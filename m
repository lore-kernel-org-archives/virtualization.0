From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: [PATCH 1/4] Introduce a new field "guest" in cpustat
Date: Mon, 20 Aug 2007 15:13:40 +0200
Message-ID: <46C99384.8020904__24987.940505571$1187617607$gmane$org@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010501080606030903020100"
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------010501080606030903020100
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1

[PATCH 1/4] as recent CPUs introduce a third running state, after "user" and
"system", we need a new field, "guest", in cpustat to store the time used by
the CPU to run virtual CPU. Modify /proc/stat to display this new field.

Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>
-- 
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth

--------------010501080606030903020100
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="proc_stat_guest"
Content-Disposition: inline;
 filename="proc_stat_guest"

Index: kvm/fs/proc/proc_misc.c
===================================================================
--- kvm.orig/fs/proc/proc_misc.c	2007-08-20 14:17:13.000000000 +0200
+++ kvm/fs/proc/proc_misc.c	2007-08-20 14:17:16.000000000 +0200
@@ -443,6 +443,9 @@ static int show_stat(struct seq_file *p,
 	int i;
 	unsigned long jif;
 	cputime64_t user, nice, system, idle, iowait, irq, softirq, steal;
+#ifdef CONFIG_GUEST_ACCOUNTING
+	cputime64_t guest;
+#endif
 	u64 sum = 0;
 	struct timespec boottime;
 	unsigned int *per_irq_sum;
@@ -453,6 +456,9 @@ static int show_stat(struct seq_file *p,
 
 	user = nice = system = idle = iowait =
 		irq = softirq = steal = cputime64_zero;
+#ifdef CONFIG_GUEST_ACCOUNTING
+	guest = cputime64_zero;
+#endif
 	getboottime(&boottime);
 	jif = boottime.tv_sec;
 
@@ -467,6 +473,9 @@ static int show_stat(struct seq_file *p,
 		irq = cputime64_add(irq, kstat_cpu(i).cpustat.irq);
 		softirq = cputime64_add(softirq, kstat_cpu(i).cpustat.softirq);
 		steal = cputime64_add(steal, kstat_cpu(i).cpustat.steal);
+#ifdef CONFIG_GUEST_ACCOUNTING
+		guest = cputime64_add(guest, kstat_cpu(i).cpustat.guest);
+#endif
 		for (j = 0; j < NR_IRQS; j++) {
 			unsigned int temp = kstat_cpu(i).irqs[j];
 			sum += temp;
@@ -474,6 +483,18 @@ static int show_stat(struct seq_file *p,
 		}
 	}
 
+#ifdef CONFIG_GUEST_ACCOUNTING
+	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu %llu %llu\n",
+		(unsigned long long)cputime64_to_clock_t(user),
+		(unsigned long long)cputime64_to_clock_t(nice),
+		(unsigned long long)cputime64_to_clock_t(system),
+		(unsigned long long)cputime64_to_clock_t(idle),
+		(unsigned long long)cputime64_to_clock_t(iowait),
+		(unsigned long long)cputime64_to_clock_t(irq),
+		(unsigned long long)cputime64_to_clock_t(softirq),
+		(unsigned long long)cputime64_to_clock_t(steal),
+		(unsigned long long)cputime64_to_clock_t(guest));
+#else
 	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu %llu\n",
 		(unsigned long long)cputime64_to_clock_t(user),
 		(unsigned long long)cputime64_to_clock_t(nice),
@@ -483,6 +504,7 @@ static int show_stat(struct seq_file *p,
 		(unsigned long long)cputime64_to_clock_t(irq),
 		(unsigned long long)cputime64_to_clock_t(softirq),
 		(unsigned long long)cputime64_to_clock_t(steal));
+#endif
 	for_each_online_cpu(i) {
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
@@ -494,6 +516,21 @@ static int show_stat(struct seq_file *p,
 		irq = kstat_cpu(i).cpustat.irq;
 		softirq = kstat_cpu(i).cpustat.softirq;
 		steal = kstat_cpu(i).cpustat.steal;
+#ifdef CONFIG_GUEST_ACCOUNTING
+		guest = kstat_cpu(i).cpustat.guest;
+		seq_printf(p,
+			"cpu%d %llu %llu %llu %llu %llu %llu %llu %llu %llu\n",
+			i,
+			(unsigned long long)cputime64_to_clock_t(user),
+			(unsigned long long)cputime64_to_clock_t(nice),
+			(unsigned long long)cputime64_to_clock_t(system),
+			(unsigned long long)cputime64_to_clock_t(idle),
+			(unsigned long long)cputime64_to_clock_t(iowait),
+			(unsigned long long)cputime64_to_clock_t(irq),
+			(unsigned long long)cputime64_to_clock_t(softirq),
+			(unsigned long long)cputime64_to_clock_t(steal),
+			(unsigned long long)cputime64_to_clock_t(guest));
+#else
 		seq_printf(p, "cpu%d %llu %llu %llu %llu %llu %llu %llu %llu\n",
 			i,
 			(unsigned long long)cputime64_to_clock_t(user),
@@ -504,6 +541,7 @@ static int show_stat(struct seq_file *p,
 			(unsigned long long)cputime64_to_clock_t(irq),
 			(unsigned long long)cputime64_to_clock_t(softirq),
 			(unsigned long long)cputime64_to_clock_t(steal));
+#endif
 	}
 	seq_printf(p, "intr %llu", (unsigned long long)sum);
 
Index: kvm/include/linux/kernel_stat.h
===================================================================
--- kvm.orig/include/linux/kernel_stat.h	2007-08-20 14:17:13.000000000 +0200
+++ kvm/include/linux/kernel_stat.h	2007-08-20 14:17:16.000000000 +0200
@@ -23,6 +23,9 @@ struct cpu_usage_stat {
 	cputime64_t idle;
 	cputime64_t iowait;
 	cputime64_t steal;
+#ifdef CONFIG_GUEST_ACCOUNTING
+	cputime64_t guest;
+#endif
 };
 
 struct kernel_stat {
Index: kvm/init/Kconfig
===================================================================
--- kvm.orig/init/Kconfig	2007-08-20 14:17:13.000000000 +0200
+++ kvm/init/Kconfig	2007-08-20 14:17:35.000000000 +0200
@@ -167,6 +167,10 @@ config BSD_PROCESS_ACCT_V3
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
+config GUEST_ACCOUNTING
+	bool
+	default n
+
 config TASKSTATS
 	bool "Export task/process statistics through netlink (EXPERIMENTAL)"
 	depends on NET

--------------010501080606030903020100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------010501080606030903020100--
