From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH V2 4/4] x86: correctly detect hypervisor
Date: Thu, 25 Jul 2013 10:56:10 +0000
Message-ID: <1f47d60c59a842a1bab5f5d7377cea53__47041.7219134562$1374750806$gmane$org@SN2PR03MB061.namprd03.prod.outlook.com>
References: <1374742475-2485-1-git-send-email-jasowang@redhat.com>
	<1374742475-2485-4-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1374742475-2485-4-git-send-email-jasowang@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dan Hecht <dhecht@vmware.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Doug Covelli <dcovelli@vmware.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Borislav Petkov <bp@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Jason Wang [mailto:jasowang@redhat.com]
> Sent: Thursday, July 25, 2013 4:55 AM
> To: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org;
> linux-kernel@vger.kernel.org; pbonzini@redhat.com
> Cc: kvm@vger.kernel.org; Jason Wang; KY Srinivasan; Haiyang Zhang; Konrad
> Rzeszutek Wilk; Jeremy Fitzhardinge; Doug Covelli; Borislav Petkov; Dan Hecht;
> Paul Gortmaker; Marcelo Tosatti; Gleb Natapov; Frederic Weisbecker;
> devel@linuxdriverproject.org; xen-devel@lists.xensource.com;
> virtualization@lists.linux-foundation.org
> Subject: [PATCH V2 4/4] x86: correctly detect hypervisor
> 
> We try to handle the hypervisor compatibility mode by detecting hypervisor
> through a specific order. This is not robust, since hypervisors may implement
> each others features.
> 
> This patch tries to handle this situation by always choosing the last one in the
> CPUID leaves. This is done by letting .detect() returns a priority instead of
> true/false and just re-using the CPUID leaf where the signature were found as
> the priority (or 1 if it was found by DMI). Then we can just pick hypervisor who
> has the highest priority. Other sophisticated detection method could also be
> implemented on top.
> 
> Suggested by H. Peter Anvin and Paolo Bonzini.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
> Cc: Doug Covelli <dcovelli@vmware.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dan Hecht <dhecht@vmware.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Gleb Natapov <gleb@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: devel@linuxdriverproject.org
> Cc: kvm@vger.kernel.org
> Cc: xen-devel@lists.xensource.com
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by:  K. Y. Srinivasan <kys@microsoft.com>

