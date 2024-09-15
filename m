Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D241B85E4
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363173; cv=none; b=c5Nk9vYU3oEbSFs1/VgyHQIxE6NBy43Y6vqUNVc+2X95Ep7k3sDr2Cgx1w2UQEdTHhRXgjQOyicS8w16R+lIUbK79zUToSEcEOcZ1FmT5baCgA8MgyIHlHDBTL/9IeGv+8aW2Su6MxspCIvhbCUnRHfXuB1jwp8TkGQ5j/PElsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363173; c=relaxed/simple;
	bh=EuaW4FnQJh+ko9mrbbs5IfkUEDZC4yELYDgRCjRezjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=VJvkJiNSJ/5hgfqQVTqhsumfgAWNCRpneEKlZXX6RC7IFWI9Bb/h0VJ8zF83O7sjg5xh5d2DQDxu+D5faQR9YZGmaRBynHiOTb7Q+3AQzkndURYm3yn1GwVUz52yggYejLYc6BziW6gihiszfpycKfkSXyY0zZwjKeDSfPsEJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=HF4KEjcW; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="HF4KEjcW"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1095607EA
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:19:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4_2HxHN2QLN for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 01:19:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3C0E6606F3
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C0E6606F3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HF4KEjcW
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C0E6606F3
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:19:31 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2638326a12.2
        for <virtualization@lists.linux-foundation.org>; Sat, 14 Sep 2024 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363170; x=1726967970; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLyCmT9A4d8YcWvLPa/afO2DGfhZ5JLM/zi5Nn9BJts=;
        b=HF4KEjcWSDi0Vn6xFLI9VNODxONY+CipVPMBem8ry5o5IPB5RqxRw//kdLYLEzY9kT
         g3MJp6+dL3e/5lcmiQMU/I1SeahLZB00NyjRcHFBT4b5F+95N+6+0YAZ+7bfvZNIqVLI
         8tHcLs6hswCiO0iKbW9nxULE1kQH03Sq67n6YVxIRLMYpIDrj0zhTOhBAkYM7p1HdnM4
         Gg4amZf3JR16RpASInL3F7dX2RGfzKhAdzyYbJoi0q411xcJ1KI/9P4jGwn3QMBSHxtD
         yfWMB+d5tx2XNztSNTC2KG417c/Fe5cCcoGj4dx4vtgXrkKF69M7IA2KZVsAMkXGzgCR
         v2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363170; x=1726967970;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLyCmT9A4d8YcWvLPa/afO2DGfhZ5JLM/zi5Nn9BJts=;
        b=cvV04pO0b2PZTMz7Id9UxswEFc+Ej15+bhIJhLLXOVtxFH3ZUugSWu1w0Wv4ag4qe4
         82+BdqOeB6TscElOklnS3B7TubVGblX4XoSVz51mLuJXDxc4iQlvpeoWD9McCIii+J08
         I4st74NehKDdmmJIl3538Y6FvwCd9FdhCAvFaq670krJX6DwanpMz6+xpfRw8wOXTt1b
         R8TC7eeNtXFt5+sjiBwIa9WL+f1IXjdfI2qBMcjqm3FEoyWFnxIwFpOgr8R3WYZaJqvn
         hsrVFl+yursFA77pO0Wk56XSwnZKpJc6LjI+GfnK+AbD4j1EBUpwl3ZTlCcuFkMB1ZCv
         fzcA==
X-Forwarded-Encrypted: i=1; AJvYcCX2ML7JJ8i6jQua7V7ZnpntDlZuzeMSj53vpe+FZs6gST7/VU6pjVW/Pg3Ux6zTRX8i0F3VRlM09BVQm651Pg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzkjmpTlOzcL0lpEp9dca38akaCu21wGF5nj08+BGP9ewKNn3Mz
	trbN5nbc3NJdRDy86lCO7R5Ku2JTZaGI8qYYbIpeyl5tAHs3LgNamP3WuEwhDFQ=
X-Google-Smtp-Source: AGHT+IF2UHBelhth2+1xufYsoelpTaniIMfonBmxDq1YLHlUWtYufWLhO9HlxpOnLIoogIrzsE5JRA==
X-Received: by 2002:a17:90a:d49:b0:2d4:bf3:428e with SMTP id 98e67ed59e1d1-2dba00659fbmr13985420a91.37.1726363170391;
        Sat, 14 Sep 2024 18:19:30 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2dbcfd252b1sm2217917a91.29.2024.09.14.18.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:19:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:44 +0900
Subject: [PATCH RFC v3 5/9] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-5-c630015db082@daynix.com>
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

tun used to simply advance iov_iter when it needs to pad virtio header.
This leaves the garbage in the buffer as is and prevents telling if the
header is padded or contains some real data.

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

