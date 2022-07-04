Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2E2C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 17:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C6E681987;
	Mon,  4 Jul 2022 17:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C6E681987
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K/BBnQlY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JMOS4Mh-eYhK; Mon,  4 Jul 2022 17:17:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 58479818CA;
	Mon,  4 Jul 2022 17:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58479818CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3121CC0032;
	Mon,  4 Jul 2022 17:17:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 654FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3271160B9A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3271160B9A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K/BBnQlY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ThZ8bl17OEfJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3861460BDF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3861460BDF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656955063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiY/8owB8tnVxNDq00B9edDJ5cOHJxj+7Raw9snQ9Fg=;
 b=K/BBnQlYqp8GkAxiLMvlSJFotxc1bjUH/xOV2wqT94eqNzk2T94RZPoKGFq30nlfzOJxLw
 SFGrv1TiC1uUm457csQii1xfzpcMRiuveL/dKxHHPjoWZ9vmaNn/zpMLwQizvHGjbMCyAW
 InLj+WsgNBJepvQRBhpuAQVvifpA2nU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-l1SHaApRP8iKmit5m4KR-A-1; Mon, 04 Jul 2022 13:17:42 -0400
X-MC-Unique: l1SHaApRP8iKmit5m4KR-A-1
Received: by mail-qk1-f198.google.com with SMTP id
 o13-20020a05620a2a0d00b006b46c5414b0so2006142qkp.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 10:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YiY/8owB8tnVxNDq00B9edDJ5cOHJxj+7Raw9snQ9Fg=;
 b=g8GLLaIwg8TBcnUd7TDRZeVIXi/zVHHXTY2sseDoDPOZRycLW5rXEd9a3/AE4bJrm9
 kBOVSIbiFcmyEsT/HuOpl+u3Yb4JrmdZtoY2HdCfQHPCVd6ZMDMMExvRTXXmMMFEgY9+
 W30qiF8JEdcl+lbn7S0W+TibL9BXf9ZWpbe4XrOB5NYbK4ZdG5k/tm4rhua6YtAF1awu
 AymNqBCnL6VNUGax1zZzjkYMGtjeBPoF3x4zGlA/TfGoDRToviy/BDaLCp9kZ8XzbghS
 EOkj6MbRi8Qaklqs2WVhY77vf6yc9BfM9p8lsRWKR3Hslf2eNf/LNpo8r6VVPlG+C1kk
 wdCg==
X-Gm-Message-State: AJIora/UyvuQQ1dvQpNlY8j75oz56xX040hgwyg7fFreaSaQB0eO/LAI
 lyEpreoy3FWmKf2/FnJ4fG3/bidFdh+NWVuGuFQkgBzEmCVw3gQiA4p8jWlwaPV/Yy6/epxmyQi
 mcsS6GvKRgkGaVmDP4XsLnCvKzCTS6No1Df1p7usRpWOyKstrwM2+Ij5lpoTuPM4njkixTwGTMS
 l0Y4asj0QN79ySsCcNSw==
X-Received: by 2002:a05:620a:4048:b0:6af:ce0:cda8 with SMTP id
 i8-20020a05620a404800b006af0ce0cda8mr20623419qko.698.1656955061049; 
 Mon, 04 Jul 2022 10:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tWJ/kP40tu6aNymBNyHUdElVqOxdIB+Q8MDadYWSEvofTZlOr7etlNSmUr6/ZU13avClULAw==
X-Received: by 2002:a05:620a:4048:b0:6af:ce0:cda8 with SMTP id
 i8-20020a05620a404800b006af0ce0cda8mr20623398qko.698.1656955060705; 
 Mon, 04 Jul 2022 10:17:40 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 y7-20020a37f607000000b006a75e8d920bsm10788838qkj.88.2022.07.04.10.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 10:17:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 5/6] virtio_test: support vhost-vdpa device
Date: Mon,  4 Jul 2022 19:17:00 +0200
Message-Id: <20220704171701.127665-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
References: <20220704171701.127665-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The new --vdpa parameter can be used to run virtio_test with
the new vdpa_sim_test.ko that implements the device.

