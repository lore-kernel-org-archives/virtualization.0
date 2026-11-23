Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461752;
	b=pNONMPu172OLJvHMqU5UDs72AG67rMeiKTAkT2liFHjBf5zRDbLtLXUkkCS652vocmFo
	 i03n6wuF52wTdk+dFKcBgvzIg1sHdJT+yCc5rtDphFvDw15lXfPGzMgJn96nIjqMByI1a
	 BTvVlId0u+UPUUjCYT959+12GJq1OMWxwmG/i3zFYudAwsSJTXGOOkrIqYZIeBMtx9cUf
	 ZcPXYWp8YGKMrQKNfbP4RBNTq0jqosEpSIEmCNS1j80Ex+9MpPyX0QM+sklOEPVCQCbgR
	 u01cZ/dHkaBjuciJrfZqsXkp2hGY0jdEpyJ6hB6Yzw4mYKV/VBBpqbE5r72ANLtqR2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ETps0+A920M+I0wsn4d1uMr+F5f++KxdjGc1y6/+WnU=;
	b=OnvJ8kp0NrAPTC/bjT+4Z3HgdKcBnLxMTmc/uJBB62VegAEZAoguOj+o+ys4VZ5H37vy
	 FL7wyd6KFDLU7nwx+FaLKN4BD9gtMI3HmgJnDAW9UisOvcFEXVCC1+yutdIxactE76/TX
	 AK44ZjvlZ7owRuCn/1NvfPDHr0+bLeOip6v4/7MHlyugselswt5SluRLjKKndAVVg922b
	 KEu6FeqEweYE2AnA4UPURWsYecRX9UzC7ey1kMDDVELlSCSZ3NPh1NpCpYz8nlkg0ZzwM
	 hyz4XC3Yc9EYACg5ozuglM5iZyIzbai3Kqg5UyG1h66ErBqCa1AUOyMTtp7QnbaeUbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hwY+7E3O;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CE606A321
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 19:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 743CE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hwY+7E3O
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so2291471c88.0
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795461751; x=1796066551; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ETps0+A920M+I0wsn4d1uMr+F5f++KxdjGc1y6/+WnU=;
        b=hwY+7E3O95z6FNADBKKrE39OZh0QXGQmAgE6DmkrI4Tv5jnOg/Uvc+z+OC6qpC4YMR
         EfzHILYcB4bnUil5AZzFOmehB31o0F/atNvyNSPFtqwP23CHyffVUjFaiZnZ1hbxOiUf
         7MP3Cmj99q8TcscdAnD5FoJsLAopnpEVqRxYtHFd9BiqNGR0zqRq49rR3e2vlSNjL4Wk
         Rf+A/jhdEo+QlXPZC/6SmO71i77qD8iSFTwQ7G9zKUPWN0sVVzlwNlGRijrlDEoiKNhd
         qdZqQOBzox1eLuLuKPWDK6EfhvCXo1TXMrNzPBe5CZAVdSy+OIbGSBwJ2YUrni4TnBQZ
         fzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795461751; x=1796066551;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ETps0+A920M+I0wsn4d1uMr+F5f++KxdjGc1y6/+WnU=;
        b=GLW4okm3kjUyDBrFFdSoi23QhL/z5Bqw3kDWq/FKfcGQDf66+iSRh1ap1ZLGs8WQvt
         atguSAL8iVwW58ENu4/n7Q3GyMVczyj/vXjL8WjHPFrketafLpz72b3/aXCkCQTpbdji
         oeujBeSxHByefuuZcjeGPaofSonl0OoiWG55gfEmub1O/CjQYFBLYkpBAXDOXl0hzEh8
         ql/WGkMPPMhOSyIdJjYURdsBIOOqyb10Wh5kE4im3CXmkpOS77hemGSbNLNv5QTZiRNO
         scMzEmkEZYkrxTDOb9RYOxUJ7jlb4tQ/RUtKF7ElUCawb1s2xUfmMXtWC3WGKOQXXIoo
         kIlw==
