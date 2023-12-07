Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930BD1E49A
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 165F382F57
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:04:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 165F382F57
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DfStLElQdPHZ
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 08:03:59 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4466180C50
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:03:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4466180C50
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vy.49hc_1701936233;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vy.49hc_1701936233)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 16:03:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC v2 0/5] virtio helper: collect dma info from virtio core
Date: Thu,  7 Dec 2023 16:03:48 +0800
Message-Id: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: b3688db07ee6
Content-Transfer-Encoding: 8bit

For the virtio net send queue, if it supports premapped mode,
then we need to collect the dma info of every desc of this buf
to do unmap inside the driver. The key is that one xmit may
contains multiple dma address. (A skb may contain 19 dma address)

Here I introduce a new helper to resolve this. And we also need
to consider the virtqueue_resize and free the unused buffers.

For on the same page of the API design before other job, I post this RFC patch
set.

Thanks.

v2:
    1. use union to reuse the sq-sg
    2. introduce virtqueue_get_dma_premapped()
    3. move WARN_ON_ONCE() to the detach_buf_{split,packed}
    4. rename the  virtqueue_detach_unused_buf_premapped() to virtqueue_detach_unused_buf_dma()


v1:
    1. introduce new struct virtio_dma_head to replace the scatterlist
    2. fix some small problems



Xuan Zhuo (5):
  virtio_ring: introduce virtqueue_get_buf_ctx_dma()
  virtio_ring: virtqueue_disable_and_recycle let the callback detach
    bufs
  virtio_ring: introduce virtqueue_detach_unused_buf_dma()
  virtio_ring: introduce virtqueue_get_dma_premapped()
  virtio_net: sq support premapped mode

 drivers/net/virtio/main.c       | 163 ++++++++++++++++++----
 drivers/net/virtio/virtio_net.h |  13 +-
 drivers/virtio/virtio_ring.c    | 231 +++++++++++++++++++++++---------
 include/linux/virtio.h          |  22 ++-
 4 files changed, 334 insertions(+), 95 deletions(-)

--
2.32.0.3.g01195cf9f

