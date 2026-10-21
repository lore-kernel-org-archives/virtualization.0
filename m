Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569006;
	b=PNV2XcSTCcFNMt2o4KDTJcYTDy+JbWq4ko60cDWxLAxLPEzsO3E2s4z7IqCw1FlKX+dT
	 5VdPFzVOSBnoehk+rpC73nzEw1o7Wpna8LuNY2Mge07jj0AGplmSCfGHqsKqkrXyLVywI
	 xwOvkMAjPeKE6j7KT3/wbNNG+iOTnO1LJDdLcghF0vd2AN8IItOCzplyPaAynQf8rBekL
	 tCGhxLSjkJu/OprqRIAzavcfC4Qk/SOUY2ldZGus0HQrA7Q8/pni39CkE6CdAL2qVwm9Z
	 fcxe9YNf2AJtqKTmY0dVoMMS/YOD9kWXWSWhN2bKETWT6D5LvfS1LjcJ7fyubfS0LdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569006;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=ov1tMCra9L57zKXbtpXOjNOzQI6TRaheTy38C346+ZWyugAHUB8i0qb9lyXWfqTP9Bge
	 HOSYF5HQUJ+7DSbmm1wzMGhuoLw6yszRPsuJlVpBqAkcQm12p02eLvsghOR9uGfKOyDRz
	 yto9NUOae0mLuexrepC02RRRxnbO6cc0k7qkx7fRTTEfJHKnjzdgwDTnhUTFw+BcEaP2O
	 SpjWr0bAGRhuk4jppqYqpkXg7lmy8o+9BYGcCZVlUHQHbGJPgAwyoHOsTbUvw8kRYuDKw
	 OetldM68hrpGW2C6SGzIc9ZdQybCRwuTYb2ppcWcbgGxzaNlden/oGwHmAHSrBdYO+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BeNOOFX7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2523606A31D
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2523606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BeNOOFX7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=BeNOOFX7zY0CcblKh6fdU18JKp+yzx5ECQRwEKnV4FzUWRVwwh5etOFjJgLVg2wu1BrgBp
	2ssZEBQyacWBusYTZczQhwX04Zm1Dc475RC1mSYYUYL3CIxw41oKoN5JlTfm7Sl6+l3ctm
	yQXOiBsB9cBXAc0TQ0jSPZkOAZRqB4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-w8Fq2gIsM62E6AyDt762zw-1; Wed, 21 Oct 2026 07:50:03 +0000
X-MC-Unique: w8Fq2gIsM62E6AyDt762zw-1
X-Mimecast-MFC-AGG-ID: w8Fq2gIsM62E6AyDt762zw_1792569002
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dff112181so388423f8f.3
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569002; x=1793173802;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=COHOuKBtBupaz+MREi8n6pcsNUHymQ/Rderc+waBDQgn944uJc3aq2Jqv42TsWwD6j
         ebE3plbMiWgtKzJDGgYXODiQNqmi2B/cNracCv3YnLKqyd5VnDX3PXtfjeI2CEDAxGBu
         pph2XZyhHawkCP2uekzjBVe5lD4ia77cFuB2crJV2F+Up7Qh64sWq7buDVQnJpKGXzAq
         dcmaGONgNAUhEqqGwg0F/Gnx40cJXS8JpuMVF07oxEY/tRLeV3pEFv9iy3cC/jCD3lPG
         WqhSvb2DfAD4Dft9HogE+NrgOxEbMW8QZY87OI2F1dhtVfoH/HQCfpq++utesvl2lz2K
         t9Fg==
X-Forwarded-Encrypted: i=1; AKwUvBztO9P/nT5ljw6hmTRLci2qvsO4oDdwzzWhvucjkw3tDTdlV236mhJKrZ7PY90vRjtFSZnfFMnMI2wNRy2aog==@lists.linux.dev
X-Gm-Message-State: AFq9FYLHRtI2g5jJO8gUCUWX2EHuuG4BpjeTTRYb38TWPmU5PpXrOfTu
	XPlXbboK8LS89y1w4YkJbVI/kuLHOegqixLglPrjHi1goHs+NlCDw5RXlo2GUYqBk6/ExFg/Bj0
	XF/4IXmXRUrhE0vH9hVhEx9K7K5GPNRQ5fSr1Q1zlSlmA6sZmPH0yRA7Rj8CgOMrhWsJw
X-Gm-Gg: AYBFou1lle7fo7lO4e13R874UNShy7cSKyep/mBOecL7f4bANPM5xJDiCmuHBqLESs8
	tNZqgTpxantf1isAmEzEombbcbgoAzZyUIZ4/rbZItJsfJWR5qTwaMJGCL33/wg0J7RGX5oIkwx
	0cZf0B53hC+zgk2AHak15n4qX+NDoUG2UdBrbGrIkIihNVbjry6yFJ755SqVRf9uT6XoIhFmi/y
	tCcvZua8w+jBJw62QXusaDUYMExzApbxj2KT0zdXLBtRuPsaR8RAq5hnluP2zTCrBiBpJ7hgyDc
	g0Pt+SXe2TBmQpBh1y79VA1HlLsrWeMwUCG8mBY7GwO9OAB+T4YHs32aud8+M+wMEJ4nYg==
X-Received: by 2002:a05:6000:400e:b0:48e:b62:d134 with SMTP id ffacd0b85a97d-48e2642cde6mr2376547f8f.6.1792569001841;
        Wed, 21 Oct 2026 00:50:01 -0700 (PDT)
X-Received: by 2002:a05:6000:400e:b0:48e:b62:d134 with SMTP id ffacd0b85a97d-48e2642cde6mr2376500f8f.6.1792569001336;
        Wed, 21 Oct 2026 00:50:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e54sm3949620f8f.27.2026.10.21.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:50:00 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:49:57 -0400
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
Subject: [PATCH net v4 3/7] virtio_net: parse tunnel csum_start little-endian
Message-ID: <421e7ebb8173ab919c2b90b945aaed462145583d.1792565282.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: IG_uecJHZcyzjd0QaTb8ZMHrJLHSl1rtZdsiDRN6gAU_1792569002
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

