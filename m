From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: [PATCH/RFC 3/4, second shot]Introduce "account_guest_time"
Date: Fri, 17 Aug 2007 13:51:49 +0200
Message-ID: <46C58BD5.3090207__34333.0191019506$1187351697$gmane$org@bull.net>
References: <46C4719A.2060308@bull.net> <46C4720F.7030304@bull.net>	
	<46C4725A.4070607@bull.net> <46C4740F.2050701@bull.net>	
	<1187303955.6449.7.camel@localhost.localdomain>
	<46C54FB8.7050504@bull.net>
	<1187339450.6449.115.camel@localhost.localdomain>
	<46C56774.2030009@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070305070409050007030503"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C56774.2030009@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------070305070409050007030503
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

This is another way to compute guest time... I remove the "account modifi=
ers"
mechanism and call directly account_guest_time() from account_system_time=
().
account_system_time() computes user, system and guest times according val=
ue
accumulated in vtime (a ktime_t) in task_struct by the virtual machine.
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth

--------------070305070409050007030503
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 name="account_guest"
Content-Disposition: inline;
 filename="account_guest"

Index: kvm/include/linux/sched.h
===================================================================
--- kvm.orig/include/linux/sched.h	2007-08-17 10:18:53.000000000 +0200
+++ kvm/include/linux/sched.h	2007-08-17 12:33:22.000000000 +0200
@@ -1192,6 +1192,9 @@
 #ifdef CONFIG_FAULT_INJECTION
 	int make_it_fail;
 #endif
+#ifdef CONFIG_GUEST_ACCOUNTING
+	ktime_t vtime;
+#endif
 };
 
 /*
Index: kvm/kernel/sched.c
===================================================================
--- kvm.orig/kernel/sched.c	2007-08-17 10:18:53.000000000 +0200
+++ kvm/kernel/sched.c	2007-08-17 12:33:07.000000000 +0200
@@ -3233,6 +3233,37 @@
 		cpustat->user = cputime64_add(cpustat->user, tmp);
 }
 
+#ifdef CONFIG_GUEST_ACCOUNTING
+/*
+ * Account guest time to a process
+ * @p: the process that the cpu time gets accounted to
+ * @cputime: the cpu time spent in kernel space since the last update
+ */
+
+static cputime_t account_guest_time(struct task_struct *p, cputime_t cputime)
+{
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	ktime_t kmsec = ktime_set(0, NSEC_PER_MSEC);
+	cputime_t cmsec = msecs_to_cputime(1);
+
+	while ((ktime_to_ns(p->vtime) >= NSEC_PER_MSEC) &&
+		(cputime_to_msecs(cputime) >= 1)) {
+		p->vtime = ktime_sub(p->vtime, kmsec);
+		p->utime = cputime_add(p->utime, cmsec);
+		p->gtime = cputime_add(p->gtime, cmsec);
+
+		cpustat->guest = cputime64_add(cpustat->guest,
+				cputime_to_cputime64(cmsec));
+		cpustat->user = cputime64_add(cpustat->user,
+		cputime_to_cputime64(cmsec));
+
+		cputime = cputime_sub(cputime, cmsec);
+	}
+
+	return cputime;
+}
+#endif
+
 /*
  * Account system cpu time to a process.
  * @p: the process that the cpu time gets accounted to
@@ -3246,6 +3277,10 @@
 	struct rq *rq = this_rq();
 	cputime64_t tmp;
 
+#ifdef CONFIG_GUEST_ACCOUNTING
+	cputime = account_guest_time(p, cputime);
+#endif
+
 	p->stime = cputime_add(p->stime, cputime);
 
 	/* Add system time to cpustat. */

--------------070305070409050007030503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------070305070409050007030503--
