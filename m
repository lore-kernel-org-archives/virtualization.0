Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47982227BB7
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736571; cv=none; b=WHJuyktViu3kcei2UFBcUZg4J6OMrppE0WvMWimb6kMWoiA0tw7jf4WZsetRtDaeY/d/CUlGNknAbVEjFXZFL730ZiFwl9RfH7gsiYQxnvBcExlPoa/V6MrYZaoq4o2CncrMBNXMy2xvddY/Jgo1yvgAzLMNeyE5jfuzqTaRmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736571; c=relaxed/simple;
	bh=OvIPYK+g9j4h856snHiOWJ7ZQgHA0nLVU5L7vERmbt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTwLJjvKYsW3q/LaPfXRpFyoB8JuWi4UCnO01TyrervTAtMu8KnOw7SQY04gY/vQHCR6drrVVjIEEuiv/z/KkAW/SLxhSF9Vntw3oxi8I3+q0RtFxUiNOcKMtxZETZVlSIwZ7+VUWup7EhZdt1MFaqgfY9UVnq0K58eB6xkszsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=F2T4Q00X; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="F2T4Q00X"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8B0D40247
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 28pSQ9kB-yJC for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 06:22:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E417A400F9
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E417A400F9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=F2T4Q00X
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E417A400F9
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:47 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-21ddab8800bso91236205ad.3
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Feb 2025 22:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736567; x=1739341367; darn=lists.linux-foundation.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3Yb4yc3CLfLvYu/aaxzBml3Yua5P+KV0PLbqfrkL/0=;
        b=F2T4Q00XFTk+18IHf+bAT1kVPTCflQ+7NGcMsb89SnnUg1ElX6B0II+hGgtLrGar+C
         T08koCX4rdPl+tf8v2oak42w9W7XfjaHt9YJREreGA1BSGoy0HsFs70YE45yW/TdtxTC
         sH4H69YQ4KM+A1nULhfHCwsRl5Qny0hCxd7dfc963bBc/+enDpYNCI7/Pxwrx04Rf7/Y
         /f7oIIBDZvIOoINa7RFonvctGsQk7d1ntGLB4WGJPQNL0p8fv0myy8x96Uo7IvvezuaN
         mB9qFnzRxVj0RaDX0zeTKnCYr1C7kRNW/7wQjN9Rtb2XVW7RxOrfbAeokwSDatwNf25N
         4cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736567; x=1739341367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Yb4yc3CLfLvYu/aaxzBml3Yua5P+KV0PLbqfrkL/0=;
        b=t8NskeAxz2EnVlDc5c1hv5oL6gxkdXkg0RshGMcJGqwoSRCLlemcIUNBbaEmytAP/W
         iGL6/Qt9mib/X2Xryf99sM6InNKXaR2kznWFNLCjAJJ+mbJAqE5Dv633+67L0RXI0YKr
         VliQnkoMFujBL/5ulavAfgtHST5r2h/rhtMTg2+oRx6lrKo98ynxQ8Auwp7WsPmVwB0f
         SGgGdTRcUCt0C342KAqQkAlckmlq9ydspQnqdbmtD06AawMeLRdQucOjsuhw9C+/Nqyx
         PtdMU7ysi2P/3C2csY5w/eiJO7FbZX8HmYlmzsNZc9qRwTz5ty0k6aNkn1a++NvtCd1u
         fh4w==
X-Forwarded-Encrypted: i=1; AJvYcCWjSHthSsHyBRJXmTtW+4zvBl3S6vIvVYg4XFaFt6C+6jBHkdlU2H6puTCdA9cfRRonFZNt/uWc+Wg12l6M0w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwPFBkoz2jpHOyKS3EFdeczZIry5yoaMMHMUL8Pr6NDcLG499/x
	AIidHPV4EcPockCIBFtZtgCWslTujMI0SmUPboqKDfPMZQhHnYm8rIEMIJUgpFY=
X-Gm-Gg: ASbGncuivSEuNKQJV+5Y72+bfn+XgetFu84Zo0bOgqyyHrUqd+PbV1vSJYDqM58b2q2
	JMdc4ASeUQWpbSxXXY9ebCjYoZBTgxx/KYk3HSgxj6nMPIo0wul3ciYQx36PlARs88pf6R3mwmR
	fUFtlnOPNi7FiON2vbSIrL7cFUUoeNZlXaJ4RIhao3iZSI3XHRYebOQHom/9zrcOykm9DVr3gue
	djRi2oMwMYhOZLZm/sv/0pMWnQCgxBcOBcxm7Nl3DhQbZUxBxiL3OXUbLwPb4UvXNcbiJE+11BY
	9yjgWgrxBEo9ROdxJdY=
X-Google-Smtp-Source: AGHT+IGzWVq9qQMR0OtpSV0vC3qHwySYobptxhoMmB1piJ2/BjXgoNAU3mlOXjwt7ZL5XD+44dzxog==
X-Received: by 2002:a05:6a00:2e1b:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-73035101c2bmr2780925b3a.8.1738736567160;
        Tue, 04 Feb 2025 22:22:47 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe6427309sm11714424b3a.43.2025.02.04.22.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:24 +0900
Subject: [PATCH net-next v5 2/7] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-2-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
In-Reply-To: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
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
 drivers/net/tun.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 452fc5104260fe7ff5fdd5cedc5d2647cbe35c79..9d4aabc3b63c8f9baab82d7ab2bba567e9075484 100644
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
@@ -1772,19 +1773,21 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (!copy_from_iter_full(&gso, sizeof(gso), from))
 			return -EFAULT;
 
-		if ((gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
-			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 
-		if (tun16_to_cpu(tun, gso.hdr_len) > len)
+		if (gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+			hdr_len = max(tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2, hdr_len);
+			gso.hdr_len = cpu_to_tun16(tun, hdr_len);
+		}
+
+		if (hdr_len > len)
 			return -EINVAL;
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1797,9 +1800,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
@@ -1820,10 +1821,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
2.48.1

