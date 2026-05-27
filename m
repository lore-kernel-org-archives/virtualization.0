Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99F625
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849202; cv=none; b=mJu8k6xfPJog7+sxFb5xqAUHFWAXsS/DnPlVHaMIMnvDrLse4hDb8kNSe1gU1/7aURFpA0yrUGi/T+5tG+bcZwoCwVGC+N/6m1eaJSrGz0ArFPJlsu8Vk8rU2qBH42eUAJ339dPiNKp8/F0w5Y4xDpPTPzO+2lYIbm7/FlY/3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849202; c=relaxed/simple;
	bh=8t6TIlrq8lTYCr8mYmTCyfM+uVkhcnM7NGEhdAc/kSo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N9Cqksas5tb39ngSe9CR9zE5Vd82sUrvg1H4aSRuLIH8FdYSfY20CwGOohluHpbePAUthrs2xVfprjl0twTwRRqRzmIWmHwplbbL+KmD+wT0R26we+9sBH+S5tNWKXMl/Yo6woa3bG1PKxn2IvWUU/fRYFT48qiQ+qbu/mf9FGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=adthIWDU; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="adthIWDU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9N6WG8+Zu4U/WbEJSIu0ss4C6WrIjKJDWfdin0qydaE=;
	b=adthIWDUzQwA0DFQsR/sPXxgncKfVMhHNeclfFmdbssxW1U77WicR331TwFbcFt3Srw/Ff8qg
	Hi/xFChr6gEU1jpo8HR/H5RkH3LcO5QPXhtHan0x6GA8jNw501a6DMiLTup3N6hmtQHbhfbtGs3
	GBUGa5BU+TUrVzeYOtS/iPc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gQD434PQqzcZxp;
	Wed, 27 May 2026 10:25:23 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (unknown [7.202.195.7])
	by mail.maildlp.com (Postfix) with ESMTPS id C06A540561;
	Wed, 27 May 2026 10:33:09 +0800 (CST)
Received: from huawei.com (7.227.44.14) by kwepemr200017.china.huawei.com
 (7.202.195.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 May
 2026 10:33:08 +0800
From: Lin Ma <malin89@huawei.com>
To: <kuba@kernel.org>, <avkrasnov@salutedevices.com>,
	<cenxianlong@huawei.com>, <chenzhe@huawei.com>, <cuirongzhen@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <eperezma@redhat.com>,
	<horms@kernel.org>, <jasowang@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <malin89@huawei.com>, <mst@redhat.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sgarzare@redhat.com>,
	<stefanha@redhat.com>, <tanjingguo@huawei.com>,
	<virtualization@lists.linux.dev>, <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v2] vsock/virtio: bind uarg before filling zerocopy skb
Date: Wed, 27 May 2026 10:33:01 +0800
Message-ID: <20260527023301.1075581-1-malin89@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr200017.china.huawei.com (7.202.195.7)

From: Jingguo Tan <tanjingguo@huawei.com>

virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
before entering the send loop, but virtio_transport_alloc_skb() still
fills the skb before it inherits that uarg. When fixed-buffer vectored
zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
managed frags and return -EMSGSIZE. The rollback path call kfree_skb()
to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
skb_release_data() falls through to ordinary frag unref.

Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
before virtio_transport_fill_skb(). This keeps control or no-payload skbs
untouched while ensuring success and rollback share one lifetime rule.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1->v2 changes:
* add acked and review tags.
* repost to avoid duplicated subject.

 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index df3b418e0392..73f58925ff72 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -205,6 +205,7 @@ static u16 virtio_transport_get_type(struct sock *sk)
 static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 						  size_t payload_len,
 						  bool zcopy,
+						  struct ubuf_info *uarg,
 						  u32 src_cid,
 						  u32 src_port,
 						  u32 dst_cid,
@@ -245,6 +246,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (info->msg && payload_len > 0) {
 		int err;
 
+		/* Bind the zerocopy lifetime before filling frags so error rollback
+		 * frees managed fixed-buffer pages through the uarg-aware path.
+		 */
+		skb_zcopy_set(skb, uarg, NULL);
+
 		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
 		if (err)
 			goto out;
@@ -364,6 +370,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		skb_len = min(max_skb_len, rest_len);
 
 		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
+						 uarg,
 						 src_cid, src_port,
 						 dst_cid, dst_port);
 		if (!skb) {
@@ -371,8 +378,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		skb_zcopy_set(skb, uarg, NULL);
-
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb, info->net);
@@ -1183,7 +1188,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	if (!t)
 		return -ENOTCONN;
 
-	reply = virtio_transport_alloc_skb(&info, 0, false,
+	reply = virtio_transport_alloc_skb(&info, 0, false, NULL,
 					   le64_to_cpu(hdr->dst_cid),
 					   le32_to_cpu(hdr->dst_port),
 					   le64_to_cpu(hdr->src_cid),
-- 
2.53.0
