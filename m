From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/6] virtio: virtqueue ops cleanup
Date: Mon, 12 Apr 2010 16:18:19 +0300
Message-ID: <cover.1271078235.git.mst@redhat.com>
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
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtqueue ops were introduced in the hope that we'll
have multiple implementations besides virtio_ring,
but none have surfaced so far, and given that
existing virtio ring is deployed in production
we are likely stuck with it now, so this layer just
adds complexity and overhead.
Further, the need to pass vq twice to each call
(as in dev->vq->vq_ops->kick(dev->vq) ) adds potential
for cut and paste errors.

This patchset does the following:
- add inline wrappers converting the above to virtqueue_kick(dev->vq)
- convert all users to this API
- remove vq_ops indirection, implementing virtqueue_xx directly
  in virtio_ring

Note that if we ever want to add another vring implementation,
we'll only need to revert the last patch in the series,
devices won't have to change.

-- 
MST


Michael S. Tsirkin (6):
  virtio: add virtqueue_ vq_ops wrappers
  virtio_balloon: use virtqueue_xxx wrappers
  virtio_console: use virtqueue_xxx wrappers
  virtio_blk: use virtqueue_xxx wrappers
  virtio_net: use virtqueue_xxx wrappers
  virtio_ring: remove a level of indirection

 drivers/block/virtio_blk.c      |    6 ++--
 drivers/char/virtio_console.c   |   32 +++++++++++++-------------
 drivers/net/virtio_net.c        |   46 +++++++++++++++++++-------------------
 drivers/virtio/virtio_balloon.c |   17 ++++++-------
 drivers/virtio/virtio_ring.c    |   36 +++++++++++++-----------------
 include/linux/virtio.h          |   43 +++++++++++++++++------------------
 6 files changed, 87 insertions(+), 93 deletions(-)
