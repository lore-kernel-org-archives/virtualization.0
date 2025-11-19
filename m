Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEFF322C78
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535324; cv=none; b=lNGnoLJ0KCKGkwH7UZbqzesL7UWNj1UAISS5qzatovAI46v5KT9cNelys2pXaboSLtZXh9NcqTdCyuZRb5ErObMN9q6GORZOWcHX5BlPT8Misv+3JuVtB/9De9jJq0d9pbjb9X/+FnvpN7z7086zMTnDYfzZo9dgUxRnd3ZnHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535324; c=relaxed/simple;
	bh=5iCO5cgXDbfIKEXyC1bd0mdDH+xAR3kAZ5VJbmIKI/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L/uRDxGtKl6IINDw5Fm3SuEMoQKkLWKkR6b5Xeb33hJhK2CxG54mMc93g0/tyEB7g0Wlmk0XXPKwhUCD1HuyJVFB9ogDr1/0BrM4EVYzYaqmXTSkvAMh3iG+u3r89Lm+VqB043HAh/GfmNZ9BW6m4/VTljeBKuts/IqfoZeUAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToesTeNc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToesTeNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763535320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zrc/sZ7wD+ZBOSRNsS/SZIC54PvyBbg7yzBkzkUFz30=;
	b=ToesTeNcXlzocXUDclC2lfxFr8eVasOffc60Ho50XypenegvFJDaniOldOivTPjd1NFkbd
	oeNoPRcgjnEOieGfVOfxQ8Z8ZCrOjiBRa7iKLPkjB7JtEJv6rWOUj6svYv+hN2sO6RQSTW
	p58L8++H2uzcpU7hwjrqUF0aY4vyjX8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-916K-MGIPdO1ZOJp-s3XDw-1; Wed, 19 Nov 2025 01:55:18 -0500
X-MC-Unique: 916K-MGIPdO1ZOJp-s3XDw-1
X-Mimecast-MFC-AGG-ID: 916K-MGIPdO1ZOJp-s3XDw_1763535317
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso4261204f8f.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 22:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535317; x=1764140117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zrc/sZ7wD+ZBOSRNsS/SZIC54PvyBbg7yzBkzkUFz30=;
        b=pkO8+TV14UmTiwSBfjCH5hLIQ/a4k7Qlp/gEpLjYpK9gCQe4+FYV+Su1AdbX3AeFwI
         Ry7R7G8gjWke7PqVnM1gAHF3PxGJ/7jBdOKatnbnSp6N4IZlCh4k3IiJjDtqapH7GFtW
         OjqAOH/2FawG3gG+HloKUKIqXnwUfjdyvEzO9lx7ZXb0xwLI4iZiHwJVIBdvY/xpTlsi
         QKPW0TjjV0GEebs0e/crY2J6BgtwiEsRO+5dLx1EHEmPSmEXDzHIqf8e4DTl8ksuHr/V
         3Xc3d8a7Bry0cJZ9ZSichAxRrGOxmgYVVaGPinvFHuA+Elh/lptlAq10GBQui6n5GqS2
         J/cA==
X-Forwarded-Encrypted: i=1; AJvYcCVH9sZcLTysR4EFXAKFdPLuIMyGCcmgRARB4O6HS4lTEhYfPqfDmJ+LyWhJYwf4JBYYIzkMjw2usXoWtkamFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8DIxr9xBMbzeg3n+dbzIWb96kT4rw0/Ed1/Va7SxmERFZLLCV
	KoSxJBmOvhOSr6MHFqK8ysIp1/NykMFXaX4lMYuXCQNzBD/IHah8wVtswSkWtgJA0Bmxz4eyWOn
	uGdoEXjuZe7BTjH04MuOdz+2dPfZal+dkouDMs6C+P1AJ6MBjQ9fybwsMHW5t0z91xezr
X-Gm-Gg: ASbGncuNYHw/AVfq5S/OyreEoEv3aNM7p1CmUkfpSC6hB8U045bDjdsUByLBntBFePo
	aTTXGR6rjbE4TQFOSUU9hHbgOzJzXvq9+f10CgLrSra8dxLbCc0DFfK3m9wd1tHAtglfQj2Nopm
	kvLUKh6qpJa6AaK4yQ1Zx3r4+hRgIYDxqbpbU5JVuaIYJ7RlgItXvruFh3XarY2tfWw/adl8oyZ
	PdtkUyW3Tj6ZrURAEcGWVWUeJeqpnBieDwwYcacEXn88hQbrn9epn8r/uQD2aheueLeSCfDOPpH
	LAH7/7iJgp7q1X1p9DlqpxIfS+zmU+P8YvqBRWP3c57+Ah0MOdTZJmlo91IGs30oIEtOckpqbEX
	pHEgmPqKTxJMaaX2XqBSHJfc3HoqKkg==
