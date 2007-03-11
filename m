From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Use of absolute timeouts for oneshot timers
Date: Sat, 10 Mar 2007 16:42:48 -0800
Message-ID: <45F35088.7020607@goop.org>
References: <45F33697.4000000@goop.org>
	<1173568491.24738.1194.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173568491.24738.1194.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: tglx@linutronix.de
Cc: john stultz <johnstul@us.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner wrote:
> It's simply enforced in NO_HZ, HIGHRES mode as we operate in absolute
> time, which is read back from the clocksource, even if we use a relative
> value for real hardware clock event devices to program the next event.
> We calculate the delta between the absolute event and now. So we never
> get an accumulating error.
>
> What problem are you observing ?

Actually, two things.  There was the unexpected pauses during boot,
which is trivially fixable by not using the Xen periodic timer, and
using the single-shot fallback.

But I'm making the more general observation that if you use an absolute
rather than relative time to set the single-shot timeout, then you have
to deal with a long-term cumulative drift between the kernel's monotonic
time and the hypervisor's monotonic time.  This can happen even if your
clocksource is derived directly from the hypervisor monotonic time,
because running ntp will warp the kernel's time, and so it will drift
with respect to the hypervisor clock.  You can only avoid this by 1) not
allowing adjtime, or 2) making those same adjtime warps to the
hypervisor time.  Neither of these is a good general solution.

Therefore, the only useful way to set a single-shot timer is by using
relative rather than absolute time, and making sure the delta not too
large.  The guest and hypervisor may (and in general, will) have
drifting clocks, but the error will never be too large to deal with.

    J
