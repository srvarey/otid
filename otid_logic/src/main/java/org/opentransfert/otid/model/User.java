package org.opentransfert.otid.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * User of the application.
 * 
 * @svn.info $Revision$<br>
 *           $Date$<br>
 *           $Author$
 */
@Entity
@Table(name = "otid_user")
public class User implements Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 5064480740157852746L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    private String login;
    private String password;
    private Date creation;

    @Column(name = "last_login")
    private Date lastLogin;

    /**
     * Gets the id.
     * 
     * @return the id
     */
    public Integer getId() {
        return this.id;
    }

    /**
     * Sets the id.
     * 
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * Gets the login.
     * 
     * @return the login
     */
    public String getLogin() {
        return this.login;
    }

    /**
     * Sets the login.
     * 
     * @param login the login to set
     */
    public void setLogin(String login) {
        this.login = login;
    }

    /**
     * Gets the password.
     * 
     * @return the password
     */
    public String getPassword() {
        return this.password;
    }

    /**
     * Sets the password.
     * 
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Gets the creation.
     * 
     * @return the creation
     */
    public Date getCreation() {
        return this.creation;
    }

    /**
     * Sets the creation.
     * 
     * @param creation the creation to set
     */
    public void setCreation(Date creation) {
        this.creation = creation;
    }

    /**
     * Gets the lastLogin.
     * 
     * @return the lastLogin
     */
    public Date getLastLogin() {
        return this.lastLogin;
    }

    /**
     * Sets the lastLogin.
     * 
     * @param lastLogin the lastLogin to set
     */
    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

}
