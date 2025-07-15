package com.rees.model;

import java.sql.Timestamp;
import java.util.List;

public class SalesSummary {

	 public String getPlotNumber() {
		return plotNumber;
	}
	public void setPlotNumber(String plotNumber) {
		this.plotNumber = plotNumber;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public double getSellingPrice() {
		return sellingPrice;
	}
	public void setSellingPrice(double sellingPrice) {
		this.sellingPrice = sellingPrice;
	}
	public double getTotalPaid() {
		return totalPaid;
	}
	public void setTotalPaid(double totalPaid) {
		this.totalPaid = totalPaid;
	}
	public double getRemaining() {
		return remaining;
	}
	public void setRemaining(double remaining) {
		this.remaining = remaining;
	}
	public String getFirstPaymentMode() {
		return firstPaymentMode;
	}
	public void setFirstPaymentMode(String firstPaymentMode) {
		this.firstPaymentMode = firstPaymentMode;
	}
	public Timestamp getFirstPaymentDate() {
		return firstPaymentDate;
	}
	public void setFirstPaymentDate(Timestamp firstPaymentDate) {
		this.firstPaymentDate = firstPaymentDate;
	}
	public List<String> getPaymentModes() {
		return paymentModes;
	}
	public void setPaymentModes(List<String> paymentModes) {
		this.paymentModes = paymentModes;
	}
	public List<Timestamp> getPaymentDates() {
		return paymentDates;
	}
	public void setPaymentDates(List<Timestamp> paymentDates) {
		this.paymentDates = paymentDates;
		
	}
	public List<Double> getAllAmounts() {
	    return allAmounts;
	}

	public void setAllAmounts(List<Double> allAmounts) {
	    this.allAmounts = allAmounts;
	}

	public List<String> getAllModes() {
	    return allModes;
	}

	public void setAllModes(List<String> allModes) {
	    this.allModes = allModes;
	}

	public List<Timestamp> getAllDates() {
	    return allDates;
	}

	public void setAllDates(List<Timestamp> allDates) {
	    this.allDates = allDates;
	}
	private String plotNumber;
	    private String projectName;
	    private double sellingPrice;
	    private double totalPaid;
	    private double remaining;
	    private String firstPaymentMode;
	    private Timestamp firstPaymentDate;
	    private List<String> paymentModes;
	    private List<Timestamp> paymentDates;
	    private List<Double> allAmounts;
	    private List<String> allModes;
	    private List<Timestamp> allDates;

    
}
