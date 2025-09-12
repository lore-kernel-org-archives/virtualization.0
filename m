Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD4321F4D
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692780; cv=none; b=PdYe9yQMuxnFOpyrJOezycCIkp3V2MdOLlRswLI2HtTZQvnizHyj1MkKq3KfIef8VQuqobGdFL8a0dnS+pyVTHJO6TRdT3c1ZK2gPEqCxyYTocV9R9sIAX9sljnPjdbwxdGCICNmkEQ+pdYS3CZ2orhs9HU3Zc4wWRYM1HnshvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692780; c=relaxed/simple;
	bh=+Cyg8fYez6TSqkQqySfOA53/MjPLqa4vHVdBzTfcQyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBlyhtQyq+nrdRv1rwEVxOKRFC/JyY0Ovip3+5sSvq3oM35kTcfmYqHb7DXOiOieSA5j65epYnjxUstL2kJuikJ10xpQvoW+Rg69XFtpC3+SPZJYT52geAVE+kniFvlVKs9XSqc9denCTEMIoXNASYcQyri3rhD1VWopYsj+uUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0787fa12e2so305387366b.2
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692777; x=1758297577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDEVJdYmXjRIZdNwmkm1CN0B9UrWr+aTfgx+0lOTdy8=;
        b=TOUA0BtZFb/vOuPO1m0yO1ZHkJSVhjv87quWOqotWKacUTKRwazlah0Evrk5HmmVkg
         6m9+hlIKFbJfiqsj/Qb6fiYgWx7B8WcC2c/yapip3yLTJq+yR0c1+5A5YdmGqDSrsbQM
         uh6xyf8T3L9UGa8dZCAtlSlV2zt9GNUjCwUoMCKFZylkS4P1j+HKaeT3VCZLN+ba+l69
         wuITjvZPPpvcvKyt2zQH5yzdIAWRcq/t61usYEmUByxPiontRBuYGG2fgfrL6stM+LqW
         g609/8KRKWPt2SyGybmZY/GxYWenuuQObS9RB2D/2Ixw1NIuUG9Kb0kE4IvxD9QKqnKI
         rGZA==
X-Forwarded-Encrypted: i=1; AJvYcCUjF1a1s5q8hl/myh1xduLbQC+MJpWuPSJCnw28xy1gxc9XY34xppx7j+IKakdXWdZ+XyPLw6TU2tNF0wImCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEZ9iCdqBzOSL7jLgephK1CSmAzH8PS1FWher86CdUEX1RLmB6
	cN7wTvBC9sq3+GehpFabDFt+KJE3S/qZTV3uPrGEtOmGF5GwaiWMm1lw
X-Gm-Gg: ASbGncup+lQ4cEyHcRtMxen0kA36/cR1QpD/Bq1dRgvWgE6N2qeS4tdQQMJkYSQuiNx
	YZSXi776PaSge/gxSceOV08R24Vf+WpS25Iyt7byuiR9Tkb7khfZQR+rsvKc83pASJR0r95MUC+
	ZzKyE+okkeDJW9eB2xDvWnRvtpwLIY0YvDMKe7IAC5JHeJuq0dyzfM5rYrDtPCE6iMVTie3QH3O
	AX9AW7HMy7lIp/y8cpm62B3nrrD8vsrU07Jki8TkLXaqyDJDQ1M7VleWN6r7s6EpNmJWlw/8+Aw
	SlKvqYGlVUW1IXsdM5XIs7FRfHWHQCZm2K/PlkOIhXj6r23zeRVH1II4n7yunPYezC0fPf7wqah
	STsadzQ6ct1OGEQ==
X-Google-Smtp-Source: AGHT+IGeZOJfA4BYuVq5HIBmnSMrSvhAZUV+17uTbGUeRylSUyMC8Q9l/3TI3WqxzCCNRy6BdNSpCg==
X-Received: by 2002:a17:907:970b:b0:afe:85d5:a318 with SMTP id a640c23a62f3a-b07c37fb563mr287410466b.36.1757692777007;
        Fri, 12 Sep 2025 08:59:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334eb65sm396246166b.97.2025.09.12.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:15 -0700
Subject: [PATCH net-next v2 6/7] net: ethtool: update set_rxfh_indir to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-6-3c7a60bbeebf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=leitao@debian.org;
 h=from:subject:message-id; bh=+Cyg8fYez6TSqkQqySfOA53/MjPLqa4vHVdBzTfcQyQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeV/U+AoSVBvH29w1x5dgjHI+lQxwjy7J9E
 oLedliMp2WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 baEJD/0XwL02qnUe6HDYNlGQqcQRWFgZHUKCbBy3LsFsKxavtRdpdQqqU6gwdgBSWl6krL0hWDK
 0dsvkqpzcReVpsyA7LZAr4TW5aKao8XHxs2wBO+LA1pAmr9qSjpJDhcwgmLBSMZlHpleZFYLcPr
 FRkMPSYglEJWGV9+rE4IpJ8hdKgvHDlTtohIa9r6YqpGvc3Qgq2Usbf80AWHJEUIhjavNbPIJJ/
 Iqz4wYohMKlNB4wpYc+3kV4+lX4PNzGOrvt71PkttsY+IZ2t0FCghEjlnlCVpl2wLihJFPJcg/8
 ajI4FSPvrO6qluUJyLY52z4v7muRi2h1YdIOzPleNmWid8DlyzT+7konNntacaoodEplEhoZypp
 J13opvchnsmb9T0yFUPoyj8zNL5ZA7XEsmmH/jgsZ/m5uWFbl0W9l8ZLf5faMGEaal10qM13lTT
 vGcHnzSlf+RwrXQzJdgSqpXHsUcEJExwUtoeZKBocGxEEiTtQBVcKnlJ684pNg+89Z9OdiJLjYv
 e2BV1XeATyu3vdTQkvvX0/YmYQAvlpSyh8GDI4qDKNE7hzFXZy1q69N5VsEXa9jfQQL6c5s8OI1
 2hpJ9Hf3YVeHu7QPdkLKcs+Dv41dn9/LAgCbSFvgZJdzoBvVVCQ0+3Ff67TpQvq544GBle5MOEG
 7v7ZXGc4YB+Qk9Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 01db50ba85e71..c95edb228c3b5 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1367,7 +1367,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
+	int num_rx_rings;
 	u32 user_size, i;
 	int ret;
 	u32 ringidx_offset = offsetof(struct ethtool_rxfh_indir, ring_index[0]);
@@ -1393,20 +1393,21 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	if (!rxfh_dev.indir)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out;
+	}
 
 	if (user_size == 0) {
 		u32 *indir = rxfh_dev.indir;
 
 		for (i = 0; i < rxfh_dev.indir_size; i++)
-			indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+			indir[i] = ethtool_rxfh_indir_default(i, num_rx_rings);
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;

-- 
2.47.3