The main differences with vhost_test are:
- control of status register
- dma map messages
- VHOST_SET_MEM_TABLE not supported by vhost-vdpa
- VHOST_TEST_RUN not supported by vhost-vdpa

The --reset option is not supported for now when using vhost-vdpa.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/virtio_test.c | 127 +++++++++++++++++++++++++++++++------
 1 file changed, 109 insertions(+), 18 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 2d8a3e881637..91f983266d86 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -44,6 +44,8 @@ struct vdev_info {
 	void *buf;
 	size_t buf_size;
 	struct vhost_memory *mem;
+	bool vdpa;
+	uint64_t backend_features;
 };
 
 static const struct vhost_vring_file no_backend = { .fd = -1 },
@@ -64,6 +66,36 @@ void vq_callback(struct virtqueue *vq)
 {
 }
 
+static void vdpa_add_status(struct vdev_info *dev, uint8_t status)
+{
+	uint8_t current_status;
+	int r;
+
+	r = ioctl(dev->control, VHOST_VDPA_GET_STATUS, &current_status);
+	assert(r >= 0);
+	current_status |= status;
+	r = ioctl(dev->control, VHOST_VDPA_SET_STATUS, &current_status);
+	assert(r >= 0);
+	r = ioctl(dev->control, VHOST_VDPA_GET_STATUS, &current_status);
+	assert(r >= 0);
+	assert((current_status & status) == status);
+}
+
+static void vdpa_dma_map(struct vdev_info *dev, uint64_t iova, uint64_t size,
+			 uint64_t uaddr, uint8_t perm)
+{
+	struct vhost_msg_v2 msg = {};
+	int r;
+
+	msg.type = VHOST_IOTLB_MSG_V2;
+	msg.iotlb.iova = iova;
+	msg.iotlb.size = size;
+	msg.iotlb.uaddr = uaddr;
+	msg.iotlb.perm = perm;
+	msg.iotlb.type = VHOST_IOTLB_UPDATE;
+	r = write(dev->control, &msg, sizeof(msg));
+	assert(r == sizeof(msg));
+}
 
 void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 {
@@ -76,6 +108,12 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 		.used_user_addr = (uint64_t)(unsigned long)info->vring.used,
 	};
 	int r;
+	if (dev->vdpa) {
+		vdpa_dma_map(dev, (uint64_t)(unsigned long)info->ring,
+			     vring_size(info->vring.num, 4096),
+			     (uint64_t)(unsigned long)info->ring,
+			     VHOST_ACCESS_RW);
+	}
 	state.num = info->vring.num;
 	r = ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
 	assert(r >= 0);
@@ -90,6 +128,11 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 	file.fd = info->call;
 	r = ioctl(dev->control, VHOST_SET_VRING_CALL, &file);
 	assert(r >= 0);
+	if (dev->vdpa) {
+		state.num = 1;
+		r = ioctl(dev->control, VHOST_VDPA_SET_VRING_ENABLE, &state);
+		assert(r >= 0);
+	}
 }
 
 static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
@@ -121,33 +164,61 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	dev->nvqs++;
 }
 
