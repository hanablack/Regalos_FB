$(document).ready(function(){
   
    $('#loginUsuario').on('click',function(){
        loginUsuario();
    });
})


function loginUsuario() {
    var loginUsuario = $('#usuarioUsuario').val();
    var passUsuario = $('#passUsuario').val();

    $.ajax({
        url: './includes/loginUsuario.php',
        method: 'POST',
        data: {
            loginUsuario:loginUsuario,
            passUsuario:passUsuario
        },
        success: function(data) {
            $('#messageUsuario').html(data);

            if(data.indexOf('Redirecting') >= 0) {
                window.location = 'usuario/';
            }
        }
    })
}