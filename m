From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [RFC PATCH] virt_mmio: fix signature checking for BE guests
Date: Wed, 13 Feb 2013 14:25:38 +0000
Message-ID: <1360765538-18097-1-git-send-email-marc.zyngier@arm.com>
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
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Using readl() to read the magic value and then memcmp() to check it
fails on BE, as bytes will be the other way around (by virtue of
the registers to follow the endianess of the guest).

Fix it by encoding the magic as an integer instead of a string.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
So I'm not completely sure this is the right fix, and I can imagine
other ways to cure the problem:
- Reading the MAGIC register byte by byte. Is that allowed? The spec
  only says it is 32bit wide.
- Using __raw_readl() instead. Is that a generic enough API?

 drivers/virtio/virtio_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 31f966f..3811e94 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -470,7 +470,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
-	if (memcmp(&magic, "virt", 4) != 0) {
+	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
 		return -ENODEV;
 	}
-- 
1.8.1.2
