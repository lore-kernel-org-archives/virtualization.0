From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 0/2] softlockup watchdog improvements
Date: Mon, 26 Mar 2007 22:38:16 -0700
Message-ID: <20070327053816.881735237@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Here's couple of patches to improve the softlockup watchdog.

The first changes the softlockup timer from using jiffies to sched_clock()
as a timebase.  Xen and VMI implement sched_clock() as counting unstolen
time, so time stolen by the hypervisor won't cause the watchdog to bite.

The second adds per-cpu enable flags for the watchdog timer.  This allows
the timer to be disabled when the CPU goes into a (potentially unbounded)
tickless sleep.

I know this conflicts with
fix-bogus-softlockup-warning-with-sysrq-t.patch in -mm2.  I think that
patch incorrectly changes the behaviour of the softlockup watchdog,
and a better solution is to temporarily disable the watchdog while
doing something known to be cpu-consuming, like a long sysreq output.

	J
-- =
