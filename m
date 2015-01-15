From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] virtio_pci: drop Kconfig warnings
Date: Thu, 15 Jan 2015 14:18:33 +0200
Message-ID: <1421324298-21749-2-git-send-email-mst@redhat.com>
References: <1421324298-21749-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421324298-21749-1-git-send-email-mst@redhat.com>
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

The ABI *is* stable, and has been for a while now.
Drop Kconfig warning saying that it's not guaranteed
to work.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 8286b63..083fb45 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -17,9 +17,6 @@ config VIRTIO_PCI
 	  virtio backends.  Most QEMU based VMMs should support these devices
 	  (like KVM or Xen).
 
-	  Currently, the ABI is not considered stable so there is no guarantee
-	  that this version of the driver will work with your VMM.
-
 	  If unsure, say M.
 
 config VIRTIO_BALLOON
-- 
MST
