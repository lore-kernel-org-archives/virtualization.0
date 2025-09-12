Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBA322DCE
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692783; cv=none; b=YPAsUjYKWJPhUjRwq2WFhIW/rr+2WUuWyZxaZOMKKwQpzoAAYNHq1y75mYiq3Rl70tUzvjdQuvV8bgo3SILbYh1KCNMZB0aSKvQn73jS6Xs/FiuU6B6I3TA1twszHP4k00PwAtnwuz2w9R+mpeCc1TWtsQ6LborCRw3O4VbxuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692783; c=relaxed/simple;
	bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5zFFQKsjExnWKxJ5PUxrvzXymTBgIQDo9zbIurEyixPzGyKXj3/3wWFgvpgki67LmcC+3cRtUAbQUJwtXffgqNpw76AuL8cjahgtVqlE0kGLgKOd4qaBx6VwEmSmCKWeyWGxHtei58o0959R101kT+RjPK+6S60B6sErJMmta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042eb09948so443691466b.3
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692779; x=1758297579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0gIuHH4FHMvq9oSF/Jigf17pZ9LbJklvlGco8PAXnY=;
        b=ARgv6UyG+fJqk9OhTAbKbBeGh73PMJCfQTVuRau1Ly/tomHZ+Q8qeInvrmgvurdABz
         8uv1lulCloCECgOD+mwx9Di8alZPUIDw9d7/TX0BQgQpeQaaE53DL43x7VezKjBUMyY8
         ey4rXFbZz7AHC42H6ivuJY9RvvCI9ac6EJ6GMcNLdWHf5R/JUUDXl9PB6RT9nLNC6G+k
         ZEomfn5AZ1xMPooNUYF4H3E26oImL8puCQgQ5nGJMcbW13M45JD/GB87at9Ep7IWpB40
         7cSqw3IsTcEPLnm5wiC4Vm0pkngZ58PZBH5m+QFWf98hL2qfMbNcwGHWpa/ID3Ot0VD6
         FvtA==
X-Forwarded-Encrypted: i=1; AJvYcCXoDdbAb9fn+A4+xZbGqaG9EhtbHQubqdtHa9PnRD2rqizQCSqeNJZ7dsFAztK+7pC9UwRpgJ6tw72d6+skyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVrTE1d+1Yx5U0g9ybOFIUI1QH7KhYTOasyHxdIj9ExYiZnswE
	ReZs1G/nfjyryTRzfapW1Wivmdar/fOsfaRDYQ5Y8qbY03M80WLDwKwN
X-Gm-Gg: ASbGncvyJ60+4u9S4ybWIXuKrV8SRGlO+8runMK5hUVOunO6sAlGEams2cCG9Z+KThE
	+Uq92qSTDlOB9ijb1BJFqdsUb3eoi/0awDv+i2TQZipYIFKIJvPsy9Ry1jSxP67umwSg9SGBYWS
	E0mhX8kTIaigEPOl6wShtdOxSm1WHUoMX73NVuXDpocoH2DNJx12aaFvKQnFhX4STub746/Mkqf
	/3Y7aPoEmChmAV9+jlgLUmeCez/JT5TuTyLKHxEYDiWGFoyAEMK4IAN8oWEyQfVl257bIbMjTSK
	z34tSJY6jaqvjq4BeMNHBHwFSqp1L4oouprr6sMCpjBuLHIKVvWYp6v5e+C/P1tmJRPeb0sCv/h
	o4h4arDLJggzqp7XBsvlGVfeL
X-Google-Smtp-Source: AGHT+IENc4Ma8V5tCc/liKhp+02LKc2RicXHgsiwshsnplPzDX12vx98CIJbx90/d9q+6PULUumo8Q==
X-Received: by 2002:a17:907:3f18:b0:b04:45e1:5929 with SMTP id a640c23a62f3a-b07c35cd746mr359576666b.28.1757692778573;
        Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33f3c01sm3584285a12.34.2025.09.12.08.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:16 -0700
Subject: [PATCH net-next v2 7/7] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-7-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=leitao@debian.org;
 h=from:subject:message-id; bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeBFGi6WpdTS8dpLji/97clvQfo2zMjVoNE
 56PFE2cZluJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 bdEVD/0XB2Bl57L+rLumfG+of0zBhpBmxvs79I7Bx+mXlU0xsci+hGJzDcx3G5qMnEWiIYYrDMg
 ENU+pkKPyT7wLQ6HhaeQH5su1B19HWA35aqAhkbbJaF/GDSl1bhrAxMQ2760HBmXo4FAErMzz9L
 2x6DIxi70oHcK8swT6751x0MXxqot89K1pzgh2D7xgBBGENxY6AXvdT7zzWOJT6c63v2gH8Rsrk
 CjjfqojfPIP0aPVE8NbnmUQ42KigZXuJdNnitjTE1ok7ymYN2wZbRUMOrzSmuyJ5v4PEIa966KL
 HLzQ5BMb09bn+gX0W4U5XwZznEAEVgIbjY7OAvuKXsUrarYZ5IPyJY/2oc11MhFM2MaA36uDjmU
 zRpmLtt51vHyuUls0x0yU3Plx4WQP8RWMzZRG5KDKpdJMvQJKmKCuhtKFDsX7mF85FxPAKf72l4
 VoEcAUwIci3bBZdZ9wFU3CzpeY1Qlc+SC493uQcoYy7VR//qHNz4aUbO8rOaKzlermR9c6ChYdm
 8MDXoMyIVKGmmb6T0ayHbpF+1x7aUK6+5y1Dle0bu77fnCmGYI4A6Rn8hveuQNNPMou3SxPtPxk
 4ShbNEvs8CF0KN9N+RsYNfTLgvsmQpH4pzF99CTHrj8hUPcbKyuBSbw6PddAMO3Xhw5lzWVnBFo
 wp4FunMO4VxPSwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace the existing virtnet_get_rxnfc callback with a dedicated
virtnet_get_rxrings implementation to provide the number of RX rings
directly via the new ethtool_ops get_rx_ring_count pointer.

This simplifies the RX ring count retrieval and aligns virtio_net with
the new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84b..e35b6ef015c05 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5610,20 +5610,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int rc = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = vi->curr_queue_pairs;
-		break;
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
+	return vi->curr_queue_pairs;
 }
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
@@ -5651,7 +5642,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rxnfc = virtnet_get_rxnfc,
+	.get_rx_ring_count = virtnet_get_rx_ring_count,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3

