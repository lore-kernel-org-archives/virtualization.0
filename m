Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A88399000
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743324; cv=none; b=cmMxA3PcfMomVFXXkRD2xjWXJyEtMZUQxGhadX5zFBKkHIruni1wSfV4CTXAATFLp0HVJH7YHv9Csu74mHyki8plgfXltz+mi9R/AkOBB24iLOl+bgdSNxeWGtNvjkegXfdadewm8gCeRIQFouH9luEHq48cUrb2hhyc8bPCTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743324; c=relaxed/simple;
	bh=hVK5ZaKV4XKlAN+5/oG1cx4MwyE5N3AwnSgb6VJtQF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUwz+diHMpNEB5de8iuPFjtIMWC8w4uPPeL+UjcpRb6fXwnCAj4Zym4YqCLo4zg1R/7Vgb9r//CDQWFbNcrj6Usbgzr8fK9bLWC9UXjTRUDrkD65o85/YnGtH1QgmnpbYL0F7zrNRn38RF6RWNMIjN5CV7Akpttb9jfxCkr3U4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEXFQdje; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEXFQdje"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so33446465ad.0
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 21:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790743321; x=1791348121; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ud4fTEqxQzrUTwARn11POV1Taqipw52FWd2xdX+lQEY=;
        b=UEXFQdjeroSrgH3O6+VYhXbLO7z7bw11IIPCr5m1IqagK+iVWSiBTA9AYtCI2JJwK7
         bs4br9xLHuNuQ/lkw4StDpZQ9OOU0gCwICWRliRIxm1noFb2ZAP4CK5OsCEzJUzRg7df
         AqhNGvWkZJJNsh5GUFCxi7KDN8eTW5/DYk436Yf36bDAh9OOQyKzNhVC6mLzFqHFW9sI
         sJS2UMDsT3eTJwA4MMnR05tJWhuCFpZnVcdeUjgWtV7CBh0T9zOs5BesIBLtTXOziUxx
         SfVwIbrOVAsiuxjEq/D2PGQ6WbpLnkOZTFl9FQtMf7Ols73cdCanhx7wMV2Luk4KG3DS
         V6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790743321; x=1791348121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud4fTEqxQzrUTwARn11POV1Taqipw52FWd2xdX+lQEY=;
        b=cp2Cn6ApZG3nTcDEPUAhIo3Df7SJnwk6PhXl/cupf5O06IP6gq7vp/rEpZQTVdYxr9
         HsoIeRpxq+JhN9L2oIkHV+glL0qOARqMNyWiF5HxyP6GDj9LG/os4TnNB3TmJMG8VWuN
         PL3jYq4epDOjCIMnZ+vdQshjjbl/ou85Bp986fosqivlu3SBCOrMmJZgQKfn4wq14gz/
         85I4P8zzNVdnMeinVAt3/wzYXhL03C3XRDY8Evc7/e4Xqtszi+BhOsiVOM0j5WevA9a5
         jTSj4YPfL8pGDULWixcfjUzA5in5/oYbQ8a9iO0dadjFRaJAJfj742RHzh3/wRVODHjV
         WWPw==
X-Forwarded-Encrypted: i=1; AKwUvBwQ+1MSayowxEKC0uB+9wfhDMwxW53beBxQQjnIUmNNpyy4GnAnOwF3Ewanq+I/bFnYINS5VmsJR8yMmYsDug==@lists.linux.dev
X-Gm-Message-State: AFq9FYJdcMEp8D4AjcIDvihw71DNAp5vDjXKlv4xtBvzzS2Ygtu0jc+9
	C5VQHCRkJiSEEk9McnGakGO7tOMDK59fcJXhCufz/DLboTGmyukRLRNu
