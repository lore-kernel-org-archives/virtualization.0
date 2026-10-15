Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8D52F278
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068122; cv=none; b=MsPMjSe/cnF0tsOR6QjiZOEYE5B6iorHN79j8ZuJlRGTcOqxBe2qhxrn6udR+E9jmn+tvzdh8a0+PqfV5cyXpD98z0mLjCn5MQ/C5t6OTLSKOiH2wV0A8Nu1nkOt4+Q6yB87fz2YA/CZJcHB1ixmHSJPjTQHzT2pdoN0rBpZoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068122; c=relaxed/simple;
	bh=FTwjQZjllXzgo977Sf3MiFovVAncHOGHuO9YtIzBc3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xuau/Sc5CRBWucmGJ3U4Ntq17h8ZV243j5bkTNcvTFKlIILSLAHT2GtTDvb4xOsUJd5ccUQB22m4O9ejIx+bSkYkEGrMGlk+89NCdjMDWQXkJg2uz8yESaDjCPcyBRnO8C7bDI8C8Oxl3VvNCJRrrUca9rnGtfSEY9j3KXK1cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+yTRJpQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+yTRJpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0zC8OJ6Wap1IWbd88wEN7TwTQBf0XfiTXbdedWRtNk=;
	b=g+yTRJpQqo45SGG4TqEQcVgGqXO0BXTE+Z1vehGSOulqNwLI/Ac4z5Q14Imf/5McumTHhN
	GjlX2+T7a8lLXJLT/tHTMX2leLTwOvEZTdWueJAVBeXHZYC/nVN8T5J6ioJ9gKLoL9+VqK
	WqjimELMCIrYdeJV1EAb5qlRUV9bZ38=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-95MIRBqgMrSRlJ1YUTEgUg-1; Thu, 15 Oct 2026 12:41:56 +0000
X-MC-Unique: 95MIRBqgMrSRlJ1YUTEgUg-1
X-Mimecast-MFC-AGG-ID: 95MIRBqgMrSRlJ1YUTEgUg_1792068115
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48aef5cfe43so3193450f8f.1
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 05:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068115; x=1792672915;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0zC8OJ6Wap1IWbd88wEN7TwTQBf0XfiTXbdedWRtNk=;
        b=u1KHBV3Bs0dCYjtF9+fQmXkNz2Ee1SLRP+HuObKIYeFRQcazMmIDSyNoKvaYKSgwm7
         PVkbvwZi9bVG8iZlc3mQlpkKel7UTMo4ZMOrMWLM25R02oVCP1uAWJQaKWFuZblsOPTj
         doR/8rOnEO4tkHit1Mv4hhLKiN/gKoZ1Xpix5+i4dSQkR59S4m9tl7AAzHW8KTVvp1pp
         l0Er7ohVbjSVhEMXa0hXXE0jFuSeqrOEEYvfDyhvjZGirwKvGyt1Yl7MbLMIMsDSxSty
         DRhHPaB+p0aBdD/9SL35vX06qpK91U8BBcDwbusb+pGidch83puWJBt/cuTeTVb5J9Jr
         KaWw==
X-Forwarded-Encrypted: i=1; AKwUvByjRp4Hr5kp8efRXUQEpa4pSMwKmz0pO+hR5iowj2+DBTl4rbgmwhYJytzZTc7VisxzZ27DC6yx2tggSck+7w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKtOqJsUbOS1db8+lcB/u0+Losi/mBtLZkOBQL3GBwKti/zN/f1
	3WcNPkL19t8M022H6rdI6nRnknGLTUX0gMtlvje7Iv0aBynJ0rTrNL8VHtWswJ3HI2ooQ2yRG9a
	e2qE+ZwFZNUIsuNpc0pk5p2pCe/+zOLCUMWTux1RFYQRrCRu2ynnbDSYKFTM/KLwE9JXz
X-Gm-Gg: AYBFou3mynDhGhJO5gWis8rqe6O6Ax2ABhTXGekJ00rSspBg1epmWklCkMDu505CTNB
	AYah2bloADTQ6KC2w+cVhpQwoVjk5e24FADG7elktz/dmxz0NT/6Tir4Y0Ke56kQKGhzpevTzvu
	7dFoEhI4ybyhmXW/rDDvP64FIkFNixc3gK6gKjbIvxOvdTKB8+5iXNeO0Akl1ZmyDireXWk1/ZT
	sJVQLcLZeTY2aMZ4opha8crYrdZBZdlLncQo+9+k3A+25WTfMUaRaGHtT9JDNe/Zrg+bWaHZs7Z
	HH+AJMKduHKcPR4/J2tRFnm8tgo6VqSUWItj+RZiDiU9yKeUEy5h8236+F5NK98ktiQ1BA==
X-Received: by 2002:a05:6000:25f1:b0:48d:f02c:eb68 with SMTP id ffacd0b85a97d-48df02cec55mr8110173f8f.10.1792068114640;
        Thu, 15 Oct 2026 05:41:54 -0700 (PDT)
X-Received: by 2002:a05:6000:25f1:b0:48d:f02c:eb68 with SMTP id ffacd0b85a97d-48df02cec55mr8110120f8f.10.1792068114075;
        Thu, 15 Oct 2026 05:41:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5b03sm19748114f8f.30.2026.10.15.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:53 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:51 -0400
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
	Max Krasnyansky <maxk@qualcomm.com>
Subject: [PATCH net-next v2 7/7] virtio_net: cleanup protocol calculation
Message-ID: <3c828204754ba2218e419f8d0a20bede7d8dffe1.1792067836.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 3PKr7wB7JaylLccYINh4jwuV2gvj8RAQEKoFJMMDK7s_1792068115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A trivial cleanup removing a duplicated code line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_net.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 85ec1039f73a..a9ed42013476 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -570,8 +570,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-			    htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -591,7 +591,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
 	 * set CHECKSUM_PARTIAL.
 	 */
-	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
 						 inner_proto))
 		return 0;
-- 
MST

