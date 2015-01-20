From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 04/05] fixup! virtio_pci: add module param to force legacy mode
Date: Tue, 20 Jan 2015 18:25:16 +0200
Message-ID: <1421771093-1589-5-git-send-email-mst@redhat.com>
References: <1421771093-1589-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421771093-1589-1-git-send-email-mst@redhat.com>
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

virtio modern: fix up fallback logic with force_legacy

This bails out if legacy driver succeeds - not what we wanted.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 0f87b99..e894eb2 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -516,18 +516,14 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	if (force_legacy) {
 		rc = virtio_pci_legacy_probe(vp_dev);
 		/* Also try modern mode if we can't map BAR0 (no IO space). */
-		if (rc != -ENODEV && rc != -ENOMEM)
-			return rc;
-
-		rc = virtio_pci_modern_probe(vp_dev);
+		if (rc == -ENODEV || rc == -ENOMEM)
+			rc = virtio_pci_modern_probe(vp_dev);
 		if (rc)
 			goto err_probe;
 	} else {
 		rc = virtio_pci_modern_probe(vp_dev);
-		if (rc != -ENODEV)
-			return rc;
-
-		rc = virtio_pci_legacy_probe(vp_dev);
+		if (rc == -ENODEV)
+			rc = virtio_pci_legacy_probe(vp_dev);
 		if (rc)
 			goto err_probe;
 	}
-- 
MST
