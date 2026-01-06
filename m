Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAB3385B8
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711915; cv=none; b=Tb98Dq9DLqTlh00T05loBeO/v39YIoTOPNCWoZkdT+zcQl5f/aDfVhMpFWLYjqtFILHCcrfkDxXJmGdH4ldo1GPsJoGFAJgcbNORcNj3TmQkrjN6NmTWoOqm8elCs262MYhmR2WtfA87oOKcN5bKomb3hED9f+WluV5AsNDE3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711915; c=relaxed/simple;
	bh=iakYf4ocTYJ7pB+W5zvpfHG5k1a398Tzn3uAlEF7lF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=todb5coHr/Jl/o0BwXZOxzseLj6tQiMY4okwW+JN+KQWqDpXvGGdiFPccibXJBOq8/yXLOoCWtwu2Pc1AVLyHJ0ptj7m8QLsmyqucF/5tZMsIyGHXKtpsotOuFiQ5By+d0K3nA8DEK8j2auOjKgB0nfSp8PbxstzFkxncoihBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cndE+rFg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cndE+rFg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so916063b3a.3
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711914; x=1768316714; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC197L1plDdByX5sXGNPm444DjHNEfSXtphhEaSIChs=;
        b=cndE+rFgqLTOba6I/Tkcl/EEG20hTHNgz7aWqdWJaiynNtz6cdmoTR+/Y6ppkzmYoK
         CbZ76SkcQ4RZjsHQIgeQ1Nd9mE3zHOubdswuo9n2zot0X7PO0vVcMi5tcNOr2wPXKxhp
         MsdJwTMe2kpnBFcq4wumy/unHiRRYsNhQpXv0vJ46S5hslt31AYLtZHW+d47g2Ptq5Xo
         QWtCxZ68YpiLhjmfO5xiBLHjrT0msHkPuXbkDM0JAKkp1tscAf5U9jBq95FgVoYTxM0l
         FeqbLxLAgW6LCYJ2OQvuTpib0inAMleePB3u9JVJs++8C2YYn7PCrvAbLxbXlEvaHJHj
         qJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711914; x=1768316714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tC197L1plDdByX5sXGNPm444DjHNEfSXtphhEaSIChs=;
        b=vyJeR+6IvrV30aUOG/w6q18i9ZlDtzIe13plGabEuNF9kpgejEnKNZxEhnqsrhkOaA
         qDfTmtCkA8taHYVEgiYXu+gV5OyjUf2H7bhig3obGQXQVm755shEtFNQXv+4uAJ+LRV7
         +SQDROklqZgPxg2mS8vFXsa9OXbfQYaGr6bWsFV1BxRZzJa5QxW042YIaTSZxyo/T/Db
         dGAwyHhbbp+nG7I+XDh8v4Oh0KO/4bTsG/J1oqh4o4xLRfhE7RNckJoW9/qGO8yEYx4v
         0XyixAmMisB3ag3V6z9Vo7BjHb4nTkNo7C1aiyAvUt25p7bHH0mj3pWvFzPF66hG3uWW
         EaJw==
X-Forwarded-Encrypted: i=1; AJvYcCW2BVUg07qlGha/syZ7IINLGbFqkTXKIso0Ut4IazdLpus1iY3Dfblcxt/Qs+lu35Wp6jpmOaOclf72stxo5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/qtD+BaDQbvtC2Hma1up83LvTaL+BPFJ7sTHLq75U1DVcEkII
	t7QuESJUkT0FML0M5dtKXxy//b2ORPt2lWEP1ZQUuJGOkG0g4oYIf78Z
X-Gm-Gg: AY/fxX63fb/hr6yn6CnoodoRwSxjqiuEdSRd5rAHAhX8u9IrbShoqyKEl7jWAgnZimm
	9iJX2Jecel+2xH2+QTbEka6xYLrnRbuC5cW2Q0kRInNpImBovhxUWoG67053hdL+reqBAvkmufZ
	b5jSqYFox+44V64f3wAZhYeQm4oHTDwZDKQFoM/KX9MPgWWTG+OlaQ2hKsBZUTCQi4GVVuwNa+D
	DyfQzfWL6y0UIVWa9TvBCuDjUoJXQ+SlxvIzH6Cdpb4BfSj1LO8RVn3MjnC71NbH8Ug+Mtya5dh
	XbN1x4zGVM1Dy1v1whVCSWVkVv3sxRw2cOFXNjotRDqVEI7ukxFlmjlkakZUtYusO758CJZOKKI
	YPrAqhJQBQbmpyuwqh+71qxFaf5vqJRL4kyZs4LRqWSQKqWDdGmJxjrxOhqks0S08OiUiSclLyh
	KY5gtsi6Om
X-Google-Smtp-Source: AGHT+IGhJ2thPSuMeCWJuvxELL17nB4aCL3Ngpi+wjeWS3G5XiZYgyewYqUsGwlAYN2kTVU2XU2ttQ==
X-Received: by 2002:a05:6a21:3290:b0:366:14b2:313 with SMTP id adf61e73a8af0-389823cbca6mr3147694637.70.1767711913785;
        Tue, 06 Jan 2026 07:05:13 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:05:13 -0800 (PST)
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
Subject: [PATCH net v3 3/3] virtio-net: clean up __virtnet_rx_pause/resume
Date: Tue,  6 Jan 2026 22:04:38 +0700
Message-ID: <20260106150438.7425-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106150438.7425-1-minhquangbui99@gmail.com>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a4dbc958689b..745bae756920 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3369,8 +3369,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void __virtnet_rx_pause(struct virtnet_info *vi,
-			       struct receive_queue *rq)
+static void virtnet_rx_pause(struct virtnet_info *vi,
+			     struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
@@ -3385,17 +3385,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
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
 	if (netif_running(vi->dev)) {
 		/* Pre-fill rq agressively, to make sure we are ready to get
@@ -3414,17 +3409,12 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
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
@@ -3438,7 +3428,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
-	virtnet_rx_resume(vi, rq);
+	virtnet_rx_resume(vi, rq, true);
 	return err;
 }
 
@@ -5811,7 +5801,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	rq->xsk_pool = pool;
 
-	virtnet_rx_resume(vi, rq);
+	virtnet_rx_resume(vi, rq, true);
 
 	if (pool)
 		return 0;
-- 
2.43.0

