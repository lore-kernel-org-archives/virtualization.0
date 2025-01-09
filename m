Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727F214A8B
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736405959; cv=none; b=R8iwBBlWEfDN3hoPJsa9yWw6Dnf4vGA1JdSObRQRocB1wTN8Q99Tmtb3iFqiwdXquMcragVlcCeaEjfKypgn8YmHjJYxAUap/PNjS5WlONk7se+nViKAlcfafF6jdDEQAO89oH7GWWg4kCCXOfb54C6LavJp5BmQ980PzWhp/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736405959; c=relaxed/simple;
	bh=3se5b6ZtcapIk1Hj4cssqIsg8szJXXkbOptd2HkOcvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=oIgLg7MGwl4DHElzks9LLmF2k4ec5ahTebRGSxNbTaMv1wyGN2i/qZSOq2U7ocz7XiLl79yodcKYqmhDigHRjcy6tFFvAwc6ghdSzMAUCc3rucwed2HwdsaOlhgzPkmJ6A0alkHCMVNgabnnp7F/Xu/cu2Zdj651yFuDKMfK/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=pwEOxJrC; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="pwEOxJrC"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC5C1404C6
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CybGbGcvdv5U for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 06:59:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D4A7840025
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4A7840025
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=pwEOxJrC
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4A7840025
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:59:16 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-216395e151bso6952655ad.0
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 22:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736405956; x=1737010756; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/vBDwZ1bg1e1swp4oqyRL1d2OsnyaZOIbrFToORcQk=;
        b=pwEOxJrCGVBnHF5Pwkai32DGphHacOjSpoDMjX7CcLWDZCxKfa1UEUa1Jtv999XFMR
         w68LzokaMSNdaHVTyLfB8duniW8TpkP7ldvJE54PWWOMseKYvFwaKFJokjK6wMh8QIXn
         1tV52v4UeJMabsVz90ocWzRlDvkztEhWrsqn2v3zqgr9AMF470tmg/Lp2UX8OXNSDT5g
         wAkUO9eugsRPXa6Ht1BIOMFQTVrn+r+cMTzuqf9cFLMel1lBIPODzNpMvgjaROyPrx+G
         QvCSpXA4dYs8+Ix1UIAnRvT2fBS0q6nTjjPL5pDAtJx7CAIYU7tJ+4NTpwtQgrrjTQGp
         v2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736405956; x=1737010756;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/vBDwZ1bg1e1swp4oqyRL1d2OsnyaZOIbrFToORcQk=;
        b=PSwFPVMSaHDAu5Z/Iw6xKHY5xHL3ns9JO5474ynpdLSL81GSz1mauSt1Fof/mf/bzh
         CHASi5csaAyZl2tHJt7glRGKJmbgrwIPQfpsKVmE8XEjqvzYe82KD5DUFeK1y1K9y8qf
         WpNa5xIrBOZBWhUZQyFyl5NcG6sC1MI/UV3K3VpJ6zOnHM6f+wPDdXSyRFnrA/TrYWQ3
         vDylVA8wzXn7pc1nyAt53EQz5Qxw2yyMrVvs/03+aWOQVzUZudwo81KamovZ1Fb6FWLi
         14RFs8UspAyOPK9GejqdQJruNwInRGPVqJUy8JRSdT8tfvOJUYrkB/iuxNKVQEqxSXLD
         axvg==
X-Forwarded-Encrypted: i=1; AJvYcCXm9qGVsdCRxHRgxSEsC+30JlFQfWffWCWBqDoRYKPXJ+T3N1lVpdQs/1PyzUzkvw0xOoQSGO6731h6usVang==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzZAhn3lqPbbbXahUh5sbDpNzOOvo/I7VPkmqXewWz1aM5J1XRt
	r/SMIT7oPWOxuPopGdu7Walwr7CXUP62O//t4OgTSNhoY7jHyGxRnWaM8VOpZqI=
X-Gm-Gg: ASbGncvolJXacybZnvvuip6pWkNllEsIHk5QGpK8b6OngvDlvOwokOd5qQvLY15PR9Z
	htnWrZ0UoRNqW6fYFU/FzeQYoWRpcdl5tYBzDjgKzzOCgKf39OxKHyIyzxKzPnAm70sm8VBDc8Q
	3GrZRZ+vID2hpCkPQY+3Ph1U8ZEUJ20ImBI8wjcanysldUc6rVUzMu4KCQZuayENlRONaCk9f3Y
	xLGWBxmOCgEWrYBPKyWo/8Ucht78uH7qN9nD29M9UsdlTx1pbx+Hqk2NIo=
X-Google-Smtp-Source: AGHT+IHzUk5V+EAYcYWqJwWaC+MFXwZq/71Rqs76Md4T53EAaSJMcMoBTEhlBWSKQlkkuLACd9/8+w==
X-Received: by 2002:a17:902:d589:b0:215:9eac:1857 with SMTP id d9443c01a7336-21a8d6335f0mr35770975ad.5.1736405954425;
        Wed, 08 Jan 2025 22:59:14 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a917694efsm5382895ad.11.2025.01.08.22.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 22:59:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:58:44 +0900
Subject: [PATCH v2 2/3] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-tun-v2-2-388d7d5a287a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
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

tun used to simply advance iov_iter when it needs to pad virtio header,
which leaves the garbage in the buffer as is. This is especially
problematic when tun starts to allow enabling the hash reporting
feature; even if the feature is enabled, the packet may lack a hash
value and may contain a hole in the virtio header because the packet
arrived before the feature gets enabled or does not contain the
header fields to be hashed. If the hole is not filled with zero, it is
impossible to tell if the packet lacks a hash value.

In theory, a user of tun can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so fill the buffer in tun.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun_vnet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
index fe842df9e9ef..ffb2186facd3 100644
--- a/drivers/net/tun_vnet.c
+++ b/drivers/net/tun_vnet.c
@@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
 		return -EFAULT;
 
-	iov_iter_advance(iter, sz - sizeof(*hdr));
+	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
+		return -EFAULT;
 
 	return 0;
 }

-- 
2.47.1

