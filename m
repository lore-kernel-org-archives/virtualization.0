Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB41ADFF8
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363699; cv=none; b=F8qQvxIUTz3NLFlTw7fdFGhHCJX0SwdRPmjlP5spiE17ovM8ns25mwtQ9/3SfSz6BZhYtgfFSOXeE38umZarRPgiPuj9SYqW78ZevE6l/T+i2KtUI0wplEmNUdATz/sO+c0wI/PjS/MXR182+eUkGcsxr5IiJMmCdlEjQVTDteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363699; c=relaxed/simple;
	bh=tzwzEP03g8s7l3aneAZ0Ydoz3zLfOnTznPFsRRqr3Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=IPujGUTMx+yeMcDpI5NGnk0HSvDSTqLrptRyHQcbKArS+MT8GGFRnkO2az1nQZ2gxT1QVzCdwVr1Jx/5TTNq0YIzkhPtuPBjqTHxlQdOep27RrkmfRLyBFRgPHoeKWNQHwHO+tJHct1sb5OePwLK+J9gw4wgD2OkoOO/8y80Q4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Dv7EfnIJ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Dv7EfnIJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3C26409A6
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjPuCSAHM1Vu for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 09:01:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E1068405BC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1068405BC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Dv7EfnIJ
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E1068405BC
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:36 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2165448243fso93712185ad.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363696; x=1737968496; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB97Bbr4B1xEv81orQhW1O95FjEA2Fdmfcgrx6OvObY=;
        b=Dv7EfnIJRkaIj3xXQ5A3SQsGCJ2SXkcFJzw2qp862Sb8QWSX8/9kZ5V5IdY014Ed1l
         O2MkFfO1N6E+8863xLXsUOCoVPcMPzQfS/GwRMZHkSw4gbI4qQ/8RPH4o5a/1EqE5mU5
         TE+q5VtPjqCuxsrAtL7xZn+KMfrDRRIC4YpN1/KWCwkHxaEmj5xKjPHUuvUiUNOwo4vK
         WhC5/ngVBaVKQ0Bn1Asf9+1NiZYpgfdeyEobEje0i5m7Jaw9Urv0eoiaNfPFKj78bjAN
         31QZaXqpIfEBWSDCAXcVzaR5buC2WXELYDZl5FOkCFAzgXzsQBvNLYiWu2xtLm7lRR+8
         9r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363696; x=1737968496;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB97Bbr4B1xEv81orQhW1O95FjEA2Fdmfcgrx6OvObY=;
        b=s8xh266iodTvIDhzjirOPe5KoEyZpLcsYCozjZsJO7lqF47AYou9yRSLFkR21lCTqV
         LwMvsgaYfnp57iC7t7y+mXG2JuAjH0JZYlB8dN1RfPE37Otu8BvIP2LXrUqWmQu9quug
         b+cnOMRLwh0NKAnJPfl4wCgBZLL82yTXOtCzPozJY6PKP4Y7ZSZw7sldRi5pihF7xldr
         S/sTb8W0HYWAtV6rcPnX8KuFSH3snXMd1+tL9fBTepag67bkVxi/Vrie7kocaG7v9RLx
         IwrulD67AueR3OHgjIJYlzlhEfhdgN2j33OsfKJvMt0d0jSFuVvzJIJ05scVytAwz4Ba
         QIoA==
X-Forwarded-Encrypted: i=1; AJvYcCXwXJWefV5GfWaD43A94VvkTQQmkTksZhKDsR0oQsuFv1ALM99sCrYvzfJgVocMjx/TFvgONLuLsTQqyZyMgA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwB8/B95nalqQgUooimtJdWcQDtjDG1PZngXySOUCqvjzh9ngF6
	Z6b7uVZJQdzy691I5mYHpOvTdiadSRys1pZ+hNko/uowxFf3WXNRlHA+BMAFbEm1l7rabDngE98
	4tqk=
X-Gm-Gg: ASbGncsoeaOBI5aWb2oLE0VMi9ii4Ow2lsNFsEgQh7ZOMtqdmpMursK0r8nkb5BXWw2
	XCOjeIMU6IDCYgAOGH0DQx+ppx9mKtmJGfxLOdJ46o3AcIwoPIj1fwoTwfBboQEQOFFaiJte5fL
	3wYso9cxDHJvshFBNxktbsyW/MOZhw6En9lSIm/DVMJ9aYg3XGXuhJyqWmwlC5+AnOVqW1GKirQ
	dMFXg7GGVRwiXeJTFvzpmpKX1iu67489avRIUyqKReuQx2hTXghkZbLqwagLRrgK98Pn9vM
X-Google-Smtp-Source: AGHT+IG+qd2PcvmwKJh5HwzId2IyxwMl0s+fSQcG6B72BSMW0ku0ylKyrlMqZ+pwpjyyUJ0B3fOsrQ==
X-Received: by 2002:a05:6a21:8192:b0:1eb:3414:5d18 with SMTP id adf61e73a8af0-1eb34146070mr8643406637.22.1737363694522;
        Mon, 20 Jan 2025 01:01:34 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aab358fc6d8sm3149440a12.51.2025.01.20.01.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:01:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:16 +0900
Subject: [PATCH net-next v4 7/9] tap: Avoid double-tracking iov_iter length
 changes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-7-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
In-Reply-To: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
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
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

tap_get_user() used to track the length of iov_iter with another
variable. We can use iov_iter_count() to determine the current length
to avoid such chores.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -641,7 +641,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	struct sk_buff *skb;
 	struct tap_dev *tap;
 	unsigned long total_len = iov_iter_count(from);
-	unsigned long len = total_len;
+	unsigned long len;
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
@@ -655,9 +655,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
 		err = -EINVAL;
-		if (len < vnet_hdr_len)
+		if (iov_iter_count(from) < vnet_hdr_len)
 			goto err;
-		len -= vnet_hdr_len;
 
 		err = -EFAULT;
 		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
@@ -671,10 +670,12 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 				 tap16_to_cpu(q, vnet_hdr.csum_start) +
 				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
 		err = -EINVAL;
-		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
+		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
 			goto err;
 	}
 
+	len = iov_iter_count(from);
+
 	err = -EINVAL;
 	if (unlikely(len < ETH_HLEN))
 		goto err;

-- 
2.47.1

