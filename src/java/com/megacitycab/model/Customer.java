package com.megacitycab.model;

public class Customer {
    private int customerId;
    private String fullName;
    private String nic;
    private String email;
    private String phoneNumber;
    private String address;
    private String username;
    private String password;

    public Customer(int customerId, String fullName, String nic, String email, String phoneNumber, String address, String username, String password) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.nic = nic;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.username = username;
        this.password = password;
    }

    public int getCustomerId() { return customerId; }
    public String getFullName() { return fullName; }
    public String getNic() { return nic; }
    public String getEmail() { return email; }
    public String getPhoneNumber() { return phoneNumber; }
    public String getAddress() { return address; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }

    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setNic(String nic) { this.nic = nic; }
    public void setEmail(String email) { this.email = email; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public void setAddress(String address) { this.address = address; }
    public void setUsername(String username) { this.username = username; }
    public void setPassword(String password) { this.password = password; }
}
