Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B95228C84
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736562; cv=none; b=acx/9wf6k2Oc7VdOtB6y4AVmdNR3RqwG/wrtDBPVpm1FFwPE8LGxzDWJECT0mxaSKiyZAWGAltT/4COV3WlI0sONbpNKCZPjrLT9uErXao9CqxOiNmVWSKjYXyy4MAQEoHl0zStrooAZX/gxD5bj4y2RxS0BpMxZjcSPV9cMjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736562; c=relaxed/simple;
	bh=k8AT/7ba0LLNdr42q8vL3zcMMHDDU7sY3oym4vZIyT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IizP9jYZv213MR0+9cuXprngRgOeT1aMdYpNsOo2gECHN6c9PyVyPZdXZoO6FlMbb3V9T/vg43H5RdXdPmdl4QQ4nTWm+gWuAe+yo70jf3JOMv/E4aHZj8FkTRsy6vMMy+gY2PV48n+brN3aligjVGlKdREVcwvzwDjFcAz8jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UsDbUCoQ; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UsDbUCoQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D41D60E15
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qO6yqxf1rUK for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 06:22:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A2D7860AC6
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2D7860AC6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=UsDbUCoQ
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2D7860AC6
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:39 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2f9cd9601b8so2163014a91.3
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Feb 2025 22:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736559; x=1739341359; darn=lists.linux-foundation.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beCLR6fS0dAzFFFSsVjnikGsGyHpeeQQjgoShxHI8aw=;
        b=UsDbUCoQK52Daw0b08EFmW5r6Z3+oii7r+js+AKUBpnKSo/WgRMJcFsqiqO94Vnb+G
         yRb/1bqtxVUPeG2OxoIlXak6wtc/EuFJAqVhnrWjxCt3UIfEu/eNwYFBAvdxGJNpybA0
         WXgvUSLs8zaZBPRACDOnyI/1ql3uEkVbXT9KL6p0PemTvU3jMHQvlaTG9o5mwJC4Zf6s
         Tp1oTLzQ/Yl8Movp0lVagpikKak8Gt5LKhzIP82WckK9ix+99JhjG2gTIpNnD9SGbwpA
         IEftSdBQoUJPqYLMwK6ae+HrED65zT6DLQHZyKLg9PejKKlRpDE/I1zsYPysvQVLT5GF
         ANWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736559; x=1739341359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beCLR6fS0dAzFFFSsVjnikGsGyHpeeQQjgoShxHI8aw=;
        b=rQun9Ook2pZMHK4z+wghyQj6ROnKxT+WwW6iHErFRcRJ66m1iDuyAGQ+GbSziwTX8I
         N+209xt2w30dlOhlxhCZgnV0TH2z+Kf417bG2m/H0tzeLoOj8VGe17+7wCu5TYbvB8Tu
         Fk5F20atR3iYipR7KlN6D+Ci5HpnJRgWPWrwJy1UIKl9IPSZN+WU42TbFLwNs1jtIABE
         vA+MDiztCeKILgCcpw07FGP4DCqcSGzizKxdz+T6VF6Ug4VfcpNAwwKc5oUyHOefWYHy
         Pyk2IAXgo853zkDloksSScJMAMCbkgw/LQ8ZhpCJDXnNwh3J2xmN8LSGoTZ0A5K9Hk1M
         U9VA==
X-Forwarded-Encrypted: i=1; AJvYcCUAcI74jttjNsOlBLHQ37NCSY6ubH4mQx0y3puwBfwFrR4ImNyx/AyFKcZoM3iYHUEb29oVkEQMRGdHiBprdQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxYbEaPI3XIev6yumX+4m77D+V4USpHU7l8Gq+AGkny65cHBWBf
	fsOu3K9jeIbfQ1atl+ZMmQEiIAHq6ECwuqKM+wt3Jn3OZVNdf9TyJmH9cKD2630=
X-Gm-Gg: ASbGncvAO7v2nmEREnHurldK0Gw65k5TdZH28b1dK/4h+uqU8JurS/39D56Ep0IEzVQ
	ibIzL94CLCGG/YQrd6ZQIr/rLnaZUuaznxpz35zC9SFYNWi4TvCBhqKCkc+FQ5Rd+PZQLl7tYDL
	m7O1Y+h00JAZv6CyxvlkXgjc7ORsI0CDyWgtfvS+FN1N1RgFFKnIx/kYSOLj3UaRBQKPQS828F2
	0UaZPFkNk6WjSuXv8VNlu+H4VoOW8NvYGMLe3B0rFwz/2AzbT0AgWs8EJcIfzwm6mNH2ahhDMM7
	JxIahg02A9mKAnD+xB8=
X-Google-Smtp-Source: AGHT+IEkltYiingUuvZ5OPE7k95CCEI+ZGRFDs15kcTYl15oURn0Qzmrf04BT6IAVXnOElwIy1y3oQ==
X-Received: by 2002:a17:90b:3c52:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2f9e079b0efmr2575681a91.20.1738736559002;
        Tue, 04 Feb 2025 22:22:39 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de330462bsm106232865ad.204.2025.02.04.22.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:23 +0900
Subject: [PATCH net-next v5 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
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
2.48.1

