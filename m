From: Xianting Tian <xianting_tian@126.com>
Subject: [PATCH] scsi: virtio_scsi: remove unnecessary condition check
Date: Thu,  9 Jul 2020 10:46:32 -0400
Message-ID: <1594305992-8458-1-git-send-email-xianting_tian@126.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

kmem_cache_destroy can correctly handle null pointer parameter,
so there is no need to check if the parameter is null before
calling kmem_cache_destroy.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 drivers/scsi/virtio_scsi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index bfec84a..5bc288f 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -1007,10 +1007,8 @@ static int __init init(void)
 		mempool_destroy(virtscsi_cmd_pool);
 		virtscsi_cmd_pool = NULL;
 	}
-	if (virtscsi_cmd_cache) {
-		kmem_cache_destroy(virtscsi_cmd_cache);
-		virtscsi_cmd_cache = NULL;
-	}
+	kmem_cache_destroy(virtscsi_cmd_cache);
+	virtscsi_cmd_cache = NULL;
 	return ret;
 }
 
-- 
1.8.3.1
