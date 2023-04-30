<script>
$.getJSON("../feeds/conference.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.id="conference-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("conference");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#conference-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 5,
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[2, 'desc']],
     	columns: [
        	{ data: 'title', orderable: true },
        	{ data: 'correspondingauthor', orderable: true },
        	{ data: 'pub_date', width: "10%", visible: true, orderable: true},
        	{ data: 'edit', render: function ( data, type, row ) {return '<a href="manualEdit.jsp?title='+row.title+'&author='+row.correspondingauthor+'&date='+row.pub_date+'"><i class="fas fa-edit fa-lg text-success"></i></a>';}},
        	{ data: 'delete', render: function ( data, type, row ) {return '<a href="manualDelete.jsp?title='+row.title+'&author='+row.correspondingauthor+'&date='+row.pub_date+'"><i class="fas fa-times-circle fa-lg text-danger"></i></a>';}}
    	]
	} );

	
});
</script>
