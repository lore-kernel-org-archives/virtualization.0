Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23337BE8B
	for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785075146; cv=none; b=iIdyuHAmPyj3Bl7ApyByL0iZLHL3tNQbgzPJAMbVec2EgHdxM5WBK6GGk2aRLWUpLS689Z38ubkuPTx+ApvFh4AXKtISbo9k8UR/O0wyMUbhBrUsebyzuyKz5209MlRPibFGz9KK6jKIUG5nckEkPVYRynkj0+5eBlpLbC//xjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785075146; c=relaxed/simple;
	bh=hAzGSzba1NEi7B4ecRdbiFHQv/Op0Tbx9G5qrGuEuC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g6c9/j7pgGQBXcBFWG8PfG5tiX+tffJjuqs1UcalCvljDpE6oAjAZ6fLRtEtpdYlqjbPDbMEVGt7Y8p8FVvYmV9Pp+4G9dA3Q5Fw7ix2KCSUEGKnhkQ2Dq+4wnxiUTxd9pME9Xh9GAV4JDYd9pnePf/nO9lJMlsbjCe/56+YUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuJTIftd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuJTIftd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1433957a91.0
        for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785075144; x=1785679944; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QKBVDCs0y9smsIpgENM3SuWaNy6SuXbVP3tPSuphxHk=;
        b=GuJTIftdJ3/aYpnHQnQD1mTS9qCCAdWltYy0F4ifQUrq5brc0GTUhpJLxy+1cdU/ym
         ZYeBcouk8uD/3pCH91i/vsU6oMvWfN0ah9sdd3jpnaMFlugIhPxiLvPkPIpqzEkVELYY
         pbLqEZp1vGE+/Cg7PdFQbnQgiY9dtgrdmY5gxGS/Awt/cqANRS4JSrLgch39dFUcjubs
         preaQO61nbf+b1N1unI0GxOcQOWxDW/rsPaBttjH8uQrS0LFzxY1y/BYgbOaASzuWMtO
         a2PQDZcrEl3NOlHt1sxl2XdnOeOwxGrUFoqpdHOxKs+WIKSSMVFnsiPqBriYia/FFwhX
         7aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785075144; x=1785679944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKBVDCs0y9smsIpgENM3SuWaNy6SuXbVP3tPSuphxHk=;
        b=MQAF08V74Vh4gr/QONEbi5ElNvMm2ELPewxHftNsMiVBFalVTUT5uFVMN4SNRzZyF4
         WeKPV93aO5ilCPsjhSSFiYoeAGCTqsrs3ADw2SBM/KR0Q3lOljKicfEUUqOB/2f+jSlV
         yCCQLPuzOf8cHHbj2cLdJUygmgSafzOJOuD+hizsZZvghyE29jyZkemLc+N9DcUCWVe4
         fdutgks+GDCtiwdGe+NKnEaBMNRafTz9gBjjgRFjmBFbgsQeK6bfWSYDB9bo0ZrmxOHx
         rQAW/7FxLMqvoAq/M+xXlLVaZA/Oz+Rv/b+qPiJ4HD7HizJaZJlL2QlTmlasyGBHOwYM
         aepg==
X-Forwarded-Encrypted: i=1; AHgh+RqiTnLi50jQEML9icqkIcAZOKZgP4fw1NY6hNnZV3xl2Z/yc71U3ZtwasJ7+c6sOkFt7GGq1X+dsNDtcdJOZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZE1RcTgE73vMsr+y5fAGGl2sKU53BjVpvavayya70LHQ7O9fM
	dRnj1dgdvCq6tu9pBaA9+aTcnTtIHa68qv9HC26cFNS725BkkNEsOO/L
X-Gm-Gg: AR+sD11USMVi0uTJ32KW+luN2v4zpwu0PFtCj67Khq8/f7f2MpnkETlwBvco8UJLi+F
	WkH5NoaOqcQ+eywJjqxnmO6YUN/HOVmA4u/orHhOtjVklvGAs9LseomJ+GuD7nDVhh5W67aMeDi
	ytMFtycBSVbN5di/83LID4Jp2N5jW/ktmIJ2yJ3KFeP4QpZutDrJar78/CMxwvO6OIwRikRts7T
	4rBALtjXtQz2o87YMARuftLiH+qAsaLdjXvxB9Fxqhj9Yu/LdfO9o9q1gqGwj0ZBbcZgGOcVbbc
	AzkFkThArAlhovXCF2eYXKPwgfkLOiwf6UDJxRn5+HXS0rJ0kWUpeV2A9sOGVefYvFW66rTLL5g
	Z7H6qcu3POBrI2Nv/csWXDzCLbhAF1ESgxuDgVjUoBg8LNko9206ljq/0/be9juOCvaGLFxIuaw
	jXmw==
