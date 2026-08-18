Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66753339714
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027214; cv=none; b=TUpN2QVwwYXyiyMy+q4OEMW/mHuJwCV6AcieUi0Toh179iBviHm7si4Obec06gOmFoQNzZPXM85wt8f5RkAwQCWYIHdbMT1GixzuCbFelF0QNbJTsPzJkRwz49HkrZHyr75KcflFGLOPFh0oBWtj4D+gT49Ni/B23E1louo1DL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027214; c=relaxed/simple;
	bh=ieK2+IysJqjtboJuOsV9J7sxXGFN4Dr4N7HwSPkkMxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hz2SEWSk7d0Rz6BPuIbibQyrDjttTDADCIPFlYUH4re0UvLzaAv5wVZSV1JHE5L1vRp7NaV5MvgT98LE8+2Lw0SvVSUI2PgCepZpo+Og3CNMFEgslLLHde6bWMYBrPe/FTf+LeZMF/t9Cfe+xFzpVvHXfW7DRbB4rQXYblbTn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMshNkEP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMshNkEP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caced6038eso7870555ad.0
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 21:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027213; x=1787632013; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hk0+goG2CVie+owgSwZFn8ixOAcSPlM11kHKU9J/60=;
        b=TMshNkEPm5qRNYeJ5aEg7ILMUT8AkDvYCkHuBapCMA0zssbBtVBkwuPLFwDG2Dpog2
         oPpe1Dxyb1NBxKQUNhNEhzhqG7wkHV/10x2i5c1f2i6i/CYOEqxz89HvYh6EMy1uxp4b
         bxHK+Z7ZM5G5EP5Bi7kucS+fxyEngfwDdcouITO6q0yJm9UctlAV0+9GhokXPMjSZrSo
         ZuUjRnMy6oU1xMYgPhp299jzsqlNPUiBO6Ik5P68vxWnm1rkBd7h4DI0tBZVI95GNVlL
         W5TYY2AoFGx/7KOEFoMdDw7vxvDcq3HzcIMBHcNWMSMVjrVnbqRXYEVFH6Hg5Yz1M8+W
         qtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027213; x=1787632013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hk0+goG2CVie+owgSwZFn8ixOAcSPlM11kHKU9J/60=;
        b=tZ6bkwf31XlPacyaxHAnwmGyZnD9TV5jgyFDxKE4vOf5DMNKs9p86Mk6+8ZrazzfqU
         RmOSedAgYP8RP9C6uFEa4BGUkAddI7KzXVl9svAqLL9Cq1dmKz8Sf4MDxhwEVAS0oiAq
         I/FjzkORvixzm/H2rwKvvImnDODSCXtLc8mjjX+WS0KnHjEGEnVnm/vbAXmJ1cIZr8lY
         heRdvfRUP5Xoy2v8rMBh2FBuCxa0Vsn2u5UWSfSmqNcfeB+l0Cvo1YshfAPvLTZzfnLI
         +77pjlDB/97JEpDXtMVXIQsjHanzn+3yOzPQVJfvyPzlvp/pT8eJzVdiOGxr9SZkNyTV
         OF6A==
X-Forwarded-Encrypted: i=1; AHgh+RrNyhpyeOlXnEp6YAdHQ97sAgFWcimo1kYaCg032S08hWwUuCv7/SyhTpPmVFuOJRj/xWv1UWFReE1gfsLQCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgqEnGUy9s6bVRtCq35XJWpxYF9occU6eODJkgBU620j3KvEDW
	1A6rZwBId6B6OOjBZdPPGXf135QwR7Q7AzeTcgWpcGmW/C68bgMTq34h
X-Gm-Gg: AR+sD12Qq9kBo78dTDjzexTvzTCwnFVc3K7Jht1bE7KQdwmgTRiuDfwIj2Qnzv/KTSG
	H8WMYpMFynGCg6DIDQsAi8b+4OPj434D1YT7bPGHPsjuzxF71S5SLQ4s1+QHVBSi+6OpEqTj2Rj
	ZmyHPjqQ4MN7d6+qhdIhgKLtBmqlydg6+EnqR3pEuhl3fkbB7hNgnCQeTrSimCqkmhVckxXC7Cc
	E3NpQRYmHILSDyl1ryIyjpEwIJMWXnPcVKJygMeebkr9aY8dLw+KKtoPNnRthvNUZJh3uCOcRFf
	7lN8nakkA1sesar6BVt2CfttKXstMEWizt9ai9SWrm1HKKbGDM8A8J/YNGMgQvOobd7No+DPdkK
	msB0k3TYH3M9qqL2EwCu4xmVGo7HGLg8WeNw21uj4Dk4X4mndX/rjnRlks8nojPGwYMkPG1p4Re
	ThDH8Kk1UqlMBFV+sg7lYTozVBNSN1FnirTOzl2meYtxNaG1xDbP6mD/eYydQvCOwT
X-Received: by 2002:a17:902:e78e:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2d5d149bafamr27492395ad.7.1787027212376;
        Mon, 17 Aug 2026 21:26:52 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e81sm12349535ad.1.2026.08.17.21.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:26:52 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v6 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Tue, 18 Aug 2026 12:26:12 +0800
Message-Id: <20260818042613.281125-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818042613.281125-1-physicalmtea@gmail.com>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
Otherwise descriptor translation can continue to use mappings installed
before the feature change.

The common helper invalidates cached vring access and applies the
transition even while a backend is attached. The backend remains attached,
but userspace must configure the vring addresses for the new address mode
after a successful live transition.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")

Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..77a5a6775c86 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -854,6 +854,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 {
 	struct vhost_virtqueue *vq;
+	int ret = -EFAULT;
 	int i;
 
 	if (features & ~VHOST_VSOCK_FEATURES)
@@ -865,9 +866,12 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
-		if (vhost_init_device_iotlb(&vsock->dev))
+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
+		ret = vhost_init_device_iotlb(&vsock->dev);
+		if (ret)
 			goto err;
+	} else {
+		vhost_clear_device_iotlb(&vsock->dev);
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
@@ -883,7 +887,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 
 err:
 	mutex_unlock(&vsock->dev.mutex);
-	return -EFAULT;
+	return ret;
 }
 
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,

