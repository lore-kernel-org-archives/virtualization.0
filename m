Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0E34AB0D
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103104; cv=none; b=C2U1l9QYG47uEojHF4tgBk8oHztwsNvW/FuXd4KKkv8PM6IrrmeJwkapaf9u0s10W58RQXTNBbhkTXE/TKaIDhLEx9i+buUNzdE9m9/iRjTNlPIm+5xfYfmq9MSNXBYv5PrRdy04Jr7Xmn0GeJD0kS9dlLKj4KrT/4EgHAcjdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103104; c=relaxed/simple;
	bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYpYxmHZDbbMrdtWu9q+MqX/b9p0xpQiLmNC8PzPbiYRyFF+AH5VgDOD8bAc/1ppTqmmJD75eWOTAgIXylBG+dAGLdFZDUI6e3OTFXrdU34LueOSQTwmHTS5oG3DBoRE33KQaEnHTgq7NA1s3JLCiy/cb6CpLAd8UQ0+BhWI8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62f28da25b9so5461742a12.1
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 02:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103101; x=1758707901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNdbybFK0ieLurW9tGv2v5Ky8Nf9YctW4a1t2pmLOlc=;
        b=sd89YJKLKGMsc93Hz1qDbtsaT8kwDJnzt4y/4RmSoSxyjAQI/CTTRsYGoXAT+hjbDi
         V+ZF6GmSnfYNTEBNjvsmSQSLJrOLlydIrsMdaT4wa0jKzdGqSmIONDpI1CKnzI5QUxJr
         mHkV1akT8O+eyHJkEPAJKxv8mgRFSrzo9epeljLwIPLpkJqMHNuFlwZL7c3PW4csyYs8
         GZjsV1dD1o7s3LM2ukCQutvi0WnGeTKBEuA2dn6Ek91AcxKwS2bZnJFLddkFo8Pbhu+3
         ra4MF05vgOc+NUoIAYcUDcXdweqbhphjaso2QqKpIkHbYVt6bPJHh7R1hJ6SN3BSLIC4
         lsGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5YS90CiULmgPELcmUV7mAH+wqR3eugnQtV2pcsGok1np3o/fQsO9R/RlQLuM29wfXnNtzLTLZKx/HdLlofQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1nlM2A73+SUWSpRm+hof96YtGI1gxva/qRqJfUGK5kXXf8I6C
	RsMU9dHAoNnyqQV/JTAvgs1Egn3WA18ae6yBLP3exZqfeb6TvQgQWgoM
X-Gm-Gg: ASbGncvwLZJXHRowxHOoMWDSSc/KJZwV6DWvKmAeNKtx7F9a2ObWICr3Y/JFEgaOe5U
	onl8/a+gWwEHCt5VzfF2XPRMQ6CJXwrZROAmKkH6QM5cE+KH8PyutUdzOPwnkWTXON6kz0c7SYG
	Yy4CkCu22sqiUBodWVGKOGUlH4Z+GKGOwEjiU8SwwV/Wvej9pufTd8DUwrxQc/J79YjfXahUp1Y
	QJZEFugBot+1cwlvlmM+yOOwY03vaRlo3PwkyoMjhiFmOAsKQbU0nIpGd+BbvZ+OO/WBrNgzQO7
	pqudi1xo9fB2mkRfgxY+HxmMh3izE45RRnBhjhZ6WmNRPIOKZKOQn+GIu6k63+GTPHlu+DRIop6
	QxB5dB62ueBR0mA==
X-Google-Smtp-Source: AGHT+IF9gsv9B/3Aw1b6/l4dkXEsvW7pOqKmAQvqfxUdHAIvZfVq35PFKiJfuHhddGDPZJBvWjF2VA==
X-Received: by 2002:a05:6402:21d3:b0:62f:26cb:8072 with SMTP id 4fb4d7f45d1cf-62f83c2db1emr1820018a12.13.1758103100907;
        Wed, 17 Sep 2025 02:58:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f86ecf183sm948650a12.12.2025.09.17.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:10 -0700
Subject: [PATCH net-next v4 3/8] net: ethtool: remove the duplicated
 handling from ethtool_get_rxrings
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-3-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=leitao@debian.org;
 h=from:subject:message-id; bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2NykJuwtDfO+7ts1cC7uzwJBFwIMlPW4jm
 PiXHqlFAseJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bTEiEACP/jgQA6Z2w3J5keCqjrA25kFufCckFxklkt0IibInyySwrZRb9Wecu3LAA6KJQKPRrjS
 PikTENRkF4T7PpF/0Ue6Gnu3ng4ao+WIec1MfWoS2qMlEr7gnNuvDRkPDpRlq2RJECJAsq03bKr
 xeCo3cif7l4Wq6KbYmH+6CFlcEULzPb7lalr5nBcvL24UedfPdidkZoqpbiTWYDWe9BKDtxPxJ/
 ZBa7dqAzaAsqFBo7pe8PASZ37Ij6InKNDIBroMW+xSfczLGCPlqxdkYVWvQMCElR7/opXQOavtF
 KcWeuJUCagNyiqMjXKEmz6VB9QU/PXp1U2I7YHbykFWUlP1OZa82xtgcjclEkPXj7vZkqas+HfO
 m1/aHDDGFCrtETam1GytzfFCeLSOVEHKyH5jUZwO2wl/tvbx7EE7mAHOahgYQ0plo1cG2thaL9d
 URO/JDy+VNm23sSQ121kuH9KS7qSTbCnK/pBpgJ+3mzPvcsNarMGnoh6IX343QdR1qVvDSJJnR6
 8uGxJL6D8jD4pAmnQS1m5Ni2QDl5XGEc4YzUwx4/73s8beybfs/zzHAJuojGw94ThlmyhZosS1m
 zobe3dnkrzM9m1s0smXKerzjqXhE6PmiarndwYA23MbVJqhxmxFdxz4H8/duNhxpml4eQayO/Ny
 LN8vq/ocCKgc8SA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

ethtool_get_rxrings() was a copy of ethtool_get_rxnfc(). Clean the code
that will never be executed for GRXRINGS specifically.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4214ab33c3c81..a0f3de76cea03 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1212,52 +1212,39 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
 {
-	struct ethtool_rxnfc info;
-	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc info;
+	size_t info_size;
 	int ret;
-	void *rule_buf = NULL;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
+	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
-		if (info.rule_cnt > 0) {
-			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
-				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
-						   GFP_USER);
-			if (!rule_buf)
-				return -ENOMEM;
-		}
-	}
-
-	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	ret = ops->get_rxnfc(dev, &info, NULL);
 	if (ret < 0)
-		goto err_out;
-
-	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
-err_out:
-	kfree(rule_buf);
+		return ret;
 
-	return ret;
+	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
-	struct ethtool_rxnfc info;
-	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
-	int ret;
+	struct ethtool_rxnfc info;
 	void *rule_buf = NULL;
+	size_t info_size;
+	int ret;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
+	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;

-- 
2.47.3

