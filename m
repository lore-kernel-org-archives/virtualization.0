Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C101A01D4
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363665; cv=none; b=qtckT/GbAASZYfJVSBP/Q21OaMd6Ln3x/clRl5Z3S/MAknvHBKUHNEFiJVEObuZI0EYILHWli8TcgkOPcR1G2DnvT0o4u96V6fvMh3bFRye0zUWTU/kW6VpkeWbSytXKKnUsJugZ0njI8gsHXWTntqtVvFeUEecQYsFgLtDvwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363665; c=relaxed/simple;
	bh=D/KbHpktOZmWZkuzza0bk8f9eJQf34LwugBKMP/xt28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qomAd2qeXSId32AJP4M6QxXrrAFrEsOeiCynuaC3S+i9QKlSLDb4Kl/iBgA8lU1YG9ucRuyqf3GxC1pDtqI3ESlQV8sv8fDzgKOnzcYav635McBCXDoTFpYQRzrhcGiF5gLVmCds6yL674iWjc+kjPJzjiCjOI+YE//v0I/oj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NjShjECK; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NjShjECK"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01F7640A15
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJVd7bdtz2ez for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 09:01:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0935A405BC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0935A405BC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NjShjECK
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0935A405BC
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:02 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21654fdd5daso71155225ad.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363662; x=1737968462; darn=lists.linux-foundation.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vp+Td7/mzSbTV1DDL8auTuqvLhIjXvEzrkpgi0EGeVI=;
        b=NjShjECK0le2vHTy5TZzw3vhHJ1MhUVo+Y23LhLcadPYF4E53yvq7Yvg8WlIs4CCGv
         ust+V5CsVoXXozAtRJSWGeVXn66/d3P8ABIq166MMcMHELNutHAD1nEBWC8kYPNcbsoz
         puZ3w2YsIMCVdN5OG0TYhQTN5tUerY3Dn5kt/xfJTbk/vRAIxRuhfSGMXRtZ0tKBbUmd
         I3lfokUu5fVI5Ul2hO1ITpetzpehbItLuExaPU0DDBqrXSnSloPXSTL2SXoeeVBmNnEO
         1XN4BgIJNyac3LaglebfGSefPvelf7MNOFfMvk/gTf8ZZWZmiC9PbN3vMC+dCI5XZkc/
         RlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363662; x=1737968462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp+Td7/mzSbTV1DDL8auTuqvLhIjXvEzrkpgi0EGeVI=;
        b=DvTsnIaLfqL14GcqO14dGSfT5AguJPUrtXvvw6sgd7ctmn7hRKFGkg4xvdjYmjHv5+
         aKAS25C8MRAo8c8vArYQydNwQikPJT9LgNs5IlGdRCaSU2gm68dEAGuFJB8jSzbyBO3f
         gawmBnVL7GskFSi+KRLEfyTkdz3zNDKPzehgQsbUZ6ia43TSM4oeN+cB+CL19o7upKYk
         cieEOhfzcgVxAzFw9eFZQgRUCW81a5N9T9iI/SO03Lzkg13mycEH9fwJ6EmmrPOSYwXn
         buE7WRTzS3h3DJ5/8yiFwuWE5bhFI5SsacHaAsKpg63fXXoanPTrqDTBmRkGY4k/NHdr
         6Nlw==
X-Forwarded-Encrypted: i=1; AJvYcCVHt+1BorUh5yMucjdoszXiiun2rHG/zqF3P+7WCeilf+NMhtJy806QLBMy8nYZucRYfRWmZ2sBl8dNtuLLiQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyQe0VgG7WzXBwvbmwsVcVNUbneh7FTiZbY3KfSWi1xyEhLEzK8
	zCHXM5gtVLQVhN28awE58s7p6ZBwHOPSPLJ//vhocdpAdmFFpzkx9RK8XFa7v+c=
X-Gm-Gg: ASbGnct1vOvjBTu2ykmU33nhftDpAmSWdH7gaG/Il00bP1qDd5dVh8uCoHpo+WxGoa4
	ERx8lQfJjfd3rgw8/IWipOeJ/UJTwhG0IJTNm5yW1xmuspoG3Jgis4JxFJfEZI3u22wHORn6er+
	qm3d6pP+L367fF/vFRAuS2H5TGLPcRqIG7FOMOtbCISHbgWUw1PCnYDL7fQlYpHrLcOV92+Mm0S
	tGesI3kUXDGC70IK3FTcYBNIzkQdImepUai+uoysyVQoeZ+TisMPggdzXs66D024oWeS6o3
X-Google-Smtp-Source: AGHT+IFW7W3w/ZoXT2erNaTWxN+NcvV4dQQ8KrLwwzVKL+Zt7YL2px/phEUI7pHUKYl7ycKYIP1eFw==
X-Received: by 2002:a17:902:d542:b0:215:9642:4d6d with SMTP id d9443c01a7336-21c3540c875mr170754915ad.17.1737363662228;
        Mon, 20 Jan 2025 01:01:02 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21c2cea0942sm55819465ad.10.2025.01.20.01.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:01:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:12 +0900
Subject: [PATCH net-next v4 3/9] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-3-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
In-Reply-To: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
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
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index bd272b4736fb7e9004f7d91dc83c69af5239bfe0..ec56ac86584813f990fabf4633e4d96ca81176ae 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1746,6 +1746,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
+	int hdr_len = 0;
 	bool zerocopy = false;
 	int err;
 	u32 rxhash = 0;
@@ -1776,6 +1777,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
 			return -EINVAL;
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
@@ -1783,8 +1785,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1797,9 +1798,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
 		linear = copylen;
 		iov_iter_advance(&i, copylen);
 		if (iov_iter_npages(&i, INT_MAX) <= MAX_SKB_FRAGS)
@@ -1820,10 +1819,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	} else {
 		if (!zerocopy) {
 			copylen = len;
-			if (tun16_to_cpu(tun, gso.hdr_len) > good_linear)
-				linear = good_linear;
-			else
-				linear = tun16_to_cpu(tun, gso.hdr_len);
+			linear = min(hdr_len, good_linear);
 		}
 
 		if (frags) {

-- 
2.47.1

