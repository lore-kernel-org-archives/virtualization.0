From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: [PATCH 3/4] modify account_system_time() to update guest time in
 cpustat and task_struct
Date: Mon, 20 Aug 2007 15:14:07 +0200
Message-ID: <46C9939F.90109__28997.0357007862$1187617815$gmane$org@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060300050103040408070503"
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
--------------060300050103040408070503
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1

[PATCH 3/4] modify account_system_time() to add cputime to cpustat->guest if we
are running a VCPU. We add this cputime to  cpustat->user instead of
cpustat->system because this part of KVM code is in fact user code although it
is executed in the kernel. We duplicate VCPU time between guest and user to
allow an unmodified "top(1)" to display correct value. A modified "top(1)" is
able to display good cpu user time and cpu guest time by subtracting cpu guest
time from cpu user time. Update "gtime" in task_struct accordingly.

Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>
-- 
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth

--------------060300050103040408070503
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="account_guest"
Content-Disposition: inline;
 filename="account_guest"

Index: kvm/include/linux/sched.h
===================================================================
--- kvm.orig/include/linux/sched.h	2007-08-20 13:20:12.000000000 +0200
+++ kvm/include/linux/sched.h	2007-08-20 13:21:24.000000000 +0200
@@ -1317,6 +1317,7 @@ static inline void put_task_struct(struc
 #define PF_STARTING	0x00000002	/* being created */
 #define PF_EXITING	0x00000004	/* getting shut down */
 #define PF_EXITPIDONE	0x00000008	/* pi exit done on shut down */
+#define PF_VCPU		0x00000010	/* I'm a virtual CPU */
 #define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
 #define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
 #define PF_DUMPCORE	0x00000200	/* dumped core */
Index: kvm/kernel/sched.c
===================================================================
--- kvm.orig/kernel/sched.c	2007-08-20 11:11:30.000000000 +0200
+++ kvm/kernel/sched.c	2007-08-20 13:21:24.000000000 +0200
@@ -3246,10 +3246,24 @@ void account_system_time(struct task_str
 	struct rq *rq = this_rq();
 	cputime64_t tmp;
 
+	tmp = cputime_to_cputime64(cputime);
+#ifdef CONFIG_GUEST_ACCOUNTING
+	if (p->flags & PF_VCPU) {
+		p->utime = cputime_add(p->utime, cputime);
+		p->gtime = cputime_add(p->gtime, cputime);
+
+		cpustat->guest = cputime64_add(cpustat->guest, tmp);
+		cpustat->user = cputime64_add(cpustat->user, tmp);
+
+		p->flags &= ~PF_VCPU;
+
+		return;
+	}
+#endif
+
 	p->stime = cputime_add(p->stime, cputime);
 
 	/* Add system time to cpustat. */
-	tmp = cputime_to_cputime64(cputime);
 	if (hardirq_count() - hardirq_offset)
 		cpustat->irq = cputime64_add(cpustat->irq, tmp);
 	else if (softirq_count())

--------------060300050103040408070503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------060300050103040408070503--
