From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [RFC v2 0/2] virtio: Support releasing lock during kick
Date: Wed,  7 Sep 2011 14:51:39 +0100
Message-ID: <1315403501-12457-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Khoa Huynh <khoa@us.ibm.com>, Christoph Hellwig <hch@lst.de>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch allows virtio-blk to release its block queue lock while kicking the
host.  This improves scalability on SMP guests who would otherwise spin on the
lock while another vCPU is kicking the host.

This approach can be used for other virtio devices too.  It simply splits the
virtqueue_kick() operation into a prepare step which requires that the lock be
held and the actual notify step which may be performed without the lock.
Existing virtio drivers may continue to use the virtqueue_kick() interface
which now does the prepare and notify steps internally.

I am sending this out as RFC because further performance benchmarking is
required.  Although we have seen good results in the past, gathering number on
a wider range of machines and verifying that there is no regression would be
helpful.

Stefan Hajnoczi (2):
  virtio_ring: split virtqueue_kick prepare/notify
  virtio_blk: unlock vblk->lock during kick

 drivers/block/virtio_blk.c   |   10 ++++++++--
 drivers/virtio/virtio_ring.c |   28 +++++++++++++++++++++-------
 include/linux/virtio.h       |   13 +++++++++++++
 3 files changed, 42 insertions(+), 9 deletions(-)

-- 
1.7.5.4
