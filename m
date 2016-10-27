From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH 3/3] x86/vmware: Add paravirt sched clock
Date: Fri, 28 Oct 2016 00:10:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610272345510.4913@nanos>
References: <alpine.DEB.2.20.1610262247030.5013@nanos>
	<20161027194454.9729-1-amakhalov@vmware.com>
	<20161027194454.9729-3-amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161027194454.9729-3-amakhalov@vmware.com>
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
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, pv-drivers@vmware.com, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 Oct 2016, Alexey Makhalov wrote:

> Set pv_time_ops.sched_clock to vmware_sched_clock(). 

Please do not describe WHAT the patch does, describe why. Describe the
problem you are solving. I can see from the patch

> +		pv_time_ops.sched_clock = vmware_sched_clock;

that you set pv_time_ops.sched_clock to vmware_sched_clock().

> It is simplified
> version of native_sched_clock() without ring buffer of mult/shift/offset
> triplets and preempt toggling.

-ENOPARSE

> Since VMware hypervisor provides constant tsc we can use constant
> mult/shift/offset triplet calculated at boot time.

So now you start to explain something which is understandable
 
> no-vmw-sched-clock kernel parameter is added to disable the paravirt
> sched clock.

I give you another example:

  The default sched_clock() implementation is native_sched_clock(). It
  contains code to handle non constant frequency TSCs, which creates
  overhead for systems with constant frequency TSCs.

  The vmware hypervisor guarantees a constant frequency TSC, so
  native_sched_clock() is not required and slower than a dedicated function
  which operates with one time calculated conversion factors.

  Calculate the conversion factors at boot time from the tsc frequency and
  install an optimized sched_clock() function via paravirt ops.

  The paravirtualized clock can be disabled on the kernel command line with
  the new 'no-vmw-sched-clock' option.

Can you see the difference and can you spot the structure similar to the
example I gave you before?

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
>  	pv_info.name = "VMware hypervisor";
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
> +		pr_info("using sched offset of %llu ns\n",
> +			vmware_cyc2ns.cyc2ns_offset);

If you either do:

	if (!vmware_tsc_khz || !vmw_sched_clock)
		return;

or

	if (vmware_tsc_khz && vmw_sched_clock)
		setup_sched_clock();

and split out the code into a seperate function then you spare one
indentation level and some of these hard to read line breaks.

Hint:
	
static void setup_sched_clock(void)
{
	struct cyc2ns_data *d = &vmware_cyc2ns;

	clocks_calc_mult_shift(&d->cyc2ns_mul, &d->cyc32ns_shift,
			       vmware_tsc_khz, NSEC_PER_MSEC, 0);
	
reduces the lenght of the arguments significantly and makes this stuff sane
to read.

Thanks,

	tglx
