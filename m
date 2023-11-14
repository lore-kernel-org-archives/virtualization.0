Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1215AE5
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1A1982187
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1A1982187
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pbRx83n2Z4N7
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 11:31:12 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F5A681F2C
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F5A681F2C
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VwPPnYJ_1699961464;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VwPPnYJ_1699961464)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 19:31:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC 0/4] virtio helper: collect dma info from virtio core
Date: Tue, 14 Nov 2023 19:31:00 +0800
Message-Id: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 52aa29c00172
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


Xuan Zhuo (4):
  virtio_ring: introduce virtqueue_get_buf_ctx_dma()
  virtio_ring: virtqueue_disable_and_recycle let the callback detach
    bufs
  virtio_ring: introduce virtqueue_detach_unused_buf_premapped
  virtio_net: sq support premapped mode

 drivers/net/virtio/main.c       | 143 ++++++++++++++++++++----
 drivers/net/virtio/virtio_net.h |   2 +
 drivers/virtio/virtio_ring.c    | 187 ++++++++++++++++++++++++--------
 include/linux/virtio.h          |   7 +-
 4 files changed, 268 insertions(+), 71 deletions(-)

--
2.32.0.3.g01195cf9f

