Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96D4F602
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770655; cv=none; b=pYcFyLE2T0Md90IwjvJqSrqMu3IlrC9jU54fjEK5eJ/DiWzHxI+G95XcWFvRWVKUXnp8+w3st+E2fgRiIz8sTKLdCMazFKH8w2+UIleKH8m14+XdZMnCZHAgZ2pCfwTXc9tCJkx4blJ+d7YDHuhBh3XnI5VxBaafPXLHyr6CLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770655; c=relaxed/simple;
	bh=QKzEEm/10AWJ1pnoVPTzsPCho/wdg0/fv0EzgkMXFrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=egB3fGzxv/fXcTEDgE0hzA0+jzxOEXbRr+vIYLBgdMiMCyqL7WVEx0RF/382Gog1+zjsXN5skg7BnGXxr2pSiwI44/2CgI97h+BycbwmYIS/zadaig3S+n1w7YevJKS5BpmGg4dTEwceVUy1G2gw5MlmEBIaPHRHMXoU43K1fcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=opN2T2ZQ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="opN2T2ZQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713770650; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fzRsFocAnGj2/Yz9p0DSIGwrCXOzJP9IzYj5Obio3dU=;
	b=opN2T2ZQXUXQNKU1K608BZI9++fKOAYJ6zfWKBCZbprUZhrtJ9BteJWJgQespqHY83fTpNZnGDZ4/BxqkuKJuNqCBNkaVk449HjXbVMiUncCFM7OwtR3vW0+SnW+VmH/gZA4Jw23KgTFXcFuZpaB0p2mx13/UqSexWAB2zOR99I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5.T5if_1713770649;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5.T5if_1713770649)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:24:09 +0800
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
Subject: [PATCH vhost v2 0/7] virtio_net: rx enable premapped mode by default
Date: Mon, 22 Apr 2024 15:24:01 +0800
Message-Id: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: aa968d36d784
Content-Transfer-Encoding: 8bit

Actually, for the virtio drivers, we can enable premapped mode whatever
the value of use_dma_api. Because we provide the virtio dma apis.
So the driver can enable premapped mode unconditionally.

This patch set makes the big mode of virtio-net to support premapped mode.
And enable premapped mode for rx by default.

Based on the following points, we do not use page pool to manage these
    pages:

    1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
       we can only prevent the page pool from performing DMA operations, and
       let the driver perform DMA operations on the allocated pages.
    2. But when the page pool releases the page, we have no chance to
       execute dma unmap.
    3. A solution to #2 is to execute dma unmap every time before putting
       the page back to the page pool. (This is actually a waste, we don't
       execute unmap so frequently.)
    4. But there is another problem, we still need to use page.dma_addr to
       save the dma address. Using page.dma_addr while using page pool is
       unsafe behavior.

    More:
        https://lore.kernel.org/all/CACGkMEu=Aok9z2imB_c5qVuujSh=vjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/

Please review.

v2:
    1. make gcc happy in page_chain_get_dma()
        http://lore.kernel.org/all/202404221325.SX5ChRGP-lkp@intel.com

v1:
    1. discussed for using page pool
    2. use dma sync to replace the unmap for the first page

Thanks.



Xuan Zhuo (7):
  virtio_ring: introduce dma map api for page
  virtio_ring: enable premapped mode whatever use_dma_api
  virtio_net: replace private by pp struct inside page
  virtio_net: big mode support premapped
  virtio_net: enable premapped by default
  virtio_net: rx remove premapped failover code
  virtio_net: remove the misleading comment

 drivers/net/virtio_net.c     | 243 +++++++++++++++++++++++------------
 drivers/virtio/virtio_ring.c |  59 ++++++++-
 include/linux/virtio.h       |   7 +
 3 files changed, 222 insertions(+), 87 deletions(-)

--
2.32.0.3.g01195cf9f

