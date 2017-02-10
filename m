From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read
 method
Date: Fri, 10 Feb 2017 12:15:03 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702101214540.4036@nanos>
References: <20170209141052.18694-1-vkuznets@redhat.com>
	<20170209141052.18694-3-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702091806400.3604@nanos>
	<87lgteqp88.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87lgteqp88.fsf@vitty.brq.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 10 Feb 2017, Vitaly Kuznetsov wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Thu, 9 Feb 2017, Vitaly Kuznetsov wrote:
> >> +#ifdef CONFIG_HYPERV_TSCPAGE
> >> +static notrace u64 vread_hvclock(int *mode)
> >> +{
> >> +	const struct ms_hyperv_tsc_page *tsc_pg =
> >> +		(const struct ms_hyperv_tsc_page *)&hvclock_page;
> >> +	u64 sequence, scale, offset, current_tick, cur_tsc;
> >> +
> >> +	while (1) {
> >> +		sequence = READ_ONCE(tsc_pg->tsc_sequence);
> >> +		if (!sequence)
> >> +			break;
> >> +
> >> +		scale = READ_ONCE(tsc_pg->tsc_scale);
> >> +		offset = READ_ONCE(tsc_pg->tsc_offset);
> >> +		rdtscll(cur_tsc);
> >> +
> >> +		current_tick = mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
> >> +
> >> +		if (READ_ONCE(tsc_pg->tsc_sequence) == sequence)
> >> +			return current_tick;
> >
> > That sequence stuff lacks still a sensible explanation. It's fundamentally
> > different from the sequence counting we do in the kernel, so documentation
> > for it is really required.
> 
> Sure, do you think the following would do?

Yes

> diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
> index 4af10b4..886b600 100644
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c
> @@ -154,6 +154,22 @@ static notrace u64 vread_hvclock(int *mode)
>                 (const struct ms_hyperv_tsc_page *)&hvclock_page;
>         u64 sequence, scale, offset, current_tick, cur_tsc;
>  
> +       /*
> +        * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> +        * Top-Level Functional Specification ver. 3.0 and above. To get the
> +        * reference time we must do the following:
> +        * - READ ReferenceTscSequence
> +        *   A special '0' value indicates the time source is unreliable and we
> +        *   need to use something else. The currently published specification
> +        *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> +        *   instead of '0' as the special value, see commit c35b82ef0294.
> +        * - ReferenceTime =
> +        *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> +        * - READ ReferenceTscSequence again. In case its value has changed
> +        *   since our first reading we need to discard ReferenceTime and repeat
> +        *   the whole sequence as the hypervisor was updating the page in
> +        *   between.
> +        */
>         while (1) {
>                 sequence = READ_ONCE(tsc_pg->tsc_sequence);
>                 if (!sequence)
> 
> -- 
>   Vitaly
> 