-static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
+static void vdev_info_init(struct vdev_info *dev, unsigned long long features,
+			   char *vdpa_dev)
 {
+	char *vhost_dev = "/dev/vhost-test";
 	int r;
 	memset(dev, 0, sizeof *dev);
 	dev->vdev.features = features;
+	if (vdpa_dev) {
+		dev->vdpa = true;
+		vhost_dev = vdpa_dev;
+	}
 	INIT_LIST_HEAD(&dev->vdev.vqs);
 	spin_lock_init(&dev->vdev.vqs_list_lock);
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
-        dev->control = open("/dev/vhost-test", O_RDWR);
+	dev->control = open(vhost_dev, O_RDWR);
 	assert(dev->control >= 0);
 	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
 	assert(r >= 0);
-	dev->mem = malloc(offsetof(struct vhost_memory, regions) +
-			  sizeof dev->mem->regions[0]);
-	assert(dev->mem);
-	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
-                          sizeof dev->mem->regions[0]);
-	dev->mem->nregions = 1;
-	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
-	dev->mem->regions[0].userspace_addr = (long)dev->buf;
-	dev->mem->regions[0].memory_size = dev->buf_size;
-	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
-	assert(r >= 0);
+	if (!dev->vdpa) {
+		dev->mem = malloc(offsetof(struct vhost_memory, regions) +
+					   sizeof(dev->mem->regions[0]));
+		assert(dev->mem);
+		memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
+					   sizeof(dev->mem->regions[0]));
+		dev->mem->nregions = 1;
+		dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
+		dev->mem->regions[0].userspace_addr = (long)dev->buf;
+		dev->mem->regions[0].memory_size = dev->buf_size;
+		r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
+		assert(r >= 0);
+	} else {
+		uint8_t status = 0;
+
+		r = ioctl(dev->control, VHOST_GET_BACKEND_FEATURES,
+			  &dev->backend_features);
+		assert(r >= 0);
+		dev->backend_features &= 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2;
+		assert(dev->backend_features);
+		r = ioctl(dev->control, VHOST_SET_BACKEND_FEATURES,
+			  &dev->backend_features);
+		assert(r >= 0);
+		r = ioctl(dev->control, VHOST_VDPA_SET_STATUS, &status);
+		assert(r >= 0);
+		vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
+				     VIRTIO_CONFIG_S_DRIVER);
+		vdpa_dma_map(dev, (uint64_t)(unsigned long)dev->buf,
+			     dev->buf_size, (uint64_t)(unsigned long)dev->buf,
+			     VHOST_ACCESS_RW);
+	}
 	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
 	assert(r >= 0);
+	if (dev->vdpa)
+		vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
 }
 
 /* TODO: this is pretty bad: we get a cache line bounce
@@ -177,8 +248,13 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 	const bool random_batch = batch == RANDOM_BATCH;
 
 	__virtio_unbreak_device(&dev->vdev);
-	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
-	assert(r >= 0);
+
+	if (!dev->vdpa) {
+		r = ioctl(dev->control, VHOST_TEST_RUN, &test);
+		assert(r >= 0);
+	} else {
+		vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+	}
 	if (!reset_n) {
 		next_reset = INT_MAX;
 	}
@@ -268,8 +344,10 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		}
 	}
 	test = 0;
-	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
-	assert(r >= 0);
+	if (!dev->vdpa) {
+		r = ioctl(dev->control, VHOST_TEST_RUN, &test);
+		assert(r >= 0);
+	}
 	fprintf(stderr,
 		"spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
 		spurious, started, completed);
@@ -323,6 +401,11 @@ const struct option longopts[] = {
 		.val = 'r',
 		.has_arg = optional_argument,
 	},
+	{
+		.name = "vdpa",
+		.val = 'V',
+		.has_arg = required_argument,
+	},
 	{
 	}
 };
@@ -336,6 +419,7 @@ static void help(void)
 		" [--delayed-interrupt]"
 		" [--batch=random/N]"
 		" [--reset=N]"
+		" [--vdpa=/dev/vhost-vdpa-N]"
 		"\n");
 }
 
@@ -347,6 +431,7 @@ int main(int argc, char **argv)
 	long batch = 1, reset = 0;
 	int o;
 	bool delayed = false;
+	char *vdpa_dev = NULL;
 
 	for (;;) {
 		o = getopt_long(argc, argv, optstring, longopts, NULL);
@@ -389,6 +474,10 @@ int main(int argc, char **argv)
 				assert(reset < (long)INT_MAX + 1);
 			}
 			break;
+		case 'V':
+			vdpa_dev = optarg;
+			features |= 1ULL << VIRTIO_F_ACCESS_PLATFORM;
+			break;
 		default:
 			assert(0);
 			break;
@@ -396,7 +485,9 @@ int main(int argc, char **argv)
 	}
 
 done:
-	vdev_info_init(&dev, features);
+	//TODO: support reset for vdpa
+	assert(vdpa_dev && !reset);
+	vdev_info_init(&dev, features, vdpa_dev);
 	vq_info_add(&dev, 256);
 	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
 	return 0;
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
