From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2] virtio_pci: better macro exported in uapi
Date: Sun, 19 May 2013 16:22:25 +0300
Message-ID: <20130519132224.GA23858@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Macro VIRTIO_PCI_CONFIG assumes that userspace actually has a structure
with a field named msix_enabled.  Add VIRTIO_PCI_CONFIG_OFF that gets
the msix_enabled by value instead, to make it useful for userspace.  We
still keep VIRTIO_PCI_CONFIG around for now, in case some userspace uses
it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
- rename macro to VIRTIO_PCI_CONFIG_OFF so preprocessor
  can be used to check for its presence, as suggested
  by Rusty
- keep old macro around as suggested by David Howells

 include/uapi/linux/virtio_pci.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index ea66f3f..e5ec1ca 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -80,7 +80,9 @@
 
 /* The remaining space is defined by each driver as the per-driver
  * configuration space */
-#define VIRTIO_PCI_CONFIG(dev)		((dev)->msix_enabled ? 24 : 20)
+#define VIRTIO_PCI_CONFIG_OFF(msix_enabled)	((msix_enabled) ? 24 : 20)
+/* Deprecated: please use VIRTIO_PCI_CONFIG_OFF instead */
+#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->msix_enabled)
 
 /* Virtio ABI version, this must match exactly */
 #define VIRTIO_PCI_ABI_VERSION		0
-- 
MST
