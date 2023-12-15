<?php
include "../../initialize.php";
include "../../config.php";
// <!--update-->
if (isset($_POST["edit"])) {
    $p_id = $_POST['p_id'];
	$p_AC_id = $_POST['p_AC_id'];
    $p_sy = $_POST['p_sy'];
    $p_status = $_POST['p_status'];
    
    
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    $sql = "manageAcademic_update('$p_id','$p_sy','$p_status','$p_AC_id')";
    if (mysqli_query($conn, $sql)) {
        header("location: manage_sy.php?inserted=1");
        exit();
    } else {
        echo "Error updating academic year: " . mysqli_error($conn);
    }
    
    mysqli_close($conn);
}
?>

<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM academic_year WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["save"])) {

    $sy = $_POST["sy"];
    $status = $_POST["status"];


    $sql = "CALL manageSy(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $sy, $status);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_sy.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding academic year: " . mysqli_error($conn));
        echo '<script>alert("Error adding academic year. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Academic Year added successfully")</script>';
}
?>


<!--insert-->
<?php
if (isset($_POST["add"])) {

	$p_id = $_POST['p_id'];
	$p_AC_id = $_POST['p_AC_id'];
    $p_sy = $_POST['p_sy'];
    $p_status = $_POST['p_status'];

if (!$conn) {
	die("Connection failed: " . mysqli_connect_error());
}

$sql = "manageAcademic_insert('$p_id','$p_AC_id','$p_sy','$p_status')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_sy.php?inserted=1");
	exit();
} else {
	echo "Error adding academic year: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>

<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM academic_year WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["add"])) {

	$p_id = $_POST['p_id'];
	$p_AC_id = $_POST['p_AC_id'];
    $p_sy = $_POST['p_sy'];
    $p_status = $_POST['p_status'];


    $sql = "CALL manageSy(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $sy, $status);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_sy.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding academic year: " . mysqli_error($conn));
        echo '<script>alert("Error adding academic year. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Academic Year added successfully")</script>';
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

$sql = "manageAcademic_delete('$p_id')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_sy.php?inserted=1");
	exit();
} else {
	echo "Error deleting academic year: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>

<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM academic_year WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["delete"])) {

    $p_id = $_POST['p_id'];
    


    $sql = "CALL manageSy(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_sy.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error deleting academic year: " . mysqli_error($conn));
        echo '<script>alert("Error deleting academic. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['deleted'])) {
    echo '<script>alert("Academic Year deleted successfully")</script>';
}
?>
<!--delete-->



<div class="container-fluid">
	<div class="col-lg-12">
		<div id="msg" class="form-group"></div>
		<form action="" id="manage_sy">
			<input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
			<div class="form-group">
				<label for="sy" class="control-label">School Year</label>
				<input type="text" name="sy" id="sy" required class="form-control form-control-sm" value="<?php echo isset($sy) ? $sy : ''; ?>">
			</div>
			<div class="form-group">
				<label for="status" class="control-label">Status</label>
				<select name="status" id="status" class="form-control form-control-sm" required="">
					<option value="1" <?php echo isset($status) && $status == 1 ? 'selected' : '' ?>>Active</option>
					<option value="0" <?php echo isset($status) && $status == 0 ? 'selected' : '' ?>>Inactive</option>
				</select>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function(){
		$('#manage_sy').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_academic",
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
						$('#msg').html('<span class="alert alert-danger w-fluid">School Year already Exist.</span>')
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