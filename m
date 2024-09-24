Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F2155342
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168481; cv=none; b=n2QHfYofzd+QOXh+bW9JNbhFfXKCRSi8gEXm//EqObI4xwvfnHGaHXsW3GPaG0WOgQKB3dHlajpw9oFbu8XuIwq8YWjsPp6rhIsefDmeVZ9viE5z1pqFyDYclbtVdlXuVlDW3sZlNVMgBjCuyy9kB4Eam2W1+v/luycTH1x6kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168481; c=relaxed/simple;
	bh=MyD71HI4MA2yAUC70K/NmNxJQezcMoO+zPtOIctDAQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=XCyDZn4C5rH0c01ihZebFuwIeTP08WcgRx9sAMRoNxgyFngWY9TCvBrHASlXrOarfUyxNXoT4ZLzRwKMnJ0xaXr6bepy8LutBEu4XSlLmca3ykdS7tiSknCd8uTqQcQLHtw8KIv3H5sS2kTt7XS127uPchOSY52ywwODzFot478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=m5Qfjz3d; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="m5Qfjz3d"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC02960A41
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T26AZ7vAymse for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 09:01:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D5E1860A40
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5E1860A40
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=m5Qfjz3d
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5E1860A40
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:18 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso8245863e87.2
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168477; x=1727773277; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1kAAAtErX+Mbn0MQOV75jcovDzbdqf7yjREy+JSPNM=;
        b=m5Qfjz3dltUnwQq5g/tMZQIdfCOszO4Jy5uLN/sZTi1u9YKzb2LLVv1Q/wx+O4Uk2K
         3VZCwIDUyqqJelx8F5Pjo6jlN+MrEUj7T+iQHafAwfT0B02OOxRhFnb7H1bzXasUToik
         LcF4YcKusVpo9C0qmkj9wIDkpE4ZIN6gs4NssflYIrG+4RCOgmPPpKhjjbtIGtjXF+3t
         5QWIF+sPlYSS3Jjwr/uBCWtaRORenPEzXA8fkY/HblvF/6xCBcyE473IRxyWx5cRtJS8
         U5dBJSRhYdoNVGQae14l53Up/C0nV+FwiqzmccqO1/0IcbKaxHDKVfqyTHHdSKZf+cd5
         GGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168477; x=1727773277;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1kAAAtErX+Mbn0MQOV75jcovDzbdqf7yjREy+JSPNM=;
        b=cJR24x6I9PizbxFe7CQipmFYMLC/hLhHWk/OUMhK0rl8MkGhiURZvycGJTlNHes7+a
         X7mJ8cHh1M7qK/FS3wmlb/Bk0jKnuzBhhRBZwu14dzS5Skk5Ty++nKCeBREH1MbWoHpf
         K2L4X7/YZazQhVECjek8e7jD1+RnsUYS6aReiP1LaOtctU3cw/8pJm1zTp9OCkDZWUfe
         faKv1OdFM225yVeU+JMJLVKtRrWQ9eGrUyFbqK36Gfo5z7WtDJAqoXhptdOsi7NLMOqb
         Vn1hYi6qB/xnnqvj8Hi5in8swMlT1pAHNp8VUfw/D9Mk2ZuFxGi/CjLRfMu5VIpCJ69W
         fLVA==
X-Forwarded-Encrypted: i=1; AJvYcCVrOaXQJS5rpKcSIt0Pwnoqtz28rT/Vh5Qnj2TdrOOr4eDs5YMnLt+204FsOADd9CJrRgxa+ItjeVeJTzGKMg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw7Mz0qBZ1k3ehzlNPWhqk7WUH9icKv243gwu1oplrii2xCGKYt
	umb64wdGwFlVrAMtUWQlSmoXNrw+Jlotdt3wgMf+XYtIOmmJLZmxdQ+z87dH9gY=
X-Google-Smtp-Source: AGHT+IFwbEJheNGzEgD5vAlxy6ttzfcaZu81VFeEqJsY1P5iYb/DMCt1ffXE/8oRaqbajpxcR435Vg==
X-Received: by 2002:a05:6512:39d4:b0:533:c9d:a01f with SMTP id 2adb3069b0e04-536ac2d6a7amr8799569e87.4.1727168476563;
        Tue, 24 Sep 2024 02:01:16 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a9392f34959sm59743266b.8.2024.09.24.02.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:06 +0200
Subject: [PATCH RFC v4 1/9] skbuff: Introduce SKB_EXT_TUN_VNET_HASH
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-1-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
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
 include/linux/if_tun.h | 5 +++++
 include/linux/skbuff.h | 3 +++
 net/core/skbuff.c      | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 043d442994b0..47034aede329 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -9,6 +9,11 @@
 #include <uapi/linux/if_tun.h>
 #include <uapi/linux/virtio_net.h>
 
+struct tun_vnet_hash_ext {
+	u32 value;
+	u16 report;
+};
+
 #define TUN_XDP_FLAG 0x1UL
 
 #define TUN_MSG_UBUF 1
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
index 83f8cd8aa2d1..997d79d5612c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -60,6 +60,7 @@
 #include <linux/errqueue.h>
 #include <linux/prefetch.h>
 #include <linux/bitfield.h>
+#include <linux/if_tun.h>
 #include <linux/if_vlan.h>
 #include <linux/mpls.h>
 #include <linux/kcov.h>
@@ -4979,6 +4980,9 @@ static const u8 skb_ext_type_len[] = {
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

