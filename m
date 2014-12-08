From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/9] virtio_pci: fix coding style for structs
Date: Mon, 8 Dec 2014 15:06:18 +0200
Message-ID: <1418043812-25753-3-git-send-email-mst@redhat.com>
References: <1418043812-25753-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418043812-25753-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

should be

struct foo {
}

not

struct foo
{
}

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index ee1b54c..6f3db1f 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -32,8 +32,7 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION("1");
 
 /* Our device structure */
-struct virtio_pci_device
-{
+struct virtio_pci_device {
 	struct virtio_device vdev;
 	struct pci_dev *pci_dev;
 
@@ -72,8 +71,7 @@ enum {
 	VP_MSIX_VQ_VECTOR = 1,
 };
 
-struct virtio_pci_vq_info
-{
+struct virtio_pci_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
 
-- 
MST
