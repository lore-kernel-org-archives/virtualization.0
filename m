Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7A228CA0
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736599; cv=none; b=Pfup6RxwM2YBBcGCPpnx6mpJ+qlxqXmW87No7CCLwhgy9TePi4LvDmYsUnE2fw6Ytah+rMzg/3qNkVXmKWdO8LCGVnV16EKt8nKehENkWAP5Ij99fK+fvIdNCFydMnzQJbQB6QhCoc3bRptBfW6a/O8MAXQMIEGpWBNvNqZUe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736599; c=relaxed/simple;
	bh=a8oH3PNmwIVYj2tKdIrFjYF4Tj+2irxY4kfMh7WOKvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=lTxruTgQEp5JIybk0ci/FYHj7Oj7wKvqPZXNaFjccjbIlLX+v+xYSdYMx0FOT0PHsvmgFSbpqJhV6Qu1RaQnE5xI9l/OpUnTONC5xyvSYdhnTiXmXb3YZJWOvYpgBphIjphlGfoaRx5wz/QV/20jCcwYYUrkV0+mMk27tb6J3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Pk3D0BTY; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Pk3D0BTY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 481F982C3C
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id It7tOV61xXPw for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 06:23:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8C09282C2E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C09282C2E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Pk3D0BTY
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8C09282C2E
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:23:17 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2f9e415fa42so386119a91.1
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Feb 2025 22:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736597; x=1739341397; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8srIBeyhs4OWM9PodAkxe8Sc4dGj/gPqaYG7YjTXw0=;
        b=Pk3D0BTYpNLAp+wXHSlRDibkC/jrbNVc7plc1BlirisBpVquUerFfQ/pAIuznKntPx
         FSWhquMm3ibLfU3nInFCrXINYCIeyX/+zZWj0eQbhPD+FGe9FDWStJo+CrrI+U+hBxcV
         9RFBm6qrCf7GXmuvb1vftRNUmiHlzmd/XI9V3cWvyQ4EtQ1y1lY6rAVyz4+2uokQvAus
         w4QskT47/bB05FFllO+5hnt1h6N4c/SXr024DnQPK8VK31UuKpL6BGIsmyh6gKcNhxhZ
         dVVFUSVlHZJYmRzh2BenJVfeTG48CQLbyxHmgfCZwjkumgY7tDoFvAMIgcYtpu+qba4e
         kWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736597; x=1739341397;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8srIBeyhs4OWM9PodAkxe8Sc4dGj/gPqaYG7YjTXw0=;
        b=AJq6AEKgXIxfp3Ik5KLTQ/VBbQgV4n59kG1xfCk+aBEGIMI9XsKcUN9aJXoQ5ycRcT
         vbXz1ftB3PE+7JmVCWHFifv+5lirZ3i85LUMBTWfihA3UkcDDAHKAGoGKOtbp0hyXF3r
         pe/zpbkKwLyfV7wLsrVvG58Bu97FuX+d+eMAsj7Ta09qRYk8DL2Mz3pvS/IEUIAndUFO
         cSaNHgtwIwXKvi+2dBf4Z68tGgMJ7VKCO6CkozqQQOc/X8pKuMDDdAEa533/g3eaN7uP
         U5+Nq0B8mtm+h8gKKgaepLyggrxsWqv5m4Roc+mZUobc7IFEZlQNuwNlgWdd9cTJCAom
         PC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsuaYsUcFH6NAUen2+COm4L5OjOqzqaYNRnIShjhtSnhTmexrF3vmIs2TgAswQx5l8TQactQylmZNCqC7BXg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwMzs7myHgYguAY9Nq6FOStEtN92FdFlduQ+EJryaGr0syW4VZz
	yLYzcbzAm9qmHRh+fqbVajOlBTOtccoSdyYtsSFUkSNrZk1119sdlKEUqonf7Fc=
X-Gm-Gg: ASbGncuPhdep6bKaH1qamZXipI9TgnyulxYFTNT/q0AX0Ha68sOTdw/vl9lCBDQ3bwu
	NI1t/JA+FR9uT+1HH+3DN3OlrunQXGpkWz98dBR4d7j3RpkK6FSIqH28BcmyzYLdXwPHAXrH1v5
	NPGiT3Iwo0vf2BgjYKiJ6NXjqPdIkfk2T7T+K10dSBId4VqWpH6yYKqfqens2TWkVdRoABuBMOi
	B22Dgkr+3dnNYxrRzOczR2rm+CRHrdZ62Pbw7vzOHWrMed6FDYO934WBceOyj6TSc1rU0XDc+Pu
	ZVPfkmtg4S277YSO3EQ=
X-Google-Smtp-Source: AGHT+IHg1+FvFT5HDL6SfSKULAJ1AqWAEtxmHva7Bnl4TG97CsA76lSGxTRKSfzGYdWpbEr3lj3N/w==
X-Received: by 2002:a05:6a00:2e14:b0:725:ffe:4dae with SMTP id d2e1a72fcca58-73035122ac9mr1991170b3a.10.1738736596777;
        Tue, 04 Feb 2025 22:23:16 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe631be56sm11600664b3a.4.2025.02.04.22.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:23:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:28 +0900
Subject: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
In-Reply-To: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
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

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..c55c432bac48d395aebc9ceeaa74f7d07e25af4c 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
+	int hdr_len = 0;
 	int copylen = 0;
 	int depth;
 	bool zerocopy = false;
@@ -663,13 +664,13 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
 			goto err;
 		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
-		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		     tap16_to_cpu(q, vnet_hdr.csum_start) +
-		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
-			     tap16_to_cpu(q, vnet_hdr.hdr_len))
-			vnet_hdr.hdr_len = cpu_to_tap16(q,
-				 tap16_to_cpu(q, vnet_hdr.csum_start) +
-				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
+		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
+		if (vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+			hdr_len = max(tap16_to_cpu(q, vnet_hdr.csum_start) +
+				      tap16_to_cpu(q, vnet_hdr.csum_offset) + 2,
+				      hdr_len);
+			vnet_hdr.hdr_len = cpu_to_tap16(q, hdr_len);
+		}
 		err = -EINVAL;
 		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
 			goto err;
@@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
 		struct iov_iter i;
 
-		copylen = vnet_hdr.hdr_len ?
-			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
-		else if (copylen < ETH_HLEN)
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
+		if (copylen < ETH_HLEN)
 			copylen = ETH_HLEN;
 		linear = copylen;
 		i = *from;
@@ -697,11 +695,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (!zerocopy) {
 		copylen = len;
-		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
-		if (linear > good_linear)
-			linear = good_linear;
-		else if (linear < ETH_HLEN)
-			linear = ETH_HLEN;
+		linear = min(hdr_len, good_linear);
+		if (copylen < ETH_HLEN)
+			copylen = ETH_HLEN;
 	}
 
 	skb = tap_alloc_skb(&q->sk, TAP_RESERVE, copylen,

-- 
2.48.1

