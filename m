From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [GIT PULL] virtio: features, fixes
Date: Wed, 10 Jun 2020 00:44:55 -0400
Message-ID: <20200610004455-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, alexander.h.duyck@linux.intel.com, anshuman.khandual@arm.com, anthony.yznaga@oracle.com, arei.gonglei@huawei.com, cai@lca.pw, clabbe@baylibre.com, dan.j.williams@intel.com, davem@davemloft.net, david@redhat.com, dyoung@redhat.com, elfring@users.sourceforge.net, glider@google.com, gregkh@linuxfoundation.org, guennadi.liakhovetski@linux.intel.com, hannes@cmpxchg.org, herbert@gondor.apana.org.au, hulkci@huawei.com, imammedo@redhat.com, jasowang@redhat.com, jgross@suse.com, kernelfans@gmail.com, konrad.wilk@oracle.com, lenb@kernel.org, lingshan.zhu@intel.com, linux-acpi@vger.kernel.org, lkp@intel.com, longpeng2@huawei.com, matej.genci@nutanix.
List-Id: virtualization@lists.linuxfoundation.org

There's a single commit here that I tweaked since linux-next - the
change is in printk format string which I consider trivial enough not
force wait for more testing. A couple of hashes are different from
what's in linux-next though.  I also upgraded the machine I used to sign
the tag (didn't change the key) - hope the signature is still ok. If not
pls let me know!

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 044e4b09223039e571e6ec540e25552054208765:

  vhost/test: fix up after API change (2020-06-09 06:42:06 -0400)

----------------------------------------------------------------
virtio: features, fixes

virtio-mem
doorbell mapping for vdpa
config interrupt support in ifc
fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Duyck (1):
      virtio-balloon: Disable free page reporting if page poison reporting is not enabled

David Hildenbrand (17):
      MAINTAINERS: Add myself as virtio-balloon co-maintainer
      virtio-mem: Paravirtualized memory hotplug
      MAINTAINERS: Add myself as virtio-mem maintainer
      virtio-mem: Allow to specify an ACPI PXM as nid
      virtio-mem: Paravirtualized memory hotunplug part 1
      virtio-mem: Paravirtualized memory hotunplug part 2
      mm: Allow to offline unmovable PageOffline() pages via MEM_GOING_OFFLINE
      virtio-mem: Allow to offline partially unplugged memory blocks
      mm/memory_hotplug: Introduce offline_and_remove_memory()
      virtio-mem: Offline and remove completely unplugged memory blocks
      virtio-mem: Better retry handling
      virtio-mem: Add parent resource for all added "System RAM"
      virtio-mem: Drop manual check for already present memory
      virtio-mem: Unplug subblocks right-to-left
      virtio-mem: Use -ETXTBSY as error code if the device is busy
      virtio-mem: Try to unplug the complete online memory block first
      virtio-mem: Don't rely on implicit compiler padding for requests

Guennadi Liakhovetski (1):
      vhost: (cosmetic) remove a superfluous variable initialisation

Jason Wang (4):
      vhost: allow device that does not depend on vhost worker
      vhost: use mmgrab() instead of mmget() for non worker device
      vdpa: introduce get_vq_notification method
      vhost_vdpa: support doorbell mapping via mmap

Longpeng(Mike) (3):
      crypto: virtio: Fix src/dst scatterlist calculation in __virtio_crypto_skcipher_do_req()
      crypto: virtio: Fix use-after-free in virtio_crypto_skcipher_finalize_req()
      crypto: virtio: Fix dest length calculation in __virtio_crypto_skcipher_do_req()

Markus Elfring (1):
      virtio-mmio: Delete an error message in vm_find_vqs()

Matej Genci (1):
      virtio: add VIRTIO_RING_NO_LEGACY

Michael S. Tsirkin (6):
      virtio: force spec specified alignment on types
      vhost: revert "vhost: disable for OABI"
      vhost_vdpa: disable doorbell mapping for !MMU
      virtio-mem: drop unnecessary initialization
      virtio_mem: convert device block size into 64bit
      vhost/test: fix up after API change

Samuel Zou (1):
      vdpasim: Fix some coccinelle warnings

Zhu Lingshan (5):
      ifcvf: move IRQ request/free to status change handlers
      ifcvf: ignore continuous setting same status value
      vhost_vdpa: Support config interrupt in vdpa
      vhost: replace -1 with VHOST_FILE_UNBIND in ioctls
      ifcvf: implement config interrupt in IFCVF

 MAINTAINERS                                |   18 +-
 drivers/acpi/numa/srat.c                   |    1 +
 drivers/crypto/virtio/virtio_crypto_algs.c |   21 +-
 drivers/misc/mic/Kconfig                   |    2 +-
 drivers/net/caif/Kconfig                   |    2 +-
 drivers/vdpa/Kconfig                       |    2 +-
 drivers/vdpa/ifcvf/ifcvf_base.c            |    3 +
 drivers/vdpa/ifcvf/ifcvf_base.h            |    4 +
 drivers/vdpa/ifcvf/ifcvf_main.c            |  146 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c           |    7 +-
 drivers/vhost/Kconfig                      |   17 +-
 drivers/vhost/net.c                        |    2 +-
 drivers/vhost/scsi.c                       |    2 +-
 drivers/vhost/test.c                       |    2 +-
 drivers/vhost/vdpa.c                       |  112 +-
 drivers/vhost/vhost.c                      |  100 +-
 drivers/vhost/vhost.h                      |    8 +-
 drivers/vhost/vringh.c                     |    6 +-
 drivers/vhost/vsock.c                      |    2 +-
 drivers/virtio/Kconfig                     |   17 +
 drivers/virtio/Makefile                    |    1 +
 drivers/virtio/virtio_balloon.c            |    9 +-
 drivers/virtio/virtio_mem.c                | 1965 ++++++++++++++++++++++++++++
 drivers/virtio/virtio_mmio.c               |    4 +-
 drivers/virtio/virtio_pci_modern.c         |    1 +
 include/linux/memory_hotplug.h             |    1 +
 include/linux/page-flags.h                 |   10 +
 include/linux/vdpa.h                       |   16 +
 include/linux/vringh.h                     |    6 +-
 include/uapi/linux/vhost.h                 |    4 +
 include/uapi/linux/virtio_ids.h            |    1 +
 include/uapi/linux/virtio_mem.h            |  211 +++
 include/uapi/linux/virtio_ring.h           |   48 +-
 mm/memory_hotplug.c                        |   81 +-
 mm/page_alloc.c                            |   26 +
 mm/page_isolation.c                        |    9 +
 36 files changed, 2723 insertions(+), 144 deletions(-)
 create mode 100644 drivers/virtio/virtio_mem.c
 create mode 100644 include/uapi/linux/virtio_mem.h
