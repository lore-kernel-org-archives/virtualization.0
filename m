Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8C1F9407
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336485; cv=none; b=tMAGIAShSW19SqZbE/dGgfE7RmSnlKPJ3utByiOv5yvNawvo1QE9Gj97pP8/xUdAQ8b2SfNBOw2M8/ZMIRojtfiXKBmQfk8Ei3cAFW95ydTXpmcBEKOXO9+JFqJ6pd+D3+tfzWboxM7gJ1qBFupylCR0mIIA7k9btnSaBOSeNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336485; c=relaxed/simple;
	bh=tHg7EPO4d3vZqqXSE/ljdfB56DasxRR2R5V/3PeBYA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=UK8U+bGVw+uThT87lRi2pyRSW9jTj5apJ75LMTlHO3uJutDv3FmBi5dc8Dz9d14mXTYT+cGec/2HrhiWRp5muWgPnEOww3Ez5A8fpPxQShKnvc3LnoCmSiP19Pkl2PzaIx9o2rV9X7mMjbjRlAprlFDzC5Z/SvDiMeCXZBHiPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=G7kpvbWL; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="G7kpvbWL"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0E4F405F6
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44fCMzeKlyRE for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 11:41:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BABBB405EB
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BABBB405EB
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=G7kpvbWL
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BABBB405EB
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:41:22 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-21669fd5c7cso250295555ad.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736336482; x=1736941282; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJZDjcdc8pRQt88Qkq7qezR/3EGVIB2MIrkBFIywvoM=;
        b=G7kpvbWL0rSwn9DD3Pa2l8zPeSqEC6E8Iqb427jlA6l9eahhGFx3xFuG6kbIKtajB2
         dWXb3DFMrvghZvYPA0TuFtZgsN0Olv/LSZtOPhzD4H8X35mMZ82hLxaz+tVPqrkbYy8X
         SW8W9yEyQR1+MEro6/7akxPpecrZcAIwcvE7kjFDZiUAMV7qWwfrSKhHWx3mjHRusA4D
         t3ZfxFjtBrqKRmypxSBF4uYOT/8MhJ35tjopfPB0JxA4Dfzi90Q0A7MGTX+hFTv85Kbo
         L+o3pXTfjLfyyszeAnIrnzdNS6G9DjH2/7LqfkBGNPRVTBq3RJWX/NmjmHoZpgy0kl3T
         eRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336482; x=1736941282;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJZDjcdc8pRQt88Qkq7qezR/3EGVIB2MIrkBFIywvoM=;
        b=nvHpLQpzEU6yiVOvqMdgGRH9yPysrY/wKBfo2hA6nvC4w8AsltAobVm34pD+iH77U4
         PqMqupFwPLfOb66HNw7w09PGX+3NO9aHbE5kK0v9TrW9/+sc8NAA01lfnnRgPaJLqGaE
         FxNHJZahpwIx789Fx4iXposHeVRRCSy5fdik9vZWVL1M2P5h+B0/+h14u+2Y0Rez43SI
         e3nsgRjsbHtZWnlrAArCsixxfgai6hBeLkQ5zQhTfchOYEld0apAZP/GR3tmVPwb0WcW
         MnsmxiDJFeW17okUt8TYDaUSTSDDnAaIWvYKmZcJJ0isOxpIOedkmGY8N5JycLXSPS3h
         +hxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIjEYoCek/GrjyR7aSi9bqpYqVG5a417L2+tPzBDGd8WIthrwEc2o6qNoheIwWOx/ELyjMCyrIry978PsRRA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx21E6bQ5tXnf7c/jk6YyY1oNLMf+6llG6z2oQt7PNzcyre7ieo
	45i7WbKYPExuzO7pYZgr7h9XlTZAUipqHueW8A3sJQP85ekrVWG0Jhp7u8my000=
