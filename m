Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6571537B9
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447525; cv=none; b=Xc8FXE1II0wrdsrHN9vHFAxfMM9/1BuBcyLSU8QFPYi5sNPJHHh5KwxxrLc9jbGcXKsezefFQWGxfK1jsO/StKg+uKWvz8GYEox4HlVmaeUi2eNBOgSupg9jZYrGLE0BUqJtiWdUxUQyyWh+mgjaBJwMSAnAYAqYrI07KpyREAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447525; c=relaxed/simple;
	bh=HSdpSrosBpFjoXoHgEPxOFMdxecD/sTFHyHuYcmRo44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCgH9eSyltu+JDypk+CGztGJ2q52z/UQzvXFHaoJpMTcDzJaeNyjtrbRccya/CEntHEs0uBl0OO86h7qJk+3+nhuIFTAR4y9vaFJlZDLuBgcur7Ko4kVWqfZ9Vzf6w9LwS+Sl+nlMoku/MSoGOsna/shPaEFk1Lk6K9JIYWnJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tbca2gfv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tbca2gfv"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 49D9540D9C
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447522;
	bh=3okZ7Dk5bsE+ZlwnvoQtqX4jE3/LzcC69p28rg/sS/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=tbca2gfv2PwPq0DU19SM1pmigc1fn0BZaJvbxBrAJMD3swtG4VWCOvQPozh5UA1AS
	 M31/yHYVuq0VqFg1BH+mUEu4o15cnyyVILDUj4WUOIK3xslNK8mraF0RBJXCIIMUC5
	 QgDe9sMs/mFs+Yf/LRbHO6tqFuzr8WgxUuBUzJgYiJFCshgOFnzhIblluovSwPVZuD
	 ahyd4pPdc6i4PQa5pYeTugFmA9nomhNUsDSaZkT0WJUYHkYh2HKNIrbKMMFVQeZi9J
	 wMErPd1BLaiEHFQWOV6mepi9M5fzE38e5mVAQFGLfSvGYrSdQsgawkOIqjVT2V+IQ4
	 U4SOx1Tt8mb8Q==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2158c589cd0so15529615ad.1
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 17:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447519; x=1734052319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3okZ7Dk5bsE+ZlwnvoQtqX4jE3/LzcC69p28rg/sS/E=;
        b=dmxiLgQ2FF3suh7j6wewNJTez7aPtv1SjAgt4/DrS1Vl740Pe7pSENpkoL/g0dEBUb
         uUz8hslmKZgv4cp94lmhxXBf7UloVY6aJmpfvI/VCpo3xA+zrFSEIrUp6vOVorSXo0oL
         fXtkKd3JGHVDQjxwI8Eeoh2yFVD3/lmxj91wHpNQkPU5v0T8zhvvwphTxD3yIbP22E2I
         W2qm9SGoQYB2u96yikNaHj5bdatE4V5/yW6z6ntXhIWxZZTwzdaMuYhhvZbM0MxAgvhE
         vHEeijzAodEVXkN6GdBOmqiaDtUWacchrSqYEqatI1EQxZPgSZgSwC0CPg5PU2fjuU41
         ieJA==
X-Gm-Message-State: AOJu0YyZK988E5Dw8qqGxEr1/n5EwmKExICrbIo1VfheAbVQZGm7OmWx
	nZ0iuCaSFpam9f7rZOi3eY5RYUuDpkQGoUb+0BzcK7TEtRlm0U6mkOdwNXPOWMMM3a4GrzNLDjV
	iMlIv0riIrLW0/fioTU5avGzjNtGxeWnPp5bPYkx5U7ncmXhWtdLlX0P55g05EjAuYHy6MkZjU+
	P6ARDYn6cKIU9l
X-Gm-Gg: ASbGncvvNHZQrRp7xQI6voj2d6g5OYuQmmal/ExWeObccDTeHdmS/gf7wKsiMHw5A2O
	G4pZ+sITPUEYxemNSHhtx1QM7sFcgzPKfGsGO1KPG87mJHhvLtQ6ho2ZYW5ODGbUs/+DA6k/OSj
	fLDYKSfhpNeD95K8R6qsr6HJbqy79Eae3WlFqraXYi2+ussCk+oFWspra2ig08uSpznfhkXBLIB
	z9Enbmw3tNz4mskZiKSZ9taWs2ahKBZ/MJMSioU5G64hg9FVUY=
X-Received: by 2002:a17:902:f601:b0:215:b13e:9b14 with SMTP id d9443c01a7336-21614d75a53mr12429295ad.25.1733447519046;
        Thu, 05 Dec 2024 17:11:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQJN3aYvWonWOaVQbbwag0krwaPJYzGL0PhqRtYyRPCKfavtSDhMd7s04xv5fglvYMegTrDg==
X-Received: by 2002:a17:902:f601:b0:215:b13e:9b14 with SMTP id d9443c01a7336-21614d75a53mr12428985ad.25.1733447518781;
        Thu, 05 Dec 2024 17:11:58 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:11:58 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 4/6] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
Date: Fri,  6 Dec 2024 10:10:45 +0900
Message-ID: <20241206011047.923923-5-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
References: <20241206011047.923923-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
be reset when flushing has actually occurred. Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
handle this.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e10bc9e6b072..3a0341cc6085 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
 static struct virtio_net_common_hdr xsk_hdr;
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -3394,7 +3395,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf,
+			       virtnet_sq_free_unused_buf_done);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
@@ -6233,6 +6235,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 	}
 }
 
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2txq(vq);
+
+	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
-- 
2.43.0

