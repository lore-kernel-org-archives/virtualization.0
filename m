From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 00/11] x86/vdso: Cleanups,
	simmplifications and CLOCK_TAI support
Date: Mon, 17 Sep 2018 14:45:33 +0200
Message-ID: <20180917124533.329334911__6229.36180229789$1537189681$gmane$org@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
implementation, which extended the clockid switch case and added yet
another slightly different copy of the same code.

Especially the extended switch case is problematic as the compiler tends to
generate a jump table which then requires to use retpolines. If jump tables
are disabled it adds yet another conditional to the existing maze.

This series takes a different approach by consolidating the almost
identical functions into one implementation for high resolution clocks and
one for the coarse grained clock ids by storing the base data for each
clock id in an array which is indexed by the clock id.

This completely eliminates the switch case and allows further
simplifications of the code base, which at the end all together gain a few
cycles performance or at least stay on par with todays code. The resulting
performance depends heavily on the micro architecture and the compiler.

Changes vs. V1:

  - Fix the VCLOCK_MAX sanity check
  - Remove the magic clock masking and extend the storage array

Thanks,

        tglx

8<-------------------
 arch/x86/Kconfig                        |    1 
 arch/x86/entry/vdso/vclock_gettime.c    |  199 ++++++++------------------------
 arch/x86/entry/vsyscall/vsyscall_gtod.c |   55 ++++----
 arch/x86/include/asm/vgtod.h            |   42 +++---
 arch/x86/kernel/time.c                  |   22 +++
 include/linux/clocksource.h             |    5 
 kernel/time/Kconfig                     |    4 
 kernel/time/clocksource.c               |    2 
 8 files changed, 140 insertions(+), 190 deletions(-)
