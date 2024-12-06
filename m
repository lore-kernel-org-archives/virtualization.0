Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187813CFA5
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447516; cv=none; b=MOlDNVWGBR8wls79AOU5QxqeMxTwuudYBEWsXj847NA+QjRwzUPVJpLRRadvPlDZaH96jIvWkgrurNKZYSavCAVKy8JDvaFjmJiMbCf9C3I8RHWOaOTbbnGlljJDIQoJIP+F/H/LvUau9Q6O4mk+BlVFlHxQjzS2Z4cX9XKZ1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447516; c=relaxed/simple;
	bh=96Kfacf61eXHoKwnotb++f8dB1xgmK90ltAc50Mdduk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2onaTghhbzLoCZRtB9LuDz+zeU1T2dtZd32tIxvYv51aOeGh2Q+QZl1cHphJ/f5iXwu3MdYoChc6Rvj3rL/E3J5ZV5JXGgqqvXy83dDZlzRq3rFZ2S/A/w+zv+zE8fM79akqMxiDPLt1H9QP8wrSOcV+vDyv0XSM4glo2QyXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Wdbngrau; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Wdbngrau"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1ACFA40CD4
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 01:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447513;
	bh=nSlPIIC6AcIBGV2PkIN03d/6vzcJU5ZO51l3In2QAJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Wdbngrau2o6jInSCfNQKeuLtlWdOY2JrDy7CoGIWhi4zudyhF6+aerjog1YNRqR6L
	 3ArdLPDcAUM3xwSO8pCA1/OFBUAdDB60vymWwQAGUzUR6R2TSY0yIL0y7j035z1Fqi
	 m+MRmG4EtLJPD/eoFBQjPRteh4d5ruv98jB+KXiL0HWvpWYUnLyzR2mpSOz5tZJihq
	 mSOy60iCI46/c1UB/Jk7S7pOoXUO2VsT3E6bbxMl7thzSaBoaQdnXmHqg5E2EVRXD1
	 lQTpwo/LRowHQm3KdAEVk8DpJhyLjq06XsWKrU2HnEMB+DveXWbhn43eJVj6g7shEY
	 twNZfePNH3Nwg==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2153e070e62so17228125ad.0
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 17:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447511; x=1734052311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSlPIIC6AcIBGV2PkIN03d/6vzcJU5ZO51l3In2QAJw=;
        b=Bcasiix2+bUgRNbzZ9wHeEppG4kDZpSxnLOiddwPWgRzSY4d6bMEHnaxky5eBLlnmY
         CSso36Ka4bHXIMJ/t6pji9lEHSGWZnx6x1zYTWnd46y49GjvFCFKym4+XGdiCzvAK2RB
         OHkb6LK4uthPXSwWzi234oBQD7nb92QIqlFfM4oYh66k6DlQqTt6soaDhs02yOj8/5P0
         xHUl+eKuWmpzNYrU8XkkGbIb6C2DSxmx827DZWVqBxaEPnjzM0H8iXjDphEU6smQFjSM
         J2Tn3sJjPqyrzFYqtji5ErZAdwY7YjcbGwct07yI88J+SNCI6WdErSAA/rFPcVTSVf5l
         WOVg==
X-Gm-Message-State: AOJu0Yzr47u5e3On71bzYGJhnbeoVIsVl6VIEQ5tZiY2k+O50iZ9pAnZ
	j5i5X+3zCjnL19Us72zSi1IYEj5Yx9r9Wp8uxb8VTTdiNk0ldA+ZdiZdFw36Kce5WxFaLkHOJaO
	0xFPH4bIYvzIVH/pnAJABxQUs+myv86m+UqEg2BxGhXiuBOvOiMVTG6DrISQ6y9vIdWKR+0U5ML
	ORRa/heZq496rI
X-Gm-Gg: ASbGnctpXDO21hYDBHeLXPlqL2YQDaPwEtxVAHD5+XOBh0oIGInZDhgOlfq4s7ziGRF
	sX3p5JWyWs4PrfN2MocHkPy75Dn77VusNLw4iLmHsbxu7nxZ94xHk0ekPoZ6ycUz6H0ZHYQw/oQ
	ZrFgSSsXjQKF524kZtul6SdnfPyUKJyg1HTCCbsHXX8Nl+ez3Hzl3ADfzqbZAAdF04Kmkg/FJ2y
	TX5x4cYLJFWHjKPqBRzsuKTQk2W2VKQNYqEdfkQk35k07uL59o=
X-Received: by 2002:a17:902:f542:b0:215:e76d:debe with SMTP id d9443c01a7336-21614d1f258mr13746955ad.10.1733447510920;
        Thu, 05 Dec 2024 17:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKbHax0jjSvtZYTNxWpYl5lGbpKdIWP0A58s2CxR3vPhspLqJQTgD+Jp4LCBdjfkXKt7Ymdg==
X-Received: by 2002:a17:902:f542:b0:215:e76d:debe with SMTP id d9443c01a7336-21614d1f258mr13746705ad.10.1733447510661;
        Thu, 05 Dec 2024 17:11:50 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:11:50 -0800 (PST)
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
Subject: [PATCH net v4 2/6] virtio_net: replace vq2rxq with vq2txq where appropriate
Date: Fri,  6 Dec 2024 10:10:43 +0900
Message-ID: <20241206011047.923923-3-koichiro.den@canonical.com>
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

While not harmful, using vq2rxq where it's always sq appears odd.
Replace it with the more appropriate vq2txq for clarity and correctness.

Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6e0925f7f182..fc89c5e1a207 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	struct send_queue *sq;
-	int i = vq2rxq(vq);
+	int i = vq2txq(vq);
 
 	sq = &vi->sq[i];
 
-- 
2.43.0