X-Received: by 2002:a05:6000:2f85:b0:429:9323:2bec with SMTP id ffacd0b85a97d-42b593869a5mr18324473f8f.40.1763535316807;
        Tue, 18 Nov 2025 22:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRW82UuLQi25W/cQGXxbC4zhS0AtsqTnIUUKMrow7dNSoBHx8kFNZOLj0xBxxurb7UU0psGg==
X-Received: by 2002:a05:6000:2f85:b0:429:9323:2bec with SMTP id ffacd0b85a97d-42b593869a5mr18324445f8f.40.1763535316367;
        Tue, 18 Nov 2025 22:55:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae88sm35392413f8f.6.2025.11.18.22.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:55:15 -0800 (PST)
Date: Wed, 19 Nov 2025 01:55:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 2/2] vhost: switch to arrays of feature bits
Message-ID: <fbf51913a243558ddfee96d129d37d570fa23946.1763535083.git.mst@redhat.com>
References: <cover.1763535083.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1763535083.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TgYFVnwWLD9oL-hl9M10NGZB-lom9xtLzdh3HAKcxi8_1763535317
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The current interface where caller has to know in which 64 bit chunk
each bit is, is inelegant and fragile.
Let's simply use arrays of bits.
By using unroll macros text size grows only slightly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c   | 29 +++++++++++++++--------------
 drivers/vhost/scsi.c  |  9 ++++++---
 drivers/vhost/test.c  | 10 ++++++++--
 drivers/vhost/vhost.h | 42 ++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vsock.c | 10 ++++++----
 5 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index d057ea55f5ad..cb778f2bf8f8 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,15 +69,15 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >= (__force u32)VHOST_DMA_DONE_LEN)
 
-static const u64 vhost_net_features[VIRTIO_FEATURES_U64S] = {
-	VHOST_FEATURES |
-	(1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
-	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-	(1ULL << VIRTIO_F_RING_RESET) |
-	(1ULL << VIRTIO_F_IN_ORDER),
-	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
-	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
+static const int vhost_net_features[] = {
+	VHOST_FEATURES,
+	VHOST_NET_F_VIRTIO_NET_HDR,
+	VIRTIO_NET_F_MRG_RXBUF,
+	VIRTIO_F_ACCESS_PLATFORM,
+	VIRTIO_F_RING_RESET,
+	VIRTIO_F_IN_ORDER,
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
+	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
 };
 
 enum {
@@ -1720,6 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
 static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			    unsigned long arg)
 {
+	const DEFINE_VHOST_FEATURES_ARRAY(features_array, vhost_net_features);
 	u64 all_features[VIRTIO_FEATURES_U64S];
 	struct vhost_net *n = f->private_data;
 	void __user *argp = (void __user *)arg;
@@ -1734,14 +1735,14 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return vhost_net_set_backend(n, backend.index, backend.fd);
 	case VHOST_GET_FEATURES:
-		features = vhost_net_features[0];
+		features = VHOST_FEATURES_U64(vhost_net_features, 0);
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES:
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
-		if (features & ~vhost_net_features[0])
+		if (features & ~VHOST_FEATURES_U64(vhost_net_features, 0))
 			return -EOPNOTSUPP;
 
 		virtio_features_from_u64(all_features, features);
@@ -1753,8 +1754,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		/* Copy the net features, up to the user-provided buffer size */
 		argp += sizeof(u64);
 		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
-		if (copy_to_user(argp, vhost_net_features,
-				 copied * sizeof(u64)))
+
+		if (copy_to_user(argp, features_array, copied * sizeof(u64)))
 			return -EFAULT;
 
 		/* Zero the trailing space provided by user-space, if any */
@@ -1784,7 +1785,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		}
 
 		for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
-			if (all_features[i] & ~vhost_net_features[i])
+			if (all_features[i] & ~VHOST_FEATURES_U64(vhost_net_features, i))
 				return -EOPNOTSUPP;
 
 		return vhost_net_set_features(n, all_features);
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 98e4f68f4e3c..04fcbe7efd77 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -197,11 +197,14 @@ enum {
 };
 
 /* Note: can't set VIRTIO_F_VERSION_1 yet, since that implies ANY_LAYOUT. */
-enum {
-	VHOST_SCSI_FEATURES = VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_HOTPLUG) |
-					       (1ULL << VIRTIO_SCSI_F_T10_PI)
+static const int vhost_scsi_features[] = {
+	VHOST_FEATURES,
+	VIRTIO_SCSI_F_HOTPLUG,
+	VIRTIO_SCSI_F_T10_PI
 };
 
+#define VHOST_SCSI_FEATURES VHOST_FEATURES_U64(vhost_scsi_features, 0)
+
 #define VHOST_SCSI_MAX_TARGET	256
 #define VHOST_SCSI_MAX_IO_VQ	1024
 #define VHOST_SCSI_MAX_EVENT	128
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 42c955a5b211..af727fccfe40 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -308,6 +308,12 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 	return r;
 }
 
+static const int vhost_test_features[] = {
+	VHOST_FEATURES
+};
+
+#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)
+
 static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
 			     unsigned long arg)
 {
@@ -328,14 +334,14 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return vhost_test_set_backend(n, backend.index, backend.fd);
 	case VHOST_GET_FEATURES:
-		features = VHOST_FEATURES;
+		features = VHOST_TEST_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES:
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
-		if (features & ~VHOST_FEATURES)
+		if (features & ~VHOST_TEST_FEATURES)
 			return -EOPNOTSUPP;
 		return vhost_test_set_features(n, features);
 	case VHOST_RESET_OWNER:
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 621a6d9a8791..c7b92730668e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -14,6 +14,7 @@
 #include <linux/atomic.h>
 #include <linux/vhost_iotlb.h>
 #include <linux/irqbypass.h>
+#include <linux/unroll.h>
 
 struct vhost_work;
 struct vhost_task;
@@ -279,14 +280,39 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 				eventfd_signal((vq)->error_ctx);\
 	} while (0)
 
