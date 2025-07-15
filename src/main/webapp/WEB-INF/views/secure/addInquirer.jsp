<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Plot Inquirer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f2f2f2;
            font-family: 'Segoe UI', sans-serif;
            padding-top: 60px;
        }

        .container {
            max-width: 600px;
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom: 25px;
            font-weight: bold;
            text-align: center;
            color: #333;
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            background-color: #ffffff;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 8px 12px;
            margin-bottom: 20px;
            font-weight: 500;
            font-size: 14px;
            color: #333;
            text-decoration: none;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: all 0.2s ease-in-out;
        }

        .back-button img {
            height: 16px;
            width: 16px;
            margin-right: 8px;
        }

        .back-button:hover {
            background-color: #f0f0f0;
            transform: scale(1.03);
            text-decoration: none;
            color: #000;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Back Button -->
    <a href="${pageContext.request.contextPath}/rees/admin/inquirer" class="back-button">
        <img src="${pageContext.request.contextPath}/images/backbutton.png" alt="Back">
        Back
    </a>

    <h2>Add Plot Inquirer</h2>

    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>

    <% if (successMessage != null) { %>
        <div class="alert alert-success"><%= successMessage %></div>
    <% } %>
    <% if (errorMessage != null) { %>
        <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <!-- React Mount Point -->
    <div id="plot-inquiry-root"></div>
</div>

<!-- React, Babel, Axios -->
<script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/babel-standalone@6.26.0/babel.min.js"></script>

<!-- React Component -->
<script type="text/babel">
function PlotInquiryForm() {
  const [projects, setProjects] = React.useState([]);
  const [sizes, setSizes] = React.useState([]);
  const [facings, setFacings] = React.useState([]);
  const [formData, setFormData] = React.useState({
    projectId: '',
    plotSize: '',
    plotFacing: '',
    name: '',
    phoneNumber: '',
    address: '',
    description: ''
  });

  React.useEffect(() => {
    axios.get("/api/projects/available")
      .then(res => {
        setProjects(res.data);
      })
      .catch(err => console.error("❌ Error loading projects:", err));
  }, []);

  const handleProjectChange = (e) => {
    const selectedProjectId = String(e.target.value).trim();
    if (!selectedProjectId) {
      setFormData(prev => ({
        ...prev, projectId: '', plotSize: '', plotFacing: ''
      }));
      setSizes([]); setFacings([]); return;
    }

    setFormData(prev => ({
      ...prev, projectId: selectedProjectId, plotSize: '', plotFacing: ''
    }));

    const url = "/api/plots/available/" + selectedProjectId;
    axios.get(url)
      .then(res => {
        const specs = res.data;
        const uniqueSizes = [...new Set(specs.map(p => p.size).filter(Boolean))];
        const uniqueFacings = [...new Set(specs.map(p => p.facing).filter(Boolean))];
        setSizes(uniqueSizes);
        setFacings(uniqueFacings);
      })
      .catch(err => {
        console.error("❌ Error loading plot specs:", err);
        setSizes([]);
        setFacings([]);
      });
  };

  const handleChange = (e) => {
    setFormData(prev => ({
      ...prev, [e.target.name]: e.target.value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    axios.post("/api/plot-inquiries", formData)
      .then(() => {
        alert("✅ Inquiry submitted!");
        setFormData({
          projectId: '', plotSize: '', plotFacing: '',
          name: '', phoneNumber: '', address: '', description: ''
        });
        setSizes([]); setFacings([]);
      })
      .catch(() => alert("❌ Submission failed."));
  };

  return (
    <form onSubmit={handleSubmit} className="mt-3">
      <div className="mb-3">
        <select name="projectId" className="form-control" value={formData.projectId} onChange={handleProjectChange} required>
          <option value="">Select Project</option>
          {projects.map(p => (
            <option key={p.project_id} value={String(p.project_id)}>{p.project_name}</option>
          ))}
        </select>
      </div>

      <div className="mb-3">
        <select name="plotSize" className="form-control" value={formData.plotSize} onChange={handleChange} required>
          <option value="">Select Plot Size</option>
          {sizes.length ? sizes.map(size => (
            <option key={size} value={size}>{size}</option>
          )) : <option disabled>No sizes available</option>}
        </select>
      </div>

      <div className="mb-3">
        <select name="plotFacing" className="form-control" value={formData.plotFacing} onChange={handleChange} required>
          <option value="">Select Plot Facing</option>
          {facings.length ? facings.map(facing => (
            <option key={facing} value={facing}>{facing}</option>
          )) : <option disabled>No facings available</option>}
        </select>
      </div>

      <div className="mb-3">
        <input type="text" name="name" className="form-control" placeholder="Name" value={formData.name} onChange={handleChange} required />
      </div>

      <div className="mb-3">
        <input type="text" name="phoneNumber" className="form-control" placeholder="Phone Number" maxLength="10" value={formData.phoneNumber} onChange={handleChange} required />
      </div>

      <div className="mb-3">
        <textarea name="address" className="form-control" placeholder="Address" value={formData.address} onChange={handleChange} required />
      </div>

      <div className="mb-3">
        <textarea name="description" className="form-control" placeholder="Description (optional)" value={formData.description} onChange={handleChange} />
      </div>

      <button type="submit" className="btn btn-primary w-100">Submit Inquiry</button>
    </form>
  );
}

ReactDOM.createRoot(document.getElementById("plot-inquiry-root")).render(<PlotInquiryForm />);
</script>

</body>
</html>
