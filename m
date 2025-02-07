Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3D235BEB
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908687; cv=none; b=iNZzSwKUJiDZ9AZrgsDhxdRPDbn1y0x4eDe8EZZkF7kNbE78tIV3aaz1jGxZQktnVN6ju40bhq0g29iCO5XS8elkIRNDPU9CnHNB7Q8YGiZ+RRE0WWUpdl75mpNuZVgh06z8hBsNYyT9ElGI6Ch7FHAjvYjURpTbPNQmznk0Ulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908687; c=relaxed/simple;
	bh=bBQXhUVCx6X6zVGj6QFAXw2H5wdiIPqhAd8Xerl1xf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKuwn724escG+F/IKRSx0A010UFGPUSREwZVnTTtrC33Rfk4PKVtxlFe3R7sOo32MEsvoayXONVVm9yZNPaPvdnExJoesRbAWnElp0IT4m9We8WLexsn1XcwvgpX06zh8p+mFboIDuTv5gpymZc8aXi7mrgGxpymGCvmBKlDB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Nip0TgPi; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Nip0TgPi"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA32A4060C
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWRpH3_oSTc4 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Feb 2025 06:11:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5ADC640126
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5ADC640126
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Nip0TgPi
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5ADC640126
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:24 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-21f20666e72so35854775ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Feb 2025 22:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908684; x=1739513484; darn=lists.linux-foundation.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/RuN2hMDX+DTthFVqrAA3p7jQCQREQBjwaJUnbA1mI=;
        b=Nip0TgPiU4kFSz9x8eAwjG46K5AmpKFMX6qdTWltEvHXtD0NwOkBC/LfFn5XrELqN+
         DB0ZM1v98NE4ia8ulHHlNTHRlOApDoFcROGPBMLKBRSM1St37q4zpYjMDR9m1fxJ2BNp
         vZts0a2LK9qy2VGAPdoq+oWnTpbCqVVZLOGctD30ZZyPlHqbD0S2KS4vTYqIbInpvhCo
         bxCPrEmkL2+nOsdfOb7LB8BbdoWv5s5J7rxQxt8QcLQfnJ2zZI7AS4yPwMG5wB7Aiag5
         Guisptq2Y3r3fclRbLN9X50vSAtiGSwaSWqfwvDAR6C6b4oPvrLPUpji6Pi15OtzkbQ8
         xbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908684; x=1739513484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/RuN2hMDX+DTthFVqrAA3p7jQCQREQBjwaJUnbA1mI=;
        b=dIp7Ss5gIkN0NHZnsgIzM6RSUbxLCA+PeEQFRs2iMCcfrMZqv93DnklhoNw8b5cUiB
         K52B2VFykh4cRRHEudxU9/VsgB7GF8162zhpDPJoUFfv703M6PZqW9IuyyqFC8B+/Kyo
         uvG3b/5SJzqmrJ+ZQpgWIcL72vvl7xYgrZyBYh6e83lbgmFx5gufamjLScceW85jWK0z
         x+Y86QWQXiHh+Mlh+hLzzdXJ2pZuiBAbveHNPw1pZs595Ryzk8Q2QXuRZIAhQsxTlTYY
         810nsWFC4brmEf2CnR6e/Wz3Dn/QGVVsGyDMguFUAfR9VpFQ8a4Rrf+e1YpFm06RrwQ3
         VkPg==
X-Forwarded-Encrypted: i=1; AJvYcCWAHWUTTNttJbViGMRWbqvQD++XY1timEJdY88VA7zcesS0c2p3V0CnRvSOTD6ewvguqc8veUbRWDG7N+03rg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzFp8+aiVc0RDZv3JIpN8lMRUzlAk8bWKUyvlD0cOWbmabT07wn
	5JbTU9LkJPrx9uOP9uI0XtLP4Rg2eNm4TFEpjNKoTmv92DOHUx2VcbsIrEMBFj8=
X-Gm-Gg: ASbGnct3rw70VXUTxZd8ileLut8zWHC3NGx3MAF3IAkMjXoCqCrCewfxTsqW4TXBo8R
	7SWuzoQ+9DNu05z0YUQLmLSodNiZ84tEcxcnAZJLjmUDZ6dxAZfQScKIFsDoM4nVqtCe4kzEWrB
	8IKCm4ESkoYZ2lbArTqfu/YJrVUFGroDu8oN/IT5bGfWtXhEqssH0D3aJe3T7Gjx9asnLvzmp1y
	CrBx+bHMaXCOuVJSOWgIkIwYu7X9V2bm1KfjEModdWJf/v9iaYwaSH/lXjIPMB7hT0j643EKVf6
	6nz0yZwcRjuSsoqTUKg=
X-Google-Smtp-Source: AGHT+IGKXNfBtm98NzYUcrTp3XJuz6e3YpYHzpl1lbmzgAWqjm0gMeX4pN7AZUkDcA3OCHSyub6G8g==
X-Received: by 2002:a17:902:ef09:b0:216:386e:dbc with SMTP id d9443c01a7336-21f4e6c22e7mr33527705ad.13.1738908683719;
        Thu, 06 Feb 2025 22:11:23 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3687c5d5sm22833125ad.166.2025.02.06.22.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:53 +0900
