Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC317C7C3
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168491; cv=none; b=mkgLR2pPrl1E0j2B5wwPTdR1eLkxdcJ0/IlGWENo1qpPuGR++U8yIpNQPpu5DRBaPD2OWq0NS1po9xzb57P0LOdnoGioMmDycGsw3qfH18lin5ef3JTnRCc+GoiZB9a5OQVRqe28NV8OhiUPQOF2jCBgweONOsZwM7sya6O6zNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168491; c=relaxed/simple;
	bh=VYv+sy+VDukn69W3Bu5/T2bthOtDJXnePcCJtj3KG4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ZeOuqswrZ58MHnrb4qvT73C9MygasXJUV5skrqhaXwqwHzuIXsCsDB/qQyb+fNV5wUXQPS22UEzVlgBCndjXq/pMGvhQN3lBtLiUEMj7WaZ0fy07xIE87EbqA8N38hz2/gRNRucjNdmfQ3KXWSpdDMGEv/IjXwQsNakR2g45O+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ChLFGgxF; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ChLFGgxF"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D36860A62
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7w2Znm8_z4ry for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 09:01:27 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 361BD60A40
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 361BD60A40
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ChLFGgxF
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 361BD60A40
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:27 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5c46680a71bso4460234a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168485; x=1727773285; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1z2jVjMLVH28Vvu6Jrp+eHoNG85dGW4/noaq6q8us20=;
        b=ChLFGgxFPyd7ZAUQygtY0uXMe3z2ZDwCjSUXyrTOtt+KxX2Hft4uh2Q40VWI29ik00
         d1ZsC3Dl1sHqL1AsiYykjMf6henSbyZuxSDxufGlDLiHNU5fG0XktttQmlRffeCgrYPr
         3yOY1p/XLHh+WywsRKLtdUbKanWCS9jkT9sAKU7072BanOGzpwuMrPRN4AluAOv7kPZL
         j6b4ax9524V9s1G0fIDHjB2Y7FMdg+BJl5I1DNTHpy/V4RWvqAPoAsA5LZPmc0GRBnpt
         nzNlyRRrvHj1Av1ql59ZgG8vbm1baBP8N76qKvPZntXQSL7ECqviaIoztxexxXgDcr5f
         9okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168485; x=1727773285;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1z2jVjMLVH28Vvu6Jrp+eHoNG85dGW4/noaq6q8us20=;
        b=QAJP0mgabIdfaeHlvW0UCZfPOFbV34U0gHVKOg4CTlygfyeVTn15xQuZipFv4rk4O7
         hTtaKGfUVRMptxE6Ln/V0C/aJGOHbtbaq5tw8vqyqXnNfbXRmiQ9q8WtJeLRyBprshIp
         yP4s+5lXMU9ydZNquPCDKSoL+KVNraWTBKfXrZNEvicDZf8sQm6wzHil6zIUwB4mtJzi
         ALnfUZ/PcTgTn6lpdtx8dHnMcm9I1mzNCVXNEqrY9WUi4dlgA8pw4QhMqF5oTD8qQIro
         b/4NE3NJGr+y0cTkT60jrxj+XmLBqbMYTnG8KVX/D8K1vpVMIXJZl3EILb3umwaZaNcJ
         3NvA==
X-Forwarded-Encrypted: i=1; AJvYcCWuJjTF1slJlOZyCF6RC8Ixsf0Wx1eXeKFblj4Qk79jJG1e88ZnD6tU9E4+4pfO+1JyFJrqpTBx1Oksm7pEZA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy6Vp5EOlal1gu22Ejn6d9GViYIsgrZsCya53a3oDltF7AexuoW
	Sdo5x0A7hpTrnTBZr0DNYSN7Aon6/tRUnw6EeK9ShY0Exy/dnRAWGSAg65KbzZ4=
X-Google-Smtp-Source: AGHT+IHUq/dkWRpPMqsa4EeYb9S0z67V0A8NcjQ83e5aXy7PtfQ3vrN7fPuwMQhOhYz1y6x1alrMzg==
X-Received: by 2002:a17:907:e212:b0:a90:430e:6a34 with SMTP id a640c23a62f3a-a90d503382dmr1557301366b.31.1727168485178;
        Tue, 24 Sep 2024 02:01:25 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a9393138be1sm58586966b.219.2024.09.24.02.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:10 +0200
Subject: [PATCH RFC v4 5/9] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-5-84e932ec0e6c@daynix.com>
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
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1d06c560c5e6..9d93ab9ee58f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2073,7 +2073,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 		if (unlikely(copy_to_iter(&gso, sizeof(gso), iter) !=
 			     sizeof(gso)))
 			return -EFAULT;
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		iov_iter_zero(vnet_hdr_sz - sizeof(gso), iter);
 	}
 
 	ret = copy_to_iter(xdp_frame->data, size, iter) + vnet_hdr_sz;
@@ -2146,7 +2146,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		iov_iter_zero(vnet_hdr_sz - sizeof(gso), iter);
 	}
 
 	if (vlan_hlen) {

-- 
2.46.0

