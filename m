Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731168632B
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145983; cv=none; b=Vi2scDGyMWqmhVAT9+GTWIZoOIeiMNA2t/5GfLonPgY51KrryZE8ItSyyTJ/Yw4TIYezlTAemwolQqKBKyPYm13hG5WaM+S+wChy30i+RfE1/zPL/I3gB60FIJOccKQtwoJZ2M8epX1QdXZ0bYf50A1IKB7ZDiXKGOOOdBDeBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145983; c=relaxed/simple;
	bh=28gwmmJZbHwifeKhKcKs3jlabK9yxZRYJLy/CpxcWhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhW3c2yrf03ZBXltz7lTA5lSwGXDB/vnrnQWThTs3HDs84IvUCdxMsm8B9NjvMaNWSn9z79RGFLLhr1zlQ59XYy5i5Fwd68FFFklXVrFcI9gmMB4n6gvc3dmfzsIXneRGmW0fZ6f6f7n+m2mXF8DdUpdtzSnJysDR93eS5YBTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=UzxmC+G9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="UzxmC+G9"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c857fba35cfso3691270a12.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781145981; x=1781750781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcjpE1eP9eIVKtszIoqhDW3RTPv4xN3zwDCvIagcOCY=;
        b=UzxmC+G9NdgZyQDbR8Y3TFCf2g9SotW9247oFNxSGNStTFFdIJ9xO7j3MrGOyLETmB
         LX5Lain0UDT7DMSqb3F2LGCuGR1E/LIptnEmK6I9XNbQJE6H37vZahOquZKuZi/WOa57
         DYaoML11pfKwXs5Fzu48Srxx3duIbwUlky++EgtWdRLz3TBvo2GdDzu5D95K0q4U/uwC
         uAiJdggrJGfQKCi0pMhX3BwYPDehRb1+KwWRLBxLUvr/jf2OhQ6vUzyT+aWld/7pDR7S
         xGh6NKI/Mu2F3Sy1/vpzKt34ByM3diedV4I0H8SQphcsyvUuNAzKwtrVPVleqxYZ3twI
         HcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781145981; x=1781750781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcjpE1eP9eIVKtszIoqhDW3RTPv4xN3zwDCvIagcOCY=;
        b=AUnCJKDuj5NxaD1gkpjVCy4xZbVDAaeHLYbDvqA0YQOb5viXfEe5BF+QnjSsdHlyLO
         Svn2VtY8+ZNs1x+5XtOVNryOu5SwXHlN2Hl6z1s7mOmf5k9QZcD3rlMoH+3ka4mjn4Ty
         2TNNd4oPspVfNqYzZrPaqpsMMhEF4R3S8tU65QFoRRSFA79g+JIiECmzIV1isYfY5RuK
         GHVa1I2PRJsLAzstKIgYZn/nMwgS/igSSmbvZl3/a0VOzvhN7Rnk5dJZZ6RYjH8cL8FM
         eE3sqCbFZVgPKjtNeXySZnet6RiHFWPvC92Szk5860t59iTukd7k1JUISEJ/XTsmd3xq
         w7HA==
X-Forwarded-Encrypted: i=1; AFNElJ96I8XJUky32XO1QgIOqRIYaYWC/xqxUnyGrHbDhPMT84ya2rGJgDq9l+k4bWo71dg+lb97GGH62Ld901icLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmVugv9P/KtbCoLfUwBQKf70ioivgxD2vuBQfQpt39qtqkEiYE
	+qXWRwo6aVQajLCb5oSKlRmRrUq7Gi2LDLVK0Gbbez5QXFKFVFyWPKuItTYMkqDHpQ==
X-Gm-Gg: Acq92OH/iqQeuUWWQEshKsTpcNjXvpM2swPxbaI2WAecrZtC8ZwQyJ34JVShvd2snX1
	cW2BsOu/NUtq+cGyF519Bg5bFxfYKXLnxaESR4VdI9y3jBNX/rfUhDsUhoOyjwoKp3K05rCBlTG
	1Emkb0ps0uWhffiT7ZOZZpKXdqE9SQAXbq5K8BTTFGgaF3ZIANisnJYh4zRq90DZdnILDZw17rl
	sJlEiuv3DHrx6yhlAvZPlGDoVOUFkTVq2LNFqjffc1LHEzhVHSbz6RmgS6/wCjBNCrrYQUvyfbC
	N7/w4EcabMyf6h4B8a264Q9k48jtK1mek1mqasSzhXIHb+ZWblG7ppl3ivDpnnyBLloIkprNvlO
	yTMWASMCFN77wWiqaON/oUdhCE6SnfqAdINuEILngPJu5B4M+5lbVyd4l67PGDm7fK/BPMD0YFY
	MIXmaJNrd1NCn5lnM=
X-Received: by 2002:a05:6a20:c887:b0:3b4:9124:ae14 with SMTP id adf61e73a8af0-3b5e31e23c8mr751745637.11.1781145980854;
        Wed, 10 Jun 2026 19:46:20 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86585b1f35sm72377a12.8.2026.06.10.19.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:46:20 -0700 (PDT)
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
Subject: [PATCH net v3] virtio-net: fix len check in receive_big()
Date: Wed, 10 Jun 2026 19:46:16 -0700
Message-ID: <20260611024616.1408317-1-xmei5@asu.edu>
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
v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag

 drivers/net/virtio_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..afe73eda1491 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
+	unsigned long max_len;
 	struct sk_buff *skb;
 
 	/* Make sure that len does not exceed the size allocated in
 	 * add_recvbuf_big.
 	 */
-	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
+		  vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_len)) {
 		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
-			 dev->name, len,
-			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+			 dev->name, len, max_len);
 		goto err;
 	}
 
-- 
2.43.0

