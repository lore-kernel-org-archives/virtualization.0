Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B152343C7
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908710; cv=none; b=kLT5uaNMu3nV4X3ZhrJxUAdTgBZiBoXTdo3quxHEdxGGjLr8U0M4IH+MyJB9wfa+N1yR5Lfhua7bIKJl3W1xKgpx4XdAcjTDWWOgllZmw0uFiHqz/WXkvTFxEBK/N98qwzKBtex73nRtGYjtAPwqtnBu/rVEhj/G+4x8WxZseDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908710; c=relaxed/simple;
	bh=nZIPHAA5zCJF7swo3jDQ5RjM5zm8qMnIWTvWpC5hGqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=l0fTHJDfAGB+GpSk5S4Fii0nrocCdx2IWbwjM0Pv/35OfvB3q3nm5koGiQ6jDRLweaQjlCgkJ2clCxuXoVO6vh9rxCE2BM6CT4I0NUF5r/ynkjW3YdXOFZ/fX0MexT3rFmVC/xzMxQmXHvrMoCk2/a/hG/U3U0Z1G5Nz1xH5SEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=C4dV+oc/; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="C4dV+oc/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 44CC340126
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpUTZtxErQKg for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Feb 2025 06:11:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4D034400C1
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D034400C1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=C4dV+oc/
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4D034400C1
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:47 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-21f5a224544so285735ad.0
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Feb 2025 22:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908706; x=1739513506; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4saBNfFGUdtw4heVChkMZd5FykA/GmW9Q/kNvdZqu3c=;
        b=C4dV+oc/swH5F5RHIGj+Z/SkmtHrq2Ck6CHNf+PtDfx4o0KI2m9ByS6i/Dv45W/mTQ
         Nw0IxzEXHP0eVSzPeqKk2qRCHc5NZC8iSfmmRWRiaU5BgYrb0x5EOhVwK/KkFvYBzxhn
         couBEowHy1uPm17xG33yvZoyPCenDWYjD/XPUL2y2JGgpJ17SneQ2ZgAWixBAJlJ5Sc0
         OK43GAAoVluYhxOgV1IscpV2cLG0IUSamNOCQGxm9LU/f/HIAg93IXe2DPd/FvXQRZtp
         wVnnEStqBYMOqPxRXcw2AeB85aOExwcMGUJyx4LT6Eq6k5BaLRBibrPeO3EQoGb7C5Oh
         oDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908706; x=1739513506;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4saBNfFGUdtw4heVChkMZd5FykA/GmW9Q/kNvdZqu3c=;
        b=aKz+LOLKJa5Md9Q2NoE6iLjrCh0sv8WpxZmFqrbxLUO+Q/nXV6YkKcVJqugfdNfgL5
         IRWsQ+xZj36FeUaDcSAXSl4AVkf/B183T/GiUI+yM72Z2BQ0CZVrfxSnghcfwttCXCo0
         zNAG+uRcLjLl5HU2Ked+XmhVWG99VCMTozM0CS22vPxXr4aeBQ9tNIuG3TzjQBCNY9ND
         6Ta+WaOUJlifKXM/JmpythaZ7GkuVuFLQqhMw2Udr/qCff75w3528s57QwCwC3Vb+2+z
         IqIkFs8234XxHyP5DOcNqF49s57Kjxy1C1qKsV/kVgV6peCXQ9t/lMJddmM2Ds8P7vu1
         TPSA==
X-Forwarded-Encrypted: i=1; AJvYcCXZtPVqa66rHpRzVj8brLefUrMms0HizTPr8gd5NpXUaRi8QznLHRIpZ3Ix/lE7F+5ihyGgS7zwi84gybyGMg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxBdw3W8vN6JOnHY4YVmP775F5eZdWyN62ZAY8aKaeQNykZHQN9
	b5ZW/9j8menKgnZFqdHO5JeDk19Ae5Q/jWmyPlsS82e7owbTLgP+85UrH/vtvOE=
X-Gm-Gg: ASbGncsCbQbUIp8AduGa1JbJe/fUInSM4/GZ24aeL+oVG5gzJd4Qz7K4GFOG30gm1ao
	M2GKASuLf/TaD/8CoqbCHKziiaODwbLeoZrUoOlPd+lb+XR6i7Qv9VZAcRvTPGwHDb2dD+XrI0T
	7w66C4fJX7oM7viFsAz6S7xBnfxv02IreaMbbe6Gu3InsN2gIDGsf9dfPZM9cG6vX815B+7kg95
	D/Wm2sJ/xrLssLcf/uLLOPDqLW2bNgt4yNbiP73Rp72y1k7JTB5O/r2ZztgYQY4zXQVmDqLdEdt
	coJXP7G1LR75O53O6zw=
X-Google-Smtp-Source: AGHT+IES1fBH9Xm1hn7eMcWgU4qwNM0YJ/XgnSVms60Xt5aaLNJShgX4JEQoDPxBZLAVM7x/w27pJw==
X-Received: by 2002:a17:902:d502:b0:21c:15b3:e3a8 with SMTP id d9443c01a7336-21f4e7636d6mr31492145ad.37.1738908706650;
        Thu, 06 Feb 2025 22:11:46 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3650cd10sm22742625ad.31.2025.02.06.22.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:56 +0900
Subject: [PATCH net-next v6 6/7] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-6-fb49cf8b103e@daynix.com>
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
X-Mailer: b4 0.14.2

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..8cb002616a6143b54258b65b483fed0c3af2c7a0 100644
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
@@ -682,12 +683,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
 		struct iov_iter i;
 
-		copylen = vnet_hdr.hdr_len ?
-			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
-		else if (copylen < ETH_HLEN)
-			copylen = ETH_HLEN;
+		copylen = clamp(hdr_len ?: GOODCOPY_LEN, ETH_HLEN, good_linear);
 		linear = copylen;
 		i = *from;
 		iov_iter_advance(&i, copylen);
@@ -697,11 +693,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (!zerocopy) {
 		copylen = len;
-		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
-		if (linear > good_linear)
-			linear = good_linear;
-		else if (linear < ETH_HLEN)
-			linear = ETH_HLEN;
+		linear = clamp(hdr_len, ETH_HLEN, good_linear);
 	}
 
 	skb = tap_alloc_skb(&q->sk, TAP_RESERVE, copylen,

-- 
2.48.1

