Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A653191C7
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692774; cv=none; b=mm9bpN20a3eKxoxczrujhSdANd1NenLiHtTX//qMrV1Z0Df0ae42KpnLiFKh9lgZSsS8k1Tk7pQ5ZLDp/bSEEee3fJR6ygVzAI3DcNAd0vazaqjfFm4h2WLYkboQzHsQj3Nev09hwsVNV94RV/0+udzPW0OA3kgk0So0P5W7CvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692774; c=relaxed/simple;
	bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0Zqs2Sds9GT6JE1wSczpcDX7cHJmOOr+miv+5kLf7ShsA+HsaeJGvbZmE35DSODhmDFa9lsqK8+T9uFN+Y+VevxMVpXMIC/0pkTCxPxG4eee61ODKYjwt4J2Oldxfqmkq+2V1bXfdn+p963JWodvkHr0qNwlo+N0rICjpWYCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so2921948a12.0
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692771; x=1758297571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEyyDJEjHIGcptoyVMY30XDmajElEFVLCjxYGTHfuEc=;
        b=hLC7ilp8YSeIkNoC9oUM/2xfYqkmhGQYmRw8Vh4qHug1l5SgEiIJIAP0s1SjYw1nFN
         f4neKoHASG6vkIXxTpLvuLV/B6JvMXueqOv3JPGVkkqI+70Aw9ZO50t7kR0YW39t0H3U
         +QK9gdzdz5hdG8GR/+J+xcelSOjwRsCJtZbJnSveGvkB6rnk8bNjbeXOt5wgsLMTvlBK
         E6X99IwL+i+yfBsY+ELWUlq0mnC4anJS+zEn5DZS/xi9OQF/Mt4X5AdskNHKXbOEM2PM
         N/M9njWaG1GXl/ilWxJ6fM7On8z99jB+How9v9MI5dEk9YMh+f44GqjmrJup53lz7K1o
         9fjw==
X-Forwarded-Encrypted: i=1; AJvYcCUqy9IbaZy6VrqSdRnRujhBjCRu/lucmEojKd6MwJoZo8M0yI7GSBvBEBc5H9eCZ59+joqdDxedw/Z4VKNZNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaEVPi8HD+KU2xl1i6pAypz84qIg76Ssl2ALwvUwrVQJ9KqUaw
	rHI5NblOBRRFn8Hm2ckepYr4DVyFlGRG2PtjTIqIto5qZflVrAu2OMN1
X-Gm-Gg: ASbGncsY88IV3u5G5U7J/oNgWFqTRCntcdmEwstik+uV1hVXqQq9ZuilGBS3V7Es4bO
	4/Pv8DJpObxfcMh2YI+FYuXRou7AMZiVxcr4CuhkDNjgYwslInNrIH7qKo8yepZu9rRa/M7jqbk
	aqb3hI2hKKsYmWRjqw6nlBbr59AE4w2eIS3+IFiRvA0vE1/su3omACMvpD3xWEyF9LVYFGC2dSt
	LKyVNOJphcKdt9YQJNjoAVspOn55k9ICIr35T68ZysRbKpOEoU8Cooc0n96u0Mei4ofWIWeEDzx
	a7BlbpVATzErWn6EKujuXpBu3dEc9kQAThv41yJ1441V0zkUN/Ib9O7pOwVx1emHEu31slVX6zS
	obcY4S5z5FRDA3Qk8KccsZHxy
X-Google-Smtp-Source: AGHT+IFYMevSqL3g2aYQTcPeajtFC88rNpWFXEFv+GuBYebsuxBaKw/pWvRf3YPo2VcyVWyJ3BIZAg==
X-Received: by 2002:a05:6402:21c9:b0:62a:a4f0:7e4f with SMTP id 4fb4d7f45d1cf-62ed82f1ae2mr3557772a12.29.1757692770879;
        Fri, 12 Sep 2025 08:59:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec3400c3fsm3535438a12.39.2025.09.12.08.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:30 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:11 -0700
Subject: [PATCH net-next v2 2/7] net: ethtool: add support for
 ETHTOOL_GRXRINGS ioctl
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-2-3c7a60bbeebf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=leitao@debian.org;
 h=from:subject:message-id; bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENdlaXSNStTYTALXrlkCB3WTj0T/uYjCPVoS
 46LuuFRlZCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXQAKCRA1o5Of/Hh3
 bZSnD/0c6x14xLVVFlG64pkExebY/Wg2ha3v+RU7+P4AgDSckNdFjd3sgud6gCZeULklQRDh3Xi
 zttTYmxlWsfmejR88F64jDnaomxVzaF+UZwOZzto15KaaqvOspyvpbA5WP6T3xHDUHL4WV2vbmb
 vWFGe/IzHlCZdPU5B0vBdNwlmB/QLFTfX56JfykLT6zFLZJRCnsj91UhNVQr47Isb2f4L793B8S
 ERF70m9DRQu1m0Mn2HdE/wZnEbXRDyV5RkR6+w3AcSP6OiViRtvHTDLiM4uS3Y4+IPpuYj+wz4Z
 Hx9iQxR+VZZewRYLJTfVjymed9eN7AJeKQXQOqjfG4m35smM0lBt41Toz6W9cVT+Ab/iL96J/hM
 zKs7xXDe3vQt4XnibQg/rwrH3hO4o4j0UcktZxMUDFzx5L7Gp/scvIl7urffe/dEgN6AtFxx8AJ
 F6Gh8VwPh2GPqUr7NFJWXF4EELVTYHbvcwECm8/yhakzAmXkMCCHbEYO/vuezZSPrQf579CVOMe
 oCvana2YaCpqNtJ7gUE+/tytahAwDDyeZNld/PlU+TVDFVc9SyWD1qndUgZJ2TQs5g60rxzNez9
 PcNmHmQYVX2Zo106mKivcazwcbZdNomA5x19UkueevX0mJfVnf7pXf+aSYZct8lCI+gaSlVhwZo
 a43wKjrUKLHOn1w==
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

