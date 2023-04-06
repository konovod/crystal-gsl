require "./libgsl.cr"

module GSL
  module SpecFunctions
    private macro def_function(fn)
      def {{fn.id[0..0].downcase}}{{fn.id[1..]}}(x : Float64) : Float64
        code = LibGSL.gsl_sf_{{fn}}_e(x, out result)
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_sf_{{fn}}_e")
        result.val
      end
    end

    enum Precision
      Double = 0
      Single = 1
      Approx = 2
    end

    private macro def_function_with_mode(fn)
    def {{fn}}(x : Float64, precision : Precision = Precision::Double) : Float64
      code = LibGSL.gsl_sf_{{fn}}_e(x, LibGSL::Gsl_mode_t.new(precision), out result)
      check_return_code(LibGSL::Code.new(code), "gsl_sf_{{fn}}_e")
      result.val
    end

  end

    # fun gsl_sf_result_smash_e(re : Gsl_sf_result_e10*, r : Gsl_sf_result*) : LibC::Int
    def_function_with_mode(airy_Ai)
    def_function_with_mode(airy_Bi)
    def_function_with_mode(airy_Ai_scaled)
    def_function_with_mode(airy_Bi_scaled)
    def_function_with_mode(airy_Ai_deriv)
    def_function_with_mode(airy_Bi_deriv)
    def_function_with_mode(airy_Ai_deriv_scaled)
    def_function_with_mode(airy_Bi_deriv_scaled)
    # fun gsl_sf_airy_zero_Ai_e(s : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_airy_zero_Bi_e(s : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_airy_zero_Ai_deriv_e(s : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_airy_zero_Bi_deriv_e(s : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    def_function(bessel_J0)
    def_function(bessel_J1)
    # fun gsl_sf_bessel_Jn_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_Jn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_Y0)
    def_function(bessel_Y1)
    # fun gsl_sf_bessel_Yn_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_Yn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_I0)
    def_function(bessel_I1)
    # fun gsl_sf_bessel_In_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_In_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_I0_scaled)
    def_function(bessel_I1_scaled)
    # fun gsl_sf_bessel_In_scaled_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_In_scaled_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_K0)
    def_function(bessel_K1)
    # fun gsl_sf_bessel_Kn_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_Kn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_K0_scaled)
    def_function(bessel_K1_scaled)
    # fun gsl_sf_bessel_Kn_scaled_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_Kn_scaled_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_j0)
    def_function(bessel_j1)
    def_function(bessel_j2)
    # fun gsl_sf_bessel_jl_e(l : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_jl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_bessel_jl_steed_array(lmax : LibC::Int, x : LibC::Double, jl_x_array : LibC::Double*) : LibC::Int
    def_function(bessel_y0)
    def_function(bessel_y1)
    def_function(bessel_y2)
    # fun gsl_sf_bessel_yl_e(l : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_yl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_i0_scaled)
    def_function(bessel_i1_scaled)
    def_function(bessel_i2_scaled)
    # fun gsl_sf_bessel_il_scaled_e(l : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_il_scaled_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_k0_scaled)
    def_function(bessel_k1_scaled)
    def_function(bessel_k2_scaled)
    # fun gsl_sf_bessel_kl_scaled_e(l : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_kl_scaled_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_bessel_Jnu_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_Ynu_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_sequence_Jnu_e(nu : LibC::Double, mode : Gsl_mode_t, size : LibC::SizeT, v : LibC::Double*) : LibC::Int
    # fun gsl_sf_bessel_Inu_scaled_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_Inu_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_Knu_scaled_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_Knu_scaled_e10_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    # fun gsl_sf_bessel_Knu_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_lnKnu_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_zero_J0_e(s : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_zero_J1_e(s : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_bessel_zero_Jnu_e(nu : LibC::Double, s : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    def_function(clausen)
    # fun gsl_sf_hydrogenicR_1_e(z : LibC::Double, r : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hydrogenicR_e(n : LibC::Int, l : LibC::Int, z : LibC::Double, r : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_coulomb_wave_FG_e(eta : LibC::Double, x : LibC::Double, lam_f : LibC::Double, k_lam_g : LibC::Int, f : Gsl_sf_result*, fp : Gsl_sf_result*, g : Gsl_sf_result*, gp : Gsl_sf_result*, exp_f : LibC::Double*, exp_g : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_wave_F_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, f_exponent : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_wave_FG_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, gc_array : LibC::Double*, f_exponent : LibC::Double*, g_exponent : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_wave_FGp_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, fcp_array : LibC::Double*, gc_array : LibC::Double*, gcp_array : LibC::Double*, f_exponent : LibC::Double*, g_exponent : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_wave_sphF_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, f_exponent : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_CL_e(l : LibC::Double, eta : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_coulomb_CL_array(lmin : LibC::Double, kmax : LibC::Int, eta : LibC::Double, cl : LibC::Double*) : LibC::Int
    # fun gsl_sf_coupling_3j_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_ma : LibC::Int, two_mb : LibC::Int, two_mc : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_coupling_6j_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_coupling_RacahW_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_coupling_9j_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, two_jg : LibC::Int, two_jh : LibC::Int, two_ji : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_coupling_6j_INCORRECT_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    def_function(dawson)
    def_function(debye_1)
    def_function(debye_2)
    def_function(debye_3)
    def_function(debye_4)
    def_function(debye_5)
    def_function(debye_6)
    def_function(dilog)
    # fun gsl_sf_complex_dilog_xy_e(x : LibC::Double, y : LibC::Double, result_re : Gsl_sf_result*, result_im : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_complex_dilog_e(r : LibC::Double, theta : LibC::Double, result_re : Gsl_sf_result*, result_im : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_complex_spence_xy_e(x : LibC::Double, y : LibC::Double, real_sp : Gsl_sf_result*, imag_sp : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_multiply_e(x : LibC::Double, y : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_multiply_err_e(x : LibC::Double, dx : LibC::Double, y : LibC::Double, dy : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_Kcomp_e(k : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_Ecomp_e(k : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_Pcomp_e(k : LibC::Double, n : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_Dcomp_e(k : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_F_e(phi : LibC::Double, k : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_E_e(phi : LibC::Double, k : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_P_e(phi : LibC::Double, k : LibC::Double, n : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_D_e(phi : LibC::Double, k : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_RC_e(x : LibC::Double, y : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_RD_e(x : LibC::Double, y : LibC::Double, z : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_RF_e(x : LibC::Double, y : LibC::Double, z : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_ellint_RJ_e(x : LibC::Double, y : LibC::Double, z : LibC::Double, p : LibC::Double, mode : Gsl_mode_t, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_elljac_e(u : LibC::Double, m : LibC::Double, sn : LibC::Double*, cn : LibC::Double*, dn : LibC::Double*) : LibC::Int
    def_function(erfc)
    def_function(log_erfc)
    def_function(erf)
    def_function(erf_Z)
    def_function(erf_Q)
    def_function(hazard)
    def_function(exp)
    # fun gsl_sf_exp_e10_e(x : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    # fun gsl_sf_exp_mult_e(x : LibC::Double, y : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_exp_mult_e10_e(x : LibC::Double, y : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function(expm1)
    def_function(exprel)
    def_function(exprel_2)
    # fun gsl_sf_exprel_n_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_exprel_n_CF_e(n : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_exp_err_e(x : LibC::Double, dx : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_exp_err_e10_e(x : LibC::Double, dx : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    # fun gsl_sf_exp_mult_err_e(x : LibC::Double, dx : LibC::Double, y : LibC::Double, dy : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_exp_mult_err_e10_e(x : LibC::Double, dx : LibC::Double, y : LibC::Double, dy : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function(expint_E1)
    def_function(expint_E2)
    # fun gsl_sf_expint_En_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    def_function(expint_E1_scaled)
    def_function(expint_E2_scaled)
    # fun gsl_sf_expint_En_scaled_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    def_function(expint_Ei)
    def_function(expint_Ei_scaled)
    def_function(Shi)
    def_function(Chi)
    def_function(expint_3)
    def_function(Si)
    def_function(Ci)
    def_function(atanint)
    def_function(fermi_dirac_m1)
    def_function(fermi_dirac_0)
    def_function(fermi_dirac_1)
    def_function(fermi_dirac_2)
    # fun gsl_sf_fermi_dirac_int_e(j : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    def_function(fermi_dirac_mhalf)
    def_function(fermi_dirac_half)
    def_function(fermi_dirac_3half)
    # fun gsl_sf_fermi_dirac_inc_0_e(x : LibC::Double, b : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    def_function(lngamma)
    # fun gsl_sf_lngamma_sgn_e(x : LibC::Double, result_lg : Gsl_sf_result*, sgn : LibC::Double*) : LibC::Int
    def_function(gamma)
    def_function(gammastar)
    def_function(gammainv)
    # fun gsl_sf_lngamma_complex_e(zr : LibC::Double, zi : LibC::Double, lnr : Gsl_sf_result*, arg : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_taylorcoeff_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_fact_e(n : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_doublefact_e(n : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_lnfact_e(n : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_lndoublefact_e(n : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_lnchoose_e(n : LibC::UInt, m : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_choose_e(n : LibC::UInt, m : LibC::UInt, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_lnpoch_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_lnpoch_sgn_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*, sgn : LibC::Double*) : LibC::Int
    # fun gsl_sf_poch_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_pochrel_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_gamma_inc_Q_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_gamma_inc_P_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_gamma_inc_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_lnbeta_e(a : LibC::Double, b : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_lnbeta_sgn_e(x : LibC::Double, y : LibC::Double, result : Gsl_sf_result*, sgn : LibC::Double*) : LibC::Int
    # fun gsl_sf_beta_e(a : LibC::Double, b : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_beta_inc_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_gegenpoly_1_e(lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_gegenpoly_2_e(lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_gegenpoly_3_e(lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_gegenpoly_1(lambda : LibC::Double, x : LibC::Double) : LibC::Double
    # fun gsl_sf_gegenpoly_2(lambda : LibC::Double, x : LibC::Double) : LibC::Double
    # fun gsl_sf_gegenpoly_3(lambda : LibC::Double, x : LibC::Double) : LibC::Double
    # fun gsl_sf_gegenpoly_n_e(n : LibC::Int, lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_gegenpoly_array(nmax : LibC::Int, lambda : LibC::Double, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_prob_deriv_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_deriv_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_func_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_func_fast_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_prob_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_array_deriv(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_deriv_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_series_e(n : LibC::Int, x : LibC::Double, a : LibC::Double*, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_array_deriv(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_deriv_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_series_e(n : LibC::Int, x : LibC::Double, a : LibC::Double*, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_func_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_func_series_e(n : LibC::Int, x : LibC::Double, a : LibC::Double*, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_func_der_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_prob_zero_e(n : LibC::Int, s : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_zero_e(n : LibC::Int, s : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_func_zero_e(n : LibC::Int, s : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_phys_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_phys_der_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_phys_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_phys_series_e(n : LibC::Int, x : LibC::Double, a : LibC::Double*, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_phys_array_der(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_phys_der_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_phys_zero_e(n : LibC::Int, s : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hermite_prob_array_der(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_der_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_der_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_0F1_e(c : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_1F1_int_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_1F1_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_U_int_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_U_int_e10_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    # fun gsl_sf_hyperg_U_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_U_e10_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    # fun gsl_sf_hyperg_2F1_e(a : LibC::Double, b : LibC::Double, c : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_2F1_conj_e(a_r : LibC::Double, a_i : LibC::Double, c : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_2F1_renorm_e(a : LibC::Double, b : LibC::Double, c : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_2F1_conj_renorm_e(a_r : LibC::Double, a_i : LibC::Double, c : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hyperg_2F0_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_laguerre_1_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_laguerre_2_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_laguerre_3_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_laguerre_1(a : LibC::Double, x : LibC::Double) : LibC::Double
    # fun gsl_sf_laguerre_2(a : LibC::Double, x : LibC::Double) : LibC::Double
    # fun gsl_sf_laguerre_3(a : LibC::Double, x : LibC::Double) : LibC::Double
    # fun gsl_sf_laguerre_n_e(n : LibC::Int, a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    def_function(lambert_W0)
    def_function(lambert_Wm1)
    # fun gsl_sf_legendre_Pl_e(l : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_legendre_Pl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_Pl_deriv_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    def_function(legendre_P1)
    def_function(legendre_P2)
    def_function(legendre_P3)
    def_function(legendre_Q0)
    def_function(legendre_Q1)
    # fun gsl_sf_legendre_Ql_e(l : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_legendre_Plm_e(l : LibC::Int, m : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_legendre_Plm_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_Plm_deriv_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_sphPlm_e(l : LibC::Int, m : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_legendre_sphPlm_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_sphPlm_deriv_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_array_size(lmax : LibC::Int, m : LibC::Int) : LibC::Int
    # fun gsl_sf_conicalP_half_e(lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_conicalP_mhalf_e(lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_conicalP_0_e(lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_conicalP_1_e(lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_conicalP_sph_reg_e(l : LibC::Int, lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_conicalP_cyl_reg_e(m : LibC::Int, lambda : LibC::Double, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_legendre_H3d_0_e(lambda : LibC::Double, eta : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_legendre_H3d_1_e(lambda : LibC::Double, eta : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_legendre_H3d_e(l : LibC::Int, lambda : LibC::Double, eta : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_legendre_H3d_array(lmax : LibC::Int, lambda : LibC::Double, eta : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_precompute(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, flags : LibC::SizeT, output_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_array_n(lmax : LibC::SizeT) : LibC::SizeT
    # fun gsl_sf_legendre_arrayx(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv_alt_arrayx(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv_arrayx(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv2_alt_arrayx(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv2_arrayx(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_array(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv_array(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv_alt_array(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv2_array(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv2_alt_array(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_nlm(lmax : LibC::SizeT) : LibC::SizeT
    # fun gsl_sf_legendre_array_index(l : LibC::SizeT, m : LibC::SizeT) : LibC::SizeT
    # fun gsl_sf_legendre_array_index_m(l : LibC::SizeT, m : LibC::SizeT, lmax : LibC::SizeT) : LibC::SizeT
    # fun gsl_sf_legendre_array_e(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv_array_e(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv_alt_array_e(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv2_array_e(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_deriv2_alt_array_e(norm : Gsl_sf_legendre_t, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
    def_function(log)
    def_function(log_abs)
    # fun gsl_sf_complex_log_e(zr : LibC::Double, zi : LibC::Double, lnr : Gsl_sf_result*, theta : Gsl_sf_result*) : LibC::Int
    def_function(log_1plusx)
    def_function(log_1plusx_mx)
    # fun gsl_sf_mathieu_a_array(order_min : LibC::Int, order_max : LibC::Int, qq : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_b_array(order_min : LibC::Int, order_max : LibC::Int, qq : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_a_e(order : LibC::Int, qq : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_mathieu_b_e(order : LibC::Int, qq : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_mathieu_a_coeff(order : LibC::Int, qq : LibC::Double, aa : LibC::Double, coeff : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_b_coeff(order : LibC::Int, qq : LibC::Double, aa : LibC::Double, coeff : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_alloc(nn : LibC::SizeT, qq : LibC::Double) : Gsl_sf_mathieu_workspace*
    # fun gsl_sf_mathieu_free(workspace : Gsl_sf_mathieu_workspace*)
    # fun gsl_sf_mathieu_ce_e(order : LibC::Int, qq : LibC::Double, zz : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_mathieu_se_e(order : LibC::Int, qq : LibC::Double, zz : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_mathieu_ce_array(nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_se_array(nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_Mc_e(kind : LibC::Int, order : LibC::Int, qq : LibC::Double, zz : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_mathieu_Ms_e(kind : LibC::Int, order : LibC::Int, qq : LibC::Double, zz : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_mathieu_Mc_array(kind : LibC::Int, nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_Ms_array(kind : LibC::Int, nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_pow_int_e(x : LibC::Double, n : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_psi_int_e(n : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    def_function(psi)
    # fun gsl_sf_psi_1piy_e(y : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_complex_psi_e(x : LibC::Double, y : LibC::Double, result_re : Gsl_sf_result*, result_im : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_psi_1_int_e(n : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    def_function(psi_1)
    # fun gsl_sf_psi_n_e(n : LibC::Int, x : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    def_function(sin_pi)
    def_function(cos_pi)
    def_function(synchrotron_1)
    def_function(synchrotron_2)
    def_function(transport_2)
    def_function(transport_3)
    def_function(transport_4)
    def_function(transport_5)
    def_function(sin)
    def_function(cos)
    # fun gsl_sf_hypot_e(x : LibC::Double, y : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_complex_sin_e(zr : LibC::Double, zi : LibC::Double, szr : Gsl_sf_result*, szi : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_complex_cos_e(zr : LibC::Double, zi : LibC::Double, czr : Gsl_sf_result*, czi : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_complex_logsin_e(zr : LibC::Double, zi : LibC::Double, lszr : Gsl_sf_result*, lszi : Gsl_sf_result*) : LibC::Int
    def_function(sinc)
    def_function(lnsinh)
    def_function(lncosh)
    # fun gsl_sf_polar_to_rect(r : LibC::Double, theta : LibC::Double, x : Gsl_sf_result*, y : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_rect_to_polar(x : LibC::Double, y : LibC::Double, r : Gsl_sf_result*, theta : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_sin_err_e(x : LibC::Double, dx : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_cos_err_e(x : LibC::Double, dx : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_angle_restrict_symm_e(theta : LibC::Double*) : LibC::Int
    # fun gsl_sf_angle_restrict_pos_e(theta : LibC::Double*) : LibC::Int
    # fun gsl_sf_angle_restrict_symm_err_e(theta : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_angle_restrict_pos_err_e(theta : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_zeta_int_e(n : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_zeta_e(s : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_zetam1_e(s : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_zetam1_int_e(s : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_hzeta_e(s : LibC::Double, q : LibC::Double, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_eta_int_e(n : LibC::Int, result : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_eta_e(s : LibC::Double, result : Gsl_sf_result*) : LibC::Int
  end

  extend SpecFunctions
end
