From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Wed, 19 Sep 2018 15:29:30 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809191523010.18945__44859.4117806808$1537363675$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
	<863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
	<alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de>
	<06e91c26-756f-f236-0af2-327e520c3065@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1406624157-1537363775=:18945"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <06e91c26-756f-f236-0af2-327e520c3065@rasmusvillemoes.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1406624157-1537363775=:18945
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 19 Sep 2018, Rasmus Villemoes wrote:
> On 2018-09-19 00:46, Thomas Gleixner wrote:
> > On Tue, 18 Sep 2018, Andy Lutomirski wrote:
> >>>
> >>
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
> 
> Does the sentinel need to be U64_MAX? What if vgetcyc and its minions
> returned gtod->cycle_last-1 (for some value of 1), and the caller just
> does "if ((s64)cycles - (s64)last < 0) return fallback; ns +=
> (cycles-last)* ...". That should just be a "sub ; js ; ". It's an extra
> load of ->cycle_last, but only on the path where we're heading for the
> fallback anyway. The value of 1 can be adjusted so that in the "js"
> path, we could detect and accept an rdtsc_ordered() call that's just a
> few 10s of cycles behind last and treat that as 0 and continue back on
> the normal path. But maybe it's hard to get gcc to generate the expected
> code.

I played around with a lot of variants and GCC generates all kinds of
interesting ASM. And at some point optimizing that math code is not buying
anything because the LFENCE before RDTSC is dominating all of it.

Thanks,

	tglx
--8323329-1406624157-1537363775=:18945
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-1406624157-1537363775=:18945--
