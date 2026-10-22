Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673928;
	b=Ai5p0D7Tu21VQ7k2XBJpaiNlE01yhssFWkyKkMdE+ZoXW4BteJ+maIrVQOqoWeVKuLP3
	 LsrfTAtA14zpuc9SM3niE7C09CiccK84Cu/Z50jgoIPv5K5vYAct2UuZ2HK3/7e9ZeSOo
	 V/tHYtCqyqoGLeriPtq4l3TEqkEl4knOKn+KWJqfvGt05/xyENsNYz9w7e37B3SelxuC7
	 FajaFGcrbK9Jz2zjVPP+XZFl8gUlVmLt/NM3tDoYRolxWwTKfRicnw7LRLd1nuPI9C2jP
	 zh145lz0m+ORk47PP/SefiNVHIYr8rPJcf4UFr+Rfkv0oq3/cJc2kfKQm/Jues28Bvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673928;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=Wm2lsA+w7xm6rhMTdU3cXhV3KJ+IpR+CE+ng3KKGWSc=;
	b=XydGqIIpustJh8/1dHCynQSeNnuB1D/VA+BJ3b/CRhIlYqForb/APSaPwV6tem9jjO+8
	 CwtEuvXdpIenYRTOhLks00a9uk8UPZPaUx6CqgbkJdMtVWnyOeoUTagy9pvMGD9qcLZIj
	 mRfyTmp38m8VEJ1RWA/lN69dLbxW6TVTKwRjXeTZJ8e4MFzGx26En8pWpmmNYz3QlJQqi
	 AHpZVqCQuH3lzv3t4Fmss8QssVf+T1TAzFTwqKzSW6jvtd2leuNNpiHHo6Svdf0rmH96R
	 LbL65e7A3XpjXGLVR16EoFZxAtyd0Qm50XsHeh7s6jRy63bnzOkaqo30Rc/ljo9il+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gzhv5qCV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99604606A33D
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99604606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gzhv5qCV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm2lsA+w7xm6rhMTdU3cXhV3KJ+IpR+CE+ng3KKGWSc=;
	b=Gzhv5qCVHqQkKUuIjmhNIU1MsWsdI5rN4tfJGf9xoddiKevPgTq6iVD0s13JWaOqTVU0lb
	aY+5qrtdwZpMo6Q7eUFXygVc/oqv4MdTX/vXoOkXL01BNgGGTXiURFCtnfKFlkjS6yoHpv
	cr1aOI7UUEDzqS1tu6A9FdCdGTYmrZg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-VnfL9NdVPNStTovnawHswQ-1; Thu, 22 Oct 2026 08:58:43 -0400
X-MC-Unique: VnfL9NdVPNStTovnawHswQ-1
X-Mimecast-MFC-AGG-ID: VnfL9NdVPNStTovnawHswQ_1792673922
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a2063be141so6527125e9.1
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 05:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673922; x=1793278722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wm2lsA+w7xm6rhMTdU3cXhV3KJ+IpR+CE+ng3KKGWSc=;
        b=ZQDKPF9Wnm95m5xoUrDLUQqijHtjiot8Z5NQ76lbPLEJy0Ff/N2zLZ/3rTbgbWzbjR
         UaFUgH7YsID8npeEw4Eigjs+Ue6/QgdxwdqCjje7U923wevsn5w+LmsYLMqrP00Dh1oJ
         luxjEIdcJjaXB6DF5rIi6kWMG1WAbXLpg+VRr8AOerSANO6NwWzEnvG7317AyOoA2eXo
         MSzcXnrI4DFf7O4uLd6y3I7JjNyi1P1ewDIEgSsh2NRPNeHlx277MkdqxSCoNCNwndPP
         IEAOWet49bv9snIzJk9FW4Q9Wxa9k5j1H78lsp0L++svqwyxFY8eyvH8vMLCm6fhrpSZ
         bBwg==
X-Forwarded-Encrypted: i=1; AKwUvBxvyxe6ta5VkyytTdnXCtjAdgJbjT9A4sCMsHbXVhbLeIOC0f0u3otBayglligSO35fTKJaY6JF6KcPo1T4/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJQXfRqIFWai4bOloDAB2/CzE4hX1SDzA4KUHRWy4BPG3DtOn8X
	TBT821WbF2R73WmAGaIKuC1pXe7wDhwMwoVJzjv41UGCC9lmfnGQAl09mKuTSrpzx+FnWvJfMCd
	S/kG04rBzmAkJy3CuYyHktBIdjt6dwydX6myEilQC4JJy5a6gx7WVOKgUYhwX7P7uGfDw
X-Gm-Gg: AYBFou3CgK7rtv780Xyb3qoBzB7pVq9GUjqX+hbLQKSllX6zvLI4rJS18BR0dZs2vJv
	qYZWKf/6OfIHjCKTt8nIokC5DAboj5AzMtJd4KeHF83fWNBOmJeWBwLjozOS/Dfy35huipytUwF
	dzq8Qnpy02y3jUTQmaP7z23NDqfZMvrS/GHMxzBklBSMSZ4iCWenHDZQkJ6BHp0O6fkqWNT0T+w
	gBJbsXsTxibY3VBu0ocNJTy++pvXpbMAKvvUf4tbo28KXgrv7oudiMqlkpI+V9LfaGL1j4/fguD
	vcZkJfVc2ZYNLuja5SEpT9aV17qCWLoAIqONjEpW1AWlzkuVS2rlB4qW8zXt+1r+wH8=
X-Received: by 2002:a7b:cbd0:0:b0:4a1:f9e6:f418 with SMTP id 5b1f17b1804b1-4a1fdd22fb0mr76175245e9.34.1792673921685;
        Thu, 22 Oct 2026 05:58:41 -0700 (PDT)
X-Received: by 2002:a7b:cbd0:0:b0:4a1:f9e6:f418 with SMTP id 5b1f17b1804b1-4a1fdd22fb0mr76174745e9.34.1792673921125;
        Thu, 22 Oct 2026 05:58:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a62aaasm69570865e9.15.2026.10.22.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:38 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:58:36 -0400
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
Subject: [PATCH net v5 7/7] virtio_net: cleanup protocol calculation
Message-ID: <f8621d16cf0c67335641d07c1555ec1e43f17628.1792668082.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 92qfGZAOkz8dYsSHbcCQr2j491rwJTz3W3OGAmTlSq0_1792673922
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
index 063cc116e51a..e984e446ba44 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -613,8 +613,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-			    htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -638,7 +638,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
 	 * set CHECKSUM_PARTIAL.
 	 */
-	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
 						 inner_proto))
 		return 0;
-- 
MST

