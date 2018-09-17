From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 01/11] clocksource: Provide clocksource_arch_init()
Date: Mon, 17 Sep 2018 14:45:34 +0200
Message-ID: <20180917130706.973042587__34256.3107180924$1537189640$gmane$org@linutronix.de>
References: <20180917124533.329334911@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=clocksource--Provide-clocksource_arch_init--.patch
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

Architectures have extra archdata in the clocksource, e.g. for VDSO
support. There are no sanity checks or general initializations for this
available. Add support for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/clocksource.h |    5 +++++
 kernel/time/Kconfig         |    4 ++++
 kernel/time/clocksource.c   |    2 ++
 3 files changed, 11 insertions(+)

--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -241,6 +241,11 @@ static inline void __clocksource_update_
 	__clocksource_update_freq_scale(cs, 1000, khz);
 }
 
+#ifdef CONFIG_ARCH_CLOCKSOURCE_INIT
+extern void clocksource_arch_init(struct clocksource *cs);
+#else
+static inline void clocksource_arch_init(struct clocksource *cs) { }
+#endif
 
 extern int timekeeping_notify(struct clocksource *clock);
 
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -12,6 +12,10 @@ config CLOCKSOURCE_WATCHDOG
 config ARCH_CLOCKSOURCE_DATA
 	bool
 
+# Architecture has extra clocksource init called from registration
+config ARCH_CLOCKSOURCE_INIT
+	bool
+
 # Clocksources require validation of the clocksource against the last
 # cycle update - x86/TSC misfeature
 config CLOCKSOURCE_VALIDATE_LAST_CYCLE
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -937,6 +937,8 @@ int __clocksource_register_scale(struct
 {
 	unsigned long flags;
 
+	clocksource_arch_init(cs);
+
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);
