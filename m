Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CE154C05
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908680; cv=none; b=DRjhkoXGyDWTnYIgh+w6IhI1GGYrNnoZf6NuNgy79uRUz3IfnEFtwfEZ5tL7q86VyojIzDHyQg+rLY4C0RzAZqh6ZigCISUOLMyQletnTpTEuSReCpjBwrpgPO5rs01JARtOYq8Qkr8ImZixRzUWtmiP63/2+8rQUfwyqRtD83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908680; c=relaxed/simple;
	bh=jE35WmComX5JeKqlu8MY6L9RXnyoavgFojt+bgtRKqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JETBFxO4chfU+7KcyNtWpLOzGM2iXXKRLQTBKE6yw9ZcrkxY1U9PqZeUsc1XtJGgZDUnBWiDFPmM8BWw0rjd/abPj3Hc3RCh/OF2z9TJzt43jR2ARcA+vEo8+Jp6MP8pmrUiJnnQQwqe8tWYEquV43jvhb26TBENihWeMFit9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ecyN1Pp3; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ecyN1Pp3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6D0E608B0
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfcWzLc4Z-Je for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Feb 2025 06:11:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EC53860A73
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC53860A73
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ecyN1Pp3
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC53860A73
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:16 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2163dc5155fso34466945ad.0
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Feb 2025 22:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908676; x=1739513476; darn=lists.linux-foundation.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgBnzmCjscGqJo3YceNPZPrt+CM1bxg86tC2DNlkHjM=;
        b=ecyN1Pp3IEaKjme3wjbZbQ3j6BO9/+w6QYYCIZVaaHjVgKvZDXAeaMy8rshdVEreH4
         8iUcoB51GeWJ43on/sSYhMJCQdn3e0jPjsDSzo/UV361ZYR+/Yw/lZbdPyDKVt1VMp3U
         mY4rSxbGFgBA5rT4z4MZ9U1zFk1um9jOnW9Oka9kWHBXWqdPtYBRUfIIKFyBD5qGffoo
         gZ9Ve06gVY1PwT7q9Hcs2vzgmfKc6A/rpkFfClv8VwaN8hUuHm+BEOy6AM/9M2peP0zB
         HqGJ44pbTDpdh9VhjSNgO7iL1z6sVcGBMHITgGx0w7waBz1c3bGSyAOrV8kRU1g4CVdG
         lqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908676; x=1739513476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgBnzmCjscGqJo3YceNPZPrt+CM1bxg86tC2DNlkHjM=;
        b=SFt+UjuA8jWdYQGkCDelhsO8+J7gjb/yjrmEXgTadIgffxPhUIz77qLO39FhveSbNO
         9wuurY5iRJ7FHMDf2yQHfumTWbwDv4qL//xSFdZxfjY0P4rK2RP5iEyWGpJpBErjgftb
         nMafHv3WfWhQ3PNvORrdOZ3+Us7wUA35yQfOMb3YVBXXydGotx07Arwnbtn2nX9Ypkjm
         rGbcAY8XciFqFSvFldGVe24wfT/ts1FRN99mf625KJoE/9fGM+WXcLzpTbjnNJ7/6UTp
         LUWtrDmIxf6nbR5wkl3s1bFaL+w1cpqxrnqAnkmMYLnAGy1fTU3Kjb9Qo/P8kCuttF4A
         sqXA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Rphwa1YDYP3rKpg7Gy5uXjtKAbq2jWH3fLJ/9PPE4VELKsHxRgtoTTrVpO62rNmQbk9rWHixqBLUtpZfcw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzHNgVw/Y9Sf2S/diUA+UnfYHo3UOWHUR2cg9efhdeBBlJGXQRu
	TNa4lUD9Y6S+fhtHF3pkx0OSpRiCUS2cLhDamn4Sf3q39G+QAMtNW1yZE2D0I9g1wSROx8WlMI3
	OnAI=
X-Gm-Gg: ASbGncuubR44R7TrNVR+YAr9y2u/WKTeCft7Pf104nN8nTsN4uykdDhXd8q53Wuc0/8
	1ihjaggtBrkkIJ+KEjQY/i+osAiP3KtsB4NUHWcbLaAV0ggZzwm7e5b8TeHeu8tmvjQFbS++0Wg
	Jd9lbP21Vv1brr9OHJvSyF6KqY7zomf0g5sQNhZWuyfAKghq1R3ejM+0iXzVS3hOiMYJDO695og
	BTG1TxE9QUk8SCYY8J6tB7Cpg1WSv0H8BSFL45/EZ8QR2LE8DYxR6LoPzSLvl5uM9sXfIj19GOy
	c6CTXcmMNzw5MpGasyo=
X-Google-Smtp-Source: AGHT+IHNm8Qe5PeRd2q8oSkdrncjlnlT7yuIXN9pgtXzJ5BMLmj/G1sZ2QlSRnuDA+GVs8YfE9jCcA==
X-Received: by 2002:a05:6a00:244e:b0:727:3c8f:3707 with SMTP id d2e1a72fcca58-7305d53a584mr3469430b3a.23.1738908676268;
        Thu, 06 Feb 2025 22:11:16 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048ad2623sm2302419b3a.60.2025.02.06.22.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:52 +0900
Subject: [PATCH net-next v6 2/7] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-2-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
In-Reply-To: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
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

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 4b189cbd28e63ec6325073d9a7678f4210bff3e1..c204c1c0d75bc7d336ec315099a5a60d5d70ea82 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1747,6 +1747,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
+	int hdr_len = 0;
 	bool zerocopy = false;
 	int err;
 	u32 rxhash = 0;
@@ -1773,19 +1774,21 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (!copy_from_iter_full(&gso, sizeof(gso), from))
 			return -EFAULT;
 
-		if ((gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
-			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 
-		if (tun16_to_cpu(tun, gso.hdr_len) > len)
+		if (gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+			hdr_len = max(tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2, hdr_len);
+			gso.hdr_len = cpu_to_tun16(tun, hdr_len);
+		}
+
+		if (hdr_len > len)
 			return -EINVAL;
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1798,9 +1801,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
@@ -1821,10 +1822,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
2.48.1

