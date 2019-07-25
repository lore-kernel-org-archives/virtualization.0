From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: [PATCH 2/4] virtio_pci: Define virtio_pci_cap64
Date: Thu, 25 Jul 2019 18:50:42 +0100
Message-ID: <20190725175044.29303-3-dgilbert@redhat.com>
References: <20190725175044.29303-1-dgilbert@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190725175044.29303-1-dgilbert@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, mst@redhat.com, jasowang@redhat.com
Cc: sebastien.boeuf@intel.com, vgoyal@redhat.com, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define 'virtio_pci_cap64' to allow capabilities to describe
memory regions larger than, or with an offset larger than 4GiB.

This will be used by the shared memory region capability.

Defined in virtio spec commit 8100dcfcd622 ("pci: Define virtio_pci_cap64")

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/uapi/linux/virtio_pci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 9defe4a124c5..11e508719dfd 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -127,6 +127,12 @@ struct virtio_pci_cap {
 	__le32 length;		/* Length of the structure, in bytes. */
 };
 
+struct virtio_pci_cap64 {
+	struct virtio_pci_cap cap;
+	__le32 offset_hi;	/* Most sig 32 bits of offset */
+	__le32 length_hi;	/* Most sig 32 bits of length */
+};
+
 struct virtio_pci_notify_cap {
 	struct virtio_pci_cap cap;
 	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
-- 
2.21.0
