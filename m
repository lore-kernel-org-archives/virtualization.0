Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174B313263
	for <virtualization@lists.linux.dev>; Fri,  5 Sep 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092059; cv=none; b=dxRjeaWVNcZMXBjeTusW2ycITB/iXQuPHqB3yRAkfOKLJmI2gLiPYLWWNOTs1tD8BsnGmyuobby1Qhlw2/dEoWIeKEvZYHvPYMJo6WmMdhNhEyec024/0Y3Uvgm+cBLAET6jCGr4p4hJufPTEUKg9jC3P39IeSqUj4Itn8cpFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092059; c=relaxed/simple;
	bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhXXnhlQDtgeP+8d0VXh2it+/PQaSxthY9vUVkO52EHpa1pV8HNvDV11/DW2/4yZOC0n/03yeZefyGhkBQl7KAb8eiWbL77jX9yNcTOZFXOLFrKOzGoFBJHMXe7/wxP+vNIj/fEH8Rs0lbggNQ8diB/FwAV7+gdxBV+XckotzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so3831922a12.3
        for <virtualization@lists.linux.dev>; Fri, 05 Sep 2025 10:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092055; x=1757696855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEyyDJEjHIGcptoyVMY30XDmajElEFVLCjxYGTHfuEc=;
        b=KnqzaxhAdfiMK+kD6Fvhx47dRwpvGvzBuRK93igR+LNXJ44oJggBgakkTOayt8QeBJ
         eJKi9TWYp+tuN4oK44sSLsokkTuhmvFuzSxRWzEEurMTkv71TK9e/7SuvcEx6243MPsm
         lp6/PjrX+aOWct/KTKzjediFIjff8tlojPnzmOmc2tQcnQp6IeyyyNHI6+1kxQ/51Xbo
         9vlP1BxTUjb1YTF8PiW4B1kwbQ3KpRX8UaR9sOLijIMF4LKRWmd8qVwxwySGKNvRsMn5
         x6EPIVhI0Tf+wE0NdDEuCEQdEn3wjRkmK7HLr39oKOaP0CYUaUW5vHYiIwPITXkH60/0
         w7dg==
X-Forwarded-Encrypted: i=1; AJvYcCULYqZEep+HNecsyq9pYfh679nsu3fxhRMfslOBoSQfK9GOOtm+bo2RPex7bRUGZ8lvQ8oIo8M017ZE1VrUGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh3fE86B7ULH8KUBQHmKrubfp3JAhjlFi9j+jXUFb+vhGhW5xw
	wbxC72FneFhuCCBb/B3j5rzBfSWZHI629+WW5ygyY2QnqZT4DWEegC2j
X-Gm-Gg: ASbGnctTVo31HLqIkN5ByuVCYUR0aIaNOCwgEQCYyiNHFmhcqhsGuhSH5v4E/o4IRhk
	rgixT0OicbLSGVrXM05S/IcSn3IkSbpY5UOd5MjCJbKeScofT2zkiz5RAat46XSlgSRjMzih4/9
	R5Ng1O7VAiT+zvgmbW2sp0ZFS787kglVkhp1XWAjAv2Z2TASF4Ynk3IZCeByTlEG6HabPw0Uvdp
	YT5GlgxpRuHVFOQcZnskAudQ5Bj1+LTSzu/LNi1gzdAp61/JZ1oj7N46bSEdiWefc/e24PWrpjB
	knDrW8QLEEnBPLnERiO3CxmT3udxCDnR61nIMjNGH4cKid2E1dGX1KsdkySLlV/XViA9Cu75w5Z
	xvkqUexswaxVt9Kbbd/WiuEaE
X-Google-Smtp-Source: AGHT+IEfg3Ct5Mwvv/lnPzUvVsJLfBdreHP7EuqgYVEHTA4nIMOW1OT1Dw0Z1/X63bSyShxKFNfYyQ==
X-Received: by 2002:a05:6402:27cf:b0:621:b7ba:ef76 with SMTP id 4fb4d7f45d1cf-621b7baf1e6mr2475893a12.35.1757092054856;
        Fri, 05 Sep 2025 10:07:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6222f293a31sm886343a12.12.2025.09.05.10.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:34 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:21 -0700
Subject: [PATCH RFC net-next 2/7] net: ethtool: add support for
 ETHTOOL_GRXRINGS ioctl
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-2-984fc471f28f@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=leitao@debian.org;
 h=from:subject:message-id; bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjS9fofHaCc9nPoMTZDSSfsSJmJMtCJ1GvnA
 Qxd2Y9yuW6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 bZ7JEACoFMQE8XAyYs6lke3RKQquerpOPAyHsrhSfB3GwhSYDs+BRRZUODdEplnKuiKkLhf44VF
 Gv7mDEXzTZhUj3LnQ8tt/W7iTdm5P7uxVO847UtQZzxH1JnGmC9q+FlatzaHVYsYH6VzZviOdwj
 DJPTsJMOWg+V+gdJbhy6HVA14hs6T4xjse/vCNwV3MkTrCUvgHpQVXMGiB6LO2OGucUxPa7uUVx
 NkPAttShJ1EY4cq9n/y9AZN0nD+qLjqSEQThMl60TB/DJp/UnHJjDCVEGHWEDijAL8bFWjL8kCo
 4p8Qe0oN70ugTH3RTbdrGWpufzpztiYVj28aeffFRthLd+SqkRqGE3+Ki/w0fBu9kwqzl6slOnh
 qXBcRIGTOIQiVVlj8veRM4Pqw2t+GcTpjoPFjnpLbRp2R2c0xSpCkRqTmIMy9ZElWSCt4+owhJe
 JxH35AzY2iXkasbwLTnme9Vq2gGrqhigoanPB+6n3lHN7n7yvqW4TE1A6hOHpYuICKHatfuj2ld
 QjS6Jjn+sWjBtAKZVS7UFuHhmYxZkHGmYSEXM2XmWznL5/0g6cuYlAHAmoaJh5XFY8KoDyTg1hx
 vXVWDFwnz5dFCTp5yCjLu34zAwOUVKWbX288i7y9Zoc6AEtkYy8p0R5r69lQNV4wkCa+cPXUWi9
 0qPczFDz0KJMCHw==
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

