Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC319D898
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363657; cv=none; b=qYnAzYjdQWHzS6jWqnvaFclTbLgM8+AtckaOyyW/Ys4QZ6LGoUPA+M6LL8HqzEfrYjbLThZVwVoGcpUAezniZ8hcOrlQtEjxO4QxJcD7rLq9aqZfiWhgsx7QaLB2kOxrECfRcmpEX6lAuT6Y4YmYO6jNNGmlKTx9o4bKPipK/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363657; c=relaxed/simple;
	bh=zHg9Cy8I4qWXw+IxBd6zljTvx2oEOGkHWlUMuk6vkYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=euQHiyaWQXe2HU/mVmGvataboTPTQl84vOcPCLV0ruR0Tgf31ke+hv+2RzJqzyoojeHWrfhvbJTtSAHYPogz+lBmZ+svVbH9DGaB+/O4p2dEd5GYJZzbQY6rUkDBR23ZuEkVowYgDzsnsp+6zYTBdMk4JSlEkRO57xQQYqZzLCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=kZfUkR4d; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="kZfUkR4d"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4CA460BD2
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IvzVpTLgRCds for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 09:00:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E16EB607AE
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E16EB607AE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=kZfUkR4d
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E16EB607AE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:54 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so7293305a91.3
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 01:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363654; x=1737968454; darn=lists.linux-foundation.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VePH2j532nDqTqhBPliR5apz+cKR0EPoqHmjo/gIw7o=;
        b=kZfUkR4dfXJNg5rak4cVhLe2fW/2+OJl4LNZBYksyBLScuqtdAAK6sB2s0QR5ECrew
         96HOG3Vhzy7K6dz+wb06Whh+mbJhEz4TFUHqOlCxqUPIMB/m/200pKMk+r4tRtl47YyB
         /d61TwZPgyRU+Msk4FuQ77bb1s6zqtQtLKoml8Mo/BLLhN6AkAMXdY2W7+WQkdcTIXx2
         GeUMqBMZ0BZHbiYjObXpiuCUxtd+R7w3bK18kcO+2gN2L9ZXrbPdOeS2ov1j+TX1EcJo
         dNCRK+9pDDtnFpAULExkglLVV7pbjLCVIxhQZ9SvQ+yPhrf7Zi3KChS2yW1xFfbSSn9E
         XV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363654; x=1737968454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VePH2j532nDqTqhBPliR5apz+cKR0EPoqHmjo/gIw7o=;
        b=kTuIpVRrP0A995zv7+kpYIg+NikYxV2s+06HBuh9RmU+pNMl/aHfDX41+VobQwUgkF
         YlZTv288mc8QpE66xcRRLfdexC0D+aBwK+W0LDGtGMyZoLEk1EOxqcGIyA+FBfO/hLP0
         MqoNna7w1dCxEk8etoAL3VlIVwoKhtPfcdJgN+H5fXtsrRkoDHz4YkP6lUx1cCsU9O4Q
         CUrjukYF0as88vkDoMim7B5CtqeCUuElpzFtxUl4XrdmTpeVC4nImzghFMEfwFy5b5Bm
         ZuKV6V+EisZ++Np80Pn/Sl7chJtV50LeF6EL/PPWJQkPyAz82cvUU/+Q71ivSZOgs62u
         0LrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7I10wIAGmmxM+aBs+vfKVBn8gnFa3UU0oqyW+iMgJ9bz+NEjQmpCtPPVT6OgstL1ZKWj9uiKUISwvQET3jg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyh5FugkcdNTDcRw94AwkH+rKMSCijSS7L0qJWKZFZu3AcZj3FB
	kXO1JkoQ0kr4pUBCPyPiGg863YBwAS+cA83cDHKy0vtlrfHKwqeYScXwJIxPn08=
X-Gm-Gg: ASbGncsInPJYGUYmUEJhQpru9NSvf5mD3yi6YbD478HQep/iy7tnoQnMuCZYmSTk2Ho
	WGcf7kcBe2VINZE5LreQK78uRPsAW6MMUrCNG9pQmrhE2EKQ6in6B2Sqny+MndlEiTR4zPp4CjF
	MYuYUaa4RlUh1/+vaI2vNxsX+kI4Zs+O6rFbsm3bSrkXVTCN06gWVigG8BZuaSpHKIVMLQ2qNdZ
	dP3pe7pgwhVW4eclDQRVsUt34BeOyLePuzZaxx5iisCapOb6vDhXVB0QtqQ4jzg30UKlbBv
X-Google-Smtp-Source: AGHT+IF9xy+qbBUCxeeJNWw0q1iQeKpxfAGNhBsUiRjFFk20hQvN5icVdaETT9eWWpl4WoKAAydh6Q==
X-Received: by 2002:a05:6a00:a95:b0:72d:8fa2:9998 with SMTP id d2e1a72fcca58-72dafa44feamr19326150b3a.14.1737363654076;
        Mon, 20 Jan 2025 01:00:54 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a9bdf0b50c6sm5386971a12.68.2025.01.20.01.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:00:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:11 +0900
Subject: [PATCH net-next v4 2/9] tun: Avoid double-tracking iov_iter length
 changes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-2-ee81dda03d7f@daynix.com>
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
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

tun_get_user() used to track the length of iov_iter with another
variable. We can use iov_iter_count() to determine the current length
to avoid such chores.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 452fc5104260fe7ff5fdd5cedc5d2647cbe35c79..bd272b4736fb7e9004f7d91dc83c69af5239bfe0 100644
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

