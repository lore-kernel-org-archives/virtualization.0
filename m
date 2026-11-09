Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242125;
	b=2Ph9T7NP05oeKsFjbuXqiW/ov0LyBHmNjs6yQCoYOqziYqNamCorlOGfxFnJK4/p7m8O
	 Mqnk0JiJE0U5754R6r59U/p8RpKik+ZS80fxx7BiIoxLzJlbvYT+WJTDx+0h+eQ8WgcOz
	 r+ZEYfY+FqSL3xCdfRk6VIWZuGg4aFDrWw2/jSdDeTQGWnveeon+fd7d9+SaGQV0y4m/C
	 rVtMlTfCby6+qWqe9X1Zy+1WX3BXVUDrD0iFsEWiCrzYHCoKYxG/lkziIN00wXtNo3/S/
	 YjBmSILb2VRzZmXq7DRSYpY8U9YQmuxNJj27vSWGQ1jC0AtYZ8dph6Yqja7EhzgFa2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242125;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=43PEyzcC+jmO9SuRFxvHoqt9FvZx25sEYcqX+V5QNzU=;
	b=nEXolEEAvwugKDwefaaQ3rKRKkxtvntZHwkLmTRs6y3vLJmedFEJc0mMu3E3e7Nx9eRp
	 hz6DzJ3PZnNPair+asDjnDyhyno0aEmVdb3gIC6LBLfBnos7YCK60z7Dt/4AOoYQDNhoJ
	 zpOgarAfsw4fLExtoDRAmTXnhz+rZAlhoQe4+DTuRu/71A1hf0zOAqw0HmDPUkeZWqpzM
	 2vdiMPlh+cQexueK/Z0cfgISKHpEpKesPDaXX9KTqgYZTDpGdVyf2jLFsbDBGJdf5o5o9
	 v8qT6+lbj/pSI8PD7ZDjw7eUr9pFQl2LJSead26pxsqRfqtXM9k+91ODN/aJ1nXkoow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSxUxtFl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68B606A325;
	Mon,  9 Nov 2026 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSxUxtFl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A221F0089F;
	Mon,  9 Nov 2026 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242125;
	bh=43PEyzcC+jmO9SuRFxvHoqt9FvZx25sEYcqX+V5QNzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mSxUxtFlT+1Lwo3RkI73K+J30SCw7SihejKDGpZF8zPjFCOqvZGO1v8YiNeCTPyQQ
	 JY51nNJlMzD1s+/ryvBaihv5tFuRiTlZvOTjMitDtApjl2RbIMta8R1T6qAdAIN610
	 w0VpnmNsU/nv6Nll/qcutT4DAhd7+nN2glNO/u0lJhPyqufUYVBAYyfxy2ibcjaH0J
	 LB42cZsQgyoM8yzAJ1+WMYr5MorS1j5dZ68fkh37hSkZdw0+tHaFsEUu7QVcMUueou
	 HUDzPrDMb9eNR3MG5rf82YXkmFqsO9vaT4Ylb800SSsqYoBqH7bsPu2TMMiEwkcRFv
	 S2U3YUsSF5+ng==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v5 3/3] tun: clear stale skb->protocol of NAPI frags skbs
Date: Mon,  9 Nov 2026 17:35:07 +0100
Message-ID: <20261109163507.3102091-4-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109163507.3102091-1-edumazet@kernel.org>
References: <20261109163507.3102091-1-edumazet@kernel.org>
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

