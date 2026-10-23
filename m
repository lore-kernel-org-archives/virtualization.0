Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768183;
	b=v5C7iXD7uB4DWw+ZR0cOdaAs3+rfv1mZS3i3YJcWMak0aK2L4r4TyR8yG+kNI+XKmWe0
	 jCnulv46qZb5xiPDmFr/iz4kiKlIJ3nwPPHCxiMd+7bOQhLrll4s67PkGF2L0PKqmhhPx
	 w54lNxd2ffZADJ63bE7VQyJg3wJ9j9LvEuRC6Sxr0WFyRipugAPNE12+z1gwr35u7VMZp
	 XD2lcuN099PsMgTaMnawdubMl39SoC7tM8CVKfUoaL84NWu5r/LTwtGPve7eHD1wA5wcQ
	 hX3STzQnvjV9CtIdz/f+p6Dwz7fZAMTrPz22KDRf4OmIQEhlY/7QluGsDmAllCwHrGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768183;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=41t17GCbg3IvDO7xWTVUZze1LmHtFL2nMEwB2wiNyOEe0CC17CCi2eQiYRfBosw2GsL7
	 MjBOG3ZV3TvyP7+C/1XNcDUGL3vmTVGnqqahUnBgJscsXbEXCSKpyQiB6tfUVyhd0xFcz
	 UGQHEDw6fdtl/cNwPpK462XP63PFxp9tBHqxK6Kc10UUZaZ6IAfIvWpJDsO37qMzn3zMD
	 d++fYAJcVwbLb2lZz6yZqkp1jgM352EvyoGeiSjBrWhkiV/7MY9kjbfMxV61E7bN7AmCD
	 ftNrdHs3zW9zl030HFwc/0ySNJIzs6OIvV5RC8jsRBM7Dx/zPdsyoL1T0MOPfHY9HLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XY6f6aHk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2560A2619
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 15:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEA2560A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XY6f6aHk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=XY6f6aHkeA9N6HGwv9DaMkIEv/SdDj/qEk8zhiTbanILVoCzWpgyemgnPRi11qTPX0X8b5
	1qXqwutAZk7Bbdb5Mu9OzNGlTkrAGGdbUgygLO8ICaaB48xqXjlWooJHRKzJ8qNNXi0Anu
	IoieuriFRk4ujmhJ1Ez4re1T2BkDTIY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-Xk4JTNXnOaiyxY0nQoPPCQ-1; Fri, 23 Oct 2026 11:09:39 -0400
X-MC-Unique: Xk4JTNXnOaiyxY0nQoPPCQ-1
X-Mimecast-MFC-AGG-ID: Xk4JTNXnOaiyxY0nQoPPCQ_1792768178
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1441649f8f.0
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768178; x=1793372978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=HXuVGbqHhqj1VYcuQIyRO0hXOCzIWWHed6vmpn9xr0jhlKWwjNWTH/LqsjeqCnGmmM
         Mii1AEbVf9EyGMGJHh3OSANK8JeL9A7RKkLj5K92TuefyftwKk+62A5QzkgoyAgWESim
         kVHFT0xULh6y6WhEQipEOUrD1z+P3iwBInbvQACssNFlMFBeXvEXWf1LE1lAD1bOV89p
         gopvsBM6HMRSfw4RQ7uTj1ivP+0KiPh1+t9517TcVr5CBzUfPlp11/QUGTv1gf5AHDk3
         LVTByW5ZIFvzhSYCUGLmn5KV45xfq3z/tZHu74qMPXzWkt8IBWBBH/O7oMDqIK5fLhnb
         7ydw==
X-Forwarded-Encrypted: i=1; AKwUvBy/mEr1Ko7nmnMEPBYwqn/mvIdv1Ra4L9zbEG1ILIrxJaXiRQaU5/Bxbs/oamYzyKDgHIk5nP1vANj0bkDLxw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKUmdXv3Wa/prB5GuUaqPks869h0SLy2JsWAlnNAtGhcYW71xBY
	/P1Z/n0VHafta2o5RMnEpg7cOy2QCq9jK2PI50lO2ntfCZXmA1iVbtiU2NDEK8TyTxrYKdfdZfc
	+6M9CkZ4DIFTvar/+/5Dg7a/6pcYE1q0uFXjh4EpnR+6XzL7aM9QBpq7OFZ3WDoeKgEk+
X-Gm-Gg: AYBFou2vZ/K/TJdMTF1D5NsM1wbazkPXLHE6YPCUa1br0jBAa9HOvlMNjYw9GZY8WFc
	VX6PxPobqoRBuzIHGuUGLa0ELZQislqiu19yPcV8eM0TaFWKvWFSi35QccUmrX2JfF4Di9P2ATp
	z02l6mkQkq48cV5AQT62bPSzrKR3dOuyZB530rSvx3sOB6dAjaawWCoTNMaGvpI9URFIobTzuM7
	wcqXd50dsY9lmmTs9P3FPK70aP7Mo8wKs2UqliKAuEBVgmoGTfnVf7TfX+xezEsmJzAqKcJE4TB
	MA7hTFkat/6MrD4O1rNF9g/6VrLD+Bg7a21ewxjwAShrusuYXeLlbVjRLs8RS5P6A45TMts=
X-Received: by 2002:a5d:64c3:0:b0:48d:faa4:af9a with SMTP id ffacd0b85a97d-48e385937f2mr4148523f8f.9.1792768178061;
        Fri, 23 Oct 2026 08:09:38 -0700 (PDT)
X-Received: by 2002:a5d:64c3:0:b0:48d:faa4:af9a with SMTP id ffacd0b85a97d-48e385937f2mr4148486f8f.9.1792768177564;
        Fri, 23 Oct 2026 08:09:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d408f15sm343026f8f.33.2026.10.23.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:36 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:34 -0400
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
Subject: [PATCH net v6 3/5] virtio_net: parse tunnel csum_start little-endian
Message-ID: <ac2b7e8b635da611f7f2bb0b42436a8155edc7ed.1792768096.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -aCsQNyPdNyar-jERvBeAhYHF-xGO33g8-3vk1IixBg_1792768178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

All tunnel related virtio features are > 32, so none of this
functionality can be enabled on legacy mixed-endian device.

Accordingly, all tunnel header fields, csum_start included, are
little-endian.

The nested virtio net header import parses csum_start that way, but the
inner transport offset is parsed with the endianness specified by the
interface.

If tun is misconfigured to legacy big-endian mode while the tunnel
features are enabled, the two parses of this field disagree, and the
value stored in skb->inner_transport_header - which is only
bounds-checked from below - can point past the end of the packet, where
GSO segmentation later dereferences it.

To fix, parse the field little-endian in both places.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..013c6c7e2dea 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	inner_l3min = virtio_l3min(inner_isv6);
 	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
 
-	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
+	inner_th = __virtio16_to_cpu(true, hdr->csum_start);
 	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
 	outer_th = le16_to_cpu(vhdr->outer_th_offset);
 	if (outer_th < outer_l3min ||
-- 
MST

