Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1335AAB0
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103110; cv=none; b=tSlGJz1E6lcnptnC2DU78qLA09YrdYJ68ASaj+dppTO8OjDa68Oam/Kq1TKf+W0Ya96uPeRIaOLt0WQmIxpaTy/aA26Gq2HSoXHcRfxX2TuivcN0kjCgKbiiBibOyV1jSlNYilbLQvAicLApkEQBecdC3QhXPVzti6DVv9pQpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103110; c=relaxed/simple;
	bh=Eu//yE4c+uDioPyDYhhWP0u0k0aovyGvDUK14dk6hs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lhm2Z6MC0Hick3SB1CgdBx59o9fqzEvD7bHpRyssE2JCBo7mOH8X+fQFp7hr2yPhwAtzyvyzkjEx97nVpRlUbwbVlfPFKkUZ46K72eHLTiu5l+YnsMDbQu5kNxONYIUDemI6r6G+w6ZNTQfuvst9QbRNqiJr+/j2M/xxy+2nveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b042cc39551so1069823966b.0
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 02:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103107; x=1758707907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/aC7Rw2Q/TRqJF9J43UBQHIqeXm4GXqxm40ob1/fn8=;
        b=sy55O8Ut0X6PvJheGc/fTJdCnONlufYjBRJEe7xEdgrBgzPTf7Uoeii+D68Etb8/5q
         mgFvpOJli6IcuJfTsy1YWd+68skrg3kCA20vfFyHmgqRs4VEUvScTE1jqou73BxcRoHM
         1vvgn0xIOt+RhPJGsay4clX3mPhesSodBwKTb8dCjwSmeq8Wy8uGe3A0V+De6b4DgcSk
         i2HBX+ZwyCSK7PbKNarrXehStpHPXtpu8ky/x/x5fW6uLNkbv6p6BLXTNgHjTl+RCvvU
         d6gPOvwRBbKmCV5mXbBfAcL7DdOoRveGy99GpyvskW6Vp0JEOTEdHsJCf+LwVvPx6nGB
         LWzA==
X-Forwarded-Encrypted: i=1; AJvYcCUyZoRIjyW0LHIdKhRtZVcSlfGFK+WugmWnLnP28SVaqdUkoXfEZohbpOxugXNtAIUzxd8Wd8iR/u+MSBz6gw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxrb8EYUh3z2bItBSGgGJ2Pip9AOlNFpZMDXVJt1bL6/2IdH1cN
	RVKiIeUdyO3lkvz/rq+YUK4FRc2JCNiunywlwNxDXJBP6tmrZHlb8JGs
X-Gm-Gg: ASbGnctPNlGX3wvSqwKu3+Oe2k+gBHfHrHfMYIYKD98s27JUpp4e8xA0z1hIF62sb5I
	mEAXd1lEcQ8sLaKHCHYscAxHZEB87omFSKV0UAGYVYwrlb+7Xq4oRyNO9QJPyuRmrpvArQRf1PT
	aEGwphRkq44prxo/ZkntcPNJCqoij7NLIIfoXIed6gxhaE/xKPxJSziSB2M1HBL55VJrXODTFQ/
	S1+x2r70dj6yvINLZy/G1HdNRfbsh8Wha3G6b33b8o/ktEGFki0O2N2Zfo1YSw0/+ppc1TGA/Nd
	wMe7fcgyG87iQ3kVrbWpbFbC+PGFBGmf1/8EJIEYMEPhdmeVIK8+KgdEBO8yqEeBWpY28VVRgY3
	WGUal3oNpyALWsQ==
X-Google-Smtp-Source: AGHT+IFj6DMREGMXsSvDFa/csIOwP5DwuveP3f5kUNa993jX5oSzuBltRcVkgzKCeQgFyexn7pJ7kA==
X-Received: by 2002:a17:907:7b8c:b0:b04:7232:3e97 with SMTP id a640c23a62f3a-b1bb9d0f224mr170452866b.21.1758103106603;
        Wed, 17 Sep 2025 02:58:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22b1sm1348076966b.86.2025.09.17.02.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:14 -0700
