From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Wed, 19 Sep 2018 01:16:46 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809190112020.1468__45585.9009795406$1537312505$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
	<863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
	<alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de>
	<439A3E73-E4FF-4D66-800E-5BEE58EDE8F6@amacapital.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1986204183-1537312607=:1468"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <439A3E73-E4FF-4D66-800E-5BEE58EDE8F6@amacapital.net>
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

--8323329-1986204183-1537312607=:1468
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 18 Sep 2018, Andy Lutomirski wrote:
> > On Sep 18, 2018, at 3:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 18 Sep 2018, Andy Lutomirski wrote:
> >> Do we do better if we use signed arithmetic for the whole calculation?
> >> Then a small backwards movement would result in a small backwards result.
> >> Or we could offset everything so that we’d have to go back several
> >> hundred ms before we cross zero.
> > 
> > That would be probably the better solution as signed math would be
> > problematic when the resulting ns value becomes negative. As the delta is
> > really small, otherwise the TSC sync check would have caught it, the caller
> > should never be able to observe time going backwards.
> > 
> > I'll have a look into that. It needs some thought vs. the fractional part
> > of the base time, but it should be not rocket science to get that
> > correct. Famous last words...
> > 
> 
> It’s also fiddly to tune. If you offset it too much, then the fancy
> divide-by-repeated-subtraction loop will hurt more than the comparison to
> last.

Not really. It's sufficient to offset it by at max. 1000 cycles or so. That
won't hurt the magic loop, but it will definitely cover that slight offset
case.

Thanks,

	tglx


--8323329-1986204183-1537312607=:1468
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-1986204183-1537312607=:1468--
