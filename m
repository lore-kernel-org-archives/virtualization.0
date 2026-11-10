Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346602;
	b=MIyePpgBGYkLdnF5nyaGWP57B6uibqGvBhlIIhKWEycgPxtD3wAxGEEnhKwRob7z5+GQ
	 idJsghbrrQQ0x5D3QeHAoTzTjU4b2Q9FglcpzbFK7+DJ9AHs2KpyWSSUNKHdiv+1TmijN
	 SR7dlqyITju2q4gG+cJIZFkjJDLUfbmBsQc8/Ox6FmyxASGZMPXAnzuz9uAfNuj+mpF7C
	 vXqcswE3Nw9NTePDcVugncprHBGSmuhlr6JpVNonr2vvSdzM2EqMFVFGSBBarAVatFZhg
	 UC3Yru5/byjY+rpdfNO78jkWmgzobcfyGGEoIuXzPRppt69m+qMMIw2Jv09KaFkY9RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ri7mT9GeXsX4XZreU1Xu63qBi5/LRjSnYOgyacuU+mg=;
	b=i+YjrPSddnd26cIzi4B8gZSzBdF3b84iQK511eDoj3KKs+2mr2gI2FV2PtxfStXjpqOh
	 Bv6oznFiVPJt6dM32Zvt3wuG/+HzbjsKzkdW3O8QVLGsw9kix0QsxwanLc0bxAgiNIPwT
	 CYMfQn3zmBeQpAdG/56qm2L2AKwQt/WK0LuTH6lDtf5F1Vr0ph671ryEPUoh7/YqW8g+i
	 3UCK4SmOD1Jag0yHkUTKZUtE4de089ooS/cLmzJUeHUazyUvBBDKHyrrmHJJVy9q7Qgsi
	 xvJFXQNKzi24+wqewOyuGMFeusgVEBH0OtBu/we1zRCL3/p9+Rzd+7QMs7IjDP/5HiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WX2fik0d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2272606A31C;
	Tue, 10 Nov 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WX2fik0d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C888D1F0089F;
	Tue, 10 Nov 2026 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346601;
	bh=ri7mT9GeXsX4XZreU1Xu63qBi5/LRjSnYOgyacuU+mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WX2fik0dGtHFTNtxwL+e0nAAlgemQs7CZIjjWPoMy44XKiqJLOAsuamj1MLUpqFIz
	 VDbabtlnPi+57tR9ffATurg15SSj2fSUOF3XLrStBS+FhyKcViKqSRgmJNUNXjzv00
	 nGOhu4cw2MeiWWjX5hlckTZ7xLBXp8c5TcBCD7MWOOwHgaSMSyCLoYydPW3/OgyCYu
	 R7OJS6GlsPqN6rQ78Lxe5Lh9C8OcMTGxXU9S2j7tMRF+dDDCuZ4RBd7wLpFmkJTcON
	 fe5vIxsWc4dfddk3WEIKNdrVduJu6JMsbF5U6wnrK8T8rI28kfiXma95XLJpv6qyad
	 GGXr1EW9KccRQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	edumazet@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v6 2/3] tun: clear stale skb->protocol of NAPI frags skbs
Date: Tue, 10 Nov 2026 22:36:27 +0100
Message-ID: <20261110213628.3476051-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110213628.3476051-1-edumazet@kernel.org>
References: <20261110213628.3476051-1-edumazet@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With IFF_NAPI_FRAGS, tun_napi_alloc_frags() gets its skb from
napi_get_frags(). If GRO merged the previous frame with
GRO_MERGED_FREE, that skb was recycled by napi_reuse_skb(), which does
not reset skb->protocol set by napi_frags_skb() for the previous frame.

tun_get_user() calls tun_vnet_hdr_tnl_to_skb() before eth_type_trans(),
so the virtio header checks see the protocol of the previous frame:
GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with the
wrong protocol. A following change checks the outer protocol of UDP
tunnel GSO packets, which would then reject a valid frame when the two
ethertypes differ.

This needs GRO to hold packets across writes, and IFF_NAPI_FRAGS needs
CAP_NET_ADMIN.

Clear skb->protocol in tun_napi_alloc_frags(), like skbs allocated
by tun_alloc_skb() or build_skb(). eth_type_trans() sets it later.

Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179386753589.488856.11455181721004759454@kernel.org/
Suggested-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 drivers/net/tun.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 3b292bce4438..d1fcb25ab026 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1500,6 +1500,12 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
+	/* An skb recycled by napi_reuse_skb() keeps the protocol of a
+	 * previous frame. eth_type_trans() sets it after the virtio
+	 * header checks, which must not see a stale one.
+	 */
+	skb->protocol = 0;
+
 	linear = iov_iter_single_seg_count(it);
 	err = __skb_grow(skb, linear);
 	if (err)
-- 
2.53.0

