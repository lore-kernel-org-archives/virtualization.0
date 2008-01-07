From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 01/16] introduce vcpu struct
Date: Mon,  7 Jan 2008 11:05:22 -0200
Message-ID: <11997111432356-git-send-email-gcosta__129.436390898441$1199711524$gmane$org@redhat.com>
References: 11981576363806-git-send-email-gcosta@redhat.com
	<1199711137195-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1199711137195-git-send-email-gcosta@redhat.com>
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

this patch introduces a vcpu struct for lguest. In upcoming patches,
more and more fields will be moved from the lguest struct to the vcpu

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/lg.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
index 8692489..8fc1c29 100644
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -38,6 +38,13 @@ struct lguest_pages
 #define CHANGED_GDT_TLS		4 /* Actually a subset of CHANGED_GDT */
 #define CHANGED_ALL	        3
 
+struct lguest;
+
+struct lg_vcpu {
+	int vcpu_id;
+	struct lguest *lg;
+};
+
 /* The private info the thread maintains about the guest. */
 struct lguest
 {
@@ -47,6 +54,9 @@ struct lguest
 	struct lguest_data __user *lguest_data;
 	struct task_struct *tsk;
 	struct mm_struct *mm; 	/* == tsk->mm, but that becomes NULL on exit */
+	struct lg_vcpu vcpus[NR_CPUS];
+	unsigned int nr_vcpus;
+
 	u32 pfn_limit;
 	/* This provides the offset to the base of guest-physical
 	 * memory in the Launcher. */
-- 
1.5.0.6
