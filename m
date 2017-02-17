From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/3] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Fri, 17 Feb 2017 18:55:02 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702171853480.3536__4015.06683924726$1487354124$gmane$org@nanos>
References: <20170214124408.25931-1-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702141552360.3635@nanos>
	<87a89o22ml.fsf@vitty.brq.redhat.com>
	<CALCETrUNdemXG7GnehNus-EW2FDuTzB8HKW_3HUjhPt9ZNf45w@mail.gmail.com>
	<87y3x7zh6h.fsf@vitty.brq.redhat.com>
	<alpine.DEB.2.20.1702161832020.3543@nanos>
	<87tw7txgx9.fsf@vitty.brq.redhat.com>
	<CALCETrXB8CufQujLAg6bbq=DGAMUE293CF7L4Kp+mCSoNWyuBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrXB8CufQujLAg6bbq=DGAMUE293CF7L4Kp+mCSoNWyuBg@mail.gmail.com>
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 17 Feb 2017, Andy Lutomirski wrote:
> On Fri, Feb 17, 2017 at 2:14 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > Not only. As far as I understand (and I *think* K. Y. pointed this out)
> > when VM is migrating to another host TSC page clocksource is disabled for
> > extended period of time so we're better off reading from MSR than
> > looping here. With regards to VDSO this means reverting to doing normal
> > syscall.
> 
> That's a crappy design.  The guest really ought to be able to
> distinguish "busy, try again" from "bail and use MSR".
> 
> Thomas, I can see valid reasons why the hypervisor might want to
> temporarily disable shared page-based timing, but I think it's silly
> that it's conflated with indicating "retry".

It's beyond silly if that's the case.

> But if this is indeed the ABI, we're stuck with it.

No argument.
