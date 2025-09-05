Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65F30B516
	for <virtualization@lists.linux.dev>; Fri,  5 Sep 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092065; cv=none; b=rvEm+fOTBbxRkQ3pFbtWpWRtJqo4zrnoKn6eGzG9SuwKFonIEwRW++ApjqRtF0nenA9kyXWOkETgNHIJAfpaPDr2Ktpi2AqXo8GwNC+bzX0NsviEiCq2spi4ejgmdk5/0lFCm3vAxon+LRMJU6N1lxqMRhv5UEq6Dp2EqcG2rKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092065; c=relaxed/simple;
	bh=sroc+RppV1M6H+TIsJKRX7fAwebQ6S9cC3k5ypJgaso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ud1llj9HTgK06QSNJJVX8EjXibqjBzuMHmQg2wzjMwvt4l0mXdylULqJHZ6snQYc3tUSyhcyhstAxq0sE03MA0f3poDxkLYIlASpwd5+QtkUf4Jz+v3fZn/G4JrdEY+maaBQr1KHlPft1hupKviZX3InfXi8ZCayvi2cgDKOy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b043a33b060so388504866b.1
        for <virtualization@lists.linux.dev>; Fri, 05 Sep 2025 10:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092061; x=1757696861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WB27QbpegxH/pdun83Mbz494V3PtsHtvy0S+yeujRvY=;
        b=Eqaz1X0u+osAHsbWrAIF5OVBVhc5xgffGIP+qMF8UFT6vAFT351ubwUIWxWqBC/cY0
         s/Djv26QnhdN/N0qk22ZKugfkTCPdzOXWuSgHHvWE9fFtN2jL6RdMCXXyAj3R1qTp0Hv
         i96nosWnYRYyRSXKof5Mzyu2Z+YqvzhrWdC9TTNt3PHS1m6VvZCjqWs6/QnkumR9k9CZ
         6hJq/bzeuJKGUMB6xyhxLer7XeAjbRWdrh/dOTJFE29y2/NncQd1R4/3ItjjBOXQ+oEm
         lsNu3wQw2RamyumpO2u+ZV86MkltPPIEElCadhkv6pPhMXjmYumIWy3vJsUUqhzksSoQ
         PpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIM/oUuQUroD0NxWQQ/isiYWZEkrI7t/LSjfcQyG6DywT58hA0Efppa0oQCWgV27iC+DAfDGz6VEvZYld2ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqcPcaZ/x3txxMt2koN0M062UvEej5gviMPU99DvqXA/0CZJh/
	BxWGpj/SmquhYyjcNiF0t0+v4PeEk9+EYL+hYLWJEJ/6iAzvvlAPAuPuveYMsw==
X-Gm-Gg: ASbGnctMQyO+GUdJBPdLBGwIjRSvDDRYhzUssHgTZJ7h7HTFpujXbcn3w+OBwNso+3F
	fJabN5R/OG9CpGNc2DLRF4ln3nAyFvVdUubzutuXH3YGZb7zj9BeGVzCVWvNzG00d78sy9WKvRH
	w6zL9k9FszIuo7UzbiSM0ux1f7VWbt+h42XFQW9eb2h5G6VmDOGTAVergcn9xeQtb8F5Q/56mwj
	zVqQzLkFeUmxtjVlPE3VcyDeKM6iXijK1WUYivyYtRDmC7lIo3NB0f/RelKKJhS2AUpwzKEkZGy
	c4eViAerDdGaDJVPg0wwnjggxncSP6S6kQwpJ49DBU6wMkwD5O0IZ6FNiqSQUCx7QBbrCrLmjil
	C9NDmsbiUD2HN2A==
X-Google-Smtp-Source: AGHT+IEkBpUVtO8y7z6mSS/qOlXkeoTLptQaKSdIMGlkvuGLpdfe1FLEyTDL49ho2pOVXAdSfYopkA==
X-Received: by 2002:a17:907:2d0e:b0:b04:708e:7348 with SMTP id a640c23a62f3a-b04708e75b4mr1064208866b.30.1757092061372;
        Fri, 05 Sep 2025 10:07:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b02152cc1b8sm1602638466b.36.2025.09.05.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:25 -0700
Subject: [PATCH RFC net-next 6/7] net: ethtool: update set_rxfh_indir to
 use get_num_rxrings helper
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-6-984fc471f28f@debian.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
In-Reply-To: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 jdamato@fastly.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=leitao@debian.org;
 h=from:subject:message-id; bh=sroc+RppV1M6H+TIsJKRX7fAwebQ6S9cC3k5ypJgaso=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjSKU6lgNhuZGo6wKBMO2msYpL2/Fa+SIRns
 9e1AD7gvDiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 bew6D/9Pxn6a4MJUgaAelp2Jvwf39pM8Cp8W1AfGBj2lmIJbg+j4d7oNHtxRxq93vaGnnZK9gNb
 1Qf2MAc4m2wx5er2xyEYEjvm3g6H3ntp0I2ZEbxzN6pDeGfHEKx1nRvKuw9DUqepUen04/T+BA5
 XmciqjcDeOf9SBvjqnlMfnrNZo75xeKq5T9uyg3Zq3vZJ9/rz7UZm9v36iq1FzZxJ4DoTraBbLR
 g6Ln6iXJwQoxaa/1aHN17NzOAZ4opKuyXEJtpX8E+ssxnKOIn/w6ArSGP3YUjxu4FPoLZRBUc93
 ibavi5cAVk5GR6GZfEDe8Yud2x/zstGRvDthHqLdLZH6D/h2MeyrY8Cggn48tqLFNmKacsuAmVC
 zZrxPZizGYlZkgi1aYhHjRXe7MJbMsuK73uX/OrhuYefH7BY+TqKpmaciFGd4UKCU4QXx84P37j
 1wWrSISGeqqmS+978jiGO4mtIS+0qLafPE3dJPTOMIQzDc7gnXrPTMH+FJwOGvs9hfHG236Y5p2
 jZsc0b8GoGeMdTx2x7ZMu185VKB/q5u+OnpCNN552wOUEDvsS1GTJ7XUxUx0JXNB5R+pSzlH6t/
 ewPRoYQ0muxDpaMVFf8kjYW7E0cps9uFf1lVL4FdQnmT5BRzaMDhbinkqHRM9cbk2AGYkiEV9qR
 3zKVJ/ClWzx732A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new get_num_rxrings() helper function
for retrieving the number of RX rings instead of directly calling
get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index daab20b392f7b..b8d85bba48329 100644
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
+	num_rx_rings = get_num_rxrings(dev);
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

