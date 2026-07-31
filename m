Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B2416125
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494113; cv=none; b=CMZuiOBOZ9rKkKkQwNbspWJqkdJiWGTzoO2h5W3blo1sH4B+gk4TuK3GM7B0BwlDuBSv2dD6583b1pyKHM+fBb0dBwVcmcv9z8C1uvoHyn3+uPbmckioWvR07WuGOYoOfwKFZuiksRvY8uNgGps7RuO3zyrHO/6GRODqrXrX4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494113; c=relaxed/simple;
	bh=3wxMKIaYa0TEK/wezstt8blZU4l0k9Wg9VQ5r2HlO0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5Nz3sfeunZKO+fAOEA3Nl/6bdENdu6bShyjUWTPLdv4YypD/KRi7YTZOsNO9kMVyiIx7fJ5PU6CQjREq3M8EF/T4xfmTcBrlkDJN7+2deSBaSgaDinYrk6Rn8LTWWZgOZhpMYYBb47WAQ7shO971gK3EnuHy39o1zh1sEBvsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzvzJ0uL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzvzJ0uL"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381216921aaso793246a91.1
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785494068; x=1786098868; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSbgQp8eeyj2uwGNe57D0ofyxWkLsHgs5sTW3EdnPUM=;
        b=YzvzJ0uLLxPZNGWZ7VFJRFo0iQfs+ExJzNPJZmA4fCatNKmqi3kqm/N0+MfGg9/gCQ
         umw95AgcHFjezXJFiR4+6A+hB6j76X5H31cTMe/q6vIxeoN7hOtwm40oJXDXrSi1Iq7J
         m9nwcvu1mEMrofTzqzg781f0YobP605WqoEjEfLndedBvzEKj5uOaqfS+l/Yf3n6nHR2
         Lc9gLNVp0zbjIbC2OOlQKPjBwU7sQQbEWt9PS/zFwiSjJ4Vyum2aKQFgt7nBKRGodVRt
         jgZxD0mhPLkxwjrWIOuW4mEcv4lbkD6/EsDbSnWMa7N7Q9dPLjbkvlnZhlt3FFVH8UbD
         4f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494068; x=1786098868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSbgQp8eeyj2uwGNe57D0ofyxWkLsHgs5sTW3EdnPUM=;
        b=LsXYhopqEKbgL17lPcdovzNQhOpwrSFUZ+D2R7R7qvAGAC0xM69OTFToSERv4UFmnM
         5euZXV3Pe6yj+jWOlDIlAzZ9LTop1FnZSTrzBWvEauFxrlYjuG5yvh1xe6N0fVjGb7cz
         uKkd7UDjhSyrsx7KECf0L/njn59DUX7LiHCFj+Mjy5Lp+K32DWx9x919crO4Kd8FDR0Y
         tR9beQYPNtsuF7yzGpd/Md4+tvcsbK0YGP1jt/qtPQ4mD4Hfm11jYES5dR6JI6A1gcvD
         LTEIP4xiwagjOvI3o2no+u3U5QSJCaPmMekBP7iEfPllDXGZBlRlN7bqtmLrzC9AzEto
         EuxA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4VVjKhcLXSAyyae/gE15qecuV/uAnho1hbRZeJnIJ3uDjTTLlT+8RaBULtOHFKSlTpIv4Gff/NaFM0Lt41Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzS4dN4Y/5e/SIxLhO2dSgOKXTJJXlWPW2MOZ44jiOwMDjFcZbO
	kjkWn/puNv0nA0szphf/e26pF6MlBjw6ZOtNBbmbenvR+AQ2hcCQyLUg
X-Gm-Gg: AR+sD115eUI76BkRXxgeiZXzowQWlykA5Ym/S79KvRK0ZgtCXecwVeZvuAxwUTtmUzc
	8FnPKgtBpZf150JmZ0Z1BxR6X+oRbnWCoqPYkcaRM7Cf/PsqocwZzNS4GvyDuk9h0f9w5hhgCX5
	zdx4kqvPGXKtAxL5sW9QvK6m++sqiZvMJDIbUQkFUKK3jvQtaTo8RAUsY8dkl7k+w4Yf87TaZih
	7+Fz2MO8s7vtsNluwx0jho6mLohugZbBy0kcHEDqoKtSQfQ6Qc2qJFnr7TG+dNEU5BRMSNIFkxP
	BC8lIeuyCGYGBRK0UmO/cZQZboJDDj5Ne4wQISq4pYE7xKYDPTAWeI3NNk0u7gIK5FzA5naMctk
	lizJWf+NTd87t+ZicJS3+V2H61GIegoKCs2TY78MdMW5OTXChWwb+1G6CaZy2roN5GCRlv0mpll
	hZ/FA+i2jUjTrRlT3kKfKJ4Jl0uBe25g1midtV132pqAtSpusq0gXcjqgHJEqng3Q=
X-Received: by 2002:a17:90b:5810:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-38fb13515aemr1518516a91.21.1785494067758;
        Fri, 31 Jul 2026 03:34:27 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153db2f911sm5434719eec.0.2026.07.31.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:27 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 31 Jul 2026 18:34:13 +0800
Message-Id: <20260731103414.1746316-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731103414.1746316-1-physicalmtea@gmail.com>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
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

Detach the IOTLB before acknowledging a feature mask without
ACCESS_PLATFORM. Hold all virtqueue mutexes in index order while clearing
the device and virtqueue IOTLB pointers, resetting metadata caches, and
updating the acknowledged features. This prevents a kick handler from
observing a mixed translation state.

Free the old IOTLB after releasing the virtqueue mutexes. Also drop
the old IOTLB miss messages and wake readers now that the device no
longer accepts IOTLB updates.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..562b9e139a76 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -851,6 +851,34 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	return 0;
 }
 
+/* Caller must hold the device mutex. */
+static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 features)
+{
+	struct vhost_iotlb *iotlb;
+	struct vhost_virtqueue *vq;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
+		mutex_lock_nested(&vsock->vqs[i].mutex, i);
+
+	iotlb = vsock->dev.iotlb;
+	vsock->dev.iotlb = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+		vq = &vsock->vqs[i];
+		vq->iotlb = NULL;
+		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
+		vq->acked_features = features;
+	}
+
+	for (i = ARRAY_SIZE(vsock->vqs); i-- > 0;)
+		mutex_unlock(&vsock->vqs[i].mutex);
+
+	vhost_clear_msg(&vsock->dev);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&vsock->dev.wait, EPOLLIN | EPOLLRDNORM);
+}
+
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 {
 	struct vhost_virtqueue *vq;
@@ -872,11 +900,16 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 
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

