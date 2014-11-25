From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v2 00/12] qemu: towards virtio-1 host support
Date: Tue, 25 Nov 2014 14:24:11 +0100
Message-ID: <1416921863-16523-1-git-send-email-cornelia.huck__39729.8563541428$1416921899$gmane$org@de.ibm.com>
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

Hi,

here's the next version of my virtio-1 qemu patchset. Using virtio-1
virtio-blk and virtio-net devices with a guest kernel built from
<1416829787-14252-1-git-send-email-mst@redhat.com> still seems to
work for the virtio-ccw transport.

Changes from v1:
- rebased against current master
- don't advertise VERSION_1 for all devices, make devices switch it on
  individually

Cornelia Huck (9):
  virtio: cull virtio_bus_set_vdev_features
  virtio: support more feature bits
  s390x/virtio-ccw: fix check for WRITE_FEAT
  virtio: introduce legacy virtio devices
  virtio: allow virtio-1 queue layout
  dataplane: allow virtio-1 devices
  s390x/virtio-ccw: support virtio-1 set_vq format
  virtio-net/virtio-blk: enable virtio 1.0
  s390x/virtio-ccw: enable virtio 1.0

Thomas Huth (3):
  linux-headers/virtio_config: Update with VIRTIO_F_VERSION_1
  s390x/css: Add a callback for when subchannel gets disabled
  s390x/virtio-ccw: add virtio set-revision call

 hw/9pfs/virtio-9p-device.c          |    7 +-
 hw/block/dataplane/virtio-blk.c     |    3 +-
 hw/block/virtio-blk.c               |   13 ++-
 hw/char/virtio-serial-bus.c         |    9 +-
 hw/net/virtio-net.c                 |   42 +++++---
 hw/s390x/css.c                      |   12 +++
 hw/s390x/css.h                      |    1 +
 hw/s390x/s390-virtio-bus.c          |    9 +-
 hw/s390x/virtio-ccw.c               |  186 +++++++++++++++++++++++++++--------
 hw/s390x/virtio-ccw.h               |    7 +-
 hw/scsi/vhost-scsi.c                |    7 +-
 hw/scsi/virtio-scsi-dataplane.c     |    2 +-
 hw/scsi/virtio-scsi.c               |   10 +-
 hw/virtio/Makefile.objs             |    2 +-
 hw/virtio/dataplane/Makefile.objs   |    2 +-
 hw/virtio/dataplane/vring.c         |   95 ++++++++++--------
 hw/virtio/virtio-balloon.c          |    8 +-
 hw/virtio/virtio-bus.c              |   23 +----
 hw/virtio/virtio-mmio.c             |    9 +-
 hw/virtio/virtio-pci.c              |   13 +--
 hw/virtio/virtio-rng.c              |    2 +-
 hw/virtio/virtio.c                  |   51 +++++++---
 include/hw/virtio/dataplane/vring.h |   64 +++++++++++-
 include/hw/virtio/virtio-access.h   |    4 +
 include/hw/virtio/virtio-bus.h      |   10 +-
 include/hw/virtio/virtio.h          |   34 +++++--
 linux-headers/linux/virtio_config.h |    3 +
 27 files changed, 449 insertions(+), 179 deletions(-)

-- 
1.7.9.5
