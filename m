From: "Kershner, David A" <David.Kershner@unisys.com>
Subject: RE: [PATCH 02/10] x86/cpufeature: Kill cpu_has_hypervisor
Date: Tue, 29 Mar 2016 18:03:07 +0000
Message-ID: <67e4f4b2ae964afea939306539be4941__27578.9627260112$1459557926$gmane$org@US-EXCH13-1.na.uis.unisys.com>
References: <1459266123-21878-1-git-send-email-bp@alien8.de>
	<1459266123-21878-3-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459266123-21878-3-git-send-email-bp@alien8.de>
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
To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc: *S-Par-Maintainer <SParMaintainer@unisys.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


> -----Original Message-----
> From: Borislav Petkov [mailto:bp@alien8.de]
> Sent: Tuesday, March 29, 2016 11:42 AM
> To: X86 ML <x86@kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>; virtualization@lists.linux-
> foundation.org; *S-Par-Maintainer <SParMaintainer@unisys.com>
> Subject: [PATCH 02/10] x86/cpufeature: Kill cpu_has_hypervisor
> 
> From: Borislav Petkov <bp@suse.de>
> 
> Use boot_cpu_has() instead.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Tested-by: David Kershner <david.kershner@unisys.com>

> Cc: virtualization@lists.linux-foundation.org
> Cc: sparmaintainer@unisys.com
> ---
>  arch/x86/events/intel/cstate.c                 | 2 +-
>  arch/x86/events/intel/uncore.c                 | 2 +-
>  arch/x86/include/asm/cpufeature.h              | 1 -
>  arch/x86/kernel/cpu/vmware.c                   | 2 +-
>  arch/x86/kernel/kvm.c                          | 2 +-
>  drivers/staging/unisys/visorbus/visorchipset.c | 2 +-
>  6 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index 7946c4231169..d5045c8e2e63 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -677,7 +677,7 @@ static int __init cstate_pmu_init(void)
>  {
>  	int err;
> 
> -	if (cpu_has_hypervisor)
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>  		return -ENODEV;
> 
>  	err = cstate_init();
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 7012d18bb293..3f6d8b5672d5 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1383,7 +1383,7 @@ static int __init intel_uncore_init(void)
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>  		return -ENODEV;
> 
> -	if (cpu_has_hypervisor)
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>  		return -ENODEV;
> 
>  	max_packages = topology_max_packages();
> diff --git a/arch/x86/include/asm/cpufeature.h
> b/arch/x86/include/asm/cpufeature.h
> index fee7a6efcd2d..3aea54ecabfd 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -136,7 +136,6 @@ extern const char * const
> x86_bug_flags[NBUGINTS*32];
>  #define cpu_has_xsave
> 	boot_cpu_has(X86_FEATURE_XSAVE)
>  #define cpu_has_xsaves
> 	boot_cpu_has(X86_FEATURE_XSAVES)
>  #define cpu_has_osxsave
> 	boot_cpu_has(X86_FEATURE_OSXSAVE)
> -#define cpu_has_hypervisor	boot_cpu_has(X86_FEATURE_HYPERVISOR)
>  /*
>   * Do not add any more of those clumsy macros - use static_cpu_has() for
>   * fast paths and boot_cpu_has() otherwise!
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 364e58346897..8cac429b6a1d 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -94,7 +94,7 @@ static void __init vmware_platform_setup(void)
>   */
>  static uint32_t __init vmware_platform(void)
>  {
> -	if (cpu_has_hypervisor) {
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
>  		unsigned int eax;
>  		unsigned int hyper_vendor_id[3];
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 807950860fb7..dc1207e2f193 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -522,7 +522,7 @@ static noinline uint32_t __kvm_cpuid_base(void)
>  	if (boot_cpu_data.cpuid_level < 0)
>  		return 0;	/* So we don't blow up on old processors */
> 
> -	if (cpu_has_hypervisor)
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>  		return hypervisor_cpuid_base("KVMKVMKVM\0\0\0", 0);
> 
>  	return 0;
> diff --git a/drivers/staging/unisys/visorbus/visorchipset.c
> b/drivers/staging/unisys/visorbus/visorchipset.c
> index 5fbda7b218c7..9cf4f8463c4e 100644
> --- a/drivers/staging/unisys/visorbus/visorchipset.c
> +++ b/drivers/staging/unisys/visorbus/visorchipset.c
> @@ -2425,7 +2425,7 @@ static __init uint32_t visorutil_spar_detect(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
> 
> -	if (cpu_has_hypervisor) {
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
>  		/* check the ID */
>  		cpuid(UNISYS_SPAR_LEAF_ID, &eax, &ebx, &ecx, &edx);
>  		return  (ebx == UNISYS_SPAR_ID_EBX) &&
> --
> 2.7.3
