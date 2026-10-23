Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768193;
	b=cHxqwhSJno1q/aetjVf/p5oGykTvrKc895k96hEcc9Vih0fWw+Eln8wLDPlKlJRMVVaW
	 rH6CPtvwxcS68WWMvyetKwme5qybo8A1UKiM9UCFY/xGYyXwEKoHnEkZv80haPbaBce7p
	 9R7/GOi1MhFD+4t70JH/Aw5K8P8RqCbULzlaSCW1CRUjVgtejA/uBccRiVo1HsGkLkr+p
	 ox8DYpMN3QMX9mGrvTuXrB2/UUPuppOlyPXn+2z101+NM9sMeYzM/D+YWWS8EfPWf1QEh
	 QTE7U3oRPwQqvET9Ua42SiBLPG7k7HGOwqUqaBMSjRKDCiT3EtY1nEOXuIS/TpdBmJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768193;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=P73C88KFexHnjdv1ZubuFq3h0+sJtblUBH3qJtB3pUP2/YU12JeFea5uF16TuXZoNGA2
	 wzo0LJXV4nvpy9rACoUP2kSe49nX9ENvqehZR07ZGQ0Xdqj3EyZzVRzmqT7qpfnYEgdOh
	 K8ofKF8AwA/0LlV9YqYL3fYnni8rD5yrjTngOaY+AcQbXR3sr0dkM4nplFd3g1n6qYE/D
	 KFosla1owsGhmboZERI33MHKeh/YFvDFH7dwU+WAR/n21ZD85PUi8QT27wzjZomReYlWL
	 orFYXajUbgfxslQBhX4VXjhb3kcLyvKwRWNqX1Wi71psWxgo1W0u30fRcIE7uq7+qkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="PLV/HGc/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9760A2603
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 15:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDE9760A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLV/HGc/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=PLV/HGc/y0rLo7xsMH3w65aZtwNrlZK4QBbeq49ry9pLeASFAaPuprCgZOf66aKiVXSdLb
	riy/jtRtWxXIETXk2OeyiCmjuyql6DvES9Pt8FkxaQ35DOSPRByU9v2pXuA0ZUO7jraFsA
	MUREaohp9blCWC0GwteBzXyDgYJZbRo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-_5VVxObhPC28UfNzfY4E4Q-1; Fri, 23 Oct 2026 11:09:36 -0400
X-MC-Unique: _5VVxObhPC28UfNzfY4E4Q-1
X-Mimecast-MFC-AGG-ID: _5VVxObhPC28UfNzfY4E4Q_1792768175
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso651581f8f.3
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768175; x=1793372975;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
        b=m+JZGYLbd2q31WkFtt04B+WZQgWLqMZm3o4fK0pzJO29IvXjMlzu9PX6BR0r62NbVv
         0NHvsqThH/lFJRskXRaeKo76jf+6u+Jm51cgdMmog3X4szl/b/lfT5DQkzhc6VMHBojc
         RiM+8X576naIyV8eTQadSYMi7QiqagKq7Sswua2h99P+ZbrLJRpgAU5m5cpPsNxWzrje
         5jx0ve+Ex4Gya97HJ4ojUrB0/FF47IRJe8rHaGCNOQycZ8Q7B/M0cL9eJdYYhdxefL3j
         iiVOQ2eHzK6rU/XogbjSAYCmpWz4IdDwb1+w3Fyc2HIafQMGzIjPHjSC1AoWkfwlsYT6
         h7Cg==
X-Forwarded-Encrypted: i=1; AKwUvBxJ3n115u2tddYAdROJHPjt5lWAHeTTtgwScSNQjX99Hg6bQcFePSOSE4DfdYHIXpSQOBHyf3ry/yBM4du+vQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKYeGzeKjRybxEj4paEDPP+B6JQML1+EaDY4nTLo6Kg0VLdOgEZ
	EpYNPF9SCXrbpbvwSBRvX8uyc94QKajnGJULFQykZh6+dZ1c8YPpoXDvHkSbcajdNnmlSzvb4xB
	LNpcwGCpU0pdGVhwY5rojwjU2OXYnumSZAAsHmGrZsBJsAcYR7IB1ymrmVl8rw/CAGtvH
X-Gm-Gg: AYBFou3pwZoly+ecaWnw/ztUqWyr01QXEkN+ajKWU7gXeD4oVN/S4QKVTjXKcu44VsD
	HBSzfkPUJ0KgR8rPt9Mzu69hHZMPBNwvOyf4pkpgSJoQ3m7zm1C4cXmXlE1F2YVj/N1ByKaR2GR
	iiFXwlOd45pfEhHErkScokz2E12BexWFeDO3moLrv+bgHYuSZPAmOtMHNtSb+tO4uCIHdpeT0rF
	5CnmXrHBDTIO2LetxmuTCwYBYE59cSBk88w/PRDeRh4MEgb+KMubv2WAB1STEXFLX8lpL+y8Fmr
	/KSScapTeyzwckJ6B6kPcm49fJkR5qajngOfRMN/Y0CRqOiC8ZGdH16HlJx4ouJjv2uHF3o=
X-Received: by 2002:a05:6000:4024:b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48e38594e74mr3887750f8f.8.1792768175113;
        Fri, 23 Oct 2026 08:09:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4024:b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48e38594e74mr3887682f8f.8.1792768174508;
        Fri, 23 Oct 2026 08:09:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d400365sm339853f8f.25.2026.10.23.08.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:26 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:22 -0400
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
Subject: [PATCH net v6 2/5] um: vector: trim skbs before verifying the header
Message-ID: <dbbe73d2ce720e333aa8fa7c58b7bd01994a4216.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1792768096.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xMoIfVwmPim_4Uh-QeWYOoESwYNcw3lIfIBLmBJaIZc_1792768175
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

