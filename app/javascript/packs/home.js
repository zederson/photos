import Vue from 'vue/dist/vue.esm'

import { PhotosClient} from '../services/photos_client'

document.addEventListener('DOMContentLoaded', () => {
  const service = new PhotosClient();

  const people = new Vue({
    el: '#home_app',
    functional: true,
    components: {
    },
    data: {
      names: [],
      criteria: {
        location: {
          party: false,
          church: false,
          box: false
        },
        names: []
      }
    },
    computed: {
    },
    methods: {
    },
    created: function() {
      let that = this;
      service.listNames((names) => { that.names = names })
    }
  });
});
