var main = {
    init: function(){
        var _this = this;
        // requires jquery: when html element with id 'btn-save' gets clicked, execute ...
        $('#btn-save').on('click', function (){
            _this.save();
        });
        // .click(function()... also works
        $('#btn-update').click(function(){
            _this.update();
        });
        $('#btn-delete').click(function(){
            _this.delete();
        });
    },
    save: function(){
        var data={
            title: $('#title').val(),   // gets value from html element with id 'title'
            author: $('#author').val(),
            content: $('#content').val()
        };

        $.ajax({
            type: 'POST',
            url: '/api/v1/posts',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function(){
            alert('Post has been published!');
            window.location.href = '/';     // go to main page if successfully published
        }).fail(function(error){
            alert(JSON.stringify(error));
        });
    },
    update: function() {
        var data = {
            title: $('#title').val(),
            content: $('#content').val()
        };

        var id = $('#id').val();

        $.ajax({
            type: 'PUT',
            url: '/api/v1/posts/'+id,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function() {
            alert('Post has been updated.');
            window.location.href = '/';
        }).fail(function(error) {
            alert(JSON.stringify(error));
        });
    },
    delete: function() {
        var id = $('#id').val();

        $.ajax({
           type: 'DELETE',
           url: '/api/v1/posts/'+id,
           dataType: 'json',
           contentType: 'application/json; charset=utf-8'
        }).done(function(){
            alert('Post has been deleted.');
            window.location.href = '/';
        }).fail(function(error){
            alert(JSON.stringify(error));
        });
    }
};
// main and save functions enclosed within main to limit their scope (and avoid issues of having functions with same names)

main.init();