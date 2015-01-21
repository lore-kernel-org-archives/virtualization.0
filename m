From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH pre-squash 06/14] fixup! virtio_pci: modern driver
Date: Wed, 21 Jan 2015 17:00:22 +0200
Message-ID: <1421852375-22604-7-git-send-email-mst@redhat.com>
References: <1421852375-22604-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421852375-22604-1-git-send-email-mst@redhat.com>
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

virtio modern: fix up fallback logic

This bails out if modern driver succeeds - not what we wanted.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 20c7638..8ae34a3 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -506,10 +506,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 		goto err_request_regions;
 
 	rc = virtio_pci_modern_probe(vp_dev);
-	if (rc != -ENODEV)
-		return rc;
-
-	rc = virtio_pci_legacy_probe(vp_dev);
+	if (rc == -ENODEV)
+		rc = virtio_pci_legacy_probe(vp_dev);
 	if (rc)
 		goto err_probe;
 
-- 
MST
