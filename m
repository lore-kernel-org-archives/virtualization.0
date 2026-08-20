Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7F3C1D7A
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213094; cv=none; b=iBRhobiroUUWcs0EAkWY06wLCV149tOFq8/TGJUbR81i4fwyi1lWGjzJM5UtFb+0fZ2zQZsZZ8j1wiebc4XEJ9p3ntcdqyoVVnBhuGB/aWt5U4/lU1tC6bT+FU9DhPUjRa3+yEoc0g42Ynrjeb4uEOH/iIXQdGCznJCwJG2Zk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213094; c=relaxed/simple;
	bh=409NHPEg8d9hyDA6rbo5mNuY8rOh8AiKvTJnLeNNu+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghnYq8OtWv1xesJg/CiRWZdeEUWUYYqtwjBD69XuOvjG+lAaH+1ycpnzBG7CcLtnHJ49x+nlKSAqIuuJ5OwSAFvSOFcq+OrVeaSroaMDXMPKjl8kZ+XJ65/jJjpO/OUm5TFcCyy3bre8W8fP5YEqLmaiGBmzf66xVXzKJLHFAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlPtbfPp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlPtbfPp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso21146325ad.2
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213092; x=1787817892; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNFgqqtecTA8geY8RdpK/nki92/0qSfCNTMPBz/Sj1Q=;
        b=NlPtbfPpzSSYuVg7P5XPnJAvh4D2Xt+wsW/P1IoSA8+tdaWqJq/6X10/9wHYlnSoVL
         iH2k5c3mbr/oROx3TP6pPYU4IlmtVtC0KT5BzuWZXRImalf/1P+RnSNg35dqIF0HJcEv
         bghur+pKn9XnpJmZ2LjoF6Ozq+8A0xWqKvzoZORWrBgfQbI58QujR0wIQiAMJNBOj5u2
         X9kG3dHvj+pj0E1DkzW6VQpXKM7g2veCI/ozX4uUjYhClb0UMhLbbqqx1aWM63co/sZk
         Vs4eH9dfuedJQlPTx/hQnh8bR/Uh/rhMsmxGdlmM9o7OtgNveTSbZnOWtmaUeww8zah5
         72eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213092; x=1787817892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNFgqqtecTA8geY8RdpK/nki92/0qSfCNTMPBz/Sj1Q=;
        b=haI20n1NLxBjJIzEnIThjqAUUcvftl2aV4L7fK7Q5wtFunRCHtfZlqK39OpCbnkKBn
         F26c6BnUSXtkqRLeuf8hyo4oJ9/lhcfScQMtRqXXNSf8MYnFOoaSvsEudnpyw3WPRx1U
         BLmf3cK+UYHzBFS7UsaqFJ4Jr3V94CvBHTPS8goJwHwp/E33qxA/JYOjYr9OppqRNlPm
         NyNmxozEq1mtuM+yH9mZRpO7uC0KF5JuP2h+wqUk+OT0+rUnT88+LEbr4laTMh48rnfb
         u42ahLBwmADoq18ssRNXsph7R9m4FuzBSlJh0yuVfCKhQAVSWMcfXyLXjE7lCSvTw8Rf
         WXEw==
X-Forwarded-Encrypted: i=1; AHgh+RoiTnTQSDij/hTSUr1C7RdZUp3BEHqaC6v8BlMZifYSiQvFWBcIh5TYVUzjW9ZE/yaJmvbGEzEZRwvfnsbrsg==@lists.linux.dev
X-Gm-Message-State: AFuF++lBO/R9pLI9Tzvl6IKqrcCMZq+G9KvLszkvG5JmCBUcrq1wCMI9
	57nX/mJc2vTZSUvZ/iZP9hOjKiUGCFXKNkA9ksuqItDoc1bhXOb3wnc0
