Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677658F49
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 07:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D99EB40A07
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 07:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D99EB40A07
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HVFSH2r7fj2d
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 07:23:38 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12DA840179
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 07:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12DA840179
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VxkmuBS_1701674611;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VxkmuBS_1701674611)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 15:23:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC v1 0/4] virtio helper: collect dma info from virtio core
Date: Mon,  4 Dec 2023 15:23:27 +0800
Message-Id: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: a973224d7b9a
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

v1:
    1. introduce new struct virtio_dma_head to replace the scatterlist
    2. fix some small problems


Xuan Zhuo (4):
  virtio_ring: introduce virtqueue_get_buf_ctx_dma()
  virtio_ring: virtqueue_disable_and_recycle let the callback detach
    bufs
  virtio_ring: introduce virtqueue_detach_unused_buf_premapped
  virtio_net: sq support premapped mode

 drivers/net/virtio/main.c       | 145 +++++++++++++++++++----
 drivers/net/virtio/virtio_net.h |   2 +
 drivers/virtio/virtio_ring.c    | 196 +++++++++++++++++++++-----------
 include/linux/virtio.h          |  21 +++-
 4 files changed, 277 insertions(+), 87 deletions(-)

--
2.32.0.3.g01195cf9f

