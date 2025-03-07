Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B811531E9
	for <virtualization@lists.linux.dev>; Fri,  7 Mar 2025 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309945; cv=none; b=MZG7WyDP+oPkws5jZFDNf8gt9qPFJsm1FJIHgF6w7jd9Z/2ch/AkZ/bLyZ9HFSouq4+ifGPUb6obi7irB4VWK1QdtnDhRE+zIzwq9ceofNdqQjfHCTZEmMDpUzYTMb+rvXrOuVgeWAuy/eeivKr67Tlm1fo/66YvQFZ3mqFou5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309945; c=relaxed/simple;
	bh=yAvpgVVKv0qwVx/BcaJPPk6io7i8uqUMf303YSpg6Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ2ZnL67otND2AoJX5+wWk//R3wmyjjZ1vywL9a8DOO2GyifdF6dX11MyWtHO9MYg1EPlu1xwhysmob5SWzfKVKRFdltWTKJ8dd8UozTQV9wIuwO3DxsXczdkCwzwHwQAed5IJZvlm6icm6L49QYJ+mLIOqGmtt9xldRGjPANXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qR9xG8Z1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qR9xG8Z1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224100e9a5cso24308495ad.2
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 17:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309943; x=1741914743; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=qR9xG8Z1iPqkANov6pp/HPjjZrDQjnYphIDUtL+6AsiEVlOYaH+WL719hNhdDCaYQG
         5y6OhCiYencQFVvKZ78rjBC+Iuf3matPTJn+hOFSsbMaJDm93Dss8N5rRSp9r9OnAoD+
         wJ8l9P5cm9ve6GK29Z5B27ge1xXB3mpHApcLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309943; x=1741914743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=C0NEZnj9jeAPX0JncJq/GMRB9yg+NXGTuYKMAW/odHs2plq/12Oea1NqhTgYGbqwnm
         BiD2clsh0rzMgm9zp9Tu5UtVQ5Alui+9aXnlQ8EObrGKrsTAmtGjNeJA8JsYRnfhprmu
         Y16qp20JTi6le2f+jwwz5q/msSMjlRcbh4NhBvuHISkytBuTGC1KGmWi9BwJ5aX75uiW
         t7QyOcFa+LBiVkfx14SYajVXMvKc3nssN6hSzDpMwTJxPKha/X27fVeFKGLaXWJv0o2E
         +dFR1xj2WWjYqy8Z5rOgGtN32ScVDb57q7Bg+09vvnYNLZEOMYWrz9udDbytYYrez9cX
         HDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk+usc5Jx/cUi6OAckyyrNKawoiODWM+xM/ZqLMuUKqq2oXdJU4rqLswfB/0qK3j6wLhEw7CGllYz2YFChug==@lists.linux.dev
X-Gm-Message-State: AOJu0YzemNx6aDtzzzNexBwHndqyp7a7fwkhqBubfrWH2QESdWcO9D2c
	YaSflFy/9w7utX1RpkzYbFEVeSwM5LafUxHVXxcD9qfUXtIEy/53UZpMzZbz1EU=
X-Gm-Gg: ASbGncvFPQuFpBGwch6LRWbGj0h+cHb4sClpl5oq/Db4FQgJ0D3dMv6nTOtVkGJPTap
	d7dyZ3+ShEtRL9EMWAQ81EVSauNUToochjYgL7oNW+XEfWRMVS+SJv2JWl8KLI6SAm22P36eN5K
	Js0XbkLF7G2yHvIheNqcmkgNX9/pODRvLKbl4y4ZVrsa6d2krUpanoTU5pztA8i6Shd0nGKw7ou
	8mCw1wwieZ/G+zDE1g3/3rfOdkS2WALXMc3T/qHpCaoy2nzfeUWBTvNCC2Fld+IK3y8pt5tSvAy
	DJgl+NyE5ygduK9AXTGHhriPIjcxyN2mpTlhtbx+5deBut935ivG
X-Google-Smtp-Source: AGHT+IGoI+aPJvj7yY+4BLZ2+twYf/oT3+TiRwVbnShK0v7noTjCRMsILjhJFgqCavzprURMi0Wvnw==
X-Received: by 2002:a17:902:e810:b0:223:432b:593d with SMTP id d9443c01a7336-22428c07537mr25062635ad.42.1741309943342;
        Thu, 06 Mar 2025 17:12:23 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:22 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 2/4] virtio-net: Refactor napi_disable paths
Date: Fri,  7 Mar 2025 01:12:10 +0000
Message-ID: <20250307011215.266806-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
References: <20250307011215.266806-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create virtnet_napi_disable helper and refactor virtnet_napi_tx_disable
to take a struct send_queue.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 133b004c7a9a..e578885c1093 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2845,12 +2845,21 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
 	virtnet_napi_do_enable(sq->vq, napi);
 }
 
-static void virtnet_napi_tx_disable(struct napi_struct *napi)
+static void virtnet_napi_tx_disable(struct send_queue *sq)
 {
+	struct napi_struct *napi = &sq->napi;
+
 	if (napi->weight)
 		napi_disable(napi);
 }
 
+static void virtnet_napi_disable(struct receive_queue *rq)
+{
+	struct napi_struct *napi = &rq->napi;
+
+	napi_disable(napi);
+}
+
 static void refill_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
@@ -2861,7 +2870,7 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq);
 
@@ -3060,8 +3069,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
-	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
-	napi_disable(&vi->rq[qp_index].napi);
+	virtnet_napi_tx_disable(&vi->sq[qp_index]);
+	virtnet_napi_disable(&vi->rq[qp_index]);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3333,7 +3342,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -3375,7 +3384,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
 	qindex = sq - vi->sq;
 
 	if (running)
-		virtnet_napi_tx_disable(&sq->napi);
+		virtnet_napi_tx_disable(sq);
 
 	txq = netdev_get_tx_queue(vi->dev, qindex);
 
@@ -5952,8 +5961,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			napi_disable(&vi->rq[i].napi);
-			virtnet_napi_tx_disable(&vi->sq[i].napi);
+			virtnet_napi_disable(&vi->rq[i]);
+			virtnet_napi_tx_disable(&vi->sq[i]);
 		}
 	}
 
-- 
2.45.2

