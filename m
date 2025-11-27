Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098A3191B5
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225646; cv=none; b=FosWugLdpBibZKs2OszMD0RH5j7CJlcsh37l6d8GbBvWghrhzKF+PQf2CmEov0srRC6dZ+bSMjtECHhaEPa5QuELgNlZ5vhQxVttoij3xS/xE/WoSX7a4kYfC3EzU3FUVTXK08pwh7PcNXGJvloQy2zJbWkcq+3j0zIElnwVjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225646; c=relaxed/simple;
	bh=6sJDh7TR0maQBdks2dSRada8nx8D+7jUwjltz8Ik4ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DeOEXS4lJy0NtZbJXRlCV4pA+ZOZPgpZgUINvU98NOXJeTB8EJOFmisR8XbNSDSNlxJYzBdxaKbZ2FQ19XTJDFz3g3hnrT/5xn46xlooBTK/ZnKJya1YQ3mo2wLoNhynRj3m5N4x91HDS1HEGBHrRk/r3MMzOGZE0qdOa1ci+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkQzqcoH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkQzqcoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764225644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+AVszRknLoY/jDDQOQpI/1Oya1cYB7+TjwgCKh4fLI=;
	b=QkQzqcoHOAi6WiYp8elVvk6RUVqiYWsVI+LTrVAVVzLOL9S67Y4G7qteIEN90eDYZ3hfmR
	uHVRHFRuUS3TxRBNJUiWhHUpQNZ7i3hGIHgqTRd+Z61u5xG706POX6NoT/uJ5wz3ujV/ks
	vZh/aTe+p9A1ayZPtP2QyjRzEyk8Iwo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-ABnoXrquOwqtdmW1xlzkpQ-1; Thu, 27 Nov 2025 01:40:40 -0500
X-MC-Unique: ABnoXrquOwqtdmW1xlzkpQ-1
X-Mimecast-MFC-AGG-ID: ABnoXrquOwqtdmW1xlzkpQ_1764225639
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d110fabso3588595e9.1
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 22:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764225639; x=1764830439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+AVszRknLoY/jDDQOQpI/1Oya1cYB7+TjwgCKh4fLI=;
        b=Dpcfzx2eNNM1H14p5nc8q9izybIqcgFGt/0rJT44tzJvSRG+D7m8ASvqiEz1YXejyy
         QLHPImV6zoGMbYmwH4NMgZ90NuVEKImjq5zHsF19m61hjlKT4uEsqhPukecSN7ZzN/sw
         koLr55Nnz7b/VYE6HLTH3QrfaUPJGWzg0gXH0XcC6dvZm7bkaZGi3AS6FRMMHVpNas4y
         NkzE7tHtKmrDa72D1+B6s2cGhwoOq2gz34TZZ+jatJ11o/yv3Uvh8d8iMGsYt2SZXTdP
         EC93Bxt93gTc6kLRpCTwm7j3sy/EUjfBxZSRB6W/wOCOE70x5jFkNTGBIQ71hlrl4EiA
         fqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzwttQEObm6qceWI0NVXqbn+jYXRAQA3/e2IK7sQVL3n39nfF6TFdUdToXBPJOrDHzvV+E6ZMxL/8kBAKlGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIiH3SJleaEcGsU3E7oONtrNLF3yBK1Lw8HDs56AHtUqcbdLpV
	jx/o1eFhceaL8Xgicmpsdv8h/SYgb7j6M/DujpRi9UzCryz7V+OPHiBrIJ1Hi2x1IBPFHnlzGAH
	6VlQ0nbLdObHybzrjhax1hUcG3qQXVrgBRB0gmjeTtNzqzoPj2zdmpIFL7diGKQcpjHui
