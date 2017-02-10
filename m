From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method
Date: Fri, 10 Feb 2017 13:15:00 +0100
Message-ID: <87h942qm2j.fsf@vitty.brq.redhat.com>
References: <20170209141052.18694-1-vkuznets@redhat.com>
	<20170209141052.18694-3-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702091806400.3604@nanos>
	<DM5PR03MB24903D71121176FFAED30E33A0450@DM5PR03MB2490.namprd03.prod.outlook.com>
	<CALCETrXptSZJMH4yBqn=xPeJHDPZNnq7io8v75=spT6q1RTpdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrXptSZJMH4yBqn=xPeJHDPZNnq7io8v75=spT6q1RTpdA@mail.gmail.com>
	(Andy Lutomirski's message of "Thu, 9 Feb 2017 14:55:50 -0800")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Andy Lutomirski <luto@amacapital.net> writes:

> On Thu, Feb 9, 2017 at 12:45 PM, KY Srinivasan <kys@microsoft.com> wrote:
>>
>>
>>> -----Original Message-----
>>> From: Thomas Gleixner [mailto:tglx@linutronix.de]
>>> Sent: Thursday, February 9, 2017 9:08 AM
>>> To: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> Cc: x86@kernel.org; Andy Lutomirski <luto@amacapital.net>; Ingo Molnar
>>> <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; KY Srinivasan
>>> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
>>> Hemminger <sthemmin@microsoft.com>; Dexuan Cui
>>> <decui@microsoft.com>; linux-kernel@vger.kernel.org;
>>> devel@linuxdriverproject.org; virtualization@lists.linux-foundation.org
>>> Subject: Re: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read
>>> method
>>>
>>> On Thu, 9 Feb 2017, Vitaly Kuznetsov wrote:
>>> > +#ifdef CONFIG_HYPERV_TSCPAGE
>>> > +static notrace u64 vread_hvclock(int *mode)
>>> > +{
>>> > +   const struct ms_hyperv_tsc_page *tsc_pg =
>>> > +           (const struct ms_hyperv_tsc_page *)&hvclock_page;
>>> > +   u64 sequence, scale, offset, current_tick, cur_tsc;
>>> > +
>>> > +   while (1) {
>>> > +           sequence = READ_ONCE(tsc_pg->tsc_sequence);
>>> > +           if (!sequence)
>>> > +                   break;
>>> > +
>>> > +           scale = READ_ONCE(tsc_pg->tsc_scale);
>>> > +           offset = READ_ONCE(tsc_pg->tsc_offset);
>>> > +           rdtscll(cur_tsc);
>>> > +
>>> > +           current_tick = mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
>>> > +
>>> > +           if (READ_ONCE(tsc_pg->tsc_sequence) == sequence)
>>> > +                   return current_tick;
>>>
>>> That sequence stuff lacks still a sensible explanation. It's fundamentally
>>> different from the sequence counting we do in the kernel, so documentation
>>> for it is really required.
>>
>> The host is updating multiple fields in this shared TSC page and the sequence number is
>> used to ensure that the guest sees a consistent set values published. If I remember
>> correctly, Xen has a similar mechanism.
>
> So what's the actual protocol?  When the hypervisor updates the page,
> does it freeze all guest cpus?  If not, how does it maintain
> atomicity?

I don't really know how it is implemented server-side but I *think* that
freezing all CPUs is only required when we want to update *both*
ReferenceTscScale and ReferenceTscOffset at the same time (as Hyper-V is
64-bit only so it can always atomically update 64-bit values)...

-- 
  Vitaly
