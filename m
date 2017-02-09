From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method
Date: Thu, 9 Feb 2017 15:15:06 -0800
Message-ID: <20170209151506.2c0a555f__23450.5936889493$1486682120$gmane$org@xeon-e3>
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

On Thu, 9 Feb 2017 14:55:50 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> On Thu, Feb 9, 2017 at 12:45 PM, KY Srinivasan <kys@microsoft.com> wrote:
> >
> >  
> >> -----Original Message-----
> >> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> >> Sent: Thursday, February 9, 2017 9:08 AM
> >> To: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Cc: x86@kernel.org; Andy Lutomirski <luto@amacapital.net>; Ingo Molnar
> >> <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; KY Srinivasan
> >> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> >> Hemminger <sthemmin@microsoft.com>; Dexuan Cui
> >> <decui@microsoft.com>; linux-kernel@vger.kernel.org;
> >> devel@linuxdriverproject.org; virtualization@lists.linux-foundation.org
> >> Subject: Re: [PATCH 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read
> >> method
> >>
> >> On Thu, 9 Feb 2017, Vitaly Kuznetsov wrote:  
> >> > +#ifdef CONFIG_HYPERV_TSCPAGE
> >> > +static notrace u64 vread_hvclock(int *mode)
> >> > +{
> >> > +   const struct ms_hyperv_tsc_page *tsc_pg =
> >> > +           (const struct ms_hyperv_tsc_page *)&hvclock_page;
> >> > +   u64 sequence, scale, offset, current_tick, cur_tsc;
> >> > +
> >> > +   while (1) {
> >> > +           sequence = READ_ONCE(tsc_pg->tsc_sequence);
> >> > +           if (!sequence)
> >> > +                   break;
> >> > +
> >> > +           scale = READ_ONCE(tsc_pg->tsc_scale);
> >> > +           offset = READ_ONCE(tsc_pg->tsc_offset);
> >> > +           rdtscll(cur_tsc);
> >> > +
> >> > +           current_tick = mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
> >> > +
> >> > +           if (READ_ONCE(tsc_pg->tsc_sequence) == sequence)
> >> > +                   return current_tick;  
> >>
> >> That sequence stuff lacks still a sensible explanation. It's fundamentally
> >> different from the sequence counting we do in the kernel, so documentation
> >> for it is really required.  
> >
> > The host is updating multiple fields in this shared TSC page and the sequence number is
> > used to ensure that the guest sees a consistent set values published. If I remember
> > correctly, Xen has a similar mechanism.  
> 
> So what's the actual protocol?  When the hypervisor updates the page,
> does it freeze all guest cpus?  If not, how does it maintain
> atomicity?

The protocol looks a lot like Linux seqlock, but it has an extra protection
which is missing here.

The host needs to update sequence number twice in order to guarantee ordering.
Otherwise it is possible that Host and guest can race.

					Host
						Write offset
						Write scale
						Set tsc_sequence = N
          Guest
		read sequence = N
		Read scale
						Write scale
						Write offset
		
		Read Offset
		Check sequence == N
						Set tsc_sequence = N +1

Look like the current host side protocol is wrong.

The solution that Andi Kleen invented, and I used in seqlock was for the writer to update
sequence at start and end of transaction. If sequence number is odd, then the reader knows
it is looking at stale data.
					Host
						Write offset
						Write scale
						Set tsc_sequence = N (end of transaction)
          Guest
		read sequence = N
		Spin until sequence is even (N is even)
		Read scale
						Set tsc_sequence += 1
						Write scale
						Write offset
		
		Read Offset
		Check sequence == N? (fails is N + 1)
						Set tsc_sequence += 1 (end of transaction)
		read sequence = N+2
		Spin until sequence is even (ie N +2)
		Read scale	
		Read Offset
		Check sequence == N +2? (yes ok).

Also it is faster to just read scale and offset with this loop and save
the reading of TSC and doing multiply until after scale/offset has been acquired.

	
