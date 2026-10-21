Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569025;
	b=vFb4Q1BWGTqgex1Nf9wx/Hf23by+5TvkUS5uHSgBA3W8HiR3tzCigqiqrCi9L8ZDOIpe
	 VFKXUjwnfQI8MDWW8VQ2UTEU3rZhQj6q8Ymb2eiOLrqtnq/2/KYxVVsV1pOJUpO5OV9vf
	 SyQ24jXvn7c5fvR3T2IjIOtHbJBjaulr78R0nwK3m4lhWPrntwyNhWOukgOe+ZFZbR7dk
	 eZYwYqeluOifA3vfhAxvmiiHtyg/NSIFqMmFPOwBbYprtnURjfRbi0FIWLbwIBLmWZ/DV
	 uAr2blUO3qPTsNpxiLHHEysMVGyc7vvmNzVZGUnlw2ZJ/J8Sfez8eb6UEkWTj0S4ZCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569025;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=i70Xk4AYsgpu4E10zOgBKBV1usiM0hwOau4g7tIhYPk=;
	b=fo/+jxX3W5bZlrOz6th9maU3+W4/5VeEaMCq7+tIZLnfC3gN9L+T91asfkOBOBHqu8AV
	 Ugx4rtxDVsCdE0sBB+JVHXA/pI9xuATGbd0O5pQYe7W+INetRaUWQsQZ09expSByYZ+ig
	 kMBRLh7xOkkmgOKmbPGzWsqxjNdsLzuJ+O5zB03INS9EOfiMOgCTCAOLEJ5dq/jw65vw3
	 jqi9yiwK4R6xcTIZZ+J5KkNFuL/R/H08ddpN0DHx4iQ2mKSoGqdbZY10/I3T8Ghklr6MQ
	 /coNzx8aBxA35tAdGRP8WQVNYJtW03s640ek3pi14ew9ZjXl/102tJdIX+SUEhubSLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hSALtdh3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D953606A325
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D953606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hSALtdh3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i70Xk4AYsgpu4E10zOgBKBV1usiM0hwOau4g7tIhYPk=;
	b=hSALtdh3RGIs68tuF4KchQhWY9oSadrI1/GHW9aM3x400iZuH6wDCqpi7fS2ThYZYNenpL
	yBAnXQmav0zyhk5wZI2Vf5ZcdhFKLJupynQqWR2tEZxr3RSBxhH6eN6q2gJouUG1InkCcC
	kSZuRf83XWl04km/1XrbQTLUWpAxgCU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-BH7PIx6ANWGLPrQbEnIyYA-1; Wed, 21 Oct 2026 07:50:21 +0000
X-MC-Unique: BH7PIx6ANWGLPrQbEnIyYA-1
X-Mimecast-MFC-AGG-ID: BH7PIx6ANWGLPrQbEnIyYA_1792569021
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dfa054f26so310810f8f.2
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569020; x=1793173820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i70Xk4AYsgpu4E10zOgBKBV1usiM0hwOau4g7tIhYPk=;
        b=QEmFQaTgsFNkpdd45H2KaOuOkvgHMXoOc7TRz3gYrX3PnVrDofgco9jtpPSnrKlA6N
         UMRSEC9p9XXnncfEtWY9YCt3kjEYnLhBIjwODs4ZRX+NWKAiR7PnSiFnFLHfMf+SO2Zm
         iKBerKhyidTe0FkurHI1yDtdg5ylUlxLD2KQsdJ9aShkGDNNurMDeceguc0Wmzrcdyns
         IINuUMB5G9v97KfFQd0/H0/yQv/YO2K7iJ7t2Bf9n1cOn2jm2RkD4o6Q8KbKJBSCPim1
         oWqbfUdM0f2a5JeUGVMDWg+d9vRV7wRTU6d8SbAa+Nfg2AnPwFA4IglHopPVMDvb9zfH
         iNZA==
X-Forwarded-Encrypted: i=1; AKwUvBwSs+Lmj2EvJ/sjB96p9y0EKhVxwUEZCbb/rEn653KciHddBxeJXfCmWlepuz36uEwH8MyEYO7CZvtDcpDA7A==@lists.linux.dev
X-Gm-Message-State: AFq9FYL1Ncw94kAWe3EmhQ5WFvGkLPFaxvXAlfgQ2UuU0a6SSMrMGNmy
	mPU9sP5tF+j4G2FbGiaNBmXYwa3rtzbOYPvxDbIJUwwIoU2GeIZvuurHuRMexEnyzUHZX+GBS0A
	v2XVc6T2o6xA8TafDsoSlSPEIQxDR+OQl4XM7iUt48gNPY5lt92uoXHHjyShf+kKsJq+h
X-Gm-Gg: AYBFou2CtKeHSSMMjJNoXD3SOb1hD1dIb8ShraIf9LAL2JJi5C7ciE0OqjMgBhhmWBd
	j3QWHcIwxMIFPJku8ylg/sWSPpUjfB7/rqR6y6v7l10ElMvj102h7mAvjFHcK+N54r8loEBOAsn
	+9NPmZb2MZZtPwOqilcEglgawus+AJo6E2KKFofCcVKzvaHKhj3IuEOXk47yM9UGtwozIQTP7d6
	h3k0k4CYWJMjEmvtVRpezsfgD04tr1wUs6F0s6GCXri9W6zBBZ6VK0gj2QnpY17hVWjFZKVkuXk
	Vj7w5nGBg0fjh2hyj27pwgxvZf1MyGn1Aar5h/Uw+fMl9mRGxGNt6eZzdoW4ghZhqcqRcg==
X-Received: by 2002:a05:6000:4555:b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-48e264a3c51mr1444643f8f.10.1792569020417;
        Wed, 21 Oct 2026 00:50:20 -0700 (PDT)
X-Received: by 2002:a05:6000:4555:b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-48e264a3c51mr1444601f8f.10.1792569019847;
        Wed, 21 Oct 2026 00:50:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm4032101f8f.40.2026.10.21.00.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:50:17 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:50:15 -0400
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
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net v4 7/7] virtio_net: cleanup protocol calculation
Message-ID: <07a96514a8ec131b50c91d18a7df5f0d41a488b3.1792565282.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: wESSnwJCi65f-hGJrC-TVzD8M-L6mZKt5w7FTC0gY8M_1792569021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

A trivial cleanup removing a duplicated code line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/virtio_net.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 724ab8659501..13f76bc505f0 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -609,8 +609,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-			    htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -630,7 +630,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
 	 * set CHECKSUM_PARTIAL.
 	 */
-	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
 						 inner_proto))
 		return 0;
-- 
MST

