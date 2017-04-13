From: Alok Kataria <akataria@vmware.com>
Subject: Re: [PATCH v2 10/11] vmware: set cpu capabilities during platform
	initialization
Date: Thu, 13 Apr 2017 10:29:27 +0000
Message-ID: <1492079789.5342.0.camel@vmware.com>
References: <20170413101116.723-1-jgross@suse.com>
	<20170413101116.723-11-jgross@suse.com>
Reply-To: Alok Kataria <akataria@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170413101116.723-11-jgross@suse.com>
Content-Language: en-US
Content-ID: <4F184592D26638428E7677F1C4C80E94@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "jgross@suse.com" <jgross@suse.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 2017-04-13 at 12:11 +0200, Juergen Gross wrote:
> There is no need to set the same capabilities for each cpu
> individually. This can be done for all cpus in platform initialization.

Looks reasonable to me.
Acked-by: Alok Kataria <akataria@vmware.com>

Thanks,
Alok

> 
> Cc: Alok Kataria <akataria@vmware.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 22403a28caf5..40ed26852ebd 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -113,6 +113,24 @@ static void __init vmware_paravirt_ops_setup(void)
>  #define vmware_paravirt_ops_setup() do {} while (0)
>  #endif
>  
> +/*
> + * VMware hypervisor takes care of exporting a reliable TSC to the guest.
> + * Still, due to timing difference when running on virtual cpus, the TSC can
> + * be marked as unstable in some cases. For example, the TSC sync check at
> + * bootup can fail due to a marginal offset between vcpus' TSCs (though the
> + * TSCs do not drift from each other).  Also, the ACPI PM timer clocksource
> + * is not suitable as a watchdog when running on a hypervisor because the
> + * kernel may miss a wrap of the counter if the vcpu is descheduled for a
> + * long time. To skip these checks at runtime we set these capability bits,
> + * so that the kernel could just trust the hypervisor with providing a
> + * reliable virtual TSC that is suitable for timekeeping.
> + */
> +static void __init vmware_set_capabilities(void)
> +{
> +	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
> +	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> +}
> +
>  static void __init vmware_platform_setup(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
> @@ -152,6 +170,8 @@ static void __init vmware_platform_setup(void)
>  #ifdef CONFIG_X86_IO_APIC
>  	no_timer_check = 1;
>  #endif
> +
> +	vmware_set_capabilities();
>  }
>  
>  /*
> @@ -176,24 +196,6 @@ static uint32_t __init vmware_platform(void)
>  	return 0;
>  }
>  
> -/*
> - * VMware hypervisor takes care of exporting a reliable TSC to the guest.
> - * Still, due to timing difference when running on virtual cpus, the TSC can
> - * be marked as unstable in some cases. For example, the TSC sync check at
> - * bootup can fail due to a marginal offset between vcpus' TSCs (though the
> - * TSCs do not drift from each other).  Also, the ACPI PM timer clocksource
> - * is not suitable as a watchdog when running on a hypervisor because the
> - * kernel may miss a wrap of the counter if the vcpu is descheduled for a
> - * long time. To skip these checks at runtime we set these capability bits,
> - * so that the kernel could just trust the hypervisor with providing a
> - * reliable virtual TSC that is suitable for timekeeping.
> - */
> -static void vmware_set_cpu_features(struct cpuinfo_x86 *c)
> -{
> -	set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> -	set_cpu_cap(c, X86_FEATURE_TSC_RELIABLE);
> -}
> -
>  /* Checks if hypervisor supports x2apic without VT-D interrupt remapping. */
>  static bool __init vmware_legacy_x2apic_available(void)
>  {
> @@ -206,7 +208,6 @@ static bool __init vmware_legacy_x2apic_available(void)
>  const __refconst struct hypervisor_x86 x86_hyper_vmware = {
>  	.name			= "VMware",
>  	.detect			= vmware_platform,
> -	.set_cpu_features	= vmware_set_cpu_features,
>  	.init_platform		= vmware_platform_setup,
>  	.x2apic_available	= vmware_legacy_x2apic_available,
>  };
