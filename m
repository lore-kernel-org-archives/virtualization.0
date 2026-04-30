Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FB2E7BB6
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533118; cv=none; b=PJdETj5hjC3N1eDjvXHjfl+zWUtCvmGCwab46udOWb7/911R1MgGznqaMBW8cBDsBrEAd+g3qKGs04NK1W6uDREP0/8aC9VXtuWFWwxTd9ACoJvPNzpZFk3Htle+Q4hky65C4JpDp1lGFihkSimO6iKh8nLzMoO90I0ZImPPoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533118; c=relaxed/simple;
	bh=WHf7SDMWeGDMepkYHsY68ydsCu4X3ZfH1ZKR959neqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXAdj3CRyssGwe4bHF7o0Q18cRtsWLIrGjuIwUl3QfrAGm7zSmV8PBIq9EbzfBSecn4e+oRVVYSU7tm3vvSc1EN3foB3Fx6pfXrfUFdQkEVexycRq4G3M8Bt1QkQk+2+vwc6PFiTuqeNKpPYjOvDwRxqVBZ1f7lMbEZetfjlyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqxWWY2d; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqxWWY2d"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8244105fa96so21421b3a.3
        for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777533116; x=1778137916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFvNVNkRh7BzI+OzIKJ5kBHa8BAxHSA7m55h3BL2rQs=;
        b=BqxWWY2dNYMVZxwUaM3V1Rcmo30msS4L/+xURzdiq/9qo/us6j0RpqVPt/9mH0M8P8
         LP6sbe2VXRN1+ClhmxJEdSejFE/weKYAQe0BBkhgLuoxt8wQrkRtILZ/y8naqr+miyG8
         K0k6XfhdbR2QyeeiRwgjn+fqaB+Bi67Zsz/xncjrVUi0YmQTSSvLgBRfMibNFegLInK1
         +y0HDu72UlTxedTJ8Mqyvne5qsQGDaFN/LZutdSGNFIwBWct1N85m73N/MrIkhyCqFn/
         DwqThK/qfn7gn86rv3uVNwevHPmTdFriNB8j7Illxe6We2bylF+e4KT2CjOTfUtGwTAk
         3JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533116; x=1778137916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFvNVNkRh7BzI+OzIKJ5kBHa8BAxHSA7m55h3BL2rQs=;
        b=dBROgCm6egLtJ2Hn3jylYLwHZhrhTRicrFn+jXGbADKwWUi1bg3g6a14mliLMDn08N
         Nhz6b/kdG2zIclDE036hPVv8yckuqTmwpkbUgrD025di0x3xohF/oXgJfYd5jUTvuSb2
         VvAwDMSmMurXxxqoOmuOIsDC4EnLS15ElS4q7XyM8dSnIpimVzaAI7MO6UiImbgS52Ot
         5DhHy4y1JAHumXXSw69fmtmrRYKYrF+sRbpyGjRJAa5EvMoGkbKtRTP87rdflEg/iVoz
         l7Q72J31mMR7FdG9m2zqEeCjeATfxCqx44uhDmm39PZogWfC2j26UEXBzNgphAUsMEpD
         gjBA==
X-Forwarded-Encrypted: i=1; AFNElJ87n5KUyVMCDSmqtURrb0eCMhyH+fZXo8uCDpWGZmg0vqgwzyYOsVTI8kAKif2Fw53MiC/qIEUezYpxE/vxpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKGf5WYNM+h5Hv5GfHpWZGbOMw790TW9ainV/goSoTjdu7J0tQ
	FnA1Mytl0v9rcn88bkmBgGY6zkGKxpMlSlrzYIPtva4yp3Nn29xj7DR9
X-Gm-Gg: AeBDies31MTSncA7qtfUyYIuQsj5gfeF6Ls9w4pxmKNe2qgiNQg6YGLyz3i2LUK3XAE
	Q5RfwA26SeaJ3J0nk54ddtOw4SEScGEtUY49V/d0wN4vhpurHn/yjfrZ0ePA0V4r9kw/1t+IUxI
	RbfKimabW/t+cSumYL2TGVHl987wOsBscnvn5VfP09EgqHh2ihzfE4oiAeVX9z4Bnusf9zRYO2j
	uV8ip9xBD5tW7JK3tIOp9bpkSMLsM0ornM2BjU7TDmd8XwktekrMDqT/9qPPjraSGYoHAfsA3XE
	o8HnRJ026lQWCXlI2qAUBnpuKKREvBLy8kH/afmetVzD9b9+ijqGd7kbJeTTYuaFA4y4eRw8Kbb
	TpDqEABu6BNAJPFNkPwIIYTSscbU+eoG5zapgiIwZYzR215tiU+JqbskRLDafy23aw2tLvvfhwj
	Vu7PD+0z6sC7RJOlZkIZzAv1VH0WWeiN6RAMvLz5Zw0zE=
X-Received: by 2002:a05:6300:2208:b0:3a3:18d4:2590 with SMTP id adf61e73a8af0-3a3cf70d02dmr1041632637.3.1777533116186;
        Thu, 30 Apr 2026 00:11:56 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7ecf57sm4049605b3a.50.2026.04.30.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:11:55 -0700 (PDT)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yiqi Sun <sunyiqixm@gmail.com>
Subject: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap copy
Date: Thu, 30 Apr 2026 15:11:10 +0800
Message-Id: <20260430071110.380509-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsockmon mirrors packets through virtio_transport_build_skb(), which
builds a new skb and copies the payload into it. For non-linear skbs,
this goes through virtio_transport_copy_nonlinear_skb().

Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
As a result, skb_copy_datagram_iter() sees zero writable bytes
in the destination iterator and copies no payload data.

This becomes an info leak because virtio_transport_build_skb() has
already reserved payload_len bytes in the new skb with skb_put(). The
skb is then returned to the tap path with that payload area still
uninitialized, so userspace reading from a vsockmon device can observe
heap contents and potentially kernel address.

Fix it by initializing iov_iter.count to the number of bytes to copy.

Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 416d533f493d..6b26ee57ccab 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
 	iov_iter.nr_segs = 1;
 
 	to_copy = min_t(size_t, len, skb->len);
-
+	iov_iter.count = to_copy;
 	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
 			       &iov_iter, to_copy);
 }
-- 
2.34.1

