Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C6313555
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225641; cv=none; b=XwMVtfaUl3nVVKpzg8NtXwgrMNtElqYncrf3k9tNpkRUYPkyOvFtveiS/ab/waDiVzQSuWSC0nvwTM1BAa9kKBCu+3zls6xD1aU7pMSi5XkjJzr/cD3O2MuZk43cWXZAfvNO0ItkCT64Vkkd4rMQss1WMBvkEilT0k06jJQarf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225641; c=relaxed/simple;
	bh=ivUXO36DJq1dbC9CAEPa5O93ZoCOFhDovxe/PoQeME4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aiCMgUZDM0Wl7uIoQOhK6ilhd70Npv8PnpK9NMYHr9wbu2WuVeHA8WC86kiX+RlOsZirMbOOJowOkIsNecqaqquUNWRSWRgFct3lBRKQfsWP8VtB1rJOoF+JPNHeDBHNs79pso/3rMcLJFhloQinTICD5wIt+gOYZwaGRLr3PK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OARRLmYG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OARRLmYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764225638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixkqHa7UY4id+SD0ZRwvgJtg9ZQCnNOZWuNc83xEvBE=;
	b=OARRLmYGM7zaZCqhiKQ2a7PePqMQJJJ2JtJClZeCD1zarGcJa91aijMr63sTJsOVD9ksDW
	9wYahTaXADYG9xGKpnKLZpNnQOES2G3eHDNCJhGxpz9XfvetQpZQkkjwrWf250+krwOHbh
	zbi2eXPNTNrAbhrwOJSpofvLL4nP04k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-sTEGePI8NMGeeDSEFJqZfw-1; Thu, 27 Nov 2025 01:40:34 -0500
X-MC-Unique: sTEGePI8NMGeeDSEFJqZfw-1
X-Mimecast-MFC-AGG-ID: sTEGePI8NMGeeDSEFJqZfw_1764225634
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cce847c4so274990f8f.2
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 22:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764225634; x=1764830434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixkqHa7UY4id+SD0ZRwvgJtg9ZQCnNOZWuNc83xEvBE=;
        b=pyuo9uDbsoEVaPfT8TtwBoRHM/M950FO/PmzBX3VLjGymxJPssJ+R/BYykVBQmH+pb
         ZxAjAll9ZH3eY7SH7jKiWKY6/gziOETnG5DX2fRnG2R+gNppH87N3xvI2uY1T9CGANgB
         t0r7KE6jFQwI2bbnIutwMGM2xdSaJ3GyrWEqtr3FZFRt7XmO/CIE3rDnkg3HAwiP6N+O
         hf2ybNYcF1YmXu/kk69G9ZZL60PPVemktubiiVrAN6c6FOFRTWMn7cfuavmP/w+tjK7g
         FS7Bv7VxK1t6qdhDntEZD92nDGoD5BF/AClZsaMZR/yMsurkrrRWMF1qd6fh+cvoIAXp
         a5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGYTCYJE5Hj9DqVzlgWS9/EJZHxBOlf0Lx5HIl1AEvXDPl2HVkko65qtXBHXGlEunlI3QhXxRGtQVXR86xlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt23Zqv88QRrJSzNdFA0upz7JF8LQFZd9aLv2sR1lUNXD/n/AX
	uFkuPqt5AjaitBjXu0H5Ncju2jHO9BGXZkidAThK+TWKIdDIYeVTZghknzC9mKlRhqb98SH/nfz
	04igsrKXEroLu8fsjrKZ6fQQdqY8LjnFW2CFDzphkkzIxIHjLI0TvXWeUNoZnuQ618sIi
X-Gm-Gg: ASbGncuqNB47sa3QPrbrDg1Pe3jYMr+GgkizFL+deYtoDv7blpPqjMNgaFoiAEXtib5
	4t+tJL1rr7eFABsfqtIJwqX66nvNEbT/eNjSB5B2mTxKZDLc8/ytBXNkufpn2I3ECLW1EpwrybJ
	cIG0FcxMQxtnsAHtK+s38Bp7WYe2GbYM7st/mQ+No/OnxEoQIvICTUkU4uOa/RUb4OaDQn/9y6w
	EvnG24hoihhpGfs/Y/GK2k5s8oqVZlzBmhMKar1HvWuprw6dDZoirVL93wVcNJqPfdc7h7uUiNX
	ESZvBOzwAZQeMvlsd+aMk+XDAv2jxT0dJBZXPJDLQ4UJw7TMe0MV9F27mv5UZCB2XMY1nfoyCn8
	NT/eAerKRrVYfOc+ASqJcmMtuyfjrCA==
