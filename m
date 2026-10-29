Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300019;
	b=hWrt0Bw7/PqXzFTSn88HIQZc5vijWHd0Dh8ZG4IVovT6JuqANLDUIdSmg1xBxtHfDUrm
	 nW2vqjsbNR8EchM/0YwSUlp83ch4qCdOj0zwa2I766Bqf18nnPiF8zWKnACWQDemf9VD8
	 +14YRm7Lb7+GGnowDzFLY1E+XjCDYXVZ3szZgmyKc+ilm7P2lmM9Bc9RNh/jZJP4yvoZw
	 dGzkpdWWiWCmL9F4JcN9ak2vX9PteBWeuiitZCdmDW0Jo/NUWUqykTqb+sMB99fGrWWU/
	 sK4bQoyyHjzf8o2C9ndcYl6MohEjLTqBBjzMMXePBg0sF1vhAgmzH5hxB4LvBJU/FuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300019;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=AEPdHdbeaOMBl97/VXK3TJ1jviZ2/6bvtxW61HoXcenwON34V6vXTYpBCLilHnLedgsf
	 WPQFMXQ/OOZROr+kjkdwRprtDS/iQIXp0gTyPRWtBQVsAVd+rxCoyQxCEw2bAY1ZIPGFj
	 tYEl+SEYtEsbsw/cufqXzWAWrQntIqixu19b7BGWFWgQnL85brIJdLdQ9cC7DyshMP4wF
	 XlTbjANp30qLKBIUn06ud0WMXZFyQTQK7JCUVQ5iuGCvc76Gb7JrAESqtvBvN8tREM3EF
	 ezQ3D2NZgn3tqr79HMYV1F7m7ICDC7vFD/D1u5UXfUp+VCWNrhIz4K1IphsZLDBLWRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxszXTfi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09431606A321
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 18:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09431606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxszXTfi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793300018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=QxszXTfiWr9P7yrb8U0nDlP14hCRZ5uIBtwxA5qRbqWA/rHj+d0mmmVh6rFBNqBG1AWEAk
	P2GseU0x6VEGC3FqDDSeRGIlATTVIyNBGwiiZMctqkEiQWePzlJ/uB+PuuQJu2gbF7t8T6
	qmyH1DCjs6ZUvoJjwGMAQ5DUYtrhvqM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-ialgvlDAPEGzBZgsEtCafQ-1; Thu, 29 Oct 2026 14:53:36 -0400
X-MC-Unique: ialgvlDAPEGzBZgsEtCafQ-1
X-Mimecast-MFC-AGG-ID: ialgvlDAPEGzBZgsEtCafQ_1793300015
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a318cd95e8so9616225e9.0
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 11:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300015; x=1793904815;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=IWnP/BlO1NuAacFZR1rPmfP2yNsk4wekiES92K214o3JgB4TD3irlTlEbPD2F4133i
         4RLj/dYyBY1wmW2qJibY8YUDu/EOGF50Cef4/yKLDysadeg89g0DC0s3pUeXlmfDPDUR
         0O0PnB/GLBFD3fdjKVbzBTZUeug0tGFHMVpuFfBvYm9ikq3BWAXGWiFBevmgykz4O7x1
         aDW5Rma0w/yNUeshFo/++v51dWcDpHybktt7tfNgk4mzqqHh+SgcKC9pNk73foLnT8+J
         Za4U0mZWDQaJOISrpBHeA1hgKLsBAo7CveVaSseg2I4PTtGsKcydnul72ffF9Bhj7ur6
         J/1A==
X-Forwarded-Encrypted: i=1; AKwUvBypx04eybKxsDxy8xDeFFWkniJmaSSfnD7Y4/OppZhfhacvCA4OTX59y5Njv5dPNnmOoFZF23/3CYZvh8Hj4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLeFEJv9fHXTOZGzvUsUW1lZVFcFnR7uw38C6YXsBxv3GFQu2gh
	okVkxpbYbmray20FDkZVu4OTGVASV5vOThcdu2ALf/Y004pyp8bMC7ItY09oMgWXC60Um2Bqa+g
	i1dzdVj8Cqpup8uaQIPfCO65ZZYmifxzC9P9qWy71DB6LSXgdg3oZH1gQyjNiDaVWGKIo
X-Gm-Gg: AYBFou1A+gV9hlHeFpkwmiKfsHOcdkUyCwHVWm09ic6sox2F4OUSPUulQYch+V+TRpX
	pGxCQU4Mkkcraw+w2/WT6mxQHHoEnrhVadI/KFF1f4EpWBQ+19yO6w5M20DYLjbx3GKmMJxbB9S
	WYRAyjxAer3Rgo70LJL2ETSKl+WPjziW9bgsSm8yTMmQZLNzoS4uW/S85C+MxsceKGwQ6LPSDBt
	GgOMWaKYbXIhndg6sVH26Em34EnmtGx+QPDMcHCV4Fwaxp8SpsSgo6FTOC0mQSWPKcXLehw5mwj
	i6CDSlPTblTFtGDI9tMMOcCIO1ofUcm+kAjJfB65w8LYEwwcZY3hVK4dLTrFgh/lPlqN+aJl5+A
	8rqkmoYI/7kgZzus9AM0YZk39eyj/NT+fgYsIzMeoIVp1
X-Received: by 2002:a05:600c:a301:b0:4a3:5d64:e063 with SMTP id 5b1f17b1804b1-4aa8a7ac897mr77300025e9.9.1793300014613;
        Thu, 29 Oct 2026 11:53:34 -0700 (PDT)
X-Received: by 2002:a05:600c:a301:b0:4a3:5d64:e063 with SMTP id 5b1f17b1804b1-4aa8a7ac897mr77299645e9.9.1793300014037;
        Thu, 29 Oct 2026 11:53:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb75bd4sm222321f8f.10.2026.10.29.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:53:33 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:53:31 -0400
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
Subject: [PATCH RFC v7 3/5] virtio_net: parse tunnel csum_start little-endian
Message-ID: <0817358e459a9056af2055a8e2f466c4807ac83b.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1793276116.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z3hjMmvMtjSx5R9sOMYSJOuvadUaDOFiUQW6I_Mwkio_1793300015
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

