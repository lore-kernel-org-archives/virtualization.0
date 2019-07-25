From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: [PATCH 1/4] virtio_pci: Define id field
Date: Thu, 25 Jul 2019 18:50:41 +0100
Message-ID: <20190725175044.29303-2-dgilbert@redhat.com>
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

The new virtio-shared memory region system allows multiple regions
to be defined for a device; each of these is the same type of
capability.
To allow multiple capabilities of the same type, create
an 'id' field to differentiate them.

Defined in virtio spec commit 39dfc8afc0b93 ("pci: Define id field")

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/uapi/linux/virtio_pci.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1abcab..9defe4a124c5 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -121,7 +121,8 @@ struct virtio_pci_cap {
 	__u8 cap_len;		/* Generic PCI field: capability length */
 	__u8 cfg_type;		/* Identifies the structure. */
 	__u8 bar;		/* Where to find it. */
-	__u8 padding[3];	/* Pad to full dword. */
+	__u8 id;		/* Multiple capabilities of the same type */
+	__u8 padding[2];	/* Pad to full dword. */
 	__le32 offset;		/* Offset within bar. */
 	__le32 length;		/* Length of the structure, in bytes. */
 };
-- 
2.21.0
