From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 00/13] qemu: MSI-X support
Date: Wed, 10 Jun 2009 15:27:54 +0300
Message-ID: <20090610122754.GA27174__29987.5909615823$1244637186$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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

Here is the port of MSI-X support patches to upstream qemu.
Please comment or commit.

This patchset adds generic support for MSI-X, adds implementation in
APIC, and uses MSI-X in virtio-net.

Changelog:
- since v3
  call to resize_region on load
  split patches a bit differently to address style comments by Glauber
  update commit message to clarify what msix_support flag does
- since v2
  rename mask -> wmask to avoid conflict with work by Yamahata
- since v1
  At Paul's suggestion, use stl_phy to decouple APIC and MSI-X implementation

This uses the mask table patch that I posted previously, and which is
included in the series.

-- 
MST

Michael S. Tsirkin (13):
  qemu: make default_write_config use mask table
  qemu: capability bits in pci save/restore
  qemu: add routines to manage PCI capabilities
  qemu: helper routines for pci access
  qemu: MSI-X support functions
  qemu: add flag to disable MSI-X by default
  qemu: minimal MSI/MSI-X implementation for PC
  qemu: add support for resizing regions
  qemu: virtio support for many interrupt vectors
  qemu: MSI-X support in virtio PCI
  qemu: request 3 vectors in virtio-net
  qemu: virtio save/load bindings
  qemu: add pci_get/set_byte

 Makefile.target    |    2 +-
 hw/apic.c          |   43 +++++-
 hw/msix.c          |  420 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/msix.h          |   35 +++++
 hw/pci.c           |  295 ++++++++++++++++++++-----------------
 hw/pci.h           |  105 +++++++++++++-
 hw/syborg_virtio.c |   13 ++-
 hw/virtio-net.c    |    1 +
 hw/virtio-pci.c    |  216 ++++++++++++++++++++++-----
 hw/virtio.c        |   70 ++++++---
 hw/virtio.h        |   14 ++-
 qemu-options.hx    |    2 +
 vl.c               |    3 +
 13 files changed, 1005 insertions(+), 214 deletions(-)
 create mode 100644 hw/msix.c
 create mode 100644 hw/msix.h
