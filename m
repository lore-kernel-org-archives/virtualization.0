From: Asias He <asias@redhat.com>
Subject: [PATCH 3/5] vhost-scsi: Make func indention more consistent
Date: Fri,  3 May 2013 15:35:57 +0800
Message-ID: <1367566559-20431-4-git-send-email-asias@redhat.com>
References: <1367566559-20431-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367566559-20431-1-git-send-email-asias@redhat.com>
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

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/scsi.c | 154 +++++++++++++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 66 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index d4798e1..d9781ed 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -333,11 +333,12 @@ static u32 tcm_vhost_get_default_depth(struct se_portal_group *se_tpg)
 	return 1;
 }
 
-static u32 tcm_vhost_get_pr_transport_id(struct se_portal_group *se_tpg,
-	struct se_node_acl *se_nacl,
-	struct t10_pr_registration *pr_reg,
-	int *format_code,
-	unsigned char *buf)
+static u32
+tcm_vhost_get_pr_transport_id(struct se_portal_group *se_tpg,
+			      struct se_node_acl *se_nacl,
+			      struct t10_pr_registration *pr_reg,
+			      int *format_code,
+			      unsigned char *buf)
 {
 	struct tcm_vhost_tpg *tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
@@ -363,10 +364,11 @@ static u32 tcm_vhost_get_pr_transport_id(struct se_portal_group *se_tpg,
 			format_code, buf);
 }
 
-static u32 tcm_vhost_get_pr_transport_id_len(struct se_portal_group *se_tpg,
-	struct se_node_acl *se_nacl,
-	struct t10_pr_registration *pr_reg,
-	int *format_code)
+static u32
+tcm_vhost_get_pr_transport_id_len(struct se_portal_group *se_tpg,
+				  struct se_node_acl *se_nacl,
+				  struct t10_pr_registration *pr_reg,
+				  int *format_code)
 {
 	struct tcm_vhost_tpg *tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
@@ -392,10 +394,11 @@ static u32 tcm_vhost_get_pr_transport_id_len(struct se_portal_group *se_tpg,
 			format_code);
 }
 
-static char *tcm_vhost_parse_pr_out_transport_id(struct se_portal_group *se_tpg,
-	const char *buf,
-	u32 *out_tid_len,
-	char **port_nexus_ptr)
+static char *
+tcm_vhost_parse_pr_out_transport_id(struct se_portal_group *se_tpg,
+				    const char *buf,
+				    u32 *out_tid_len,
+				    char **port_nexus_ptr)
 {
 	struct tcm_vhost_tpg *tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
@@ -421,8 +424,8 @@ static char *tcm_vhost_parse_pr_out_transport_id(struct se_portal_group *se_tpg,
 			port_nexus_ptr);
 }
 
-static struct se_node_acl *tcm_vhost_alloc_fabric_acl(
-	struct se_portal_group *se_tpg)
+static struct se_node_acl *
+tcm_vhost_alloc_fabric_acl(struct se_portal_group *se_tpg)
 {
 	struct tcm_vhost_nacl *nacl;
 
@@ -435,8 +438,9 @@ static struct se_node_acl *tcm_vhost_alloc_fabric_acl(
 	return &nacl->se_node_acl;
 }
 
-static void tcm_vhost_release_fabric_acl(struct se_portal_group *se_tpg,
-	struct se_node_acl *se_nacl)
+static void
+tcm_vhost_release_fabric_acl(struct se_portal_group *se_tpg,
+			     struct se_node_acl *se_nacl)
 {
 	struct tcm_vhost_nacl *nacl = container_of(se_nacl,
 			struct tcm_vhost_nacl, se_node_acl);
@@ -531,8 +535,9 @@ static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
 	kfree(evt);
 }
 
-static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
-	u32 event, u32 reason)
+static struct tcm_vhost_evt *
+tcm_vhost_allocate_evt(struct vhost_scsi *vs,
+		       u32 event, u32 reason)
 {
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	struct tcm_vhost_evt *evt;
@@ -576,8 +581,8 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
 	kfree(tv_cmd);
 }
 
