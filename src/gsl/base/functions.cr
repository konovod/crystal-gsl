require "./libgsl.cr"

module GSL
  module SpecFunctions
    private macro def_function(fn, fn_raw = nil)
      {% fn_raw = fn unless fn_raw %}
      def {{fn}}(x : Float64) : Float64
        code = LibGSL.gsl_sf_{{fn_raw}}_e(x, out result)
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
        code = LibGSL.gsl_sf_{{fn}}_e(x, LibGSL::Gsl_mode_t.new(UInt32.new(precision.to_i)), out result)
        check_return_code(LibGSL::Code.new(code), "gsl_sf_{{fn}}_e")
        result.val
      end
    end

    private macro def_function_with_args(fn, *args)
      def {{fn}}({{*args}}) : Float64
        code = LibGSL.gsl_sf_{{fn}}_e({{*args.map(&.var)}}, out result)
        check_return_code(LibGSL::Code.new(code), "gsl_sf_{{fn}}_e")
        result.val
      end
    end

    private macro def_function_with_args_mode(fn, *args)
      def {{fn}}({{*args}}, precision : Precision = Precision::Double) : Float64
        code = LibGSL.gsl_sf_{{fn}}_e({{*args.map(&.var)}}, precision, out result)
        check_return_code(LibGSL::Code.new(code), "gsl_sf_{{fn}}_e")
        result.val
      end
    end

    private macro def_function_complex(fn, fn_raw = fn)
      def {{fn}}(x : Complex) : Complex # fixing first capital letter
        code = LibGSL.gsl_sf_complex_{{fn_raw}}_e(x.real, x.imag, out result_re, out result_im)
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_sf_{{fn}}_e")
        Complex.new(result_re.val, result_im.val)
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

    def_function_with_args(airy_zero_Ai, s : UInt32)
    def_function_with_args(airy_zero_Bi, s : UInt32)
    def_function_with_args(airy_zero_Ai_deriv, s : UInt32)
    def_function_with_args(airy_zero_Bi_deriv, s : UInt32)
    def_function(bessel_J0)
    def_function(bessel_J1)
    def_function_with_args(bessel_Jn, n : Int32, x : Float64)
    def_function_with_args(bessel_Jn, n : Int32, x : Float64)
    # fun gsl_sf_bessel_Jn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_Y0)
    def_function(bessel_Y1)
    def_function_with_args(bessel_Yn, n : Int32, x : Float64)
    # fun gsl_sf_bessel_Yn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_I0)
    def_function(bessel_I1)
    def_function_with_args(bessel_In, n : Int32, x : Float64)
    # fun gsl_sf_bessel_In_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_I0_scaled)
    def_function(bessel_I1_scaled)
    def_function_with_args(bessel_In_scaled, n : Int32, x : Float64)
    # fun gsl_sf_bessel_In_scaled_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_K0)
    def_function(bessel_K1)
    def_function_with_args(bessel_Kn, n : Int32, x : Float64)
    # fun gsl_sf_bessel_Kn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_K0_scaled)
    def_function(bessel_K1_scaled)
    def_function_with_args(bessel_Kn_scaled, n : Int32, x : Float64)
    # fun gsl_sf_bessel_Kn_scaled_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_j0)
    def_function(bessel_j1)
    def_function(bessel_j2)
    def_function_with_args(bessel_jl, l : Int32, x : Float64)
    # fun gsl_sf_bessel_jl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_bessel_jl_steed_array(lmax : LibC::Int, x : LibC::Double, jl_x_array : LibC::Double*) : LibC::Int
    def_function(bessel_y0)
    def_function(bessel_y1)
    def_function(bessel_y2)
    def_function_with_args(bessel_yl, l : Int32, x : Float64)
    # fun gsl_sf_bessel_yl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_i0_scaled)
    def_function(bessel_i1_scaled)
    def_function(bessel_i2_scaled)
    def_function_with_args(bessel_il_scaled, l : Int32, x : Float64)
    # fun gsl_sf_bessel_il_scaled_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function(bessel_k0_scaled)
    def_function(bessel_k1_scaled)
    def_function(bessel_k2_scaled)
    def_function_with_args(bessel_kl_scaled, l : Int32, x : Float64)
    # fun gsl_sf_bessel_kl_scaled_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(bessel_Jnu, nu : Float64, x : Float64)
    def_function_with_args(bessel_Ynu, nu : Float64, x : Float64)
    # fun gsl_sf_bessel_sequence_Jnu_e(nu : LibC::Double, mode : Gsl_mode_t, size : LibC::SizeT, v : LibC::Double*) : LibC::Int
    def_function_with_args(bessel_Inu_scaled, nu : Float64, x : Float64)
    def_function_with_args(bessel_Inu, nu : Float64, x : Float64)
    def_function_with_args(bessel_Knu_scaled, nu : Float64, x : Float64)
    # fun gsl_sf_bessel_Knu_scaled_e10_e(nu : LibC::Double, x : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function_with_args(bessel_Knu, nu : Float64, x : Float64)
    def_function_with_args(bessel_lnKnu, nu : Float64, x : Float64)
    def_function_with_args(bessel_zero_J0, s : LibC::UInt)
    def_function_with_args(bessel_zero_J1, s : LibC::UInt)
    def_function_with_args(bessel_zero_Jnu, nu : Float64, s : LibC::UInt)
    def_function(clausen)
    def_function_with_args(hydrogenicR_1, z : Float64, r : Float64)
    def_function_with_args(hydrogenicR, n : Int32, l : Int32, z : Float64, r : Float64)
    # fun gsl_sf_coulomb_wave_FG_e(eta : LibC::Double, x : LibC::Double, lam_f : LibC::Double, k_lam_g : LibC::Int, f : Gsl_sf_result*, fp : Gsl_sf_result*, g : Gsl_sf_result*, gp : Gsl_sf_result*, exp_f : LibC::Double*, exp_g : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_wave_F_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, f_exponent : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_wave_FG_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, gc_array : LibC::Double*, f_exponent : LibC::Double*, g_exponent : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_wave_FGp_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, fcp_array : LibC::Double*, gc_array : LibC::Double*, gcp_array : LibC::Double*, f_exponent : LibC::Double*, g_exponent : LibC::Double*) : LibC::Int
    # fun gsl_sf_coulomb_wave_sphF_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, f_exponent : LibC::Double*) : LibC::Int
    def_function_with_args(coulomb_CL, l : Float64, eta : Float64)
    # fun gsl_sf_coulomb_CL_array(lmin : LibC::Double, kmax : LibC::Int, eta : LibC::Double, cl : LibC::Double*) : LibC::Int
    def_function_with_args(coupling_3j, two_ja : Int32, two_jb : Int32, two_jc : Int32, two_ma : Int32, two_mb : Int32, two_mc : Int32)
    def_function_with_args(coupling_6j, two_ja : Int32, two_jb : Int32, two_jc : Int32, two_jd : Int32, two_je : Int32, two_jf : Int32)
    def_function_with_args(coupling_RacahW, two_ja : Int32, two_jb : Int32, two_jc : Int32, two_jd : Int32, two_je : Int32, two_jf : Int32)
    def_function_with_args(coupling_9j, two_ja : Int32, two_jb : Int32, two_jc : Int32, two_jd : Int32, two_je : Int32, two_jf : Int32, two_jg : Int32, two_jh : Int32, two_ji : Int32)
    def_function_with_args(coupling_6j_INCORRECT, two_ja : Int32, two_jb : Int32, two_jc : Int32, two_jd : Int32, two_je : Int32, two_jf : Int32)
    def_function(dawson)
    def_function(debye_1)
    def_function(debye_2)
    def_function(debye_3)
    def_function(debye_4)
    def_function(debye_5)
    def_function(debye_6)
    def_function(dilog)
    def_function_complex(dilog, dilog_xy)
    def_function_complex(spence, spence_xy)
    # fun gsl_sf_complex_dilog_e(r : LibC::Double, theta : LibC::Double, result_re : Gsl_sf_result*, result_im : Gsl_sf_result*) : LibC::Int
    def_function_with_args(multiply, x : Float64, y : Float64)
    def_function_with_args(multiply_err, x : Float64, dx : Float64, y : Float64, dy : Float64)
    def_function_with_args_mode(ellint_Kcomp, k : Float64)
    def_function_with_args_mode(ellint_Ecomp, k : Float64)
    def_function_with_args_mode(ellint_Pcomp, k : Float64, n : Float64)
    def_function_with_args_mode(ellint_Dcomp, k : Float64)
    def_function_with_args_mode(ellint_F, phi : Float64, k : Float64)
    def_function_with_args_mode(ellint_E, phi : Float64, k : Float64)
    def_function_with_args_mode(ellint_P, phi : Float64, k : Float64, n : Float64)
    def_function_with_args_mode(ellint_D, phi : Float64, k : Float64)
    def_function_with_args_mode(ellint_RC, x : Float64, y : Float64)
    def_function_with_args_mode(ellint_RD, x : Float64, y : Float64, z : Float64)
    def_function_with_args_mode(ellint_RF, x : Float64, y : Float64, z : Float64)
    def_function_with_args_mode(ellint_RJ, x : Float64, y : Float64, z : Float64, p : Float64)
    # fun gsl_sf_elljac_e(u : LibC::Double, m : LibC::Double, sn : LibC::Double*, cn : LibC::Double*, dn : LibC::Double*) : LibC::Int
    def_function(erfc)
    def_function(log_erfc)
    def_function(erf)
    def_function(erf_Z)
    def_function(erf_Q)
    def_function(hazard)
    def_function(exp)
    # fun gsl_sf_exp_e10_e(x : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function_with_args(exp_mult, x : Float64, y : Float64)
    # fun gsl_sf_exp_mult_e10_e(x : LibC::Double, y : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function(expm1)
    def_function(exprel)
    def_function(exprel_2)
    def_function_with_args(exprel_n, n : Int32, x : Float64)
    def_function_with_args(exprel_n_CF, n : Float64, x : Float64)
    def_function_with_args(exp_err, x : Float64, dx : Float64)
    # fun gsl_sf_exp_err_e10_e(x : LibC::Double, dx : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function_with_args(exp_mult_err, x : Float64, dx : Float64, y : Float64, dy : Float64)
    # fun gsl_sf_exp_mult_err_e10_e(x : LibC::Double, dx : LibC::Double, y : LibC::Double, dy : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function(expint_E1)
    def_function(expint_E2)
    def_function_with_args(expint_En, n : Int32, x : Float64)
    def_function(expint_E1_scaled)
    def_function(expint_E2_scaled)
    def_function_with_args(expint_En_scaled, n : Int32, x : Float64)
    def_function(expint_Ei)
    def_function(expint_Ei_scaled)
    def_function(shi, Shi)
    def_function(chi, Chi)
    def_function(expint_3)
    def_function(si, Si)
    def_function(ci, Ci)
    def_function(atanint)
    def_function(fermi_dirac_m1)
    def_function(fermi_dirac_0)
    def_function(fermi_dirac_1)
    def_function(fermi_dirac_2)
    def_function_with_args(fermi_dirac_int, j : Int32, x : Float64)
    def_function(fermi_dirac_mhalf)
    def_function(fermi_dirac_half)
    def_function(fermi_dirac_3half)
    def_function_with_args(fermi_dirac_inc_0, x : Float64, b : Float64)
    def_function(lngamma)
    # fun gsl_sf_lngamma_sgn_e(x : LibC::Double, result_lg : Gsl_sf_result*, sgn : LibC::Double*) : LibC::Int
    def_function(gamma)
    def_function(gammastar)
    def_function(gammainv)
    # fun gsl_sf_lngamma_complex_e(zr : LibC::Double, zi : LibC::Double, lnr : Gsl_sf_result*, arg : Gsl_sf_result*) : LibC::Int
    def_function_with_args(taylorcoeff, n : Int32, x : Float64)
    def_function_with_args(fact, n : LibC::UInt)
    def_function_with_args(doublefact, n : LibC::UInt)
    def_function_with_args(lnfact, n : LibC::UInt)
    def_function_with_args(lndoublefact, n : LibC::UInt)
    def_function_with_args(lnchoose, n : LibC::UInt, m : LibC::UInt)
    def_function_with_args(choose, n : LibC::UInt, m : LibC::UInt)
    def_function_with_args(lnpoch, a : Float64, x : Float64)
    # fun gsl_sf_lnpoch_sgn_e(a : LibC::Double, x : LibC::Double, result : Gsl_sf_result*, sgn : LibC::Double*) : LibC::Int
    def_function_with_args(poch, a : Float64, x : Float64)
    def_function_with_args(pochrel, a : Float64, x : Float64)
    def_function_with_args(gamma_inc_Q, a : Float64, x : Float64)
    def_function_with_args(gamma_inc_P, a : Float64, x : Float64)
    def_function_with_args(gamma_inc, a : Float64, x : Float64)
    def_function_with_args(lnbeta, a : Float64, b : Float64)
    # fun gsl_sf_lnbeta_sgn_e(x : LibC::Double, y : LibC::Double, result : Gsl_sf_result*, sgn : LibC::Double*) : LibC::Int
    def_function_with_args(beta, a : Float64, b : Float64)
    def_function_with_args(beta_inc, a : Float64, b : Float64, x : Float64)
    def_function_with_args(gegenpoly_1, lambda : Float64, x : Float64)
    def_function_with_args(gegenpoly_2, lambda : Float64, x : Float64)
    def_function_with_args(gegenpoly_3, lambda : Float64, x : Float64)
    def_function_with_args(gegenpoly_n, n : Int32, lambda : Float64, x : Float64)
    # fun gsl_sf_gegenpoly_array(nmax : LibC::Int, lambda : LibC::Double, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(hermite_prob, n : Int32, x : Float64)
    def_function_with_args(hermite_prob_deriv, m : Int32, n : Int32, x : Float64)
    def_function_with_args(hermite, n : Int32, x : Float64)
    def_function_with_args(hermite_deriv, m : Int32, n : Int32, x : Float64)
    def_function_with_args(hermite_func, n : Int32, x : Float64)
    def_function_with_args(hermite_func_fast, n : Int32, x : Float64)
    # fun gsl_sf_hermite_prob_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_array_deriv(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_deriv_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(hermite_prob_series, n : Int32, x : Float64, a : Float64*)
    # fun gsl_sf_hermite_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_array_deriv(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_deriv_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(hermite_series, n : Int32, x : Float64, a : Float64*)
    # fun gsl_sf_hermite_func_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(hermite_func_series, n : Int32, x : Float64, a : Float64*)
    def_function_with_args(hermite_func_der, m : Int32, n : Int32, x : Float64)
    def_function_with_args(hermite_prob_zero, n : Int32, s : Int32)
    def_function_with_args(hermite_zero, n : Int32, s : Int32)
    def_function_with_args(hermite_func_zero, n : Int32, s : Int32)
    def_function_with_args(hermite_phys, n : Int32, x : Float64)
    def_function_with_args(hermite_phys_der, m : Int32, n : Int32, x : Float64)
    # fun gsl_sf_hermite_phys_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(hermite_phys_series, n : Int32, x : Float64, a : Float64*)
    # fun gsl_sf_hermite_phys_array_der(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_phys_der_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(hermite_phys_zero, n : Int32, s : Int32)
    # fun gsl_sf_hermite_prob_array_der(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_hermite_prob_der_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(hermite_prob_der, m : Int32, n : Int32, x : Float64)
    def_function_with_args(hyperg_0F1, c : Float64, x : Float64)
    def_function_with_args(hyperg_1F1_int, m : Int32, n : Int32, x : Float64)
    def_function_with_args(hyperg_1F1, a : Float64, b : Float64, x : Float64)
    def_function_with_args(hyperg_U_int, m : Int32, n : Int32, x : Float64)
    # fun gsl_sf_hyperg_U_int_e10_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function_with_args(hyperg_U, a : Float64, b : Float64, x : Float64)
    # fun gsl_sf_hyperg_U_e10_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : Gsl_sf_result_e10*) : LibC::Int
    def_function_with_args(hyperg_2F1, a : Float64, b : Float64, c : Float64, x : Float64)
    def_function_with_args(hyperg_2F1_conj, a_r : Float64, a_i : Float64, c : Float64, x : Float64)
    def_function_with_args(hyperg_2F1_renorm, a : Float64, b : Float64, c : Float64, x : Float64)
    def_function_with_args(hyperg_2F1_conj_renorm, a_r : Float64, a_i : Float64, c : Float64, x : Float64)
    def_function_with_args(hyperg_2F0, a : Float64, b : Float64, x : Float64)
    def_function_with_args(laguerre_1, a : Float64, x : Float64)
    def_function_with_args(laguerre_2, a : Float64, x : Float64)
    def_function_with_args(laguerre_3, a : Float64, x : Float64)
    def_function_with_args(laguerre_n, n : Int32, a : Float64, x : Float64)
    def_function(lambert_W0)
    def_function(lambert_Wm1)
    def_function_with_args(legendre_Pl, l : Int32, x : Float64)
    # fun gsl_sf_legendre_Pl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_Pl_deriv_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    def_function(legendre_P1)
    def_function(legendre_P2)
    def_function(legendre_P3)
    def_function(legendre_Q0)
    def_function(legendre_Q1)
    def_function_with_args(legendre_Ql, l : Int32, x : Float64)
    def_function_with_args(legendre_Plm, l : Int32, m : Int32, x : Float64)
    # fun gsl_sf_legendre_Plm_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_Plm_deriv_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    def_function_with_args(legendre_sphPlm, l : Int32, m : Int32, x : Float64)
    # fun gsl_sf_legendre_sphPlm_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_sphPlm_deriv_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_legendre_array_size(lmax : LibC::Int, m : LibC::Int) : LibC::Int
    def_function_with_args(conicalP_half, lambda : Float64, x : Float64)
    def_function_with_args(conicalP_mhalf, lambda : Float64, x : Float64)
    def_function_with_args(conicalP_0, lambda : Float64, x : Float64)
    def_function_with_args(conicalP_1, lambda : Float64, x : Float64)
    def_function_with_args(conicalP_sph_reg, l : Int32, lambda : Float64, x : Float64)
    def_function_with_args(conicalP_cyl_reg, m : Int32, lambda : Float64, x : Float64)
    def_function_with_args(legendre_H3d_0, lambda : Float64, eta : Float64)
    def_function_with_args(legendre_H3d_1, lambda : Float64, eta : Float64)
    def_function_with_args(legendre_H3d, l : Int32, lambda : Float64, eta : Float64)
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
    def_function_with_args(mathieu_a, order : Int32, qq : Float64)
    def_function_with_args(mathieu_b, order : Int32, qq : Float64)
    # fun gsl_sf_mathieu_a_coeff(order : LibC::Int, qq : LibC::Double, aa : LibC::Double, coeff : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_b_coeff(order : LibC::Int, qq : LibC::Double, aa : LibC::Double, coeff : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_alloc(nn : LibC::SizeT, qq : LibC::Double) : Gsl_sf_mathieu_workspace*
    # fun gsl_sf_mathieu_free(workspace : Gsl_sf_mathieu_workspace*)
    def_function_with_args(mathieu_ce, order : Int32, qq : Float64, zz : Float64)
    def_function_with_args(mathieu_se, order : Int32, qq : Float64, zz : Float64)
    # fun gsl_sf_mathieu_ce_array(nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_se_array(nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(mathieu_Mc, kind : Int32, order : Int32, qq : Float64, zz : Float64)
    def_function_with_args(mathieu_Ms, kind : Int32, order : Int32, qq : Float64, zz : Float64)
    # fun gsl_sf_mathieu_Mc_array(kind : LibC::Int, nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    # fun gsl_sf_mathieu_Ms_array(kind : LibC::Int, nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : Gsl_sf_mathieu_workspace*, result_array : LibC::Double*) : LibC::Int
    def_function_with_args(pow_int, x : Float64, n : Int32)
    def_function_with_args(psi_int, n : Int32)
    def_function(psi)
    def_function_with_args(psi_1piy, y : Float64)
    def_function_complex(psi)
    def_function_with_args(psi_1_int, n : Int32)
    def_function(psi_1)
    def_function_with_args(psi_n, n : Int32, x : Float64)
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
    def_function_with_args(hypot, x : Float64, y : Float64)
    def_function_complex(sin)
    def_function_complex(cos)
    def_function_complex(logsin)
    def_function(sinc)
    def_function(lnsinh)
    def_function(lncosh)
    # fun gsl_sf_polar_to_rect(r : LibC::Double, theta : LibC::Double, x : Gsl_sf_result*, y : Gsl_sf_result*) : LibC::Int
    # fun gsl_sf_rect_to_polar(x : LibC::Double, y : LibC::Double, r : Gsl_sf_result*, theta : Gsl_sf_result*) : LibC::Int
    def_function_with_args(sin_err, x : Float64, dx : Float64)
    def_function_with_args(cos_err, x : Float64, dx : Float64)
    # fun gsl_sf_angle_restrict_symm_e(theta : LibC::Double*) : LibC::Int
    # fun gsl_sf_angle_restrict_pos_e(theta : LibC::Double*) : LibC::Int
    def_function_with_args(angle_restrict_symm_err, theta : Float64)
    def_function_with_args(angle_restrict_pos_err, theta : Float64)
    def_function_with_args(zeta_int, n : Int32)
    def_function_with_args(zeta, s : Float64)
    def_function_with_args(zetam1, s : Float64)
    def_function_with_args(zetam1_int, s : Int32)
    def_function_with_args(hzeta, s : Float64, q : Float64)
    def_function_with_args(eta_int, n : Int32)
    def_function_with_args(eta, s : Float64)
  end

  extend SpecFunctions
end