Subject: [PATCH net-next v4 7/8] net: ethtool: use the new helper in
 rss_set_prep_indir()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-7-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=leitao@debian.org;
 h=from:subject:message-id; bh=Eu//yE4c+uDioPyDYhhWP0u0k0aovyGvDUK14dk6hs8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2Tt4wLCwETTgcStetKA/Q6F44CCbtf2hWi
 cLtDjU+FJSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bS7+D/9SHuIXwZ310hb9JQXyJvLpC5awA9jKk58JusaDzMYU89odd39ehy+fs3bdIsrHMnI4zQn
 R8lp7d4VixExlPP+6AObZKyqY7740eRqMf8l25omf4bfhRZ9UnJQFLNTBWZdtOQezSprMynYRBD
 QB6gTIz0fFUgtaCdqQu/mQrZ9zgHI88rKE45z6pRFMgQiPYDt5NzH3Y9zy5XwCaa9kHqVrV/tzn
 7GS2KG37glBAWyjlriPrlJthbnd0mMImTrResKazp46Lx29CvAmpboff2jqUJ1oCD/Eex20axk8
 NwNJfiNyPzYkeG8hI1p+6jq5BRGS+svs14j3o29jYueSUUR9chkUcfPQ6YE606gW90IMUOwjSyd
 X6bWCyTl7ovTKt0XenErMZw7sqQmV2jjRHHfgx/nwgBKS9vuhNz0snUgaAc9ODQPvni8OTmsMCF
 BM7DR5C7c49n5pbBXCQR5PjP6VY7Im1PicMU8nvJdh2z/YAGQhfmbUgGky3niSdEVEP3qomBB/V
 qpNH3v0FqlQAlyk1IRP1BH91RKB0Qc/4DkF8AEQQmS1sooEriSPTNDV344H+scUtKFAVIav1Ywl
 o7A0nsYXzy10OvB223Kx0sfvY4m3sOLL67KffQ3lHOrm5lDMAPk7rmPVDTWRQmuPVSmeqoSFtr6
 kp8JlGa1LR5v36A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Refactor rss_set_prep_indir() to utilize the new
ethtool_get_rx_ring_count() helper for determining the number of RX
rings, replacing the direct use of get_rxnfc with ETHTOOL_GRXRINGS.

This ensures compatibility with both legacy and new ethtool_ops
interfaces by transparently multiplexing between them.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/rss.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 202d95e8bf3e1..4dced53be4b3b 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -620,23 +620,22 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
 		   bool *reset, bool *mod)
 {
-	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **tb = info->attrs;
-	struct ethtool_rxnfc rx_rings;
 	size_t alloc_size;
+	int num_rx_rings;
 	u32 user_size;
 	int i, err;
 
 	if (!tb[ETHTOOL_A_RSS_INDIR])
 		return 0;
-	if (!data->indir_size || !ops->get_rxnfc)
+	if (!data->indir_size)
 		return -EOPNOTSUPP;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	err = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (err)
+	err = ethtool_get_rx_ring_count(dev);
+	if (err < 0)
 		return err;
+	num_rx_rings = err;
 
 	if (nla_len(tb[ETHTOOL_A_RSS_INDIR]) % 4) {
 		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_INDIR]);
@@ -665,7 +664,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 
 	nla_memcpy(rxfh->indir, tb[ETHTOOL_A_RSS_INDIR], alloc_size);
 	for (i = 0; i < user_size; i++) {
-		if (rxfh->indir[i] < rx_rings.data)
+		if (rxfh->indir[i] < num_rx_rings)
 			continue;
 
 		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
@@ -682,7 +681,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 	} else {
 		for (i = 0; i < data->indir_size; i++)
 			rxfh->indir[i] =
-				ethtool_rxfh_indir_default(i, rx_rings.data);
+				ethtool_rxfh_indir_default(i, num_rx_rings);
 	}
 
 	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);

-- 
2.47.3

