Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A13343D8D
	for <virtualization@lists.linux.dev>; Fri,  5 Sep 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092062; cv=none; b=ZH5Pavy3nKiHKQfxegzCGFT1Ttt2xfG8ztNh3lU9jNq/pgVfdg/Gazl/gWTxvpq9INw7zZAPGwqzfkOtim/pRQt9En4V7HjczSBzTfi0QMxfz+AciOP6O8eQ1u70Lwbh+Sb2f98I24cxwvtTM8i/FSAMtVQJQEeoAEnz9X1u/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092062; c=relaxed/simple;
	bh=KVKSsW2WTK2b+YQKfMYkRtMIvYs5cvK6cLAuCNRNWUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNeOWTWX/+3IicaLFqvtJIv+t/fJxt43vPbPVUI3bu9Cc4kff8NAZTf5jL3kolDtJePFjvK9zQHj5qdcvLt2SVIoS9U918Rnr3RjJXxeqFY1xqXzWHpyN+oztKWJAaEUcEUIkVZc/azHh6Dk5mJXT/zmgP8En8pDlEa2RUx4nGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so3832006a12.3
        for <virtualization@lists.linux.dev>; Fri, 05 Sep 2025 10:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092058; x=1757696858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkb3H3Hru4QFaSuS9oEviTp7IMbrnpNMLSXnPYRrEKg=;
        b=vdptqFjOE6IxUOvCcEub1Dlvnbi01b2Q2Mg2CqM2WBQuzuOveJ4G+YC9M6WuEhi5FI
         ndLAqOT6sr3oyo5L575D23tryXTD9tXqitBYp6dYzcM00vdBYkmkaTU0oDj31LgMnHqS
         iJ6sK52rqnmU+2TaKVphKyAIz2h/VNFJ6eHqk660or0t7kKBvQ89Lu1YFAzEoaR0HiQK
         kqWo4w7x5Vn6QRaWHEugnHcu79joOhbZ4JuB3tc4GRDYmshQHqQX/8T9Hh/7bFZ49Sal
         DTsYRCUCkE9a+JgOJAcY4uRpAafMuKmkmALArYDt0mOxupem90q6eSV9KVGKEtOvhGgd
         Kg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRLVpsaxVnUW2sTfXlBskkE+NlFouo3rAVgU6JZCrCa3HBYaRJlkM+5EIlKC9CCQNFa3hzoKAry321Q+09Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsOommRDQAcyXRjWouTsed44T2XNbDc1Nd65YsH4yP6w3iWAh/
	rHJgn5iKGsAwSOAqQCpLwmjLcUvbIp9rtO1wtUDV+4JvR9jlAAv79Yta
X-Gm-Gg: ASbGncu2gokq7BhkcfyKMjDUzQxEG0WXIBEdR8j1xt9+CYbw2u8j6BaZASX8LIcuco/
	jDpnl7v23DWX9ZWJW/PGKs/0h7zbzn7GjHHutRt/B2OrF3g2vApU7T/1yOMnHUcA+JvK6Hd8Mlp
	GNOFXoEtUquRw5GHxgLxPiYh7vHErPczIY03OCu6lkVk24j1wjsD4wnGnp8cJf4m+NRzioKbd8H
	aqKEr07B8iRrbZ9h8wPAyC9mLwGKXNQDMeGHEPwv6Qh2Kn7rNVVB4UUkoQNQH/E58l+lRVKRSs0
	6A3Fcz1dRbevefMv7gbDxTuwrbb35RvGLZWqyHbapap5QkNsZz7wOR21r3xxaliWL/8r892clI7
	QXND2rQn+dvic4Q==
