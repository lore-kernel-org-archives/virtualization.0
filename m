Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879849;
	b=e6Slgi+ZNjLpLvr6pBJEVrvpF930WNu1PClWdpEuC9oT6Rzjg0SkSvIGy8H/J4HbUW5O
	 6l5IbxsyxisG17a2i5IdH98sj32YE1GNtFu+ZLZP90xNNf62C+UnfGYZ9/w8jxs5YCV+f
	 VyGV9ZCtnG9NHLLcY0NP0JnYKJ5h6p05uaVRgmLn7nyQj7x2fyB0FFXQTPtsL75DU/sPc
	 d2y9OW0mRMJmcXzQFkyOxjlFfKFeVN7soKgXANQC61sHA2OYQkDvSN60l/HuiEl8pT0bC
	 Rr59bNbNrXx2MXMU7t4tpKWSmRoqn1jEbP756nCjSBob7nBRsmklpZt2HMqpnkg2qRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879849;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lpa4x7IMkI0pAmvLfxMZgiuZ7+FSjz5ACO8N7GXOsnc=;
	b=Ihv4e73IBERcwO2V4C5M2rAH4CaWryefkTjfWa4fJfr0BvxA9Bx75sd5DMmH2YLySU8/
	 ZY1TwKzyluoTY8hFJKeF5mdgfFV0s8kK4fxzLRafK1kKmDy/QB++724738Q2s76RcJbr4
	 TnflY8JCPF3SplJpLXLPUg5KOCrCaSi+e9nyr1FAA73hzqpbO+g7J4U6DTmJt9D6Qvs++
	 nW7HOpy2lLgmwSTpjyOb1HZJd8hK9W35y1dwE1kXdAi9CD/qR+GpWP0FMAQpKYoS8ClyW
	 p79Ky+DX1eT9QT4d5MvYSOpK/g52JkKGF4VfrLpYoCKoIlT1ClRCWUe5jSX92LN7jKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHKKOxtF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C0606D801;
	Thu,  5 Nov 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHKKOxtF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEF31F00A15;
	Thu,  5 Nov 2026 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879849;
	bh=Lpa4x7IMkI0pAmvLfxMZgiuZ7+FSjz5ACO8N7GXOsnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHKKOxtFlWgDXqCg7HPSBhZblipLs99GZooDHgQPGVSXmlGHBrB84XvlhW2Ht8JY+
	 c2nY3FQI1c5xfBHg9BdBf23QzkslS55wesYV+UMZTaBkcXaTT0gOOQ62RRcrMqCJHP
	 ADNKkmDePPVKysQsV5fFQ+SxAh+ETj/n0lEOR9pkaQM4h915oSYuiWY8PFBrL4wcC7
	 ULvByd9N1vE7KW81qFK+3zYlnzIkKQ3ytYL9IGUV2DrVMiBgwrouDA7f4jZt56AWWx
	 5l9+Kp9Dirg1Q3HmBrpPOitZnuDba3NLZzwL/Iv7oe/EFvLj8fKcoJSu+Hcx+OuSdI
	 By57OlPfi2n/A==
From: Eric Dumazet <edumazet@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v3 3/8] tun: clear stale skb->protocol of NAPI frags skbs
Date: Thu,  5 Nov 2026 12:57:10 +0100
Message-ID: <20261105115715.1466924-4-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105115715.1466924-1-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
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

On the IFF_TAP path, tun_get_user() calls tun_vnet_hdr_tnl_to_skb()
before eth_type_trans(), so the virtio header checks see the protocol
of the previous frame: the outer protocol check of UDP tunnel GSO
packets rejects a valid frame when the two ethertypes differ, and
GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with
the wrong protocol.

This needs GRO to hold packets across writes, for example with
napi_defer_hard_irqs and gro_flush_timeout set on the device.

Clear skb->protocol for IFF_TAP frames, as for skbs allocated by
tun_alloc_skb(). eth_type_trans() sets it right after.

Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179386753589.488856.11455181721004759454@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 drivers/net/tun.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 3920b3dff1e8..6b648f21018c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1941,6 +1941,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			goto drop;
 		}
 		skb_set_network_header(skb, ETH_HLEN);
+		/* A NAPI frags skb recycled by napi_reuse_skb() keeps the
+		 * protocol of a previous frame. eth_type_trans() sets it
+		 * below, the virtio header checks must not see a stale one.
+		 */
+		skb->protocol = 0;
 		break;
 	}
 
-- 
2.53.0

