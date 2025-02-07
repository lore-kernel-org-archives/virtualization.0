Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C66234962
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908672; cv=none; b=MDMYIX6kibg+8Pv+OBVeQfqY29AyVwPN00QupgXilViTM90o7fAJYxI0zdy0bEtz3YFpfp4r9UGOz27uZzmV2czNi0z7MOdhkejjXF08DTMesDKJITCzu8X4g0eKoJSUF769pHh1NSj1Or3Q1P0D3nvh+PIqWoQwfUK4wNeVvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908672; c=relaxed/simple;
	bh=cdUkce1+zju76xB2ulgsqkhH2BtZWQUF+tczDHuY9Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sg+3PJYrzehIPLdVkmkeE5h++xbefFx1b/fWyo0W8UBbGjoIHjKAa+Jo/5NtJPR/PJc4iJxbqtCQpnXLPZHxm84twqTwhTdM57eYBe58q6TRXTLARpESsclkL5dHk/G5u3d/YelYUllp6gntVI/QY1Iu17EDGK5zXay3JvLywHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=dP0elJYp; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="dP0elJYp"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E84C4427F1
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bs27-6o7965f for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Feb 2025 06:11:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DB092427EF
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB092427EF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=dP0elJYp
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB092427EF
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:09 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-21f3e2b4eceso25350595ad.2
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Feb 2025 22:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908669; x=1739513469; darn=lists.linux-foundation.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8e6Q2IF1AlrwVhf0WEzy1BrH8KeyaluzZCG0JrRNn4=;
        b=dP0elJYpFw6jP3EWuMr48/Hx4bghca/coAPjXK60Si1l7K0j+wbPGnnar8xNe1ED0C
         utr4hz/SbUkgnGj4Lil5ECYt6g5jYfGcyxukYHGGNCX4SygXvLp2EpMy0coTfh05q468
         iaYenumJceDcxI2mHEvPD4kphGVxhzfIK89PGYDb1uJlhZC6NKMutcWvEtDs72qXVhqS
         J+phyhB+h+vDDTMsOiCUtUPoIkbaRH3EdORllLFjivMnsktu5ulx3Qy4ny7TQwY/iXlq
         NGkDL1g/P3WhtaVEeOYjaWtgoZ/lbT8vVLDrL8QYQdKWcyMJZSEzRkkMDM7s4WCrCMCX
         S51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908669; x=1739513469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8e6Q2IF1AlrwVhf0WEzy1BrH8KeyaluzZCG0JrRNn4=;
        b=mui188Rc1bCJxuexos2TMK1z8cxzVDSB1/4HjwH9MPZ/+nq96cDn84fsyttgb+nfOg
         cut8qqDzVXzo2L5ooTTDSpdXt2H1nrsi/ZTHjfauvRHHgbJwQC0sQPj2foZdjvil1u8Q
         TYZJ3epKVAeKwXlk8v2fkQ8ihYg00etN2RPeLwCQk/YwEVC3coT/1Ur2qnzLK8NbQLEY
         gXNrmCxel3ZVfEMRqBYS9pwy3hzHjlquCKnEo50PxHdy/CG24qOU042NlGW8eEgSyNpp
         92GuPwm6RbMPgGUm1vvAL5fPt6tfM++4+oZoSotyHjBIu+ajCuiGtj+6+IKV+qWT6roL
         8mdA==
X-Forwarded-Encrypted: i=1; AJvYcCXhea0AV2idlk7++g8RiFvEH96eLGB5IEY4iiNvQXw91NLndOurKYMc3yuYYedSdExt9ASJ7i+fRAp28uMU1w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzTBtcbxIaOFJ0fuXc4nd+CFQf5OYRAoJb/uUzHIvIo41omJFb3
	Gn/lysH+PuIxSffW5rN8c8d4EG7RciLJZiVOkDHkdESsn+3dkndt7dfoVnBUywY=
X-Gm-Gg: ASbGncuq2hf2e4W/lET9+tcOs46rScg9RTn+DqxEOPIX4cSqAEKGMGmneft0Gpvf4nn
	Yq/P2qOEBK9njV62jjrTK3qNZ419/hyQ/4aN2RXO+PaE3ZFOE17nPFxa8uuTgz8LHY0fpbXT3ut
	/yiJFnjkGkP/Y3tpM8Qq3ZAxZN8nR+392EKIvCFn61jJSPs3X30DAXigeW+fUacgRO8oiBbQy1V
	Jn+TTk5I3T19Gci9DiOQVIufr3Th4c/L9zQeXe876vnyr4fM0FJpS5PmVsk/l6ejeRpUTuUQUZz
	jqY+5Gxha4fD6xKSkv4=
X-Google-Smtp-Source: AGHT+IHsiQFjzXezkiITWyryKLHFxWaOkXCA3VROnOenVsONjd60T0L0zqwo9kfDi5iWVlXHr3UF2g==
X-Received: by 2002:a17:903:19cd:b0:216:73f0:ef63 with SMTP id d9443c01a7336-21f4e7ae7cfmr37137465ad.49.1738908668736;
        Thu, 06 Feb 2025 22:11:08 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683d729sm22605005ad.124.2025.02.06.22.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:51 +0900
Subject: [PATCH net-next v6 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-1-fb49cf8b103e@daynix.com>
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

Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
future changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..4b189cbd28e63ec6325073d9a7678f4210bff3e1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -298,17 +298,21 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-#ifdef CONFIG_TUN_VNET_CROSS_LE
 static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
 {
-	return tun->flags & TUN_VNET_BE ? false :
-		virtio_legacy_is_little_endian();
+	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
+		  (tun->flags & TUN_VNET_BE);
+
+	return !be && virtio_legacy_is_little_endian();
 }
 
 static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be = !!(tun->flags & TUN_VNET_BE);
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (put_user(be, argp))
 		return -EFAULT;
 
@@ -319,6 +323,9 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be;
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (get_user(be, argp))
 		return -EFAULT;
 
@@ -329,22 +336,6 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 
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

