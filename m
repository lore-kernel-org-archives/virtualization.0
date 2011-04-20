From: Liu Yuan <namei.unix@gmail.com>
Subject: [PATCH] driver, virtio: Modify the err hanlding logic
Date: Wed, 20 Apr 2011 21:21:59 +0800
Message-ID: <1303305719-4475-1-git-send-email-namei.unix__10332.7996483587$1303316363$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Liu Yuan <tailai.ly@taobao.com>

In the function vp_request_msix_vectors(), when
pci_enable_msix() returns 0, there will be
redundant double checks for 'err'. This patch
fixes it to avoid the unnecessary check.

Signed-off-by: Liu Yuan <tailai.ly@taobao.com>
---
 drivers/virtio/virtio_pci.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 4fb5b2b..2c05376 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -298,10 +298,11 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 
 	/* pci_enable_msix returns positive if we can't get this many. */
 	err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries, nvectors);
-	if (err > 0)
-		err = -ENOSPC;
-	if (err)
+	if (err) {
+		if (err > 0)
+			err = -ENOSPC;
 		goto error;
+	}
 	vp_dev->msix_vectors = nvectors;
 	vp_dev->msix_enabled = 1;
 
-- 
1.7.1
