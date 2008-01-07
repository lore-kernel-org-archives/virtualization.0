From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 03/16] initialize vcpu
Date: Mon,  7 Jan 2008 11:05:24 -0200
Message-ID: <11997111523234-git-send-email-gcosta__35929.628116037$1199711645$gmane$org@redhat.com>
References: 11981576363806-git-send-email-gcosta@redhat.com
	<1199711137195-git-send-email-gcosta@redhat.com>
	<11997111432356-git-send-email-gcosta@redhat.com>
	<11997111481113-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11997111481113-git-send-email-gcosta@redhat.com>
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
 drivers/lguest/lguest_user.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/lguest/lguest_user.c b/drivers/lguest/lguest_user.c
index 3b92a61..34be8e7 100644
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -88,6 +88,20 @@ static ssize_t read(struct file *file, char __user *user, size_t size,loff_t*o)
 	return run_guest(lg, (unsigned long __user *)user);
 }
 
+static int vcpu_start(struct lg_vcpu *vcpu, int vcpu_id,
+		      unsigned long start_ip)
+{
+	if (vcpu_id > NR_CPUS)
+		return -EINVAL;
+
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
@@ -134,6 +148,12 @@ static int initialize(struct file *file, const unsigned long __user *input)
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
