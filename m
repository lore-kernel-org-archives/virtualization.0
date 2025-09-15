Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A830101A
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933269; cv=none; b=jKoXt6Js0pNn1MyCZ2cDUF45CcgkBUAdSJhhKHuQfZ971pZpbf5n1Ba+nodqivk3ha+cYZmNAJwCtrKClH0Ms+tT3bxQKFmEnzWVFkTR2VCpGkzIIIzWLkuEWs+cByeawrkkQXIfJjVWKRp2oGv9oP6m/uFn8faKNN2QeLZJ2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933269; c=relaxed/simple;
	bh=b8e8OaWNtnadVIxSNP9KePI7AvW3rS2UHvHFSh890lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2huOzlkR5nlOQHNnnh9+EIEmSu1/8qLX9ZH3j540FHKXz3P1lJHQ2YpXWm/YHBQ9roY96nGqsGDRRlrMrmQF4KEaLE9NN2yNOGfRy0OcYo3EO2VSj3bbIReDYKyXDjvrzt3d1x7Mf7xbHxP6WAawfV24JmmaB9BTLGIuoO9V4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042cc3954fso727378566b.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 03:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933265; x=1758538065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7HyATeze4iHdtm3Jn5UcYkJ1c2GNNZC+W/TqjLRDmY=;
        b=N4fHJeyc/DtjQMri/BgBZPCBr5lBfcUBxT8AunCBydeL2TgG5AYG5QtnI5MSlWKLxS
         0Ch/94GVr5FvRaDPTQR6M5o8pKwne2vJLQDLYJ2nlkjyRbhFvLtka8SYUmVo8FYwctNZ
         qUgzaFI/IZeSE65Emp4/+itYV3lHbdXyQnG8zlCZ/04dr6Od9VvJI9Ag2PX0qcBSxcSB
         GfXv9TjiyqixIaBFbmf0Bbe0dhUZtikXV+Qd6JHLKWkY5kYQsbYaIuoEUO0jCM2XVlDe
         uQE9pC83KIp7YE+gm0T7QsmVZX3BZnJM2WdD/7Kl0mQTD/6G/W0z0M8o10vOQ5vTQaQO
         P0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX/xQU8BTH5MEjbu5VdPamV0BksZaueBMNbbDSWsIQ7xLZntDA2tnUGgU3+9HHugxOOCCQ0Itya4bKGbMdd5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdvCyh4N6RTzmAvFwRB8SaUbQ/Y6C0N4KF4ElLVmOZQwv3RDwZ
	RoSc17VH68ozmjXVcnwkDMerA++S20Rm1u4+bVbKTsci0PAKWIe5dGpM
X-Gm-Gg: ASbGncupdvUJwWc/7G0KncwQEUS8PzEcmK0Ru24zl/vRScoDdVEv6beMitMUDLiKu1U
	5nkloTr7lj7q5Oq+7PlPzbJoPF0ABrrEh4NbiGRYsgzCimSwlsaiu9ahPNtEkGSqrbGdvXR1fBl
	UjrB+TSZMhxEKWrqXhx9vwPHKpikQ+qaHN2Ru3cVRTO3Yx97k7upJ98EehYT9upiLBIsxM4iIQM
	vPgAnE+moVkEYpC3Y0ZA6jxTY2OtrKAmi5nqx7OEZfCxb/aABo1opQOlh3Z14r7T5Z8QuKwcgpm
	H8/H8LhxqPyMlAgaEMGcJe6a55fms3PnbcSl/avQdm6IGMLH/SQDqddoVCQWY0kOmMOah0bNl+2
	TIe/3hZfoWL2T
X-Google-Smtp-Source: AGHT+IGp/mJO2oohkJBO9wkXgeZW6c1+lSdmqvm9cI4B/RVB1WNWpeBKx1eZf48BYogf1YjTyHGKeA==
X-Received: by 2002:a17:907:9617:b0:b04:c7c5:499d with SMTP id a640c23a62f3a-b07c3833a41mr1095994866b.47.1757933265119;
        Mon, 15 Sep 2025 03:47:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm908527566b.67.2025.09.15.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:29 -0700
Subject: [PATCH net-next v3 4/8] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-4-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=leitao@debian.org;
 h=from:subject:message-id; bh=b8e8OaWNtnadVIxSNP9KePI7AvW3rS2UHvHFSh890lk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HwVVGDRCgyCtSdI1fF4Q6fbRHuHKhZJjhV
 IHl21NhkU2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bSp5D/4mvnlmyjVJSm/vLWnl0aLz3ZcZoum4iaB+BznlaOH0XVWCgGs4WSLKBBKjLB30Xlsg9WD
 NiIROe1uA/sPL2U2YRLnvW38W720g1vf+iFyDCiJ+/fYcc41l06bSIvtcxZdwezPs2JLpVuhwQf
 o86uQdBdPDsO5kg56YDD/j2W49t36X/KhVkDN23PJPPn+VFRvsLdNHSMDGO9fuc6gPFMRqyzNmC
 rJ7DOCarl05LOScu+uap5Xyw3kICe6fPMB8/zUQ07kXI96IY7+F5cTR0Ku7aHqgRiSKcXGewjhd
 bfYaK6RoTSLN1wxE708bBcfP6d+TVDV/Mx+DkG5E84b7RdVp0jssyqq+Pl9GDgW2Aqfkg5o8r41
 ntyA9eDoq9OFssebdIvQh/ZZMKbwq///I3dutP5BjH0sIDTv3Fr4Vrl2D5Lp6Ug10IBaRK4iseY
 TKt2DHCl7dp/ysGGtWHp0T6Mvl43v5rDFTp7CJpuzpeLFxs7C3xhAFmqyEPYPeVY/Z9bb+riezd
 wd5nEyvCRT+5HvntJ3i5S+s1PLNCuRCRZyCJuisTiSXhJeFGoGOgDFEV/Qc+X7e4IAtFY1kD2tx
 FZ+hObN5WQIt6R/citTQ4/JvZKvjiDmdjIQx6VExcrHJv1Tpq21gvC4AxBtlGXyV7QT50/hsLfl
 Q4I2ZEakH9zxwtg==
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
 net/ethtool/common.h    |  2 ++
 net/ethtool/ioctl.c     | 26 ++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

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
index a0f3de76cea03..5b17e71cb3032 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,26 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
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
 static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
@@ -1217,7 +1237,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	size_t info_size;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rx_ring_count)
 		return -EOPNOTSUPP;
 
 	info_size = sizeof(info);
@@ -1225,10 +1245,12 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
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

