(function($R)
{
    $R.add('plugin', 'definedlinks', {
        init: function(app)
        {
            this.app = app;
            this.opts = app.opts;

            this.component = app.component;

            // local
            this.links = [];
        },
        // messages
        onmodal: {
            open: function($modal, $form)
            {
                if (!this.opts.definedlinks) return;

                this.$modal = $modal;
                this.$form = $form;

                this._load();
            }
        },

        // private
        _load: function()
        {
            if (typeof this.opts.definedlinks === 'object')
            {
                this._build(this.opts.definedlinks);
            }
            else
            {
                $R.ajax.get({
                    url: this.opts.definedlinks,
                    success: this._build.bind(this)
                });
            }
        },
        _build: function(data)
        {
            if (data.length) {
                data.unshift({ name: this.app.lang.get('link-select') || 'Pick...', url: false });
            }
            var $selector = this.$modal.find('#redactor-defined-links');
            if ($selector.length === 0)
            {
                var $body = this.$modal.getBody();
                var $item = $R.dom('<div class="form-item" />');
                var $selector = $R.dom('<select id="redactor-defined-links" />');

                $item.append($selector);
                $body.prepend($item);
            }

            this.links = [];

            $selector.html('');
            $selector.off('change');

            var formData = this.$form.getData()
            var url = formData.link || formData.url

            for (var key in data)
            {
                if (!data.hasOwnProperty(key) || typeof data[key] !== 'object')
                {
                    continue;
                }

                this.links[key] = data[key];

                var $option = $R.dom('<option>');
                $option.val(key);
                $option.html(data[key].name);

                if (data[key].url === url) {
                    $option.attr('selected', 'selected')
                }

                $selector.append($option);
            }

            $selector.on('change', this._select.bind(this));
        },
        _select: function(e)
        {
            var formData = this.$form.getData();
            var key = $R.dom(e.target).val();
            var data = { text: '', url: '', link: '' };

            if (key !== '0')
            {
                data.text = this.links[key].name;
                data.url = this.links[key].url;
                data.link = this.links[key].url;
            }

            if (formData.text !== '')
            {
                data = { url: data.url, link: data.link };
            }

            this.$form.setData(data);
        }
    });
})(Redactor);
