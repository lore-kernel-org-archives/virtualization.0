Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E9191F94
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068100; cv=none; b=VN9wUGzMO2JnZeKDMo6GZCjDIyIuTpUJ5Nfjx4w4TkZFXriBenvkcAdBDoQFyj8YZKwPteabqmpEIo1plti4Y8tjltEscSPAshNtXsIv0JaOTI1tWJo8N/spZm9AzxLPz41/JrsDxfK0JA7vpCOydu5cAPe5lRo5xwJvsK19fl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068100; c=relaxed/simple;
	bh=IwhLYmjLCPlF0e5s5GUMXm2Cd+FkpD1UwImr2LvvCHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QQuOt2Fz1kjg1QzBeJGTizkA1Ya9yp9ANj0b4DqY7KPSkWUjJ7Hi9GDznOiz8qdxzKS1ZSIcWVxVlLJF5OOfhkyGBVfuEn8O4ndbPNlorm4Beee0o8BSJmv7c/MtfQbcopIsERr/e5T/GM4exiPz/myfTQjSv4K7igyiIU/fFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdwinpGg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdwinpGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
	b=cdwinpGgKCUZUoUbV+nV4RUa1XXx8hjDVtGlKZx5qdtEwLuw1ZRV1oPEQbpy8s5z9NU7D3
	Z8sO0a1h+ic6hnv6L8MXfk1IcucnfU9WNxFDoLY9Ls7SCHt6gBOFAO70jajj//n0Pegv8c
	3PfsuwPR67CHx91hdLol0S4nZ8D9H/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-k8Fc9PQQNbqc1gmaShbH2g-1; Thu, 15 Oct 2026 12:41:37 +0000
X-MC-Unique: k8Fc9PQQNbqc1gmaShbH2g-1
X-Mimecast-MFC-AGG-ID: k8Fc9PQQNbqc1gmaShbH2g_1792068096
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df02e6b40so921769f8f.3
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 05:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068096; x=1792672896;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
        b=fs9fEcXPAIb21J1VmlMBVskhVIymZEMGsycFI3Uz22HY/Ht6OCzQmjhnsYiHaDMFw0
         6gQGGEOKz8Ny3+9gNSE1e5c0qguIOLzskBwYQZs1FTeidaGDoPlTJTh5jUv9EKB6AhAP
         wRCTNT7B6UMwAU4pQjQI2vG8k+Dzl7cvk7RJBvjwc7Y0cooCH2LBuoyIQbsB+kh4YpfA
         gi+hqC3iA3/co3W/K+RV3tVfmcsolNVjZw7Ual9VGGVmhj19ZFAWnjYfkk2P21ZEmSkf
         DKLFj6+nB79UMDrm047VZNUqYOOG4ZH20j7liHq87GxZa/LZUzKfoqT4Zv+2WGdc8xHO
         iMkw==
X-Forwarded-Encrypted: i=1; AKwUvBwZ16y9i2MTAoxdn5fTONliOVbaFb+bwk5WUpj5N1jv9W/yfaqcM4Q/4EZXX/+MChPp+r/hTJPR/5dVWWtkVw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLwyYF4FqOIXqMGHpom6Qovu3GzNgtrtgngqcHN+mlQ6nWaVv/t
	MtcvLApJ+2XHvqCt1lOvlYcNEca9sModHFWTCtwKB3QJnR2iwHF0vpBxIJ+gk7Y7w+OhLbr+T4Z
	igmCIysTO1jxdHtA+dzysldtsCl3lNLtoipCIGae/gYbNTx7I2/vmUFzwHKel8K0/h4Fn
X-Gm-Gg: AYBFou2SoM0JLkT5sVCwq8SRi2/IcZAKLaK6H/Lpj1eBTDtTw6j30PtDRX3YUlTaoiG
	N4iTQfFi5fwKamh0bdY95qXvUyzOJ++J6U7QHI+eUPePKepG3sqHl//AaEjrk0GgLDM/2eryB2a
	7+SOC2ViVuke2s/XZ7meA9R4cGJJBzesYb95nJm5xNEHmEQWg1GbIgjeGm5I6Uf24/KnuNdDgW5
	XH2BINR/FF8Fm4QDthZjRMk2aj+S+aSaefJSDJROYr6h8j4oU1K4Q8bk9+eWehYCKFN+gZ/c5KB
	JiqiDzpAhTFLpLVB6Onu92ZlQuDe4CxChsX1nEg9WgtpMNg9x/vbYKApCQElQuZKO5oRnQ==
X-Received: by 2002:a05:6000:468a:b0:48d:c162:571a with SMTP id ffacd0b85a97d-48dc1625761mr21924077f8f.4.1792068095461;
        Thu, 15 Oct 2026 05:41:35 -0700 (PDT)
X-Received: by 2002:a05:6000:468a:b0:48d:c162:571a with SMTP id ffacd0b85a97d-48dc1625761mr21924037f8f.4.1792068094949;
        Thu, 15 Oct 2026 05:41:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48defca4013sm8758247f8f.9.2026.10.15.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:27 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net-next v2 3/7] um: vector: trim skbs before verifying the
 header
Message-ID: <d9ac3420f95c5953227d80c71ebc3cd7e3c5fd9c.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tPl1NaZQbi0hkq5ip3j4_KSzUYXlQQoK58oKXzl-6M8_1792068096
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

Assisted-by: LLM
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

