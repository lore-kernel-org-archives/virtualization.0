Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF29291C10
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411408; cv=none; b=P0qdv8b+0WdSTOuRh6sI/BwB9RneNQQoMDzQ2dHxMZuo7DVYMZPzfHb8yKUyzKbbNOkQimGclwn2vgybXT1tUW6nikW+hdd6iKq+wrYWQZV8YxFX26ALwy1/Ra2STqqby9Hh0EoAcIcPdRItP2awN4sERKJenmyhtcLKr1kjTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411408; c=relaxed/simple;
	bh=eqoVPoCIcKD9k93jD8GU7ZX3x1Cv6cnc9YQOa29tXGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NY72CaqAOs46Le2NHcLSCExD+v4Mx2r2OnKIVuAYxN88jJxn3/UkBlZLo2MRPSUCPthL9qacYXBiZHF7oIKsT2Ht+BRMzf5ZiO33rfra2KpKZWpa5hsA2FXVDCwyJ/vpaABAsCV1Z7nqCb/MDonld2OAMUlCa1FNlPB1bpruYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WeIRE8i/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeIRE8i/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0652/Ynsgn6p09c6VX24pbfJywD9ROD3CSNdUJjWbo=;
	b=WeIRE8i/d3c2LPptXEQ/FJqy+YepfGG+dBO9ZtL3DYq+cXK5uY297iVyoV3dInPSRNtuLK
	l7QNJrRrAQ4YUZ53WFFt3A1/qOE7/D4SlHtapugl/qosO8tzSjlZEbr8neP3D+2VGPDWZZ
	0WODNN6wXRqi8HWmEKtGwjBwmyEOcyc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-fpOJcv5XO7mTW4dS0zuADQ-1; Mon, 19 Oct 2026 12:03:19 +0000
X-MC-Unique: fpOJcv5XO7mTW4dS0zuADQ-1
X-Mimecast-MFC-AGG-ID: fpOJcv5XO7mTW4dS0zuADQ_1792411398
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1db220b42so17622905e9.0
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 05:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411398; x=1793016198;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0652/Ynsgn6p09c6VX24pbfJywD9ROD3CSNdUJjWbo=;
        b=s83R/zZ/II4ZYONBcg0ryQFNwvdaW6t7xxOYcDU66EFOPHBSJOf16Tmbj0O6Uoptc9
         J+mr2ZldftkNjp7StyuOh8B9gyY+SSlCpDKwoyB82FX37GifQdalpl/o2qB+cvRZazEa
         AdbIalm5ZHv/cLI9zIiPDZ6nkmkQRaMvmc7dAto+ArlIUBM6tttiXgRG8rYCi6wGEUrl
         qgwxrxhJacdpsKJ+BCiDnYkaCU7t6ybkvqPTWdb0KgX3rBNxIpm8RcjtRUshfDH6V3Dm
         4XIznmL3zdBD51H7C2XGHljK+10bXpZ0cuiY4T2uIIPptcnX7Y0v7n2YiU7gtuypQGFO
         oUyQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4pHpFNMxaZx9K1tMU0MkSnR69EXJoc2JTJPPgGE8UcXgp+Oe1B6dfszqFlu7ZlT97P/YNTr6UfmI+yqq2TQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJzhBh76GvLZ0TgSWpfPFdKZMx8no3hJJIQTslcfrRwj/dmDxxi
	gRgj6czh48CI/Iom7echEee+Wi3k2LXfovkdFNxWz2XdwquZtUukojiHKqLZAZqCCBVpjwFy8cq
	BaDMMsRi5LKTVnlMJdXOSJq5gSgQiKQ4ipxBPUWj8X6WmXt2KNeXY+tU2GpN0Zf7P/9h+
X-Gm-Gg: AYBFou2J1uZ5UAeS5YEhIcTtbPimCDWY5MHoLngriI7skXz/uBgeCu87OXAAqyJSp+v
	OMHU2jKdZHrWvTKCgSe743cLQV9gRF/VepvomgmHp6IRqJ6K7ij8g6uZsTo/Wqj7GskAF+in/sl
	U0UXXcenYz5EaADbsh/iGNnibrbv/D8FxucEd3PVXltKL+DH4xYg5nZaEcSZlI4/AFuaUusm3CD
	kB54BBlJlVeQHOnb4+jVQkcP29+VmQVxjKXA9KB+oXALNxrf1LAQx3+0MQQAdA13hQ/wOwGDOM9
	M2DDrx0A2PoJqAP/G8K4S7r4WKCD5J8TEAp9a05Xl6krllTYpXhBKsEY6/GlChRC729JjA==
X-Received: by 2002:a05:600c:8b43:b0:4a1:83f0:7c8a with SMTP id 5b1f17b1804b1-4a1d75ad072mr151102505e9.1.1792411397902;
        Mon, 19 Oct 2026 05:03:17 -0700 (PDT)
X-Received: by 2002:a05:600c:8b43:b0:4a1:83f0:7c8a with SMTP id 5b1f17b1804b1-4a1d75ad072mr151101675e9.1.1792411397200;
        Mon, 19 Oct 2026 05:03:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm187486045e9.4.2026.10.19.05.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:16 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:14 -0400
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
Subject: [PATCH net v3 4/8] virtio_net: parse tunnel csum_start little-endian
Message-ID: <fa2c17b9871d1d858cc9e109e1bfc61b3ffdbd69.1792411304.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: M0DQKFCDE3Sz3I-oNS9ynA106k18tI5W0Nhh3wHIBpI_1792411398
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

<glm>
The tunnel header format is only produced by standard-compliant
devices, so all of its fields, csum_start included, are
little-endian.  The nested virtio net header import already
parsed csum_start that way, but the inner transport offset was
parsed with the endianness specified by the interface.

On an interface in legacy big-endian mode the two parses of the
same field disagreed, and the value stored in
skb->inner_transport_header - which is only bounds-checked from
below - could point past the end of the packet, where GSO
segmentation later dereferences it.
</glm>

Parse the field little-endian in both places.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Cc: Paolo Abeni <pabeni@redhat.com>
Assisted-by: LLM
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

