From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 36/85] virtio-mmio: add error check for
	platform_get_irq
Date: Fri, 26 Jul 2019 09:38:46 -0400
Message-ID: <20190726133936.11177-36-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Ihor Matushchak <ihor.matushchak@foobox.net>, virtualization@lists.linux-foundation.org, "Ivan T . Ivanov" <iivanov.xz@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Ihor Matushchak <ihor.matushchak@foobox.net>

[ Upstream commit 5e663f0410fa2f355042209154029842ba1abd43 ]

in vm_find_vqs() irq has a wrong type
so, in case of no IRQ resource defined,
wrong parameter will be passed to request_irq()

Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Ivan T. Ivanov <iivanov.xz@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index f363fbeb5ab0..e09edb5c5e06 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -463,9 +463,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct irq_affinity *desc)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
+	int irq = platform_get_irq(vm_dev->pdev, 0);
 	int i, err, queue_idx = 0;
 
+	if (irq < 0) {
+		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
+		return irq;
+	}
+
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
 	if (err)
-- 
2.20.1
