From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH 2/2] virtio-scsi: reorder the goto label in init()
Date: Thu, 7 Mar 2013 11:29:28 +0800
Message-ID: <1362626968-16871-2-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1362626968-16871-1-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362626968-16871-1-git-send-email-gaowanlong@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Reorder the goto label in init() to make it more clearly, and remove
the useless NULL pointer reassignment.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/scsi/virtio_scsi.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index f679b8c..55dfb06 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -774,32 +774,27 @@ static int __init init(void)
 	virtscsi_cmd_cache = KMEM_CACHE(virtio_scsi_cmd, 0);
 	if (!virtscsi_cmd_cache) {
 		pr_err("kmem_cache_create() for virtscsi_cmd_cache failed\n");
-		goto error;
+		return ret;
 	}
 
-
-	virtscsi_cmd_pool =
-		mempool_create_slab_pool(VIRTIO_SCSI_MEMPOOL_SZ,
-					 virtscsi_cmd_cache);
+	virtscsi_cmd_pool = mempool_create_slab_pool(VIRTIO_SCSI_MEMPOOL_SZ,
+						     virtscsi_cmd_cache);
 	if (!virtscsi_cmd_pool) {
 		pr_err("mempool_create() for virtscsi_cmd_pool failed\n");
-		goto error;
+		goto out_destroy_cache;
 	}
+
 	ret = register_virtio_driver(&virtio_scsi_driver);
 	if (ret < 0)
-		goto error;
+		goto out_destroy_pool;
 
 	return 0;
 
-error:
-	if (virtscsi_cmd_pool) {
-		mempool_destroy(virtscsi_cmd_pool);
-		virtscsi_cmd_pool = NULL;
-	}
-	if (virtscsi_cmd_cache) {
-		kmem_cache_destroy(virtscsi_cmd_cache);
-		virtscsi_cmd_cache = NULL;
-	}
+out_destroy_pool:
+	mempool_destroy(virtscsi_cmd_pool);
+out_destroy_cache:
+	kmem_cache_destroy(virtscsi_cmd_cache);
+
 	return ret;
 }
 
-- 
1.8.2.rc2
