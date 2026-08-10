Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB73AB28E
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369265; cv=none; b=ChIyGKB/toYf6u9Xk/P7T7VbKzrahz/6RfAQFIZ3fkCZbPa2u9mCbcKl9KKz+/ak29kuJ0qFBlKzAoYbc/2tK7GF3SCK7d9T+2jC+2RYbFItTq1uDN3oiZzvhB8XfIAJdLLwFRCAdMqUApsGfIiNTTGmpGnym7QhDsrAW6MzzTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369265; c=relaxed/simple;
	bh=m53EkhQFEeVWYP+OkPDmqEJQ4fOSY+ZFOJarQope3ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2079dDHj28Awd6i2IF+2XZFZR6nAV1QBFToSpPd9KL8GKs6ZNwuKmumRzmTW5u2poLH09dQaMa1x+Ba8VZf4dilDGjv3IrInphRneZZ+xahXAWdyT/oW2udig5K54g5NBBNaZ8wt9tExXvX0+wT3f0TZzcdYX2VepqkLyLplIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSltaodj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSltaodj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1862500b3a.3
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369263; x=1786974063; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rWtRbZHwwJKxr9m3CvsahX+FmG6nPUQO4TaHyIPdRr8=;
        b=WSltaodjJJLCUiQZ7MWjhQK4gyWz84fh3jzz1PjiL6GwXO/JZLgzIrP+SJMTDbd4+k
         GSjPuOsDZMom9NNxcehwFutIck/E/9gE0pgyBruCh/5kXy0m0QqMa91U4uQRA1KEd5y0
         5tBpMPrpq/4/ziI3bXRrL47heuGuviLMkLdLxPd+k4erHLrcOKyc0AmLMw/8ZytXaBPP
         5fUbe49fRVadGVAdWNqM1FmQemklTZ8XBj+gSAGwsyh5XIFQUs2WCGwRBgg+QhsIDX47
         2Nyb38f5BpEtfr4kHjWQGiO3KY0gLt4MPd21fztPIZx6Y/bfdGTNPGgZ7ghMGB9xy4Nt
         cM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369263; x=1786974063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rWtRbZHwwJKxr9m3CvsahX+FmG6nPUQO4TaHyIPdRr8=;
        b=otxl+gBMdbEIB9gGaE0sxIm0p85QpxKPUDG45NmW7xlcbA6VNRrXjUFslsPOdD1iFU
         6XC/VtOfTzji454Xs1aqThbjNFPX89lU2wD9xJPPgClLYCCaeBfjjBr9t4Y4vPxn+waY
         E7f6Fr9/74y2MKC1/DRsaRsRNmMJ3Ey/D3Qro9fzXHardp7oPaoWFsnlE1uZZz1C5Pfw
         agoT8Lwpq3C4MPS4yOYOIFQEs3fdE767LxOSC37h/Cpae35cSjGIojkeqo7gsYneH0vw
         qBfsRAz+wLoMj98X6CFBnfZApes534sLjwxyDEyFw8d1BeN50XhtI44rqVtuZ4+IoZbB
         If3w==
X-Forwarded-Encrypted: i=1; AHgh+RrE4Vs5Ln4D80sTSI+RzB1kqRQeMlyfSjGaq/yakD76LXaLthAuL1Cy1hpILqGQVG+CZtpf6kEL0wzv6siedQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgKeLIc8w4Y6pcG3j1bbJU4U57qhzbosVbOF7ZtbMbzBK7J5NK
	zNNWYi11iR9skitBEWgYbc78PdmqdLMiCJdG3xrpNuvktNvNcJHnOC5R
X-Gm-Gg: AR+sD12jO23bH0NlbaltSbS00mBN8IrU/MyyydLT/itus9nHpghE5+jmvk5JaWIdfbl
	UZ5gi9mnVG4cdWBPwIJk+TtMKfTO5+Zb1y7ig+oVO9WsauswV2yoNTPAqVTQfySzEvhr2b+WNFl
	wXGI7EG6t2a8ImYQSN6anQRCTZbFHKJ8PMm48YAuILFFR7CmqWDa6lDUwLyUjGEX/mh6MMVZ4dX
	kzBydr13/ESKqLlLX6Y2gGhcKGJhb06iBfTQj5xKVRZ6fhTYf148AASGDo+DDGxYTCc5wp1IgDt
	jsBNuNAu1EHKlTFms7kIu5iCGdAIgRMyxt+rrkvuXIcnrbYFQq2KTXvlMl1203XdWaHnA2/295I
	NgJ0Fq9DpPvN0PbzxTLPTmlacHeW9Jr1R9Q9AT67+QLavHeKoNU1rb2zo3k1YAbpdT/iadEEMJK
	kP4Wo9wMp51kOIfIGATB2aBUAHijzgVKqP6HQnB9hYsV2f4tgZd44lHHQtCnk=
X-Received: by 2002:a05:6a00:4086:b0:847:b16b:46d9 with SMTP id d2e1a72fcca58-84f9c9983d1mr1774067b3a.34.1786369262252;
        Mon, 10 Aug 2026 06:41:02 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f166sm4006236b3a.35.2026.08.10.06.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:41:01 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Mon, 10 Aug 2026 21:40:17 +0800
Message-Id: <20260810134018.143973-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810134018.143973-1-physicalmtea@gmail.com>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_set_features() leaves the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
continue to use translations installed before the feature change,
including HVAs made stale by a later memory table update.

Detach the device IOTLB before acknowledging a feature mask without
ACCESS_PLATFORM. Serialize each virtqueue handoff with its own mutex
while clearing its IOTLB pointer, resetting its metadata cache, and
updating its acknowledged features. Keep the old IOTLB alive until all
virtqueues have dropped their references, then free it.

Also drop queued IOTLB miss messages and wake readers now that the
device no longer accepts IOTLB updates.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..7372c22691de 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -851,6 +851,30 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	return 0;
 }
 
+/* Caller must hold the device mutex. */
+static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 features)
+{
+	struct vhost_iotlb *iotlb;
+	struct vhost_virtqueue *vq;
+	int i;
+
+	iotlb = vsock->dev.iotlb;
+	vsock->dev.iotlb = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+		mutex_lock(&vsock->vqs[i].mutex);
+		vq = &vsock->vqs[i];
+		vq->iotlb = NULL;
+		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
+		vq->acked_features = features;
+		mutex_unlock(&vsock->vqs[i].mutex);
+	}
+
+	vhost_clear_msg(&vsock->dev);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&vsock->dev.wait, EPOLLIN | EPOLLRDNORM);
+}
+
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 {
 	struct vhost_virtqueue *vq;
@@ -872,11 +896,16 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
-		vq = &vsock->vqs[i];
-		mutex_lock(&vq->mutex);
-		vq->acked_features = features;
-		mutex_unlock(&vq->mutex);
+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    vsock->dev.iotlb) {
+		vhost_vsock_clear_iotlb(vsock, features);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+			vq = &vsock->vqs[i];
+			mutex_lock(&vq->mutex);
+			vq->acked_features = features;
+			mutex_unlock(&vq->mutex);
+		}
 	}
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
-- 
2.34.1

