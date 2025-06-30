Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA028DB6D
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294584; cv=none; b=YOuJZjaPA8H6N1kZsUhDZeZaamO37+UYC4TF1E9yrQTJvm54gG0QmbzZ53hekO+1CAxNoLQOPQJkHQZYtd7eMRWT7NY36pZYAsagmJqFut7HGOouKwOVYKL8lX3f2ojbA5D2tf1KaqHcy6trQsiHdUBOOMLBTBbRPmET9H15JBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294584; c=relaxed/simple;
	bh=aJBZLRK2AtKTR7exY7C4jH9FsFz8pTE7CY5s0ADk6xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVSFf/CsGYW0noZomjaj7Ph4nfSsAJGMFR2+5D+Prf2W2Sim4J9L+eFtYBBsi3Milaz552oXQGEpOizO/k0ZauMCVSCkO5offfisTgdihs0S/6w+ZRckdgQvCI/Xlw4ya7Vgn7gaVRo1xAmJN9HACUCup+wXO2ox5BL0coRbeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTzfs28w; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTzfs28w"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so4504571a91.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751294582; x=1751899382; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n69gDXxPGfgIU+wPEIeigImTRma77DzYZ7Ve67R5PNg=;
        b=dTzfs28wxoNfyLkOTRGts/m30ZwdDpKT5g9k32cU6i2Gh59AuAJoOoscfopz0Kq1rC
         pH+ZzJRyHjYAayuFuoEwU/s57cKqwRTYkfS9HcaeK5//kJkOM4RqD3eTI+u6GA1CQyDE
         t3ueM9LCnFEwrzJ/EItEIRx4C6OyyoVV+pUWA8GwiQwvkbOSjnfrHkCczivqDBJWq472
         kKeZt7KSLJTo+LqKDnkud3etN7xPOKdPPCVDpLXzOd8xYq+w8iLIrvL6ilAY1lT3HRI9
         Rqoq0CGG4NBPPhZCloSPP9lZzPhB3Hu9F7lEIVEGNbseNHbVLm6dJwI1OD2vpw9Ip2nb
         +w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294582; x=1751899382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n69gDXxPGfgIU+wPEIeigImTRma77DzYZ7Ve67R5PNg=;
        b=RK5Irr651ueliY5pS0izfpLRmi1/kWhYxLjU4y5yi3mPcFVRz+0Tfnc9Ke/HGPmJb4
         HeeUz9jH0AE4EoP4mWqE+We5oLOhWUadHEP2eyrqqi0hMGvcItMORiiFUpyiAKrt0tC6
         TmCyosVvW0M3Q5bk3YdMGPuO6EdzeBuAVgabyk+EgY3jbGa3xQfxVwLQV+nLN0Up8yIL
         K1E3rTmlhTb19DxpAtKZtG3tAROq6FLZz9d0YXCsbeq2Zi/+rYNY/JEB0xyCvSqhrOda
         Ixm+aojsxkccKbx6jyP+SBRwWsGCnBfDME2T5vgQIY4Su99DE01yNu4MkHBVVBdH58K9
         n4sA==
X-Forwarded-Encrypted: i=1; AJvYcCWj14YJwRdATkHBLk6mf8WxbpwtjLWW9AY+FhyYAgfeW1no/NY1Y4PjEs6/+IfAeVJFuYp7ik10av7OjWSyGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBO96n3Alv1hYBW7MNQASl+uaJaeUC9ZPUz5XW5umf6hv+x8mT
	kh6n7NmaAN41UP/6gtGVyjzDM2wSBzJOohT7WatfHt25n4cpN4BQ6XSp
X-Gm-Gg: ASbGncu2me/USeOHPC7g11sW5yMStzkZ9G/DhFHms8gr48N+zuVAjg1iyuvayDrBNcT
	wY7E5xKU4YMU0EXspLiI5FIITqz7kp5M+u7HDMV6CAHGjC9An7xXpjDBogfjZNQsnGBelwjSqmi
	90PLey/VqMzqHAIw1AVsKThf9nAkMoUxyLn5q9ID9SmlJx1fFUWUqWtkn5/3sc6fhhr/a7D2eu+
	v8cEZ4d4Bbiz5Pgq4FwDRY+DF2fcmixcswWi13qjdrDTbWyWASKpdHLu1/KyFaCgJB69dDzTABw
	WyNN7Uj2UEMcBCO4Cjjdoi3tJZ8eM0poGV49iNI2sc5EhrcCiWH7GbdWJ9QfAk7zQ1TOhK4oD2W
	4
X-Google-Smtp-Source: AGHT+IEBKjYr3kuohCQjY0CglzvBmQzIq01EIwspNpePjbfFFbP1AgODBoDwnck1jrdGsXqUo51EbA==
X-Received: by 2002:a17:90b:1b0c:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-318c91117a0mr17987244a91.5.1751294582368;
        Mon, 30 Jun 2025 07:43:02 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a270csm9170017a91.16.2025.06.30.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:43:01 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 3/3] virtio-net: use the check_mergeable_len helper
Date: Mon, 30 Jun 2025 21:42:12 +0700
Message-ID: <20250630144212.48471-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630144212.48471-1-minhquangbui99@gmail.com>
References: <20250630144212.48471-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the current repeated code to check received length in mergeable
mode with the new check_mergeable_len helper.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 535a4534c27f..ecd3f46deb5d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2156,7 +2156,6 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				      struct virtnet_rq_stats *stats)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
-	unsigned int headroom, tailroom, room;
 	struct skb_shared_info *shinfo;
 	unsigned int xdp_frags_truesz = 0;
 	unsigned int truesize;
@@ -2202,20 +2201,14 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		page = virt_to_head_page(buf);
 		offset = buf - page_address(page);
 
-		truesize = mergeable_ctx_to_truesize(ctx);
-		headroom = mergeable_ctx_to_headroom(ctx);
-		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-		room = SKB_DATA_ALIGN(headroom + tailroom);
-
-		xdp_frags_truesz += truesize;
-		if (unlikely(len > truesize - room)) {
+		if (check_mergeable_len(dev, ctx, len)) {
 			put_page(page);
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, len, (unsigned long)(truesize - room));
-			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
+		truesize = mergeable_ctx_to_truesize(ctx);
+		xdp_frags_truesz += truesize;
+
 		frag = &shinfo->frags[shinfo->nr_frags++];
 		skb_frag_fill_page_desc(frag, page, offset, len);
 		if (page_is_pfmemalloc(page))
@@ -2429,18 +2422,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	struct sk_buff *head_skb, *curr_skb;
 	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
 	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
-	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
 
 	head_skb = NULL;
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
-	if (unlikely(len > truesize - room)) {
-		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-			 dev->name, len, (unsigned long)(truesize - room));
-		DEV_STATS_INC(dev, rx_length_errors);
+	if (check_mergeable_len(dev, ctx, len))
 		goto err_skb;
-	}
 
 	if (unlikely(vi->xdp_enabled)) {
 		struct bpf_prog *xdp_prog;
@@ -2475,17 +2462,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
 
-		truesize = mergeable_ctx_to_truesize(ctx);
-		headroom = mergeable_ctx_to_headroom(ctx);
-		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-		room = SKB_DATA_ALIGN(headroom + tailroom);
-		if (unlikely(len > truesize - room)) {
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, len, (unsigned long)(truesize - room));
-			DEV_STATS_INC(dev, rx_length_errors);
+		if (check_mergeable_len(dev, ctx, len))
 			goto err_skb;
-		}
 
+		truesize = mergeable_ctx_to_truesize(ctx);
 		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb)
-- 
2.43.0

