Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958830;
	b=LFk43MjiAzhf7681bbSdZ+ro77r82maRpBnVRqFRHzcCPmKTVXE4zmJ5XPQOoHL77Gx1
	 sAOeFRSHSp24VsyqY3Lq3hkGbsCoe+mwnOpw6oXNIBY7eD3znVGZCbF0uJZvBmuJxZkkV
	 WJJ37u51tMo8IzOJll9KTKQMXP5V3PkelxOaceY/7wOJXORDhcNX+VKr1lEaYO7ZqaRe7
	 G4uCDKJa6rjAIcEygf+evWamy5raBePK0tPbUlBbhuuFRC5Qb4NxImTpRerCQm5EHeJyd
	 JD4Y2eLtlmToz5+UgLylKuLmfP7Yiid4mmjEKqgNx1yvyf8T86/lJVM9bGaQAGAv8ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=43PEyzcC+jmO9SuRFxvHoqt9FvZx25sEYcqX+V5QNzU=;
	b=idpzX9PFm2yNiuaJV0NG2oEuSUhwV9CSbVreKxPKDIAUbLW9MYDgIALa+bwBHUtzV1Cw
	 6D+m1oL55CAiyKdPtvGSyxIEObWRmCnnuz11kgWhgNQ8gKZLyc0dr6ATrEWK+kEDADeEl
	 tuZorGiDbrLgVAVtxRHtH0O1k51T19sBkCKGx5z+U8/QPRJGgD33jerOv/eQw8lFasx+n
	 vZmUvflGu+eI0HU6sUu5Gx2alEzaHLA8AjpIVIV1aTSRVCBCYF0Oxy1vGp4f00BnubxDl
	 Kz4/gyntAvy0bS/dvh/0uMe2mpbWUT+9D6eDkJXXiC2SQebzQQWfU/L0n7wmPEgboGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QexeoRwv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91C606A32E;
	Fri,  6 Nov 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QexeoRwv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAD91F008A2;
	Fri,  6 Nov 2026 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958830;
	bh=43PEyzcC+jmO9SuRFxvHoqt9FvZx25sEYcqX+V5QNzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QexeoRwv+e5S2YWIOrYYeLwNqIyKNqYrbBvVqqZx/SA/X0Rgrr73852bm+eDmvpLL
	 TwEnfpC4nq/jSymPkPpuoEvuSMj2Qkujnr9TgINTe9lA1/rmnYopVIrqMrnbXuVrol
	 AGgFgPMUb2huhiFvr14QWwvHZfPINaPSLl079bjKxoXw2MruvvAYrbET6qETi0oD4q
	 Uobkn9Sf2zGRRfs8F9fy3/sLPebRiEDmZ9OhM8rffHimlAiDrPaMPG+BNZVOo+AX5F
	 o81xFpIwcSrh2CEVQg1+WRumjLrDCMy/CWLHw3QIp7AZjUfocbZCI19pnZVj4IOz1I
	 klQquK5SKCxQA==
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
Subject: [PATCH net v4 2/2] tun: clear stale skb->protocol of NAPI frags skbs
Date: Fri,  6 Nov 2026 10:53:40 +0100
Message-ID: <20261106095340.2113683-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106095340.2113683-1-edumazet@kernel.org>
References: <20261106095340.2113683-1-edumazet@kernel.org>
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
the outer protocol check of UDP tunnel GSO packets rejects a valid
frame when the two ethertypes differ, and GSO packets without
VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with the wrong protocol.

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
index 3920b3dff1e8..9aca5056f7c5 100644
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

