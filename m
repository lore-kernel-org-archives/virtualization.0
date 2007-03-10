From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Use of absolute timeouts for oneshot timers
Date: Sat, 10 Mar 2007 15:32:09 -0800
Message-ID: <45F33FF9.70406@goop.org>
References: <45F33697.4000000@goop.org> <1173568491.24738.1194.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751376AbXCJXcM@vger.kernel.org>
In-Reply-To: <1173568491.24738.1194.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: Dan Hecht <dhecht@vmware.com>, john stultz <johnstul@us.ibm.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner wrote:
> The clocksource is not used until the clocksource is installed. Also the
> periodic mode during boot, when the clock event device supports periodic
> mode, is not reading the time. It relies on the clock event device
> getting it straight.

Yes.  This could be one source of error, where I compute  the offset
hypervisor_time - ktime_get(), but ktime_get() may drift with respect to
hypervisor time while using a periodic jiffies timebase.

> Once we switch to NO_HZ or HIGHRES the clock event device is directly
> coupled to the clock event source.
>   
OK.  Erm, but not in the sense that you always choose the xen/hpet/lapic
clocksource+clockevent together; there's no direct linkage between the
two kinds of device.  But there's the coupling where the clocksource is
always used to directly measure the clockevent's behaviour.

> Once we switched over to the clocksource, everything should be in
> perfect sync.
>   

Assuming that the clocksource and the clockevent device have
close-enough timebases.

>> Or perhaps this is a property of the whole clock subsystem: that
>> clockevents must be paired with clocksources.  But its not obvious to me
>> that this enforced, or even acknowledged.
>>     
>
> It's simply enforced in NO_HZ, HIGHRES mode as we operate in absolute
> time, which is read back from the clocksource, even if we use a relative
> value for real hardware clock event devices to program the next event.
> We calculate the delta between the absolute event and now. So we never
> get an accumulating error.
>   

Right, but if the clocksource and the clockevent devices have a relative
drift, then using the clocksource to compute that we need a 500ns delay,
but the clockevent device ends delivering the oneshot event 750ns (or
250ns) later, then things are going to be locally upset, even if the
next time the clockevent oneshot is programmed it will take the
overshoot into account.  (Of course, you'd hope the drift would never
really be that bad, and 2^32 ns only gives you ~4s window to screw up).

> What problem are you observing ?
>   

Unexpected pauses during boot.  I think the real problem is that Xen
periodic timer events are not delivered unless the vcpu is actually
running (ie, they're specifically intended for timeslicing rather than
general periodic events).  Perhaps the real fix in this case is to just
remove the periodic feature flag.


    J
