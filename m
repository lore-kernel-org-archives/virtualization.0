Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA61D5ADD
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014922; cv=none; b=NTpC7HcngV2yIABNbYoFu2/zk962zXJRjo9Ukjs0HL5qi/xRsVYAznBcqeMa8AyL8vL8YacsL4nYYc7p81eNjgtgp5aIQxRpu44n2vM7Kyb4Z+5U7+COw6My1cSn2F9ff5f/os/Z88WYbUvtEl7E9cQs94EVNCJ30o3bEKKEpXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014922; c=relaxed/simple;
	bh=LD3j4cF3ZMXrF9quJO23QS+8dlMHJLISNsvcy2RQu8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ICTfzigSYQUh2DdC9m4tMRHzB8+Cnu7t1RvetWsvr0xgd9HL+x90EhRB6cwh85GoK6bzPxLkP2O4h70TtHQl1K12TxILqOCPRvwiCHmOs1RL0k34QlvoOaT/bS+GViNIuDVq/l382y4nKe+nsqQVNrxPjpUerNbXdxQ7pzMBDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=nXxm44DB; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="nXxm44DB"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFF55412F5
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jiPqJsp2oWuE for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 08:08:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F3EF3410C2
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3EF3410C2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=nXxm44DB
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3EF3410C2
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:39 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2164b662090so9965985ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 00:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014919; x=1737619719; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZHCcie3Jz8m8hktWKIHhBfL5Qmb7ZIYIU8qeIL3Flw=;
        b=nXxm44DBl/i8yXNxCZXY8Kq2maUMrnrOCvQ9HkIxnU8HIXKJVFwRiLuEd7RIam03s0
         kDLYw5Juu2XK1bawmzMR8u+8LvCsjH1jTNOqM9Jfg03zf31l2ueNbu+oVkKGE8jzu12I
         +siVj2nCx31ayL1jYYb70UeU00Om4PRu1ABHgitXmSOMetHjvheNC9Yh1hhY9C7FivND
         2gVDPAZ0yU3XxPhu3vdu9CdNvFvQJZi7C6fV8yMVAF327rGxHM8Rj+iqyXShWiwLTkI0
         C91CsTAcQ6SnuFeZ+fISTkLD+UzTczSMTiTRysY4X61meYode3dGUczU8HkRkCQdKCJg
         GRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014919; x=1737619719;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZHCcie3Jz8m8hktWKIHhBfL5Qmb7ZIYIU8qeIL3Flw=;
        b=nL8n6fMqIF4IPjMEUX7xghQhf6qhrfd5MEXjY5hBryt+Enn4UwXKvvK9yprN1KHsvy
         SU7WOskoR72CQfDUsiFZILCX3o7XXVa2GOs5ybdgD1dC6633H7Qw9Cvvjvrsbpz8t38s
         Xt8dX7hsiGO70mlwEqP3UXfIabF7qK/QYM6SDi9rWmJ7LDhMzSD4BaiyVQ9iZqGzaFjb
         qZr2BMOcpemxk+0omK9ZzxKrfo4h3iRDfr64JIYdNj2GlU3XUfJjNorM5kCPH+mpjFqk
         FOQAIImYUX/q9cIFmokWXpPEwkgJbbukZSKY3Ixfbc+25q5rZmAzyJzDPPUo8dLhDnKR
         J2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCU40sDTgYPzsrFg3TaUMSM86qIms/P2A4PW+2dRmKJWzLO1z9368S+lyOKBBw87DkVni6l2MGnbUfj7xyhGVQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwLNxO3J4xBtz4gw59tMLOIo/jAhX4bjjcS4CQFpx55N61NoLqB
	OFqXT7zIV70FNYVob2+Ji3P8KLdrB2ijTYlW6mBnoFIG/8LvLBFBOtqUKGQzO1w=
X-Gm-Gg: ASbGnctceHTlhUZlM85lHoINb61gGU7lvbz85AkRlHGI1gIPXP56FZbdAqIcjdu7Gu7
	Jkek/sO36cCXO/T5tobng5ShKHNbtOAlGuWptroARECJ4p0EpYKO/iit++x6WfKbxpynCaJt+ns
	nVHarA+iAbtd8j3JExlIr1a+G7+FQm9MOnFVHSPmyS2DYhOgUp9k4aR0nqmtnBsAuKXRehP53cz
	XKSaT5LDQk+/3Jh5xYQN1OVCBLu7y7mAJDd4So8SN9zj72vvsMqwLzMKlQ=
X-Google-Smtp-Source: AGHT+IFh9yQIztGDTXss6u8AScgSJUBFClQpr2gqvX+d26toeWNI7G8UL+nQyJLfVgkmE7FH1vRIjQ==
X-Received: by 2002:a17:903:94d:b0:216:2af7:a2a3 with SMTP id d9443c01a7336-21a83fe48f2mr535916575ad.53.1737014919344;
        Thu, 16 Jan 2025 00:08:39 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f256b4csm93035125ad.215.2025.01.16.00.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:04 +0900
Subject: [PATCH net v3 1/9] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-1-c6b2871e97f7@daynix.com>
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

Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
future changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f..452fc5104260 100644
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

