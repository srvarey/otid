package org.opentransfert.otid.model;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * EntityManager hibernate.
 * 
 * @svn.info $Revision$<br>
 *           $Date$<br>
 *           $Author$
 */
public class EntityManagerFilter implements Filter {

    /** Logger */
    protected Logger log = LoggerFactory.getLogger(EntityManagerFilter.class.getName());

    private EntityManagerFactory entityManagerFactory;

    /* (non-Javadoc)
    * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
    */
    public void init(FilterConfig config) throws ServletException {
        Map<String, String> configOverrides = new HashMap<String, String>();
        // this enables to see hibernate generated SQL in the server log
        configOverrides.put("hibernate.show_sql", "true");
        this.entityManagerFactory = Persistence.createEntityManagerFactory("database", configOverrides);
    }

    /* (non-Javadoc)
    * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
    */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {

        EntityManager em = this.entityManagerFactory.createEntityManager();
        request.setAttribute("entitymanager", em);
        EntityTransaction tx = null;
        try {
            // begin the transaction
            tx = em.getTransaction();
            tx.begin();

            // continue processing
            chain.doFilter(request, response);

            // after returning, commit the transaction
            tx.commit();

        } catch (RuntimeException e) {
            // if something fails, log the error and rollback
            this.log.error("Error in the transaction", e.getMessage());
            tx.rollback();
        } finally {
            // always close the entitymanager
            em.close();
        }
    }

    /**
     * (non-Javadoc)
     * 
     * @see javax.servlet.Filter#destroy()
     */
    public void destroy() {
        this.entityManagerFactory = null;
    }

}
