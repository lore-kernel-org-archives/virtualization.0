From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: [PATCH 3/4] virtio_pci: Defined shared memory capability
Date: Thu, 25 Jul 2019 18:50:43 +0100
Message-ID: <20190725175044.29303-4-dgilbert@redhat.com>
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

Define the PCI capability used for enumerating shared memory regions.
Each capability contains a 'struct virtio_pci_cap64'
Multiple capabilities of this type may exist for a device and may
be distinguished using the 'cap.id' field.

Defined in virtio spec commit 855ad7af2bd64 ("shared memory: Define PCI capability")

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/uapi/linux/virtio_pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 11e508719dfd..401a5d6851f1 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG	4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG		5
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
-- 
2.21.0
