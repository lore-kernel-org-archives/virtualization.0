From: Asias He <asias@redhat.com>
Subject: [PATCH v2 10/11] vhost-scsi: Rename struct tcm_vhost_tpg *tv_tpg to
	*tpg
Date: Mon,  6 May 2013 16:38:28 +0800
Message-ID: <1367829509-5371-11-git-send-email-asias__31114.0145561241$1367829646$gmane$org@redhat.com>
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

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/scsi.c | 122 +++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index d9781ed..353145f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -705,7 +705,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 
 static struct tcm_vhost_cmd *
 vhost_scsi_allocate_cmd(struct vhost_virtqueue *vq,
-			struct tcm_vhost_tpg *tv_tpg,
+			struct tcm_vhost_tpg *tpg,
 			struct virtio_scsi_cmd_req *v_req,
 			u32 exp_data_len,
 			int data_direction)
@@ -713,7 +713,7 @@ vhost_scsi_allocate_cmd(struct vhost_virtqueue *vq,
 	struct tcm_vhost_cmd *tv_cmd;
 	struct tcm_vhost_nexus *tv_nexus;
 
-	tv_nexus = tv_tpg->tpg_nexus;
+	tv_nexus = tpg->tpg_nexus;
 	if (!tv_nexus) {
 		pr_err("Unable to locate active struct tcm_vhost_nexus\n");
 		return ERR_PTR(-EIO);
@@ -895,7 +895,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 {
 	struct tcm_vhost_tpg **vs_tpg;
 	struct virtio_scsi_cmd_req v_req;
-	struct tcm_vhost_tpg *tv_tpg;
+	struct tcm_vhost_tpg *tpg;
 	struct tcm_vhost_cmd *tv_cmd;
 	u32 exp_data_len, data_first, data_num, data_direction;
 	unsigned out, in, i;
@@ -981,10 +981,10 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 
 		/* Extract the tpgt */
 		target = v_req.lun[1];
-		tv_tpg = ACCESS_ONCE(vs_tpg[target]);
+		tpg = ACCESS_ONCE(vs_tpg[target]);
 
 		/* Target does not exist, fail the request */
-		if (unlikely(!tv_tpg)) {
+		if (unlikely(!tpg)) {
 			vhost_scsi_send_bad_target(vs, vq, head, out);
 			continue;
 		}
@@ -993,7 +993,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		for (i = 0; i < data_num; i++)
 			exp_data_len += vq->iov[data_first + i].iov_len;
 
-		tv_cmd = vhost_scsi_allocate_cmd(vq, tv_tpg, &v_req,
+		tv_cmd = vhost_scsi_allocate_cmd(vq, tpg, &v_req,
 					exp_data_len, data_direction);
 		if (IS_ERR(tv_cmd)) {
 			vq_err(vq, "vhost_scsi_allocate_cmd failed %ld\n",
@@ -1172,7 +1172,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 			struct vhost_scsi_target *t)
 {
 	struct tcm_vhost_tport *tv_tport;
-	struct tcm_vhost_tpg *tv_tpg;
+	struct tcm_vhost_tpg *tpg;
 	struct tcm_vhost_tpg **vs_tpg;
 	struct vhost_virtqueue *vq;
 	int index, ret, i, len;
@@ -1199,32 +1199,32 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 	if (vs->vs_tpg)
 		memcpy(vs_tpg, vs->vs_tpg, len);
 
-	list_for_each_entry(tv_tpg, &tcm_vhost_list, tv_tpg_list) {
-		mutex_lock(&tv_tpg->tv_tpg_mutex);
-		if (!tv_tpg->tpg_nexus) {
-			mutex_unlock(&tv_tpg->tv_tpg_mutex);
+	list_for_each_entry(tpg, &tcm_vhost_list, tv_tpg_list) {
+		mutex_lock(&tpg->tv_tpg_mutex);
+		if (!tpg->tpg_nexus) {
+			mutex_unlock(&tpg->tv_tpg_mutex);
 			continue;
 		}
-		if (tv_tpg->tv_tpg_vhost_count != 0) {
-			mutex_unlock(&tv_tpg->tv_tpg_mutex);
+		if (tpg->tv_tpg_vhost_count != 0) {
+			mutex_unlock(&tpg->tv_tpg_mutex);
 			continue;
 		}
-		tv_tport = tv_tpg->tport;
+		tv_tport = tpg->tport;
 
 		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
-			if (vs->vs_tpg && vs->vs_tpg[tv_tpg->tport_tpgt]) {
+			if (vs->vs_tpg && vs->vs_tpg[tpg->tport_tpgt]) {
 				kfree(vs_tpg);
-				mutex_unlock(&tv_tpg->tv_tpg_mutex);
+				mutex_unlock(&tpg->tv_tpg_mutex);
 				ret = -EEXIST;
 				goto out;
 			}
-			tv_tpg->tv_tpg_vhost_count++;
-			tv_tpg->vhost_scsi = vs;
-			vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
+			tpg->tv_tpg_vhost_count++;
+			tpg->vhost_scsi = vs;
+			vs_tpg[tpg->tport_tpgt] = tpg;
 			smp_mb__after_atomic_inc();
 			match = true;
 		}
-		mutex_unlock(&tv_tpg->tv_tpg_mutex);
+		mutex_unlock(&tpg->tv_tpg_mutex);
 	}
 
 	if (match) {
@@ -1262,7 +1262,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 			  struct vhost_scsi_target *t)
 {
 	struct tcm_vhost_tport *tv_tport;
-	struct tcm_vhost_tpg *tv_tpg;
+	struct tcm_vhost_tpg *tpg;
 	struct vhost_virtqueue *vq;
 	bool match = false;
 	int index, ret, i;
@@ -1285,30 +1285,30 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 
 	for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
 		target = i;
-		tv_tpg = vs->vs_tpg[target];
-		if (!tv_tpg)
+		tpg = vs->vs_tpg[target];
+		if (!tpg)
 			continue;
 
-		mutex_lock(&tv_tpg->tv_tpg_mutex);
-		tv_tport = tv_tpg->tport;
+		mutex_lock(&tpg->tv_tpg_mutex);
+		tv_tport = tpg->tport;
 		if (!tv_tport) {
 			ret = -ENODEV;
 			goto err_tpg;
 		}
 
 		if (strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
-			pr_warn("tv_tport->tport_name: %s, tv_tpg->tport_tpgt: %hu"
+			pr_warn("tv_tport->tport_name: %s, tpg->tport_tpgt: %hu"
 				" does not match t->vhost_wwpn: %s, t->vhost_tpgt: %hu\n",
-				tv_tport->tport_name, tv_tpg->tport_tpgt,
+				tv_tport->tport_name, tpg->tport_tpgt,
 				t->vhost_wwpn, t->vhost_tpgt);
 			ret = -EINVAL;
 			goto err_tpg;
 		}
-		tv_tpg->tv_tpg_vhost_count--;
-		tv_tpg->vhost_scsi = NULL;
+		tpg->tv_tpg_vhost_count--;
+		tpg->vhost_scsi = NULL;
 		vs->vs_tpg[target] = NULL;
 		match = true;
-		mutex_unlock(&tv_tpg->tv_tpg_mutex);
+		mutex_unlock(&tpg->tv_tpg_mutex);
 	}
 	if (match) {
 		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
@@ -1332,7 +1332,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	return 0;
 
 err_tpg:
-	mutex_unlock(&tv_tpg->tv_tpg_mutex);
+	mutex_unlock(&tpg->tv_tpg_mutex);
 err_dev:
 	mutex_unlock(&vs->dev.mutex);
 	mutex_unlock(&tcm_vhost_mutex);
@@ -1582,16 +1582,16 @@ static void tcm_vhost_hotunplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
 static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
 			       struct se_lun *lun)
 {
-	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
+	struct tcm_vhost_tpg *tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
 
 	mutex_lock(&tcm_vhost_mutex);
 
-	mutex_lock(&tv_tpg->tv_tpg_mutex);
-	tv_tpg->tv_tpg_port_count++;
-	mutex_unlock(&tv_tpg->tv_tpg_mutex);
+	mutex_lock(&tpg->tv_tpg_mutex);
+	tpg->tv_tpg_port_count++;
+	mutex_unlock(&tpg->tv_tpg_mutex);
 
-	tcm_vhost_hotplug(tv_tpg, lun);
+	tcm_vhost_hotplug(tpg, lun);
 
 	mutex_unlock(&tcm_vhost_mutex);
 
@@ -1601,16 +1601,16 @@ static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
 static void tcm_vhost_port_unlink(struct se_portal_group *se_tpg,
 				  struct se_lun *lun)
 {
-	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
+	struct tcm_vhost_tpg *tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
 
 	mutex_lock(&tcm_vhost_mutex);
 
-	mutex_lock(&tv_tpg->tv_tpg_mutex);
-	tv_tpg->tv_tpg_port_count--;
-	mutex_unlock(&tv_tpg->tv_tpg_mutex);
+	mutex_lock(&tpg->tv_tpg_mutex);
+	tpg->tv_tpg_port_count--;
+	mutex_unlock(&tpg->tv_tpg_mutex);
 
-	tcm_vhost_hotunplug(tv_tpg, lun);
+	tcm_vhost_hotunplug(tpg, lun);
 
 	mutex_unlock(&tcm_vhost_mutex);
 }
@@ -1659,23 +1659,23 @@ static void tcm_vhost_drop_nodeacl(struct se_node_acl *se_acl)
 	kfree(nacl);
 }
 
-static int tcm_vhost_make_nexus(struct tcm_vhost_tpg *tv_tpg,
+static int tcm_vhost_make_nexus(struct tcm_vhost_tpg *tpg,
 				const char *name)
 {
 	struct se_portal_group *se_tpg;
 	struct tcm_vhost_nexus *tv_nexus;
 
-	mutex_lock(&tv_tpg->tv_tpg_mutex);
-	if (tv_tpg->tpg_nexus) {
-		mutex_unlock(&tv_tpg->tv_tpg_mutex);
-		pr_debug("tv_tpg->tpg_nexus already exists\n");
+	mutex_lock(&tpg->tv_tpg_mutex);
+	if (tpg->tpg_nexus) {
+		mutex_unlock(&tpg->tv_tpg_mutex);
+		pr_debug("tpg->tpg_nexus already exists\n");
 		return -EEXIST;
 	}
-	se_tpg = &tv_tpg->se_tpg;
+	se_tpg = &tpg->se_tpg;
 
 	tv_nexus = kzalloc(sizeof(struct tcm_vhost_nexus), GFP_KERNEL);
 	if (!tv_nexus) {
-		mutex_unlock(&tv_tpg->tv_tpg_mutex);
+		mutex_unlock(&tpg->tv_tpg_mutex);
 		pr_err("Unable to allocate struct tcm_vhost_nexus\n");
 		return -ENOMEM;
 	}
@@ -1684,7 +1684,7 @@ static int tcm_vhost_make_nexus(struct tcm_vhost_tpg *tv_tpg,
 	 */
 	tv_nexus->tvn_se_sess = transport_init_session();
 	if (IS_ERR(tv_nexus->tvn_se_sess)) {
-		mutex_unlock(&tv_tpg->tv_tpg_mutex);
+		mutex_unlock(&tpg->tv_tpg_mutex);
 		kfree(tv_nexus);
 		return -ENOMEM;
 	}
@@ -1696,7 +1696,7 @@ static int tcm_vhost_make_nexus(struct tcm_vhost_tpg *tv_tpg,
 	tv_nexus->tvn_se_sess->se_node_acl = core_tpg_check_initiator_node_acl(
 				se_tpg, (unsigned char *)name);
 	if (!tv_nexus->tvn_se_sess->se_node_acl) {
-		mutex_unlock(&tv_tpg->tv_tpg_mutex);
+		mutex_unlock(&tpg->tv_tpg_mutex);
 		pr_debug("core_tpg_check_initiator_node_acl() failed"
 				" for %s\n", name);
 		transport_free_session(tv_nexus->tvn_se_sess);
@@ -1709,9 +1709,9 @@ static int tcm_vhost_make_nexus(struct tcm_vhost_tpg *tv_tpg,
 	 */
 	__transport_register_session(se_tpg, tv_nexus->tvn_se_sess->se_node_acl,
 			tv_nexus->tvn_se_sess, tv_nexus);
-	tv_tpg->tpg_nexus = tv_nexus;
+	tpg->tpg_nexus = tv_nexus;
 
-	mutex_unlock(&tv_tpg->tv_tpg_mutex);
+	mutex_unlock(&tpg->tv_tpg_mutex);
 	return 0;
 }
 
@@ -1766,20 +1766,20 @@ static int tcm_vhost_drop_nexus(struct tcm_vhost_tpg *tpg)
 static ssize_t tcm_vhost_tpg_show_nexus(struct se_portal_group *se_tpg,
 					char *page)
 {
-	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
+	struct tcm_vhost_tpg *tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
 	struct tcm_vhost_nexus *tv_nexus;
 	ssize_t ret;
 
-	mutex_lock(&tv_tpg->tv_tpg_mutex);
-	tv_nexus = tv_tpg->tpg_nexus;
+	mutex_lock(&tpg->tv_tpg_mutex);
+	tv_nexus = tpg->tpg_nexus;
 	if (!tv_nexus) {
-		mutex_unlock(&tv_tpg->tv_tpg_mutex);
+		mutex_unlock(&tpg->tv_tpg_mutex);
 		return -ENODEV;
 	}
 	ret = snprintf(page, PAGE_SIZE, "%s\n",
 			tv_nexus->tvn_se_sess->se_node_acl->initiatorname);
-	mutex_unlock(&tv_tpg->tv_tpg_mutex);
+	mutex_unlock(&tpg->tv_tpg_mutex);
 
 	return ret;
 }
@@ -1788,16 +1788,16 @@ static ssize_t tcm_vhost_tpg_store_nexus(struct se_portal_group *se_tpg,
 					 const char *page,
 					 size_t count)
 {
-	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
+	struct tcm_vhost_tpg *tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
-	struct tcm_vhost_tport *tport_wwn = tv_tpg->tport;
+	struct tcm_vhost_tport *tport_wwn = tpg->tport;
 	unsigned char i_port[TCM_VHOST_NAMELEN], *ptr, *port_ptr;
 	int ret;
 	/*
 	 * Shutdown the active I_T nexus if 'NULL' is passed..
 	 */
 	if (!strncmp(page, "NULL", 4)) {
-		ret = tcm_vhost_drop_nexus(tv_tpg);
+		ret = tcm_vhost_drop_nexus(tpg);
 		return (!ret) ? count : ret;
 	}
 	/*
@@ -1855,7 +1855,7 @@ check_newline:
 	if (i_port[strlen(i_port)-1] == '\n')
 		i_port[strlen(i_port)-1] = '\0';
 
-	ret = tcm_vhost_make_nexus(tv_tpg, port_ptr);
+	ret = tcm_vhost_make_nexus(tpg, port_ptr);
 	if (ret < 0)
 		return ret;
 
-- 
1.8.1.4
