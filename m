From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio-next
Date: Wed, 18 Feb 2015 15:45:12 +1030
Message-ID: <87y4nvssv3.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Tony Luck <tony.luck@intel.com>, kvm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Fenghua Yu <fenghua.yu@intel.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-pci@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Isaku Yamahata <yamahata@valinux.co.jp>, Pawel Moll <pawel.moll@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sasha Levin <sasha.levin@oracle.com>, Alok Kataria <akataria@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit b97f880c8342fd6e49a02c9ef7507a678722b2b3:

  Merge branch 'for-3.19-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata (2015-01-21 07:54:16 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git tags/virtio-next-for-linus

for you to fetch changes up to 5b40a7daf51812b35cf05d1601a779a7043f8414:

  virtio: don't set VIRTIO_CONFIG_S_DRIVER_OK twice. (2015-02-17 16:19:29 +1030)

----------------------------------------------------------------
OK, this has the big virtio 1.0 implementation, as specified by OASIS.

On top of tht is the major rework of lguest, to use PCI and virtio 1.0, to
double-check the implementation.

Then comes the inevitable fixes and cleanups from that work.

Thanks,
Rusty.

----------------------------------------------------------------
Luis R. Rodriguez (1):
      virtual: Documentation: simplify and generalize paravirt_ops.txt

Michael S. Tsirkin (23):
      virtio_pci: drop virtio_config dependency
      virtio/9p: verify device has config space
      virtio/blk: verify device has config space
      virtio/console: verify device has config space
      virtio/net: verify device has config space
      virtio/scsi: verify device has config space
      virtio/balloon: verify device has config space
      mn10300: drop dead code
      pci: add pci_iomap_range
      s390: add pci_iomap_range
      virtio_pci: move probe/remove code to common
      virtio_pci: modern driver
      virtio_pci_modern: reduce number of mappings
      virtio_pci_modern: support devices with no config
      virtio_balloon: coding style fixes
      virtio_blk: coding style fixes
      virtio_ring: coding style fix
      virtio_rng: drop extra empty line
      virtio_pci: Kconfig grammar fix
      virtio_pci: drop Kconfig warnings
      virtio_pci: add an option to disable legacy driver
      virtio_pci: add module param to force legacy mode
      virtio_pci_modern: drop an unused function

Pawel Moll (1):
      virtio-mmio: Update the device to OASIS spec version

Rusty Russell (53):
      virtio-pci: define layout for virtio 1.0
      virtio_pci: macros for PCI layout offsets
      virtio: define VIRTIO_PCI_CAP_PCI_CFG in header.
      virtio: Don't expose legacy block features when VIRTIO_BLK_NO_LEGACY defined.
      virtio: Don't expose legacy config features when VIRTIO_CONFIG_NO_LEGACY defined.
      virtio_pci: use 16-bit accessor for queue_enable.
      virtio: don't require a config space on the console device.
      lguest: have --rng read from /dev/urandom not /dev/random.
      lguest: add operations to get/set a register from the Launcher.
      lguest: write more information to userspace about pending traps.
      lguest: add infrastructure for userspace to deliver a trap to the guest.
      lguest: add infrastructure to check mappings.
      lguest: send trap 13 through to userspace.
      lguest: suppress PS/2 keyboard polling.
      lguest: don't disable iospace.
      lguest: add iomem region, where guest page faults get sent to userspace.
      lguest: disable ACPI explicitly.
      lguest: Override pcibios_enable_irq/pcibios_disable_irq to our stupid PIC
      lguest: add MMIO region allocator in example launcher.
      lguest: decode mmio accesses for PCI in example launcher.
      lguest: add PCI config space emulation to example launcher.
      lguest: implement virtio-PCI MMIO accesses.
      lguest: fix failure to find linux/virtio_types.h
      lguest: add a dummy PCI host bridge.
      lguest: Convert block device to virtio 1.0 PCI.
      lguest: Convert net device to virtio 1.0 PCI.
      lguest: Convert entropy device to virtio 1.0 PCI.
      lguest: Convert console device to virtio 1.0 PCI.
      lguest: define VIRTIO_CONFIG_NO_LEGACY in example launcher.
      lguest: remove support for lguest bus.
      lguest: remove support for lguest bus in demonstration launcher.
      lguest: remove lguest bus definitions from header.
      lguest: support emerg_wr in console device in example launcher.
      lguest: support backdoor window.
      lguest: always put console in PCI slot #1.
      lguest: use the PCI console device's emerg_wr for early boot messages.
      lguest: remove NOTIFY facility from demonstration launcher.
      lguest: remove NOTIFY call and eventfd facility.
      tools/lguest: handle device reset correctly in example launcher.
      tools/lguest: fix features_accepted logic in example launcher.
      tools/lguest: rename virtio_pci_cfg_cap field to match spec.
      tools/lguest: insert device references from the 1.0 spec (4.1 Virtio Over PCI)
      tools/lguest: insert driver references from the 1.0 spec (4.1 Virtio Over PCI)
      tools/lguest: handle indirect partway through chain.
      tools/lguest: don't start devices until DRIVER_OK status set.
      lguest: don't look in console features to find emerg_wr.
      tools/lguest: more documentation and checking of virtio 1.0 compliance.
      tools/lguest: give virtqueues names for better error messages
      tools/lguest: use common error macros in the example launcher.
      virtio: Don't expose legacy net features when VIRTIO_NET_NO_LEGACY defined.
      tools/lguest: don't use legacy definitions for net device in example launcher.
      virtio_net: unconditionally define struct virtio_net_hdr_v1.
      virtio: don't set VIRTIO_CONFIG_S_DRIVER_OK twice.

