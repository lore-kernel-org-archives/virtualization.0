Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586A36C08F
	for <virtualization@lists.linux.dev>; Tue,  9 Sep 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449471; cv=none; b=UBPlALm/j8kszOFCic6D5eLgRb7ShtPL/ixVWDolKYe8XHffTM3ySCaiLJAVUDR1CzMMa2pYQGhsKmWR1eux3V6I16sgAAZ2yqXeFizHPxM4ghacbVo6gOv8Glj29WLBMan/gpsZhhINUboDuNjUtETU45mJHacMT6JoGmOkGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449471; c=relaxed/simple;
	bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEsQKR4yCJzuyWUVKumE4yOoWsLgoebspixujlza5KVmfVys6XuOSH2EV5f/kdciQgKaisJfgD7rReRfY7HpWzLUaczXnExIylMWjosEU+gn9AmCxgumBG59X8rFkmDbqYx+xfkcc4ZjJa5DvLrQUPFsvamx4bqdyyfzSRp7KrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b046f6fb230so258882966b.1
        for <virtualization@lists.linux.dev>; Tue, 09 Sep 2025 13:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449467; x=1758054267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0gIuHH4FHMvq9oSF/Jigf17pZ9LbJklvlGco8PAXnY=;
        b=GHtped2UxxqjnFCQW95jONwhaE4y2O+XpjQwk1XIbUsaj2SiV4EIRaosWYsbjsrQgr
         4DQroZx0rgYS7VGdux9aX2uY3Y6XObNfNafwIShxz/rJ+0l2YLZNJR/wX59YA5Seia92
         cGIBvNPsu0e4660YPqs1POj2ONIM7VFSmWwEsJ5CQw39VpByDL8LIefK4zts1Mvh7jQm
         vAA0GVgFuHfbb+htm3w72W3JO0hfw+Op2i8zYuRVCx2H/AUK20dn7BcmTG4heWNHAf85
         hgEQG9grrBewe24KeFjb+/aDIdIUODfUpMY8UTkommTKkuZ2AoIbjcBOPPHnq2pBtljV
         qUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZV17V0Ax8PmwLRa89tOD3D77fw9+yZjKCn2psi+1Q/Vo4pdGmDSBYjxkG3tMORVmqjcu4/5J2NExuXVqwhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXghLJh/cldIVUijoN/cygLhpOjjhmidpWCFD0VZMXoY4qftPe
	wgSnX+Mc2JCAqZg3eYkCaxVuOTbC7pkqjEXAHhP6ZCJbIIhjZkxiovjm
X-Gm-Gg: ASbGnct/Tl6jP6xyIAG2eyymvYxW8H4YRbdwiP1CgHE6yP1OsIWAkdETOHC0BU6xvmc
	/DfTNXnQmO2RDuwOJSvR0grdYBGGPyaUwWICRf6UYNz9E+dv4bPaaH+c/IfUQ8TsgtRryHzh987
	/pbK/5Sk14gJt96ia6EkhNCz+oQtB6yHeO7U5Ff1UDDKb3qdtmpl5rcAyYvOSXLqXMHdtP/mf1a
	SDJMqXdHpCZGLc6pu5hbGtMA3ujlGuyBA8FgBV7eClGZjPZ2HcQeSDaxWKop1zRMOOKU/XrXo9F
	9lTV5dMwysO1ood3LkPXkAxuGGNac5PWbN6iE9hqbJgImWCyPrFDp96aLE/HIDWytwuABht4P+p
	9cVeNggS3Js3p
X-Google-Smtp-Source: AGHT+IEK3ZoFj8QYDAr4NlAPkp8aJUwqkx0FN+bwLBX7AEho7EnU/rHebPmVDrI+BtfXZ8uN0GJ4ng==
X-Received: by 2002:a17:907:1ca3:b0:b04:5bb5:2745 with SMTP id a640c23a62f3a-b04b1f0cfa0mr1239911266b.21.1757449466569;
        Tue, 09 Sep 2025 13:24:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830a7598sm47470966b.24.2025.09.09.13.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:24:05 -0700
Subject: [PATCH net-next 7/7] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-7-634282f06a54@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=leitao@debian.org;
 h=from:subject:message-id; bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzuzfaQzetsofrcRbpnwuLrO1D7w86wY1TTU
 lrqGZgmCpuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bXNZEACcAE5R231Z7uNnKiyv2RPO6hJXjog8YhKoP/yzmIshYPJ0FAh+8o5piRpRtM6dIn3qeky
 Ve1yQ7Aw/Vn8l55/nTiEZPX665GmRsqep7Gba1AHM+74XOC+97c0zEQXxid9b+gICQ2Sstr7hbT
 soSkCyNxLHjMgPxyHxw0/L+GSL4cBJHIQKMvR+6uDBCNcZh9wYinG0rGorRBHPj+FCkX51WtHCp
 wJ+furxV5a/tIdO1ApWgVUcqhomico6t2mIziLg6dSgwljOTRH2bKpmwfhz2Z79sBLtNIW938GO
 6EV6K3X5TaY9wDymNRCMAHARFqNJFpBmdQcMRbNX0p+EP2jcpseYnh3XYx7rEwEdDC70lyYpdmP
 LSZrKK/bEAJq8ZhG9ONl0+B2fHP9xLZH+xNIXamgSlk6h6HASJ4mbrfpnRch4YmCQntT7asuCiM
 s41BTaQndV6gaP/m2Fyk9ByczEjdYeX/JRMg/VdlZUcppBm4q9VLrz5bTLji+suZPduq602SWhX
 rwDS8GDkRdHiUEB+Hc3JaxEVH5mSLPAxuQp84S/nkv7VVuQFgD/dPlaDTkvUK8X+rlOfEjb2TB7
 ZiI2uaLp8RpXRA+oz3+wnuVuWJ8gWcp//voZ+HEDBzlZpHcjLJ71zUzypcZXd6Zo4wZXP+2saHB
 NTHpOaRsFhQuJmQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace the existing virtnet_get_rxnfc callback with a dedicated
virtnet_get_rxrings implementation to provide the number of RX rings
directly via the new ethtool_ops get_rx_ring_count pointer.

This simplifies the RX ring count retrieval and aligns virtio_net with
the new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84b..e35b6ef015c05 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5610,20 +5610,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int rc = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = vi->curr_queue_pairs;
-		break;
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
+	return vi->curr_queue_pairs;
 }
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
@@ -5651,7 +5642,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rxnfc = virtnet_get_rxnfc,
+	.get_rx_ring_count = virtnet_get_rx_ring_count,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3

