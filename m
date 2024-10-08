Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342831EC00C
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370537; cv=none; b=N2HT35K6b5ZT3JwdPagb8tszZ+nB0hghHyOLHkbwElKRJPIqXN+1W+W3mG9wIKcQEzTrnd9ORncW3oXUXC5CtI/A024QQfzz3lDD/l+lX8dI8SsDFIn6/ujciu+TzgHtKLK+DmFtutQrA3Jf2E7fvTA+smQa23IxNORSqjomxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370537; c=relaxed/simple;
	bh=xPXdqMNBwYBxjRVy67D/GdzAQuV+QqFH17klGcbYhos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=W83IGI83bmSeAzXtVJwjuET5skL0VEHYCz1SshutLbj1WPgB6bEis8O/bxPosyA8ODcCaTlHAyQpzOlTiC4+8MkFIZQ72Hewg+k3KEKD6KvOYxp0wxzKFlBKRsKEQhSriALT/6ZLl9hBgVcSBLicgIpL0I6Y2bwTinb8VyaFvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=wEBcN247; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="wEBcN247"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0351C40315
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-sXtn6Of0Dt for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Oct 2024 06:55:35 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1023040313
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1023040313
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=wEBcN247
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1023040313
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:34 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2e28bd0bd13so120139a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 23:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370534; x=1728975334; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNVaNoDirrDF/K5gG8N1Rw46L/tBZORPSDyk4tebyaM=;
        b=wEBcN247dwVENgdMpZO3gV8aNEtA4nTbEqGqMq7PkcT4Y157V/aTIXPJaLxHDCgQKY
         qC1K30AwATsYV17WVFhPR6Eq2M4EDN1SKq5yi1de26vvmenvFHjuFV2fJ9/FSRyxwugg
         f5u0GBp1xbKbgGyBtz/FYZn2F5NExhQRGdrGtAgfKqRngJlZUoUpl2imW20nM0UUndM5
         wCFxnEXxer6h15mP1eRuW8w+p5xqP2Dds3SZlukhbR+KlLmfx0A1YPbDlIT1ta/xuylq
         Deel6qGbZ7Z3NB3WveemLEEC/0nkPJBGtU/3yGmi2T/zuOTLI9ja0tw+ZFThu/W330Bd
         8k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370534; x=1728975334;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNVaNoDirrDF/K5gG8N1Rw46L/tBZORPSDyk4tebyaM=;
        b=YHYDop+jLHNggG/bEAzuWmJ1ZaWDsSVplcEwd0re5cJgjJ0cocPbKjab06zctvsNZT
         SmP7LeY2fQMvXu5zzNAIiu28IZpUhJA5eJheB9f/LA5cNTSlLCkLBAjggdVGjqV1RDPV
         pplIHXeokvdHmkTNeOzFrp3CJl0HmYNN73xLaoJz/XbB6769RmgxsKW1e/AyV1PG88ty
         4ZTlO6lyB7/9Cr/VMMBVqidW/3tn3BvWDuIFpC219gm+02gbm9krOclk/kc9E9Irmils
         4Py33XEUvh46Y3FKw6mJ5zniMQIEK0tLMj8zIIwBCbKZziO7vrfwrRckGOOtkrJ/vgZG
         /NUg==
X-Forwarded-Encrypted: i=1; AJvYcCXg5+bLtkzISXC1vK5IXo443Qelg6PvtqHjmsdyYIfWsojx1ZkyQmrJPrUlB2oQb80juCvSUTwun5mtxe/PzQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwIuO14fuq1cXxoOtaMrA8X713THdyiy60YcwA4asO7BGlBcfLc
	McdsYknU+OFU/YX1tZR9FzC3mcQAMCoqk9Nmoaj4QfXOoVTg3MOhG2a4WaksffE=
X-Google-Smtp-Source: AGHT+IHkb1uMKsN/5XlbEXxGBI6s7AmtVvSir5FKrdkZc8sYxsL2ddqvfgRpOey0uZac+T06eJdEyg==
X-Received: by 2002:a17:90b:4a92:b0:2cb:4e14:fd5d with SMTP id 98e67ed59e1d1-2e1e627f3camr15847213a91.17.1728370534383;
        Mon, 07 Oct 2024 23:55:34 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e20b0f64cdsm6721041a91.35.2024.10.07.23.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:55:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:30 +0900
Subject: [PATCH RFC v5 10/10] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-10-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
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
2.46.2

