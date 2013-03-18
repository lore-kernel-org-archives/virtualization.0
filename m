From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 00/22] virtqueue_add_sgs, virtqueue_add_outbuf,
	virtqueue_add_inbuf
Date: Mon, 18 Mar 2013 20:04:31 +1030
Message-ID: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Add virtqueue_add_sgs which is more general than virtqueue_add_buf,
which makes virtio-scsi and virtio-blk nicer, then add virtqueue_add_inbuf
and virtqueue_add_outbuf which handle the more general case, and finally
delete virtqueue_add_buf().

I'm hoping this will be the final post of the whole series, and it can
move from my pending-rebases tree into virtio-next.

Thanks!
Rusty.

Paolo Bonzini (4):
  scatterlist: introduce sg_unmark_end
  virtio-blk: reorganize virtblk_add_req
  virtio-blk: use virtqueue_add_sgs on bio path
  virtio-blk: use virtqueue_add_sgs on req path

Rusty Russell (17):
  virtio_ring: virtqueue_add_sgs, to add multiple sgs.
  virtio_ring: don't count elements twice for add_buf path.
  virtio_ring: inline internal vring functions more aggressively.
  virtio_ring: virtqueue_add_outbuf / virtqueue_add_inbuf.
  tools/virtio: make vringh_test use inbuf/outbuf.
  virtio_blk: remove nents member.
  virtio_scsi: use virtqueue_add_inbuf() for virtscsi_kick_event.
  virtio_net: use virtqueue_add_sgs[] for command buffers.
  virtio_net: use simplified virtqueue accessors.
  virtio_rng: use simplified virtqueue accessors.
  virtio_console: use simplified virtqueue accessors.
  caif_virtio: use simplified virtqueue accessors.
  virtio_rpmsg_bus: use simplified virtqueue accessors.
  virtio_balloon: use simplified virtqueue accessors.
  9p/trans_virtio.c: use virtio_add_sgs[]
  tools/virtio: remove virtqueue_add_buf() from tests.
  virtio: remove virtqueue_add_buf().

Wanlong Gao (1):
  virtio-scsi: use virtqueue_add_sgs for command buffers

 block/blk-integrity.c               |    2 +-
 block/blk-merge.c                   |    2 +-
 drivers/block/virtio_blk.c          |  146 ++++++++++------------
 drivers/char/hw_random/virtio-rng.c |    2 +-
 drivers/char/virtio_console.c       |    6 +-
 drivers/net/caif/caif_virtio.c      |    3 +-
 drivers/net/virtio_net.c            |   61 +++++----
 drivers/rpmsg/virtio_rpmsg_bus.c    |    8 +-
 drivers/scsi/virtio_scsi.c          |   95 ++++++--------
 drivers/virtio/virtio_balloon.c     |    6 +-
 drivers/virtio/virtio_ring.c        |  235 +++++++++++++++++++++++++----------
 include/linux/scatterlist.h         |   16 +++
 include/linux/virtio.h              |   18 ++-
 net/9p/trans_virtio.c               |   48 +++++--
 tools/virtio/linux/scatterlist.h    |   16 +++
 tools/virtio/linux/virtio.h         |   18 ++-
 tools/virtio/virtio_test.c          |    6 +-
 tools/virtio/vringh_test.c          |   30 ++---
 18 files changed, 433 insertions(+), 285 deletions(-)

-- 
1.7.10.4
