Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8262C68B
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538077; cv=none; b=hnV2kGveNheD7YvJo+yGP/Fj3rTPL6hVLZmfLJ4imevcSmBG+ikCP0oyPqRQgXNIJ/uI4rX+Gzm9PGZefBOGZSgQAmp6nxTz+QI5gbx6uzrtbX3INMy5A+9rzJYAb9UFyfL7ryQgZOwXMC8SZXJ41NzkPOk/cq7RfJg7kcZmsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538077; c=relaxed/simple;
	bh=TrOIQFBG0yF/YdFVNAHwFamLVivKUkDlQ6QegL1FGWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TJn1A2WXVqQeyaDZw8PtB1drba/vbNHLZ7w9r0q1ei4xA5UxpHl/Hq5wGf6y9ipHJKUvBbs8dUY5MDaGsWm9iQH1x4C3I+XCJ23mg+taE+Ho5mmm+v1oAtvnconx4GyLw6/GMFB5Oqj/PqfN8GL4X3zibqdGLLeB8P2vUrnzmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ayXxV3i0; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ayXxV3i0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711538072; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=w6riP8UvylZg2YXJUX+TCfxwwudPvekOkUqanGFacX4=;
	b=ayXxV3i0z9jVy/FnAatV1i7ZjqcG/94lDz3/sqLpdoIAide/09pAT5JVzHhoVWBFloTM7fXaI9s8zPc0d6uXXyN1F5DRurK9CoGwFQIHz2/Uyc5V/G9qTOFAvkxAaorNyzCWWYPVzJDuCb35vEm9DpEH/z2kyT8LPLb7rF8K+s0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3ObwQj_1711538070;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3ObwQj_1711538070)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 19:14:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v6 00/10] virtio: drivers maintain dma info for premapped vq
Date: Wed, 27 Mar 2024 19:14:20 +0800
Message-Id: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: e859552de2d6
Content-Transfer-Encoding: 8bit

As discussed:

http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com

If the virtio is premapped mode, the driver should manage the dma info by self.
So the virtio core should not store the dma info. We can release the memory used
to store the dma info.

For virtio-net xmit queue, if the virtio-net maintains the dma info,
the virtio-net must allocate too much memory(19 * queue_size for per-queue), so
we do not plan to make the virtio-net to maintain the dma info by default. The
virtio-net xmit queue only maintain the dma info when premapped mode is enable
(such as AF_XDP is enable).

So this patch set try to do:

1. make the virtio core to do not store the dma info when driver can do that
    - But if the desc_extra has not dma info, we face a new question,
      it is hard to get the dma info of the desc with indirect flag.
      For split mode, that is easy from desc, but for the packed mode,
      it is hard to get the dma info from the desc. And hardening
      the dma unmap is safe, we should store the dma info of indirect
      descs when the virtio core does not store the bufer dma info.

      The follow patches to this:
         * virtio_ring: packed: structure the indirect desc table
         * virtio_ring: split: structure the indirect desc table

    - On the other side, in the umap handle, we mix the indirect descs with
      other descs. That make things too complex. I found if we we distinguish
      the descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.

      The follow patches do this.
         * virtio_ring: packed: remove double check of the unmap ops
         * virtio_ring: split: structure the indirect desc table

2. make the virtio core to enable premapped mode by find_vqs() params
    - Because the find_vqs() will try to allocate memory for the dma info.
      If we set the premapped mode after find_vqs() and release the
      dma info, that is odd.

Note:
    This patch set is on the top of
        [PATCH vhost v6 0/6] refactor the params of find_vqs()
        http://lore.kernel.org/all/20240327095741.88135-1-xuanzhuo@linux.alibaba.com


Please review.

Thanks

v6:
    1. rebase the code

v5:
    1. use the existing structure to replace vring_split_desc_indir

v4:
    1. virtio-net xmit queue does not enable premapped mode by default

v3:
    1. fix the conflict with the vp_modern_create_avq().

v2:
    1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS + 2 addr + len pairs.
    2. introduce virtnet_sq_free_stats for __free_old_xmit

v1:
    1. rename transport_vq_config to vq_transport_config
    2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
    3. introduce virtqueue_dma_map_sg_attrs
    4. separate vring_create_virtqueue to an independent commit



Xuan Zhuo (10):
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: packed: remove double check of the unmap ops
  virtio_ring: packed: structure the indirect desc table
  virtio_ring: split: remove double check of the unmap ops
  virtio_ring: split: structure the indirect desc table
  virtio_ring: no store dma info when unmap is not needed
  virtio: find_vqs: add new parameter premapped
  virtio_ring: export premapped to driver by struct virtqueue
  virtio_net: set premapped mode by find_vqs()
  virtio_ring: virtqueue_set_dma_premapped support disable

 drivers/net/virtio_net.c      |  57 +++--
 drivers/virtio/virtio_ring.c  | 430 +++++++++++++++++++++-------------
 include/linux/virtio.h        |   3 +-
 include/linux/virtio_config.h |  19 +-
 4 files changed, 303 insertions(+), 206 deletions(-)

--
2.32.0.3.g01195cf9f

