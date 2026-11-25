Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593267;
	b=3L1A/+hxmzunkbSO8PnmyV6pI0It0L4rhP1Zk2ihnYpN6cFBc2efx1kwdtKk3lPTGA2A
	 JvaAmeREe2u2nXkC+3WFFBjK6me1ZslUQIEpd8yW1njp0X4i7e9jDr8C8NINVc7dcs5jA
	 e+OdIIkg2AJ2Iypng6QrZO/wejNKlfUHHhi4PJNoESmuPdluE0pZN+57eC5xfLXxRG5id
	 bTv5mwmHEwLDGdJ5IIHyc/M6RYHDCtmj9uqJeD2ffdL3N/J5ERPqR8gmLMSmRSkhSx6Yb
	 tFYVHee4rLfIwHHNwD1BOBOtO9ZGlFKrrF8gTJRq6s4BcIdF4luv+ATBgYM6/OdrHBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593267;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=Z1Wd0+tIRxlELqrNUF2pEQYgQp20wMSK4suuq0p4MX4=;
	b=VhY9RSqVmq8gTeQJVh0XwO2/P6+RNPGRnGXW5S1C6LAIT/+w9DM0/c7Q7f1UodfQMMst
	 xIla3jZSIDEWDQZhBSHNuJEtzTqVUoDa4zEYqwL6P7wbUjmCyk7KMwoDGzLtJK5OCp3rT
	 jTTNeyx7IWCE3G9JWhGj2EHh2kDT1M2QrFJgtRSWVAc9BEc2U6DNiCa6i5mY26RByCtAK
	 49c9ZMtWIL6i5ky/9WxeXRePdmJyp3Kjx1sZC7P3C5UivuXlyi5y3Zf1/k8d0Uxp2edbt
	 qOPUM9TYt1RyzhmJl7oIO8KsO2+fOoqLkEPhApg1Fj88PPyj9I2LWwQQrTIHaDapY4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKeEc0o4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3139606A327
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 07:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3139606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKeEc0o4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795593265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1Wd0+tIRxlELqrNUF2pEQYgQp20wMSK4suuq0p4MX4=;
	b=RKeEc0o4j9tDEqdXpqNYHuG+k3eD+jDQhE7jboeWRYFl5igGwtiVYxMahU0D8A/xQCAHZx
	UgGzENPV+aeN2cM3bUDcCL6Qh0/bFHLQs9ZPkjbGJQGMXwI0SIxeEflVgkMYkW8V4hK0mq
	jnvdVftT/P3tqkamTOo2Me8QbnZsRhM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-D89MiEf-O_m6eYyRxcg2xw-1; Wed,
 25 Nov 2026 07:54:21 +0000
X-MC-Unique: D89MiEf-O_m6eYyRxcg2xw-1
X-Mimecast-MFC-AGG-ID: D89MiEf-O_m6eYyRxcg2xw_1795593260
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 301B01953988;
	Wed, 25 Nov 2026 07:54:20 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 642101800543;
	Wed, 25 Nov 2026 07:54:17 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alberto Faria <afaria@redhat.com>
Subject: [PATCH v2 2/2] vdpa_sim_blk: add support for FUA writes
Date: Wed, 25 Nov 2026 07:54:08 +0000
Message-ID: <20261125075408.226762-3-afaria@redhat.com>
In-Reply-To: <20261125075408.226762-1-afaria@redhat.com>
References: <20261125075408.226762-1-afaria@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: D9qmEGMz958djqp0AhGRm3xmjqfJbIlc-5N5HMTnpeA_1795593260
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Expose VIRTIO_BLK_F_REQ_FLAGS and VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA to
drivers. The simulator is a ramdisk, so it handles FUA and non-FUA
writes in the same way.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 13 +++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 97d437d89524a..888ea80f6e0af 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -209,6 +209,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 		if (config->device_features &
 		    ~dev_attr->supported_features)
 			return ERR_PTR(-EINVAL);
+		if (dev_attr->validate_features) {
+			ret = dev_attr->validate_features(
+				config->device_features);
+			if (ret)
+				return ERR_PTR(ret);
+		}
 		dev_attr->supported_features =
 			config->device_features;
 	}
@@ -442,11 +448,18 @@ static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
 static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	int ret;
 
 	/* DMA mapping must be done by driver */
 	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
 		return -EINVAL;
 
+	if (vdpasim->dev_attr.validate_features) {
+		ret = vdpasim->dev_attr.validate_features(features);
+		if (ret)
+			return ret;
+	}
+
 	vdpasim->features = features & vdpasim->dev_attr.supported_features;
 
 	return 0;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index bb137e4797633..70890974b6e56 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -45,6 +45,7 @@ struct vdpasim_dev_attr {
 	u32 nas;
 
 	void (*work_fn)(struct vdpasim *vdpasim);
+	int (*validate_features)(u64 features);
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
 	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 4d3e36fb59d50..e0ed9eb729cf3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -32,7 +32,9 @@
 				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
 				 (1ULL << VIRTIO_BLK_F_MQ)       | \
 				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
-				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
+				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES)  | \
+				 (1ULL << VIRTIO_BLK_F_REQ_FLAGS)  | \
+				 (1ULL << VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA))
 
 #define VDPASIM_BLK_CAPACITY	0x40000
 #define VDPASIM_BLK_SIZE_MAX	0x1000
@@ -371,6 +373,15 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
 		vdpasim_schedule_work(vdpasim);
 }
 
+static int vdpasim_blk_validate_features(u64 features)
+{
+	if ((features & BIT_ULL(VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA)) &&
+	    !(features & BIT_ULL(VIRTIO_BLK_F_REQ_FLAGS)))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
 {
 	struct virtio_blk_config *blk_config = config;
@@ -424,6 +435,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.nas = VDPASIM_BLK_AS_NUM;
 	dev_attr.alloc_size = sizeof(struct vdpasim_blk);
 	dev_attr.config_size = sizeof(struct virtio_blk_config);
+	dev_attr.validate_features = vdpasim_blk_validate_features;
 	dev_attr.get_config = vdpasim_blk_get_config;
 	dev_attr.work_fn = vdpasim_blk_work;
 	dev_attr.free = vdpasim_blk_free;
-- 
2.56.1

