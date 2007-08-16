From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: [PATCH/RFC 2/4]Introduce a new field "guest" in task_struct
Date: Thu, 16 Aug 2007 17:57:57 +0200
Message-ID: <46C47405.6050505__22312.8402991735$1187280002$gmane$org@bull.net>
References: <46C4719A.2060308@bull.net> <46C4720F.7030304@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010508010305010200010001"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C4720F.7030304@bull.net>
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
--------------010508010305010200010001
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1

PATCH 2/4] like for cpustat, introduce the "guest" and "cguest" fields for the
tasks. Modify
signal_struct and task_struct. Modify /proc/<pid>/stat to display these new field

Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>
-- 
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth

--------------010508010305010200010001
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="proc_task_stat_guest"
Content-Disposition: inline;
 filename="proc_task_stat_guest"

Index: kvm/fs/proc/array.c
===================================================================
--- kvm.orig/fs/proc/array.c	2007-08-16 15:23:52.000000000 +0200
+++ kvm/fs/proc/array.c	2007-08-16 15:36:54.000000000 +0200
@@ -354,6 +354,13 @@
 	return stime;
 }
 
+static clock_t task_gtime(struct task_struct *p)
+{
+	clock_t gtime = cputime_to_clock_t(p->gtime);
+
+	return gtime;
+}
+
 static int do_task_stat(struct task_struct *task, char *buffer, int whole)
 {
 	unsigned long vsize, eip, esp, wchan = ~0UL;
@@ -368,8 +375,8 @@
 	unsigned long long start_time;
 	unsigned long cmin_flt = 0, cmaj_flt = 0;
 	unsigned long  min_flt = 0,  maj_flt = 0;
-	cputime_t cutime, cstime;
-	clock_t utime, stime;
+	cputime_t cutime, cstime, cgtime;
+	clock_t utime, stime, gtime;
 	unsigned long rsslim = 0;
 	char tcomm[sizeof(task->comm)];
 	unsigned long flags;
@@ -387,8 +394,8 @@
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = cputime_zero;
-	utime = stime = 0;
+	cutime = cstime = cgtime = cputime_zero;
+	utime = stime = gtime = 0;
 
 	rcu_read_lock();
 	if (lock_task_sighand(task, &flags)) {
@@ -406,6 +413,7 @@
 		cmaj_flt = sig->cmaj_flt;
 		cutime = sig->cutime;
 		cstime = sig->cstime;
+		cgtime = sig->cgtime;
 		rsslim = sig->rlim[RLIMIT_RSS].rlim_cur;
 
 		/* add up live thread stats at the group level */
@@ -416,6 +424,7 @@
 				maj_flt += t->maj_flt;
 				utime += task_utime(t);
 				stime += task_stime(t);
+				gtime += task_gtime(t);
 				t = next_thread(t);
 			} while (t != task);
 
@@ -423,6 +432,7 @@
 			maj_flt += sig->maj_flt;
 			utime += cputime_to_clock_t(sig->utime);
 			stime += cputime_to_clock_t(sig->stime);
+			gtime += cputime_to_clock_t(sig->gtime);
 		}
 
 		sid = signal_session(sig);
@@ -440,6 +450,7 @@
 		maj_flt = task->maj_flt;
 		utime = task_utime(task);
 		stime = task_stime(task);
+		gtime = task_gtime(task);
 	}
 
 	/* scale priority and nice values from timeslices to -20..20 */
@@ -457,7 +468,7 @@
 
 	res = sprintf(buffer, "%d (%s) %c %d %d %d %d %d %u %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %u %u %llu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %u %u %llu %lu %ld\n",
 		task->pid,
 		tcomm,
 		state,
@@ -502,7 +513,10 @@
 		task_cpu(task),
 		task->rt_priority,
 		task->policy,
-		(unsigned long long)delayacct_blkio_ticks(task));
+		(unsigned long long)delayacct_blkio_ticks(task),
+		gtime,
+		cputime_to_clock_t(cgtime)
+		);
 	if (mm)
 		mmput(mm);
 	return res;
Index: kvm/include/linux/sched.h
===================================================================
--- kvm.orig/include/linux/sched.h	2007-08-16 15:23:52.000000000 +0200
+++ kvm/include/linux/sched.h	2007-08-16 15:36:54.000000000 +0200
@@ -514,7 +514,7 @@
 	 * Live threads maintain their own counters and add to these
 	 * in __exit_signal, except for the group leader.
 	 */
-	cputime_t utime, stime, cutime, cstime;
+	cputime_t utime, stime, gtime, cutime, cstime, cgtime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw;
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 	unsigned long inblock, oublock, cinblock, coublock;
@@ -1018,7 +1018,7 @@
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
 	unsigned int rt_priority;
-	cputime_t utime, stime;
+	cputime_t utime, stime, gtime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	struct timespec start_time; 		/* monotonic time */
 	struct timespec real_start_time;	/* boot based time */
Index: kvm/kernel/exit.c
===================================================================
--- kvm.orig/kernel/exit.c	2007-08-16 15:23:52.000000000 +0200
+++ kvm/kernel/exit.c	2007-08-16 15:36:54.000000000 +0200
@@ -120,6 +120,7 @@
 		 */
 		sig->utime = cputime_add(sig->utime, tsk->utime);
 		sig->stime = cputime_add(sig->stime, tsk->stime);
+		sig->gtime = cputime_add(sig->gtime, tsk->gtime);
 		sig->min_flt += tsk->min_flt;
 		sig->maj_flt += tsk->maj_flt;
 		sig->nvcsw += tsk->nvcsw;
@@ -1255,6 +1256,11 @@
 			cputime_add(p->stime,
 			cputime_add(sig->stime,
 				    sig->cstime)));
+		psig->cgtime =
+			cputime_add(psig->cgtime,
+			cputime_add(p->gtime,
+			cputime_add(sig->gtime,
+				    sig->cgtime)));
 		psig->cmin_flt +=
 			p->min_flt + sig->min_flt + sig->cmin_flt;
 		psig->cmaj_flt +=
Index: kvm/kernel/fork.c
===================================================================
--- kvm.orig/kernel/fork.c	2007-08-16 15:23:52.000000000 +0200
+++ kvm/kernel/fork.c	2007-08-16 15:39:07.000000000 +0200
@@ -876,7 +876,8 @@
 	sig->leader = 0;	/* session leadership doesn't inherit */
 	sig->tty_old_pgrp = NULL;
 
-	sig->utime = sig->stime = sig->cutime = sig->cstime = cputime_zero;
+	sig->utime = sig->stime = sig->gtime = sig->cutime =
+				sig->cstime = sig->cgtime = cputime_zero;
 	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
 	sig->min_flt = sig->maj_flt = sig->cmin_flt = sig->cmaj_flt = 0;
 	sig->inblock = sig->oublock = sig->cinblock = sig->coublock = 0;
@@ -1045,6 +1046,7 @@
 
 	p->utime = cputime_zero;
 	p->stime = cputime_zero;
+	p->gtime = cputime_zero;
 
 #ifdef CONFIG_TASK_XACCT
 	p->rchar = 0;		/* I/O counter: bytes read */

--------------010508010305010200010001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------010508010305010200010001--
