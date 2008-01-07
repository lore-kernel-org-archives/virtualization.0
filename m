From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 15/16] make pending notifications per-vcpu
Date: Mon,  7 Jan 2008 11:05:36 -0200
Message-ID: <11997112151794-git-send-email-gcosta__38537.5461228707$1199711816$gmane$org@redhat.com>
References: 11981576363806-git-send-email-gcosta@redhat.com
	<1199711137195-git-send-email-gcosta@redhat.com>
	<11997111432356-git-send-email-gcosta@redhat.com>
	<11997111481113-git-send-email-gcosta@redhat.com>
	<11997111523234-git-send-email-gcosta@redhat.com>
	<1199711157132-git-send-email-gcosta@redhat.com>
	<11997111623212-git-send-email-gcosta@redhat.com>
	<11997111661344-git-send-email-gcosta@redhat.com>
	<11997111711574-git-send-email-gcosta@redhat.com>
	<11997111751377-git-send-email-gcosta@redhat.com>
	<11997111801864-git-send-email-gcosta@redhat.com>
	<11997111841603-git-send-email-gcosta@redhat.com>
	<11997111891639-git-send-email-gcosta@redhat.com>
	<11997111961607-git-send-email-gcosta@redhat.com>
	<11997112043261-git-send-email-gcosta@redhat.com>
	<11997112102919-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11997112102919-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

this patch makes the pending_notify field, used to control
pending notifications, per-vcpu, instead of per-guest

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/core.c        |    6 +++---
 drivers/lguest/hypercalls.c  |    6 +++---
 drivers/lguest/lg.h          |    3 ++-
 drivers/lguest/lguest_user.c |    4 ++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/lguest/core.c b/drivers/lguest/core.c
index 847f2df..eae5149 100644
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -186,10 +186,10 @@ int run_guest(struct lg_vcpu *vcpu, unsigned long __user *user)
 
 		/* It's possible the Guest did a NOTIFY hypercall to the
 		 * Launcher, in which case we return from the read() now. */
-		if (lg->pending_notify) {
-			if (put_user(lg->pending_notify, user))
+		if (vcpu->pending_notify) {
+			if (put_user(vcpu->pending_notify, user))
 				return -EFAULT;
-			return sizeof(lg->pending_notify);
+			return sizeof(vcpu->pending_notify);
 		}
 
 		/* Check for signals */
diff --git a/drivers/lguest/hypercalls.c b/drivers/lguest/hypercalls.c
index 4a4133b..ae8c0b4 100644
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -89,7 +89,7 @@ static void do_hcall(struct lg_vcpu *vcpu, struct hcall_args *args)
 		vcpu->halted = 1;
 		break;
 	case LHCALL_NOTIFY:
-		lg->pending_notify = args->arg1;
+		vcpu->pending_notify = args->arg1;
 		break;
 	default:
 		/* It should be an architecture-specific hypercall. */
@@ -152,7 +152,7 @@ static void do_async_hcalls(struct lg_vcpu *vcpu)
 
 		/* Stop doing hypercalls if they want to notify the Launcher:
 		 * it needs to service this first. */
-		if (lg->pending_notify)
+		if (vcpu->pending_notify)
 			break;
 	}
 }
@@ -217,7 +217,7 @@ void do_hypercalls(struct lg_vcpu *vcpu)
 	/* If we stopped reading the hypercall ring because the Guest did a
 	 * NOTIFY to the Launcher, we want to return now.  Otherwise we do
 	 * the hypercall. */
-	if (!vcpu->lg->pending_notify) {
+	if (!vcpu->pending_notify) {
 		do_hcall(vcpu, vcpu->hcall);
 		/* Tricky point: we reset the hcall pointer to mark the
 		 * hypercall as "done".  We use the hcall pointer rather than
diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
index 1b3c933..d33445f 100644
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -51,6 +51,8 @@ struct lg_vcpu {
 	u32 esp1;
 	u8 ss1;
 
+	unsigned long pending_notify; /* pfn from LHCALL_NOTIFY */
+
 	/* At end of a page shared mapped over lguest_pages in guest.  */
 	unsigned long regs_page;
 	struct lguest_regs *regs;
@@ -95,7 +97,6 @@ struct lguest
 	struct pgdir pgdirs[4];
 
 	unsigned long noirq_start, noirq_end;
-	unsigned long pending_notify; /* pfn from LHCALL_NOTIFY */
 
 	unsigned int stack_pages;
 	u32 tsc_khz;
diff --git a/drivers/lguest/lguest_user.c b/drivers/lguest/lguest_user.c
index acc1616..8ac6d2b 100644
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -92,8 +92,8 @@ static ssize_t read(struct file *file, char __user *user, size_t size,loff_t*o)
 
 	/* If we returned from read() last time because the Guest notified,
 	 * clear the flag. */
-	if (lg->pending_notify)
-		lg->pending_notify = 0;
+	if (vcpu->pending_notify)
+		vcpu->pending_notify = 0;
 
 	/* Run the Guest until something interesting happens. */
 	return run_guest(vcpu, (unsigned long __user *)user);
-- 
1.5.0.6
