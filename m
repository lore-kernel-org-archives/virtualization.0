Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C01E570E
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370497; cv=none; b=YHhbohgkin8WZso4Q8zaq20jNH0i53m3rXdZzJWjSa8NhtUiFWTp9we9680PnPxnuXUlUZxsMNKlgsj+N3iGheRlPS7gu32xcXBFiQwwTAy9dIKvCApiB0QMvE+4gDA2lffPu/wIW8Arkw34K126j7PPNFqklLfNd8EzM5U7Qc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370497; c=relaxed/simple;
	bh=GX7xNNedqmkBNoygMLXRBk8YNW8TUTKj2IdIaUHcsB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=FkET+koq5eXgmii8mBhBIDu4ui8kfEPdPZNOwyB4I7aHTAQgDN6o8n9R6SKbLnvSkv2CN5Mih2Tdd9tiFUmmAwnAiw9XQ5MYYnT3GFHHCwM4pr0B1nLHDP4Y0ozKrMgUQDw2ubbpZHke87hicvvY8dQ+qiB6Ov/qkjDTPHPEfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=RGWkVlK9; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="RGWkVlK9"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B71AD4024F
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6fR-tLptpcZX for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Oct 2024 06:54:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DFA60401D8
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFA60401D8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=RGWkVlK9
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DFA60401D8
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:54 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-20b93887decso41626435ad.3
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370494; x=1728975294; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61I8UVOx3KOO+grmBS2eNs+UXuu5q7xipsiBLUyhIxU=;
        b=RGWkVlK90xCYxztVli+gT9YytE+deJAiHgdx+tRkHvLibfDDVrNypI7l/dIxTe9aa1
         A5gi2nwlIanGeI+S1Xkqb0bp1FeKrcyD4RXduvcYydeYAZEH7Tzlk3P0tIdBWKUB/R+0
         qIqCMlp9p5P1x8gVwejGB1LP35/MmL9iEVmT3CXCvVQhh9sbYSvvOoJsGtFlKF2PEfGj
         +DBHU8f9wusykvx7uVQ1o+o/Zi7Rly7G4t1tbVaqYisWiS7f6zOOtap/nVm3a0MDKRi5
         Zlfb2PLM2W8pz7MEKemQ2xQIdFLhFQ3O1monI8v8YFG/MJtWMFjRe3XrV5U9N9iHFrQP
         ThQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370494; x=1728975294;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61I8UVOx3KOO+grmBS2eNs+UXuu5q7xipsiBLUyhIxU=;
        b=FvA/aD7Tx6Y2ySpra9V8Tmq+tZ+Xs/tBhqtzD6ldl81pA1+Q9I2XxX8/j5QIG8NSdw
         hk8tEeihJwgYZi34mXpr5ppAQ2I/0ilAUOr1ps8aNGFnVKUiihSTg4MgSo/OPvEB1Rbe
         qQtltSyuz+ctPOk0W/LYPFb4TjIWXdCKrwoKLj+OgUst/IedH+rtGhFUruHin8kyHPPR
         zWycyVfJmbb3+B9Fh28r0qDXnOgHm87uXHyJmV1ZEZhz7Up2XcoxpoXOTdwVB6UP+gSh
         mGpI/lDI6JgT0yznDgAGSnUV2R48YcXG6dBQrcXw0R9GsCATrHrkj2Wj439ZlUiHU9mq
         +9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOtE+A8ZhAGC3t6R0kG4BSmU6E8KV1Q1+XG11IJQN1bkYDVTLOr9vbMEKzwzQ8RE4XJ0B3eXnOJW2PTUq0Gw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwJKDcGIKA50VVVj5S+rIrvRaZo9BLcCGNTZXRdWDV8HQBcsZEs
	LssDPDip7+6ATFoAlyRx49KPYLG+turzVuhgUdRCaK+UlykWLBOF23Vt6FAiAxY=
X-Google-Smtp-Source: AGHT+IFQle2yzzR4dcGGT4YtYzeAeqeN1k82tWPpuGYLK1pMOd+gx8+tY2XKUq2OjAmapp2a+BI3iw==
X-Received: by 2002:a17:903:32c7:b0:20b:987b:e3a0 with SMTP id d9443c01a7336-20bfea56b19mr207151025ad.30.1728370494237;
        Mon, 07 Oct 2024 23:54:54 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c139a2bbbsm49777315ad.294.2024.10.07.23.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:54:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:23 +0900
Subject: [PATCH RFC v5 03/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-3-f3cf68df005d@daynix.com>
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

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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
index 0e638a37aa09..9822988f2d49 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1852,7 +1852,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.46.2

