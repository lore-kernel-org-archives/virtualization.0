Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7662364A0
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112730; cv=none; b=KoYuIwI3nj9W8bRNmRkdSQ0BoimAgWQod+/kvL4aG2+Ycews0nwxFM+vLlU4qVy7uIIJ2OkT00hjXpVFVpcxdJmetbBFmespG5RplI/Jak+KTVFlotKrONgd2RpEV+GnVv7WoUi2YiptDKqgAdqz/nzLfbrVW+9B2MXawjMciGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112730; c=relaxed/simple;
	bh=nN0hXC2rCPqcNLu07ELbr6FXn/yhkJ6KwF/VMli0qYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tc/2Ngui4ndTsoDdqG8nfqIUl9BKhv0790U2VNTeFa1rWMaHdIzYfmUOANIiHU7pNGr90eAeAr7fm7OZ0p0z3IuDaAay57wCedqNibLLlQgFYL+NEwYKraygelbc94nvOdfI4vTOCJPhwHk6Hx537S9aD6mgxHtkoVqAGvHJSH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tl8BW4Jfyz1b1CP;
	Wed, 28 Feb 2024 17:26:59 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A90B1A0172;
	Wed, 28 Feb 2024 17:31:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 17:31:58 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexanderduyck@fb.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>, <linux-mm@kvack.org>
Subject: [PATCH net-next v6 2/5] page_frag: unify gfp bits for order 3 page allocation
Date: Wed, 28 Feb 2024 17:30:09 +0800
Message-ID: <20240228093013.8263-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240228093013.8263-1-linyunsheng@huawei.com>
References: <20240228093013.8263-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

Currently there seems to be three page frag implementations
which all try to allocate order 3 page, if that fails, it
then fail back to allocate order 0 page, and each of them
all allow order 3 page allocation to fail under certain
condition by using specific gfp bits.

The gfp bits for order 3 page allocation are different
between different implementation, __GFP_NOMEMALLOC is
or'd to forbid access to emergency reserves memory for
__page_frag_cache_refill(), but it is not or'd in other
implementions, __GFP_DIRECT_RECLAIM is masked off to avoid
direct reclaim in vhost_net_page_frag_refill(), but it is
not masked off in __page_frag_cache_refill().

This patch unifies the gfp bits used between different
implementions by or'ing __GFP_NOMEMALLOC and masking off
__GFP_DIRECT_RECLAIM for order 3 page allocation to avoid
possible pressure for mm.

Leave the gfp unifying for page frag implementation in sock.c
for now as suggested by Paolo Abeni.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
---
 drivers/vhost/net.c | 2 +-
 mm/page_alloc.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f2ed7167c848..e574e21cc0ca 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -670,7 +670,7 @@ static bool vhost_net_page_frag_refill(struct vhost_net *net, unsigned int sz,
 		/* Avoid direct reclaim but allow kswapd to wake */
 		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
 					  __GFP_COMP | __GFP_NOWARN |
-					  __GFP_NORETRY,
+					  __GFP_NORETRY | __GFP_NOMEMALLOC,
 					  SKB_FRAG_PAGE_ORDER);
 		if (likely(pfrag->page)) {
 			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c0f7e67c4250..636145c29f70 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4685,8 +4685,8 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	gfp_t gfp = gfp_mask;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	gfp_mask |= __GFP_COMP | __GFP_NOWARN | __GFP_NORETRY |
-		    __GFP_NOMEMALLOC;
+	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
+		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
 	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
-- 
2.33.0

