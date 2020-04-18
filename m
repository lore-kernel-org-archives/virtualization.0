From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 74/75] virtio-blk: improve virtqueue error to BLK_STS
Date: Sat, 18 Apr 2020 10:09:09 -0400
Message-ID: <20200418140910.8280-74-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Sasha Levin <sashal@kernel.org>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Halil Pasic <pasic@linux.ibm.com>

[ Upstream commit 3d973b2e9a625996ee997c7303cd793b9d197c65 ]

Let's change the mapping between virtqueue_add errors to BLK_STS
statuses, so that -ENOSPC, which indicates virtqueue full is still
mapped to BLK_STS_DEV_RESOURCE, but -ENOMEM which indicates non-device
specific resource outage is mapped to BLK_STS_RESOURCE.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Link: https://lore.kernel.org/r/20200213123728.61216-3-pasic@linux.ibm.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c2ed3e9128e3a..a55383b139df9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -345,9 +345,14 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (err == -ENOSPC)
 			blk_mq_stop_hw_queue(hctx);
 		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
-		if (err == -ENOMEM || err == -ENOSPC)
+		switch (err) {
+		case -ENOSPC:
 			return BLK_STS_DEV_RESOURCE;
-		return BLK_STS_IOERR;
+		case -ENOMEM:
+			return BLK_STS_RESOURCE;
+		default:
+			return BLK_STS_IOERR;
+		}
 	}
 
 	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
-- 
2.20.1
