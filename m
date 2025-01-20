Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22D1A8F93
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363649; cv=none; b=QmxoSRqroO3QizwYDNTsh9uZ/+6g/dqQ9RL2Bbg+EibFN3I87R0K5dXJq2p7nlw23fPUA2ZYf9NHMWqn/896jqfIO0mmub+/+WgxMaQRbdCM5wUqWXgJVY7Zukp1ZfbensLgZAVfljpvELSDLrxOFS+LU92mhZkkqAYd+JFg7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363649; c=relaxed/simple;
	bh=LM9iW/m0YgbRl7+h6nWSsqFiOmAXB2xxJK4cNTPhNBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbPVzA+yI8wbrUkxK6e6SBGgKDV4ZiaKlCQmMAgerWm4mQvfGDH4jmdx0SjzmzI+uJWLu7MlYwrFdXGLvS+6pEZR9a8OXsvvNwSPg202PZ3KP6DhvOXTb5QkziLRPdtB2s9dZof2OEd7xZynnJJfDNmPmJvx1x2oDEWfAn/SceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZA1tNjhd; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZA1tNjhd"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAED040A15
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dG5WNQGDd2Cn for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 09:00:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B1572405BC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1572405BC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ZA1tNjhd
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1572405BC
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:46 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-216395e151bso54777535ad.0
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363646; x=1737968446; darn=lists.linux-foundation.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRUixS5CfbfDqt7hn3posZxB5lUwV0PPemsSCTV1gNk=;
        b=ZA1tNjhdBRdVgacbpJPtpG4Q/k4KI7Y5KiLXko5h9XbKzXhFuGJg7lQeiIRxanH7eV
         TbyRNrsmeWND4HNHctYX2BENhy13X5H410WR2BPHiBvMIBkcxQMOeadIpsDjXno1grp4
         AgEhS4vQuVft2rGLrtL9dxU31Jfhd8lf0p09K6q1kntL7DTJ/EZ72osTTyZpQiCNYpVm
         DbqxPxTt1fiI4Wo1U+CAaiGA1oTDh6/YXkeymysw6QH5tHkb2Gav/7qahl/GO2jNPeoj
         II7mEnyfn1wpyynuEI8U7oxM0eVUReg0EK/tbzENa2uZ4kk5SPivslhNWliC57fMjlsW
         BLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363646; x=1737968446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRUixS5CfbfDqt7hn3posZxB5lUwV0PPemsSCTV1gNk=;
        b=GFk9wkfjMXbWA5BTKHhnVshrdDQc+hl8XipyrJ8cn8t/3a1V1zoNmauGqksE+PUwLG
         8A4TXSaDYA8vYTmAWmbuK59YcZucZsx77EsicevOTmQq0UXqktE8U2AhtxdJZzvc5mEK
         lt4xsgnGqvnmAGRtXyTm3o3goRKO15U61e0gTgf05O8Pyf+RfbhTPHoBiiuJ8ZgwjTJy
         IhxvBcl6RSih6vZRYq0UA+SVpdhhjjIDzp1Z/wxWD21ei2bg5GeaopTAhBj1o4jS+S7v
         fTrxg6spT/9tPBNHGI1+5s18J6CgZF6uTWIVdw0rqnrutwN++t3JC2SbCFA9NAhVmoLJ
         GeiA==
X-Forwarded-Encrypted: i=1; AJvYcCUd9c/Ypectc7Vc+nuzM1QKdcBvMRdst2+Gd5B4pVAAOsD13BquEuyfLM7Qhep8hNsDRV+uONy4A2s7SnWCPg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YykBUfZDMISxPwtHarcnE+CcR45mFVWtChdEma1kTozNlxLbd1i
	mK0nE4uA8UNTs2oAPsAdmJMZtW3UDyzEQdL5Pc9FA/XQyGpxHQZPuFWVtgKicwA=
X-Gm-Gg: ASbGncsThfJqZW02Y2jsgJwKmfBKL+oiRxc8x5zBRCZEAsbS23JDXh58LCHPzCh0PEe
	UJ0uQyVbb8G0RM6bt/PXJWDWJiUyKsDVjkty8DLk1taEnR09q3Q5zjabZC2B8IqXiE7VqmQR6JO
	khCcyIquneB7Q8qO1qHiOAjicsmt7giq88qHAZ/EuFsoPNmckCbUTlBB+S5rRmi8AqU/uVQVaZX
	3xqoOmDtMhKoBk03LAc53MAQ1IfrVhB7W19Lh4Ges2UqtRrg8PvMguZtKESymZnwqTcFarb
X-Google-Smtp-Source: AGHT+IEks6SKihbl6+Qi45ONgGmxvxvz6jOzu1ulUFye+X8vv37vBy4sWvWutLsO9/Ck2HEV+RAlLQ==
X-Received: by 2002:a17:903:234a:b0:215:9eac:1857 with SMTP id d9443c01a7336-21bf029ddf1mr288703675ad.5.1737363645786;
        Mon, 20 Jan 2025 01:00:45 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21c2d3a913csm56890235ad.117.2025.01.20.01.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:00:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:10 +0900
Subject: [PATCH net-next v4 1/9] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-1-ee81dda03d7f@daynix.com>
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

Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
future changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..452fc5104260fe7ff5fdd5cedc5d2647cbe35c79 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -298,10 +298,10 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-#ifdef CONFIG_TUN_VNET_CROSS_LE
 static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
 {
-	return tun->flags & TUN_VNET_BE ? false :
+	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
+		 (tun->flags & TUN_VNET_BE)) &&
 		virtio_legacy_is_little_endian();
 }
 
@@ -309,6 +309,9 @@ static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be = !!(tun->flags & TUN_VNET_BE);
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (put_user(be, argp))
 		return -EFAULT;
 
@@ -319,6 +322,9 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be;
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (get_user(be, argp))
 		return -EFAULT;
 
@@ -329,22 +335,6 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 
 	return 0;
 }
-#else
-static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
-{
-	return virtio_legacy_is_little_endian();
-}
-
-static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	return -EINVAL;
-}
-
-static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_TUN_VNET_CROSS_LE */
 
 static inline bool tun_is_little_endian(struct tun_struct *tun)
 {

-- 
2.47.1

