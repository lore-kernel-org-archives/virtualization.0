From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read
 method
Date: Thu, 9 Feb 2017 18:08:22 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702091806400.3604__5262.76133391566$1486660197$gmane$org@nanos>
References: <20170209141052.18694-1-vkuznets@redhat.com>
	<20170209141052.18694-3-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170209141052.18694-3-vkuznets@redhat.com>
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

On Thu, 9 Feb 2017, Vitaly Kuznetsov wrote:
> +#ifdef CONFIG_HYPERV_TSCPAGE
> +static notrace u64 vread_hvclock(int *mode)
> +{
> +	const struct ms_hyperv_tsc_page *tsc_pg =
> +		(const struct ms_hyperv_tsc_page *)&hvclock_page;
> +	u64 sequence, scale, offset, current_tick, cur_tsc;
> +
> +	while (1) {
> +		sequence = READ_ONCE(tsc_pg->tsc_sequence);
> +		if (!sequence)
> +			break;
> +
> +		scale = READ_ONCE(tsc_pg->tsc_scale);
> +		offset = READ_ONCE(tsc_pg->tsc_offset);
> +		rdtscll(cur_tsc);
> +
> +		current_tick = mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
> +
> +		if (READ_ONCE(tsc_pg->tsc_sequence) == sequence)
> +			return current_tick;

That sequence stuff lacks still a sensible explanation. It's fundamentally
different from the sequence counting we do in the kernel, so documentation
for it is really required.

Thanks,

	tglx
