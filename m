Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F60214A66
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736405965; cv=none; b=HX5lv9wGRczOpXMg4PZPlHJGHmAfXXEE7dCI4nq5V3ppJ0qlv0rNPZcusf3+Zznh0xho3rAC5Fby8KznaSspBL2gREfFxJok76Db3Uv5nRkvxuNJJs9b4UxGrENpSKoi1zq/qd0rYyC2i1twb1V+R+PMB1ge9Tqfj3thYu01H+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736405965; c=relaxed/simple;
	bh=j9JT4BCL5ue3sxQx0JMGybwFg69W5Wt0V1JljWQGcRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Ry+EHaSTFWk6D/eu4nV3cr+nA5nDuGjYyQ+3MxUla3W8nOEAMCKVy3/e70qxpotaXskLf5GxNVkogxh0s5VmoywPHfP6Q9PKqk5Jkcg/xb1WOayVtQcc+b5n37mxG4HtEgP4JoMPPE0vRAP0cY52jw1AhZJ94T6io9VX64L4VSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=IGfl31Ww; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="IGfl31Ww"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78BAA40025
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UubFJVyzzTBo for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 06:59:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5AAF8404C6
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AAF8404C6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=IGfl31Ww
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5AAF8404C6
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:59:22 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2167141dfa1so9883095ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 22:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736405962; x=1737010762; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcMFqPOnaXF/Vbm6gaswrNROks4WBDypVrONtYlYR6g=;
        b=IGfl31WwcSmDTz43lirIE9w/ICkTjGeQlIGbuvZsKBZpFOtzvElAl5dcPpLHlzowZV
         ytObgpcuaTRGtfnFwwJ1uLFAOwCN0pO7XTGzL5sMVWPhI+PiegqNquEniVF/BJIQrxFA
         se5sSO5pYsUpEbXrjat5DaPGNH7tKjvJP/SqUmraAvyps69NKzle7U2c0R9NEpG2lVmX
         gMUVcbUimC2fzj/Gd4eYXH7jp3k3u9jXm+ncjI3SRiPa2AsGojjmrKtILtoUFGrxGgBX
         hcnhXmPmbSpQYj97/GAGv0jDRiesY8D91bFBvahNkmxgjvyC6fi0kvHFO5kFCy4nmuXd
         k/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736405962; x=1737010762;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcMFqPOnaXF/Vbm6gaswrNROks4WBDypVrONtYlYR6g=;
        b=PzBaw2fOiPKhsDgrswgaFA61lsZXEtPzc5OYVLGNbRfMqgWOI6SoZ9C9CynnrqCTQo
         GgaJISvuF3UqMGpAhPJqH0yqdIqkRC+rB3V/od3tUOhKLA+6ee/2+YBIhntd8+BQN540
         RX5Ow1KmnpR1D50JFNWy2jwaM5QLzinJia9XqLJkQQLMAVsSVCneNvKWWScDp6uoNvpX
         Z72u5jGxXDYntSsteoBiXMdXmWENJcZmO8JNgKzND05Pi8j+ZQWanlHa8asko3ok+WSk
         fH6Z+B8e3wvgM5/v8+4iv9jOlvvZgemR+HIUxKCye9o0SK97z3ywI+DAbMYf4xiqFZ32
         wJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqWAh+7jFN7lY6s7IteMzhXXdwiFdoF7PuUXlbAHr+7VvJBX2CoLeTRWUlZRB1yAFFfUoukogPNvydOdMHdw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzgOcPHlHH53xbewbkGw70uOKpaAfRRhaslBC9ngILU9vyXjdZZ
	AMYt3hAm3zb1DZqshnG6G+k+nlPr6HJ4mhcjkc77wzodXKBLdLFiMYEpYoQc0zk=
X-Gm-Gg: ASbGncukndNisHJ3CjHjxtjjccAsbaCD3bfLHEKZKoNyYuskAb3RbijjIv5BK7LBKgu
	/fIu++ZuuCAvRcRbvoE9hMVmhtWFyaOSHqHzGX5UMh2sjBJtFI7fVrpa7B9kdDVZi8xOACWi0u3
	Cx7jKf7/cyGfKRuEGiM8m7vjEQnUO0fMHyFbIQXi3qO0RE06g8jIAR5IemBgSyUGSBHpRIcEurn
	qsYXNLVu4hVAhjd1EACtK3yF12Vh4ceQ+7qQK0rVww9ZHO8rJuHtl93kI8=
X-Google-Smtp-Source: AGHT+IEJP35PzzPUa5d42ylaSKRGrOzMFsCH1VQGbqQMF8wzgrB57rbB+fwdI4blxhYKLVyvTAVjLQ==
X-Received: by 2002:a17:902:fc84:b0:216:84f0:e33c with SMTP id d9443c01a7336-21a8d6c7b93mr34039715ad.20.1736405961688;
        Wed, 08 Jan 2025 22:59:21 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dca02589sm338316855ad.257.2025.01.08.22.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 22:59:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:58:45 +0900
Subject: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-tun-v2-3-388d7d5a287a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
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
 drivers/net/tun.c      |  6 ++++--
 drivers/net/tun_vnet.c | 14 +++++++++-----
 drivers/net/tun_vnet.h |  4 ++--
 4 files changed, 16 insertions(+), 10 deletions(-)

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
index dbf0dee92e93..f211d0580887 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1991,7 +1991,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 	size_t total;
 
 	if (tun->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr gso = { 0 };
+		struct virtio_net_hdr_v1 gso = {
+			.num_buffers = __virtio16_to_cpu(true, 1)
+		};
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
@@ -2044,7 +2046,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
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

