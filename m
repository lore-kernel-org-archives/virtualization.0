From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v5 00/19] qemu: towards virtio-1 host support
Date: Tue,  2 Dec 2014 14:00:08 +0100
Message-ID: <1417525227-14051-1-git-send-email-cornelia.huck__6943.81678845293$1417525283$gmane$org@de.ibm.com>
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
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Another iteration of virtio-1 patches for qemu, as always available on
git://github.com/cohuck/qemu virtio-1

This one seems to work together with the current vhost-next patches
(well, I can ping :)

Changes from v4:
- add helpers for feature bit manipulation and checking
- use 64 bit feature bits instead of 32 bit arrays
- infrastructure to allow devices to offer different sets of feature
  bits for legacy and standard devices
- several fixes (mainly regarding, you guessed it, feature bits)

Cornelia Huck (16):
  virtio: cull virtio_bus_set_vdev_features
  virtio: feature bit manipulation helpers
  virtio: add feature checking helpers
  virtio: support more feature bits
  virtio: endianness checks for virtio 1.0 devices
  virtio: allow virtio-1 queue layout
  dataplane: allow virtio-1 devices
  s390x/virtio-ccw: support virtio-1 set_vq format
  virtio: disallow late feature changes for virtio-1
  virtio: allow to fail setting status
  s390x/virtio-ccw: enable virtio 1.0
  virtio-net: no writeable mac for virtio-1
  virtio-net: support longer header
  virtio-net: enable virtio 1.0
  virtio: support revision-specific features
  virtio-blk: revision specific feature bits

Thomas Huth (3):
  linux-headers/virtio_config: Update with VIRTIO_F_VERSION_1
  s390x/css: Add a callback for when subchannel gets disabled
  s390x/virtio-ccw: add virtio set-revision call

 hw/9pfs/virtio-9p-device.c                    |    4 +-
 hw/block/dataplane/virtio-blk.c               |    4 +-
 hw/block/virtio-blk.c                         |   44 +++--
 hw/char/virtio-serial-bus.c                   |    6 +-
 hw/net/virtio-net.c                           |  100 ++++++-----
 hw/s390x/css.c                                |   12 ++
 hw/s390x/css.h                                |    1 +
 hw/s390x/s390-virtio-bus.c                    |    3 +-
 hw/s390x/s390-virtio-bus.h                    |    2 +-
 hw/s390x/virtio-ccw.c                         |  235 ++++++++++++++++++-------
 hw/s390x/virtio-ccw.h                         |    8 +-
 hw/scsi/vhost-scsi.c                          |    3 +-
 hw/scsi/virtio-scsi-dataplane.c               |    2 +-
 hw/scsi/virtio-scsi.c                         |   12 +-
 hw/virtio/Makefile.objs                       |    2 +-
 hw/virtio/dataplane/Makefile.objs             |    2 +-
 hw/virtio/dataplane/vring.c                   |   96 +++++-----
 hw/virtio/virtio-balloon.c                    |    4 +-
 hw/virtio/virtio-bus.c                        |   24 ++-
 hw/virtio/virtio-mmio.c                       |    6 +-
 hw/virtio/virtio-pci.c                        |    7 +-
 hw/virtio/virtio-pci.h                        |    2 +-
 hw/virtio/virtio-rng.c                        |    2 +-
 hw/virtio/virtio.c                            |   83 +++++++--
 include/hw/qdev-properties.h                  |   11 ++
 include/hw/virtio/dataplane/vring-accessors.h |   75 ++++++++
 include/hw/virtio/dataplane/vring.h           |   14 +-
 include/hw/virtio/virtio-access.h             |    4 +
 include/hw/virtio/virtio-bus.h                |   14 +-
 include/hw/virtio/virtio-net.h                |   46 ++---
 include/hw/virtio/virtio-scsi.h               |    6 +-
 include/hw/virtio/virtio.h                    |   61 +++++--
 linux-headers/linux/virtio_config.h           |    3 +
 33 files changed, 625 insertions(+), 273 deletions(-)
 create mode 100644 include/hw/virtio/dataplane/vring-accessors.h

-- 
1.7.9.5