X-Google-Smtp-Source: AGHT+IEW7PqC2/WUxYBi8+JOOLG0n7mbB0JHYUl3TfKSgMK9s6BabZvv4Lbp1/uO2+dfsZQbPoQRyg==
X-Received: by 2002:a05:6402:1e8a:b0:61c:7160:73b2 with SMTP id 4fb4d7f45d1cf-61d26ed35bbmr21799723a12.36.1757092058336;
        Fri, 05 Sep 2025 10:07:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm16609830a12.44.2025.09.05.10.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:23 -0700
Subject: [PATCH RFC net-next 4/7] net: ethtool: add get_rxrings callback to
 optimize RX ring queries
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-4-984fc471f28f@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=leitao@debian.org;
 h=from:subject:message-id; bh=KVKSsW2WTK2b+YQKfMYkRtMIvYs5cvK6cLAuCNRNWUQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjS/M4wmNx9IaSekB2GdCq/oA1QNr1HRj7vF
 jpaMHABPYeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 bUo+D/wLtkI785qZ2WWIoHuckAJX+CwjwJiXB/E06jkg4U4q0K73svWKLBE5q77MDyLxZvlGKlz
 JIhUufDnHn3zg2rqZ+LxSTDE97wzmanDF6Jv7NYOqA5Q1tly2R9hyrWXFzvF+UPVPCHYNikNAJ2
 BQ7MKQE5nywYwNy51ChhT7SjELqA6Nj0qASCaoDLTT/ETjGyezrKKzN3bEMjRv8A4tyiJRIQxYF
 /a7/NQ2T+ImmCScmTsO+y8yr19n0kFJFOBN8M9fXPt0NAyNyhQCYJo0Hn7ifOEa66ahPuKxQlXv
 ATp1V4utt1u/1VdWZwmEKVAPlmfDXHQ83Njr1kZn+r/6Ek/MFJxXxjhh4/RSxu2Ty6SxxDRCoWR
 bUsYzUgZtQcvDd1mMD8cjdNeEa7cM/3oPImRwOUanFZDKAWL+F+Xz9tX6rsFdSoz8d+y+pekpYg
 9OMe/pvWYYEQ41Ym5Hh9Rq6b4JhnATH7OYDkuOyNGDuAb25Xq13PEf99J7L2EaTh5LPzHmigz22
 6Towg7bus7eOF+XwAXfjc4eB+dIi/HQt8Sw90njgY69vySsDKE8uRPTularT2vVeyV5/O78Ilde
 UcXS2kO6lcpEiMOV0vCZPL6cANjSoXxXQeJdy4TIbrLrn+eFDGA1m/BQBkGkNOecUPZtxML4yci
 0f2wXpuznziJEEw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rxrings callback in ethtool_ops to allow drivers
to provide the number of RX rings directly without going through the
full get_rxnfc flow classification interface.

Modify ethtool_get_rxrings() to use get_rxrings() if available,
falling back to get_rxnfc() otherwise.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  1 +
 net/ethtool/ioctl.c     | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index de5bd76a400ca..4f6da35a77eb1 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1141,6 +1141,7 @@ struct ethtool_ops {
 				 struct ethtool_ringparam *,
 				 struct kernel_ethtool_ringparam *,
 				 struct netlink_ext_ack *);
+	int	(*get_rxrings)(struct net_device *dev);
 	void	(*get_pause_stats)(struct net_device *dev,
 				   struct ethtool_pause_stats *pause_stats);
 	void	(*get_pauseparam)(struct net_device *,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1a9ad47f60313..2f3dbef9eb712 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,22 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static int get_num_rxrings(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings;
+	int ret;
+
+	if (ops->get_rxrings)
+		return ops->get_rxrings(dev);
+
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
@@ -1217,16 +1233,17 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rxrings)
 		return -EOPNOTSUPP;
 
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
-	if (ret < 0)
-		return ret;
+	if (WARN_ON_ONCE(info.cmd != ETHTOOL_GRXRINGS))
+		return -EOPNOTSUPP;
+
+	info.data = get_num_rxrings(dev);
 
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }

-- 
2.47.3

