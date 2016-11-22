From: Gonglei <arei.gonglei@huawei.com>
Subject: [PATCH 1/2] virtio_pci_modern: fix complaint by sparse
Date: Tue, 22 Nov 2016 13:51:49 +0800
Message-ID: <1479793910-120188-2-git-send-email-arei.gonglei@huawei.com>
References: <1479793910-120188-1-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1479793910-120188-1-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Gonglei <arei.gonglei@huawei.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

drivers/virtio/virtio_pci_modern.c:66:40: warning: incorrect type in argument 2 (different base types)
drivers/virtio/virtio_pci_modern.c:66:40:    expected unsigned int [noderef] [usertype] <asn:2>*addr
drivers/virtio/virtio_pci_modern.c:66:40:    got restricted __le32 [noderef] [usertype] <asn:2>*lo
drivers/virtio/virtio_pci_modern.c:67:33: warning: incorrect type in argument 2 (different base types)
drivers/virtio/virtio_pci_modern.c:67:33:    expected unsigned int [noderef] [usertype] <asn:2>*addr
drivers/virtio/virtio_pci_modern.c:67:33:    got restricted __le32 [noderef] [usertype] <asn:2>*hi
drivers/virtio/virtio_pci_modern.c:150:32: warning: incorrect type in argument 2 (different base types)
drivers/virtio/virtio_pci_modern.c:150:32:    expected unsigned int [noderef] [usertype] <asn:2>*addr
drivers/virtio/virtio_pci_modern.c:150:32:    got restricted __le32 [noderef] <asn:2>*<noident>
drivers/virtio/virtio_pci_modern.c:151:39: warning: incorrect type in argument 1 (different base types)
drivers/virtio/virtio_pci_modern.c:151:39:    expected unsigned int [noderef] [usertype] <asn:2>*addr
drivers/virtio/virtio_pci_modern.c:151:39:    got restricted __le32 [noderef] <asn:2>*<noident>
drivers/virtio/virtio_pci_modern.c:152:32: warning: incorrect type in argument 2 (different base types)
drivers/virtio/virtio_pci_modern.c:152:32:    expected unsigned int [noderef] [usertype] <asn:2>*addr

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 drivers/virtio/virtio_pci_modern.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e76bd91..4bf7ab3 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -33,12 +33,12 @@ static inline u8 vp_ioread8(u8 __iomem *addr)
 {
 	return ioread8(addr);
 }
-static inline u16 vp_ioread16 (u16 __iomem *addr)
+static inline u16 vp_ioread16 (__le16 __iomem *addr)
 {
 	return ioread16(addr);
 }
 
-static inline u32 vp_ioread32(u32 __iomem *addr)
+static inline u32 vp_ioread32(__le32 __iomem *addr)
 {
 	return ioread32(addr);
 }
@@ -48,12 +48,12 @@ static inline void vp_iowrite8(u8 value, u8 __iomem *addr)
 	iowrite8(value, addr);
 }
 
-static inline void vp_iowrite16(u16 value, u16 __iomem *addr)
+static inline void vp_iowrite16(u16 value, __le16 __iomem *addr)
 {
 	iowrite16(value, addr);
 }
 
-static inline void vp_iowrite32(u32 value, u32 __iomem *addr)
+static inline void vp_iowrite32(u32 value, __le32 __iomem *addr)
 {
 	iowrite32(value, addr);
 }
-- 
1.8.3.1
