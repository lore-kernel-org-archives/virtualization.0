From: Yang Zhang <yang.zhang.wz@gmail.com>
Subject: [RFC PATCH v2 5/7] Documentation: Add three sysctls for smart idle
	poll
Date: Tue, 29 Aug 2017 11:46:39 +0000
Message-ID: <1504007201-12904-6-git-send-email-yang.zhang.wz__47337.1471780867$1504007322$gmane$org@gmail.com>
References: <1504007201-12904-1-git-send-email-yang.zhang.wz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1504007201-12904-1-git-send-email-yang.zhang.wz@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Jeremy Fitzhardinge <jeremy@goop.org>, kvm@vger.kernel.org, rkrcmar@redhat.com, peterz@infradead.org, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, wanpeng.li@hotmail.com, Jessica Yu <jeyu@redhat.com>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, zijun_hu <zijun_hu@htc.com>, Petr Mladek <pmladek@suse.com>, Kees Cook <keescook@chromium.org>, Johannes Berg <johannes.berg@intel.com>, Chris Wright <chrisw@sous-sol.org>, Ian Abbott <abbotti@mev.co.uk>, Josh Poimboeuf <jpoimboe@redhat.com>, dmatlack@google.com, tglx@linutronix.de, Mauro Carvalho Chehab <mchehab@kernel.org>, Quan Xu <quan.xu0@gmail.com>, linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

To reduce the cost of poll, we introduce three sysctl to control the
poll time.

Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
Signed-off-by: Quan Xu <quan.xu0@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: zijun_hu <zijun_hu@htc.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/sysctl/kernel.txt | 25 +++++++++++++++++++++++++
 arch/x86/kernel/paravirt.c      |  4 ++++
 include/linux/kernel.h          |  6 ++++++
 kernel/sysctl.c                 | 23 +++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index bac23c1..67447b8 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -63,6 +63,9 @@ show up in /proc/sys/kernel:
 - perf_event_max_stack
 - perf_event_max_contexts_per_stack
 - pid_max
+- poll_grow                   [ X86 only ]
+- poll_shrink                 [ X86 only ]
+- poll_threshold_ns           [ X86 only ]
 - powersave-nap               [ PPC only ]
 - printk
 - printk_delay
@@ -702,6 +705,28 @@ kernel tries to allocate a number starting from this one.
 
 ==============================================================
 
+poll_grow: (X86 only)
+
+This parameter is multiplied in the grow_poll_ns() to increase the poll time.
+By default, the values is 2.
+
+==============================================================
+poll_shrink: (X86 only)
+
+This parameter is divided in the shrink_poll_ns() to reduce the poll time.
+By default, the values is 2.
+
+==============================================================
+poll_threshold_ns: (X86 only)
+
+This parameter controls the max poll time before entering real idle path.
+This parameter is expected to take effect only when running inside a VM.
+It would make no sense to turn on it in bare mental.
+By default, the values is 0 means don't poll. It is recommended to change
+the value to non-zero if running latency-bound workloads inside VM.
+
+==============================================================
+
 powersave-nap: (PPC only)
 
 If set, Linux-PPC will use the 'nap' mode of powersaving,
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a11b2c2..0b92f8f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -318,6 +318,10 @@ struct pv_idle_ops pv_idle_ops = {
 	.update = paravirt_nop,
 };
 
+unsigned long poll_threshold_ns;
+unsigned int poll_shrink = 2;
+unsigned int poll_grow = 2;
+
 __visible struct pv_irq_ops pv_irq_ops = {
 	.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
 	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index bd6d96c..6cb2820 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -462,6 +462,12 @@ extern __scanf(2, 0)
 
 extern bool crash_kexec_post_notifiers;
 
+#ifdef CONFIG_PARAVIRT
+extern unsigned long poll_threshold_ns;
+extern unsigned int poll_shrink;
+extern unsigned int poll_grow;
+#endif
+
 /*
  * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
  * holds a CPU number which is executing panic() currently. A value of
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6648fbb..9b86a8f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1229,6 +1229,29 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.extra2		= &one,
 	},
 #endif
+#ifdef CONFIG_PARAVIRT
+	{
+		.procname       = "halt_poll_threshold",
+		.data           = &poll_threshold_ns,
+		.maxlen         = sizeof(unsigned long),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{
+		.procname       = "halt_poll_grow",
+		.data           = &poll_grow,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{
+		.procname       = "halt_poll_shrink",
+		.data           = &poll_shrink,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+#endif
 	{ }
 };
 
-- 
1.8.3.1
