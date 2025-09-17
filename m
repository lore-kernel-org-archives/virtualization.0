Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B579352062
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103106; cv=none; b=VKouMZ5x9cS+KdLDrhYOmVdSOjs/D9rSJvYMsegZH3LX+1x2nmVyD9Y8aLdglnQaKoMtdKkB0VQL14KHPPq2ZA0MqSUgSDVYYBF+tI7J72pFeY0H0g/IpVSDRTUcBX49fLN6kyidmntzK6H/oijDPDh2dfTG2pAj2iocIt4kZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103106; c=relaxed/simple;
	bh=9BWXBrWWV7onXdD5Y7LlmKabKEBZvRMEMewGpwrLXjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSecoaKo1kIE+ZjNHWf2bUu30s+d0NWqnWgztAM0+0NqTTi7XmsDt00jap9wUUtbyoQt25MT2rFiz+qpSDjUhJ4FuRcMtCsvwNT/08Qlc0vKtQNLbPWn6GOPmE2JLIGxDz1LYkZ7xgUCP1AMbmQ6pNn0oMe9VREFTdbQioOyqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b079c13240eso1038381166b.1
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 02:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103102; x=1758707902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQE6LtSTYqQ+c2iAKiSALM65Z422xxQgQPusJ9V+cNk=;
        b=O4MT8QFGsUW+LlksP+5r7c/b0aNo+zgTczwwpFQpNE26b83oUwUV9Fs5C1081gsCRF
         tXJPNX/l6QBspA5nVEomfsWTDEKtSMOyUJUXR0ElPWpAJXztLvbbR6VkSsQcIwd2Nay4
         Fi9axTkI+43mjw3Amt4CK+YMejePJuYgSOkiTE61XE3ADWcLo6v5Yhw5AM+EDgEoj6hj
         AkKaa7wDGLiPNsAA2JQ/i7v7gixLpWVSsdVHPjr1IAX+4hwCXdZJIy9lyTjCmmoN2yYk
         YWMbLaaQRGeP/fYCR/PB2kaMrWZE5+eLFom+qPqTd2Cfj3A8EBJNq7uY0Zw7iCEHIGqh
         s8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWIL+BfwhYBM0ruwluHyP2HYmU2guKE1VkEZzZ+mnCkA2fMn3Fs5KIwCNHz4OQXbVc61G2fcX7r1ShhMS5hPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4skp0yHaxVewTw++DI9HRac45S9iCTkbR6j4Dzha9/QRpJB9z
	ikwwnho9tE2cVv7AkSaBa5tptJyy+sCgc7v0xaU/laRKXyjUrG325ykG
X-Gm-Gg: ASbGncvoW0abi0Oj4PUBsJb/gWrvist4+K6Ri3oYfW/GsI4O4+pTJqeDlPq8iyPvl0Z
	W0gGyYyg1dCO9SDFQB8sQQI/KxhwtkAo4LilH7v5XWhsoUhm2hp9HxJ91AcH3zBz2hl7ZeT7qe1
	E2eNIw48h+1WvZNi8H2j5dTEb2O8JNOYTTba+Hb2eLoy/qQZd7rr9gnP/ydpqai4eueXG+QCSOj
	WB6kMDTUNkS27XikPX2cNPvKsVG0NBwgITHPA+eonMM+5Is6pAROFff4Patnitw80eR3o4ISB7Z
	RBCRUWFAnSJqpvnj7tPA7kepDHylDDKZopi3v8MawXEuB8p+k/zJR2Na9xME69YOyxljuSrGz7P
	M6ylBICipVdVSPxxDk73Jvrm4Gsk71UCy
X-Google-Smtp-Source: AGHT+IFYZHeYkpuS99ezHy5849Hx5zCbaZ/mp70yB1SouYyTWZlfB9hmErX2+QC6IjE/8sv5ghVFfQ==
X-Received: by 2002:a17:907:c0d:b0:b03:d5ca:b16 with SMTP id a640c23a62f3a-b1bb1020d85mr195258966b.23.1758103102365;
        Wed, 17 Sep 2025 02:58:22 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1355607166b.83.2025.09.17.02.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:11 -0700