-enum {
-	VHOST_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
-			 (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
-			 (1ULL << VIRTIO_RING_F_EVENT_IDX) |
-			 (1ULL << VHOST_F_LOG_ALL) |
-			 (1ULL << VIRTIO_F_ANY_LAYOUT) |
-			 (1ULL << VIRTIO_F_VERSION_1)
-};
+#define VHOST_FEATURES \
+	VIRTIO_F_NOTIFY_ON_EMPTY, \
+	VIRTIO_RING_F_INDIRECT_DESC, \
+	VIRTIO_RING_F_EVENT_IDX, \
+	VHOST_F_LOG_ALL, \
+	VIRTIO_F_ANY_LAYOUT, \
+	VIRTIO_F_VERSION_1
+
+static inline u64 vhost_features_u64(const int *features, int size, int idx)
+{
+	u64 res = 0;
+
+	unrolled_count(VIRTIO_FEATURES_BITS)
+	for (int i = 0; i < size; ++i) {
+		int bit = features[i];
+
+		if (virtio_features_chk_bit(bit) && VIRTIO_U64(bit) == idx)
+			res |= VIRTIO_BIT(bit);
+	}
+	return res;
+}
+
+#define VHOST_FEATURES_U64(features, idx) \
+	vhost_features_u64(features, ARRAY_SIZE(features), idx)
+
+#define DEFINE_VHOST_FEATURES_ARRAY_ENTRY(idx, features) \
+	[idx] = VHOST_FEATURES_U64(features, idx),
+
+#define DEFINE_VHOST_FEATURES_ARRAY(array, features) \
+	u64 array[VIRTIO_FEATURES_U64S] = { \
+		UNROLL(VIRTIO_FEATURES_U64S, \
+		       DEFINE_VHOST_FEATURES_ARRAY_ENTRY, features) \
+	}
 
 /**
  * vhost_vq_set_backend - Set backend.
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ae01457ea2cd..16662f2b87c1 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -29,12 +29,14 @@
  */
 #define VHOST_VSOCK_PKT_WEIGHT 256
 
-enum {
-	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
-			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
+static const int vhost_vsock_features[] = {
+	VHOST_FEATURES,
+	VIRTIO_F_ACCESS_PLATFORM,
+	VIRTIO_VSOCK_F_SEQPACKET
 };
 
+#define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_features, 0)
+
 enum {
 	VHOST_VSOCK_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
 };
-- 
MST

