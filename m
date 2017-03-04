From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/3] x86/hyperv: move TSC reading method to
	asm/mshyperv.h
Date: Sat, 4 Mar 2017 10:07:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703041004180.3756@nanos>
References: <20170303132142.25595-1-vkuznets@redhat.com>
	<20170303132142.25595-3-vkuznets@redhat.com>
	<20170303113123.16dc3b6e@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170303113123.16dc3b6e@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 3 Mar 2017, Stephen Hemminger wrote:
> static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
> {
> 	u64 scale, offset, cur_tsc;
> 	u32 start;
> 
> 	/*
> 	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> 	 * Top-Level Functional Specification ver. 3.0 and above. To get the
> 	 * reference time we must do the following:
> 	 * - READ ReferenceTscSequence
> 	 *   A special '0' value indicates the time source is unreliable and we
> 	 *   need to use something else. The currently published specification
> 	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> 	 *   instead of '0' as the special value, see commit c35b82ef0294.
> 	 * - ReferenceTime =
> 	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> 	 * - READ ReferenceTscSequence again. In case its value has changed
> 	 *   since our first reading we need to discard ReferenceTime and repeat
> 	 *   the whole sequence as the hypervisor was updating the page in
> 	 *   between.
> 	 */
> 	do {
> 		start = READ_ONCE(tsc_pg->tsc_sequence);
> 		smp_rmb();
> 
> 		if (unlikely(!start))
> 			return U64_MAX;
> 
> 		scale = tsc_pg->tsc_scale;
> 		offset = tsc_pg->tsc_offset;
> 
> 		/*
> 		 * Make sure we read sequence after we read all other values
> 		 * from TSC page.
> 		 */
> 		smp_rmb();
> 	} while (unlikely(READ_ONCE(tsc_pg->tsc_sequence != start)));
> 
> 	cur_tsc = rdtsc_ordered();

That's wrong. You need to read the TSC value together with the scale and
offset. That's needs to be "atomic". You can only do the mult/shift
outside.

> 	return mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
> }

Thanks,

	tglx
