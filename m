Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765A1FCFCE
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849300; cv=none; b=hoOSufaxyTccGjPIrUwBWYeZsUIS5EMT0t8A/KmLRXBS7yUXMA6SG21PA+kTJX019YG9aepIkRzEFV/Z0SVuPIL8bFmXnXXhLd3eOth+rGws4MFPh09TPLC9qm6I2iHhZGH8VDsdZZ2R2LKbnGYVntgBViIWH+BzI5bUwjCqX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849300; c=relaxed/simple;
	bh=tjt6UJr/WhYJJgKlXXv2tzURIehZ2/2wH4imLUM3bx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=k79PBMFPOJL5rN4dPuo5NRiU9U9YAAnPQBguBduVy3A7shbNqdvMja4YQG3AdH3xSdwrRXqNg0YWjWi+TIhJy1Ca7ddA5HgBnuUC0SwPw7wf0wlIsoai7BgZFZpe4t7s8FhDXOeR2fEAVxlbsaXjlUZ9Pq6huaDDcYMal9vJzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=bnX5Gate; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="bnX5Gate"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A894360E02
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F-SlVF_zPbtg for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Mar 2025 07:01:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0985B60D7B
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0985B60D7B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bnX5Gate
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0985B60D7B
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:37 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-223f4c06e9fso11048865ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849297; x=1742454097; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=bnX5GatehoXsK1EFK5AhYVNB5bynjollIOk+UVvf/0ounozWaIohNxzX7vPDsZVOSo
         0MJb9srPNVbpDcLLHYYQOSjZAxK7kV6ie+Sii1W5y3F7/5e96etWtUksGPlJ/FhH5NYb
         b/j2GaBfzmmbzh43095Puou6u3EmCEdCOTOihbTAt0LNk7UvUWN0k3c+FQErNcG6OVS2
         ajXWq7u6Ax5u+ZVv7InM6y8XhZYcHp+/4D89LrjDvaCMWIgvgKUup6KLF1OZ25lrgcQ+
         44l1E98TWkxXKeivQp2+Er/vjYYPMWabheERbK+PtYnoy+wdyv5BagLIfqQtvb4/0eff
         ozQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849297; x=1742454097;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=vZ3Jm3aEnYpX0QgF9qbCCSjVdzGcXIXYzy43/kErsaEymzKHpOhAWyXWxlyAE3WrVD
         9qB+Srf6j3TtDIFBb0Vx04NxC034+dtctcN3JNHB//XP8rnmgtzkfkz/aa18z5lXA3hu
         EbFTkcLwEq6sdjtqc8mcQchUhNlKV9rfpJdrMTLArzRYI9lZAkKL/GoWQgYuj4YC72ix
         89Y1j5E4ogb72RlFBpjE7RlmiXJ98mUUQETSXWdCHbPlRLwPQ5ByUnUI37XHUs6M6yZP
         JeT/qqFtE7GeevRL5VGTmWSYf7SA2M+TRIhHZ66AfkfBOO5iey0WrtHGAyohAF7NMJuL
         HJDA==
X-Forwarded-Encrypted: i=1; AJvYcCUszuW+3KLOILLiD8BHOT1/fD0aQXb+oUiIjy4UgVdTjGxnsPpjlih6X/wt1YImKuoFYR9inqRkjmZzIcGd+w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwjEBmCHLdqkXTY4aF2OfBux9J9TqXX0JjX3Dn5Vehnl2eOwNyD
	X6b2slcj8P/kKOrFlPud5GA2rKVoOiiyroFwAIL0FwrR2vCvhTp4AXewKBh7ytU=
X-Gm-Gg: ASbGncupIBeXCqvmpBqS0IyaqsKV4RULbI+OLBxWUJxLI+5OzjXvAjz2wvmNEuRqGNB
	WAT8aYCtgsKVH0yheL3oPuxskTRjfVWsxvaCf5G5V//E4UHgFm9uNe88fQNgZkD2UkQtFy0CJ/A
	pIWo3R16k3SJ4+BX+5VwZUVuDAN4+bcht1MgUuUV9SSlmv8JVN597l3F8PKuCTJib49xRohPzji
	B+HuSxkIBEK9Gc6Tu1A4bVpc9piJqT8GeUHISz7gz1oz6Zq79XLyCTx7kmrvkP/yv+VcRkV5wFm
	NSTFNL0vHLKNQIJos8oE+xV3doZJG3fQvEglumzXUv60dtwlPdgThzXACVU=
X-Google-Smtp-Source: AGHT+IF5wWHOyH5JHVoHtTy7K1X2eW3fNA4SOZ5Z2GJbYtGXN3r5z7f/KOO/C3Z0RJnF3qBJwnVUzw==
X-Received: by 2002:a17:902:f548:b0:215:a303:24e9 with SMTP id d9443c01a7336-225c651d65emr18870555ad.3.1741849297043;
        Thu, 13 Mar 2025 00:01:37 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbeb7esm6519955ad.193.2025.03.13.00.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:05 +0900
Subject: [PATCH net-next v10 02/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-2-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e856..d01c1ec77b7d 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9cd8de6bebb5..32c7ee31330c 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1862,7 +1862,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.48.1

