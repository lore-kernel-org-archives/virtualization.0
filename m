Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1374EF15C
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411432; cv=none; b=jEt3z7Y6oyKaobewOjYvlWXYCjupCd+icla+AFlj1ClTCBHfvl/XtMhd+f/Upni5C6yk1Cq4Pn9LB2txC9dHSHH+ga7A2u14RZCWYV2FBGMZ2K38vkX+RR50+Fy7EpqNPTLDS5M0kdxOtmi48OTCC4DPq3bUE9hRO+bmM1pZ7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411432; c=relaxed/simple;
	bh=IaWSRvOb2cGYlSz53/UzuVPRqHxy+V4mCLIjV89pieg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Abn2eI7pCwuz86qEn6ZW1PtOr/vNHj1twsCeBPhmj21H1K0AVMTEXGpQxm7eyBVDmnmjLX6Bo1tal1WBXg22Xmv0v30gVigP58b9tf4gbQIkvc67rcN5dtazLBrke+l++rsqMaAv1g+EKRk8oHJn3dtFlLwLozMSCLaHvsa4zyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJD3xkVO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJD3xkVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaP8+sKI0/SWouY6crwA9muX1ZFQBStGGvXIun7lVgI=;
	b=YJD3xkVOhBQj5pvbAqxDWni5xS5/Wl78Yl54UdR7AJ4Vf6kdjyOTPPKy+X8lG5F4E15snn
	ySFwofyRRYhuhTzUM6FJUpWf1Qge6GQ8lyuHm5adZcaN3FEHJuZawAFsNiPpHbGoLyju3B
	5J+ITb9RrgyjvLzGLlhguZzNUM5h3Po=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-o6NcV2xgNVWHjpOOmZEuPg-1; Mon, 19 Oct 2026 12:03:47 +0000
X-MC-Unique: o6NcV2xgNVWHjpOOmZEuPg-1
X-Mimecast-MFC-AGG-ID: o6NcV2xgNVWHjpOOmZEuPg_1792411426
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so15486995e9.3
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 05:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411426; x=1793016226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oaP8+sKI0/SWouY6crwA9muX1ZFQBStGGvXIun7lVgI=;
        b=JkdaQ0nRAOWVn/nRvyu4aT6ZfL7qj/UK8D0x5FQvBH1Yo6HEKgy3pL4BxTbBhGHHPf
         SbpW3yWTNvy7UKApPW5NFEs1VNTWsYDtW3zH0ZtPw4xcZuAkmLUo3+ZKqsiXRbBEXChS
         pViGghyv4hKMcDHgu6NHUR8eQcnH3SUTrvZ1HOlf060SpSoPA9WXSAobif3y+UCXWEQB
         aeHKtPBFZLlAOVAA0tzFLjPSGbUbJ5/baR3pkwco4qnF7h7iBVz0mOuzkSWMH+EBA2mt
         Zy6CtYIv5+1PmPSviuQc5Qhm07n1TtNpcrt8GzH2HVNVqJ3gEikwP5h1uQEMKSQoYZnn
         cXsA==
X-Forwarded-Encrypted: i=1; AKwUvBwz526dqS/y04HcTAqnRGwQLKsh9aNF2iQHsH1ZuHOzuGDQUot7As55jJEz8onwbc0rTBYhJ2dSj9Rxzf6hDA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIncItYEEndbpyg6a2Fz8hC7yaUTFFrnooOQgFynkCdYk7RBj/R
	1s7bS2+p3ioYIVROzMNn02mXRHFLWmbm9+xjzX3sU7LbGLmMdnd7R8mdF0b1pNekiaFu04yHqOD
	tmlOPEBym/ExL6+nLHccxvP4POKcxzktmTEqpILYAKY1LAjK2/A4WnDKCxn3iO9Dft1BG
X-Gm-Gg: AYBFou203S/oozSKS1qAnEa1YTzw0YWwaUMSK5Lq8yozu1ot/nJexH5zJCjVsbGYVL8
	Bza1zR2vcq5QWz+Tbau+CqOhER98lVARkcAMHJtK3P7ZitaGnTDWP+ekWU719D7l22pjK2CR3tV
	rlXsnRWWgY5/fkcdS5MhgfvFZM87YjAPzu3WBGzgm1cD4KGnSJZdztEw0rzjqXF9MMwdsDUK71J
	oXkO1BbIMYBB5dXZ4XEvCqVI2Ia1FvsyeaFbEEwxgcivkwKZP7SL2AJClgwL+kcOnWvemuv687r
	aWbMsugCbfIil64UY/xwDwcqsABoozjM5M+uugmYyCj2rV8oHfRKOvZ5JJWjDniUzjKTlA==
X-Received: by 2002:a05:600c:3b23:b0:4a1:cd83:b240 with SMTP id 5b1f17b1804b1-4a1d75ab20bmr196806555e9.1.1792411425826;
        Mon, 19 Oct 2026 05:03:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3b23:b0:4a1:cd83:b240 with SMTP id 5b1f17b1804b1-4a1d75ab20bmr196805755e9.1.1792411425263;
        Mon, 19 Oct 2026 05:03:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4feb6bsm24518591f8f.41.2026.10.19.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:44 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:42 -0400
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
Subject: [PATCH net v3 8/8] virtio_net: cleanup protocol calculation
Message-ID: <13dd30912d6d03da7f432e115e9db1ea2d2cf37f.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R1OuOiXi2RC5gTaSRqo6XgdmJ0iZ0DZ-IwxA1VJpfUk_1792411426
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
index beaecd9cd28d..bb9b5d016ce8 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -603,8 +603,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-			    htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -624,7 +624,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
 	 * set CHECKSUM_PARTIAL.
 	 */
-	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
 						 inner_proto))
 		return 0;
-- 
MST

