Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63E35FC08
	for <virtualization@lists.linux.dev>; Tue,  9 Sep 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449464; cv=none; b=qhuVI3LSiAiEsa4SZRxc3fz2T59OcREPBIp3l/k8RHjp4QE/jpCkACmtLrTr2INzqufObSxiiBCQErQUyxJHrsbx0mZ+F15mjhqmg3gHoAwf9N9G78nw1inUGZPrZQ1kDe9Owocbz6qonZlS4bP6skH62q9uxq55Px3ReINo8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449464; c=relaxed/simple;
	bh=CeqI/CPfLt91GzhZXuIdCi7ZkDtyIbGKbbgMl5Idh5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JEbZYunCiufMuP93QuHYGdkZzOHg/P/9ln57GlgGtSQblSnr/M9EbwwTbP7pB1nZ1rQ/Lgq/Jg6vZRn6+0xnWyO7EnjHCrxA5UpurfI3PrcUOxLoMe7cEDvDyL5Vm9KYG9guWlxaUUDbr4FUYjeWZXssNS27/8izET7R1k4KgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0472bd218bso935919766b.1
        for <virtualization@lists.linux.dev>; Tue, 09 Sep 2025 13:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449461; x=1758054261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxdlD9Z0X49cP7JCYN5rg4ONGmDsa0/rUnEhDLiPlaE=;
        b=Z0RKNIXu+bJb5qiGpR5RvMZrCp20Jo9E1o4lo8ptbTMCR0evJf1AiVymnyCU9s6VRQ
         4GWgvphg1kQZ8i+kkmBYJnH+ffZi9/LK51pQg8wYmC2Dn2ovzujzAxctZbXuBcHejf6V
         jKtjBB4OsQiTuaHhmYjdEc3Oac+pUioi1/G5zcYokBznxBkF9WTXNTc/9HHb766ljEJH
         fADQ9txIkUvjUSJvh1O6/2fwdDUh6wfUoZIcxt89nSeWuWgdI2tqL+GzKYqd6Hl2EzsY
         jGMlqPK5UUMfozGKTLYDnBec32/WfcOy2mAFt+MDs5rRrgmxvKWCfo/MBJo9NBNteNBS
         +LOw==
X-Forwarded-Encrypted: i=1; AJvYcCU3EYlNHcckihIehgvqDTcl4SivZ5cq+3KeFGeCPL5Y56kc9ThXdjxuOlfttbrvD4UPD00fq6HE8m85Z3A1wg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9PluFN3WC9LpJi6JGOcuNoOhFCOQVLzAjVCogdnDrQG/Aogq9
	ELvWlc9ZQrEZpBleianpLyVSR6R+6IZDJK7q8q9YzIRBuk4Y5ras+15Y
X-Gm-Gg: ASbGnct6DJMxPihseWT9RYXJiri58ib74cvP5ixlhEBu1Jos8FUOudjXhyAwHJ1lDVr
	nq8Lx6oN+KD1CwA/1zICAHPIq2CIkfoa7hwdlTq51gp+chtlpc/kKfRXDJ7tSJNSrOKIjdoOkHq
	TXwRCUcBBvrFJS0YZvBa6S1vaFJscPoZwx0SDLu5RUx84c5NNOOtjyztGXxLO5VdDkopX0llDmW
	QFqFiNmer3TYCGIiuqgsn9QiIY/TIaZqWarXpPR+VjsHy1z1ffcdIjbNcbzsLonhv1ceGqGK5q9
	9ylmzSSXsh5xnYq4kJvikuEl2aj/JMW/C4m0btmWmtp5Mpzlry5ITU//U3D3Bv3tlp+KXewxirB
	214orp3g+O0P9td5BgupE59g1
X-Google-Smtp-Source: AGHT+IEvHg6ejivcaH5NOdw4MTljYAZ8L8hvnXX9lNaDU53Kn6RN02jfK8C0gO6q+DPkiefz+t81NQ==
X-Received: by 2002:a17:907:2d25:b0:af9:a5f8:2f0c with SMTP id a640c23a62f3a-b04b1476a9bmr1169147266b.28.1757449460980;
        Tue, 09 Sep 2025 13:24:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c0123f0b4sm1723412a12.24.2025.09.09.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:24:01 -0700
Subject: [PATCH net-next 3/7] net: ethtool: remove the duplicated handling
 from ethtool_get_rxrings
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-3-634282f06a54@debian.org>
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
In-Reply-To: <20250909-gxrings-v1-0-634282f06a54@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=leitao@debian.org;
 h=from:subject:message-id; bh=CeqI/CPfLt91GzhZXuIdCi7ZkDtyIbGKbbgMl5Idh5w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzuUfC3DsAQnBWfYk7VdXnbHJW09eWCxff2v
 A3+GGnwHWSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bWLDD/0d/6UdWDw0+cg3R92uXrdEy15HzJSwVFMzYSpA1tqbyQMvgx8OExFarvkDRtv81W/sq6V
 uH5tu1xdrpKjl2W4JyYvF7qyICgd4KM0YF9yMwQN3QJzRBRMbadbIWCeKBppbZod+/E1NrsSDNZ
 aGXx8NCh/KlgB/oit03vjvpdZ/wkjUqn4MUdDfoBTgus6Klphy9AV5mOgjxMfneVzeOjrRbiK96
 rHuZe9Y8D0lnTExxhyD2gbW8VycW5ROTj8hk5JxyEWCvTWrVJNxHT/4q2c6sI1sM1Z76sTlY1kg
 4IBUv8wHr6TMRNBXtBpFqDpo/sa5A0s98fiCTac3olIj0gtEhqBCnk5hr+ZLY3vAt70o91jpxBv
 actYxEgYyZf2p7nmBg3smRydIpDNIiMbgJgZ8JIn+RodQCpR3T0zEc5h7mgF+m0BnEbFAUvPcFE
 jy4X2oEw/KEVqZiOEb8Ijvj5EiHYIMZC8Gj6hB/hQiVNWOxUl449EZRbZN2YqOhQktzAnPqZGVa
 GlB4gxAaTZlLl3YT5GoOtce03m++JV9kvqYLBXA0GFd10TER9CvIUX8VMkzYayBTBdTtzHrvJbG
 6AeEdNl4ceS+JOJRfX1R/U8JpJmGz8sNi9xCgCEOhTtwaVAs7cRqVpGDiLhRGM3C+eKFmNNHeMq
 Tte36N9xHnwh9IQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

ethtool_get_rxrings() was a copy of ethtool_get_rxnfc(). Clean the code
that will never be executed for GRXRINGS specifically.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4214ab33c3c81..1a9ad47f60313 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1216,7 +1216,6 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
-	void *rule_buf = NULL;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
@@ -1225,25 +1224,11 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
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

-- 
2.47.3

