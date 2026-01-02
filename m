Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B02641C6
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367262; cv=none; b=WW7SlYEa5JKdgRt0Zbj+YwVoKZZSvUxaKyYQEQRs8E6NabnasWZCpZotFs8NsfwnwcV67pYubrP9XmvT7SLkqAOVgCwoW+97KfU+BtJVTX9MRBVHM1Os6EnFlsiellCcKQv3tfY3UtAND5gRVzkcBihkZEKnnLkw3Y3vB+1UvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367262; c=relaxed/simple;
	bh=/4eiguhDqiumviny97YbX/V0ioG/S7VlDOjqS+Yf6c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yg3IbKQPNh95nHYt47WOOEBMwp5ij1uetmLwnqr7dCE3KzK/owwKjly3FJeflS4be839V8kOXEy42UOaqqkxnfaDTGLgyO91OYZKaggIIviB7zhxo7k49YhRoDd4IrGog5U4NKhXqgbhQFy3Oc40+A0sUHuL2H7BCmVV4MaDZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljiAR2V3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljiAR2V3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so15565221a91.1
        for <virtualization@lists.linux.dev>; Fri, 02 Jan 2026 07:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367260; x=1767972060; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9jxgbD+/yxl3j2kHcSn/k4rVRA0Pzivb1lp5AvUuyE=;
        b=ljiAR2V3tLuKASLfXk+omxZJ/Ti4rcx9jBLlbnZ+M5KeUS+g3EYJwV46SWrmgfSkN9
         zwQDGiQzusdpKqfTVCBQ9pmWXqlgq/k7L6rjS+DotYYxTK/TOXt+VKF4cEGm4Yr81WJ+
         iP5wli5auM1UMZE5zI1srdQ45flyRotQunz6VqKUGqzLQ/63Ll8VharYFBC2SUXz85vO
         JfTr5fjA5b5VvhxmnrCKOJi7EBacriguUID0SUzMu676QQG/UYfPf2MhZl1/ugIePVdl
         oYhsREQ3OKxdBq67a1KXadQwLOVS/r438mckJeqfo5poYUYBOpWQ+w+wXrTFucGbvoMF
         +4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367260; x=1767972060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9jxgbD+/yxl3j2kHcSn/k4rVRA0Pzivb1lp5AvUuyE=;
        b=JWpf1sCznX/2CeuLPkpe6iOugUeHJxaaF4HkIThzDNCozNaZ3Ehx4dbSzDZZtOU3cV
         auYOXhd4tL8+UP3uMmWITrcY5LiOtxA9ZwaDlxxo0h//vlMvhIE/XU8t8Z6BwQGCb4rS
         eqbZu4bVfcXxfF4FdI3naLblb3zSTX33wXbjA9Bg405KaaHd4iruwfQMCfdnmHckTobZ
         Sf9FGEOwefoFJPqRkxEIcyu3DrEltx3pfnZDWRe0T/w8Q5wKbR1jIDbMvawQJy0Hl3hC
         5TOFbTg/NGMtNc5orNRfTJpGIilyO1vXsxVdwkHa7Fk9oXRz1m84QW7aYfJat651DAWo
         YIhw==
X-Forwarded-Encrypted: i=1; AJvYcCVyh9LSK8doK7laiaryRy1HBv1dDbBIXQjC2Qizfw7czqJGvOSZQW3/COpTq7lW5mOZ+tCJXAd6m/0SQAkN0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs4CTrTp5UUUYk5l9lIqlQqVJxKUWsbY5I1oPGM1hp+B8rEic8
	Wk3fv83R9ySQe2gNggoEPsh1rm5wfH+Ux3yXydX3mBNecYQq/T1fGRIs
X-Gm-Gg: AY/fxX4F5CoqH57naVwEUAIyamOuT31wlAQubOc2Sot2SIGeT6gq0C5PJGH80HbMcdd
	QDMDH8vCxO8J4VJR3Olf/KG8NB/Syn5EBWpWSzwgPl5SuWnaalWrI6M8V91xPNfdGcBb3mJMLkV
	A3IETJmuNKlpvZbiMekk4iXCP+CWoWeCSLkgCqqzarwBQ0CGMT92a/SdFT6xnJ8qpr8qNVMtiAd
	jLhBhRuEtJuVXfXc8/slkzmnYKYtAyD9OTncj0UdxuTdCP+qnHCLm0pZ94hr8QPilcVhSV/3WdN
	ASjJf52I1w1uMTf1ZKAcK/3FUefdv0SK76GFtOTZf0gE6Sl6zBvyzIjRvkmcvtBbh53qfTV4btU
	8lwBHsL3JqpMcB8ih57mbXlVtu8MIagGmnSjpCz9WtOiikQoY09jOH66Xg/kCvgK7p7aqexkiAz
	VLrV8GWYhVvJWiRYODn+k27OY=
X-Google-Smtp-Source: AGHT+IG+uB/bwtxyi8mZp0xNuzYOVJCRuR6o1MY96JjPiCTZmrbu0bFieKOLX9lXthIPYGtwJPA6DA==
X-Received: by 2002:a17:90b:5188:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-34e92139e2dmr36663487a91.14.1767367260086;
        Fri, 02 Jan 2026 07:21:00 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:59 -0800 (PST)
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
Subject: [PATCH net v2 3/3] virtio-net: clean up __virtnet_rx_pause/resume
Date: Fri,  2 Jan 2026 22:20:23 +0700
Message-ID: <20260102152023.10773-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delayed refill worker is removed which makes virtnet_rx_pause/resume
quite the same as __virtnet_rx_pause/resume. So remove
__virtnet_rx_pause/resume and move the code to virtnet_rx_pause/resume.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e77a05b5662..95c80f55fa9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3366,8 +3366,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void __virtnet_rx_pause(struct virtnet_info *vi,
-			       struct receive_queue *rq)
+static void virtnet_rx_pause(struct virtnet_info *vi,
+			     struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
@@ -3382,17 +3382,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++)
-		__virtnet_rx_pause(vi, &vi->rq[i]);
+		virtnet_rx_pause(vi, &vi->rq[i]);
 }
 
-static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
-{
-	__virtnet_rx_pause(vi, rq);
-}
-
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
+static void virtnet_rx_resume(struct virtnet_info *vi,
+			      struct receive_queue *rq,
+			      bool refill)
 {
 	bool running = netif_running(vi->dev);
 
@@ -3412,17 +3407,12 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
+			virtnet_rx_resume(vi, &vi->rq[i], true);
 		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+			virtnet_rx_resume(vi, &vi->rq[i], false);
 	}
 }
 
-static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
-{
-	__virtnet_rx_resume(vi, rq, true);
-}
-
 static int virtnet_rx_resize(struct virtnet_info *vi,
 			     struct receive_queue *rq, u32 ring_num)
 {
@@ -3436,7 +3426,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
-	virtnet_rx_resume(vi, rq);
+	virtnet_rx_resume(vi, rq, true);
 	return err;
 }
 
@@ -5814,7 +5804,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	rq->xsk_pool = pool;
 
-	virtnet_rx_resume(vi, rq);
+	virtnet_rx_resume(vi, rq, true);
 
 	if (pool)
 		return 0;
-- 
2.43.0