Subject: [PATCH net-next v4 4/8] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-4-dae520e2e1cb@debian.org>
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4083; i=leitao@debian.org;
 h=from:subject:message-id; bh=9BWXBrWWV7onXdD5Y7LlmKabKEBZvRMEMewGpwrLXjI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2z5BhvbZTvHZ0JxV+ekm87PIk4x54Ip06t
 oUdH2g0FiqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bb6YEACF3NEx/MdQVixAhaypqlYSJjboYzQSEL7H4+Qi0P8kmF+eQyQQGRfn/z16qCkhVD5zCXX
 UszOzJgYxDwizcOHv6WY7QuCFuFHu7J8jwMzYnHtdby5zXqQEpKyAwRURED+aPwil2ia90IrCzO
 CGrpsr4Lae9gm8C20Yv+Ac9jHzFnRmRt6z/1fAbbvSJ55InJFCXOdGx8rcscp1McrHdTNIT3VQ0
 tjIO3YzbJOhXDPmUlnbj5asrMXzrciHA9M+H0RlbZbDiiYAUs4U1juz93nWQfQMwUGGoVBUZIjC
 Gm7b2gapXFugXHatG/8tcpXyeP+jTxON+sg/0YWFp7ZMYZT3+cq/wx5+6zTb7MphxmiWrBjEZNJ
 MdPec5lJ/es2MFtHVqYl2/0EeQOSZGs69AfZTv5keDG4yGYWaN2PzBNDsX+9iF40XsiyWkqs+0X
 1t/qSCT6nJxFke9yYBunf9vX1xC2hjsipmdJQLMCtC92QRz2Lbt7NcWNYcM7vLbxE29k9ttyItq
 t5pHNUqPIhdulXbMN+hQr2EKlPVFuBIxez1bbPseyj7Nv8/4AGprTMU6UnsfZyWA/YpSGYIDecE
 xpc5nLTB3N2J8NSdbwj0bFz4m3ptkd/fI6FuNqYjPWUXyl8XQjX06hncOqAwP0czWAQmNGcDF00
 dtJlcJ2RWCPUCVQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rx_ring_count callback in ethtool_ops to allow
drivers to provide the number of RX rings directly without going through
the full get_rxnfc flow classification interface.

Create ethtool_get_rx_ring_count() to use .get_rx_ring_count if
available, falling back to get_rxnfc() otherwise. It needs to be
non-static, given it will be called by other ethtool functions laters,
as those calling get_rxfh().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/common.c    | 20 ++++++++++++++++++++
 net/ethtool/common.h    |  2 ++
 net/ethtool/ioctl.c     |  8 +++-----
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index d7d757e72554e..c869b7f8bce8b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -968,6 +968,7 @@ struct kernel_ethtool_ts_info {
  * @reset: Reset (part of) the device, as specified by a bitmask of
  *	flags from &enum ethtool_reset_flags.  Returns a negative
  *	error code or zero.
+ * @get_rx_ring_count: Return the number of RX rings
  * @get_rxfh_key_size: Get the size of the RX flow hash key.
  *	Returns zero if not supported for this specific device.
  * @get_rxfh_indir_size: Get the size of the RX flow hash indirection table.
@@ -1162,6 +1163,7 @@ struct ethtool_ops {
 	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
 	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
 	int	(*reset)(struct net_device *, u32 *);
+	u32	(*get_rx_ring_count)(struct net_device *dev);
 	u32	(*get_rxfh_key_size)(struct net_device *);
 	u32	(*get_rxfh_indir_size)(struct net_device *);
 	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 4f58648a27ad6..10460ea3717ca 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -577,6 +577,26 @@ int __ethtool_get_link(struct net_device *dev)
 	return netif_running(dev) && dev->ethtool_ops->get_link(dev);
 }
 
+int ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings = {};
+	int ret;
+
+	if (ops->get_rx_ring_count)
+		return ops->get_rx_ring_count(dev);
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	rx_rings.cmd = ETHTOOL_GRXRINGS;
+	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
+	if (ret < 0)
+		return ret;
+
+	return rx_rings.data;
+}
+
 static int ethtool_get_rxnfc_rule_count(struct net_device *dev)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index c4d084dde5bf4..1609cf4e53ebb 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -54,6 +54,8 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 			       struct kernel_ethtool_ringparam *kparam,
 			       struct netlink_ext_ack *extack);
 
+int ethtool_get_rx_ring_count(struct net_device *dev);
+
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 int ethtool_get_ts_info_by_phc(struct net_device *dev,
 			       struct kernel_ethtool_ts_info *info,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a0f3de76cea03..8493ee200601e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1212,23 +1212,21 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
 {
-	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxnfc info;
 	size_t info_size;
 	int ret;
 
-	if (!ops->get_rxnfc)
-		return -EOPNOTSUPP;
-
 	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
+	ret = ethtool_get_rx_ring_count(dev);
 	if (ret < 0)
 		return ret;
 
+	info.data = ret;
+
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 

-- 
2.47.3

