From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v4 00/16] qemu: towards virtio-1 host support
Date: Thu, 27 Nov 2014 16:16:33 +0100
Message-ID: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
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

Yet another version of the virtio-1 support patches.

This one has seen some (very) light testing with the virtio-1 guest
support patches currently on vhost-next.

Changes from v3:

- Add support for FEATURES_OK. We refuse to set features after the
  driver has set this in the status field, and we allow to fail
  setting the status if the features are inconsistent.
- Add missing virtio-1 changes for virtio-net (header size and mac).
- Dropped setting the VERSION_1 bit for virtio-blk: There's still
  some stuff missing.

For virtio-blk, we need to validate the feature bits if version 1 is
negotiated: some legacy features are not allowed in that case. I'm not
quite sure how to handle this, though. We could use the new
validate_features callback to verify that the driver negotiated a
sensible feature set, but that would require us to offer a superset
of legacy and version 1 bits, which feels wrong. Any ideas?

Cornelia Huck (13):
  virtio: cull virtio_bus_set_vdev_features
  virtio: support more feature bits
  s390x/virtio-ccw: fix check for WRITE_FEAT
  virtio: introduce legacy virtio devices
  virtio: allow virtio-1 queue layout
  dataplane: allow virtio-1 devices
  s390x/virtio-ccw: support virtio-1 set_vq format
  virtio: disallow late feature changes for virtio-1
  virtio: allow to fail setting status
  s390x/virtio-ccw: enable virtio 1.0
  virtio-net: no writeable mac for virtio-1
  virtio-net: support longer header
  virtio-net: enable virtio 1.0

Thomas Huth (3):
  linux-headers/virtio_config: Update with VIRTIO_F_VERSION_1
  s390x/css: Add a callback for when subchannel gets disabled
  s390x/virtio-ccw: add virtio set-revision call

 hw/9pfs/virtio-9p-device.c                    |    7 +-
 hw/block/dataplane/virtio-blk.c               |    4 +-
 hw/block/virtio-blk.c                         |    9 +-
 hw/char/virtio-serial-bus.c                   |    9 +-
 hw/net/virtio-net.c                           |   52 +++++--
 hw/s390x/css.c                                |   12 ++
 hw/s390x/css.h                                |    1 +
 hw/s390x/s390-virtio-bus.c                    |    9 +-
 hw/s390x/virtio-ccw.c                         |  206 +++++++++++++++++++------
 hw/s390x/virtio-ccw.h                         |    7 +-
 hw/scsi/vhost-scsi.c                          |    7 +-
 hw/scsi/virtio-scsi-dataplane.c               |    2 +-
 hw/scsi/virtio-scsi.c                         |   10 +-
 hw/virtio/Makefile.objs                       |    2 +-
 hw/virtio/dataplane/Makefile.objs             |    2 +-
 hw/virtio/dataplane/vring.c                   |   96 ++++++------
 hw/virtio/virtio-balloon.c                    |    8 +-
 hw/virtio/virtio-bus.c                        |   23 +--
 hw/virtio/virtio-mmio.c                       |    9 +-
 hw/virtio/virtio-pci.c                        |   13 +-
 hw/virtio/virtio-rng.c                        |    2 +-
 hw/virtio/virtio.c                            |   88 +++++++++--
 include/hw/virtio/dataplane/vring-accessors.h |   75 +++++++++
 include/hw/virtio/dataplane/vring.h           |   14 +-
 include/hw/virtio/virtio-access.h             |    4 +
 include/hw/virtio/virtio-bus.h                |   10 +-
 include/hw/virtio/virtio.h                    |   39 ++++-
 linux-headers/linux/virtio_config.h           |    3 +
 28 files changed, 523 insertions(+), 200 deletions(-)
 create mode 100644 include/hw/virtio/dataplane/vring-accessors.h

-- 
1.7.9.5
