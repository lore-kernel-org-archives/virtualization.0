From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH v3 2/2] virtio_mmio: add cleanup for virtio_mmio_remove
Date: Wed, 6 Dec 2017 21:59:32 +0800
Message-ID: <1a62b93b539bcde52f629314f04193928f02693e.1512568542.git.zhangweiping@didichuxing.com>
References: <cover.1512568542.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1512568542.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

cleanup all resource allocated by virtio_mmio_probe.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/virtio/virtio_mmio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index ec40104..a9192fe 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -610,7 +610,13 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 static int virtio_mmio_remove(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
+	struct resource *mem;
 
+	iounmap(vm_dev->base);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (mem)
+		devm_release_mem_region(&pdev->dev, mem->start,
+			resource_size(mem));
 	unregister_virtio_device(&vm_dev->vdev);
 
 	return 0;
-- 
2.9.4
