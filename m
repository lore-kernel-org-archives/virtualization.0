Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55C7E584
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118350; cv=none; b=k+ldEclh/siDYH9WyEUnJ6YSUWHLcFyGwry2Pt5/AB78BkiVLlipy3r8pYfg+IyLYuvQ6e23O2n/ftpC/3wu88+9rfLjN9ykFO3Q8MAsLHciDEo4THWYGSYuV2pJNG5Z0rq2npf3++NRfLnde4+bJO7Gzo8poT631lvbXN/DmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118350; c=relaxed/simple;
	bh=msX24r+zZLtPYPWzWYft9WgCYJqgJtT/IZ+EkDMUjZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F5XFFDtp0n+IndeT7qbfrTGRT0L85wPFhU2vCTpc4KYTlnVXiTQDHWxhFT1DHbgx9GkFKfUZQLLEkfG3G6poqtEI7ulML+cEi55xjKDDHruRUbF7t4+qPkbiXzvR4C1eqDBrm6e6EFPyiF0SYugX+icFxKy8XHSN6LZ+tPmhkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TlBLl5qSwz1xpkf;
	Wed, 28 Feb 2024 19:04:15 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 007071A016C;
	Wed, 28 Feb 2024 19:05:46 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Feb
 2024 19:05:45 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <mst@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<jasowang@redhat.com>, <kuba@kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <davem@davemloft.net>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xudingke@huawei.com>,
	<liwei395@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net-next v2 2/3] vhost_net: Call peek_len when using xdp
Date: Wed, 28 Feb 2024 19:05:44 +0800
Message-ID: <1709118344-127812-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500008.china.huawei.com (7.185.36.136)

If TUN supports AF_XDP TX zero-copy, the XDP program will enqueue
packets to the XDP ring and wake up the vhost worker. This requires
the vhost worker to call peek_len(), which can be used to consume
XDP descriptors.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/vhost/net.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f2ed7167c848..077e74421558 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -207,6 +207,11 @@ static int vhost_net_buf_peek_len(void *ptr)
 	return __skb_array_len_with_tag(ptr);
 }
 
+static bool vhost_sock_xdp(struct socket *sock)
+{
+	return sock_flag(sock->sk, SOCK_XDP);
+}
+
 static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
 {
 	struct vhost_net_buf *rxq = &nvq->rxq;
@@ -214,6 +219,13 @@ static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
 	if (!vhost_net_buf_is_empty(rxq))
 		goto out;
 
+	if (ptr_ring_empty(nvq->rx_ring)) {
+		struct socket *sock = vhost_vq_get_backend(&nvq->vq);
+		/* Call peek_len to consume XSK descriptors, when using xdp */
+		if (vhost_sock_xdp(sock) && sock->ops->peek_len)
+			sock->ops->peek_len(sock);
+	}
+
 	if (!vhost_net_buf_produce(nvq))
 		return 0;
 
@@ -346,11 +358,6 @@ static bool vhost_sock_zcopy(struct socket *sock)
 		sock_flag(sock->sk, SOCK_ZEROCOPY);
 }
 
-static bool vhost_sock_xdp(struct socket *sock)
-{
-	return sock_flag(sock->sk, SOCK_XDP);
-}
-
 /* In case of DMA done not in order in lower device driver for some reason.
  * upend_idx is used to track end of used idx, done_idx is used to track head
  * of used idx. Once lower device DMA done contiguously, we will signal KVM
-- 
2.41.0

