Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644F188580
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288887; cv=none; b=bbX+w0xE4d1NYO1o5pQveRcd7KvxdLkiKrVo1eaf1psb9gSS+swlP/H7v66fuetvB+WNfu9dtY4o2h4/f2oOiLECirLBkbz2zcMFti2K4EPmxfBpJzcBeP+vlB9JFPf5+7QEaLdJZzq8LnEnVtBf/v7IHqA6Ig8DRZG1HfSbF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288887; c=relaxed/simple;
	bh=QyB99KR/E5dyuun3oXDM9y/WJ8QG5my98H0Do5AE/aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew8KJ3p348pl3B8e100XhMkfUUTRH2kC9BfFzppCbrsoKFRDZpEX8BJxt7+lY0q37vPdi+SWA3l70rMfnnnMIQUwtfJ3EzpXFURJ91gdVjYRA4OrKTU3gNrLGVb3Ty0Sy0iMMrpXTFWueD2h/4C3ThrYUFyl0tb35rq9E2BTuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tA25twWE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tA25twWE"
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4CEDA40C71
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 05:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288884;
	bh=/pCx9eaXWcL4ixwAWHstQXvOGcUbbmljwAztWY9crP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=tA25twWEuEa95gb/WvkSsWO8gOpoK2ee1ZMjyAYQh17VuktUoz8bJtOHof0mf4Q3L
	 4NvsdkhoEYE/g+/30JzCPWuWpXHk1C6SBMkiLIs6EKEoj4jK+1KcKY4Z+2eMIaP/a+
	 Fl6z4rMQHjDuRetTqPTD56lkDC4hcCATlNakOszMiBCBVLdRaPm1Kq91B5HhEkGXgA
	 k+XmcwiI0ORKKIeFJtBmQIMOHXoVAnOcD5PIuJ5E7ky4Ua44LQzZgRIMisbyp3SAB/
	 UYMvjZ5jl0r4yKscS5UcS61j1jZ+zskpyL6B/rzqK9dfZPC0yAWhtwlbN2MydkJSB4
	 w0gIvRhQGEyKg==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5f1d3fb6bb0so3307328eaf.1
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 21:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288882; x=1733893682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pCx9eaXWcL4ixwAWHstQXvOGcUbbmljwAztWY9crP4=;
        b=G0obix4Nj8QbiNHrLK1tRfoyDx81fJNR9oN5TQrg7yv7Qmr2nOViegcXX6eLAnKLft
         oichWu6GRZn1I2C5ttbBraOryCQv1Bg+WRvGfqBGFJ/2fQ03FciZn9EYMrUZhJUhm+He
         OFeJrRCCkYQS57f56xINQy3nIwjppHY1bClhNtAylgIJpSBV7Bd/Bf7brfnf/o+7iLoZ
         RpydKqSLelwtBlUfWnGpJB/EBjAl+xKQ9035webyFVac+wYIT1IKfKUyK4IBUkF21xgV
         vpZlcUsW16DbEl0oyDoQ0qOck51KgXmWWVoiOt3RiylZGMZVg7R/GBxtZEOwux2BnPZO
         Z0Mw==
X-Gm-Message-State: AOJu0YzE1OUd8jvf15bbB7wBv60BTPwhAcWE4NxcPeg7JX7cgyXPcHp0
	KBZmv/EgFaikjCIfG5m2hL5uJIzkfuLMiMDL9uowqTOvGQ1dN8+HI+6kj+wEbouDHB57dpWorYN
	93vM6J/48Bvgtke9PAb2dO6JbeSKYdBK8qiKm+nzsCiTADvWfsex9dE4VCHfGDsMZ435QvCh9Og
	JR+jTDLoahTgSZ
X-Gm-Gg: ASbGncv+gGVt6ail/uE9Y+5ZiEWBZj92TAZZRovwJyube692TxRz/Rth2P+a2VpPE/y
	EKNDXMiyh1Wc7NcyXrMAlBGk0ZgjdseJF7EE0YXovbKpvkr7tNogW3mujs3gDDoaGY0xBYU6KeU
	nq/O4gt3HGUEAbGUvcjh8VKuXsihycDSoHnjM0ra8tPBgri78Y5rUvkQ31juVOXERMVwv+8m2km
	t5YBWkg4hph8akTEISjg33rzdSn60iMr0r5vt/91W0p6a6LeEJvzeO3GOceHAj7hNPG
X-Received: by 2002:a05:6359:5f8b:b0:1c3:38a:2143 with SMTP id e5c5f4694b2df-1caea790375mr503388455d.0.1733288882540;
        Tue, 03 Dec 2024 21:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs3DkY/VwOKGPPt8+iJ+sQPX2t2a1HIu9jL1g2fxiv2RrXsi55RCQsiq+IatRf8oAeRlGmPQ==
X-Received: by 2002:a05:6359:5f8b:b0:1c3:38a:2143 with SMTP id e5c5f4694b2df-1caea790375mr503387455d.0.1733288882234;
        Tue, 03 Dec 2024 21:08:02 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:01 -0800 (PST)
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
Subject: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq where appropriate
Date: Wed,  4 Dec 2024 14:07:19 +0900
Message-ID: <20241204050724.307544-3-koichiro.den@canonical.com>
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

While not harmful, using vq2rxq where it's always sq appears odd.
Replace it with the more appropriate vq2txq for clarity and correctness.

Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 48ce8b3881b6..1b7a85e75e14 100644
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

