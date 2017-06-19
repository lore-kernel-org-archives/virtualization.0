From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] virtio: virtio_mmio: make of_device_ids const.
Date: Mon, 19 Jun 2017 11:44:41 +0530
Message-ID: <f31acbc59cd01a42749c31b6558eefbce508e730.1497852750.git.arvind.yadav.cs__45490.5152357698$1509078053$gmane$org@gmail.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   3647	    608	      0	   4255	   109f	drivers/virtio/virtio_mmio.o

File size after constify virtio_mmio_match.
   text	   data	    bss	    dec	    hex	filename
   4063	    192	      0	   4255	   109f	drivers/virtio/virtio_mmio.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/virtio/virtio_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 74dc717..badf61d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -713,7 +713,7 @@ static void vm_unregister_cmdline_devices(void)
 
 /* Platform driver */
 
-static struct of_device_id virtio_mmio_match[] = {
+static const struct of_device_id virtio_mmio_match[] = {
 	{ .compatible = "virtio,mmio", },
 	{},
 };
-- 
1.9.1
