Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2E1B85C2
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363103; cv=none; b=W3PISkZN2TlKlH4QOASd1j2U8zTdFp2LUWZlKX0zDNx/ZSN0ibmTRKLm+mzEN9zQtI78VNgVFofDy7RQfv390HEHqkgT+N4ZzHI4RgHQOLDjzAthdspyVqrWPrZaYS/TZfyKBAjGimvBT2hloHcC4aJvT65uKXxNq/CinzQkFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363103; c=relaxed/simple;
	bh=lLUNpbHX/GXFiFtHpw12GxrI7YDiHIJJxc3/RYWJl4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=m+OtJrm2Anyz7DQPvqgl19aWnL8kJApF+dhmgWAYcK7F6FFpYQqKcFtiAaoTmBt0uHeuu0DRxtVMVMb/fFgB1oYzen+0bvbiE+58mYonOInFyqaKeHQV1j7S4IBvit8KEejpTWJAVowdAEOQbGvmTKuU0Rj+pRhk/c4SFaEKrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=1C9yq5J6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="1C9yq5J6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8906881B0A
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8EVUzyALZEw for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 01:18:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DB8DF817B5
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB8DF817B5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=1C9yq5J6
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB8DF817B5
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:20 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so1529436a91.0
        for <virtualization@lists.linux-foundation.org>; Sat, 14 Sep 2024 18:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363100; x=1726967900; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yA9Gcv+7jpsWFyFoetAxKnXy2lsD/ZqoQ1BDUECczE=;
        b=1C9yq5J6/bV1x9+7px2M22m5Q2WIWFaWKKsa2UdyOI2ZeG7INKSsZAmkOShEM/9Gkc
         GFje1fcaFRwdy7xFiaFy9bffux5PK7BHhNZcDXDy5ORExLshfSz1ynZ4NPI1tzW5DktU
         q/46gmAELyf8kpr9aONf7eb7vKCDS9hl4/uprzKGwPoibAG450Ze8MsapNZMmzqG/wBv
         HXzKgstXB7emSuBFGlZeUunbiHrZfvdBAgN2DEK+y1SKNCoH5T4mKB5MageQqiae1XVE
         FqFYzIz/XR5VVEft7w86wyb4d2pjK3vJJ1Klv/rqykdKop25tz81AeOwa3rD6z9EVjty
         +V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363100; x=1726967900;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yA9Gcv+7jpsWFyFoetAxKnXy2lsD/ZqoQ1BDUECczE=;
        b=HVi81Onffc+NaA7U/kYVT1uWU9REyxQwM2UeKbsA4IuckmRbMa4JakQBgxmK6MICE1
         WEsKGw2uYx6KIukbFBuNAzNHwtc1j1X6aXWZbB2YvPSZm1mbipz9aoxmYqIf/KbLEXcI
         pAjeuuI1NN5IdnmL3kU7nNI5/chkIPNBf/Ncs1zBeQtOSxWy6sFu6RTahIbOoZDD4s6T
         xXC4V+UfAcDqTguEx4gKG1ep0NiAeV/3ESf8YVDIi7Iq6fbtcmoMnukduwuvFGbyXHKY
         Gi2EhE1K918Mm5xg/HrfgtkgkWjMARkFr/ZcSV5hn+rqUQ9YYfdrkHl1uzZMINL0fAhy
         LsvA==
X-Forwarded-Encrypted: i=1; AJvYcCWDT5IgJ9xfx0c7+FinDW3Tv8DxSpb3qrm2Gb0S7zZZdH1aXna688c0fWkAFfA9zpo9ALxzjuHT3NXQtGTwnA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwplDE0Y4BaAy+DWJnWeuuDQDV33z4GHDb/zOPn+nKY9y8QH3CH
	QrCvPn5qj3erQ/MAAzqtZXwu/SJwcJ1kDbTQuFNKkMY+G4KAjDYffPNf5XLA6oE=
X-Google-Smtp-Source: AGHT+IFSAj7upe4/2sUQdHW7jz5sgYJGysCflqOFoadt1kpwGAuHykIm5X1P7+daPBsyN4rHWM4Ujg==
X-Received: by 2002:a17:90b:33c4:b0:2d8:94f1:b572 with SMTP id 98e67ed59e1d1-2dbb9e1ce4fmr10261622a91.18.1726363099986;
        Sat, 14 Sep 2024 18:18:19 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2dbb9c4cdb0sm4356067a91.10.2024.09.14.18.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:18:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:40 +0900
Subject: [PATCH RFC v3 1/9] skbuff: Introduce SKB_EXT_TUN_VNET_HASH
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-1-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

This new extension will be used by tun to carry the hash values and
types to report with virtio-net headers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/skbuff.h | 10 ++++++++++
 net/core/skbuff.c      |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 29c3ea5b6e93..17cee21c9999 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -334,6 +334,13 @@ struct tc_skb_ext {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_TUN)
+struct tun_vnet_hash_ext {
+	u32 value;
+	u16 report;
+};
+#endif
+
 struct sk_buff_head {
 	/* These two members must be first to match sk_buff. */
 	struct_group_tagged(sk_buff_list, list,
@@ -4718,6 +4725,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
+#endif
+#if IS_ENABLED(CONFIG_TUN)
+	SKB_EXT_TUN_VNET_HASH,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..ce34523fd8de 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4979,6 +4979,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_TUN)
+	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct tun_vnet_hash_ext),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)

-- 
2.46.0

