Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF351FA851
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336477; cv=none; b=SP/KlmhdMdyCv0vXXWLhbeofVoh4FLrIV9xkO6ypsauTxeyoQWzn+Mi5PXDdzKMLOq/q1llh1g5oTj+c3phNiC9Pb2x7+Lz8oMApgmcPUaPw2GbQ42Ti8uZi1EKsoG8jJKujDOhMsLaMUYCJssgXHZd0yYwb9bXTjerDZeurGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336477; c=relaxed/simple;
	bh=3se5b6ZtcapIk1Hj4cssqIsg8szJXXkbOptd2HkOcvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Go0lx1T71zR84NPe8uGgoZ67Uc4+6WRwbOWRHuFsvTB+koYQ6S4eHWzCHuxNnm49kUKMSxwtl3BzZXv4C/BVPyvL4Fqgwclhj+8cBeTeIAl90MxUuR7YcZFUr8/20UmKkLipL/KeDlqJOzGTGP41LMh52m6qS+f1jYfrie5AK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=vUcf7nVN; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vUcf7nVN"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BD7F607A5
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CIKzxouWgmGn for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 11:41:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E09F6607A4
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E09F6607A4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=vUcf7nVN
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E09F6607A4
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:41:14 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso19366515a91.2
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 03:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736336474; x=1736941274; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/vBDwZ1bg1e1swp4oqyRL1d2OsnyaZOIbrFToORcQk=;
        b=vUcf7nVNs0vkjOA/goT+HZkMcsYP/TY1MYVqoprHkCO7yZZNBOXKddwU5mDalDmCFm
         JjGya2KIvUgZREtR4PpEgRxHzZefwVQTL0YTcbulEG5JL7pJl628P+pPL/JYmp+JqrF6
         eoF4/AFPZXOHww4Z+M66dWmS6ItpUC11rHWKxeoRbiB94r+84nm6RTYMXZMpKJWcqVgS
         Vz3IQ97upXMxgdZxGXzoGK5LRjDZahVVy8n3MqbdQlRFNRuwv7QVHe4Q7NOS0EMK5DwW
         z97DvdT55UZDus97yfDSYllGamUKpZtRa01+y5hriNbKyQAbNcDzj0KKDz6MDVBsfKrw
         sT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336474; x=1736941274;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/vBDwZ1bg1e1swp4oqyRL1d2OsnyaZOIbrFToORcQk=;
        b=eOSh1WUnLZZmt0XIOvV4uI/PUBDX5o2KvYDGQlW1w2xQa92va5m42lbgwkcJ4sP1Su
         fTGPr/gXpv2MJenosiplaVRajanJIkONAO/vOb5nmC286BmYt/ZBlZ2dgbQYAMk7c6Zm
         ldsjIhkdaLtPurU6MsgbZFPdvwZWHNwblhtAvXfeLV1XcwB9u+5yM7/jS7188wtPWlvZ
         YmXZcg1vAjBuFXPa2HSIEyqGLPE48ERh1GkgRWSKuRMJ5qvFuhwFq9gLsk0oa8zXMlBZ
         sa8mEXgKa6pjHG/rFUGG5gioa+Q3KXKF6sn80Nz1t+c2hRx/I+AioksRoBnuLQterT6+
         I81Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8Je3P/onpXEJ6kPa1vSQfBypIE2WCcKMKJ5hVseB/WxjiAG/+hZzMYfx6vz04cc0LM7Gql43KDJLVN0bdpg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxu9POeeEipvln9VEs3qOu39ixiA57TN2PGhSNzGJHla5fPo5T6
	l2mOXIYCPffmpCffLuCSnbaFFGxdz2bPgcsiQ50y1G8rTrvQ/PIMaYP3du+fHow=
X-Gm-Gg: ASbGncvpKduKNJhiRn+w/ax70EtynhiLrckh1w2D1jrbXfAxwXZyukb5XazEG+2KE5C
	SIN29G86sSB6HWnbP2gqho/Z9a558hrP4FEXRltzayDcG5nWtFIJFyyLiRkY6hvB/GdpFIM4GUO
	moiJFoUwbrZFlr54jIuGXsVFW7xhcCXPbKqefw1Zo4iT2sEbdtkUb+JehOFBeqTlphpjELBznfY
	zI2yDJf6H+leXHsBRIQwDcZ+jtdtrmeEqu40zsbMu6S+caEYY3YVQA63lg=
X-Google-Smtp-Source: AGHT+IEF8qMJ7NIeisRWLUDr1vgbLpWM1JpUxFEsueCBmq3r2f5ah2dV4+8clMjFEVU+QatbWr90SA==
X-Received: by 2002:a17:90b:5484:b0:2ee:b8ac:73b4 with SMTP id 98e67ed59e1d1-2f548f4265emr3092055a91.36.1736336474242;
        Wed, 08 Jan 2025 03:41:14 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f54a36a5adsm1383037a91.49.2025.01.08.03.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 03:41:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 20:40:12 +0900
Subject: [PATCH 2/3] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-tun-v1-2-67d784b34374@daynix.com>
References: <20250108-tun-v1-0-67d784b34374@daynix.com>
In-Reply-To: <20250108-tun-v1-0-67d784b34374@daynix.com>
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

