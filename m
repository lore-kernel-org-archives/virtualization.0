Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78221E47D5
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370492; cv=none; b=uL0MW5Z6R3r82llqIldj23X3ftmuqhBlau1sj9As3kkvgnVPxsx1eQA1BWUWaWuFHkEfQ9UtaPHww1zoZCs2lGgzHLaoEiN+XbWDnsLuwMW3kvUxoC0JeXUTjOWydWg12ABEbhUJmSL30kJP0vwCq/4AMDrm+n9AynVLKqnLXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370492; c=relaxed/simple;
	bh=uaol2IGqvlm8ZTxu7WxkWiZOHaSPhvJu+1yhZK+cfFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Tg3gJ4KhWN0VtT+v24hpAoGKBJuNwvwn2dpqBq6P3LMbtOa3rycJ0i7Oyu8U+FbAhTDNoQJwLhC2n7HkQ/pS8paqnuQFAUcRs/zB6yQTaNJEOlzskPD5CXlfc5YffE2rAzaZbm0RGQpytg40MQwk1xFXMn+MfVh1zg88NCK6SpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=e4WoseHn; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="e4WoseHn"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5254C4024F
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6G5MFcJm8Qo for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Oct 2024 06:54:49 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 61F00401D8
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61F00401D8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=e4WoseHn
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 61F00401D8
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:48 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-71de9e1f431so2885738b3a.3
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370488; x=1728975288; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUS5KMA/ewmQfZHiSllXFCUo7ZXTGgrN42vxjEBIbqQ=;
        b=e4WoseHnQPo82rMBOmpiuhxuPBX1ACZaDXFe0RaGI5nl9bYXUMUMl7PTWv79918h7h
         tW3RGsUtRaM+4ycyVrVAstwD15y8TMwwRTrhlCTV7umYnZrnBL0OE/nVbNws1Kxl7cln
         ORQBrpwEgK/ODOS03BapAA6kl6xYPahsg6z52VYO8n08ehLxleTRcilDUQ6wPtAlx/Hq
         owRynHxKRXVb8UXcHwcznWcc2Gr1ea3OsNW1mZ7t7IrDCQPEaSam6LZfw5puc+l5OWhe
         l68rJdUIy1KtmSMXYskJx3LDYEOPGfxFXnoAdi0JTvCgwXGGYixiYfzKfiQ/PZWSu7jj
         LjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370488; x=1728975288;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUS5KMA/ewmQfZHiSllXFCUo7ZXTGgrN42vxjEBIbqQ=;
        b=Ym9JM9LZU+2g3fUKWfNapviyN6gXabuZ0T0qNpGPe2/qca1Fycy2m6eJ/cVSHAUKEB
         JomDyEDwMg6DELcG3k1FmHtv+VKDA8lEupLSmn8ip9y8gUFA3actzF9AwVqEm2/MCJsO
         bhRzMUvFYCJBV+p6IPhnNzosfTemgctKMq+9jttEFHEqYzL4B+ZE26btFcQKu362jJOY
         sS8zNzB3MRHsX58zZH4jQ3jgvE17X+WC4wg8KAqWNdA4m0OdC077zzLiQDxJwNiWdy+z
         vQLMrulw53hUOvCa1wUVuszODOd9YGRlTCCPiA3Le3CqIgz2MMKOK+PjlDizIq7+nIhR
         q7/A==
X-Forwarded-Encrypted: i=1; AJvYcCXpdoHZMa6oP4fWaAdthl10wuP0c7Hw5e5bjqZGAJUM7XJfKpGaRxYbqUK0dleZ6WpIItgVw6T0pgCB9Es2nw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzWhbFCcWBAnh21mEbkp77LqCCZ8ZL44HFzVsar3XJFOh7zEY4V
	pOEokVDHQQVrBXXMYXHidQaZTPa/Mq3uG2VkNeREtznFRvYzK9WDCga5aOEZgMQ=
X-Google-Smtp-Source: AGHT+IEKcNMiY7wzLXe5eQDoa0aLQOUol5zSII/XfgY6pIxMP/K/JQLspO3LpuBtTgX1dSRwe3ohkA==
X-Received: by 2002:a05:6a00:3e22:b0:71e:21c:bf1b with SMTP id d2e1a72fcca58-71e021cc1bcmr11161687b3a.14.1728370488090;
        Mon, 07 Oct 2024 23:54:48 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0d6521asm5477837b3a.166.2024.10.07.23.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:54:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:22 +0900
Subject: [PATCH RFC v5 02/10] skbuff: Introduce SKB_EXT_TUN_VNET_HASH
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-2-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

This new extension will be used by tun to carry the hash values and
types to report with virtio-net headers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/skbuff.h | 3 +++
 net/core/skbuff.c      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 29c3ea5b6e93..a361c4150144 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4718,6 +4718,9 @@ enum skb_ext_id {
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
index 83f8cd8aa2d1..f0bf94cf458b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -64,6 +64,7 @@
 #include <linux/mpls.h>
 #include <linux/kcov.h>
 #include <linux/iov_iter.h>
+#include <linux/virtio_net.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
@@ -4979,6 +4980,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_TUN)
+	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct virtio_net_hash),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)

-- 
2.46.2

