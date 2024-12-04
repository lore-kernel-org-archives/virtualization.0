Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C7190051
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288908; cv=none; b=ZSEnofzRMlmDzakFdAk83i8b6xTzgx6CT93JYH0hGqjzNyljr9RLPn4NvR/Impvjg/hAhriInpVGwDqKZRuXaBcgebUx8i9qEyuzV4gFTq/frc838vSc85MrgJKDanf8JZNNtzYFpkT6+V+Hgo+6pojJ8/4GIP5Fn3R8LTSvk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288908; c=relaxed/simple;
	bh=pJkC/sg81thrf+L+DBV2A5EohoZuMx0x87sK8yW3WmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDSULIkH4qEbmU5xHoaqIMiyM1e1B3cZOBNvlWhMUiRVwRLouCB3cRxo4gNTY1C6RiNmfdHJf8W1czhqs1AcFxoR5enYbzDbrrg1Vvy94IIgntWhAQKcLT45RiORGWQYChFJU5t8HEFtyLLazwpMauY8FW0jB2atsQWYfsQxPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RNb3nZ/D; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RNb3nZ/D"
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2190840CE5
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 05:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288904;
	bh=9uM+qY4J1GQbqjmyDa0r1OVtoI70UH7O4H6kctiyohw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=RNb3nZ/Dju3MXmIt9xCp+I4QFIndzYDkC/bRwMxnumYQWyT/B6V4YBglTrwW+2Fk5
	 Bu53TcRURs+UlO1BUyrU33SvY94U87Yv/JG+N4aHh5QoaJ9hLrQ9un5y+qDxiBGDd9
	 x8M5gikXmBqbddu96hCLd85ieoaox0EaWlm3nAEr51ZX3zWBHGF5PnUKQl4oqPnvZ0
	 Ynme3mGq51tb4QNoFGntWjJJjApoX+ZgaMXvEL5IMcNWYdQmzeC2FSnYlm45QNmCpO
	 8EdM1iVOI2xsk2jS7aDN0Eo0KXVARkoqugQhxQWNMIis+nGYigoXb9boBpTLDazFnA
	 MPFKjfCLsCShQ==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7fc1becad32so4915480a12.0
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 21:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288902; x=1733893702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uM+qY4J1GQbqjmyDa0r1OVtoI70UH7O4H6kctiyohw=;
        b=iP+5QkEHTi4jMXtf7fRpQ/fhHMyvJL8IPU8gdLjtxFe7cGRP3zhPRimiwEy4IbajzQ
         scX+5BFmSZzJbFjFIwiQY2Oe0Jp9jSqyDSAKs29ozWtLDccEeEuw1wGYC7Gns67z+99v
         b+K3jpxdBn1tYe/QWErChBLsSQpu0dOliMvgWo4p6uXG6UvVDeSOlXGgSh3K8oh0JryR
         sr4RdOJx//Hgf0Ng6scADr4U5TsTAtE/R5R3/J5Q9gyndKhptb7s/OAQmkEEALuhVKtt
         EmSqYFK8CUHserEeXThkn8bSr/DKY7enTF59UbSyFF4iP75nyNU+HuC2ql2MkJjvSdGZ
         TPAg==
X-Gm-Message-State: AOJu0YwhsPPNQp+6eVs37CVsjtffnxNdgWaabrCuxsgipTquWPYCb/vk
	MsEaTHSX4lFMKUuXjR1ozDmwR6GRhTV599eJbEsaFPPZ5WTrZWaYZHhxMVxH3c617qH+F4XLGo7
	psSE2hEcRNApOtKOS76Dp60AQGDFv/VGWyXovPrLKZ6kFvxGV9rCttWWrcrDv9o7NHxXyDjnZ8m
	8n3XS992vvtfR6
X-Gm-Gg: ASbGncvmOBcusQUCATeKaIvigbeob8YBSnbTnNki70E8WJTWdBmMG48xn2zuqZsB3MY
	IYRaTAXM9tphoVts0iUzqxSqMHI6+XJ8zeBtkAt1Qu8ualhq/KtdCvsKoTgd3qwYz0HKc85+8Hs
	z7ZJw8mvTyd16Zz7ArkjwYTsTd6Z/IyNESJY6+1CzGq8QTKfJuXX5k2pGxEFGLL7pCUd1tmBF9r
	zhmhdM//hT4PzwAI3QNHJqjgerzEFRUQSPIEnGYlHG0iUjhWJWscwr6QgTCFKkYpxRW
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr8288062637.17.1733288902441;
        Tue, 03 Dec 2024 21:08:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtD8y79hadaHZvvNeugnEdk8crgadqfqLkx2GLITOJPtd6W8UtDItN+uiyqRlDo7jPSUc/FA==
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr8288032637.17.1733288902122;
        Tue, 03 Dec 2024 21:08:22 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:21 -0800 (PST)
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
Subject: [PATCH net-next v3 7/7] virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
Date: Wed,  4 Dec 2024 14:07:24 +0900
Message-ID: <20241204050724.307544-8-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset when flushing has actually occurred, Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
to handle this.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5eaa7a2884d5..177705a56812 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5740,7 +5740,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf,
+			      virtnet_sq_free_unused_buf_done);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
-- 
2.43.0