X-Received: by 2002:a05:6000:2584:b0:42b:2a09:2e59 with SMTP id ffacd0b85a97d-42cc19f0942mr23867961f8f.0.1764225633550;
        Wed, 26 Nov 2025 22:40:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeII0KjZfqE/x5p5aVz7nAKQexoeFKp+f876+mbJSMjnNag/kZbcGgIiTKL8OMS1SQs7DKWw==
X-Received: by 2002:a05:6000:2584:b0:42b:2a09:2e59 with SMTP id ffacd0b85a97d-42cc19f0942mr23867919f8f.0.1764225632944;
        Wed, 26 Nov 2025 22:40:32 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d613esm1742574f8f.11.2025.11.26.22.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 22:40:32 -0800 (PST)
Date: Thu, 27 Nov 2025 01:40:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v6 1/3] virtio: clean up features qword/dword terms
Message-ID: <ad53b7b6be87fc524f45abaeca0bb05fb3633397.1764225384.git.mst@redhat.com>
References: <cover.1764225384.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764225384.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XUYShV1pqBOEqpXttqF_TLKhM_bgOt2te44Jva3QFWY_1764225634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio pci uses word to mean "16 bits". mmio uses it to mean
"32 bits".

To avoid confusion, let's avoid the term in core virtio
altogether. Just say U64 to mean "64 bit".

Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
Cc: Paolo Abeni <pabeni@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c                    | 12 +++++------
 drivers/virtio/virtio.c                | 12 +++++------
 drivers/virtio/virtio_debug.c          | 10 ++++-----
 drivers/virtio/virtio_pci_modern_dev.c |  6 +++---
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 29 +++++++++++++-------------
 include/linux/virtio_pci_modern.h      |  8 +++----
 8 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 35ded4330431..d057ea55f5ad 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,7 +69,7 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >= (__force u32)VHOST_DMA_DONE_LEN)
 
