From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: define virtio_pci_cfg_cap in header.
Date: Thu, 2 Jul 2015 12:52:12 +0200
Message-ID: <1435834327-11479-1-git-send-email-mst__24901.0762236596$1435834352$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: linux-api@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We already have VIRTIO_PCI_CAP_PCI_CFG, let's define the structure that
goes with it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_pci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 7530146..90007a1 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -157,6 +157,12 @@ struct virtio_pci_common_cfg {
 	__le32 queue_used_hi;		/* read-write */
 };
 
+/* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
+struct virtio_pci_cfg_cap {
+	struct virtio_pci_cap cap;
+	__u8 pci_cfg_data[4]; /* Data for BAR access. */
+};
+
 /* Macro versions of offsets for the Old Timers! */
 #define VIRTIO_PCI_CAP_VNDR		0
 #define VIRTIO_PCI_CAP_NEXT		1
-- 
MST
