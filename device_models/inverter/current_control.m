function f = current_control(iod, vod, ioq, voq, icvd, icvq, phi_d, phi_q, xi_d, xi_q, qm, delta_theta_vsm, delta_w_vsm, params)

 %get parameters
 
    kpv = params.kpv; % Voltage controller gain
    kiv = params.kiv; % Voltage controller gain
    wb = params.wb; 
    wg = params.wg; 
    cf = params.cf; % Filter capacitance in p.u.
    kffi = params.kffi;
    lg = params.lg; % Grid inductance in p.u.
    rg = params.rg; % Grid resistance in p.u.    
    wad = params.wad; % Active damping filte
    rv = params.rv;
    lv = params.lv;
    kq = params.kq;
    q_ref = params.q_ref;
    v_ref = params.v_ref;
    vg = params.vg;
f = [
    
     %d(gamma_d)/dt = 
      -kpv*vod-...
      cf*wg*voq-...
      icvd+...
      (kffi-kpv*rv)*iod+...
      kpv*lv*wg*ioq+...
      kiv*xi_d-...
      kpv*kq*qm+... %changed sign of kpv*kq*qm to -
      kpv*lv*ioq*delta_w_vsm-...
      cf*voq*delta_w_vsm+... *changed sign of cf*voq*delta_w_vsm to -
      kpv*kq*q_ref+... *changed sign of kpv*kq*q_ref to +
      kpv*v_ref; 
      
      %d(gamma,q)/dt = 
      cf*wg*vod-...
      kpv*voq-...
      icvq-...
      kpv*lv*wg*iod+...
      (kffi-kpv*rv)*ioq+...
      kiv*xi_q-...
      kpv*lv*iod*delta_w_vsm+...
      cf*vod*delta_w_vsm; 
      
      %d(io,d)/dt= 
      wb*vod/lg-...
      wb*rg*iod/lg+...
      wb*wg*ioq+...
      wb*vg*cos(delta_theta_vsm)/lg; 
      
      %d(io,q)/dt = 
      wb*voq/lg-...
      wb*wg*iod-...
      wb*rg*ioq/lg+...
      wb*vg*sin(delta_theta_vsm)/lg; 

      %d(phi_d)/dt= 
      wad*vod-wad*phi_d; 
      
      %d(phi_q)/dt =
      wad*voq-wad*phi_q; 


      ];
      
end

