<?php
include "../../initialize.php";
include "../../config.php";

if (isset($_POST["edit"])) {

    $p_id = $_POST['p_id'];
    $p_DepartmentID = $_POST['p_DepartmentID'];
    $p_departmentName = $_POST['p_departmentName'];
    $p_departmentDescription = $_POST['p_departmentDescription'];
    
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    $sql = "manageDepartment_update('$p_id','$p_DepartmentID','$p_departmentName','$p_departmentDescription')";
    if (mysqli_query($conn, $sql)) {
        header("location: manage_department.php?inserted=1");
        exit();
    } else {
        echo "Error updating department: " . mysqli_error($conn);
    }
    
    mysqli_close($conn);
}
?>
<?php

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM department WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["save"])) {

    $department = $_POST["department"];
    $description = $_POST["description"];


    $sql = "CALL manageDepartment(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $department, $description);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_department.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding department: " . mysqli_error($conn));
        echo '<script>alert("Error adding course. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Department added successfully")</script>';
}
?>




<!--insert-->
<?php
if (isset($_POST["add"])) {

$p_id = $_POST['p_id'];
$p_departmentID = $_POST['p_departmentID'];
$p_departmentName = $_POST['p_departmentName'];
$p_departmentDescription = $_POST['p_departmentDescription'];

if (!$conn) {
	die("Connection failed: " . mysqli_connect_error());
}

$sql = "manageDepartment_insert('$p_id','$p_departmentID','$p_departmentName','$p_departmentDescription')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_department.php?inserted=1");
	exit();
} else {
	echo "Error adding department: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>
<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM department WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["add"])) {

    $p_id = $_POST['p_id'];
    $p_departmentID= $_POST['p_departmentID'];
    $p_departmentName = $_POST['p_departmentName'];
    $p_departmentDescription = $_POST['p_departmentDescription'];



    $sql = "CALL manageDepartment(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $department, $description);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_department.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding department: " . mysqli_error($conn));
        echo '<script>alert("Error adding department. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Department added successfully")</script>';
}
?>
<!--insert-->



<!--delete-->
<?php
if (isset($_POST["delete"])) {

$p_id = $_POST['p_id'];

if (!$conn) {
	die("Connection failed: " . mysqli_connect_error());
}

$sql = "manageDepartment_delete('$p_id')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_department.php?inserted=1");
	exit();
} else {
	echo "Error deleting department: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>

<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM department WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["delete"])) {

    $p_id = $_POST['p_id'];
    


    $sql = "CALL manageDepartment(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_department.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error deleting department: " . mysqli_error($conn));
        echo '<script>alert("Error deleting department. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['deleted'])) {
    echo '<script>alert("Department deleted successfully")</script>';
}
?>
<!--delete-->



<div class="container-fluid">
	<div class="col-lg-12">
		<div id="msg" class="form-group"></div>
		<form action="" id="manage_department">
			<input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
			<div class="form-group">
				<label for="department" class="control-label">Department</label>
				<input type="text" name="department" id="department" required class="form-control form-control-sm" value="<?php echo isset($department) ? $department : ''; ?>">
			</div>
			<div class="form-group">
				<label for="description" class="control-label">Description</label>
				<textarea name="description" id="description" cols="30" rows="3" class="form-control" required=""><?php echo isset($description) ? $description : ''; ?></textarea>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function(){
		$('#manage_department').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_department",
				method:"POST",
				data:$(this).serialize(),
				error:err=>{
					console.log(err)
					alert_toast("An error occured.","error")
					end_loader();
				},
				success:function(resp){
					if(resp == 1){
						location.reload()
					}else if(resp ==2){
						$('#msg').html('<span class="alert alert-danger w-fluid">Department already Exist.</span>')
						end_loader();
					}else{
						console.log(resp)
						end_loader();
					}
				}
			})

		})
	})
</script>