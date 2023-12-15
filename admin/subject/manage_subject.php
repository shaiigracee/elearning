<?php
include "../../initialize.php";
include "../../config.php";
// <!--update-->
if (isset($_POST["edit"])) {

    $p_id = $_POST['p_id'];
    $p_subjectID = $_POST['p_subjectID'];
    $p_subject_code = $_POST['p_subject_code'];
    $p_subjectDescription = $_POST['p_subjectDescription'];
    
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    $sql = "manageSubject_update('$p_id','$p_subjectID','$p_subject_code','$p_subjectDescription')";
    if (mysqli_query($conn, $sql)) {
        header("location: manage_subject.php?inserted=1");
        exit();
    } else {
        echo "Error updating subject: " . mysqli_error($conn);
    }
    
    mysqli_close($conn);
}
?>


<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM subjects WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["save"])) {

    $subject_code = $_POST["subject_code"];
    $description = $_POST["description"];


    $sql = "CALL manageSubject(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $subject_code, $description);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_subject.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding subject: " . mysqli_error($conn));
        echo '<script>alert("Error adding subject. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Subject added successfully")</script>';
}
?>
<!--update-->

<!--insert-->
<?php
if (isset($_POST["add"])) {

$p_id = $_POST['p_id'];
$p_subjectID = $_POST['p_subjectID'];
$p_subject_code = $_POST['p_subject_code'];
$p_subjectDescription = $_POST['p_subjectDescription'];

if (!$conn) {
	die("Connection failed: " . mysqli_connect_error());
}

$sql = "manageSubject_insert('$p_id','$p_courseID','$p_subject_code','$p_subjectDescription')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_subject.php?inserted=1");
	exit();
} else {
	echo "Error adding subject: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>
<?php


if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM subjects WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["add"])) {

    $p_id = $_POST['p_id'];
    $p_subjectID = $_POST['p_subjectID'];
    $p_subject_code = $_POST['p_subject_code'];
    $p_subjectDescription = $_POST['p_subjectDescription'];



    $sql = "CALL manageSubject(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ss", $subject_code, $description);


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_subject.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error adding subject: " . mysqli_error($conn));
        echo '<script>alert("Error adding course. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['inserted'])) {
    echo '<script>alert("Subject added successfully")</script>';
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

$sql = "manageSubject_delete('$p_id')";
if (mysqli_query($conn, $sql)) {
	header("location: manage_subject.php?inserted=1");
	exit();
} else {
	echo "Error deleting subject: " . mysqli_error($conn);
}

mysqli_close($conn);
}
?>

<?php
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $qry = $conn->query("SELECT * FROM subjects WHERE id = $id");
    $data = $qry->fetch_array();
    foreach ($data as $key => $value) {
        $$key = $value;
    }
}

if (isset($_POST["delete"])) {

    $p_id = $_POST['p_id'];
    


    $sql = "CALL manageSubject(?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    


    if (mysqli_stmt_execute($stmt)) {
        header("location: manage_subject.php?inserted=1");
        exit(); 
    } else {
        
        error_log("Error deleting subject: " . mysqli_error($conn));
        echo '<script>alert("Error deleting subject. Please try again.")</script>';
    }


    mysqli_stmt_close($stmt);
}

if (isset($_GET['deleted'])) {
    echo '<script>alert("SUbject deleted successfully")</script>';
}
?>
<!--delete-->


<div class="container-fluid">
	<div class="col-lg-12">
		<div id="msg" class="form-group"></div>
		<form action="" id="manage_subject">
			<input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
			<div class="form-group">
				<label for="subject_code" class="control-label">Subject Code</label>
				<input type="text" name="subject_code" id="subject_code" required class="form-control form-control-sm" value="<?php echo isset($subject_code) ? $subject_code : ''; ?>">
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
		$('#manage_subject').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_subject",
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
						$('#msg').html('<span class="alert alert-danger w-fluid">subject already Exist.</span>')
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