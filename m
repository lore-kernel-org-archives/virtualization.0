From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] virtio_blk: fix comment for virtio 1.0
Date: Sun, 1 Mar 2015 08:39:19 +0100
Message-ID: <1425192883-5930-3-git-send-email-mst@redhat.com>
References: <1425192883-5930-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1425192883-5930-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Fix up comment to match virtio 1.0 logic:
virtio_blk_outhdr isn't the first elements anymore,
the only requirement is that it comes first in
the s/g list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_blk.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index b695ba9..19c66fc 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -119,7 +119,11 @@ struct virtio_blk_config {
 #define VIRTIO_BLK_T_BARRIER	0x80000000
 #endif /* !VIRTIO_BLK_NO_LEGACY */
 
-/* This is the first element of the read scatter-gather list. */
+/*
+ * This comes first in the read scatter-gather list.
+ * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated,
+ * this is the first element of the read scatter-gather list.
+ */
 struct virtio_blk_outhdr {
 	/* VIRTIO_BLK_T* */
 	__virtio32 type;
-- 
MST
