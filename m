Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5F302179
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933270; cv=none; b=dxjApdNpNZM6HWgASyK7fULFwy+1S6l6unU3cG17utVuDeBB4Fh0GCgKaoUqCbWJtP5EtAlEopazuoF2w7fhfBDi+DPEj9Ok44ykeOlJ2qPncuZlC5Is6bqOBt877dAKTi1/H88K7C9k4GySlwX6mx1SLsDhjb6QwvR8f7Dj9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933270; c=relaxed/simple;
	bh=cJNmCEop9g7hasbfK5nHQAjt4RcAnO6s+ONwXp7yYCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUoUqX/dCcB8lVzfcD82+dUcv73dM3OVkkCqVB8t6/fhUIgeK0xeJWdm1Q36g1DiC2Y2z9z8Bo2yIq/Lth1Y0Q0hbrsg5sL77r60otYggU5gKbvwOtCvBZpYSSPNDdfyxYJ3SOWVFTKL2CT4KJJWMjVY17Z+LAXjOSnUeuvDQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so6752034a12.3
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 03:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933267; x=1758538067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thqZlVu6AwBX6pN9TwBbQDUepDpkuMkaK1MUaqSKnac=;
        b=wLg0d60cARDlkwtxaotel4I3JzmMLrjNn6OW5CUXhl7sibO/zin1Z9gKPeQUhJ6wiU
         ZiapypP9Lu3lRN3XBAByh2zLZMuhnm/yI72RJg9cDOgXmb9j2WaITUIHJGrWdgo4DtYp
         4bhCiU5Z1s0I/PK7CxXO+RSj1r5hQYwLUxMK2DfeKMZTXllUYOvYrZdabhyWogo4I4dL
         hS3AJ25L4RPMYptOFHXWlx0m4knGHiP9D7iJDbouNPieAtuGbFFkH39gU/ZSH2E8H9we
         SUv4JmS7E72cM/Jz/woe75ITfxmjhH4wvgKnXdTjTQMxXxU3cU9djwx4nQGygBZKt5pL
         yXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiDS3cWHRUx5Bws3y1m63RDR8fs2JGduvMjPZwMNkD1w5hpvnQ3uxG4766Evvz7XMe83C2hXuisHal8brGoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwarKHAiZ5lSYvupi4D7D7uA+tQIosPEtWA4HxdeZjMoM5WMnuD
	QE7dVg7tXcTaN22SJ/fN621prwdnEODj4R5zJ1twyW9wgFMxufst0H1u
X-Gm-Gg: ASbGncs79Mkb0CeecFFb85UAGqyq9DqmAjdvgKeH/0ZKCAXen/mwEv1V3R/ahdSfT4U
	oTLqsEMezJL3af6YyJeQdTpWkIEcd5imQQnbvheQUMy7Oy5ApT02XHBkWQt+mRt96/8m0k4a57T
	38riO3alS4u+WIMlgEC+9CQsfjVUelStuzMpvtDwOMHdJ6HewhDJCBNJ8nLGfeqBjEobrS4+j3J
	SMrQeW641TXpG0w/GhSBgNsr4t+djd/8O1+UA24+gJquLslYWK1V+g/q/fIj8MxZ8g1p9No3kUz
	T/SEHvgTA9QjdyvlL5EQg+yAIHXPfTwM/tJc6kEfb6XVyHaSM724JXIiLT/Pczi0eZLwOt/ABt2
	RFN8nrp1nUBJIZYjP+2vdx+U=
X-Google-Smtp-Source: AGHT+IG2lHVG5X9TCybfnRv3fi1JR7IpXWMr4JJq5A/iavS4CtYbQ/LrA4ABQjGkQeP4oF4WcFcoGA==
X-Received: by 2002:a05:6402:1ed6:b0:62f:af:60a0 with SMTP id 4fb4d7f45d1cf-62f00af631dmr8127144a12.28.1757933266562;
        Mon, 15 Sep 2025 03:47:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f4b8ec394sm852604a12.1.2025.09.15.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:30 -0700
Subject: [PATCH net-next v3 5/8] net: ethtool: update set_rxfh to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-5-bfd717dbcaad@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187; i=leitao@debian.org;
 h=from:subject:message-id; bh=cJNmCEop9g7hasbfK5nHQAjt4RcAnO6s+ONwXp7yYCk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HzRQyd97vtKnYcGncnR/KR0p9FyVINGynI
 4V0yrt3f7+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bd+bD/kBGpbWXaTLKX4Up2S4d/W8V7UlXsppBPkr+WPNLXs2W0arKKE30TQyekECZEbWJ3BB30g
 g36/crQFSe6cwz4npE5sTfNNj1+/ObX2DuLe58203DG3B2G+MC7y8zHAFR5mhwWOPN3CYxWn3qP
 HhJVWaCCXSMKpfZYrJr8JiFZUI7SciiuDDxnZUMwmXYVWe3HJpKdMQdpZ8B+ej3hkWHNIFcMRYL
 QYcwWN/gY4kwxHDYAXhynwqHmZzqkPuYAEWJ9O+0Y5Sjdx4cLVV2YHW28xp02clh3NFCs6LWf5A
 6rYaKOy+gw7SzcipOHPTkiXOzc1h478wOs7db7jVwvfbZ15oRjg0y/5wkQYFtApazssDB5rAWji
 twVsmHfbsC8Lm2041NLDVzT9Zg7UuQsmllDarxVsB2HS0zFsU+ms9xc0QCpTTk0LYrirBHOJVhu
 FT6vZ78cthuTBTsaFfcEyarWlBVVDUB8UoawhxF2C5dChildS5gRptFtgMhDSNyGlQvHaMdTQ9n
 1tVr2UmMrg4u7obD4ycOYBI/jQg/+mV8J0bEQDxmbe/7TOjKooHjsHSwv2Qvz8sz5uZS2vDB3HC
 foEQVM+HsRzx06ERfFP9Y0I5NiCrUWu+deZboXIoPTkCUA6FsUe+M2Rechb4JCSRk1LlZrzsXGP
 Zmz9ZeNcZFYq4sw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5b17e71cb3032..2fcb11e7505f4 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1555,9 +1555,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	bool create = false;
+	int num_rx_rings;
 	u8 *rss_config;
 	int ntf = 0;
 	int ret;
@@ -1618,10 +1618,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (!rss_config)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out_free;
+	}
 
 	/* rxfh.indir_size == 0 means reset the indir table to default (master
 	 * context) or delete the context (other RSS contexts).
@@ -1634,7 +1635,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;
@@ -1646,7 +1647,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			rxfh_dev.indir_size = dev_indir_size;
 			indir = rxfh_dev.indir;
 			for (i = 0; i < dev_indir_size; i++)
-				indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+				indir[i] =
+					ethtool_rxfh_indir_default(i, num_rx_rings);
 		} else {
 			rxfh_dev.rss_delete = true;
 		}

-- 
2.47.3

