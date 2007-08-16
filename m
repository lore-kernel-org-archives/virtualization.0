From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: [PATCH/RFC 1/4]Introduce a new field "guest" in cpustat
Date: Thu, 16 Aug 2007 17:57:49 +0200
Message-ID: <46C473FD.3050009__2286.84252729199$1187280012$gmane$org@bull.net>
References: <46C4719A.2060308@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090406080801040303060903"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C4719A.2060308@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------090406080801040303060903
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1

[PATCH 1/4] as modern CPUs introduce a third running state, after "user" and
"system", we need a new field, "guest", in cpustat to store the time used by
the CPU to run virtual CPU. Modify /proc/stat to display this new field.

Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>
-- 
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth

--------------090406080801040303060903
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="proc_stat_guest"
Content-Disposition: inline;
 filename="proc_stat_guest"

Index: kvm/fs/proc/proc_misc.c
===================================================================
--- kvm.orig/fs/proc/proc_misc.c	2007-08-10 16:49:42.000000000 +0200
+++ kvm/fs/proc/proc_misc.c	2007-08-10 16:51:34.000000000 +0200
@@ -443,6 +443,7 @@
 	int i;
 	unsigned long jif;
 	cputime64_t user, nice, system, idle, iowait, irq, softirq, steal;
+	cputime64_t guest;
 	u64 sum = 0;
 	struct timespec boottime;
 	unsigned int *per_irq_sum;
@@ -452,7 +453,7 @@
 		return -ENOMEM;
 
 	user = nice = system = idle = iowait =
-		irq = softirq = steal = cputime64_zero;
+		irq = softirq = steal = guest = cputime64_zero;
 	getboottime(&boottime);
 	jif = boottime.tv_sec;
 
@@ -467,6 +468,7 @@
 		irq = cputime64_add(irq, kstat_cpu(i).cpustat.irq);
 		softirq = cputime64_add(softirq, kstat_cpu(i).cpustat.softirq);
 		steal = cputime64_add(steal, kstat_cpu(i).cpustat.steal);
+		guest = cputime64_add(guest, kstat_cpu(i).cpustat.guest);
 		for (j = 0; j < NR_IRQS; j++) {
 			unsigned int temp = kstat_cpu(i).irqs[j];
 			sum += temp;
@@ -474,7 +476,7 @@
 		}
 	}
 
-	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu %llu\n",
+	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu %llu %llu\n",
 		(unsigned long long)cputime64_to_clock_t(user),
 		(unsigned long long)cputime64_to_clock_t(nice),
 		(unsigned long long)cputime64_to_clock_t(system),
@@ -482,7 +484,8 @@
 		(unsigned long long)cputime64_to_clock_t(iowait),
 		(unsigned long long)cputime64_to_clock_t(irq),
 		(unsigned long long)cputime64_to_clock_t(softirq),
-		(unsigned long long)cputime64_to_clock_t(steal));
+		(unsigned long long)cputime64_to_clock_t(steal),
+		(unsigned long long)cputime64_to_clock_t(guest));
 	for_each_online_cpu(i) {
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
@@ -494,7 +497,8 @@
 		irq = kstat_cpu(i).cpustat.irq;
 		softirq = kstat_cpu(i).cpustat.softirq;
 		steal = kstat_cpu(i).cpustat.steal;
-		seq_printf(p, "cpu%d %llu %llu %llu %llu %llu %llu %llu %llu\n",
+		guest = kstat_cpu(i).cpustat.guest;
+		seq_printf(p, "cpu%d %llu %llu %llu %llu %llu %llu %llu %llu %llu\n",
 			i,
 			(unsigned long long)cputime64_to_clock_t(user),
 			(unsigned long long)cputime64_to_clock_t(nice),
@@ -503,7 +507,8 @@
 			(unsigned long long)cputime64_to_clock_t(iowait),
 			(unsigned long long)cputime64_to_clock_t(irq),
 			(unsigned long long)cputime64_to_clock_t(softirq),
-			(unsigned long long)cputime64_to_clock_t(steal));
+			(unsigned long long)cputime64_to_clock_t(steal),
+			(unsigned long long)cputime64_to_clock_t(guest));
 	}
 	seq_printf(p, "intr %llu", (unsigned long long)sum);
 
Index: kvm/include/linux/kernel_stat.h
===================================================================
--- kvm.orig/include/linux/kernel_stat.h	2007-08-10 16:49:42.000000000 +0200
+++ kvm/include/linux/kernel_stat.h	2007-08-10 16:49:59.000000000 +0200
@@ -23,6 +23,7 @@
 	cputime64_t idle;
 	cputime64_t iowait;
 	cputime64_t steal;
+	cputime64_t guest;
 };
 
 struct kernel_stat {

--------------090406080801040303060903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------090406080801040303060903--
