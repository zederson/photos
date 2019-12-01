export class PhotosClient {

  listNames(callback) {
    var that = this;
    let url = '/api/names';

    $.ajax({
      url: url,
      headers: { 'Content-Type':'application/json' },
      method: 'GET',
      dataType: 'json',
      statusCode: {
        200: (response) => { callback(response) }
      }
    });
  }
}
