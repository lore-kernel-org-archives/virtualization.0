From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 03/16] initialize vcpu
Date: Thu, 20 Dec 2007 11:33:43 -0200
Message-ID: <1198157654189-git-send-email-gcosta__44102.0512524576$1198157832$gmane$org@redhat.com>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576442148-git-send-email-gcosta@redhat.com>
	<11981576492807-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576492807-git-send-email-gcosta@redhat.com>
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

this patch initializes the first vcpu in the initialize() routing,
which is responsible for starting the process of putting the guest up.
right now, as much of the fields are still not per-vcpu, it does not
do much.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/lguest_user.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/lguest/lguest_user.c b/drivers/lguest/lguest_user.c
index 3b92a61..d1b1c26 100644
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -88,6 +88,17 @@ static ssize_t read(struct file *file, char __user *user, size_t size,loff_t*o)
 	return run_guest(lg, (unsigned long __user *)user);
 }
 
+static int vcpu_start(struct lguest_vcpu *vcpu, int vcpu_id,
+		      unsigned long start_ip)
+{
+	vcpu->vcpu_id = vcpu_id;
+
+	vcpu->lg = container_of((vcpu - vcpu_id), struct lguest, vcpus[0]);
+	vcpu->lg->nr_vcpus++;
+
+	return 0;
+}
+
 /*L:020 The initialization write supplies 4 pointer sized (32 or 64 bit)
  * values (in addition to the LHREQ_INITIALIZE value).  These are:
  *
@@ -134,6 +145,12 @@ static int initialize(struct file *file, const unsigned long __user *input)
 	lg->mem_base = (void __user *)(long)args[0];
 	lg->pfn_limit = args[1];
 
+	/* This is the first cpu */
+	lg->nr_vcpus = 0;
+	err = vcpu_start(&lg->vcpus[0], 0, args[3]);
+	if (err)
+		goto release_guest;
+
 	/* We need a complete page for the Guest registers: they are accessible
 	 * to the Guest and we can only grant it access to whole pages. */
 	lg->regs_page = get_zeroed_page(GFP_KERNEL);
-- 
1.5.0.6