Sasha Levin (1):
      virtio_pci: drop useless del_vqs call

Tetsuo Handa (1):
      virtio: Avoid possible kernel panic if DEBUG is enabled.

 Documentation/ia64/paravirt_ops.txt    |  137 ---
 Documentation/virtual/00-INDEX         |    3 +
 Documentation/virtual/paravirt_ops.txt |   32 +
 MAINTAINERS                            |    2 +-
 arch/mn10300/unit-asb2305/pci-iomap.c  |   35 -
 arch/s390/include/asm/pci_io.h         |    1 +
 arch/s390/pci/pci.c                    |   34 +-
 arch/x86/include/asm/lguest_hcall.h    |    1 -
 arch/x86/lguest/boot.c                 |  173 ++-
 drivers/block/virtio_blk.c             |   12 +-
 drivers/char/hw_random/virtio-rng.c    |    1 -
 drivers/char/virtio_console.c          |    9 +
 drivers/lguest/Makefile                |    3 -
 drivers/lguest/core.c                  |   29 +-
 drivers/lguest/hypercalls.c            |    7 +-
 drivers/lguest/lg.h                    |   26 +-
 drivers/lguest/lguest_device.c         |  540 ---------
 drivers/lguest/lguest_user.c           |  221 +---
 drivers/lguest/page_tables.c           |   75 +-
 drivers/lguest/x86/core.c              |  198 ++--
 drivers/net/virtio_net.c               |    6 +
 drivers/scsi/virtio_scsi.c             |    6 +
 drivers/virtio/Kconfig                 |   24 +-
 drivers/virtio/Makefile                |    3 +-
 drivers/virtio/virtio.c                |    5 +-
 drivers/virtio/virtio_balloon.c        |    9 +-
 drivers/virtio/virtio_mmio.c           |  131 ++-
 drivers/virtio/virtio_pci_common.c     |   94 +-
 drivers/virtio/virtio_pci_common.h     |   43 +-
 drivers/virtio/virtio_pci_legacy.c     |   76 +-
 drivers/virtio/virtio_pci_modern.c     |  695 +++++++++++
 drivers/virtio/virtio_ring.c           |    9 +-
 include/asm-generic/pci_iomap.h        |   10 +
 include/linux/lguest_launcher.h        |   61 +-
 include/linux/virtio_mmio.h            |   44 +-
 include/uapi/linux/virtio_balloon.h    |    3 +-
 include/uapi/linux/virtio_blk.h        |   17 +-
 include/uapi/linux/virtio_config.h     |    2 +
 include/uapi/linux/virtio_net.h        |   42 +-
 include/uapi/linux/virtio_pci.h        |   93 +-
 lib/pci_iomap.c                        |   35 +-
 net/9p/trans_virtio.c                  |    6 +
 tools/lguest/Makefile                  |    8 +-
 tools/lguest/lguest.c                  | 2016 ++++++++++++++++++++++++++------
 44 files changed, 3372 insertions(+), 1605 deletions(-)
 delete mode 100644 Documentation/ia64/paravirt_ops.txt
 create mode 100644 Documentation/virtual/paravirt_ops.txt
 delete mode 100644 arch/mn10300/unit-asb2305/pci-iomap.c
 delete mode 100644 drivers/lguest/lguest_device.c
 create mode 100644 drivers/virtio/virtio_pci_modern.c
