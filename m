From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 00/16] virtio ring rework.
Date: Tue, 19 Feb 2013 18:26:18 +1030
Message-ID: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

OK, this is (ab)uses some of Paolo's patches.  The first 7 are
candidates for this merge window (maybe), the rest I'm not so sure
about.

Thanks,
Rusty.

Paolo Bonzini (3):
  scatterlist: introduce sg_unmark_end
  virtio-blk: reorganize virtblk_add_req
  virtio-blk: use virtqueue_add_sgs on req path

Rusty Russell (13):
  virtio_ring: virtqueue_add_sgs, to add multiple sgs.
  virtio-blk: use virtqueue_start_buf on bio path
  virtio_blk: remove nents member.
  virtio_ring: don't count elements twice for add_buf path.
  virtio_ring: virtqueue_add_outbuf / virtqueue_add_inbuf.
  virtio_net: use simplified virtqueue accessors.
  virtio_net: use virtqueue_add_sgs[] for command buffers.
  virtio_rng: use simplified virtqueue accessors.
  virtio_console: use simplified virtqueue accessors.
  caif_virtio: use simplified virtqueue accessors.
  virtio_rpmsg_bus: use simplified virtqueue accessors.
  virtio_balloon: use simplified virtqueue accessors.
  9p/trans_virtio.c: use virtio_add_sgs[]

 block/blk-integrity.c               |    2 +-
 block/blk-merge.c                   |    2 +-
 drivers/block/virtio_blk.c          |  146 +++++++++-----------
 drivers/char/hw_random/virtio-rng.c |    2 +-
 drivers/char/virtio_console.c       |    6 +-
 drivers/net/caif/caif_virtio.c      |    3 +-
 drivers/net/virtio_net.c            |   61 ++++-----
 drivers/rpmsg/virtio_rpmsg_bus.c    |    8 +-
 drivers/virtio/virtio_balloon.c     |    6 +-
 drivers/virtio/virtio_ring.c        |  253 ++++++++++++++++++++++++++---------
 include/linux/scatterlist.h         |   16 +++
 include/linux/virtio.h              |   17 +++
 net/9p/trans_virtio.c               |   48 +++++--
 13 files changed, 371 insertions(+), 199 deletions(-)

-- 
1.7.10.4
