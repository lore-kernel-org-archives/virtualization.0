Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFF1779B7
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068252; cv=none; b=dcV0bQkMsLrXPn1abbR6752ZwwMBKHi8ORUeWHQ3uFny42fgrNb51+6Mdlgflr08So9JyizuJyyD6Yq+4noFOOJXIOmE5TJ7ftRIKFoivlIw8AhpiW38hgOon3xQ2P9SrX3JgH1WsmtFt/99lhF2yo3IG3vMkwEy/4rey4hawBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068252; c=relaxed/simple;
	bh=0WJDpDa9lhr2LGFYbOePHFyZ6YwcfioYnmBnQeGxP4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8QZCmgiO7nkIbngJZHjYSNholtBVMvErZOsg3jDguwUXycYj0Cyezko1KbpY23Cn0Oy+RvMHCWnY5+qB8/pP208idTU3iObzT0WB4301mgzmm50W2SX+69tilBmEtbXe2/8mPkzCC970nqalgbp94CdERa4Lz7ut7mssSwuw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ys0IW+Zm; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ys0IW+Zm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717068248; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JCJQLpIokiiuVSotEGZG1s9N4gxo3eGKbRmi/fsG/24=;
	b=Ys0IW+Zm0RDetZ9jZ7w4AH/TJqNIdgYAPIKjzuCK+4L2v6l1zm8oi8iLkzo6cy+q1agZNgzyqBMWMvRKK7rSyzMMMlHXJRk0zN2rdpM3F5VarRkiqdGopC+Mj7GKS+B0AX8sM7zaRI6S3cRBMpxLsLixYOARHnmJ1D4NMONGC0E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7WnOUG_1717068246;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WnOUG_1717068246)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:24:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Date: Thu, 30 May 2024 19:23:54 +0800
Message-Id: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: fcf606ca5ff8
Content-Transfer-Encoding: 8bit

This patch set prepares for supporting af-xdp zerocopy.
There is no feature change in this patch set.
I just want to reduce the patch num of the final patch set,
so I split the patch set.

Thanks.

v2:
    1. Add five commits. That provides some helper for sq to support premapped
       mode. And the last one refactors distinguishing xmit types.

v1:
    1. resend for the new net-next merge window



Xuan Zhuo (12):
  virtio_net: independent directory
  virtio_net: move core structures to virtio_net.h
  virtio_net: add prefix virtnet to all struct inside virtio_net.h
  virtio_net: separate virtnet_rx_resize()
  virtio_net: separate virtnet_tx_resize()
  virtio_net: separate receive_mergeable
  virtio_net: separate receive_buf
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: introduce dma map api for page
  virtio_ring: introduce virtqueue_dma_map_sg_attrs
  virtio_ring: virtqueue_set_dma_premapped() support to disable
  virtio_net: refactor the xmit type

 MAINTAINERS                                   |   2 +-
 drivers/net/Kconfig                           |   9 +-
 drivers/net/Makefile                          |   2 +-
 drivers/net/virtio/Kconfig                    |  12 +
 drivers/net/virtio/Makefile                   |   8 +
 drivers/net/virtio/virtnet.h                  | 248 ++++++++
 .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
 drivers/virtio/virtio_ring.c                  | 118 +++-
 include/linux/virtio.h                        |  12 +-
 9 files changed, 606 insertions(+), 401 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 create mode 100644 drivers/net/virtio/virtnet.h
 rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)

--
2.32.0.3.g01195cf9f

