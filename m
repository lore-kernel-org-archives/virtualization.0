From: Asias He <asias@redhat.com>
Subject: [PATCH V2 6/6] tcm_vhost: Flush vhost_work in vhost_scsi_flush()
Date: Fri,  8 Mar 2013 10:21:47 +0800
Message-ID: <1362709307-12554-7-git-send-email-asias__17276.7201242552$1362709400$gmane$org@redhat.com>
References: <1362709307-12554-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362709307-12554-1-git-send-email-asias@redhat.com>
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
---
 drivers/vhost/tcm_vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index af80c7f..f80a545 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -1127,6 +1127,8 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 
 	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
 		vhost_scsi_flush_vq(vs, i);
+	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
+	vhost_work_flush(&vs->dev, &vs->vs_event_work);
 }
 
 static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
-- 
1.8.1.4
