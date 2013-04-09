From: Asias He <asias@redhat.com>
Subject: [PATCH v5 2/3] tcm_vhost: Add helper to check if endpoint is setup
Date: Tue,  9 Apr 2013 16:51:38 +0800
Message-ID: <1365497499-9172-3-git-send-email-asias@redhat.com>
References: <1365497499-9172-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365497499-9172-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index f0189bc..7069881 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -111,6 +111,24 @@ static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
 	return ret;
 }
 
+static bool tcm_vhost_check_endpoint(struct vhost_virtqueue *vq)
+{
+	bool ret = false;
+
+	/*
+	* We can handle the vq only after the endpoint is setup by calling the
+	* VHOST_SCSI_SET_ENDPOINT ioctl.
+	*
+	* TODO: Check that we are running from vhost_worker which acts
+	* as read-side critical section for vhost kind of RCU.
+	* See the comments in struct vhost_virtqueue in drivers/vhost/vhost.h
+	*/
+	if (rcu_dereference_check(vq->private_data, 1))
+		ret = true;
+
+	return ret;
+}
+
 static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
 {
 	return 1;
-- 
1.8.1.4
