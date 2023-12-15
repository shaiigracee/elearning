<?php
include "../../initialize.php";
include "../../config.php";

if (isset($_POST["add"])) {

	$p_id = $_POST['p_id'];
	$p_class_id= $_POST['p_class_id'];
    $p_course= $_POST['p_course'];
    $p_department = $_POST['p_department'];
	$p_level= $_POST['p_level'];
	$p_section= $_POST['p_section'];


if (!$conn) {
	die("Connection failed: " . mysqli_connect_error());
}

$sql = "manageClass_insert('$p_id','$p_class_id','$p_course','$p_department','$p_level','$p_section')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_class.php?inserted=1");
	exit();
} else {
	echo "Error adding class: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>

<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM class WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["add"])) {

	
	$level = $_POST["level"];
    $section = $_POST["section"];

    $sql = "CALL manageClass(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss",  $level, $section);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_class.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding class: " . mysqli_error($conn));
        echo '<script>alert("Error adding class. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Class added successfully")</script>';
}
?>

<?php
if (isset($_POST["delete"])) {

$p_id = $_POST['p_id'];

if (!$conn) {
	die("Connection failed: " . mysqli_connect_error());
}

$sql = "manageClass_delete('$p_id')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_class.php?inserted=1");
	exit();
} else {
	echo "Error deleting class: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>

<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM class WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["delete"])) {

    $p_id = $_POST['p_id'];
    


    $sql = "CALL manageClass(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_class.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error deleting class: " . mysqli_error($conn));
        echo '<script>alert("Error deleting class. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['deleted'])) {
    echo '<script>alert("Class deleted successfully")</script>';
}
?>

<?php
if (isset($_POST["edit"])) {
    $p_id = $_POST['p_id'];
	$p_class_id= $_POST['p_class_id'];
    $p_course= $_POST['p_course'];
    $p_department = $_POST['p_department'];
	$p_level= $_POST['p_level'];
	$p_section= $_POST['p_section'];

    
    
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    $sql = "manageClass_update('$p_id','$p_class_id','$p_course','$p_department','$p_level','$p_section')";
    if (mysqli_query($conn, $sql)) {
        header("location: manage_class.php?inserted=1");
        exit();
    } else {
        echo "Error updating class: " . mysqli_error($conn);
    }
    
    mysqli_close($conn);
}
?>
<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM class WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["save"])) {

	$p_department = $_POST['p_department'];
	$p_course= $_POST['p_course'];
	$p_level= $_POST['p_level'];
	$p_section= $_POST['p_section'];


    $sql = "CALL manageClass(?,?,?,?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ssss",$p_department, $p_course, $p_level, $p_section);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_class.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding class: " . mysqli_error($conn));
        echo '<script>alert("Error adding class. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Class added successfully")</script>';
}
?>


<div class="container-fluid">
	<div class="col-lg-12">
		<div id="msg" class="form-group"></div>
		<form action="" id="manage_class">
			<input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
			<div class="form-group">
				<label for="department_id" class="control-label">Department</label>
				<select name="department_id" id="department_id" class="custom-select custom-select-sm select2" required="">
					<?php 
					$department = $conn->query("SELECT * from department order by department desc");
					while($row = $department->fetch_assoc()):
					?>
						<option value="<?php echo $row['id'] ?>" <?php echo isset($department_id) && $department_id == $row['id'] ? 'selected' : '' ?>><?php echo $row['department'] ?></option>
					<?php endwhile; ?>
				</select>
			</div>
			<div class="form-group">
				<label for="course_id" class="control-label">Course</label>
				<select name="course_id" id="course_id" class="custom-select custom-select-sm select2" required="">
					<?php 
					$course = $conn->query("SELECT * from course order by course desc");
					while($row = $course->fetch_assoc()):
					?>
						<option value="<?php echo $row['id'] ?>" <?php echo isset($course_id) && $course_id == $row['id'] ? 'selected' : '' ?>><?php echo $row['course'] ?></option>
					<?php endwhile; ?>
				</select>
			</div>
			<div class="form-group">
				<label for="level" class="control-label">Level</label>
				<input type="text" name="level" id="level" required class="form-control form-control-sm" value="<?php echo isset($level) ? $level : ''; ?>">
			</div>
			<div class="form-group">
				<label for="level" class="control-label">Section</label>
				<input type="text" name="section" id="section" required class="form-control form-control-sm" value="<?php echo isset($section) ? $section : ''; ?>">
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function(){
		$('.select2').select2();
		$('#manage_class').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_class",
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
						$('#msg').html('<span class="alert alert-danger w-fluid">Class already Exist.</span>')
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