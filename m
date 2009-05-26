From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] qemu: fix pci_find_capability for multiple caps
Date: Tue, 26 May 2009 12:30:27 +0300
Message-ID: <20090526093027.GC8588@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<20090525122520.GD5046@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090525122520.GD5046@redhat.com>
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

pci_find_capability_list has a bug so it'd stop at the first
capability. This only happens to work as we only support
a single capability (MSI-X). Here's a fix.

Found-by: Isaku Yamahata <yamahata@valinux.co.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

This is a fixup for my patch "qemu: add routines to manage PCI
capabilities".

 hw/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hw/pci.c b/hw/pci.c
index 19905b9..a63d988 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -918,7 +918,7 @@ static uint8_t pci_find_capability_list(PCIDevice *pdev, uint8_t cap_id,
 
     for (prev = PCI_CAPABILITY_LIST; (next = pdev->config[prev]);
          prev = next + PCI_CAP_LIST_NEXT)
-        if (pdev->config[next + PCI_CAP_LIST_ID] != cap_id)
+        if (pdev->config[next + PCI_CAP_LIST_ID] == cap_id)
             break;
 
     *prev_p = prev;

-- 
MST
