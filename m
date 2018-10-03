From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Wed, 3 Oct 2018 17:10:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1810031704480.23677__33606.0688518502$1538579308$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com>
	<4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net>
	<87murvdysd.fsf@vitty.brq.redhat.com>
	<8C316427-8BEC-4979-8AB2-5E385066BB6F@amacapital.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-391363870-1538579410=:23677"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8C316427-8BEC-4979-8AB2-5E385066BB6F@amacapital.net>
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
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-391363870-1538579410=:23677
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 3 Oct 2018, Andy Lutomirski wrote:
> > On Oct 3, 2018, at 5:01 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > Not all Hyper-V hosts support reenlightenment notifications (and, if I'm
> > not mistaken, you need to enable nesting for the VM to get the feature -
> > and most VMs don't have this) so I think we'll have to keep Hyper-V
> > vclock for the time being.
> > 
> But this does suggest that the correct way to pass a clock through to an
> L2 guest where L0 is HV is to make L1 use the “tsc” clock and L2 use
> kvmclock (or something newer and better).  This would require adding
> support for atomic frequency changes all the way through the timekeeping
> and arch code.
>
> John, tglx, would that be okay or crazy?

Not sure what you mean. I think I lost you somewhere on the way.

Thanks,

	tglx
--8323329-391363870-1538579410=:23677
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-391363870-1538579410=:23677--
