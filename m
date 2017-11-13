From: Quan Xu <quan.xu04@gmail.com>
Subject: [PATCH RFC v3 4/6] Documentation: Add three sysctls for smart idle
	poll
Date: Mon, 13 Nov 2017 18:47:44 +0800
Message-ID: <1510570064-6178-1-git-send-email-quan.xu0@gmail.com>
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
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Quan Xu <quan.xu0@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Quan Xu <quan.xu0@gmail.com>

To reduce the cost of poll, we introduce three sysctl to control the
poll time when running as a virtual machine with paravirt.

Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
Signed-off-by: Quan Xu <quan.xu0@gmail.com>
---
 Documentation/sysctl/kernel.txt |   35 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/paravirt.c      |    4 ++++
 include/linux/kernel.h          |    6 ++++++
 kernel/sysctl.c                 |   34 ++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 694968c..30c25fb 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -714,6 +714,41 @@ kernel tries to allocate a number starting from this one.
 
 ==============================================================
 
+paravirt_poll_grow: (X86 only)
+
+Multiplied value to increase the poll time. This is expected to take
+effect only when running as a virtual machine with CONFIG_PARAVIRT
+enabled. This can't bring any benifit on bare mental even with
+CONFIG_PARAVIRT enabled.
+
+By default this value is 2. Possible values to set are in range {2..16}.
+
+==============================================================
+
+paravirt_poll_shrink: (X86 only)
+
+Divided value to reduce the poll time. This is expected to take effect
+only when running as a virtual machine with CONFIG_PARAVIRT enabled.
+This can't bring any benifit on bare mental even with CONFIG_PARAVIRT
+enabled.
+
+By default this value is 2. Possible values to set are in range {2..16}.
+
+==============================================================
+
+paravirt_poll_threshold_ns: (X86 only)
+
+Controls the maximum poll time before entering real idle path. This is
+expected to take effect only when running as a virtual machine with
+CONFIG_PARAVIRT enabled. This can't bring any benifit on bare mental
+even with CONFIG_PARAVIRT enabled.
+
+By default, this value is 0 means not to poll. Possible values to set
+are in range {0..500000}. Change the value to non-zero if running
+latency-bound workloads in a virtual machine.
+
+==============================================================
+
 powersave-nap: (PPC only)
 
 If set, Linux-PPC will use the 'nap' mode of powersaving,
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 67cab22..28c74ca 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -317,6 +317,10 @@ struct pv_idle_ops pv_idle_ops = {
 	.poll = paravirt_nop,
 };
 
+unsigned long paravirt_poll_threshold_ns;
+unsigned int paravirt_poll_shrink = 2;
+unsigned int paravirt_poll_grow = 2;
+
 __visible struct pv_irq_ops pv_irq_ops = {
 	.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
 	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4b484ab..0f46846 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -491,6 +491,12 @@ extern __scanf(2, 0)
 
 extern bool crash_kexec_post_notifiers;
 
+#ifdef CONFIG_PARAVIRT
+extern unsigned long paravirt_poll_threshold_ns;
+extern unsigned int paravirt_poll_shrink;
+extern unsigned int paravirt_poll_grow;
+#endif
+
 /*
  * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
  * holds a CPU number which is executing panic() currently. A value of
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d9c31bc..9f194dc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -135,6 +135,11 @@
 static int six_hundred_forty_kb = 640 * 1024;
 #endif
 
+#ifdef CONFIG_PARAVIRT
+static int sixteen = 16;
+static int five_hundred_thousand = 500000;
+#endif
+
 /* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
 static unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 
@@ -1226,6 +1231,35 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.extra2		= &one,
 	},
 #endif
+#ifdef CONFIG_PARAVIRT
+	{
+		.procname       = "paravirt_halt_poll_threshold",
+		.data           = &paravirt_poll_threshold_ns,
+		.maxlen         = sizeof(unsigned long),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = &zero,
+		.extra2         = &five_hundred_thousand,
+	},
+	{
+		.procname       = "paravirt_halt_poll_grow",
+		.data           = &paravirt_poll_grow,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = &two,
+		.extra2         = &sixteen,
+	},
+	{
+		.procname       = "paravirt_halt_poll_shrink",
+		.data           = &paravirt_poll_shrink,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = &two,
+		.extra2         = &sixteen,
+	},
+#endif
 	{ }
 };
 
-- 
1.7.1
