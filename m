From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 00/20] qemu: towards virtio-1 host support
Date: Thu, 11 Dec 2014 14:25:02 +0100
Message-ID: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
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
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

And yet another iteration of virtio-1 support in qemu, tested with the
latest virtio kernel patches. Find it at

    git://github.com/cohuck/qemu virtio-1

Changes from v5:
- fixed stupid bug in "virtio: support more feature bits": we need to
  define a proper prop backend for 64 bit wide handling...
- don't negotiate revision 1 unless VERSION_1 is offered
- use 64 bit wide features in the whole of vhost (patch can probably be
  merged into the 64 bit extension for the rest of the code)

The bug I suspected in the revision-specific feature handling turned out
to be a messup on my side. There still seems to be something missing for
vhost-net to support virtio-1.

Cornelia Huck (17):
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
  vhost: 64 bit features

Thomas Huth (3):
  linux-headers/virtio_config: Update with VIRTIO_F_VERSION_1
  s390x/css: Add a callback for when subchannel gets disabled
  s390x/virtio-ccw: add virtio set-revision call

 hw/9pfs/virtio-9p-device.c                    |    4 +-
 hw/block/dataplane/virtio-blk.c               |    4 +-
 hw/block/virtio-blk.c                         |   44 +++--
 hw/char/virtio-serial-bus.c                   |    6 +-
 hw/core/qdev-properties.c                     |   58 ++++++
 hw/net/vhost_net.c                            |   12 +-
 hw/net/virtio-net.c                           |  100 ++++++-----
 hw/s390x/css.c                                |   12 ++
 hw/s390x/css.h                                |    1 +
 hw/s390x/s390-virtio-bus.c                    |    3 +-
 hw/s390x/s390-virtio-bus.h                    |    2 +-
 hw/s390x/virtio-ccw.c                         |  234 ++++++++++++++++++-------
 hw/s390x/virtio-ccw.h                         |   13 +-
 hw/scsi/vhost-scsi.c                          |    3 +-
 hw/scsi/virtio-scsi-dataplane.c               |    2 +-
 hw/scsi/virtio-scsi.c                         |   12 +-
 hw/virtio/Makefile.objs                       |    2 +-
 hw/virtio/dataplane/Makefile.objs             |    2 +-
 hw/virtio/dataplane/vring.c                   |   96 +++++-----
 hw/virtio/vhost.c                             |   14 +-
 hw/virtio/virtio-balloon.c                    |    4 +-
 hw/virtio/virtio-bus.c                        |   24 ++-
 hw/virtio/virtio-mmio.c                       |    9 +-
 hw/virtio/virtio-pci.c                        |    7 +-
 hw/virtio/virtio-pci.h                        |    2 +-
 hw/virtio/virtio-rng.c                        |    2 +-
 hw/virtio/virtio.c                            |  120 +++++++++----
 include/hw/qdev-properties.h                  |   12 ++
 include/hw/virtio/dataplane/vring-accessors.h |   75 ++++++++
 include/hw/virtio/dataplane/vring.h           |   14 +-
 include/hw/virtio/vhost.h                     |    6 +-
 include/hw/virtio/virtio-access.h             |    4 +
 include/hw/virtio/virtio-bus.h                |   14 +-
 include/hw/virtio/virtio-net.h                |   46 ++---
 include/hw/virtio/virtio-scsi.h               |    6 +-
 include/hw/virtio/virtio.h                    |   62 +++++--
 include/net/vhost_net.h                       |    4 +-
 linux-headers/linux/virtio_config.h           |    3 +
 38 files changed, 727 insertions(+), 311 deletions(-)
 create mode 100644 include/hw/virtio/dataplane/vring-accessors.h

-- 
1.7.9.5