X-Forwarded-Encrypted: i=1; AL+hErF1caBS1Trcz3YJ103G0KhHL0xCR2zHvvfTAIHwHnWDvnJRQI52RXzK14sJXlK1xBYOpXFcaI+cC9SXFKrR9A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+cP6Q6LFzamLwa0WDWCnOtRFF4CHEYVpAbh7OTV9HDwF+6ymLV
	TdNc6iejQXRAGYckPTA+mfVYOkw/EeCKsfhWYzCKuyim0wvaAFUp5S9vrgBruwAKdSUlX0PQ25h
	MVWutjn9qmtbsUSzEPXIQ5A==
X-Received: from dldz14-n1.prod.google.com ([2002:a05:701b:418e:10b0:1a1:ce17:436b])
 (user=nilayvaish job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:21cd:b0:1b2:4871:b1f7 with SMTP id a92af1059eb24-1b5568fbfcbmr10792987c88.39.1795461749885;
 Mon, 23 Nov 2026 11:22:29 -0800 (PST)
Date: Mon, 23 Nov 2026 11:22:20 -0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261123192220.4013325-1-nilayvaish@google.com>
Subject: [PATCH net-next] virtio_net: use page_private() accessors for the
 big-packets page chain
From: Nilay Vaish <nilayvaish@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
Cc: "=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"

Big packets mode chains its receive pages through page->private, reading
and writing the field directly.

struct page is being shrunk as part of the memdesc work, and its private
field is one of those that will move. Direct users have to go through
the accessors before that can happen.

Use page_private() and set_page_private() instead, like the rest of the
kernel, so that the driver no longer depends on where struct page keeps
the field.

No functional change.

This patch was written with the help of an AI coding assistant (Gemini).

Signed-off-by: Nilay Vaish <nilayvaish@google.com>
---
 drivers/net/virtio_net.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0988a946ef35..5eef2c315963 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -680,8 +680,10 @@ static void give_pages(struct receive_queue *rq, struct page *page)
 	struct page *end;
 
 	/* Find end of list, sew whole thing into vi->rq.pages. */
-	for (end = page; end->private; end = (struct page *)end->private);
-	end->private = (unsigned long)rq->pages;
+	for (end = page; page_private(end);
+	     end = (struct page *)page_private(end))
+		;
+	set_page_private(end, (unsigned long)rq->pages);
 	rq->pages = page;
 }
 
@@ -690,9 +692,9 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	struct page *p = rq->pages;
 
 	if (p) {
-		rq->pages = (struct page *)p->private;
+		rq->pages = (struct page *)page_private(p);
 		/* clear private here, it is used to chain pages */
-		p->private = 0;
+		set_page_private(p, 0);
 	} else
 		p = alloc_page(gfp_mask);
 	return p;
@@ -881,7 +883,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		 * Currently, big packets mode doesn't use page pools.
 		 */
 		if (!rq->page_pool) {
-			page = (struct page *)page->private;
+			page = (struct page *)page_private(page);
 			if (page)
 				give_pages(rq, page);
 		}
@@ -929,7 +931,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
 				frag_size, truesize);
 		len -= frag_size;
-		page = (struct page *)page->private;
+		page = (struct page *)page_private(page);
 		offset = 0;
 	}
 
@@ -2705,7 +2707,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 		sg_set_buf(&rq->sg[i], page_address(first), PAGE_SIZE);
 
 		/* chain new page in list head to match sg */
-		first->private = (unsigned long)list;
+		set_page_private(first, (unsigned long)list);
 		list = first;
 	}
 
@@ -2725,7 +2727,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 	sg_set_buf(&rq->sg[1], p + offset, PAGE_SIZE - offset);
 
 	/* chain first in list head */
-	first->private = (unsigned long)list;
+	set_page_private(first, (unsigned long)list);
 	err = virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num_skbfrags + 2,
 				  first, gfp);
 	if (err < 0)
-- 
2.56.1.839.g22a8290db9-goog

