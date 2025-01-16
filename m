Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346611990B7
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014930; cv=none; b=p/ykOhbQsLpoZgFHkX8ByRKtntbKreKz/JhyS8hKJHqDWqLJVzYf3M8ADOQbnD66sTyI1jmvyTUo4yjS/u295rvDeN4bLTUaof1iOfNcIMK/VXWHVO7gw6wHWLz7zaoYlXwrILw36xZqstNgCcXEOq23EstG781qEpAqeNch9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014930; c=relaxed/simple;
	bh=/419PxDofAsCUo/JZxu3j3vP33oHhAqgdevqSkikvxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=UYSSuUYSHiK+lsvhLuzoERlIhJfqkLUsEwdQowIc8dyDUA1dVrEJSbwKJzg9okYhEZXb848Xk04ygSYIiV7IpGFLbS1tgs96+sD+I/khVszCYYr106f4EgDyS4IpQsPwKuiRJqKtObh0JP0uo8AcIIBn2Pw3h4hqggNe5MfaXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ery53vet; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ery53vet"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C006F6FA44
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IA5pxnmJec0e for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 08:08:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 246F76FA42
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 246F76FA42
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ery53vet
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 246F76FA42
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:47 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-21649a7bcdcso9479025ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014927; x=1737619727; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2j5vDk29ORNIvTpV6DoLsO8UQi3lrdzW7BTzShujmAk=;
        b=ery53vetTFeIU/kdozwHEmHONvEL6/jd6JUWO2Mi6FCLxb3mqu/H/ezZYgBU3nl8qP
         bwIkaKaXEJve8tFWMWOVI4lcWVqnjdGG2KowZ8m7zV+RqrHg4ZIQYY7DBjTxJzXubER/
         GkKzjCB8GEfRbDPIOE0vWoIDJQ8elGnKAhH7klYmjjJjzOrSN0O6xVprP/2Kqf4U+LYi
         9xSP/prY21SfnXq0arTKUdrFubEmDviTQrZhItgAwCQ8Kq4cColfRcjKQ0TbakojaXg6
         fZ+72XwMkSQWVt0my8BLqbUD/nOQ2KD8CjyH9IMjWU8z121KQ4LijYYyeOibgZD7/1qo
         JfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014927; x=1737619727;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j5vDk29ORNIvTpV6DoLsO8UQi3lrdzW7BTzShujmAk=;
        b=F/t46fzKTDsqe1SbNffXtMErnSbzJZltfJWAbLi4KFsZL0VkzSLqQDpJ+cgybHIsUV
         SagBU6D5WOkFdnuFIOVq0vmbAwKQRr3+Mv1FtIGBJkeUWP/+Exc3Y4m18Q4HKQImVVyB
         Jai9XCDrgjaAfzKbOCdqsTQbe4a9tkrXcqGIu8PO4LxsofHMklZXygCN6/ggQcmxkeL3
         nIM1+a6zfpgc66d5wlui4oOMlNjKqDnj6OG4iDWvbr7BC5M5x9WgBXNsiMOG9O9K9h2Q
         gAHYO6gY0OPHgVaAPTaJVAL2k4xPPMbl2lez/OhK8yQQhvqkQHQw6AfsHqvBQA4eHmqV
         Ge3g==
X-Forwarded-Encrypted: i=1; AJvYcCVA3I800SLz+ikX3CTvoDniPTiHe3+wYN8R6vbB0B7o0sjLNk8Epet48CqtRwJxg1XSPV0F0jOrmF1lGv9j1w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YymD1y4YpAEJxzqelIja4tfU9Jb10OQmcDmXFW1AJHQ8bgUFaoQ
	bdgYxq+yLUApGzVe33PClCHCaQAwuUQIOx7kM8QcJVxgS8FXKROWJxwDBNwqyLY=
X-Gm-Gg: ASbGncujMb3/1ZAfD2f9DKctVN88PHet5ByFG3H2N3DU/Ov6i7+3qAPt/DQNWV/w5Hz
	rAMbqh/hqsfZLqF18Y2RbzbbRhsGfL3NSgzhR4Ta1xFKRBfJGYW7qLThvaASGRqDXcInN9z4Pnx
	QVQBBZObGVkEkrfGWkqUusBc+Q+DOtnvvCMEwfpLqfdRwAs6AaD43pxvfbFRbsupNGaBReOUT+r
	tAf2PfbEX2K7XO+flwxO4SkPqsyl5QcZDtS8bOKKkZfP1Efq87cpxI//5Q=
X-Google-Smtp-Source: AGHT+IFXnY5IpJjGACI7HaxQcoaTwGb7qy2/2clnYLiMHQFPxHM1iUKDDNzZY45rgekWHJMGYf+fSg==
X-Received: by 2002:a17:902:d2d2:b0:215:a039:738 with SMTP id d9443c01a7336-21a83f42444mr517969985ad.5.1737014927403;
        Thu, 16 Jan 2025 00:08:47 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f10ddd4sm93691125ad.39.2025.01.16.00.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:05 +0900
Subject: [PATCH net v3 2/9] tun: Avoid double-tracking iov_iter length
 changes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-2-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
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

tun_get_user() used to track the length of iov_iter with another
variable. We can use iov_iter_count() to determine the current length
to avoid such chores.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 452fc5104260..bd272b4736fb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1742,7 +1742,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct tun_pi pi = { 0, cpu_to_be16(ETH_P_IP) };
 	struct sk_buff *skb;
 	size_t total_len = iov_iter_count(from);
-	size_t len = total_len, align = tun->align, linear;
+	size_t len, align = tun->align, linear;
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
@@ -1754,9 +1754,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (!(tun->flags & IFF_NO_PI)) {
-		if (len < sizeof(pi))
+		if (iov_iter_count(from) < sizeof(pi))
 			return -EINVAL;
-		len -= sizeof(pi);
 
 		if (!copy_from_iter_full(&pi, sizeof(pi), from))
 			return -EFAULT;
@@ -1765,9 +1764,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	if (tun->flags & IFF_VNET_HDR) {
 		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 
-		if (len < vnet_hdr_sz)
+		if (iov_iter_count(from) < vnet_hdr_sz)
 			return -EINVAL;
-		len -= vnet_hdr_sz;
 
 		if (!copy_from_iter_full(&gso, sizeof(gso), from))
 			return -EFAULT;
@@ -1776,11 +1774,13 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
 			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
 
-		if (tun16_to_cpu(tun, gso.hdr_len) > len)
+		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
 			return -EINVAL;
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
+	len = iov_iter_count(from);
+
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
 		if (unlikely(len < ETH_HLEN ||

-- 
2.47.1

