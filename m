Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D78417BD2
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692569; cv=none; b=F12BRqnvawDjIUGdMf+dmzNknCpLFaHoedSNep2u5Tm4PqbjDNKkQAJGOqPZasS03rnogqXimzKnBWHtzAHTwk3YXhRPjx2yIyjpvjKgNE8p8/+EoDQLlCvE5xxtNW9l/MR8JUrZHEZ4VVBkoY3XuKw0CVRnSKppRBGGGCZ0u1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692569; c=relaxed/simple;
	bh=y6rMr9v8RkMQDzFniTx5ksD4K7N0krZyH7ayvc6VZdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkXqFfSUqiimiD7QEhrwtytyjewGj999COo6mAzYBJKOwuLHOYsU4L+appOJqSMhAOeqiUQZP4JYv4heRNRRFN85y8kO0jO0RA1pksVd479OiMp+c0q2tx77g2ty3KOoTMdnNxnf8DTYa4T2TSx+mrv+6GWwTlQQEjIosxHaPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8cxDWzx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8cxDWzx"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848743155bcso217535b3a.0
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692562; x=1787297362; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=whRMOBoocsT3J+VYRBCXYaXX4rPKx8GaSyd74snbzsw=;
        b=B8cxDWzxRy5x9+LxP14Fl+kLTVuXjhiJGq0s+vZTJ7A0LhaAhzajWrJIS97zrSRfjs
         qdLSUtQfdf9BtzeiMXKPy9wGkwhnDFEAEhnp31VX0scLSW2htjss4VcyADkQvu5R/DwG
         oIcdxfK8kNIRejvicjtkUMWFKu11TUHbZ4QiaLkdWKcEXs2xGytVKTuPZyOZDKop1dR8
         Je/NcttQlaiIjrIVDJPyG+XeNkIVUjw2+efBlRq0jYUqsDSWy8rgrXWCjjjCpjNCK/BK
         EAZ00rRJS1AYXpSVRfsCuj6jRUttBo9JRR/wM2MjYs2vHv30j1ZsLaK+p83TdKY7kKAe
         uFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692562; x=1787297362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=whRMOBoocsT3J+VYRBCXYaXX4rPKx8GaSyd74snbzsw=;
        b=ScQ86Qdu9JT54paw04utdC7JgGm81219EmE7Gtmn/ZDj1ZcZ2MwK/iYLR/Bul5ScB4
         /3jCRHqB/L0qzvXiMthcHXBsi/O9IuxVMxODhwYoxEmQTL/z6XEI0yr6fFWTHzSpNP3B
         9/z6u8L3N/uTnkgbB3sb2SN9xX0tnF4bH/haSBMP9nN+0Iks4SlqHuTt0KvutoYGM9qZ
         TQPDy9XCZDECGJeodbtkF5aMIj/ge98LzfV7b9pDfYIEYm+EF/8DXRUiWUZWeU57NE8P
         kYIfgaJ5yG/19ZwtaZChEOJ76+XrWNgCRmh9R+vd4drUQdnwOgZrc4aDPg//HMckxD0P
         QEJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwV5jqcdSHSzFXqVZmnwQyHuXlgMZ0qcHSdpibn5oxZHnhvQQPzNIwH31vx+tWc08JRY4+DKvuXqD4QVuK+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNAljLXKwpxVNm3tW/ZAwPwSaTUerdpSsIY63h1oEHK9EUFC4c
	bV2noumj1o3JaVleikno6ISoY08sNqraQOuh2IYLWaUM53KtTLH0UNdw
X-Gm-Gg: AR+sD13OP/Hn6i4hsJ6J+crORcYDBa3YSib4lJFHLXynmS87g/otnClevsc6/4EbqyD
	GVHCsQ9CpS1xgqZHritroCsIDISt9hh4Ka/Y7gq05P/Fz/uXMibqCrIPvR2l3cAEo2nUp1MQ4Jm
	fPdMxzp/QAm3yYEDNebqcTnVXv8xh3CNIi83ixWFcRVPHMsX3K6xfyxZlie3Kz5LdgJdEZh7w+D
	y2S5l7DL3Qeplpn6EsIt7b1BofggbYhb91mfztEmo/HDUP+BaGdBLbPCzkORJrf9IXnhWtQXQ97
	yy215KtQ9VG+QJdNlHqwsmCRLb3tW9emmKj4N/Plkp7MtymerPnAOFW7jamaDH/sBau/FOF+skK
	NbaSVpuHO7LiiyMtP1jDp5acnrgGQS0oAYoYBlml0dom7KdUA1yMCLXgMGKk37IY4X5iQeIq4fI
	DZrwXQQd4ojhoPJai6C/bxMSJ7dI3EkVKt8SaCE0HCqQkr0MdSMOqGLQyRVuJSDpA=
X-Received: by 2002:a05:6a00:1793:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84fde314673mr3794400b3a.35.1786692562070;
        Fri, 14 Aug 2026 00:29:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d249b39sm93258b3a.47.2026.08.14.00.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:21 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v4 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 15:29:02 +0800
Message-Id: <20260814072903.124991-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
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

Use the common vhost helper to detach the device IOTLB before
acknowledging a feature mask without ACCESS_PLATFORM. The helper clears
each virtqueue's IOTLB pointer and metadata cache under its mutex, then
frees the old IOTLB after all virtqueues have dropped their references.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..b69c260eaeff 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -863,7 +863,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
 	    !vhost_log_access_ok(&vsock->dev)) {
 		goto err;
 	}
 
+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    vsock->dev.iotlb)
+		vhost_clear_device_iotlb(&vsock->dev);
+
 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
-- 
2.34.1
