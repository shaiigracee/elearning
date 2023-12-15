<?php
include "../../initialize.php";
include "../../config.php";
// <!--update-->
if (isset($_POST["edit"])) {

    $p_id = $_POST['p_id'];
    $p_courseID = $_POST['p_courseID'];
    $p_courseName = $_POST['p_courseName'];
    $p_courseDescription = $_POST['p_courseDescription'];
    
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    $sql = "manageCourse_update('$p_id','$p_courseID','$p_courseName','$p_courseDescription')";
    if (mysqli_query($conn, $sql)) {
        header("location: manage_course.php?inserted=1");
        exit();
    } else {
        echo "Error updating course: " . mysqli_error($conn);
    }
    
    mysqli_close($conn);
}

?>
<?php


if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM course WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["save"])) {

    $course = $_POST["course"];
    $description = $_POST["description"];


    $sql = "CALL manageCourse(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $course, $description);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_course.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding course: " . mysqli_error($conn));
        echo '<script>alert("Error adding course. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Course added successfully")</script>';
}
?>
<!--update-->


<!--insert-->
<?php
if (isset($_POST["add"])) {

$p_id = $_POST['p_id'];
$p_courseID = $_POST['p_courseID'];
$p_courseName = $_POST['p_courseName'];
$p_courseDescription = $_POST['p_courseDescription'];

if (!$conn) {
	die("Connection failed: " . mysqli_connect_error());
}

$sql = "manageCourse_insert('$p_id','$p_courseID','$p_courseName','$p_courseDescription')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_course.php?inserted=1");
	exit();
} else {
	echo "Error adding course: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>
<?php


if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM course WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["add"])) {

    $p_id = $_POST['p_id'];
    $p_courseID = $_POST['p_courseID'];
    $p_courseName = $_POST['p_courseName'];
    $p_courseDescription = $_POST['p_courseDescription'];



    $sql = "CALL manageCourse(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $course, $description);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_course.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding course: " . mysqli_error($conn));
        echo '<script>alert("Error adding course. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Course added successfully")</script>';
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

$sql = "manageCourse_delete('$p_id')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_course.php?inserted=1");
	exit();
} else {
	echo "Error deleting course: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>

<?php


if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM course WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["delete"])) {

    $p_id = $_POST['p_id'];
    


    $sql = "CALL manageCourse(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_course.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error deleting course: " . mysqli_error($conn));
        echo '<script>alert("Error deleting course. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['deleted'])) {
    echo '<script>alert("Course deleted successfully")</script>';
}
?>
<!--delete-->

<div class="container-fluid">
    <div class="col-lg-12">
        <div id="msg" class="form-group"></div>
        <form action="" method="post" id="manage_course" onsubmit="return validateForm()">
            <input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
            <div class="form-group">
                <label for="course" class="control-label">Course</label>
                <input type="text" name="course" id="course" required class="form-control form-control-sm" value="<?php echo isset($course) ? $course : ''; ?>">
            </div>
            <div class="form-group">
                <label for="description" class="control-label">Description</label>
                <textarea name="description" id="description" cols="30" rows="3" class="form-control" required=""><?php echo isset($description) ? $description : ''; ?></textarea>
            </div>
        </form>
    </div>
</div>

<script>
    function validateForm() {

        return true; 
    }
</script>






<script>
	$(document).ready(function(){
		$('#manage_course').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_course",
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
						$('#msg').html('<span class="alert alert-danger w-fluid">Course already Exist.</span>')
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