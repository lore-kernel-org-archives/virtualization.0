Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D434F46D
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103104; cv=none; b=SXTOLZYXlgR+vhoIC/7iHi0KzxjagiPjwDbbUrF4H2rccTcH+EHoLViSDJ9cR3i+2GaCg6z/OS+UNyLGOAg+2S8gGGBafeMlESM2dvjTkmYugGkRUndKBGTPBo6b9Nzr5rBwIBH7gOgDXCqVAhrYI8XzcJkU2Wu665D7sRe5Lhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103104; c=relaxed/simple;
	bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WR2cJTTSkdxmscbnLyoeO5VYg2JtyDIcsc2w5Urbp3gKz05jdiCuuiM/OecuGOXUMgvv3foBY4fPu+7intDeBG931Sv1TsjJX8l13hUuYrLajyqXiSBrtzbS/rv+2i4yjdRDVebS+VBTUtYj4dwT4idxSofZyAkQ7rPW9W9BoiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0787fc3008so915779966b.3
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 02:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103100; x=1758707900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEyyDJEjHIGcptoyVMY30XDmajElEFVLCjxYGTHfuEc=;
        b=iGYxsBa+Jm0IHjmjcknjKnOe1nHIRtdd6xzwK1++zKgSomSm6BJ5jfpVeq++btADYT
         RvGq80pHEobLFmahZgz5Z6j5aDULhlxFxCPBAFUmd/wLRp+93NP3qGdqVmjttBF5O9tf
         bK/LbCmWvmsjVJ2/gr1BLLS+RsROTrDE+yPEC7Q7EimijvZ/6ch5RdY9X4CZmpWXe49H
         MCcv0BEkzKqBAcwe2LkJ0St6OtyMqcIwwgEdLMxHiH2C/RhwZ5AgDDC9+ypztfCabyPz
         cTOpzdT45cgSBjYQvr+5lUNBgQ797eMc3+G8y2wmmdsGUwo8t/TH1UyWHptB8Jy8L2bn
         fuhg==
X-Forwarded-Encrypted: i=1; AJvYcCUNxlEpbtjILlRTrL5Jx1xg9R3uar+1Y/iWUD4tLyauMUUKTZVtP/myl9xGLUfIviRAhuWRuy5VFbvX7ZjnRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOyNJ8J+SFVt6b91sAP7/ivYqbGVBynZCMCaS6vjHY6CDvdt2d
	wQwJoWcqPT2NfanKReP8dzAVL0l3JMNab39j1PM+cbDUQK669MIinDcm
X-Gm-Gg: ASbGncv3WKuVPdGOFgNpRdrDRD0mBXF+vYb64o44MkSdr65pinlU6uxoZqdZeIyi+pL
	E+XX5trusgICT1c+WQmTyTTsFoSHNmSPcQbD1/W0Uw/4N6xggW4nk5+cdnRl1fQMC6kaJETNlix
	CEHJWmu4y6kQB89GMAeZuzSjtvW585lnBn/Gk9DvwSCOX74ruLFySe52TOnKJhd1XYIorEJ2k8I
	Pj3VDeWcVqaVB9Weo6ZMLsqzMFQxdaJD2L7RyXIgy35GN4ebmCHB04UqTkQgVKgtHXQ95lBoyi/
	m7zqR/gxCyKTy/3/LVpfV+IE56ti3ysHA/zvE0Xe//UZIuf2w2TCXkS4sINQRcuKpiyjahOMm4E
	UN7NOs4dSIiQ8zw==
X-Google-Smtp-Source: AGHT+IFmKSMVHhuFIvQinupVyiUNckMKMb5lWYss0WThxAB0V4vANhmyHX6vXQLprkM//2EeY/ySKg==
X-Received: by 2002:a17:907:3c88:b0:b0c:a265:c02c with SMTP id a640c23a62f3a-b1bb5e572e9mr222242866b.12.1758103099498;
        Wed, 17 Sep 2025 02:58:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31291b0sm1343812366b.34.2025.09.17.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:09 -0700
Subject: [PATCH net-next v4 2/8] net: ethtool: add support for
 ETHTOOL_GRXRINGS ioctl
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-2-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=leitao@debian.org;
 h=from:subject:message-id; bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2AU9fNvTISS+beBqpJEDcxAHhVAhTAHCq9
 srn6uWzgxqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bav/EACG9P0Yxm8JP5TFsL1itesM8mMX5t+D87Z7fjw6n/bPC8stKFKiHf4HO5v6ao/MvPQu0c6
 a49OqGLI01YJ+gEMnKPZ0s0AaOGZsscXy9tIxTG+1SFZ3IThHyVa8bA7suuTJ00vfXfBxinTG6N
 /vQjRj4a+IA60KFNI89/iBpirfrMMsnSdDNMmPXcs6bQycFimuQEs8RZpCJC1JJxoT4Z4reolko
 ajaTnJ8EXw+lhqb4nx6wk8fDbuepbVVhkajeE0mSoNQz4hFJ69fc+stXB6qnluuG+XrvwisMhMw
 MgNzQVN+4DdcfxRZ+EJOWzGKyhg47SyLTZDKO+NwvJT0Wm9hFXDlAxWg0427Ba2zwPssv9vWFRT
 SyMaxhyNbAmHzZjndir82/49HKpIy9yGo2Nw/XyZLy740CSoZUnBLmxgykZf0P09szeo3s+yp1V
 9CnOZipMsiD4/cHsLlnIgZZOlrl5V2SJ+1uJ1LIolKgGdajfCzotoOWJC9Uqo85dIYaeKifvtbG
 lU07fl8zCdwmRGI8hFt6PGiQotMAlaWXNnAQ2WQdEKAQ/VlDuQe9npNeKy5cgN3GwD7pgN4PjIz
 RTZ2eRKu1NI8kZU9/pDXFoCiz7JRobHeYh4xaE2Fir85ZF8XlLt2dCrZUkgXEHIp92TG2Fnna2r
 ajP6h36DirNPoVQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch adds handling for the ETHTOOL_GRXRINGS ioctl command in the
ethtool ioctl dispatcher. It introduces a new helper function
ethtool_get_rxrings() that calls the driver's get_rxnfc() callback with
appropriate parameters to retrieve the number of RX rings supported
by the device.

By explicitly handling ETHTOOL_GRXRINGS, userspace queries through
ethtool can now obtain RX ring information in a structured manner.

In this patch, ethtool_get_rxrings() is a simply copy of
ethtool_get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 15627afa4424f..4214ab33c3c81 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,44 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
+						  u32 cmd,
+						  void __user *useraddr)
+{
+	struct ethtool_rxnfc info;
+	size_t info_size = sizeof(info);
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	int ret;
+	void *rule_buf = NULL;
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (ret)
+		return ret;
+
+	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
+		if (info.rule_cnt > 0) {
+			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
+				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
+						   GFP_USER);
+			if (!rule_buf)
+				return -ENOMEM;
+		}
+	}
+
+	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
+err_out:
+	kfree(rule_buf);
+
+	return ret;
+}
+
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
@@ -3377,6 +3415,8 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 		rc = ethtool_set_rxfh_fields(dev, ethcmd, useraddr);
 		break;
 	case ETHTOOL_GRXRINGS:
+		rc = ethtool_get_rxrings(dev, ethcmd, useraddr);
+		break;
 	case ETHTOOL_GRXCLSRLCNT:
 	case ETHTOOL_GRXCLSRULE:
 	case ETHTOOL_GRXCLSRLALL:

-- 
2.47.3