X-Gm-Gg: AR+sD11OzANwh99KBtsrfX05YFzJOLHSM5g53EUTDHdvRbW03tIgK1DiM5I7vrv3EuJ
	x9hv8Hx6vrxq3KXuKcKkuq5rlOkXWNT6SWA0/0uspHVRaZPEYvoVJGM4t4REDvZQNNGS6jkaM3D
	AlCcP5fNzzLGpeSGFYbyTp6CzI6lirgpasXnCkMxoV+U8gNBOTuWjksPDFxvCKKHeCLsuBVVgLT
	wruQf04WpxWj/UdjS0t5UYcXN+iS1LX17ghh1HuPQKIEvyBOBCsC+AAoYdRDClxWlms3GMOTVRp
	O0LzeeHUpRs9LccmpzfFKuWc8a51dh9kbp4ZzP9PbjTQPwrRv3gxtWAEvd5+3RqSQvY9NZS5qjT
	qZqhDJp+OqDUFea9jv9v5bfa4Kn2PWES+dMsxFBkK2JXZLatyJdiJnJn/dXV95BC22s7iKofh0E
	nVMFbcBS9z/W3DTg6jah4dRVTHknS+HN1pgCRyHKtgWVTjTyoC2VsGzO2j55SvRYbV
X-Received: by 2002:a17:902:d58b:b0:2d2:da8e:9017 with SMTP id d9443c01a7336-2d5fd711facmr217368835ad.8.1787213091762;
        Thu, 20 Aug 2026 01:04:51 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3c27aesm3553425ad.69.2026.08.20.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:04:51 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB transitions
Date: Thu, 20 Aug 2026 16:03:30 +0800
Message-Id: <20260820080332.313933-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820080332.313933-1-physicalmtea@gmail.com>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
used change meaning with the address space. Clear the cached vring access
state when the device IOTLB is installed or removed so stale IOVAs cannot
be reused as direct userspace addresses.

Keep device IOTLB initialization idempotent and apply the mode change even
when a virtqueue backend is attached. Drop the device-wide IOTLB first,
then clear each VQ state under its own mutex, and keep the old table alive
until every VQ has completed the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses
for the new address mode before data processing can resume.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 14637cff0bd4..31fff9800045 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
 		vq->meta_iotlb[j] = NULL;
 }
 
+/* Caller must hold the virtqueue mutex. */
+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
+{
+	vq->desc = NULL;
+	vq->avail = NULL;
+	vq->used = NULL;
+	vq->log_used = false;
+	vq->log_addr = -1ull;
+	__vhost_vq_meta_reset(vq);
+}
+
 static void vhost_vq_meta_reset(struct vhost_dev *d)
 {
 	int i;
@@ -1918,6 +1929,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	unsigned int num = vq->num;
 
+	if (!vq->desc || !vq->avail || !vq->used)
+		return 0;
+
 	if (!vq->iotlb)
 		return 1;
 
@@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+/* Caller must hold the device mutex. */
+void vhost_clear_device_iotlb(struct vhost_dev *d)
+{
+	struct vhost_iotlb *iotlb;
+	int i;
+
+	iotlb = d->iotlb;
+	if (!iotlb)
+		return;
+
+	/*
+	 * Drop the device-wide view first.  Each VQ then drops its
+	 * per-VQ view and its cached ring access under its own mutex.
+	 * Keep the old table alive until every VQ has completed this
+	 * handoff, since a worker may still be using it while waiting
+	 * for its VQ mutex.
+	 */
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = NULL;
+		vhost_vq_invalidate_access(vq);
+		mutex_unlock(&vq->mutex);
+	}
+
+	vhost_clear_msg(d);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
+}
+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
 	int i;
 
+	if (d->iotlb)
+		return 0;
+
 	if (max_iotlb_entries <= 0)
 		return -EINVAL;
 
@@ -2307,7 +2358,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
 
 		mutex_lock(&vq->mutex);
 		vq->iotlb = niotlb;
-		__vhost_vq_meta_reset(vq);
+		vhost_vq_invalidate_access(vq);
 		mutex_unlock(&vq->mutex);
 	}
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..3c75e8089373 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
+void vhost_clear_device_iotlb(struct vhost_dev *d);
 int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
-- 
2.34.1

