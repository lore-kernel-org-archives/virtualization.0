From: Asias He <asias@redhat.com>
Subject: [PATCH] tcm_vhost: Use vs for struct vhost_scsi
Date: Fri, 22 Mar 2013 15:07:02 +0800
Message-ID: <1363936022-13228-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

Use vs for struct vhost_scsi, instead of s. vs is used everywhere, make
the naming more consistent.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 16022d3..9365938 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -1194,48 +1194,48 @@ err_dev:
 
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
-	struct vhost_scsi *s;
+	struct vhost_scsi *vs;
 	int r, i;
 
-	s = kzalloc(sizeof(*s), GFP_KERNEL);
-	if (!s)
+	vs = kzalloc(sizeof(*vs), GFP_KERNEL);
+	if (!vs)
 		return -ENOMEM;
 
-	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
-	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
+	vhost_work_init(&vs->vs_completion_work, vhost_scsi_complete_cmd_work);
+	vhost_work_init(&vs->vs_event_work, tcm_vhost_evt_work);
 
-	s->vs_events_nr = 0;
-	s->vs_inflight[0] = 0;
-	s->vs_inflight[1] = 0;
-	spin_lock_init(&s->vs_flush_lock);
-	init_waitqueue_head(&s->vs_flush_wait);
+	vs->vs_events_nr = 0;
+	vs->vs_inflight[0] = 0;
+	vs->vs_inflight[1] = 0;
+	spin_lock_init(&vs->vs_flush_lock);
+	init_waitqueue_head(&vs->vs_flush_wait);
 
-	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
-	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
+	vs->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
+	vs->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
 	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++)
-		s->vqs[i].handle_kick = vhost_scsi_handle_kick;
-	r = vhost_dev_init(&s->dev, s->vqs, VHOST_SCSI_MAX_VQ);
+		vs->vqs[i].handle_kick = vhost_scsi_handle_kick;
+	r = vhost_dev_init(&vs->dev, vs->vqs, VHOST_SCSI_MAX_VQ);
 	if (r < 0) {
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
-	kfree(s);
+	mutex_lock(&vs->dev.mutex);
+	memcpy(t.vhost_wwpn, vs->vs_vhost_wwpn, sizeof(t.vhost_wwpn));
+	mutex_unlock(&vs->dev.mutex);
+	vhost_scsi_clear_endpoint(vs, &t);
+	vhost_dev_stop(&vs->dev);
+	vhost_dev_cleanup(&vs->dev, false);
+	kfree(vs);
 	return 0;
 }
 
-- 
1.8.1.4
