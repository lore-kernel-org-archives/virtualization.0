Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B836A340
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384606; cv=none; b=K7FLTmofORJYvGkyPzGJaoCiCaUeX3Y5AwnXqSZG06JS/oTCtkG3+p0zopRGcQANxcWYljblcv50jwLvMvhUajb4E/x5yPeO0ZqPS91Zz6SGL/wV2nOgtukwJPUBEU2rzvXlWMkwqZm4GkfDzbGsRH63Yto33KFGDQYgstTsP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384606; c=relaxed/simple;
	bh=yjq5ysintMy6qPSJ4Cdq7WhtHnZn5JBYrFkMLEUEGsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=irKpumDkl6ujL4rNnHEr7nOZqaqBhktGVy3Z2B7/1KSvitaOw45eLL+YV4zz2+Ti3FZkNUFZDr2WDdBk+y5JkzMhNJWL8HZXAciBO/uNayi2UE7P1TrcKLBpLbgpLRWgZZ9s+gqWSAXjb76+UZfR8yYxhBvfSzOuGRvubjBuPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjueoTjY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjueoTjY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1374775a12.3
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 21:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785384604; x=1785989404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnLHteJgCUKCQ5QeMJy2BEHKwrjGEMGZN70wKgx1U0U=;
        b=WjueoTjYVpOkEJu8u7eEOqEHyOk5uYFUQmuhfW8Co3octp9T9YgafZC9H/gbYedGmW
         fzLsnNIdOf4g5XRHGYddEAmVC6ZFCtHp2uxeC38jyeGUDMLVCrbjS8a1agneaS3sB4XI
         40IIZgOGk0ShAMoxSov5TS0O4mVDM7VmsKAq85qgubWOf4QuE5kgXvPey90rcb/d6OHY
         XLKKQpQ7dKMnFDxfOcsR9dJPBprSNeZprjmHMPsNwgP0c3npe4o7ICDtSrmNqf84GasS
         34DPk8WVpxrt2QqqQDEA069BN/XcTYwToRIXDYcDYYFEVWZDKsmvr4EzRIPB0NSABJfZ
         Gckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785384604; x=1785989404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnLHteJgCUKCQ5QeMJy2BEHKwrjGEMGZN70wKgx1U0U=;
        b=VaCJGkc95jOpTblhDpHa10E7kDm/P6jd6VaxgLvhTT5BTbJbyFy94iKAvdhChoHsJk
         mgRmT9HuKvTqUYK//fQL+F3q/N4FavR3EUoNPv4sQmRt9TgYAoEPyRFphr3FiNdFiXKK
         dX/l3RJnT7IGLB/xcRqHopdtbT0b2bWSjnBOySoqP47KOWH4mTm6BF0/3/PKZuID5J5T
         5qmVXBWmzwj1/Bt3z8asSGAoBwUioxrxmTf98M1e8Km2ERGmNW7HGo4Vm3Qx6xlgbdrH
         OH7IFj8JjDC8H/OTmnD/n3F4MlbmFlByvfB0xcLXkFiImmy/9M7kvObDGBC8VNILutzt
         ag4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrCqnQEon2RtTEc/us9wovLvWq+jLXeTHhKtyH2yjWA5HmgW2xVLBuS06eI9kStSDFhWsyANUmn+vXAyjSlcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgjEbKY//UdKL4N5sZgjPXWDo43J/b8rJ9XfX1LAUadT4898Jt
	8BVo7aSeQ4sH1KVbqNQ43gsn4t9AmQklmbsV16TXnRpntHkuE6CtwkJA
X-Gm-Gg: AR+sD13x1H2RLoy84vdtO4UrUayxv8/z5FEBH3BVAZee0VSQ2XhaXVac3N8I9ltqB3D
	dj1GUNk+TD/KGuw9LbRndvRnQykZw7PfOF4ZiVxiIUnmQCP3s24DO2PGI3pnl+92oEqqgYmTkwa
	UWlK4LCWxajpTv0YOSA5Dd9M83JlQtsl9B+NoZ6eoCBuujtr05XPoA5ffErR98v3KlmiSM+WuWB
	qxnkucctk1wmxsEk4B5PLpHHuTvt4TY/vQFmLkCJKBoYctqacnOBj4LJyMAM4l73Kd55KdIK+Qr
	NvQQj694VtQkUe/2a1T7marq5ga4akULPlHie6/f2K9iO/m72BaCa2zDU4d8z3tY2oAXhDjMQ8P
	5oa1c9HKEoeLJ9IAapSMXmZN9gnXOOK6v5AuY5HBMNVFuUNnV/o3d/mKYN1MDjyepjZskGKgjv1
	o/r13hJMsVIr+Y0nq0pFHlvZmvlddOCG3/lZvMupvJFgDLr3q9JJYr3hb25OeSJkYwAdbM16o=
X-Received: by 2002:a05:6a20:b58b:b0:3c0:9c1b:d0c0 with SMTP id adf61e73a8af0-3c900793598mr870063637.75.1785384603654;
        Wed, 29 Jul 2026 21:10:03 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b125bbsm15993102eec.5.2026.07.29.21.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:10:03 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM changes
Date: Thu, 30 Jul 2026 12:09:38 +0800
Message-Id: <20260730040938.1725757-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_set_features() initializes dev->iotlb when
VIRTIO_F_ACCESS_PLATFORM is enabled. It does not remove that IOTLB
when the feature is later cleared. The virtqueue still points at the
old IOTLB, and vhost_vsock_handle_tx_kick() passes descriptors to
vhost_get_vq_desc(), which translates them through that mapping.

A userspace backend can enable ACCESS_PLATFORM, install an IOTLB entry
for a payload GPA, start the device, clear ACCESS_PLATFORM, replace the
memory table, and reuse the old HVA before submitting the same GPA
again. The feature state then says direct memory access is in use
while the TX path still uses the old IOTLB HVA.

Reject clearing ACCESS_PLATFORM while the device IOTLB exists. Also
keep the existing IOTLB when a feature update leaves ACCESS_PLATFORM
enabled; VHOST_SET_FEATURES is used for runtime log updates and must
not discard the current translations by allocating an empty IOTLB.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ae01457ea2cd..57e8fd1eb670 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -798,6 +798,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 {
 	struct vhost_virtqueue *vq;
+	int ret = -EFAULT;
 	int i;
 
 	if (features & ~VHOST_VSOCK_FEATURES)
@@ -809,7 +810,14 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    vsock->dev.iotlb) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
 	}
@@ -827,7 +835,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 
 err:
 	mutex_unlock(&vsock->dev.mutex);
-	return -EFAULT;
+	return ret;
 }
 
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
-- 
2.34.1