X-Received: by 2002:a17:90b:4b8e:b0:38e:2a4:cffc with SMTP id 98e67ed59e1d1-38f2961561dmr5471035a91.25.1785075143784;
        Sun, 26 Jul 2026 07:12:23 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e0f4a039asm17136083c88.9.2026.07.26.07.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 07:12:23 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	physicalmtea@gmail.com
Subject: [PATCH] vhost_net: reject unsafe feature changes after activation
Date: Sun, 26 Jul 2026 22:11:58 +0800
Message-Id: <20260726141158.1652386-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_net_set_features() is reachable through VHOST_SET_FEATURES and
VHOST_SET_FEATURES_ARRAY. A successful VHOST_NET_SET_BACKEND with a
socket backend invokes vhost_net_set_backend() and enables a virtqueue;
a later VHOST_SET_FEATURES can still change feature-dependent state.

When ACCESS_PLATFORM is first enabled, vhost_net_set_features() calls
vhost_init_device_iotlb(). vhost_get_vq_desc() calls translate_desc(),
which prefers dev->iotlb over dev->umem. Clearing ACCESS_PLATFORM
updates acked_features but does not clear dev->iotlb, so the old IOTLB
and its HVA entries remain in the descriptor path.

With IN_ORDER disabled, vhost_get_vq_desc() reads the next head from
the guest's avail ring but still advances vq->next_avail_head after a
successful consume. Enabling IN_ORDER later makes vhost use that
existing cursor without resetting it, so the next descriptor may not
be the one from the guest's avail ring.

Keep feature negotiation fixed after the first successful backend
activation, except for VHOST_F_LOG_ALL. Reject clearing
ACCESS_PLATFORM while a device IOTLB exists, and avoid rebuilding an
existing IOTLB for a log-only update. Use VHOST_RESET_OWNER before
starting a new feature negotiation.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Fixes: 45347e79b544 ("vhost_net: basic in_order support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 6edac0c1ba9b..df357142461a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -144,6 +144,8 @@ struct vhost_net {
 	unsigned tx_zcopy_err;
 	/* Flush in progress. Protected by tx vq lock. */
 	bool tx_flush;
+	/* Feature negotiation is fixed after a backend has been started. */
+	bool features_locked;
 	/* Private page frag cache */
 	struct page_frag_cache pf_cache;
 };
@@ -318,6 +320,24 @@ static void vhost_net_vq_reset(struct vhost_net *n)
 
 }
 
+/* Caller must hold n->dev.mutex. */
+static bool vhost_net_features_changed(struct vhost_net *n, const u64 *features)
+{
+	const u64 *acked = n->vqs[VHOST_NET_VQ_TX].vq.acked_features_array;
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
+		u64 changed = features[i] ^ acked[i];
+
+		if (i == VIRTIO_DWORD(VHOST_F_LOG_ALL))
+			changed &= ~VIRTIO_BIT(VHOST_F_LOG_ALL);
+		if (changed)
+			return true;
+	}
+
+	return false;
+}
+
 static void vhost_net_tx_packet(struct vhost_net *net)
 {
 	++net->tx_packets;
@@ -1321,6 +1341,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	n = kvmalloc(sizeof *n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!n)
 		return -ENOMEM;
+	n->features_locked = false;
 	vqs = kmalloc_array(VHOST_NET_VQ_MAX, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
 		kvfree(n);
@@ -1597,6 +1618,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		vhost_dev_flush(&n->dev);
 		sockfd_put(oldsock);
 	}
+	if (sock)
+		n->features_locked = true;
 
 	mutex_unlock(&n->dev.mutex);
 	return 0;
@@ -1637,6 +1660,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, umem);
 	vhost_net_vq_reset(n);
+	n->features_locked = false;
 done:
 	mutex_unlock(&n->dev.mutex);
 	if (tx_sock)
@@ -1649,6 +1673,8 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
+	bool access_platform;
+	int r = -EFAULT;
 	int i;
 
 	hdr_len = virtio_features_test_bit(features, VIRTIO_NET_F_MRG_RXBUF) ||
@@ -1672,11 +1698,23 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 		sock_hlen = hdr_len;
 	}
 	mutex_lock(&n->dev.mutex);
+	if (n->features_locked && vhost_net_features_changed(n, features)) {
+		r = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (virtio_features_test_bit(features, VHOST_F_LOG_ALL) &&
 	    !vhost_log_access_ok(&n->dev))
 		goto out_unlock;
 
-	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
+	access_platform =
+		virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM);
+	if (!access_platform && n->dev.iotlb) {
+		r = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (access_platform && !n->dev.iotlb) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
 	}
@@ -1694,7 +1732,7 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 
 out_unlock:
 	mutex_unlock(&n->dev.mutex);
-	return -EFAULT;
+	return r;
 }
 
 static long vhost_net_set_owner(struct vhost_net *n)
-- 
2.34.1

