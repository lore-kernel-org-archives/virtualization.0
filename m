Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD32557A
	for <virtualization@lists.linux.dev>; Sat, 11 May 2024 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397252; cv=none; b=Ja2taiO4Oo69q0fNgiN6JD47lbylcrN5BVd6e8AJTQlbvfDbgay/ApkqLS2cHeqD4ZaWc6bGlddjXCZbZqlZvt41X95Cxz1T45qk0Qhi8+fG+weDYENVnnTw+WXGYTXIJJYjxGKSL/2oAZgfka9W3XN/TEttbAQhMJwBChwK6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397252; c=relaxed/simple;
	bh=CcDkkWan88A1XCr91ZzWcpyz3A8ByzYbE5eLB9/o77M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iC3lo51hwiRbfScauavHeAdpuQoBsF5fa1R+y1yefUnlCsJxuagBBfEYiMcJN2A1f521Q5hHPzyyeNDwSaWbth1aNqcjm1yKk9NDX4tVddat3n0yDFgDc06pkZaRXXKtScLQpjAsehAzX7aiAPk6/VRFqoCtokCRh+qKT3g8Cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AoWsuFYk; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AoWsuFYk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715397247; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=htoVDchsx8815IcYZrFv1YVXLA73nTjibEg1V5cgDGs=;
	b=AoWsuFYkSOmww8bZHm6dJPCVGNC+sj0RMbcRZqbmWQrC65UkfEGbvuoZeYyrdiMqj/TZsJFUuju1T41r7FfEZ5di3aUfIviB4PwnaxT1E7k1JI4NcGn1097YaMbivWD2liWi1xVhbgFrJFG8KOTptEPuJ+W2zRAJMyeaJbbCTR4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6BzGt5_1715397244;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W6BzGt5_1715397244)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 11:14:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v5 0/4] virtio_net: rx enable premapped mode by default
Date: Sat, 11 May 2024 11:14:00 +0800
Message-Id: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: e1ef52e80115
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
    5. And we need space the chain the pages submitted once to virtio core.

    More:
        https://lore.kernel.org/all/CACGkMEu=Aok9z2imB_c5qVuujSh=vjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/

Why we do not use the page space to store the dma?
    http://lore.kernel.org/all/CACGkMEuyeJ9mMgYnnB42=hw6umNuo=agn7VBqBqYPd7GN=+39Q@mail.gmail.com

Please review.

v5: 1. Fix the comments from @Larysa Zaremba
        http://lore.kernel.org/all/20240508063718.69806-1-xuanzhuo@linux.alibaba.com

v4:
    1. For the conflict, switch to the net-next branch

v3:
    1. big mode still use the mode that virtio core does the dma map/unmap

v2:
    1. make gcc happy in page_chain_get_dma()
        http://lore.kernel.org/all/202404221325.SX5ChRGP-lkp@intel.com

v1:
    1. discussed for using page pool
    2. use dma sync to replace the unmap for the first page

Thanks.






Xuan Zhuo (4):
  virtio_ring: enable premapped mode whatever use_dma_api
  virtio_net: big mode skip the unmap check
  virtio_net: rx remove premapped failover code
  virtio_net: remove the misleading comment

 drivers/net/virtio_net.c     | 90 +++++++++++++++---------------------
 drivers/virtio/virtio_ring.c |  7 +--
 2 files changed, 38 insertions(+), 59 deletions(-)

--
2.32.0.3.g01195cf9f

