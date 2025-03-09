package com.megacitycab.model;

public class Driver {
    private int driverId;
    private String fullName;
    private String licenseNumber;
    private String phoneNumber;
    private String address;

    // Constructors
    public Driver() {}

    public Driver(int driverId, String fullName, String licenseNumber, String phoneNumber, String address) {
        this.driverId = driverId;
        this.fullName = fullName;
        this.licenseNumber = licenseNumber;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }

    // Getters
    public int getDriverId() {
        return driverId;
    }

    public String getFullName() {
        return fullName;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    // Setters
    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
