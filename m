From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 0/4] Revised softlockup watchdog improvement patches
Date: Tue, 27 Mar 2007 14:49:19 -0700
Message-ID: <20070327214919.800272641@goop.org>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Prarit Bhargava <prarit@redhat.com>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Ingo,

This series of patches implements a number of improvements to the
softlockup watchdog and its users.

They are:

1. Make the watchdog ignore stolen time

When running under a hypervisor, the kernel may lose an arbitrary amount
of time as "stolen time".  This may cause the softlockup watchdog to
trigger spruiously.  Xen and VMI implement sched_clock() as measuring
unstolen time, so use that as the timebase for the softlockup watchdog.
This also removes a dependency on jiffies.

2. Add a per-cpu enable flag for the watchdog

When the scheduler disables ticks for a specific CPU, this allows the
watchdog to be disabled as well.  This avoids spurious watchdog errors
if a CPU has been tickless for a long time.  The existing tick-sched.c
code tried to address this by periodically touching the watchdog, but
this seems more direct.

3. Use the per-cpu enable flags to temporarily disable the watchdog

Some drivers perform long operations which will cause the watchdog to
time out.  If we know we're about to start such an operation, disable
the watchdog timer for the interim.  This is more straightforward than
trying to periodically tickle the watchdog timer during the operation, and
safer than just doing it once at the start and hoping there's enough time.

4. Add a global disable flag

Sometimes a long operation will affect all CPUs' ability to tickle the
watchdog timer.  An obvious example is suspend/resume, but it can also
happen while generating lots of sysrq output, or other specialized
operations.  Add global enable/disable calls to deal with these case.

-- =