> ---
>  arch/x86/include/asm/hypervisor.h |    2 +-
>  arch/x86/kernel/cpu/hypervisor.c  |   15 +++++++--------
>  arch/x86/kernel/cpu/mshyperv.c    |   13 ++++++++-----
>  arch/x86/kernel/cpu/vmware.c      |    8 ++++----
>  arch/x86/kernel/kvm.c             |    6 ++----
>  arch/x86/xen/enlighten.c          |    9 +++------
>  6 files changed, 25 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hypervisor.h
> b/arch/x86/include/asm/hypervisor.h
> index 2d4b5e6..e42f758 100644
> --- a/arch/x86/include/asm/hypervisor.h
> +++ b/arch/x86/include/asm/hypervisor.h
> @@ -33,7 +33,7 @@ struct hypervisor_x86 {
>  	const char	*name;
> 
>  	/* Detection routine */
> -	bool		(*detect)(void);
> +	uint32_t	(*detect)(void);
> 
>  	/* Adjust CPU feature bits (run once per CPU) */
>  	void		(*set_cpu_features)(struct cpuinfo_x86 *);
> diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
> index 8727921..36ce402 100644
> --- a/arch/x86/kernel/cpu/hypervisor.c
> +++ b/arch/x86/kernel/cpu/hypervisor.c
> @@ -25,11 +25,6 @@
>  #include <asm/processor.h>
>  #include <asm/hypervisor.h>
> 
> -/*
> - * Hypervisor detect order.  This is specified explicitly here because
> - * some hypervisors might implement compatibility modes for other
> - * hypervisors and therefore need to be detected in specific sequence.
> - */
>  static const __initconst struct hypervisor_x86 * const hypervisors[] =
>  {
>  #ifdef CONFIG_XEN_PVHVM
> @@ -49,15 +44,19 @@ static inline void __init
>  detect_hypervisor_vendor(void)
>  {
>  	const struct hypervisor_x86 *h, * const *p;
> +	uint32_t pri, max_pri = 0;
> 
>  	for (p = hypervisors; p < hypervisors + ARRAY_SIZE(hypervisors); p++) {
>  		h = *p;
> -		if (h->detect()) {
> +		pri = h->detect();
> +		if (pri != 0 && pri > max_pri) {
> +			max_pri = pri;
>  			x86_hyper = h;
> -			printk(KERN_INFO "Hypervisor detected: %s\n", h-
> >name);
> -			break;
>  		}
>  	}
> +
> +	if (max_pri)
> +		printk(KERN_INFO "Hypervisor detected: %s\n", x86_hyper-
> >name);
>  }
> 
>  void init_hypervisor(struct cpuinfo_x86 *c)
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 8f4be53..71a39f3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -27,20 +27,23 @@
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
> 
> -static bool __init ms_hyperv_platform(void)
> +static uint32_t  __init ms_hyperv_platform(void)
>  {
>  	u32 eax;
>  	u32 hyp_signature[3];
> 
>  	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> -		return false;
> +		return 0;
> 
>  	cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS,
>  	      &eax, &hyp_signature[0], &hyp_signature[1], &hyp_signature[2]);
> 
> -	return eax >= HYPERV_CPUID_MIN &&
> -		eax <= HYPERV_CPUID_MAX &&
> -		!memcmp("Microsoft Hv", hyp_signature, 12);
> +	if (eax >= HYPERV_CPUID_MIN &&
> +	    eax <= HYPERV_CPUID_MAX &&
> +	    !memcmp("Microsoft Hv", hyp_signature, 12))
> +		return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
> +
> +	return 0;
>  }
> 
>  static cycle_t read_hv_clock(struct clocksource *arg)
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 7076878..628a059 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -93,7 +93,7 @@ static void __init vmware_platform_setup(void)
>   * serial key should be enough, as this will always have a VMware
>   * specific string when running under VMware hypervisor.
>   */
> -static bool __init vmware_platform(void)
> +static uint32_t __init vmware_platform(void)
>  {
>  	if (cpu_has_hypervisor) {
>  		unsigned int eax;
> @@ -102,12 +102,12 @@ static bool __init vmware_platform(void)
>  		cpuid(CPUID_VMWARE_INFO_LEAF, &eax,
> &hyper_vendor_id[0],
>  		      &hyper_vendor_id[1], &hyper_vendor_id[2]);
>  		if (!memcmp(hyper_vendor_id, "VMwareVMware", 12))
> -			return true;
> +			return CPUID_VMWARE_INFO_LEAF;
>  	} else if (dmi_available && dmi_name_in_serial("VMware") &&
>  		   __vmware_platform())
> -		return true;
> +		return 1;
> 
> -	return false;
> +	return 0;
>  }
> 
>  /*
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index a96d32c..7817afd 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -498,11 +498,9 @@ void __init kvm_guest_init(void)
>  #endif
>  }
> 
> -static bool __init kvm_detect(void)
> +static uint32_t __init kvm_detect(void)
>  {
> -	if (!kvm_para_available())
> -		return false;
> -	return true;
> +	return kvm_cpuid_base();
>  }
> 
>  const struct hypervisor_x86 x86_hyper_kvm __refconst = {
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index 193097e..2fcaedc 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -1720,15 +1720,12 @@ static void __init xen_hvm_guest_init(void)
>  	xen_hvm_init_mmu_ops();
>  }
> 
> -static bool __init xen_hvm_platform(void)
> +static uint32_t __init xen_hvm_platform(void)
>  {
>  	if (xen_pv_domain())
> -		return false;
> -
> -	if (!xen_cpuid_base())
> -		return false;
> +		return 0;
> 
> -	return true;
> +	return xen_cpuid_base();
>  }
> 
>  bool xen_hvm_need_lapic(void)
> --
> 1.7.1
> 
> 
> 
