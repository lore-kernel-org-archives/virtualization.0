From: Asias He <asias@redhat.com>
Subject: [PATCH 4/4] tcm_vhost: Flush vhost_work in vhost_scsi_flush()
Date: Tue, 12 Mar 2013 10:42:51 +0800
Message-ID: <1363056171-5854-5-git-send-email-asias__7300.86641056022$1363056250$gmane$org@redhat.com>
References: <1363056171-5854-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363056171-5854-1-git-send-email-asias@redhat.com>
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

We also need to flush the vhost_works. One is the completion vhost_work, the
other is event vhost_work.

Signed-off-by: Asias He <asias@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 61093d1..c5157cd 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -953,6 +953,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 
 	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
 		vhost_scsi_flush_vq(vs, i);
+	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
 }
 
 static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
-- 
1.8.1.4
