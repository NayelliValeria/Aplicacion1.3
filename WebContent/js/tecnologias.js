/**
 * 
 */
var aPos;
var dimmer;
var dimmerError;
var id=0;
var nombre;
var descripcion;
var aData;
var oTable;
var re = 0; /*Reload yes or no*/
$(document).ready(function(){
	
	$('#resultados').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"bPaginate": true,
		"sPaginateType":"full_numbers",
		"oLanguage":{
			"sSearch":"Buscar:",
			"sEmptyTable":"No se encontraron tecnologías registradas",
			"sLengthMenu": 'Mostrar <select>'+
		      '<option value="10">10</option>'+
		      '<option value="20">20</option>'+
		      '<option value="30">30</option>'+
		      '<option value="40">40</option>'+
			  '<option value="50">50</option>'+
			  '<option value="-1">All</option>'+
			  '</select> registros',
			"oPaginate":
			  {
				  "sNext": "Siguiente",
				  "sPrevious": "Anterior"
			  },
		"sInfoFiltered": " - resultados de  _MAX_ ",
		"sInfo": "Mostrando _END_ de _TOTAL_ resultados"
		},
		"aoColumns": [
	              { "mDataProp": "Nombre",	"sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "Descripcion", "sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "id", "sType": "string", "bVisible": false, "bSearchable": false }
                 ],
     "aSorting":[[1,"asc"]],
	 "bInfo": true,
	 "bAutoWidth": true,
	 "bLengthChange": true,
	 "bFilter": true,
	 "bSort": true
	});
	
	oTable = $('#resultados').dataTable();
	
	/* Seleccionar un registro*/
	$("#resultados tbody").delegate("tr", "click", function(){
		
		if ($(event.target.parentNode).hasClass('row_selected') ) {
			$(event.target.parentNode).removeClass('row_selected');
			id=0;
		}else 
		{
			oTable.$('tr.row_selected').removeClass('row_selected');
			$(event.target.parentNode).addClass('row_selected');
			aPos = oTable.fnGetPosition( this );
			aData = oTable.fnGetData( aPos[0] );
			id = aData[aPos].id;
	        $('#nomEdit').val(aData[aPos].Nombre);
	        $('#descEdit').val(aData[aPos].Descripcion);
		}
    });
	
	$('#editar').click(function(){
		if(id>0)
		{
			id = aData[aPos].id;
	        nombre = $('#nomEdit').val(aData[aPos].Nombre);
	        descripcion =  $('#descEdit').val(aData[aPos].Descripcion);
	        var nuevo = document.getElementById("editarTecnologia");
			dimmer = document.createElement("div");
		    dimmer.style.width =  window.innerWidth + 'px';
			dimmer.style.height = (window.innerHeight) + 'px';
			dimmer.className = 'dimmer';
			dimmer.onclick = function()
			{
				document.body.removeChild(this);
				nuevo.style.visibility = 'hidden';
			 };
			 document.body.appendChild(dimmer);
			 nuevo.style.visibility = 'visible';
		}else
			ventanaError("Por favor seleccione un registro haciendo click sobre alguna de las celdas",1);
		
		 return false;
	});
	
	$('#agregar').click( function() {
		$('#nom').val("");
		$('#desc').val("");
		var nuevo = document.getElementById("nuevaTecnologia");
		dimmer = document.createElement("div");
	    dimmer.style.width =  window.innerWidth + 'px';
		dimmer.style.height = (window.innerHeight) + 'px';
		dimmer.className = 'dimmer';
		dimmer.onclick = function()
		{
			document.body.removeChild(this);
			nuevo.style.visibility = 'hidden';
		 };
		 document.body.appendChild(dimmer);
		 nuevo.style.visibility = 'visible';
		 return false;
	});
	
	$('#guardar').click(function(){
		$.ajax({
			url:'/Aplicacion1.3/AgregarTecnologia',
			type: 'POST',
			data: 'editar='+0+
			'&nombre=' + $('#nom').val() +
			'&descripcion=' +$('#desc').val(),
			success: function(resultado) 
			{
				re=1;
				var nuevo = document.getElementById("nuevaTecnologia");
				document.body.removeChild(dimmer);
				nuevo.style.visibility = 'hidden';
				ventanaError("La tecnoloía se ha guardado exitosamente", 0);
				setTimeOut(function(){
					window.location.href='Tecnologias.jsp';
				},2000);
			},
			error:function(jqXHR, textStatus, errorThrown){
				if(jqXHR.responseText !== '')
					//ventanaError("Error:"+jqXHR.responseText, 0);
					$('#validacion').append('<p class="error">Error: ' + jqXHR.responseText +'</p>');
				else
					//ventanaError("Error:"+errorThrown, 0);
					$('#validacion').append('<p class="error">Error: ' + errorThrown +'</p>');
			}
		});//fin .ajax()
		return false;
	});
	
	$('#guardarCambios').click(function(){
		$.ajax({
			url:'/Aplicacion1.3/AgregarTecnologia',
			type: 'POST',
			data: 'editar='+1+
			'&id='+id+
			'&nombre=' + $('#nomEdit').val() +
			'&descripcion=' +$('#descEdit').val(),
			success: function(resultado) 
			{
				re=1;
				var nuevo = document.getElementById("editarTecnologia");
				document.body.removeChild(dimmer);
				nuevo.style.visibility = 'hidden';
				ventanaError("La tecnología se ha guardado exitosamente", 0);
				setTimeOut(function(){
					window.location.href='Tecnologias.jsp';
				},2000);
			},
			error:function(jqXHR, textStatus, errorThrown){
				if(jqXHR.responseText !== '')
					//ventanaError("Error:"+jqXHR.responseText, 0);
					$('#validacion').append('<p class="error">Error: ' + jqXHR.responseText +'</p>');
				else
					//ventanaError("Error:"+errorThrown, 0);
					$('#validacion').append('<p class="error">Error: ' + errorThrown +'</p>');
			}
		});//fin .ajax()
		return false;
	});
	
	$('#cancelar').click(function(){
		var nuevo = document.getElementById("nuevaTecnologia");
		document.body.removeChild(dimmer);
		nuevo.style.visibility = 'hidden';
	});
	
	$('#cancelarCambios').click(function(){
		var nuevo = document.getElementById("editarTecnologia");
		document.body.removeChild(dimmer);
		nuevo.style.visibility = 'hidden';
	});
	
	$('#eliminar').click(function(){
		if(id>0){
			var seguroEliminar = document.getElementById("seguroEliminar");
			dimmerError = document.createElement("div");
			dimmerError.style.width =  window.innerWidth + 'px';
			dimmerError.style.height = window.innerHeight + 'px';
			dimmerError.className = 'dimmerError';
			dimmerError.onclick = function()
			 {
				 document.body.removeChild(this);   
				 seguroEliminar.style.visibility = 'hidden';
			 };
			 document.body.appendChild(dimmerError);
			 seguroEliminar.style.visibility = 'visible';
			return false;
		}else
			ventanaError("Por favor seleccione un registro haciendo click sobre alguna de las celdas",1);
	});
	
	/* Dialogo de confirmación para la acción eliminar*/
	$('#siQuieroEliminar').click( function() {
		document.body.removeChild(dimmerError);   
		seguroEliminar.style.visibility = 'hidden';
		if(id>0)
		{
			$.ajax({
				url:'/Aplicacion1.3/AgregarTecnologia',
				type: 'POST',
				data: 'editar='+2+'&id=' + id,
				success: function(data,  textStatus, jqXHR) {
					re=1;
					ventanaError( jqXHR.responseText, 0);
					setTimeOut(function(){window.location.reload();},2000);
					},
				error:function(jqXHR, textStatus, errorThrown){
					if(jqXHR.responseText != '')
						ventanaError("Error: " + jqXHR.responseText, 1);
					else
						ventanaError("Error: No ha sido posible eliminar la tecnología, intente nuevamente", 1);
					}
			});//fin .ajax()
			return false;
		}
		else
			ventanaError("Por favor seleccione un registro, realizando click sobre alguna de las celdas", 1);
	} );
			
	/* Cierre de diálogo */
	$('#noQuieroEliminar').click( function() {
		window.location.reload();
	} );
	
	/*Ventanna de error*/
	function ventanaError(text , e)
	{	
		var error = document.getElementById("ventana");
		dimmerError = document.createElement("div");
		if(e == 1)
			$('#info').append('<p class="error">'+ text +'</p>');
		else
			$('#info').append('<p class="info">'+ text +'</p>');
		dimmerError.style.width =  window.innerWidth + 'px';
		dimmerError.style.height = window.innerHeight + 'px';
		dimmerError.className = 'dimmerError';			
		dimmerError.onclick = function()
		 {
			location.reload();
			error.style.visibility = 'hidden';
			document.body.removeChild(dimmerError);
			$("#info").html('');
			if(re==1)
				window.location.reload();
			re=0;
		 };
		 document.body.appendChild(dimmerError);
		 error.style.visibility = 'visible';
		return false;
	}
	
	$('#btnCerrarVentanaError').click(function(){
		var error = document.getElementById("ventana");
		error.style.visibility = 'hidden';
		document.body.removeChild(dimmerError);
		$("#info").html('');
		if(re==1)
			window.location.reload();
		red = re = 0;
	});
	
	$('.paginate_disabled_previous').click(function(){
    	resizeFrame();
    });
	
    $('.paginate_enabled_next').click(function(){
    	resizeFrame();
    });
    
});

function fnGetSelected( oTableLocal )
{
	var aReturn = new Array();
	var aTrs = oTableLocal.fnGetNodes();
	
	for ( var i=0 ; i<aTrs.length ; i++ )
	{
		if ( $(aTrs[i]).hasClass('row_selected') )
		{
			aReturn.push( aTrs[i] );
		}
	}
	return aReturn;
}