Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9212B93
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363256; cv=none; b=iVvR5Mz9g6EQ9JdBacdepf4Kh4MG1kTtoZAYArQXYgRMqXKzIOeCDScM5o9oNWtvKU93pERC5bHp1bvJjBV/A5rlLb3XINh+fwaQVGsRUiZSjB+q4LGAr5PZs53O1C5ZUAxkchREY42SVf9KnjBMFIvTLkDtB/BHni6uDGBlauE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363256; c=relaxed/simple;
	bh=2fqPz17MRcLXtYYBT9jcWjUzidfYf/z7eYbmCSZjWTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=fOKQeLTz/cxXJP+HZeJIinEKgQVFFR1ax2bi1xb1EKTjsniEjkuvwR/uKHO3Um3IXbxmh6FMdNDGMAB2xW2RZCYxP+u8LnwrbAXaxTgoM+JN9wQNxm/rvHjV9sVpsDQoskY+7GawuQXTjHUsGy0yBA+/HxmsFBDyuICPCWzwQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Y622bboQ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Y622bboQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BD3084353
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:20:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgNd6yfX9ylv for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 01:20:54 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EBC96842EC
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBC96842EC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Y622bboQ
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBC96842EC
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:20:53 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso1662779a12.3
        for <virtualization@lists.linux-foundation.org>; Sat, 14 Sep 2024 18:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363253; x=1726968053; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldxygdAUBk4mdAzGg1OPlp5HlR7yVW+p2ali8303Ccc=;
        b=Y622bboQ7PnJjInt+808NBxYW5FlV4N6RA0Sv3Qkm0JL9GfEu/hd2tUhD5zUxkkXJn
         yv5es2ueAadN58XtrbqP1qBnm8Oid6i8aG0R2/gUS/AtLvNoRMoR1XVzhsrFjOYSVwHn
         Xe300C/DknHVDuzS/MQbm00m60rrAL95FKNQsYh4/ohtUClZ5gofMO//MhMwWY3TuWGK
         sKn8kxzcUKXnc/JdaCcmUbTZy+6K0G8l5tzXmPQZ7tMZQ69vFIBhoEVt7qhu1iFjnfwi
         QUT5s33njsLoNkPLVIuBpn2Mn14mdAem0Ul0v/SvPPkLSqMlxonChH9V6XB5Or9ZRrPZ
         tb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363253; x=1726968053;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldxygdAUBk4mdAzGg1OPlp5HlR7yVW+p2ali8303Ccc=;
        b=a6gBysps2MMh86mp726lRRw+rk3xycTKK4LWAanHkRQMisEvcTwNGGaVXMgtk16ABR
         JrnCEUbYfKgzcQMwF/KDVqa0TwuBdEILLYqw4m7JHAkw4PEWgzm3afosicIATaWxttA2
         /QzTRzGyEFdCDu5up0ILS5BmyoJNToaqWjBDIE3yNIg8ylAtVLOs8MWxmA/4zXtosnna
         vPPLj8VaBq9wZiBYjXJM0E6QQHvWxYfBU1wJwn7Q+Clwr++AXsEqLEraa23qgYAw2j3y
         PMCMB4nNcaK3pYtZpV3K5OKvfbvN2HmFciErmyWNC3M6Fkhxgy06xdIxADXsqGA/T13V
         3vYA==
X-Forwarded-Encrypted: i=1; AJvYcCVmmGEodYCN1F12zoYPbthqwQgSfLzUkZ/aYXAKX5wj22l78WqyVwD0aVMKYhE1J35hiLs83yoKb8YxWJRInQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwM3E2/3PjJ4KBPnPv6IUb7JHf8ikxMdlcrPNHpwm/YPrBqnLRR
	r3Klre7toDk0b576eKh5FM+PxPJkGX3xpasetK3ykLkJyVlHp46wyTVSN2zwu/U=
X-Google-Smtp-Source: AGHT+IE0yowzjkvInt+ft5+xweE+VUrTmnfVWN9Wxm7pcrS1764om0EdmXZEOykQ9o1zzDGEix2zCw==
X-Received: by 2002:a05:6a20:c996:b0:1c6:a680:ef3d with SMTP id adf61e73a8af0-1d112db5de9mr11518495637.28.1726363253133;
        Sat, 14 Sep 2024 18:20:53 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7db4991cfd2sm1787114a12.48.2024.09.14.18.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:20:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:48 +0900
Subject: [PATCH RFC v3 9/9] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-9-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/vhost/net.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f16279351db5..ec1167a782ec 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -73,6 +73,7 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			 (1ULL << VIRTIO_NET_F_HASH_REPORT) |
 			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
@@ -1604,10 +1605,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
 
-	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			       (1ULL << VIRTIO_F_VERSION_1))) ?
-			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
-			sizeof(struct virtio_net_hdr);
+	if (features & (1ULL << VIRTIO_NET_F_HASH_REPORT))
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			     (1ULL << VIRTIO_F_VERSION_1)))
+		hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	else
+		hdr_len = sizeof(struct virtio_net_hdr);
 	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
@@ -1688,6 +1692,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
+		if ((features & ((1ULL << VIRTIO_F_VERSION_1) |
+				 (1ULL << VIRTIO_NET_F_HASH_REPORT))) ==
+		    (1ULL << VIRTIO_NET_F_HASH_REPORT))
+			return -EINVAL;
 		return vhost_net_set_features(n, features);
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;

-- 
2.46.0

