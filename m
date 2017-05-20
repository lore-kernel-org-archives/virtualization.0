From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] vhost/scsi: Delete error messages for failed memory
	allocations in five functions
Date: Sat, 20 May 2017 16:32:17 +0200
Message-ID: <babc429d-6440-92aa-e1d0-eee2636a8d0f__10021.067914977$1495290751$gmane$org@users.sourceforge.net>
References: <bafa65e4-08fe-efdb-d836-7657e8a64749@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <bafa65e4-08fe-efdb-d836-7657e8a64749@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 May 2017 15:50:30 +0200

Omit seven extra messages for memory allocation failures in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/vhost/scsi.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 650533916c19..49d07950e2e5 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -417,5 +417,4 @@ vhost_scsi_allocate_evt(struct vhost_scsi *vs,
 	if (!evt) {
-		vq_err(vq, "Failed to allocate vhost_scsi_evt\n");
 		vs->vs_events_missed = true;
 		return NULL;
 	}
@@ -1722,21 +1721,15 @@ static int vhost_scsi_nexus_cb(struct se_portal_group *se_tpg,
-		if (!tv_cmd->tvc_sgl) {
-			pr_err("Unable to allocate tv_cmd->tvc_sgl\n");
+		if (!tv_cmd->tvc_sgl)
 			goto out;
-		}
 
 		tv_cmd->tvc_upages = kzalloc(sizeof(struct page *) *
 				VHOST_SCSI_PREALLOC_UPAGES, GFP_KERNEL);
-		if (!tv_cmd->tvc_upages) {
-			pr_err("Unable to allocate tv_cmd->tvc_upages\n");
+		if (!tv_cmd->tvc_upages)
 			goto out;
-		}
 
 		tv_cmd->tvc_prot_sgl = kzalloc(sizeof(struct scatterlist) *
 				VHOST_SCSI_PREALLOC_PROT_SGLS, GFP_KERNEL);
-		if (!tv_cmd->tvc_prot_sgl) {
-			pr_err("Unable to allocate tv_cmd->tvc_prot_sgl\n");
+		if (!tv_cmd->tvc_prot_sgl)
 			goto out;
-		}
 	}
 	return 0;
 out:
@@ -1760,6 +1753,5 @@ static int vhost_scsi_make_nexus(struct vhost_scsi_tpg *tpg,
 	if (!tv_nexus) {
 		mutex_unlock(&tpg->tv_tpg_mutex);
-		pr_err("Unable to allocate struct vhost_scsi_nexus\n");
 		return -ENOMEM;
 	}
 	/*
@@ -1961,7 +1953,6 @@ vhost_scsi_make_tpg(struct se_wwn *wwn,
-	if (!tpg) {
-		pr_err("Unable to allocate struct vhost_scsi_tpg");
+	if (!tpg)
 		return ERR_PTR(-ENOMEM);
-	}
+
 	mutex_init(&tpg->tv_tpg_mutex);
 	INIT_LIST_HEAD(&tpg->tv_tpg_list);
 	tpg->tport = tport;
@@ -2015,7 +2006,6 @@ vhost_scsi_make_tport(struct target_fabric_configfs *tf,
-	if (!tport) {
-		pr_err("Unable to allocate struct vhost_scsi_tport");
+	if (!tport)
 		return ERR_PTR(-ENOMEM);
-	}
+
 	tport->tport_wwpn = wwpn;
 	/*
 	 * Determine the emulated Protocol Identifier and Target Port Name
-- 
2.13.0