-static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
+static const u64 vhost_net_features[VIRTIO_FEATURES_U64S] = {
 	VHOST_FEATURES |
 	(1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
@@ -1720,7 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
 static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			    unsigned long arg)
 {
-	u64 all_features[VIRTIO_FEATURES_DWORDS];
+	u64 all_features[VIRTIO_FEATURES_U64S];
 	struct vhost_net *n = f->private_data;
 	void __user *argp = (void __user *)arg;
 	u64 __user *featurep = argp;
@@ -1752,7 +1752,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 		/* Copy the net features, up to the user-provided buffer size */
 		argp += sizeof(u64);
-		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
 		if (copy_to_user(argp, vhost_net_features,
 				 copied * sizeof(u64)))
 			return -EFAULT;
@@ -1767,13 +1767,13 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 		virtio_features_zero(all_features);
 		argp += sizeof(u64);
-		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
 		if (copy_from_user(all_features, argp, copied * sizeof(u64)))
 			return -EFAULT;
 
 		/*
 		 * Any feature specified by user-space above
-		 * VIRTIO_FEATURES_MAX is not supported by definition.
+		 * VIRTIO_FEATURES_BITS is not supported by definition.
 		 */
 		for (i = copied; i < count; ++i) {
 			if (copy_from_user(&features, featurep + 1 + i,
@@ -1783,7 +1783,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 				return -EOPNOTSUPP;
 		}
 
-		for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+		for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
 			if (all_features[i] & ~vhost_net_features[i])
 				return -EOPNOTSUPP;
 
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a09eb4d62f82..5bdc6b82b30b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -53,7 +53,7 @@ static ssize_t features_show(struct device *_d,
 
 	/* We actually represent this as a bitstring, as it could be
 	 * arbitrary length in future. */
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++)
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++)
 		len += sysfs_emit_at(buf, len, "%c",
 			       __virtio_test_bit(dev, i) ? '1' : '0');
 	len += sysfs_emit_at(buf, len, "\n");
@@ -272,8 +272,8 @@ static int virtio_dev_probe(struct device *_d)
 	int err, i;
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
-	u64 device_features[VIRTIO_FEATURES_DWORDS];
-	u64 driver_features[VIRTIO_FEATURES_DWORDS];
+	u64 device_features[VIRTIO_FEATURES_U64S];
+	u64 driver_features[VIRTIO_FEATURES_U64S];
 	u64 driver_features_legacy;
 
 	/* We have a driver! */
@@ -286,7 +286,7 @@ static int virtio_dev_probe(struct device *_d)
 	virtio_features_zero(driver_features);
 	for (i = 0; i < drv->feature_table_size; i++) {
 		unsigned int f = drv->feature_table[i];
-		if (!WARN_ON_ONCE(f >= VIRTIO_FEATURES_MAX))
+		if (!WARN_ON_ONCE(f >= VIRTIO_FEATURES_BITS))
 			virtio_features_set_bit(driver_features, f);
 	}
 
@@ -303,7 +303,7 @@ static int virtio_dev_probe(struct device *_d)
 	}
 
 	if (virtio_features_test_bit(device_features, VIRTIO_F_VERSION_1)) {
-		for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+		for (i = 0; i < VIRTIO_FEATURES_U64S; ++i)
 			dev->features_array[i] = driver_features[i] &
 						 device_features[i];
 	} else {
@@ -325,7 +325,7 @@ static int virtio_dev_probe(struct device *_d)
 		goto err;
 
 	if (drv->validate) {
-		u64 features[VIRTIO_FEATURES_DWORDS];
+		u64 features[VIRTIO_FEATURES_U64S];
 
 		virtio_features_copy(features, dev->features_array);
 		err = drv->validate(dev);
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
index d58713ddf2e5..ccf1955a1183 100644
--- a/drivers/virtio/virtio_debug.c
+++ b/drivers/virtio/virtio_debug.c
@@ -8,12 +8,12 @@ static struct dentry *virtio_debugfs_dir;
 
 static int virtio_debug_device_features_show(struct seq_file *s, void *data)
 {
-	u64 device_features[VIRTIO_FEATURES_DWORDS];
+	u64 device_features[VIRTIO_FEATURES_U64S];
 	struct virtio_device *dev = s->private;
 	unsigned int i;
 
 	virtio_get_features(dev, device_features);
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++) {
 		if (virtio_features_test_bit(device_features, i))
 			seq_printf(s, "%u\n", i);
 	}
@@ -26,7 +26,7 @@ static int virtio_debug_filter_features_show(struct seq_file *s, void *data)
 	struct virtio_device *dev = s->private;
 	unsigned int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++) {
 		if (virtio_features_test_bit(dev->debugfs_filter_features, i))
 			seq_printf(s, "%u\n", i);
 	}
@@ -50,7 +50,7 @@ static int virtio_debug_filter_feature_add(void *data, u64 val)
 {
 	struct virtio_device *dev = data;
 
-	if (val >= VIRTIO_FEATURES_MAX)
+	if (val >= VIRTIO_FEATURES_BITS)
 		return -EINVAL;
 
 	virtio_features_set_bit(dev->debugfs_filter_features, val);
@@ -64,7 +64,7 @@ static int virtio_debug_filter_feature_del(void *data, u64 val)
 {
 	struct virtio_device *dev = data;
 
-	if (val >= VIRTIO_FEATURES_MAX)
+	if (val >= VIRTIO_FEATURES_BITS)
 		return -EINVAL;
 
 	virtio_features_clear_bit(dev->debugfs_filter_features, val);
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 9e503b7a58d8..413a8c353463 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -401,7 +401,7 @@ void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->device_feature_select);
@@ -427,7 +427,7 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
@@ -448,7 +448,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u32 cur = features[i >> 1] >> (32 * (i & 1));
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96c66126c074..132a474e5914 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -177,7 +177,7 @@ struct virtio_device {
 	union virtio_map vmap;
 #ifdef CONFIG_VIRTIO_DEBUG
 	struct dentry *debugfs_dir;
-	u64 debugfs_filter_features[VIRTIO_FEATURES_DWORDS];
+	u64 debugfs_filter_features[VIRTIO_FEATURES_U64S];
 #endif
 };
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index a1af2676bbe6..69f84ea85d71 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -80,7 +80,7 @@ struct virtqueue_info {
  *	Returns the first 64 feature bits.
  * @get_extended_features:
  *      vdev: the virtio_device
- *      Returns the first VIRTIO_FEATURES_MAX feature bits (all we currently
+ *      Returns the first VIRTIO_FEATURES_BITS feature bits (all we currently
  *      need).
  * @finalize_features: confirm what device features we'll be using.
  *	vdev: the virtio_device
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index f748f2f87de8..ea2ad8717882 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -4,15 +4,16 @@
 
 #include <linux/bits.h>
 
-#define VIRTIO_FEATURES_DWORDS	2
-#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_DWORDS * 64)
-#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_DWORDS * 2)
+#define VIRTIO_FEATURES_U64S	2
+#define VIRTIO_FEATURES_BITS	(VIRTIO_FEATURES_U64S * 64)
+
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
-#define VIRTIO_DWORD(b)		((b) >> 6)
+#define VIRTIO_U64(b)		((b) >> 6)
+
 #define VIRTIO_DECLARE_FEATURES(name)			\
 	union {						\
 		u64 name;				\
-		u64 name##_array[VIRTIO_FEATURES_DWORDS];\
+		u64 name##_array[VIRTIO_FEATURES_U64S];\
 	}
 
 static inline bool virtio_features_chk_bit(unsigned int bit)
@@ -22,9 +23,9 @@ static inline bool virtio_features_chk_bit(unsigned int bit)
 		 * Don't care returning the correct value: the build
 		 * will fail before any bad features access
 		 */
-		BUILD_BUG_ON(bit >= VIRTIO_FEATURES_MAX);
+		BUILD_BUG_ON(bit >= VIRTIO_FEATURES_BITS);
 	} else {
-		if (WARN_ON_ONCE(bit >= VIRTIO_FEATURES_MAX))
+		if (WARN_ON_ONCE(bit >= VIRTIO_FEATURES_BITS))
 			return false;
 	}
 	return true;
@@ -34,26 +35,26 @@ static inline bool virtio_features_test_bit(const u64 *features,
 					    unsigned int bit)
 {
 	return virtio_features_chk_bit(bit) &&
-	       !!(features[VIRTIO_DWORD(bit)] & VIRTIO_BIT(bit));
+	       !!(features[VIRTIO_U64(bit)] & VIRTIO_BIT(bit));
 }
 
 static inline void virtio_features_set_bit(u64 *features,
 					   unsigned int bit)
 {
 	if (virtio_features_chk_bit(bit))
-		features[VIRTIO_DWORD(bit)] |= VIRTIO_BIT(bit);
+		features[VIRTIO_U64(bit)] |= VIRTIO_BIT(bit);
 }
 
 static inline void virtio_features_clear_bit(u64 *features,
 					     unsigned int bit)
 {
 	if (virtio_features_chk_bit(bit))
-		features[VIRTIO_DWORD(bit)] &= ~VIRTIO_BIT(bit);
+		features[VIRTIO_U64(bit)] &= ~VIRTIO_BIT(bit);
 }
 
 static inline void virtio_features_zero(u64 *features)
 {
-	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
+	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_U64S);
 }
 
 static inline void virtio_features_from_u64(u64 *features, u64 from)
@@ -66,7 +67,7 @@ static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
 {
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+	for (i = 0; i < VIRTIO_FEATURES_U64S; ++i)
 		if (f1[i] != f2[i])
 			return false;
 	return true;
@@ -74,14 +75,14 @@ static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
 
 static inline void virtio_features_copy(u64 *to, const u64 *from)
 {
-	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
+	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_U64S);
 }
 
 static inline void virtio_features_andnot(u64 *to, const u64 *f1, const u64 *f2)
 {
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+	for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
 		to[i] = f1[i] & ~f2[i];
 }
 
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 48bc12d1045b..9a3f2fc53bd6 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -107,7 +107,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 static inline u64
 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 
 	vp_modern_get_extended_features(mdev, features_array);
 	return features_array[0];
@@ -116,11 +116,11 @@ vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 static inline u64
 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 	int i;
 
 	vp_modern_get_driver_extended_features(mdev, features_array);
-	for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i)
+	for (i = 1; i < VIRTIO_FEATURES_U64S; ++i)
 		WARN_ON_ONCE(features_array[i]);
 	return features_array[0];
 }
@@ -128,7 +128,7 @@ vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 static inline void
 vp_modern_set_features(struct virtio_pci_modern_device *mdev, u64 features)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 
 	virtio_features_from_u64(features_array, features);
 	vp_modern_set_extended_features(mdev, features_array);
-- 
MST

