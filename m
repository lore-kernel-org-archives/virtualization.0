From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] x86/vmware: Add paravirt sched clock
Date: Wed, 26 Oct 2016 12:18:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610261213000.4983@nanos>
References: <20161026052038.77042-1-amakhalov@vmware.com>
	<20161026052640.77585-1-amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161026052640.77585-1-amakhalov@vmware.com>
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
Cc: corbet@lwn.net, time-lords@vmware.com, linux-doc@vger.kernel.org, pv-drivers@vmware.com, x86@kernel.org, linux-kernel@vger.kernel.org, monitor-list@vmware.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Oct 2016, Alexey Makhalov wrote:
> no-vmw-sched-clock kernel parameter is added to switch back to the
> native_sched_clock() implementation.

You are not switching back. The parameter is used to disable the paravirt
sched clock.

>  #ifdef CONFIG_PARAVIRT
> +static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
> +
> +static int vmw_sched_clock __initdata = 1;
> +static __init int setup_vmw_sched_clock(char *s)

Please stop glueing a variable to a function w/o a new line between
them. It's just stopping the reading flow.

> +{
> +	vmw_sched_clock = 0;
> +	return 0;
> +}
> +early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
> +
> +static unsigned long long vmware_sched_clock(void)
> +{
> +	unsigned long long ns;
> +
> +	ns = mul_u64_u32_shr(rdtsc(), vmware_cyc2ns.cyc2ns_mul,
> +			     vmware_cyc2ns.cyc2ns_shift);
> +	ns -= vmware_cyc2ns.cyc2ns_offset;
> +	return ns;
> +}
> +
>  static void __init vmware_paravirt_ops_setup(void)
>  {
>  	pv_info.name = "VMware";
>  	pv_cpu_ops.io_delay = paravirt_nop;
> +
> +	if (vmware_tsc_khz && vmw_sched_clock) {
> +		unsigned long long tsc_now = rdtsc();
> +
> +		clocks_calc_mult_shift(&vmware_cyc2ns.cyc2ns_mul,
> +				       &vmware_cyc2ns.cyc2ns_shift,
> +				       vmware_tsc_khz,
> +				       NSEC_PER_MSEC, 0);
> +		vmware_cyc2ns.cyc2ns_offset =
> +			mul_u64_u32_shr(tsc_now, vmware_cyc2ns.cyc2ns_mul,
> +					vmware_cyc2ns.cyc2ns_shift);
> +
> +		pv_time_ops.sched_clock = vmware_sched_clock;
> +		pr_info("vmware: using sched offset of %llu ns\n",

Please use pr_fmt instead of adding the prefix to every print.

Thanks,

	tglx
