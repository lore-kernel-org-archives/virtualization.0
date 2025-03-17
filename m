Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE48238162
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209104; cv=none; b=oXTxYAW3XeCUZjXB5GfKqv9BUnepcmHTWlUPVJtzgUuBBzZzAWdPLjCDM9uIEZ6clqATRTRf8EfL6uzVVCgIQ7lvB2BWzJ5sCbDJYdGuDIqwD1w8B1PhOMSktbLy3ou/8P4HrLaXLVRy67mAstF0lFNrbwozOegpJVNrKlkY0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209104; c=relaxed/simple;
	bh=tjt6UJr/WhYJJgKlXXv2tzURIehZ2/2wH4imLUM3bx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=RGPGS+eq4pluLI7UfIwxTY61K4+iGFRqw4Vvv3Uv2OShnKvyqQLe1MhIzSogRtjvssaJZp2E3Q8YJF2zDXun59URzUb9ZO4Q9ZFV39zzRr4fYMfGY6zjTl4o1FwkXRavlLIKT4murpAH6ksD4/R8vL8r0/neEGVpITZ5UW5bpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=jEDw5q5V; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="jEDw5q5V"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B548C40B9E
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJfGEC4EJSbv for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 10:58:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E493940480
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E493940480
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=jEDw5q5V
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E493940480
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:21 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-223a7065ff8so32988155ad.0
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209101; x=1742813901; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=jEDw5q5VB4HcOhlxbC8wpFhYmwPC92Oi+j6nKVT8BPfHA3GYjctS5UB4R+EUcT7JL3
         9XN5XviJod3tDkqkU77SFqmsy8pSdCHVifC/HNeuyWhhPgLo9IENxxDKPGESUYpiW3VI
         Z9n0mfDxFfkZG4cZjQUApwkQ//K5fCoPHdSs0PYU1wSAT7Pe61WeFIXAD98vFibpq+5V
         7OU2KU2OaqnzK4vOxytSth7ZmgP+OFXy4il8bpUpyYAjtFOueI/sIHr8qTlFY4a89fcV
         anKdI9nbkj5evJCEkNpdngnDKm/a8DjDX4fcfqXvJmXc3Iw+zDvaOftNbQldnzJKG7lk
         tWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209101; x=1742813901;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=kotEoeGSvKdkkFhQcPiUM8QV5HCaEsc3sE+/V655cFUe7xpSKE5t6JySXxXDMYh2rJ
         h1gLw1Yi2PuKFrGHMWWoMDWtYpsUJNc8X9kLitTMrVn1+NaabPnmSd83yAfKWhuylel1
         DH5BzaGh8L+3re6AsCwDR5+Zplhvzsw8YJeaXaqP2ySG2T3+Qu4Zdea2DDeIT5lV1nFs
         VAQ/bX2h8Kon1kVu7a6larSPSIDB5uhaWadM02iJEobLd3MuwdBzQRRcDuJdBOkVyAeS
         SDzkX/+gcyAFl6ThDjj6mut45S3BIWgZc2vCXiN6AiVXb4ilTormd3QhFJAFBPKSrs1C
         eibQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9jbIvWCNOAGEW6vtbiC7foD4CJzeL5vni7cCHBFre0RJu/7UEsspJJQi9m1F/nmqpi7Zf6iPXB7tJl4cv4w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxSOHnBrw5fjnIL1eyAOgyPfvxeUX2XPKOJgQwA9LOTtOZ2QSgX
	pXCb5VkkoCqYFzj/GuangnoH+O+W9/sDjpA2EEdDBpHGaKEpOz+jOQrb2GJQrCU=
X-Gm-Gg: ASbGncuZX7NNPTXODjTPlgt0vVjtaOuMbvBi/elaUp5f6QhNNMDFWuqFgDkzrmFu6UF
	vR+AVYOeB/QowUgYVqz8PIsSKDWEkKzrOOtuMR2mE1F1PN62WLBDptzutpSW/1sv5sIWq/Pf+jL
	bIaXof9YmWLGGZOAy5x3ckEMLmldDL4lwgLi+xdI+ZmqIA6PxveL3vrRwp9xD1ekDVj3ZwVH2Xq
	y7MPoSfz2gJNxjmoHgpcHZPORKByC5X7p309dbpybjblaZ2LWDVizsjIQ891njzPfys5IoIgGov
	TXBvbGV1Q5OmqCV790BZ81KiuXeJKv2I/fePTMb7aNv52dDLHH7WQSrIRZw=
X-Google-Smtp-Source: AGHT+IGYq7HCRRL8m4VKOQxjMlmqfYplWsVLO77u9xzWoCNDu3x4nlybmlZH5cMRcZ12ODXkwSAaKg==
X-Received: by 2002:a17:903:11c4:b0:21f:85ee:f2df with SMTP id d9443c01a7336-225e0a896a9mr153965305ad.15.1742209101298;
        Mon, 17 Mar 2025 03:58:21 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c688856fsm72665785ad.14.2025.03.17.03.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:58:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:52 +0900
Subject: [PATCH net-next v11 02/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-2-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
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

