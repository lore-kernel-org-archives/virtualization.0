From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 2/3] x86/hyperv: move TSC reading method to
	asm/mshyperv.h
Date: Fri, 3 Mar 2017 11:31:23 -0800
Message-ID: <20170303113123.16dc3b6e__33160.8305605643$1488569503$gmane$org@xeon-e3>
References: <20170303132142.25595-1-vkuznets@redhat.com>
	<20170303132142.25595-3-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170303132142.25595-3-vkuznets@redhat.com>
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Minor coding comments

> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index d324dce..4ff25436 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -178,6 +178,56 @@ void hyperv_cleanup(void);
>  #endif
>  #ifdef CONFIG_HYPERV_TSCPAGE
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> +static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
> +{
> +	u64 scale, offset, current_tick, cur_tsc;
> +	u32 sequence;
> +
> +	/*
> +	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> +	 * Top-Level Functional Specification ver. 3.0 and above. To get the
> +	 * reference time we must do the following:
> +	 * - READ ReferenceTscSequence
> +	 *   A special '0' value indicates the time source is unreliable and we
> +	 *   need to use something else. The currently published specification
> +	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> +	 *   instead of '0' as the special value, see commit c35b82ef0294.
> +	 * - ReferenceTime =
> +	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> +	 * - READ ReferenceTscSequence again. In case its value has changed
> +	 *   since our first reading we need to discard ReferenceTime and repeat
> +	 *   the whole sequence as the hypervisor was updating the page in
> +	 *   between.
> +	 */
> +	while (1) {
> +		sequence = READ_ONCE(tsc_pg->tsc_sequence);
> +		if (!sequence)
> +			break;

It would be clearer to just return U64_MAX here (and not fall out)
since this is only case here. Also since this failure only occurs if host
clock is not available, probably should be unlikely.

> +		/*
> +		 * Make sure we read sequence before we read other values from
> +		 * TSC page.
> +		 */
> +		smp_rmb();
> +
> +		scale = READ_ONCE(tsc_pg->tsc_scale);
> +		offset = READ_ONCE(tsc_pg->tsc_offset);
> +		cur_tsc = rdtsc_ordered();

Since you already have smp_ barriers and rdtsc_ordered is a barrier,
the compiler barriers (READ_ONCE()) shouldn't be necessary.

> +
> +		current_tick = mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
> +
> +		/*
> +		 * Make sure we read sequence after we read all other values
> +		 * from TSC page.
> +		 */
> +		smp_rmb();
> +
> +		if (READ_ONCE(tsc_pg->tsc_sequence) == sequence)
> +			return current_tick;
> +	}

Why not make do { } while out of this.

	do {
...
	} while (unlikely(READ_ONCE(tsc_pg->tsc_sequence) != sequence);
	return current_tick;

Also don't need to calculate tick value until have good data. As in:

static inline u32 hv_clock_sequence(const struct ms_hyperv_tsc_page *tsc_pg)
{
	u32 sequence =
	return sequence;
}

static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
{
	u64 scale, offset, cur_tsc;
	u32 start;

	/*
	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
	 * Top-Level Functional Specification ver. 3.0 and above. To get the
	 * reference time we must do the following:
	 * - READ ReferenceTscSequence
	 *   A special '0' value indicates the time source is unreliable and we
	 *   need to use something else. The currently published specification
	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
	 *   instead of '0' as the special value, see commit c35b82ef0294.
	 * - ReferenceTime =
	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
	 * - READ ReferenceTscSequence again. In case its value has changed
	 *   since our first reading we need to discard ReferenceTime and repeat
	 *   the whole sequence as the hypervisor was updating the page in
	 *   between.
	 */
	do {
		start = READ_ONCE(tsc_pg->tsc_sequence);
		smp_rmb();

		if (unlikely(!start))
			return U64_MAX;

		scale = tsc_pg->tsc_scale;
		offset = tsc_pg->tsc_offset;

		/*
		 * Make sure we read sequence after we read all other values
		 * from TSC page.
		 */
		smp_rmb();
	} while (unlikely(READ_ONCE(tsc_pg->tsc_sequence != start)));

	cur_tsc = rdtsc_ordered();
	return mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
}
