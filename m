From: Asias He <asias@redhat.com>
Subject: [PATCH v2 08/11] vhost-scsi: Rename struct vhost_scsi *s to *vs
Date: Mon,  6 May 2013 16:38:26 +0800
Message-ID: <1367829509-5371-9-git-send-email-asias__28566.7416792878$1367829615$gmane$org@redhat.com>
References: <1367829509-5371-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367829509-5371-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

vs is used everywhere, make the naming more consistent.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/scsi.c | 56 ++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 02ddedd..d4798e1 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1342,63 +1342,63 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
-	struct vhost_scsi *s;
+	struct vhost_scsi *vs;
 	struct vhost_virtqueue **vqs;
 	int r, i;
 
-	s = kzalloc(sizeof(*s), GFP_KERNEL);
-	if (!s)
+	vs = kzalloc(sizeof(*vs), GFP_KERNEL);
+	if (!vs)
 		return -ENOMEM;
 
 	vqs = kmalloc(VHOST_SCSI_MAX_VQ * sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
-		kfree(s);
+		kfree(vs);
 		return -ENOMEM;
 	}
 
-	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
-	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
+	vhost_work_init(&vs->vs_completion_work, vhost_scsi_complete_cmd_work);
+	vhost_work_init(&vs->vs_event_work, tcm_vhost_evt_work);
 
-	s->vs_events_nr = 0;
-	s->vs_events_missed = false;
+	vs->vs_events_nr = 0;
+	vs->vs_events_missed = false;
 
-	vqs[VHOST_SCSI_VQ_CTL] = &s->vqs[VHOST_SCSI_VQ_CTL].vq;
-	vqs[VHOST_SCSI_VQ_EVT] = &s->vqs[VHOST_SCSI_VQ_EVT].vq;
-	s->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
-	s->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
+	vqs[VHOST_SCSI_VQ_CTL] = &vs->vqs[VHOST_SCSI_VQ_CTL].vq;
+	vqs[VHOST_SCSI_VQ_EVT] = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
+	vs->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
+	vs->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
 	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++) {
-		vqs[i] = &s->vqs[i].vq;
-		s->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
+		vqs[i] = &vs->vqs[i].vq;
+		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
 	}
-	r = vhost_dev_init(&s->dev, vqs, VHOST_SCSI_MAX_VQ);
+	r = vhost_dev_init(&vs->dev, vqs, VHOST_SCSI_MAX_VQ);
 
-	tcm_vhost_init_inflight(s, NULL);
+	tcm_vhost_init_inflight(vs, NULL);
 
 	if (r < 0) {
 		kfree(vqs);
-		kfree(s);
+		kfree(vs);
 		return r;
 	}
 
-	f->private_data = s;
+	f->private_data = vs;
 	return 0;
 }
 
 static int vhost_scsi_release(struct inode *inode, struct file *f)
 {
-	struct vhost_scsi *s = f->private_data;
+	struct vhost_scsi *vs = f->private_data;
 	struct vhost_scsi_target t;
 
-	mutex_lock(&s->dev.mutex);
-	memcpy(t.vhost_wwpn, s->vs_vhost_wwpn, sizeof(t.vhost_wwpn));
-	mutex_unlock(&s->dev.mutex);
-	vhost_scsi_clear_endpoint(s, &t);
-	vhost_dev_stop(&s->dev);
-	vhost_dev_cleanup(&s->dev, false);
+	mutex_lock(&vs->dev.mutex);
+	memcpy(t.vhost_wwpn, vs->vs_vhost_wwpn, sizeof(t.vhost_wwpn));
+	mutex_unlock(&vs->dev.mutex);
+	vhost_scsi_clear_endpoint(vs, &t);
+	vhost_dev_stop(&vs->dev);
+	vhost_dev_cleanup(&vs->dev, false);
 	/* Jobs can re-queue themselves in evt kick handler. Do extra flush. */
-	vhost_scsi_flush(s);
-	kfree(s->dev.vqs);
-	kfree(s);
+	vhost_scsi_flush(vs);
+	kfree(vs->dev.vqs);
+	kfree(vs);
 	return 0;
 }
 
-- 
1.8.1.4
