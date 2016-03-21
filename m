From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 1/6] xen: sync xen header
Date: Mon, 21 Mar 2016 13:24:30 +0100
Message-ID: <1458563075-30298-2-git-send-email-jgross@suse.com>
References: <1458563075-30298-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1458563075-30298-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

Import the actual version of include/xen/interface/sched.h from Xen.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 include/xen/interface/sched.h | 100 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 18 deletions(-)

diff --git a/include/xen/interface/sched.h b/include/xen/interface/sched.h
index f184909..a4c4d73 100644
--- a/include/xen/interface/sched.h
+++ b/include/xen/interface/sched.h
@@ -3,6 +3,24 @@
  *
  * Scheduler state interactions
  *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
  * Copyright (c) 2005, Keir Fraser <keir@xensource.com>
  */
 
@@ -12,18 +30,30 @@
 #include <xen/interface/event_channel.h>
 
 /*
+ * Guest Scheduler Operations
+ *
+ * The SCHEDOP interface provides mechanisms for a guest to interact
+ * with the scheduler, including yield, blocking and shutting itself
+ * down.
+ */
+
+/*
  * The prototype for this hypercall is:
- *  long sched_op_new(int cmd, void *arg)
+ * long HYPERVISOR_sched_op(enum sched_op cmd, void *arg, ...)
+ *
  * @cmd == SCHEDOP_??? (scheduler operation).
  * @arg == Operation-specific extra argument(s), as described below.
+ * ...  == Additional Operation-specific extra arguments, described below.
  *
- * **NOTE**:
- * Versions of Xen prior to 3.0.2 provide only the following legacy version
+ * Versions of Xen prior to 3.0.2 provided only the following legacy version
  * of this hypercall, supporting only the commands yield, block and shutdown:
  *  long sched_op(int cmd, unsigned long arg)
  * @cmd == SCHEDOP_??? (scheduler operation).
  * @arg == 0               (SCHEDOP_yield and SCHEDOP_block)
  *      == SHUTDOWN_* code (SCHEDOP_shutdown)
+ *
+ * This legacy version is available to new guests as:
+ * long HYPERVISOR_sched_op_compat(enum sched_op cmd, unsigned long arg)
  */
 
 /*
@@ -44,12 +74,17 @@
 /*
  * Halt execution of this domain (all VCPUs) and notify the system controller.
  * @arg == pointer to sched_shutdown structure.
+ *
+ * If the sched_shutdown_t reason is SHUTDOWN_suspend then
+ * x86 PV guests must also set RDX (EDX for 32-bit guests) to the MFN
+ * of the guest's start info page.  RDX/EDX is the third hypercall
+ * argument.
+ *
+ * In addition, which reason is SHUTDOWN_suspend this hypercall
+ * returns 1 if suspend was cancelled or the domain was merely
+ * checkpointed, and 0 if it is resuming in a new domain.
  */
 #define SCHEDOP_shutdown    2
-struct sched_shutdown {
-    unsigned int reason; /* SHUTDOWN_* */
-};
-DEFINE_GUEST_HANDLE_STRUCT(sched_shutdown);
 
 /*
  * Poll a set of event-channel ports. Return when one or more are pending. An
@@ -57,12 +92,6 @@ DEFINE_GUEST_HANDLE_STRUCT(sched_shutdown);
  * @arg == pointer to sched_poll structure.
  */
 #define SCHEDOP_poll        3
-struct sched_poll {
-    GUEST_HANDLE(evtchn_port_t) ports;
-    unsigned int nr_ports;
-    uint64_t timeout;
-};
-DEFINE_GUEST_HANDLE_STRUCT(sched_poll);
 
 /*
  * Declare a shutdown for another domain. The main use of this function is
@@ -71,15 +100,11 @@ DEFINE_GUEST_HANDLE_STRUCT(sched_poll);
  * @arg == pointer to sched_remote_shutdown structure.
  */
 #define SCHEDOP_remote_shutdown        4
-struct sched_remote_shutdown {
-    domid_t domain_id;         /* Remote domain ID */
-    unsigned int reason;       /* SHUTDOWN_xxx reason */
-};
 
 /*
  * Latch a shutdown code, so that when the domain later shuts down it
  * reports this code to the control tools.
- * @arg == as for SCHEDOP_shutdown.
+ * @arg == sched_shutdown, as for SCHEDOP_shutdown.
  */
 #define SCHEDOP_shutdown_code 5
 
@@ -92,10 +117,47 @@ struct sched_remote_shutdown {
  * With id != 0 and timeout != 0, poke watchdog timer and set new timeout.
  */
 #define SCHEDOP_watchdog    6
+
+/*
+ * Override the current vcpu affinity by pinning it to one physical cpu or
+ * undo this override restoring the previous affinity.
+ * @arg == pointer to sched_pin_override structure.
+ *
+ * A negative pcpu value will undo a previous pin override and restore the
+ * previous cpu affinity.
+ * This call is allowed for the hardware domain only and requires the cpu
+ * to be part of the domain's cpupool.
+ */
+#define SCHEDOP_pin_override 7
+
+struct sched_shutdown {
+    unsigned int reason; /* SHUTDOWN_* => shutdown reason */
+};
+DEFINE_GUEST_HANDLE_STRUCT(sched_shutdown);
+
+struct sched_poll {
+    GUEST_HANDLE(evtchn_port_t) ports;
+    unsigned int nr_ports;
+    uint64_t timeout;
+};
+DEFINE_GUEST_HANDLE_STRUCT(sched_poll);
+
+struct sched_remote_shutdown {
+    domid_t domain_id;         /* Remote domain ID */
+    unsigned int reason;       /* SHUTDOWN_* => shutdown reason */
+};
+DEFINE_GUEST_HANDLE_STRUCT(sched_remote_shutdown);
+
 struct sched_watchdog {
     uint32_t id;                /* watchdog ID */
     uint32_t timeout;           /* timeout */
 };
+DEFINE_GUEST_HANDLE_STRUCT(sched_watchdog);
+
+struct sched_pin_override {
+    int32_t pcpu;
+};
+DEFINE_GUEST_HANDLE_STRUCT(sched_pin_override);
 
 /*
  * Reason codes for SCHEDOP_shutdown. These may be interpreted by control
@@ -107,6 +169,7 @@ struct sched_watchdog {
 #define SHUTDOWN_suspend    2  /* Clean up, save suspend info, kill.         */
 #define SHUTDOWN_crash      3  /* Tell controller we've crashed.             */
 #define SHUTDOWN_watchdog   4  /* Restart because watchdog time expired.     */
+
 /*
  * Domain asked to perform 'soft reset' for it. The expected behavior is to
  * reset internal Xen state for the domain returning it to the point where it
@@ -115,5 +178,6 @@ struct sched_watchdog {
  * interfaces again.
  */
 #define SHUTDOWN_soft_reset 5
+#define SHUTDOWN_MAX        5  /* Maximum valid shutdown reason.             */
 
 #endif /* __XEN_PUBLIC_SCHED_H__ */
-- 
2.6.2