X-Gm-Gg: ASbGncuFTAEBwBmgKOtVsOS8u1GL9ExW6wN1CX5ZW9BiXuBSpQ8DUZ6X1ZT1Mih4OF5
	xkl5eCPmDemSNd5+avshq1teHa263qw+H7urwfYk6uaOq60IbqiNhun1114lGjEBinAm5Q4msjS
	wwDml5k6hJ1xIBOzhzCpPfGs/X47l8a7JbwchzjKFg7JkBOX7juTXyIDUBjlxy8+X7a1GA6H0lk
	k30mY/ypohxAfhWUm0C1S83UWlKo0VuMMDEmngpmdYgx2B7llVfQ2Bk/s3r5nLzHX0gPe69ncWz
	/nBgEX/UDShMCcOLZlrtejuMG0QTLZ67ZxW4QhY6QyKYJGx4EScEB8vv67g0ScO+W8W+o+V7sVR
	uHL6OT5aegpy5gmIiffbtL2/XiNrECw==
X-Received: by 2002:a05:600c:4f48:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47904b2494cmr86357025e9.26.1764225639368;
        Wed, 26 Nov 2025 22:40:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIc2HWl1bEZAW98bVde7+vw9sLlCeonr8va9/QQZdNQY3M7yfM4XWOaGQlBJyuh5tTNCFGXw==
X-Received: by 2002:a05:600c:4f48:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47904b2494cmr86356645e9.26.1764225638741;
        Wed, 26 Nov 2025 22:40:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c44dcsm78644225e9.11.2025.11.26.22.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 22:40:38 -0800 (PST)
Date: Thu, 27 Nov 2025 01:40:35 -0500
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
Subject: [PATCH v6 3/3] vhost: switch to arrays of feature bits
Message-ID: <637e182e139980e5930d50b928ba5ac072d628a9.1764225384.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: yG2Eof8zDnDzWhqkoTj48H57VUNNNBrs0fDh332qDVQ_1764225639
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The current interface where caller has to know in which 64 bit chunk
each bit is, is inelegant and fragile.
Let's simply use arrays of bits.
By using unroll macros text size grows only slightly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c   | 19 ++++++++++---------
 drivers/vhost/scsi.c  |  9 ++++++---
 drivers/vhost/test.c  |  6 +++++-
 drivers/vhost/vhost.h | 42 ++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vsock.c | 10 ++++++----
 5 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index d057ea55f5ad..f8ed39337f56 100644
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
+static const int vhost_net_bits[] = {
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
+	const DEFINE_VHOST_FEATURES_ARRAY(vhost_net_features, vhost_net_bits);
 	u64 all_features[VIRTIO_FEATURES_U64S];
 	struct vhost_net *n = f->private_data;
 	void __user *argp = (void __user *)arg;
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 98e4f68f4e3c..f43c1fe9fad9 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -197,11 +197,14 @@ enum {
 };
 
 /* Note: can't set VIRTIO_F_VERSION_1 yet, since that implies ANY_LAYOUT. */
-enum {
-	VHOST_SCSI_FEATURES = VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_HOTPLUG) |
-					       (1ULL << VIRTIO_SCSI_F_T10_PI)
+static const int vhost_scsi_bits[] = {
+	VHOST_FEATURES,
+	VIRTIO_SCSI_F_HOTPLUG,
+	VIRTIO_SCSI_F_T10_PI
 };
 
+#define VHOST_SCSI_FEATURES VHOST_FEATURES_U64(vhost_scsi_bits, 0)
+
 #define VHOST_SCSI_MAX_TARGET	256
 #define VHOST_SCSI_MAX_IO_VQ	1024
 #define VHOST_SCSI_MAX_EVENT	128
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 94cd09f36f59..f592b2f548e8 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -28,7 +28,11 @@
  */
 #define VHOST_TEST_PKT_WEIGHT 256
 
-#define VHOST_TEST_FEATURES VHOST_FEATURES
+static const int vhost_test_bits[] = {
+	VHOST_FEATURES
+};
+
+#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)
 
 enum {
 	VHOST_TEST_VQ = 0,
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
index ae01457ea2cd..0298ddc34824 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -29,12 +29,14 @@
  */
 #define VHOST_VSOCK_PKT_WEIGHT 256
 
-enum {
-	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
-			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
+static const int vhost_vsock_bits[] = {
+	VHOST_FEATURES,
+	VIRTIO_F_ACCESS_PLATFORM,
+	VIRTIO_VSOCK_F_SEQPACKET
 };
 
+#define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_bits, 0)
+
 enum {
 	VHOST_VSOCK_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
 };
-- 
MST

