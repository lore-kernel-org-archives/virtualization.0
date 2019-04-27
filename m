From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 26/32] virtio-blk: limit number of hw queues by
	nr_cpu_ids
Date: Fri, 26 Apr 2019 21:42:17 -0400
Message-ID: <20190427014224.8274-26-sashal__38895.9336372622$1556329559$gmane$org@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, Sasha Levin <sashal@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit bf348f9b78d413e75bb079462751a1d86b6de36c ]

When tag_set->nr_maps is 1, the block layer limits the number of hw queues
by nr_cpu_ids. No matter how many hw queues are used by virtio-blk, as it
has (tag_set->nr_maps == 1), it can use at most nr_cpu_ids hw queues.

In addition, specifically for pci scenario, when the 'num-queues' specified
by qemu is more than maxcpus, virtio-blk would not be able to allocate more
than maxcpus vectors in order to have a vector for each queue. As a result,
it falls back into MSI-X with one vector for config and one shared for
queues.

Considering above reasons, this patch limits the number of hw queues used
by virtio-blk by nr_cpu_ids.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 68846897d213..8767401f75e0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -437,6 +437,8 @@ static int init_vq(struct virtio_blk *vblk)
 	if (err)
 		num_vqs = 1;
 
+	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
-- 
2.19.1