Subject: [PATCH net-next v6 3/7] tun: Decouple vnet from tun_struct
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-3-fb49cf8b103e@daynix.com>
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

Decouple vnet-related functions from tun_struct so that we can reuse
them for tap in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c204c1c0d75bc7d336ec315099a5a60d5d70ea82..28a1af1de9d704ed5cc51aac3d99bc095cb28ba5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -298,17 +298,17 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
+static inline bool tun_legacy_is_little_endian(unsigned int flags)
 {
 	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
-		  (tun->flags & TUN_VNET_BE);
+		  (flags & TUN_VNET_BE);
 
 	return !be && virtio_legacy_is_little_endian();
 }
 
-static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
+static long tun_get_vnet_be(unsigned int flags, int __user *argp)
 {
-	int be = !!(tun->flags & TUN_VNET_BE);
+	int be = !!(flags & TUN_VNET_BE);
 
 	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
 		return -EINVAL;
@@ -319,7 +319,7 @@ static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
 	return 0;
 }
 
-static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
+static long tun_set_vnet_be(unsigned int *flags, int __user *argp)
 {
 	int be;
 
@@ -330,27 +330,26 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 		return -EFAULT;
 
 	if (be)
-		tun->flags |= TUN_VNET_BE;
+		*flags |= TUN_VNET_BE;
 	else
-		tun->flags &= ~TUN_VNET_BE;
+		*flags &= ~TUN_VNET_BE;
 
 	return 0;
 }
 
-static inline bool tun_is_little_endian(struct tun_struct *tun)
+static inline bool tun_is_little_endian(unsigned int flags)
 {
-	return tun->flags & TUN_VNET_LE ||
-		tun_legacy_is_little_endian(tun);
+	return flags & TUN_VNET_LE || tun_legacy_is_little_endian(flags);
 }
 
-static inline u16 tun16_to_cpu(struct tun_struct *tun, __virtio16 val)
+static inline u16 tun16_to_cpu(unsigned int flags, __virtio16 val)
 {
-	return __virtio16_to_cpu(tun_is_little_endian(tun), val);
+	return __virtio16_to_cpu(tun_is_little_endian(flags), val);
 }
 
-static inline __virtio16 cpu_to_tun16(struct tun_struct *tun, u16 val)
+static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
 {
-	return __cpu_to_virtio16(tun_is_little_endian(tun), val);
+	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
 }
 
 static inline u32 tun_hashfn(u32 rxhash)
@@ -1766,6 +1765,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (tun->flags & IFF_VNET_HDR) {
 		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
+		int flags = tun->flags;
 
 		if (len < vnet_hdr_sz)
 			return -EINVAL;
@@ -1774,11 +1774,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (!copy_from_iter_full(&gso, sizeof(gso), from))
 			return -EFAULT;
 
-		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
+		hdr_len = tun16_to_cpu(flags, gso.hdr_len);
 
 		if (gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
-			hdr_len = max(tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2, hdr_len);
-			gso.hdr_len = cpu_to_tun16(tun, hdr_len);
+			hdr_len = max(tun16_to_cpu(flags, gso.csum_start) + tun16_to_cpu(flags, gso.csum_offset) + 2, hdr_len);
+			gso.hdr_len = cpu_to_tun16(flags, hdr_len);
 		}
 
 		if (hdr_len > len)
@@ -1857,7 +1857,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 	}
 
-	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun))) {
+	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun->flags))) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2111,23 +2111,24 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
 	if (vnet_hdr_sz) {
 		struct virtio_net_hdr gso;
+		int flags = tun->flags;
 
 		if (iov_iter_count(iter) < vnet_hdr_sz)
 			return -EINVAL;
 
 		if (virtio_net_hdr_from_skb(skb, &gso,
-					    tun_is_little_endian(tun), true,
+					    tun_is_little_endian(flags), true,
 					    vlan_hlen)) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
 
 			if (net_ratelimit()) {
 				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-					   tun16_to_cpu(tun, gso.hdr_len));
+					   sinfo->gso_type, tun16_to_cpu(flags, gso.gso_size),
+					   tun16_to_cpu(flags, gso.hdr_len));
 				print_hex_dump(KERN_ERR, "tun: ",
 					       DUMP_PREFIX_NONE,
 					       16, 1, skb->head,
-					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+					       min((int)tun16_to_cpu(flags, gso.hdr_len), 64), true);
 			}
 			WARN_ON_ONCE(1);
 			return -EINVAL;
@@ -2496,7 +2497,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
-	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
+	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun->flags))) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
@@ -3325,11 +3326,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case TUNGETVNETBE:
-		ret = tun_get_vnet_be(tun, argp);
+		ret = tun_get_vnet_be(tun->flags, argp);
 		break;
 
 	case TUNSETVNETBE:
-		ret = tun_set_vnet_be(tun, argp);
+		ret = tun_set_vnet_be(&tun->flags, argp);
 		break;
 
 	case TUNATTACHFILTER:

-- 
2.48.1

