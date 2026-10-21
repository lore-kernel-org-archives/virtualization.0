Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569004;
	b=H2AscJ8CDar8blxDmWPhc0UZh8merDFJaVKrhYC0wabsXwtX6PdwGyNdU+lLd4fatq03
	 NZsNWRqiFJLFNFZtkKnwBDWY5Elw0lQC/Tl84ZySVbCjErl8pIBPLs39rLdX0IvJEPRk1
	 ggYbvoulo89vzzBE8Y6vJCZqqqiCbrSGx/r0HVE9Qhix8FDPmQInfzR45jZVKa2t9nqAT
	 ss7BuLt3SfDdRHPcP9exFg6NKKHfzDq5GJGttkYgUzVo8bqcfXMuKU7LII2AxgK5d2LJZ
	 Bfi954YWyjSHSMsSrjzFxpvNlcY9sHr6jJVTTL5ATWZxbP7G6b6NdHKpZ/QvKzSAj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569004;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
	b=IWch4k8hbV01fXcUP9NnvOJJhcRxXX/x6I55HvQ5bla5BTczdwRFgst7Vssk/2X9KlQ2
	 I1LpnqD911DyvkgJczY6+cdcAN0fRrlBKtMWzqwZsRRBNiDixeN14Yb/oZFeIShhyvRWG
	 /qywkxQ8a/GM/WrMqH5PO8CaL5gqxUEdIz+nSdQ6sFMcTZj7gMvY5cyE1YjaBRJQPTHo2
	 8hLOow189ugy/LR3VzHt8cv1eqqsOCQpX9h5eOPl361OOHCkMXFVxgVtjSriWqcmVsijZ
	 MWEA1oBBw1BybciZJeIbQfYVPog3PxS3/qjXNwWFxgpev4w0iaXdK3HZse9KhvGIEOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AG8eyZof;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD74606A324
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD74606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AG8eyZof
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
	b=AG8eyZofS9EVP/oREakFOFTFRHSoF9DDX9l0S2sGpgQtaG/UQpCpbrHHMzB4x2Bu5vSYVY
	55/npnPA9pHwxyCwvo6FLqFSK9OJHLjfAm9BINUx7KTbK/iPljSM5NGQbWeCzDffPnEBwA
	mkVScBnpfYSsVVeZQ9o725Q82qqgY/4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-opmgA2AoOtS3xU3SNKJ00g-1; Wed, 21 Oct 2026 07:49:59 +0000
X-MC-Unique: opmgA2AoOtS3xU3SNKJ00g-1
X-Mimecast-MFC-AGG-ID: opmgA2AoOtS3xU3SNKJ00g_1792568998
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1080092f8f.0
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792568998; x=1793173798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
        b=wgPDc3OmqdRbMWby26fZDbVlF8nd81hHQWZxizUOK4Xp5EAI0GN+emY3tIvN0vYEXi
         jf6yiRlbmI0G+QbOrb6FlMtvi9Bv7iQ+QYjgVlcVQz7W59uOdYxhDU/4gyU6TUDd4MtC
         t/16FPG81LFXrhJ6l1mCj2+9s+2Yrh8VOfqXskdWifmxRspwvp1mLUjoREbkstS+Y5tu
         nEYOu+ZhvDpXS5F5m227ldtgWHyXUDh9ygL0DP/VBhrbZgYRZw2eDklul6mz3NswtciZ
         43/ihnTZYE7ZUT/vNBWl5vNXzka+UiUaGea2u9W0Aakd7FUqK5IABkY8yZtQ7KfTO18e
         aJKw==
X-Forwarded-Encrypted: i=1; AKwUvByj/4M2Q7NnKIVexwPcyyAkZf9tZOXOKK6PIFSYTrwH6lYuEPAi/Mh8KlUlUVE7XB2F/bzJvx6irFCO+Ff/rQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKX4A06OBXAFrgL9VIDeRuKEb91JiTD1KnOKD/mlKD4/i2yRG8h
	WZKJW6yF1fo3q9tGYvVNHCjzih8+bLG3tW3x5tdylQG2T4Fkrd1HlGMhYXnR+PF4UG9nFGQw4a3
	FnJKtiaNploCUE5vw6KMKgCTMnKRvlne96sGYyOv2CTkLCx8M40fDNlo/0mQfZfUfL/6f
X-Gm-Gg: AYBFou0p0r950i5ATbx+4YqLI3ECD1o6/zPjCmFGfkUqZj1xi53Sn5acvghyy70EN6s
	kUDi+X56Q0WA577xzGx1GhsDe0lfzrUwDTMz+G4AjY0p55x713zO5w6xdxjB13gXvdxWT9rAyXd
	PjC7oFQa+YJ74LeAYFOvVBs5oP6+u5uzrV4DOLsGbTxQJTUHexPvUY0rS7HQERUaz2QYDpi6aO5
	MThNPBqTVNGQqp8D7hS+Wfr22TzHsVxdEN0K2DQLgoh31rSSpHX0UQwJ9Gosk2Yb/hKsOT0AMz0
	FUI7zS9b/Q+az1sXHJ0lufqtw6uvJ8hwsl+tDvX1SrrMyEdNq/25MrjqkPRav4pSE0iEdw==
X-Received: by 2002:a05:600c:3f0d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1fdd29c19mr24760575e9.14.1792568998287;
        Wed, 21 Oct 2026 00:49:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1fdd29c19mr24759945e9.14.1792568997732;
        Wed, 21 Oct 2026 00:49:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1060f3sm34363505e9.1.2026.10.21.00.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:49:49 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:49:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net v4 2/7] um: vector: trim skbs before verifying the header
Message-ID: <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HzEA6cxxDXDTUl-czYp075uC9QsWf4ST0jewfvS25AI_1792568998
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The vector receive path over-allocates the skb and only trims it
to the received length after the transport header is verified.

A follow up patch will complete the packet checksum in software within
virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
checksum would be computed incorrectly over the unreceived tail of the
buffer).

Trim first, so the import sees the packet as it was received.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 8a70b3a62553..1afbef78df72 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -865,6 +865,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 
 	if (skb != NULL) {
 		if (pkt_len > vp->header_size) {
+			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					vp->header_rxbuffer, skb, vp);
@@ -879,7 +880,6 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
@@ -981,6 +981,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
 		if (mmsg_vector->msg_len > vp->header_size) {
+			pskb_trim(skb,
+				mmsg_vector->msg_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1005,8 +1007,6 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb,
-				mmsg_vector->msg_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			/*
 			 * We do not need to lock on updating stats here
-- 
MST

