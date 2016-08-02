From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0095/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:40:17 +0800
Message-ID: <20160802104017.20091-1-baolex.ni__1126.11843874237$1470143372$gmane$org@intel.com>
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
To: mst@redhat.com, pjk1939@linux.vnet.ibm.com, pavel@ucw.cz, gregkh@linuxfoundation.org, hpa@zytor.com, x86@kernel.org
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, baolex.ni@intel.com, chuansheng.liu@intel.com, kent.overstreet@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42758b5..786a393 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -561,7 +561,7 @@ static struct blk_mq_ops virtio_mq_ops = {
 };
 
 static unsigned int virtblk_queue_depth;
-module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
+module_param_named(queue_depth, virtblk_queue_depth, uint, S_IRUSR | S_IRGRP | S_IROTH);
 
 static int virtblk_probe(struct virtio_device *vdev)
 {
-- 
2.9.2