X-Gm-Gg: ASbGnctK4z3JX4LBaTNViDmA5/H/WCRQ7vwwcQ0t22wLt90UiRldNOKYWyZB1BNwqB/
	/tRByHu2mPx7zB5fZ6BE2kT+J6HopalB/HHa41TV9I6aI07w9Oj+ded2jVqJWn102aKRW5qQ+yi
	mcSUvDgtV196NueEMiqR/QbJBwskW+gndocTXchvb9b86qSqN5r2krRAkyhY6nO0stp8uBdchRf
	Pfy38WBuqcjtxKeuSShFn1htUtnvgQjkmzm9QKkL8CXCwE2yiQXwCBm6gA=
X-Google-Smtp-Source: AGHT+IGZASTQqlbIXu/5lZbeo0etu1KHnAZzoaUJLTqYhE6bCTImvJlbR5ZtQox21lD/Cy5M8tQ6Cw==
X-Received: by 2002:a17:903:2308:b0:216:779a:d5f3 with SMTP id d9443c01a7336-21a83f546c3mr40688775ad.14.1736336482042;
        Wed, 08 Jan 2025 03:41:22 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc970c8fsm326235045ad.60.2025.01.08.03.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 03:41:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 20:40:13 +0900
Subject: [PATCH 3/3] tun: Set num_buffers for virtio 1.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-tun-v1-3-67d784b34374@daynix.com>
References: <20250108-tun-v1-0-67d784b34374@daynix.com>
In-Reply-To: <20250108-tun-v1-0-67d784b34374@daynix.com>
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
X-Mailer: b4 0.14-dev-fd6e3

The specification says the device MUST set num_buffers to 1 if
VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c      |  2 +-
 drivers/net/tun.c      |  4 ++--
 drivers/net/tun_vnet.c | 14 +++++++++-----
 drivers/net/tun_vnet.h |  4 ++--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 60804855510b..fe9554ee5b8b 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -713,7 +713,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr vnet_hdr;
+		struct virtio_net_hdr_v1 vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dbf0dee92e93..ec6f4ae655fb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1991,7 +1991,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 	size_t total;
 
 	if (tun->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr gso = { 0 };
+		struct virtio_net_hdr_v1 gso = { .num_buffers = 1 };
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
@@ -2044,7 +2044,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		struct virtio_net_hdr_v1 gso;
 
 		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
 		if (ret < 0)
diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
index ffb2186facd3..a7a7989fae56 100644
--- a/drivers/net/tun_vnet.c
+++ b/drivers/net/tun_vnet.c
@@ -130,15 +130,17 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
 
 int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-		     const struct virtio_net_hdr *hdr)
+		     const struct virtio_net_hdr_v1 *hdr)
 {
+	int content_sz = MIN(sizeof(*hdr), sz);
+
 	if (iov_iter_count(iter) < sz)
 		return -EINVAL;
 
-	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
+	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
 		return -EFAULT;
 
-	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
+	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
 		return -EFAULT;
 
 	return 0;
@@ -154,11 +156,11 @@ EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
 
 int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
 			  const struct sk_buff *skb,
-			  struct virtio_net_hdr *hdr)
+			  struct virtio_net_hdr_v1 *hdr)
 {
 	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
 
-	if (virtio_net_hdr_from_skb(skb, hdr,
+	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
 				    tun_vnet_is_little_endian(flags), true,
 				    vlan_hlen)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
@@ -176,6 +178,8 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
 		return -EINVAL;
 	}
 
+	hdr->num_buffers = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 2dfdbe92bb24..d8fd94094227 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -12,13 +12,13 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
 		     struct virtio_net_hdr *hdr);
 
 int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-		     const struct virtio_net_hdr *hdr);
+		     const struct virtio_net_hdr_v1 *hdr);
 
 int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 			const struct virtio_net_hdr *hdr);
 
 int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
 			  const struct sk_buff *skb,
-			  struct virtio_net_hdr *hdr);
+			  struct virtio_net_hdr_v1 *hdr);
 
 #endif /* TUN_VNET_H */

-- 
2.47.1

