From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 05/16] make write() operation smp aware
Date: Thu, 20 Dec 2007 11:33:45 -0200
Message-ID: <11981576632726-git-send-email-gcosta__32305.7234906175$1198158195$gmane$org@redhat.com>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576442148-git-send-email-gcosta@redhat.com>
	<11981576492807-git-send-email-gcosta@redhat.com>
	<1198157654189-git-send-email-gcosta@redhat.com>
	<11981576581695-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576581695-git-send-email-gcosta@redhat.com>
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

This patch makes the write() file operation smp aware. Which means, receiving
the vcpu_id value through the offset parameter, and being well aware to which
vcpu we're talking to.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/lguest_user.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/lguest/lguest_user.c b/drivers/lguest/lguest_user.c
index 894d530..ae5bf4c 100644
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -223,14 +223,21 @@ static ssize_t write(struct file *file, const char __user *in,
 	struct lguest *lg = file->private_data;
 	const unsigned long __user *input = (const unsigned long __user *)in;
 	unsigned long req;
+	struct lguest_vcpu *vcpu = NULL;
+	int vcpu_id = *off;
 
 	if (get_user(req, input) != 0)
 		return -EFAULT;
 	input++;
 
 	/* If you haven't initialized, you must do that first. */
-	if (req != LHREQ_INITIALIZE && !lg)
-		return -EINVAL;
+	if (req != LHREQ_INITIALIZE) {
+		if (!lg)
+			return -EINVAL;
+		vcpu = &lg->vcpus[vcpu_id];
+		if (!vcpu)
+			return -EINVAL;
+	}
 
 	/* Once the Guest is dead, all you can do is read() why it died. */
 	if (lg && lg->dead)
-- 
1.5.0.6
