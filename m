Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673899;
	b=O9LQ/8oP1ay1RbhuOPEpu8IlcqAE+NmaA/YBus3PJggw4YBhc7zJgjTW2ngbYHMot43K
	 azqxVdk4pdf1etNUmgXauHqGxLecLX/x2jKQ9UEiXpASnaIsqrPOFlxEch848UUzTUsMR
	 sOh+RkFC9TY6veXQAVHJDNXAhBK7xZ83TmYAugtDJqXk7VoV2UWz1MgF9t/aFglWBi40O
	 p+we2igADxjjQVIYzIoCMM1/a/peQCZD//42/kFbhxTtNiJWt5UUTHfpmjjtbIUuz7W+b
	 jrnPMKAZggeyUs6nSx1uacIc299TKpdXJeOV62lYGR/Ahx/DtG9ThgPBssZGijOI3jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673899;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=b6JY1dUcwNGQSOJbm1hlDdfWSQIe4kYyKv0kjFltE7zxV3bXl0kbmhNRgoMrD84P41E3
	 Unews7mh/VLH4pzMMLcV/qHqcvR8MjB5rckXtGs69DHUVd+D6eOe1y2XUDwLHLiO3AEg7
	 VFyvDJCzulVARUAXEuQFhd7oOIRIG/bn7g5JumvSJ1e0H/CNHpUCOp+BwUTO2nFJb4sWA
	 qzryysDquqQSfGUzH8U4ihGga8u0veiMz5eDKRAqEi2vDqoGX8753NBQ9CwL+KPbTZYjE
	 LBnb7/jwIhhCaprgeuLNtqBH2eZWmp1Qd3qQuJRPJ3J+gx1YEWuynAKpE/MPWaKMIuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jRDsSkl3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86547606A330
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86547606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jRDsSkl3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=jRDsSkl3fEDSq51XXgV2/7tzf55ovASvfjehudhYBIpD0za3eINgoHogkWcaMV4rCQmCoo
	e79ba1LOi0EPlVzaL7LQuEaPjBc1r9G6VSoyIUxsb2OhUxI4G4HgedQmMEC5aWP5eYTo2k
	i2g7UGG3WK4edkw6lkjuu7l9cms2vwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-b_ZHvozfNCORLUp48CL9_Q-1; Thu, 22 Oct 2026 08:58:16 -0400
X-MC-Unique: b_ZHvozfNCORLUp48CL9_Q-1
X-Mimecast-MFC-AGG-ID: b_ZHvozfNCORLUp48CL9_Q_1792673895
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e29c25101so845501f8f.3
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 05:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673895; x=1793278695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
        b=ZK9UxiTyiB3nYWiZ/sLADRMd5kxqErNtT1u1pNK7dtCEimUM0nvR3JKgah7O2HzkyC
         IpVE6bi8vDCb8HZs0z82sgpxwxINlFTOBRKoWfCLwS9O7808fonEWz+Og3g6BIRlmtBq
         gh+HlJb4dcA/Hu8Ni35P9QDnKEU/HgUydIw964nFzQ1RWW5kdsTxNIIizo04pluemKVO
         YrqHy0Ck+V3zp1NvkI047xgR5wXsAECmZfqjlkZs7Gcnc/7kUK4hSayElUvVAbWrwxg8
         d/H88pLYT9Pw4kc8tRgla5sVvLlRGm0c69BtaqoBAbn4Cv1VAhvtRV9n+TmnhjEiwLBQ
         WCBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcCvAuZ4X79AAbrQTKXrxVaPiVu6eB6sO3yEiF6nE6cnhNyh530fxQgHmOyGHDYWioAMisbWC/mocNhWWBxw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKliTSaAHajQ/ZJcQdbdb5PajsB368MOSMLQ6TfxLIRCWtlsLYp
	2ClOOLT81WFWha0WHHKgUAcGTYoTPBwh6KCHfjwAuOeWXjZ0juyZNr2Ifh2FrBCy2mp9puTMJg1
	HDt7TocPlD8XouP02xKe0TeFCXXqvQwodn5GAhbftkOXHdpRg4dr072DLX1NJJ/UXJ4l5
X-Gm-Gg: AYBFou1+YRtS0Y658hH83CxlwYMg9PjIg9U3V53ltAXbvyMzFxl3C1TJ8AOJBGChNAX
	JMi/2pJ7ml3Ki0o/OgKHI1vtGGUSK8qrMW/52YPbmlf7v9VRPNTnGuaibBMxITNbkvsMiUmxbyi
	LhP2AYen3o0auPONrNIyIZYc8/BjTrKsgJzNywF35WF0B6MoO0ukXGMT6rwcjKT/WdMksi7cPzn
	XvZiTI1MRmGoo82xaWi+rzJUUTCRwYTKMXvO/kHR/qWjAVtNkNo80oKp76Q15mwXW8wRwq07cl2
	Oy5Dnu9lyduE03wYHeDGWn4FrhP3O637YK0PrnR/CtzmOg8CY77HkCJKeKMEMuZ7WgE=
X-Received: by 2002:a05:6000:2289:b0:48e:932:af01 with SMTP id ffacd0b85a97d-48e264b569dmr9840309f8f.31.1792673894858;
        Thu, 22 Oct 2026 05:58:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2289:b0:48e:932:af01 with SMTP id ffacd0b85a97d-48e264b569dmr9840264f8f.31.1792673894174;
        Thu, 22 Oct 2026 05:58:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583ffa8sm12500019f8f.51.2026.10.22.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:04 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:58:02 -0400
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
Subject: [PATCH net v5 2/7] um: vector: trim skbs before verifying the header
Message-ID: <1b2a0697662501fd4fe896a7dc2bba2d97885101.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.v5.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eZioVOFxVqlESfNzGnI7Z_IRRX4yvUNt1xsjvqikxns_1792673895
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

