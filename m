Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896581E7C31
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370508; cv=none; b=YxayXzR0RTo/jajsyfvNNDAJnWSclMR/qWx4ZxLYrrxpglrTxZ0jzUDiwPZQu7D79Cniw5bF3xamz4QHE8y0QERzH313RC7hk0hxWWkImZop+higBK1zkX0qQgoQCmdeKkhu29mATq5nkL5MkA+WFUaYC+YCT2/j0Petd95h6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370508; c=relaxed/simple;
	bh=lANdjeuF5u8nCug7V+6XvVtwfr4345Ds4BaIqTrhBSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=gClZHlwAOmWryt1p7xYSkuIF89HZEzizS9haa9jlQlymPMzhsbM3ppb8O/OnGvfBDZRXNJ9dEYMZtaUVxe6g7EuUXDs7vDLadlk/yDue1eKjhNGENaQRJc+1YJKeGGJZ3+0OqscZ6Fj+7PA6DxzHldzojti+WDW2rEQuBKwv6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=FwkMQktU; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="FwkMQktU"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3126540253
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJenLJAgBlu5 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Oct 2024 06:55:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 422D3401D8
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 422D3401D8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=FwkMQktU
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 422D3401D8
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:06 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-20b84bfbdfcso40634945ad.0
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370505; x=1728975305; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dvPHHUdir+WDvdCaxVm3cJC63BLzIFu5EZfdDdcBS8=;
        b=FwkMQktUhSzFMRdEvycGfXH2gW8fXazEGshK1XiDolbe9PHZaH+EeMe7nQMDj+Gc9/
         GOBHQnAJTTn5F8UTNDkByqvE17X6omgA+nam5Ql6O2Am/0NY5Vyav+oilEVkwGiJJaZ5
         TqLmBrAkQ6CPl8m4PWUkLFulIOSRx2+7ydmN2wYEk92OQrTcqQ1q2iq7EU4J3Ou4czYr
         Bo/c2T0CXt61KnYwFWOTR36dGn+KhNjdTLoLAro+MB9KvCWwQwsHRNxJNrrkm9QhAgEV
         NSlsZ9ooHtKvtEm0Io0gCOT+0U/NOqY1gs81ynz45nj3Tmuw9YaJi4r7uGaJ9Zx0mx9b
         DKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370505; x=1728975305;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dvPHHUdir+WDvdCaxVm3cJC63BLzIFu5EZfdDdcBS8=;
        b=Ogn8jr8IGyoMhCvDbkHF2GqSFmU42HN2snuLr0wnUZkivdn0OBBCFPnc8UHU1qbqUp
         9h4r8PIEgCwrqP3BXci8Wnxoowa0gKwIy/HFfYPrVuxeJ2yK4JQ9iXYSDxyLJ9U2/ujR
         ZK6lDo0xFWt5NIrdHaPKZwD7IQosrIX1eNQKHcUOj9OKD0TC01GRTZleODg7gB/JRnF4
         g83NIfx0q0FYCHkwP2nqHaI85WCq5jMKrEdxZQMd2qSDRtywDsnpCesDuIUsbpiwy9e9
         0puTEvxMAfWsh0iNG/f8JtpgsAC6Bjyqib9DXIa2QJMnBN6O4iJPy/QXsFzcv25szbPc
         GBvw==
X-Forwarded-Encrypted: i=1; AJvYcCVXZ3Bew3VVRt2AgEWS1pkHxuKWUsF8dhcimxCkyWEQf3tf8eWLiDto5pYU4BC4tS1lSA2uFTY1+d3UghCMWA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw6kIFbf31BrI4JP5y+xS3CDOEgJG3uUBX3ABVzLLTOfkT4uohG
	LK8kuZNa3v20B6pDPF5cXBstiFtcJJzctjTd8mLLw7q8STsl4EHxJyUTHVXbQek=
X-Google-Smtp-Source: AGHT+IHz3TcZF7m5dn69T56wM9r7uLbH/pxoXLCwFEF5B/fIFcyPsIk0p2kYddj3LyEN9FsnedlIaQ==
X-Received: by 2002:a17:903:41d2:b0:20b:a41f:6e4d with SMTP id d9443c01a7336-20c4e2bb35bmr36489095ad.15.1728370505493;
        Mon, 07 Oct 2024 23:55:05 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c1396d995sm49759165ad.230.2024.10.07.23.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:55:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:25 +0900
Subject: [PATCH RFC v5 05/10] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-5-f3cf68df005d@daynix.com>
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
 drivers/net/tun_vnet.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 7c7f3f6d85e9..c40bde0fdf8c 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -138,7 +138,8 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
 		return -EFAULT;
 
-	iov_iter_advance(iter, sz - sizeof(*hdr));
+	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
+		return -EFAULT;
 
 	return 0;
 }

-- 
2.46.2

