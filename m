From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Wed, 19 Sep 2018 00:46:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809190037570.1468__36898.4343055219$1537310728$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
	<863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1153053927-1537310814=:1468"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
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
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1153053927-1537310814=:1468
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 18 Sep 2018, Andy Lutomirski wrote:
> > On Sep 18, 2018, at 12:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> >> On Mon, 17 Sep 2018, John Stultz wrote:
> >>> On Mon, Sep 17, 2018 at 12:25 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >>> Also, I'm not entirely convinced that this "last" thing is needed at
> >>> all.  John, what's the scenario under which we need it?
> >> 
> >> So my memory is probably a bit foggy, but I recall that as we
> >> accelerated gettimeofday, we found that even on systems that claimed
> >> to have synced TSCs, they were actually just slightly out of sync.
> >> Enough that right after cycles_last had been updated, a read on
> >> another cpu could come in just behind cycles_last, resulting in a
> >> negative interval causing lots of havoc.
> >> 
> >> So the sanity check is needed to avoid that case.
> > 
> > Your memory serves you right. That's indeed observable on CPUs which
> > lack TSC_ADJUST.
> > 
> > @Andy: Welcome to the wonderful world of TSC.
> > 
> 
> Do we do better if we use signed arithmetic for the whole calculation?
> Then a small backwards movement would result in a small backwards result.
> Or we could offset everything so that we’d have to go back several
> hundred ms before we cross zero.

That would be probably the better solution as signed math would be
problematic when the resulting ns value becomes negative. As the delta is
really small, otherwise the TSC sync check would have caught it, the caller
should never be able to observe time going backwards.

I'll have a look into that. It needs some thought vs. the fractional part
of the base time, but it should be not rocket science to get that
correct. Famous last words...

Thanks,

	tglx



--8323329-1153053927-1537310814=:1468
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-1153053927-1537310814=:1468--
