Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9692153DC
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406894; cv=none; b=ewzeHZQGOb0sJ/sLEDq/U5j2ubJc92E3X5UiBexwltfcWu0NN76p0lHVL8nKfK9nr3kF3wEvfxlWSL+bf1DHe0WianOeWUR3vCep/jSbtdeQ+OYByVX0VHj5b2U5Zl2accW95HfvZ5KZVhl/8kRz9qh3YdydPkWNryY8m/6td5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406894; c=relaxed/simple;
	bh=V4rTr48gCTTCBFSUklYTYzH1BMfrr/4hphLyr2CFHBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Af6bNPPX9PS6QFO1H6TasWZBE1tAYTUf8hQbfyMzc8rMNbjXMxI5BZxwhJ+pmGWjDhoKKPJ1A4vo7AP3IZIm+LHEJsvmH6V4gm2MQ1jctKHDu9LthyE8L3r3vh/bLF3/kA49ZjGnBFMbBCxcmBbUk1cJ+ai1vFPoKAp0UdiKVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=tRKExdjI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="tRKExdjI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C350404D7
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6-xx-2JDB6i for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:14:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C558B404C6
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C558B404C6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=tRKExdjI
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C558B404C6
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:51 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2f44353649aso854638a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736406891; x=1737011691; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g1VKQa2xOP+8VFeFm3JNqgr+uiGplo0eLcy0YMBCzc=;
        b=tRKExdjInJXtSxyHFvSbvFteVukDSqnNP/M0d+AFhHWrHK66j788/6N7r6CothKBU9
         fJzrr4fgNsiWUcNf3c+rgi69Ve6wmoOWFfaq6BZwfkQC/RtWz3fduqpolfIH8R+CedoU
         /LPBWfkod0IgkzJw11BsczsCu8D2Z/0cwX4eBmroCSbcef6NveAZhAHxN5lM5/o8G/aW
         4z1ZVtIVr/mRWgffzt+XnyybXCjmgOLs6hm656FTFe2WzwuZRu9cdLwX7E9fFEL3NLeY
         jI8bw8asaCvmPpnpIC8WWsb5nLdi5i++B5gRJePAaOSqEVTKdaxT25OACv2y3nVRB4Jb
         0Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736406891; x=1737011691;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g1VKQa2xOP+8VFeFm3JNqgr+uiGplo0eLcy0YMBCzc=;
        b=MdiFAk2UzRZoZ9C5P/Hna5lBFP66l4nUdEQ1snVaRYix+C+0xM85mY0uQ+69KMOUO+
         AOgaiAwzzkjKCsc8oFIMg8j1/hMr7d1i/3PfInmHiYep6SwiUb372sEmVY1hgFdpZSe8
         VIsoYU2owae4cMV75pKQg0kil1yHG8cX1qVw/z3lCOyCSRWwAWsPYSbRRWfiKOsKtsIc
         TuwqDUxysI2xMzUR/3Vo4iz0iB5C29QnB9yM/nXZTYZwZExRN0B9jIJz+smGKIP+kx9O
         i4MjaFp8A5jWIfKXS57aCfrwNWlMShuxyGM2tGPpLUTcNXY9KDPFzz7epIwm+w1MtrYV
         v+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW89R2ZSddbkKTQ0HnwKInM3Ug6hfDWmQkcok/d6SqCvtEg7cJc+ShnuDRUbAveLGLjGLznfmedrgCCT4V37Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YySg5sghdozKVWpvzc/IC+LP0J4WZQlTjILwQBHgGrWDquC9TQ7
	cVzQKwMEuX4zf6qmsz3i6mNXTu0Ct4VZ4Z3Y5mRyMPm6vKECRgQqF1YngxXJmZs=
X-Gm-Gg: ASbGncvMXNWM9wVEVGnDhGBoBd2EMKLCMYpqkublDGk1cwdcUwuBmePRzhn1uYWlO1d
	plQSJDYBxtgKaorlssqmF+CySWkYybBu/vV8tj0lNrK42vzgZZvIib3g2TVR5LSxBYuoVVEjsP9
	7c6UgBqWIik6WZK5QrkDXbUflWU7BI0Bb5zXZJFhd5qytThcaNBns6QlikflJdWSTbJPD0PaIPX
	qStg2AGMx8qhudZw1LgKSEQqLwnbwkwpR0fjba2cK+VdasdF1aHk85zIn4=
X-Google-Smtp-Source: AGHT+IGd9lpv9zb1K0tz5iHHV3Jqm/5MPg+oC5ZDuZy/BjPg77kTbQjj8ZNOzcyz3pMcdff2Q/gChg==
X-Received: by 2002:a05:6a00:1d81:b0:728:e906:e45a with SMTP id d2e1a72fcca58-72d220599a3mr9260391b3a.24.1736406891083;
        Wed, 08 Jan 2025 23:14:51 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad816464sm36435407b3a.40.2025.01.08.23.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:14:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 16:13:44 +0900
Subject: [PATCH v6 6/6] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rss-v6-6-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
In-Reply-To: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
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
index 9ad37c012189..ed1bf01a7fcf 100644
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
2.47.1

