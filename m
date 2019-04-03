From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] virtio: Fix indentation of VIRTIO_MMIO
Date: Wed,  3 Apr 2019 16:04:09 +0100
Message-ID: <1554303849-26630-1-git-send-email-fabrizio.castro__48249.6726488293$1555717729$gmane$org@bp.renesas.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

VIRTIO_MMIO config option block starts with a space, fix that.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/virtio/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 3589764..1b5c9f0 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -62,12 +62,12 @@ config VIRTIO_INPUT
 
 	 If unsure, say M.
 
- config VIRTIO_MMIO
+config VIRTIO_MMIO
 	tristate "Platform bus driver for memory mapped virtio devices"
 	depends on HAS_IOMEM && HAS_DMA
- 	select VIRTIO
- 	---help---
- 	 This drivers provides support for memory mapped virtio
+	select VIRTIO
+	---help---
+	 This drivers provides support for memory mapped virtio
 	 platform device driver.
 
  	 If unsure, say N.
-- 
2.7.4
