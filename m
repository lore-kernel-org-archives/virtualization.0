Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EB26E16F
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682246; cv=none; b=TGxQBml2AnjOuxnfLlJHWk28Z1Hgw0XZHkfgQUDUVSy1QZleWB0+I+lSyXYQpqFb4Kot9CfAVt1JHyMPrCThpzT65aM5P2m8KqVSmqq6w8RWXAR5wGvDRCEfO0v6xlQdvAgAkW0RqD1gWO/OiCnU8WAe+Tnn2ifah98KIlEjpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682246; c=relaxed/simple;
	bh=yAvpgVVKv0qwVx/BcaJPPk6io7i8uqUMf303YSpg6Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGzhMxRLNi8g0dCoTsx0dhQtEX42B6DamoCSthySMS2HP4XBXBxXe870FCnTMIJL01Gb3vQUwSFrPxz/G+qB9bcbBD8mZsAmAi9zZ+Qhc58Hd0tncRJb9dL00zaeRznLxVc5cy6w/nzux6x8SoXsGKIl0YiI6d3ZyRMrtrr89N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KJ/0IClo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KJ/0IClo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22339936bbfso21832305ad.1
        for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 10:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682244; x=1741287044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=KJ/0IClooLdmpcYGJL/graZaTqxXAk/AZj/8Xp022syNlCrB1gXGAvD/g1MRuZ3laa
         1sdrrWRaPkn26cGlpXNQsgiCLJYSNaxCVqYpAB68duvzm7oNwUQCZ1dnBDcvwcX9atUo
         RTrNngjGFJQ/n+DG2sAkjNEULoJwqvHcxlwz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682244; x=1741287044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=gguDV+CyRkgz9WDz2jXzR6lZ7Hb5vQGnGFaWA1I/HA19u470bfspZt99wdQIG90Sl5
         ew+mbgzH6OzYEGPcPHd7b7lZX3m7CJBMZ5dgpNsg/mjsqR6gUTXfAVbYyLni8RKpT8kD
         JWhgK88J/UZF5XITq2OwddpKnY/ElGuDmi4QbfFxVJuyjSc9i7iyym36MeM8FGrgiw3Q
         thHmwEMbeV/Canjgw9W0DTwOW8sr9AY0XgSdAUlS+H/XwkSwdaoJZNkitj3yrhjcvusQ
         xrAj6VRkUGF1SxFe6gP+iwO6C/+bxtV6+g73hqvabxEqTMOPdXUA3LPzmXs7FEb/FgIA
         HNQw==
X-Forwarded-Encrypted: i=1; AJvYcCVmOTBWnzGW0T0A5TcPxSVm0Pcp8Lur17hypxH0NwDr8/tBKmx68dj59IdflIGc5KRJyGwRDEm71UrirVVZAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwUzuP6nchVXucjHKHqHA1UvLisscz59l29OqtEumD7nXmEiWn
	x7NSuIupSXKCE2C7nfVflqXudfj2Rk1pW64WlQQVCKjPUHrXLlola4ct7bJ0oq0=
X-Gm-Gg: ASbGncu5NbWVwYv+CDtf6CTiVKtCM3z/V0g9/RlHNehjg48yHWBH1q8I1blQ/MlJ/3M
	Wkerq940V1IGKw3wdcBTfE4amzY1SSeWgq03vTuQdL6S0WvCBSkr2ehBa5hvsoAZ4fmijJT2K4X
	WWofqQTxkrGXtsinBpsHiNarP3jTR/o1HUI9MPKb6Hl1ORZY3riqsKmowIl7FIZ8QDGZSIXLF6z
	zjZcSNhBhoLSef/sALJ8VTNa7HPXhxAeqIEXwKE2eyo8VDCHKkm9YcZ8rGjwMoRwz++SYMEbl8s
	/mw0+6I2Ps8bo8aGPqnRTxGX9d5+KQN9mg==
X-Google-Smtp-Source: AGHT+IG/mIbJ7+AwlpU7kzFyTXUYqGruYlMGaC/kiigMhtr+Deogz9sMy/ksGfgjZazdRJbKbvfNCw==
X-Received: by 2002:a17:902:cec1:b0:223:5945:ffd5 with SMTP id d9443c01a7336-2236925558dmr3548155ad.32.1740682243894;
        Thu, 27 Feb 2025 10:50:43 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:43 -0800 (PST)
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
Subject: [PATCH net-next v5 2/4] virtio-net: Refactor napi_disable paths
Date: Thu, 27 Feb 2025 18:50:12 +0000
Message-ID: <20250227185017.206785-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
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

