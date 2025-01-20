Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32911AF0AE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363704; cv=none; b=tOuIVDuL3F1ZcL0tPO7ZbT+2PmFUZFa2nOJQzAWdRCQiu4uf4M+WS0h3j7ZzDOvdfAqP7mWIGuVcWSXUPuD3Z/b0Ix35fvQT2Rl4zVfQJgwUORzOYhirkAH53iPkgJFXzixUaonj/NAlJ5AevDpYuaRu3twI3l32bE97rkGsP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363704; c=relaxed/simple;
	bh=HCC1TB2JnsejBIhQXiuHZ87jAkzuIxmozdRWSI4CgLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Dv8f2glU+bIU6AMB+zJekqafncVCVfOhimhhySPONefIt4XTofpDD0ce5De09XPiZtAclISRPbz1c+3mYq0uH/XfJi+iT6rekTF9GyArHeKfZnH5qNzcCTmPgh7FXVhlv9q6E/HttO+nnowbqguuYXEZ6CZmAdqS38gn2+xwJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=LYKUT2uq; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="LYKUT2uq"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C57B60B9E
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5KCg2tIu34b1 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 09:01:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AC102607AE
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC102607AE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LYKUT2uq
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC102607AE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:42 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-216281bc30fso97115275ad.0
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363702; x=1737968502; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87auSTBirOR9mtDtSjr+Anr6dOurfYcbwGKWr12CzKY=;
        b=LYKUT2uqX84GdQYwPMmZPS+ybbRidqM/y8lfB1f7q5hUmZzUM+Qjk94pa/OANW3VpE
         nNtGgiZ+POJarpgwhlj/gQJhO34dPkh7AxQxEaVDHH/4bus755zBoXA4Hv16UWF8H25k
         fc/nNr18kUmiPMX5WF/vUQdZnHSigC2QfcH7ByylwQCPoTOlQXZ+8I0MLr0M9NjFSuK+
         VlrSFhKZipyrLXMqy2/L70xLqvA1W5lreQGLU63JeRoQFJWiOQkAIZYwXJUTJw5bKFz1
         RdxQFmhCpL3BR3DU/uKXre+lrXWhadW0jEu9Pqg7ZsOnILQ9N2xiabHPhOC/W0ucNQ6R
         SU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363702; x=1737968502;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87auSTBirOR9mtDtSjr+Anr6dOurfYcbwGKWr12CzKY=;
        b=miNYpLL1DK3CaOqH04ZebpmBSiEaROmTEYttjKudQ3LiqhB/b0fSKEaSUit4o2J21d
         Pc6o7+eztYiEKIeUa/EcyVgpTE6ggR0RfOSH6rAWB5cmj5dOC5YyyOQnZUjgHAE1/keK
         MyuIqZRmrPfTxNg2v/dRoFqdRXHGfy5vqDLaXySKx08zVKVYj5TF+6MsyGu46+xX8oVI
         z6z1UPeqOUtlR+/sA75NIwSX82A3j42fXDVG1/WnRcbv2QVt2wyNBxHWIX77kW76I213
         1BJua/iOWiPHhnf7MzHenQ81BHttnWzJajq4pAj1C/aMwHGVUD6PgiQta6ieyUTwlwht
         e6jw==
X-Forwarded-Encrypted: i=1; AJvYcCXBwAAYFTMpCiBquhcE24Jwk+DbJFRsJf19dKUt1jkmPwnwQ46dmSWZQsNBGzU3slhc7PjA6/fl3JroXVtY9w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyNxypgq5EXYuXKCggCVgxzLvVpS62Ti/tLXpwxCTN4/W2BJxa8
	gD1p9jvYC9e1ctjAPvxtrHB6n6uMxrO2B1ja98Ura1vbYvg8KimUbpyqsFg7l/c=
X-Gm-Gg: ASbGnctN/Lh7glnvH5QWfKX+JAku34a61KvhxZnzHKuc/MSz2LuxO1gFgUNlzOoNUSU
	RTFJtfhD/gDnMZhk0xnT1iVVbFYGcKUPH0voDJZqq2q/Ifrd4g7nOh+POiE04FatTWn5xmMN/XT
	/uU1uIHI5lhntRMWMP6+S1UDUtug7zCKUMJXkCf5apRawufe5vImNGuMQJzpGT6ze+nNlrxDLw4
	Eqllcj7o9KTuLVTUqIa6FiJCaYW830d+fZflEUutLOAqiaiSnlW51hXRvsigbNtQKx7Zn9N
X-Google-Smtp-Source: AGHT+IGLR93WqsCZ053+MjqXMxSgfHfX9VZsicHSXVEe1/bIQZebS5wSQUjIqaTjuz4uKaG0GOmcHA==
X-Received: by 2002:a17:902:e948:b0:215:6f9b:e447 with SMTP id d9443c01a7336-21c35621db7mr180247815ad.30.1737363701892;
        Mon, 20 Jan 2025 01:01:41 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21c2d40278dsm55514515ad.223.2025.01.20.01.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:01:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:17 +0900
Subject: [PATCH net-next v4 8/9] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
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

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8..7ee2e9ee2a89fd539b087496b92d2f6198266f44 100644
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
@@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		err = -EINVAL;
 		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
 			goto err;
+		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
 	}
 
 	len = iov_iter_count(from);
@@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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
@@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
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
2.47.1

