Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673903;
	b=j/M+QKC+a/MV8S9AjGuGKKQTP98RcwUDgZLKaFQyIVXTMN8Mp+xGgrfC0zED4OmnMJaI
	 Gr9cWWvtm2iZzaDdCDUAEAFc1kmxcfElms2s0Po4AIo5cNKc4hMFHnw8LkNH6+pec1nbc
	 kKauQ3kPYQs83COuCx6c5VlzisAF4GJIkFjltfHcdALkYzWVIrdQwA+83cZXxQZQzuEEE
	 Ok1XPPBDVvuyQqij/wdqE3DIzbR2mGpd+2eeGbsaMf6aQOwS77aco7wy1NR/W0IOEMpq8
	 YsRTJT6f7b6nlg5wL+U5IMQ53bA5PxtahEsRyQJMoJaFR1f2mQDuxtq015f4ml6mdFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673903;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=ZbrrhavKaR6MhM7ivysDenpV+BKxUP+S4sR8+B38RQrW7ghtOR+Bc9q9Mp8dIgCQljGw
	 414kjrBRUDG01280ZAJp+GbMFGwiCL4nYfParW95DUfTsiibVeBHhxDec9LFUlo+sSFjM
	 WupLLXRb28C+ihSMqhSsIwjxdEi6p/TqyiUJW62LKbr9lchFel4xgyTMWocO8kXK5JtXh
	 ciMpzC65CwoMjufyJ9rw9fKJJ8XpcXhFPC6cLHJFjA0UxXjRaKrALEcqm0sHFkR43BnIF
	 xZWtj/bEu9xj1FR8hMIvcaTSowt8ogMU1zYd7guvtjYG8Z0hif+2FOOBQtrBvaNKSFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KRzOSqpJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897960A261B
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C897960A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KRzOSqpJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=KRzOSqpJzlgjxddSh9ztKfePznefMsnoP71XoVPwW/ijw0Fow2Y/kmPtp2yBP6DX9j9Cez
	bi4uVljJvTeM9SFiVqMNRYnj3qjAqUg4fRk6QglB5Uc2RL/voF6GBR9xsvifiRjZxN2z1e
	G94PmmaJjE+3l/+Q7v5hMBwpAQbycao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-3krF5dvxOgC0_4NQfFJpQw-1; Thu, 22 Oct 2026 12:58:20 +0000
X-MC-Unique: 3krF5dvxOgC0_4NQfFJpQw-1
X-Mimecast-MFC-AGG-ID: 3krF5dvxOgC0_4NQfFJpQw_1792673899
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2063be13dso6354665e9.3
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 05:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673899; x=1793278699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=J1QpPJ55hDFo7TfVeovStwHp3fmOOTyXcx5/FsRQI8K4GqF6csdqdh08Oki+3/A6lB
         QYNvySjHi8aVN5tFSRmuNG1WWAh9KByUhQOVUVkOFapl4+HrND5Tcg5Gu321r7JmO6f/
         lOkJCF0hcNw4w/KLBA62e+wJzwRlOQB+CgRo4sIGQWzWnajQOMf+Q/ThYU48qm0GwZDP
         ga1gnDGsNjo43+K0LhwR+YUuhirMGwMCcWE1S9LVQeWosJjvScs15HwOGdZyefGSPzmD
         Qp9ahrciB2Xzv+dnFuFDhCEduSCvnmN4Lc/yrZ7bVuAfG3ytEQ/vWFya6U7zbpdsgRXB
         FzgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfBrEcMTf+DFj8xfY85IhfNF6ev/e7/71+H6YjWj2F6PkkJNhUcYdWL/0gsDWs04JWco2KgxPtMP5NeynYXg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJUT82sjWP6xxtXtwFOCXGJ5+qfQmfTwQax5EXHItKvRBCPNSTG
	U1IHvcp8F5N3FwmDfeNCa/vSYbDgEZDgvgBw/fmeK1c9NwXwJijhsuWW57OCDMTiJdrTLbhlRrA
	XFPKFatSNZG/Y44gmABMMV30m09S484LcW+JLs4/1k7Xd9QjnYYj5RD9SzTHDJ87OnC1h
X-Gm-Gg: AYBFou14+6Vj9xmtCXcidY5GBfB/iV7v8g5kmqR+rI8eykpH66AvRu1i3Fhnm8TjS5F
	kSDpzK7mwbTVynL12dDGoJFARvxovyH4J9ART8P/mFXZ42csU2xJ638/Vu8Volt9CKy5TMQVnr4
	TOUglwisWWhP0nNCF38OwAVzpYMueG7wKq+7xo6zle/fNC2eMg2o0c2LjCvFP1uT0r/UuzZ4whh
	lcqg/WA6kRfK1OstOSi+dgeQbhT6Yv3MF2aysZQabRGVpz88vWwErrrd3ABU3LtlKSiJc3apNes
	j86kI3dYb8JRtSY902S0r0dgU18yWbvy1JkcO3sr8aQPkwI8npXW8f14q1LTpyjtUkM=
X-Received: by 2002:a05:600c:3513:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1fdd1e97emr110652255e9.31.1792673899231;
        Thu, 22 Oct 2026 05:58:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1fdd1e97emr110651585e9.31.1792673898550;
        Thu, 22 Oct 2026 05:58:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583522esm12561180f8f.35.2026.10.22.05.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:16 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:58:14 -0400
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
Subject: [PATCH net v5 3/7] virtio_net: parse tunnel csum_start little-endian
Message-ID: <dfcede18b8d54519bf586b8e5099e89ec63bf014.1792668082.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -zinDGU1XSMP38Ke0Q-GlMa3WnLg3TuYpojUgv7FWtg_1792673899
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