-static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
-	struct tcm_vhost_evt *evt)
+static void
+tcm_vhost_do_evt_work(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
 {
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	struct virtio_scsi_event *event = &evt->event;
@@ -698,12 +703,12 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		vhost_signal(&vs->dev, &vs->vqs[vq].vq);
 }
 
-static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
-	struct vhost_virtqueue *vq,
-	struct tcm_vhost_tpg *tv_tpg,
-	struct virtio_scsi_cmd_req *v_req,
-	u32 exp_data_len,
-	int data_direction)
+static struct tcm_vhost_cmd *
+vhost_scsi_allocate_cmd(struct vhost_virtqueue *vq,
+			struct tcm_vhost_tpg *tv_tpg,
+			struct virtio_scsi_cmd_req *v_req,
+			u32 exp_data_len,
+			int data_direction)
 {
 	struct tcm_vhost_cmd *tv_cmd;
 	struct tcm_vhost_nexus *tv_nexus;
@@ -734,8 +739,11 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
  *
  * Returns the number of scatterlist entries used or -errno on error.
  */
-static int vhost_scsi_map_to_sgl(struct scatterlist *sgl,
-	unsigned int sgl_count, struct iovec *iov, int write)
+static int
+vhost_scsi_map_to_sgl(struct scatterlist *sgl,
+		      unsigned int sgl_count,
+		      struct iovec *iov,
+		      int write)
 {
 	unsigned int npages = 0, pages_nr, offset, nbytes;
 	struct scatterlist *sg = sgl;
@@ -779,8 +787,11 @@ out:
 	return ret;
 }
 
-static int vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
-	struct iovec *iov, unsigned int niov, int write)
+static int
+vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
+			  struct iovec *iov,
+			  unsigned int niov,
+			  int write)
 {
 	int ret;
 	unsigned int i;
@@ -860,8 +871,10 @@ static void tcm_vhost_submission_work(struct work_struct *work)
 	}
 }
 
-static void vhost_scsi_send_bad_target(struct vhost_scsi *vs,
-	struct vhost_virtqueue *vq, int head, unsigned out)
+static void
+vhost_scsi_send_bad_target(struct vhost_scsi *vs,
+			   struct vhost_virtqueue *vq,
+			   int head, unsigned out)
 {
 	struct virtio_scsi_cmd_resp __user *resp;
 	struct virtio_scsi_cmd_resp rsp;
@@ -877,8 +890,8 @@ static void vhost_scsi_send_bad_target(struct vhost_scsi *vs,
 		pr_err("Faulted on virtio_scsi_cmd_resp\n");
 }
 
-static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
-	struct vhost_virtqueue *vq)
+static void
+vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 {
 	struct tcm_vhost_tpg **vs_tpg;
 	struct virtio_scsi_cmd_req v_req;
@@ -1059,8 +1072,12 @@ static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
 	pr_debug("%s: The handling func for control queue.\n", __func__);
 }
 
-static void tcm_vhost_send_evt(struct vhost_scsi *vs, struct tcm_vhost_tpg *tpg,
-	struct se_lun *lun, u32 event, u32 reason)
+static void
+tcm_vhost_send_evt(struct vhost_scsi *vs,
+		   struct tcm_vhost_tpg *tpg,
+		   struct se_lun *lun,
+		   u32 event,
+		   u32 reason)
 {
 	struct tcm_vhost_evt *evt;
 
@@ -1150,9 +1167,9 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
  *  The lock nesting rule is:
  *    tcm_vhost_mutex -> vs->dev.mutex -> tpg->tv_tpg_mutex -> vq->mutex
  */
-static int vhost_scsi_set_endpoint(
-	struct vhost_scsi *vs,
-	struct vhost_scsi_target *t)
+static int
+vhost_scsi_set_endpoint(struct vhost_scsi *vs,
+			struct vhost_scsi_target *t)
 {
 	struct tcm_vhost_tport *tv_tport;
 	struct tcm_vhost_tpg *tv_tpg;
@@ -1240,9 +1257,9 @@ out:
 	return ret;
 }
 
-static int vhost_scsi_clear_endpoint(
-	struct vhost_scsi *vs,
-	struct vhost_scsi_target *t)
+static int
+vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
+			  struct vhost_scsi_target *t)
 {
 	struct tcm_vhost_tport *tv_tport;
 	struct tcm_vhost_tpg *tv_tpg;
@@ -1402,8 +1419,10 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	return 0;
 }
 
-static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
-				unsigned long arg)
+static long
+vhost_scsi_ioctl(struct file *f,
+		 unsigned int ioctl,
+		 unsigned long arg)
 {
 	struct vhost_scsi *vs = f->private_data;
 	struct vhost_scsi_target backend;
@@ -1519,8 +1538,9 @@ static char *tcm_vhost_dump_proto_id(struct tcm_vhost_tport *tport)
 	return "Unknown";
 }
 
