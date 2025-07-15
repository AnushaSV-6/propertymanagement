<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Plot Inquirer List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
        }

        .table-container {
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<body>
	

<div class="container table-container">

    <h2>📋 Plot Inquirer List</h2>
    <div id="inquirer-list-root"></div>
</div>

<!-- Scripts -->
<script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/babel-standalone@6.26.0/babel.min.js"></script>

<!-- React Component -->
<script type="text/babel">
function InquirerList() {
  const [inquirers, setInquirers] = React.useState([]);

  React.useEffect(() => {
    axios.get("/api/plot-inquiries")
      .then(res => {
        setInquirers(res.data);
        console.log("✅ Fetched inquirers:", res.data);
      })
      .catch(err => console.error("❌ Error fetching inquirers:", err));
  }, []);

  return (
    <div className="table-responsive">
      {inquirers.length === 0 ? (
        <div className="alert alert-info">No inquirers found.</div>
      ) : (
        <table className="table table-bordered table-hover align-middle text-center">
          <thead className="table-dark">
            <tr>
              <th>#</th>
              <th>Name</th>
              <th>Phone</th>
              <th>Address</th>
              
              <th>Plot Size</th>
              <th>Facing</th>
              <th>Description</th>
             
            </tr>
          </thead>
          <tbody>
            {inquirers.map((inq, idx) => (
              <tr key={inq.id || idx}>
                <td>{idx + 1}</td>
                <td>{inq.name}</td>
                <td>{inq.phoneNumber}</td>
                <td>{inq.address}</td>
				
                <td>{inq.plotSize}</td>
                <td>{inq.plotFacing}</td>
                <td>{inq.description || '-'}</td>
                
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

ReactDOM.createRoot(document.getElementById("inquirer-list-root"))
  .render(<InquirerList />);
</script>

</body>
</html>
