From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 03/11] x86/vdso: Enforce 64bit clocksource
Date: Mon, 17 Sep 2018 14:45:36 +0200
Message-ID: <20180917130707.151963007__32138.882604386$1537189704$gmane$org@linutronix.de>
References: <20180917124533.329334911@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=x86-vdso--Enforce-64bit-clocksource.patch
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

All VDSO clock sources are TSC based and use CLOCKSOURCE_MASK(64). There is
no point in masking with all FF. Get rid of it and enforce the mask in the
sanity checker.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |    2 +-
 arch/x86/kernel/time.c               |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -199,7 +199,7 @@ notrace static inline u64 vgetsns(int *m
 #endif
 	else
 		return 0;
-	v = (cycles - gtod->cycle_last) & gtod->mask;
+	v = cycles - gtod->cycle_last;
 	return v * gtod->mult;
 }
 
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -120,4 +120,10 @@ void clocksource_arch_init(struct clocks
 			cs->name, cs->archdata.vclock_mode);
 		cs->archdata.vclock_mode = VCLOCK_NONE;
 	}
+
+	if (cs->mask != CLOCKSOURCE_MASK(64)) {
+		pr_warn("clocksource %s registered with invalid mask %016llx. Disabling vclock.\n",
+			cs->name, cs->mask);
+		cs->archdata.vclock_mode = VCLOCK_NONE;
+	}
 }
