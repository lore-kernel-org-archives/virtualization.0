Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E03B6341
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584127; cv=none; b=cJxscxTGX/VO3L+9OhemKo3U2SflwfY982Ko5rpc5XTTdi5vDsbipKSb1CpFLsB+FPPzQrkP0CboAHlp4hHifeF1ZQDKIxY0Ehc7asy5rOowtP5uRf2OD5kE4lzT9u27p6SBrd9f3nGnZyJhj6oYAnQqGbjqNpQMwvVwy+3qpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584127; c=relaxed/simple;
	bh=iSnCoy0wOHnjTetJKmG/nh8R5MUt1SEexf5yDRqPPro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORMF2O8FykH3lwPJuJIYi3qQ4IANFKBQPPzn4d3AyNiET7M9u8R57cuLvTq6agF5AMy145xwvl22ekhaW4h6z4CGJ5s3qyD9SsIJTflnN9UU+EoNm+JiYdUkg0/MNwzhNb9NlXvmYmAn7md4IntHSPnyqFPVP/Ktnoef4jQAjS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=K4Ok0KM2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="K4Ok0KM2"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so2352051a91.1
        for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 21:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781584126; x=1782188926; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+s4R842SAMDVeGmCPYwOESmnuBNOdgsUtTVh5NI/emg=;
        b=K4Ok0KM2F7yWZo0R+Dw5A185PUhaoVDL4XaloqhBxR04yJ1WlAppLTdZJcRplwGBGc
         z2IzDoazBcGsBNr+dhU6mweN0lYKxjc3O6F8QXC0iGBXO8RGdQ//DwVCgidug4/GUbBE
         hsMOUA4D/KwpQsfWfCxUj+7dG/riUrM5mxIz9euOm1dkgmBIdmwY7o3fBbkUCzWiQI23
         Nj4/JiupgvQ7QK7wvekax8x6iccWHJp+cOS06TAOoX9jwPihJwRMHTj6/TNrjiDji5Xz
         HJERSoaFayJsUvdLqzpL0PmZkvQSwML9zsHcbTZ7JZHKWlPM7KxRJHryey6YUAybIStb
         IIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781584126; x=1782188926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s4R842SAMDVeGmCPYwOESmnuBNOdgsUtTVh5NI/emg=;
        b=rs87TsEtuEPtJCbVXk4rPDD4fAmnO/ZVCPyWRuaL729DVfy70pShsCOB9TypoKC5LY
         EBemzuY6Vi2HYvFk5ruD1AXGEoxJBoeRu4C/5bDfO+xPNZDUMfOpGXY1TjpLGvnfjfAh
         VpQhUxWksA//2VOERQauVaUsYTt7jzdApfvpJ/1y/vuAQ8hjySDMDhHTyBMmK6q4lHns
         p9eAsZUSBkBOp0Qaf3NkR9uMO/acufoKaAmdlsPi04peYB+V1jZZPl+AeFMtUUEYYK0Q
         7TZA3X47Zuu3Xx/anEKXX4qzGyInPmnN69Y4hgygnNwK6iX9gS/yahm90isQKMrpnH6A
         IMTw==
X-Forwarded-Encrypted: i=1; AFNElJ+7TwaZo5jC3nCLIq6UnEt8RwX0/CrMEOjm9D19A8+w9ETrFskiMLL6B2QtTCClTvrbwcHTUAMNhR8XVDwFDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKJmxKFTKWWrX9L+oYSYojZpfxH9ZVvjyJK95gmp6dm8iIBx6W
	ENsakdqyaP3tslXT34tA/rk4fQr7M35/AEKDpTGJ+vDoc7rldsuO95OSiiXBjuRz8A==
X-Gm-Gg: Acq92OFmiaOmcx9U5rFxUZ81dpZ3bSMKGuWvoor4OVvySumcDcj6mtSSXeK/ieuvi+5
	TMDjLVPi2G7JWcgstMKLcXx4567A8d/9e3IXvvvEVYllMdeowX+wgvpL0RgVOr0vLluyZ1wYxTl
	iIfU/tUIszceG+ySPOBkxfsQfyB2YobBYbxEQbQmx7Hmzjt5fqOx+HcRN1P5OKYDG4wYEbzl8I+
	oLpnn3PWCDVBo6XBwpz20mp8j75b6nek2hP1rxVyAjsGfNHsxyhn7k52tN3DmLzbdy7rnOVKa0D
	Mr6FShzFWEUz2aCdtFOgataLbZGWD1Te2ndObY+41tzMqfaJtAakYWMWtht5y8Ugm7QkbKSQ4PS
	OIyqVtfLHQwBo0xoTTLhDwNoUISJvIVt8uZZhHzhNGe3JIRW57ydzk3fBXvHxt/3LxH+n7Cd533
	ujmh0r
X-Received: by 2002:a17:90b:58c4:b0:35b:9894:f6f9 with SMTP id 98e67ed59e1d1-37a040adfbbmr17185832a91.18.1781584125653;
        Mon, 15 Jun 2026 21:28:45 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5208fd0fsm1244221a91.0.2026.06.15.21.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:28:45 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v4] virtio-net: fix len check in receive_big()
Date: Mon, 15 Jun 2026 21:28:37 -0700
Message-ID: <20260616042837.2249468-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

receive_big() bounds the device-announced length by
(big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
add_recvbuf_big() sets sg[1] to start at offset
sizeof(struct padded_vnet_hdr) into the first page, so the chain
actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
check allows for the common hdr_len == 12 case.

A malicious virtio backend can announce a len in that gap.  page_to_skb()
then walks one frag past the page chain, storing a NULL page->private
into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
write past the static frag array and a NULL frag handed up the rx path.

Bound len by the size add_recvbuf_big() actually advertised.

Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: use easy to understand math to compute the max_len
v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
v2: add additiona check as 2/2

 drivers/net/virtio_net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..8f4562316aaa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1999,15 +1999,16 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
+	unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
+				sizeof(struct padded_vnet_hdr) + vi->hdr_len;
 	struct sk_buff *skb;
 
 	/* Make sure that len does not exceed the size allocated in
 	 * add_recvbuf_big.
 	 */
-	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+	if (unlikely(len > max_len)) {
 		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
-			 dev->name, len,
-			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+			 dev->name, len, max_len);
 		goto err;
 	}
 
-- 
2.43.0

