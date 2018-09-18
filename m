From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Tue, 18 Sep 2018 09:52:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809180948570.3558__31769.3150755533$1537257047$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: John Stultz <john.stultz@linaro.org>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 17 Sep 2018, John Stultz wrote:
> On Mon, Sep 17, 2018 at 12:25 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > Also, I'm not entirely convinced that this "last" thing is needed at
> > all.  John, what's the scenario under which we need it?
> 
> So my memory is probably a bit foggy, but I recall that as we
> accelerated gettimeofday, we found that even on systems that claimed
> to have synced TSCs, they were actually just slightly out of sync.
> Enough that right after cycles_last had been updated, a read on
> another cpu could come in just behind cycles_last, resulting in a
> negative interval causing lots of havoc.
> 
> So the sanity check is needed to avoid that case.

Your memory serves you right. That's indeed observable on CPUs which
lack TSC_ADJUST.

@Andy: Welcome to the wonderful world of TSC.

Thanks,

	tglx
