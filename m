From: Tim Mann <mann@vmware.com>
Subject: Re: [PATCH 2/3] x86/vmware: Add basic paravirt ops support
Date: Wed, 26 Oct 2016 13:47:07 -0700
Message-ID: <20161026134707.1e445c37__15893.8545654111$1477936058$gmane$org@manzanita>
References: <20161026052038.77042-1-amakhalov@vmware.com>
	<20161026052600.77535-1-amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161026052600.77535-1-amakhalov@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Makhalov <amakhalov@vmware.com>
Cc: time-lords@vmware.com, corbet@lwn.net, pv-drivers@vmware.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, monitor-list@vmware.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

I believe our trademark guidelines say we aren't supposed to use VMware as a
noun to mean a product, only to mean the company.  So we can say "running on
VMware ESXi" or "running in a VMware virtual machine", but "running on VMware"
is wrong.  There is supposedly some good legal reason for this related to
keeping our trademark.

On Tue, 25 Oct 2016 22:26:00 -0700, Alexey Makhalov <amakhalov@vmware.com>
wrote:
> Add basic paravirt support:
>  1. set pv_info.name to "VMware" to have proper boot log message
> 	Booting paravirtualized kernel on VMware
>     instead of "... on bare hardware"
>  2. set pv_cpu_ops.io_delay() to empty function - paravirt_nop() to
>     avoid vm-exits on IO delays.
> 
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
> Acked-by: Alok N Kataria <akataria@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 480790f..e3fb320 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -61,6 +61,16 @@ static unsigned long vmware_get_tsc_khz(void)
>  	return vmware_tsc_khz;
>  }
>  
> +#ifdef CONFIG_PARAVIRT
> +static void __init vmware_paravirt_ops_setup(void)
> +{
> +	pv_info.name = "VMware";
> +	pv_cpu_ops.io_delay = paravirt_nop;
> +}
> +#else
> +#define vmware_paravirt_ops_setup() do {} while (0)
> +#endif
> +
>  static void __init vmware_platform_setup(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
> @@ -94,6 +104,8 @@ static void __init vmware_platform_setup(void)
>  	} else {
>  		pr_warn("Failed to get TSC freq from the hypervisor\n");
>  	}
> +
> +	vmware_paravirt_ops_setup();
>  }
>  
>  /*



-- 
Tim Mann                  | work: mann@vmware.com  home: tim@tim-mann.org
VMware Sr. Staff Engineer | http://www.vmware.com  http://tim-mann.org
