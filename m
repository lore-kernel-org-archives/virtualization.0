Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300021;
	b=aZJalxjzxfH/gaKKcmPCV6lh7NfqPbtN4q+kgRnFI7JzLlAP2F8DwN6vqVK84KwHVNUl
	 +kPkW43ByVAiY4kukavPdYczcuNubbwSaXzZ2xchpkmiVcl7TEx/8/Uiof8Pw/QI3ygbb
	 6scvihj9Sk4jIUAOtcEMUlClnhmMow9qrtFX87WYN0+MWZDIB8HaUBJKfzS9gKWCS5QmC
	 4KeIK1naH8qcwRq+CAgEfNNVahojtf240x4FH31tGzg+DPf2kelFZKHjDI3Ub1pPfNh5h
	 W0jhoonhv1AUh3/ORLSC52hBQcF0R3gA1ZuQMtNB6sKwQzsoxsQ5JdBieeLhnXW/KCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300021;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
	b=iNyTQC7TIRhvoNUrghNYDaNFXvlQnQ+b0t/6/1RLYHfC2vP23iq+uotUir+eH8IlBBLD
	 p6KdyhUveDjZGyP6EEnyfZruneUvRpFj13mxT/ihfW23ihoX12wOkpXaWe8lRutfOkr5/
	 aIw7wwb4yRDinhCECKwQ6uRl/nJl051Xxu0I4NUJFONOe1hC15itwlyChtvPJaS8IQi8C
	 zl3JGfm20dv1JaWGTZKpUqsmxFPPhWO7LcnLeolKxQe2t7fYfjjBopnSu0zQ/9562z5FX
	 bhGiMyNe7Z+/pAnu01P7phDAkHFSVCNhstgC0aWNwgYxQOdJxOlOX0RYQzA3QE/WbLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YlJAnAkx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C060A2600
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 18:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D6C060A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YlJAnAkx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793300020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
	b=YlJAnAkxwJ+kqnHGTw7OOfRmBCTLFLkHQwPwdUPLA13mvof1syA7Mox5Jr7a7RyOZRUn9o
	T4PEVcAuLnGWwfN6QKTg5fhJF491rZMaI6wQYTtj6BCq3xWPpkKYY66QyetjnJ5kpNoVEj
	EFzBO4EOnfI7m/4C+jsunLRzfphcRv8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-Ii_92-GkOqaAM_TiqRUxxA-1; Thu, 29 Oct 2026 14:53:32 -0400
X-MC-Unique: Ii_92-GkOqaAM_TiqRUxxA-1
X-Mimecast-MFC-AGG-ID: Ii_92-GkOqaAM_TiqRUxxA_1793300012
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so21202785e9.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 11:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300011; x=1793904811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
        b=e4J2eHEfizFL9YScm9Zt5KKUy/jbL7bv0Flg55aRlFDiL8byo/YVIK6aLD++PeOsAh
         ayNfAG7tfCzr26itBpDmyyJX7XdEHsGZhUSvTIyTlgCuzlJ5Fr7LYMFBmvaypCgqCM7k
         dfoKbrVWm9PmQnUNLy+/h1LfxAycGV2wlGlPKCEl4+AIZHlgK4AQbNR3CdX7SFx6EpZh
         z9a25YZLNzefpoqZPHu2cPcTNI/TO/8RQxaBc0+CljTXjCX6nSHNDUjjC2es2dvt3/dD
         Caj4JwMe9bZ973I60sUEdKUZ4oSgPv6lCjiZS05P54qxLAb6XqzJbk2SMdPm5BhuSDBV
         T/Bw==
X-Forwarded-Encrypted: i=1; AKwUvBy24UMe8VEKWUCYMmKktXODHeKo5vXkmqiDPu1zx5rfbDFy1MbJg9/g56yLYBjHuxojQsc/cpxP0i+yObfA/w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJTkOBnqGw+THPK294sGiJxn6iLBqEi+aX8XTtCUpQL6M3EpH4
	+cEwxbxJY/xBzqyXrrskk7pfO8NVyf1YzNnzGH14JjZlzt//eavNCzb4ZCNNahEKC6LM5EoYmCV
	EvBUtszBPCKu/VGDDATWtgCGYAAu+h5vCZuPoy9poIpOA5+IOKdjIEXet9ul6+7qh5UJf
X-Gm-Gg: AYBFou16pjIr9Vz8sHYWyHev37devJYE4NO+mCoCRJaLExiffekDIWz7UWEK1VPn05F
	SXZbLhTkmw9GtAaBQmWqwLZK9f0jKpT+DAWig2xHETXR6ispD0TgpSdjJ3995mTcrkPV6Frjmzc
	SBxykbiU8TZNsSa587gfYRKmPsw0XnusXGFMuWa13Frd0+FSFOnGFRpY8i+DHFvxmZcBjFk9nXo
	KwKzbIoNcvfrvgFiG6QU+E8rDLoFn2m1cxln2J3C0mXtaOcNJ2Uks9sDkMZtCyNxu9FBb7CmVDo
	9cZC1b6ibe5DpI9IJIYXhi6tcjbIx+hBAYZKYb1femkrg/r3D6a4B9OYzZRwy/ZddPQ1NKKkLNl
	P5U4HlwiQ3ad91SlyfKWe41TXYF3P07qcYhEuS0nGCVqs
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4a9675dc5cfmr142984395e9.28.1793300011469;
        Thu, 29 Oct 2026 11:53:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4a9675dc5cfmr142984155e9.28.1793300011057;
        Thu, 29 Oct 2026 11:53:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b289f7sm4241265e9.5.2026.10.29.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:53:22 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:53:19 -0400
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
	Willem de Bruijn <willemb@google.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH RFC v7 2/5] um: vector: trim skbs before verifying the header
Message-ID: <d5a36cae5997d36ae6b4bb192a251194e61a8a2f.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1793276116.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GPzs0mbUzmL5yYTXTuyzsBuNnVC4SKj4UV1BzJYtyZ4_1793300012
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index e902e78c5ff6..828bd61995b8 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -873,6 +873,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 
 	if (skb != NULL) {
 		if (pkt_len > vp->header_size) {
+			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					vp->header_rxbuffer, skb, vp);
@@ -887,7 +888,6 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
@@ -989,6 +989,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
 		if (mmsg_vector->msg_len > vp->header_size) {
+			pskb_trim(skb,
+				mmsg_vector->msg_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1013,8 +1015,6 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
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

