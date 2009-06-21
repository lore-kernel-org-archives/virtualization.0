From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv6 00/12] qemu: MSI-X support
Date: Sun, 21 Jun 2009 19:44:57 +0300
Message-ID: <20090621164457.GA10164__21843.4012881064$1245602931$gmane$org@redhat.com>
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
- since v5
  make sure that load does not modify registers that guest can not change
  replace global msix disable flag with a per-device flag to control the number of vectors
- since v4
  rebased to latest bits
- since v3
  call to resize_region on load
  split patches a bit differently to address style comments by Glauber
  update commit message to clarify what msix_support flag does
- since v2
  rename mask -> wmask to avoid conflict with work by Yamahata
- since v1
  At Paul's suggestion, use stl_phy to decouple APIC and MSI-X implementation

This uses the mask table patch that I posted previously, and which is
included in the series. That patch has been slightly updated due
to mask -> wmask rename. Isaku Yamahata, maybe you want to
update your patch series with that.

-- 
MST

Michael S. Tsirkin (12):
  qemu/pci: make default_write_config use mask table
  qemu/pci: helper routines for pci access
  qemu/pci: add routines to manage PCI capabilities
  qemu/pci: check constant registers on load
  qemu/pci: MSI-X support functions
  qemu/apic: minimal MSI/MSI-X implementation for PC
  qemu/virtio: virtio support for many interrupt vectors
  qemu/virtio: MSI-X support in virtio PCI
  qemu/virtio: virtio save/load bindings
  qemu/pci: add pci_get/set_byte
  qemu/net: request 3 vectors in virtio-net
  qemu/net: flag to control the number of vectors a nic has

 Makefile.target    |    2 +-
 hw/apic.c          |   43 ++++++-
 hw/msix.c          |  378 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/msix.h          |   34 +++++
 hw/pci.c           |  245 ++++++++++++++++++----------------
 hw/pci.h           |  106 ++++++++++++++-
 hw/syborg_virtio.c |   13 ++-
 hw/virtio-net.c    |    4 +
 hw/virtio-pci.c    |  212 +++++++++++++++++++++++------
 hw/virtio.c        |   70 +++++++---
 hw/virtio.h        |   14 ++-
 net.c              |   18 +++-
 net.h              |    4 +
 qemu-options.hx    |   14 +-
 rules.mak          |    2 +-
 15 files changed, 956 insertions(+), 203 deletions(-)
 create mode 100644 hw/msix.c
 create mode 100644 hw/msix.h