-static void tcm_vhost_do_plug(struct tcm_vhost_tpg *tpg,
-	struct se_lun *lun, bool plug)
+static void
+tcm_vhost_do_plug(struct tcm_vhost_tpg *tpg,
+		  struct se_lun *lun, bool plug)
 {
 
 	struct vhost_scsi *vs = tpg->vhost_scsi;
@@ -1560,7 +1580,7 @@ static void tcm_vhost_hotunplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
 }
 
 static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
-	struct se_lun *lun)
+			       struct se_lun *lun)
 {
 	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
@@ -1579,7 +1599,7 @@ static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
 }
 
 static void tcm_vhost_port_unlink(struct se_portal_group *se_tpg,
-	struct se_lun *lun)
+				  struct se_lun *lun)
 {
 	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
@@ -1595,10 +1615,10 @@ static void tcm_vhost_port_unlink(struct se_portal_group *se_tpg,
 	mutex_unlock(&tcm_vhost_mutex);
 }
 
-static struct se_node_acl *tcm_vhost_make_nodeacl(
-	struct se_portal_group *se_tpg,
-	struct config_group *group,
-	const char *name)
+static struct se_node_acl *
+tcm_vhost_make_nodeacl(struct se_portal_group *se_tpg,
+		       struct config_group *group,
+		       const char *name)
 {
 	struct se_node_acl *se_nacl, *se_nacl_new;
 	struct tcm_vhost_nacl *nacl;
@@ -1640,7 +1660,7 @@ static void tcm_vhost_drop_nodeacl(struct se_node_acl *se_acl)
 }
 
 static int tcm_vhost_make_nexus(struct tcm_vhost_tpg *tv_tpg,
-	const char *name)
+				const char *name)
 {
 	struct se_portal_group *se_tpg;
 	struct tcm_vhost_nexus *tv_nexus;
@@ -1744,7 +1764,7 @@ static int tcm_vhost_drop_nexus(struct tcm_vhost_tpg *tpg)
 }
 
 static ssize_t tcm_vhost_tpg_show_nexus(struct se_portal_group *se_tpg,
-	char *page)
+					char *page)
 {
 	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
@@ -1765,8 +1785,8 @@ static ssize_t tcm_vhost_tpg_show_nexus(struct se_portal_group *se_tpg,
 }
 
 static ssize_t tcm_vhost_tpg_store_nexus(struct se_portal_group *se_tpg,
-	const char *page,
-	size_t count)
+					 const char *page,
+					 size_t count)
 {
 	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
@@ -1849,9 +1869,10 @@ static struct configfs_attribute *tcm_vhost_tpg_attrs[] = {
 	NULL,
 };
 
-static struct se_portal_group *tcm_vhost_make_tpg(struct se_wwn *wwn,
-	struct config_group *group,
-	const char *name)
+static struct se_portal_group *
+tcm_vhost_make_tpg(struct se_wwn *wwn,
+		   struct config_group *group,
+		   const char *name)
 {
 	struct tcm_vhost_tport *tport = container_of(wwn,
 			struct tcm_vhost_tport, tport_wwn);
@@ -1907,9 +1928,10 @@ static void tcm_vhost_drop_tpg(struct se_portal_group *se_tpg)
 	kfree(tpg);
 }
 
-static struct se_wwn *tcm_vhost_make_tport(struct target_fabric_configfs *tf,
-	struct config_group *group,
-	const char *name)
+static struct se_wwn *
+tcm_vhost_make_tport(struct target_fabric_configfs *tf,
+		     struct config_group *group,
+		     const char *name)
 {
 	struct tcm_vhost_tport *tport;
 	char *ptr;
@@ -1979,9 +2001,9 @@ static void tcm_vhost_drop_tport(struct se_wwn *wwn)
 	kfree(tport);
 }
 
-static ssize_t tcm_vhost_wwn_show_attr_version(
-	struct target_fabric_configfs *tf,
-	char *page)
+static ssize_t
+tcm_vhost_wwn_show_attr_version(struct target_fabric_configfs *tf,
+				char *page)
 {
 	return sprintf(page, "TCM_VHOST fabric module %s on %s/%s"
 		"on "UTS_RELEASE"\n", TCM_VHOST_VERSION, utsname()->sysname,
-- 
1.8.1.4