X-Gm-Gg: AYBFou1Hme7XfOtbox6/VMq4ffV6PiFNzE3s4MMFigi5MNBiYz7NbbV1yLQrKiJYUNW
	VdW2r6R72HNVUTQcpEhSsIhYJfUffUtlcPQuh8S9ue2RcbjMyNbwFT3mCcoRcqTDugM4BllEyjy
	GSxzl9q7X2VMClP4WEkKtqYm1U/1kRev//C94FoeIomn3Nyui3dVbRTh8t7UyEkD7vcDYD30cCL
	0hV5VMgqyOdCFN1SWmgOoPMaDNHylWyN3vXR/IZho98kgAYYkLeBvTJ+8zQYzFWZSjzC1/LQn04
	VxClZZy0TP2UEDLIelhdTFoyBYGjiMZsMb27T4ZD5bs/+sClye0p5htgRwO060H+7WA491l+vYc
	XVwcdZGT3FtpfRaDkvuNyhCWs9GT7GRkKgyI6F6hWYL7w0x+jx83pFO8bPvR7M0fEBwVOIlm040
	lAsw2gd2y5Zbs+bprJNbnJG9fGB/eWSZUnHY4+9Wd0OiR15a1IAeoSQJN0lFssjt2SLD39e24aY
	s5DR3OC+cI=
X-Received: by 2002:a17:902:ce90:b0:2df:9eb0:761a with SMTP id d9443c01a7336-2e2e4a25a1bmr2167915ad.25.1790743320928;
        Tue, 29 Sep 2026 21:42:00 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5b89c06sm538155ad.24.2026.09.29.21.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:42:00 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload length
Date: Wed, 30 Sep 2026 13:41:45 +0900
Message-ID: <20260930044147.3818241-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_alloc_skb() sizes its skb from the total guest descriptor
length, while virtio_vsock_hdr.len independently declares the payload
length.  Since commit ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs
for handling large receive buffers"), large descriptors use skb fragments.

virtio_vsock_skb_put() currently changes only skb->len for a nonlinear
skb, leaving skb->data_len and all fragments attached.  The zero-payload
fast path skips the helper entirely.  A guest can therefore retain the
full descriptor allocation while receive credit accounts no payload.

On Linux v7.2, 455 zero-payload skbs retained 30,255,680 bytes on a
256 KiB receive buffer while rx_bytes and buf_used remained zero.  A
full-payload control retained 265,984 bytes in four skbs.  The existing
SKB_TRUESIZE(0) queue budget caps skb count but does not account for these
descriptor-sized fragments.

Set skb->len to the fragment length before calling pskb_trim(), then trim
to the declared payload length.  This releases unused fragments and lets
skb_condense() reduce truesize.  Move the zero-payload return after the
helper so zero-length packets are trimmed too.

These skbs are newly allocated, unique, and have no frag_list, so the trim
does not enter an allocation-bearing path.  Keep a warning for a violated
caller contract.

The fixed v7.2 image left a one-byte skb with no fragments and reduced
the zero-payload queue to one 960-byte skb.  The build had no compiler
warnings, and the run had no sanitizer, WARN, oops, or panic findings.

Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Required configuration is CONFIG_VSOCKETS, CONFIG_VIRTIO_VSOCKETS_COMMON,
and CONFIG_VHOST_VSOCK.

The source reproducer is available privately to maintainers and is
omitted from this public AI-assisted report. It exercises the real
allocation helper and VSOCK receive queue from an in-kernel module, not
a live guest virtqueue. Guest control is source-confirmed, but live guest
end-to-end validation and deliberate host OOM were not performed. No KASAN
splat is expected or claimed; the oracle is retained truesize and receive
credit state above.

 drivers/vhost/vsock.c        | 6 ++----
 include/linux/virtio_vsock.h | 9 ++++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index abed1fbcf66c..fa59456abda9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -400,10 +400,6 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	payload_len = le32_to_cpu(hdr->len);
 
-	/* No payload */
-	if (!payload_len)
-		return skb;
-
 	/* The pkt is too big or the length in the header is invalid */
 	if (payload_len + sizeof(*hdr) > len) {
 		kfree_skb(skb);
@@ -411,6 +407,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	}
 
 	virtio_vsock_skb_put(skb, payload_len);
+	if (!payload_len)
+		return skb;
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..31358683e23e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -51,10 +51,13 @@ static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
 {
 	DEBUG_NET_WARN_ON_ONCE(skb->len);
 
-	if (skb_is_nonlinear(skb))
-		skb->len = len;
-	else
+	if (skb_is_nonlinear(skb)) {
+		skb->len = skb->data_len;
+		if (WARN_ON_ONCE(pskb_trim(skb, len)))
+			return;
+	} else {
 		skb_put(skb, len);
+	}
 }
 
 static inline struct sk_buff *

base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
-- 
2.55.0
