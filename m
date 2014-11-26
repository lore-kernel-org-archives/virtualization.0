From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v3 00/12] qemu: towards virtio-1 host support
Date: Wed, 26 Nov 2014 18:28:31 +0100
Message-ID: <1417022923-1654-1-git-send-email-cornelia.huck@de.ibm.com>
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

Next version of virtio-1 patches for qemu.

Only change from v2 is splitting out the vring accessors into a
separate header file - should hopefully fix the build issues.

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

 hw/9pfs/virtio-9p-device.c                    |    7 +-
 hw/block/dataplane/virtio-blk.c               |    4 +-
 hw/block/virtio-blk.c                         |   13 +-
 hw/char/virtio-serial-bus.c                   |    9 +-
 hw/net/virtio-net.c                           |   42 ++++--
 hw/s390x/css.c                                |   12 ++
 hw/s390x/css.h                                |    1 +
 hw/s390x/s390-virtio-bus.c                    |    9 +-
 hw/s390x/virtio-ccw.c                         |  186 +++++++++++++++++++------
 hw/s390x/virtio-ccw.h                         |    7 +-
 hw/scsi/vhost-scsi.c                          |    7 +-
 hw/scsi/virtio-scsi-dataplane.c               |    2 +-
 hw/scsi/virtio-scsi.c                         |   10 +-
 hw/virtio/Makefile.objs                       |    2 +-
 hw/virtio/dataplane/Makefile.objs             |    2 +-
 hw/virtio/dataplane/vring.c                   |   96 +++++++------
 hw/virtio/virtio-balloon.c                    |    8 +-
 hw/virtio/virtio-bus.c                        |   23 +--
 hw/virtio/virtio-mmio.c                       |    9 +-
 hw/virtio/virtio-pci.c                        |   13 +-
 hw/virtio/virtio-rng.c                        |    2 +-
 hw/virtio/virtio.c                            |   51 +++++--
 include/hw/virtio/dataplane/vring-accessors.h |   75 ++++++++++
 include/hw/virtio/dataplane/vring.h           |   14 +-
 include/hw/virtio/virtio-access.h             |    4 +
 include/hw/virtio/virtio-bus.h                |   10 +-
 include/hw/virtio/virtio.h                    |   34 ++++-
 linux-headers/linux/virtio_config.h           |    3 +
 28 files changed, 467 insertions(+), 188 deletions(-)
 create mode 100644 include/hw/virtio/dataplane/vring-accessors.h

-- 
1.7.9.5
