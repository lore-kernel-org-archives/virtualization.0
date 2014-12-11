From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] virtio_pci_common.h: drop VIRTIO_PCI_NO_LEGACY
Date: Thu, 11 Dec 2014 19:01:37 +0200
Message-ID: <1418317279-13915-4-git-send-email-mst@redhat.com>
References: <1418317279-13915-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418317279-13915-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.or, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Legacy drivers use virtio_pci_common.h too, we should not
define VIRTIO_PCI_NO_LEGACY there.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index d840dad..38d99ad 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -27,7 +27,6 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
-#define VIRTIO_PCI_NO_LEGACY
 #include <linux/virtio_pci.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
-- 
MST
