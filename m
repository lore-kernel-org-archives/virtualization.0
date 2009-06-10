From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 13/13] qemu: add pci_get/set_byte
Date: Wed, 10 Jun 2009 15:29:33 +0300
Message-ID: <20090610122933.GN27174__10233.5707437762$1244638659$gmane$org@redhat.com>
References: <cover.1244635350.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1244635350.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>, qemu-devel@nongnu.org, Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Rusty Russell <rusty@rustcor>
List-Id: virtualization@lists.linuxfoundation.org

Add pci_get/set_byte to keep *_word and *_long access functions company.
They are unused for now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/hw/pci.h b/hw/pci.h
index 9455e4c..07404c5 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -259,6 +259,18 @@ PCIBus *pci_bridge_init(PCIBus *bus, int devfn, uint16_t vid, uint16_t did,
                         pci_map_irq_fn map_irq, const char *name);
 
 static inline void
+pci_set_byte(uint8_t *config, uint8_t val)
+{
+    *config = val;
+}
+
+static inline uint8_t
+pci_get_byte(uint8_t *config)
+{
+    return *config;
+}
+
+static inline void
 pci_set_word(uint8_t *config, uint16_t val)
 {
     cpu_to_le16wu((uint16_t *)config, val);
-- 
1.6.3.1.56.g79e1.dirty
