Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138001DC9B8
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014940; cv=none; b=cKvm3yH5FAFpVyEH4qRxM+W9lzIEWJXgpRBzp8ybKppjY91ZSULVq6jdD9jn/fFhgwe0HYS0i+DWU5Odf1Ly9cE6PO19rAH8PmosjIGWgX7ZIrhLGgMWpd/+3G68BfpTxEpv/YA6yQrl+EeYPA+IkxMeWrDjncCbPER6E7CeoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014940; c=relaxed/simple;
	bh=GaoqUecKAtyQ+qguYmr90B1yeZ/UsTWOKRqkOYcnF54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=kNV4pgdPZpumSWxQwy2cWs4JBRRmuwRhJeyObcVjEu33cwKOSF9aRVBb425X7I4inBfhaCyiSOleqsOxjoOA/0dMy2YFGyoJSmGxxVsCkCDeIdFC2QNfgPX5pYwA5EjJQ6tVHpuLVwdYXUYKK6ciy1IzU0nWvPq203U9XmqF8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=0duCGvrS; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="0duCGvrS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0BBF6FA49
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrEu_zthFt54 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 08:08:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EA6D76FA41
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA6D76FA41
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0duCGvrS
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA6D76FA41
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:55 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-21644aca3a0so12958325ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 00:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014935; x=1737619735; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sr3AZgpAWe/4VnOS/hnlHnXvPWA7Ea0pV5fu0VlMHbQ=;
        b=0duCGvrShRRpkKHX0iRep1DiYzzlKO1A+FQIIMIyLiFsM9JirXnBuH8EAMxGt7a5No
         5MUKolTtVp6mqeLLBCq0OzuwFwuq5U5nMQ4E3Ew7gMH6HFb2/Hw/9KpOO/AS3denTybj
         4T5oeNx03Yw5cY2MvAw2W/hSNbuizvJF0rSWsUL4+KchRZXt/fur2cyqAXnE3Tf3V1xR
         PNdQf/5td/jy3B12XSKdT6G8YbjVL6H1+XOFmxLcRJetm5m3MqKYCJl8zk0M+LJ+XrRh
         fZkieWOol8M5lzPhJLbH12fhc0+Rxb+0aqa/yFi7uvcfmmp84snyEdYkdZFhkhA8CMHp
         oDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014935; x=1737619735;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr3AZgpAWe/4VnOS/hnlHnXvPWA7Ea0pV5fu0VlMHbQ=;
        b=MjoLvI8n+A4+iXpFclRr2puuUFP6+J9EmVjrmbD3RG3baMZo5SsVXe/tM7rmSWpJzr
         SNN7zcx9asXb7bnMffi8tX09DY/Pf68fEGvEFZzZfu/7D5lXFovQOtz/z/ZeHzaHzAwB
         OwgqDH1um6KRbpGllMnL9ZAIYt4SiaZinGYJoCStF0IDf5R4HJkXhyCwaFzTEO/d4kxG
         1HgOQW89L0OpJhgKn5RS1g8T1t+OzWGuin6LnjInJttdCJLRspFDhsHHPnUb1cDDm27r
         yy2yv3LL1Xd9PzKzA9Sfp5WtWrgoa5aNzgjtfXj+RW38r7xZAdTX5rk7yyxOrGGmN925
         l9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXsObEKP3dOcAO/t5m6vKhNsd6Vc7YPt87A6IHsnqxT3cDFohtNyWCmaw3MApxSh0C0SUwmK1RL71/d0Ukakg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyD6n6ojG8rPVvPSDRTS+ONmM8byPvhxrLs5Ct9XUYTrImFhfWL
	y1EwMsgchF1cR2gaNlAoL/gxl/r/l0w9SsNCjbyzYxbSLU4DBY3JgHQEr4CXQN8=
X-Gm-Gg: ASbGncuYn2QHJq2niinJPsqpWSHEO64EmPy8/ub7DAoXjvEM6oW1/XwwxlUeFMgZB2B
	pA2ppGz2CpwZzxNmR94FSDjf6Eflp0Ctw7GQBCrBeRbAkg1kOuwQ+1wuCqd9EhX/431LmU+4BsR
	d21DWJuntISoM+nQl7j8PePkCWHjrl1OjyBcQncImvSHlcW9IeItatw2vymEbUy03Q1YYUz7Xi1
	/HG1gDcgaYrc9ndGTqWsnaNzyoQR/MC4mPnhCn+zoxq4ojEd1uMLS71S/8=
X-Google-Smtp-Source: AGHT+IHS/tQI+KZgiPpOBaU0C7Tuw2h4kHEXmyIHIVzfFUu8R974PCCRg9snVdH9CSEC/VT7pq33OQ==
X-Received: by 2002:a17:903:1c8:b0:215:30d1:36fa with SMTP id d9443c01a7336-21a83ffbe2dmr449801035ad.39.1737014935205;
        Thu, 16 Jan 2025 00:08:55 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f13e9e7sm92600955ad.101.2025.01.16.00.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:06 +0900
Subject: [PATCH net v3 3/9] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-3-c6b2871e97f7@daynix.com>
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

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index bd272b4736fb..ec56ac865848 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1746,6 +1746,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
+	int hdr_len = 0;
 	bool zerocopy = false;
 	int err;
 	u32 rxhash = 0;
@@ -1776,6 +1777,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
 			return -EINVAL;
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
@@ -1783,8 +1785,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1797,9 +1798,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
 		linear = copylen;
 		iov_iter_advance(&i, copylen);
 		if (iov_iter_npages(&i, INT_MAX) <= MAX_SKB_FRAGS)
@@ -1820,10 +1819,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	} else {
 		if (!zerocopy) {
 			copylen = len;
-			if (tun16_to_cpu(tun, gso.hdr_len) > good_linear)
-				linear = good_linear;
-			else
-				linear = tun16_to_cpu(tun, gso.hdr_len);
+			linear = min(hdr_len, good_linear);
 		}
 
 		if (frags) {

-- 
2.47.1

