Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C354418D7
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688453; cv=none; b=uQKAHUXElJ/sZIexk7To9BTbRxfZuMuyzBjYKMRjWalefKLXgPhexyv4KBBUB7HeRzzh6hXbCHjR74XBRxe4b73pCuRW7Lv+uKh4G18YEfNqZ8zm4UJRvYunFZukWdYFl5kDy/P45rfiB2H5JGHw1NNKLDqGH8BGuPDFfZFs5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688453; c=relaxed/simple;
	bh=y/rU4gh0E0L2u/dhKcW9ljUwXNcpqmT4X+WX+7weVWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfPMZTDpd3tRUIzfGl4NJvGJts/IQOxEn6cmoD0ueopCksbxCXtJq6I2CanSWY2yMCeCcOm079z8bS+tNocwscjilnx8/Df2zaCLJaOk4Is/5F9T5ocTWTPBDUdQwNa8aGR7I3CQG6XE5aWu13MkIwLISesZdWxpMuPayM7YOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=BW888Rs/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="BW888Rs/"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ccf01ba514so19150936d6.0
        for <virtualization@lists.linux.dev>; Fri, 05 Jun 2026 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780688449; x=1781293249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAFqrVA+AqYfDZqdtHewX5SP2boCxXzf2uI82b8kdGA=;
        b=BW888Rs//Tr72XbCY2PRsghGgcGXYL3/jz2UynKKdH27fUYLuanWjK/MIwcigiHoqK
         mW6pZkW2fTD8CNnaRW4VIeCGqKZeFwYOeUbRZqhJZC9VDK4bLLqtKyr9NtkjdEtNMAE/
         oekiMEoXutVn3tQmSswMhOP7JIxaPKQIpiDk/wpjjAuGDXj16gf5hDpiiMPA1YX6KDCK
         8xEs4Wa7nYb4NOCkxi0VTMWVN5Lbaa5/AwGvm51MiIbSHQYrFYiC0d7BKEzBT7BuKhQ/
         YdHKur+ongAAeoZuMbzKl1R2fTmdVzrVR5qBqcNXQXFEBVw7N2G7IfZkb9wIJkyTtlHC
         KXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780688449; x=1781293249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAFqrVA+AqYfDZqdtHewX5SP2boCxXzf2uI82b8kdGA=;
        b=HfiDE3MUKrnV8SzIvMWd3eThxQ/XIvsSDdkXCM2CmxznVj6U+44UGz6ZgA64Yug9sl
         2t+v0zeq2vCcAxkeZBg6lubRS6kjdZq58dn2biS8zocNEvSZFPkbrbRoWZaJz/UOGvcb
         8P46XlDdrpxPXIJwxDq1O9gnsgJttPGZdTDNTNX57aG1GDLcqLay23t0RKPCEQieyYlv
         mlMwU2y9OTpxtO7KtRvi4zjul/IDUfD1i+GPF4bNg61zXdWcD7a/6w3LnZ/FYBZNx3La
         Dn1ZdrU99iF1Iw58CQrnP2UMBLhO4b+FEn6jrg0H7Dtw2HAcS24B/38NhgboD3DunyVq
         CqGA==
X-Forwarded-Encrypted: i=1; AFNElJ8EUfb9wvQMRzekaJ8+KdhaHlAtmYucC7Qmua3qmXH2IpjyB/orhRRfl3/t5E/F6iHDW/SQyAj8J93lNs6Kgw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/WWUCIGrGLG5lml0oMU3wamVd7/KwT1yDx66hltGD2qWzsJjy
	bBX5lwrHlBKRbzvOQ2m18nF/7tFFmCO81f7KJakMXKrKduau10Am4iYNsj5O5zVpgY8=
X-Gm-Gg: Acq92OGS2wYtqUaeuDjuWGB5bgL4PlmaFS2JcHgskd4km1+AqOwfMOi31jowRcLHsCr
	upW/vJK1IMqzed5z1ovBsvrAN39PrQAIeUGW/+ekyYSzwXiJXvhqTvghWT7L19ZSuo67BJzhdGd
	3B3HerxtBnXjpYTX4h4t8fPwo2RwJED8IrgxJFAPVAqWMYPckZYmLi1/hCA7l1y+3T3692yFPsZ
	1VIVQTPAvgonKaBLVi05Ub7xiIU4tK/GFQjj8hr6Q0CbVGkq04nL3hQZ8grafmtVsnE3ub+Rc2e
	fWQKwAXpThzLp++NujnfiV7pJ8azzso/TAB5X2DUpC5Oh52nh1snHyMpY+mhni5R+nTg0gD/Dnq
	cI4bhiqFf+ztNoPesMeb11GwVgrZH6BlvKDKbiVbGE9Hg9G/mGbr0i8rTg6zVFuZQIVA4vhtwdu
	4QDsEshi21IHEZJa893gZcFYaE5zuEnlm/x1sNXA==
X-Received: by 2002:a05:620a:690d:b0:915:8865:dc01 with SMTP id af79cd13be357-915a9da7f30mr906550385a.46.1780688448992;
        Fri, 05 Jun 2026 12:40:48 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a00afafsm974370785a.2.2026.06.05.12.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 12:40:48 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:VIRTIO NET DRIVER),
	virtualization@lists.linux.dev (open list:VIRTIO NET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] virtio_net: normalize non-positive napi_weight values
Date: Fri,  5 Jun 2026 19:40:44 +0000
Message-ID: <20260605194045.2625610-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio_net.napi_weight module parameter is signed and is copied
directly into the RX NAPI weight after netif_napi_add_config().

A value of -1 lets virtnet_poll() run with a negative budget.  The RX
loop processes no packets, the unsigned received-vs-budget comparison
completes NAPI, and the NAPI core reports:

NAPI poll function virtnet_poll returned 0, exceeding its budget of -1

The device then repeatedly drops receive progress under stock QEMU
virtio-net traffic.

Normalize non-positive values to the default NAPI weight before
assigning the RX and TX NAPI weights.  TX NAPI can still be disabled
through the separate napi_tx parameter, which intentionally sets the TX
weight to zero.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..667026607cfa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6481,6 +6481,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 static int virtnet_alloc_queues(struct virtnet_info *vi)
 {
 	int i;
+	int weight = napi_weight > 0 ? napi_weight : NAPI_POLL_WEIGHT;
 
 	if (vi->has_cvq) {
 		vi->ctrl = kzalloc_obj(*vi->ctrl);
@@ -6500,10 +6501,10 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
 				      i);
-		vi->rq[i].napi.weight = napi_weight;
+		vi->rq[i].napi.weight = weight;
 		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
 					 virtnet_poll_tx,
-					 napi_tx ? napi_weight : 0);
+					 napi_tx ? weight : 0);
 
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
-- 
2.43.0

