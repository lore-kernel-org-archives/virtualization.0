Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E942114
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751169; cv=none; b=tm+aHGkNszOoyTeq16L0JDoVAmPUICR7azlCtZ/DGsQ+PbYRBjuEGPhNgxzBib1THQh1nCA5NFC3uZoziuvgj3qRMtnqeEZ8OdKzzmKb/6JssZ6lVIBQw0+z64E2M71vnbYiOiPNluubI3S0FuSkH+jdUQZCdVr9DIpv44+qsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751169; c=relaxed/simple;
	bh=ZSd37NZmwRJpjHAS9ajLmdk+WDKEomc1d5hGfAfOCQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rE23BmELkhwebYoSX7cYJL2NBegRfGjFG5PvrTux27ZCV3PLjKdmrH1e973aGDf0ANCDgoTcJYM1iGALd633QXiBa6mzSyL7+1PkRMBmeP7GZQE0bms6xrv0cyeb+QalVDx8sfKr8cBwaHnbT/P9uGrEsmB5Xfsr7yZNQpVXCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UB9ygYh0; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UB9ygYh0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713751164; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qfFyaumVlpjGsrE/xHi1bO0ootxsSU/JVlrBiwyRb2Y=;
	b=UB9ygYh0YLrjvv3KMZ23wg5UrjqHta+BY9GijltiB2z+VPKuyihI70Z8IRg7Q/Ma61RImGyKPgbwxiDOToSZJ0pzdr/wrnvIsgcqTnxFvoAbu5N0W4ilym8FvJ+TH0ygCEeGqKnbTe76kQ4CVtQqbUespHvYbaZujYzyu/Ry0e0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4y4sJ2_1713750843;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4y4sJ2_1713750843)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 09:54:04 +0800
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
Subject: [PATCH vhost v1 0/7] virtio_net: rx enable premapped mode by default
Date: Mon, 22 Apr 2024 09:53:56 +0800
Message-Id: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 2c089e81de7e
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

