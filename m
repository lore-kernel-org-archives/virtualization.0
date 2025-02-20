Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE412641F8
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091270; cv=none; b=hpXBfDyiw23FIDwH81igMqwV+w9xw3sasmOLGotBWz+/lqxXfHSNcX56HHK/KK+O8Ia4/yIlM2+dCr80EXZLqXuq9JYvFtcUaepBQGJSNawoB4SoQgvLeouQLoYFfcmwqAxwEExh7RbJUusWVrHv2VFbkZW7tfUml73o6qutlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091270; c=relaxed/simple;
	bh=mRGswsKourNVCaSODc/n1NTXWr1ln5mIzOK1iDX0YHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdyjscmZNR3H4/kIqRXf+T9yLEJeirIQYttV+FiQYZz8nQg5En12Pbuyt4MaKEJ9IKXCeTbJ8s5v6Tg5Ky3eDB6DJiCA/m6zwz9A2RqBtD+RQ5fbxlgV4CMFrD2M7RqURftThibDs2s/prPBK8EFc+Xevqi5GSuAjUB4g9fO0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJjDq89J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJjDq89J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740091268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KVhFVLcrq0MwE18FSmJzB1oSZy7QOKz+o8BK19VMfs=;
	b=CJjDq89JuLuL06EJoF5TQ1ZMgKXm8u1jovI5w7gIzFCj9tkKmYHK696DgJVG2Rkrv4x3b8
	exlOLh2TCA+XSajGHvyyTXKPr6PHPwWJ0zBqiNnz7duKca1Qcx3MmhyRh/YKww4rYTVhge
	p1jVtIc/ip0A+QTkOE9Xa0iXx2VCBjc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-NQYkDMMMMc6lP83Dh1jTYA-1; Thu,
 20 Feb 2025 17:41:04 -0500
X-MC-Unique: NQYkDMMMMc6lP83Dh1jTYA-1
X-Mimecast-MFC-AGG-ID: NQYkDMMMMc6lP83Dh1jTYA_1740091263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B520819373DC;
	Thu, 20 Feb 2025 22:41:02 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.44.32.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E96B1800D96;
	Thu, 20 Feb 2025 22:40:56 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 20 Feb 2025 23:40:30 +0100
Subject: [PATCH RFC v4 1/4] virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-virtio-shm-page-size-v4-1-ddaed7b6f734@redhat.com>
References: <20250220-virtio-shm-page-size-v4-0-ddaed7b6f734@redhat.com>
In-Reply-To: <20250220-virtio-shm-page-size-v4-0-ddaed7b6f734@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Sergio Lopez <slp@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2407; i=slp@redhat.com;
 h=from:subject:message-id; bh=mRGswsKourNVCaSODc/n1NTXWr1ln5mIzOK1iDX0YHA=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBnt69rNaApFMtsFfuvcVdoXvsq5VoZddtLVwtzB
 iLIBEoYegWJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ7evawAKCRD0aSeNLwwC
 NSU3D/0epEm/Iz+J0xyvWT0cojPJldJU0xWq/zjXQ0FXd01iypGAieK+heQnMejXs0hA3bpDWdt
 /F0MEpKeNBEi8DCwWRgSn9Hu/2iQZ/WvXIwpYUAs+6xN9kfb8HlY6FeZLK8JIarb+PrTCWXodLK
 cXIA7tZSgPtou56F+sj6yMkBNdhsh8JIur8cwjYYkDxaG4jliDcFfsXDbyWi9ml70pPbUuiRIrC
 Bc7CVWJqOhy0ZL6yZ+Hk/Pi2zaD/bfHFoMTwt/HmAMDbYx7bILy698QWk9QLjEr//YbGHssJbEe
 bYTVg8czPAGjFO/FlAJ0ca8fz6t7b8do61XFD005nkHa3WC68yfTQ2Y6wQuGFWe35fuf1YG4chx
 mm4TehBJVbL1IICa0kEuqnxgDaGRP2elT8gUNuO8lZhVifluXLxBG1GtrlNgHECjyrjXniUAk7V
 JHfcTqQq7hjWXHLKZPqqsLKW64weEBuU0KQmayMTvr+r4UqrN84cjarVfKD8THuEnNEDX1vBfA4
 m3zxBExmBt+LedcPbdlAt3gJ4srNC1qUVwBfpaJ88EvIKcUt13Go2zcJPZG1fA79sM/O12SZv1m
 54X+SoIRwcM91Jgl2szarSI3XoYRrgsTtGg+rGmm8UpGchMbZn7GiGrE5Bc2SRffJ4ZYXPF8gZI
 /EZWitdXX7+b3Pg==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Introduce VIRTIO_F_SHM_PAGE_SIZE, a feature bit which indicates that the
transport provides the page size for SHM regions.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 3 +++
 drivers/virtio/virtio_ring.c       | 2 ++
 include/uapi/linux/virtio_config.h | 7 ++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5eaade7578606e4b02af0d66447417ad6aa11064..104ba08f82d4a6268240bbad15385dd44b3a71d6 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -367,6 +367,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 
 	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
 		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
+
+	if (features & BIT_ULL(VIRTIO_F_SHM_PAGE_SIZE))
+		__virtio_set_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE);
 }
 
 static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fdd2d2b07b5a2aca864bc917306536685afb66a6..d853d5cf7e553be8bbe0ff461dc7312b258c6e58 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2983,6 +2983,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_NOTIFICATION_DATA:
 			break;
+		case VIRTIO_F_SHM_PAGE_SIZE:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2445f365bce74b4e926c6929322b269252ab6830..3171e3792263c2cd472ac09da18e593ab400751d 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		42
+#define VIRTIO_TRANSPORT_F_END		43
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -120,4 +120,9 @@
  */
 #define VIRTIO_F_ADMIN_VQ		41
 
+/*
+ * This feature indicates that the transport provides the SHM page size.
+ */
+#define VIRTIO_F_SHM_PAGE_SIZE		42
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */

-- 
2.48.1

