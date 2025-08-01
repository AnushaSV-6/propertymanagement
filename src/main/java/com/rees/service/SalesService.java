
package com.rees.service;

import com.rees.dao.SalesDAO;
import com.rees.model.Customer;
import com.rees.model.Plot;
import com.rees.model.Project;
import com.rees.model.Sales;
import com.rees.model.SalesPayment;
import com.rees.model.SalesSummary;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@Service
public class SalesService {

	@Autowired
	private SalesDAO salesDAO;

	// Used in both Add & Update flows
	public Customer getCustomerByPhone(String phone) {
		return salesDAO.findCustomerByPhone(phone);
	}

	public Customer getCustomerById(int customerId) {
		return salesDAO.findCustomerById(customerId);
	}

	public Project getProjectById(int id) {
		return salesDAO.getProjectById(id);
	}

	public Plot getPlotById(int id) {
		return salesDAO.getPlotById(id);
	}

	public SalesSummary getSalesSummary(int customerId, int projectId, int plotId) {
		return salesDAO.getSalesSummary(customerId, projectId, plotId);
	}

	public boolean saleExists(int customerId, int projectId, int plotId) throws SQLException {
		return salesDAO.saleExists(customerId, projectId, plotId);
	}

	public Sales getSale(int customerId, int projectId, int plotId) throws SQLException {
		return salesDAO.getSale(customerId, projectId, plotId);
	}

	public Sales getSaleByCustomerProjectPlot(int customerId, int projectId, int plotId) {
		return salesDAO.findByCustomerProjectPlot(customerId, projectId, plotId);
	}

	public void saveSale(Sales sale, int customerId, int projectId, int plotId) throws Exception {
		salesDAO.insertSale(sale, customerId, projectId, plotId);
		salesDAO.updatePlotStatus(plotId, customerId);
	}

	public void insertSalePayment(int saleId, double amount, Date date, String mop, String desc) throws SQLException {
		salesDAO.insertSalePayment(saleId, amount, date, mop, desc);
	}

	public List<Project> getAllProjects() {
		return salesDAO.getAllProjects();
	}

	public List<Project> getProjectsWithSales(int customerId) {
		return salesDAO.getProjectsWithSales(customerId);
	}

	public List<Plot> getPlotsWithSales(int customerId, int projectId) {
		return salesDAO.getPlotsWithSales(customerId, projectId);
	}

	public List<Project> getAvailableProjects() throws SQLException {
		return salesDAO.getAvailableProjects();
	}

	public List<Plot> getAvailablePlotsByProject(int projectId) throws SQLException {
		return salesDAO.getAvailablePlotsByProject(projectId);
	}
}
