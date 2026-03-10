Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF215C8F0
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132069; cv=none; b=bu8yDUvsyC5etps75rXRotE8CSlgJgx2+gyuuf5f09WCeCsHZdoxJ2FA+x6+JrxOAw+Vi45rbzzW6IpeUSFhAF2KnDrYr0V5O7+1O05FbDWFs0AOdbmK752rSXs8+cPs71qjtFig8reHOnlSKpPo8J7icHwvspXEGBsBYMuFCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132069; c=relaxed/simple;
	bh=Ay1ky4PAy2AzWSJhsp2FqcwtvyHpN49xECX1Z/0Vi+E=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=E/9778eq4pI5Uhl1AjkWVtI+1S0yi1k9d02JywGm4EC3m67iKQA77cDWP+a6iZtsHsdz37VuaFmrLtRRBXNePc+3CYmR+bseSCjZSOALa8/0gDtSQ03nqqo0JKEgV6+BAA6J5VmG+VCwAQ6msNyiegjjxtkOnGw2ryW4zFj/sTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDKWs14U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDKWs14U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773132065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/kpnarN+ukT5pO+lAZb2jdVe5IO5LO0iKcF3T8JPBGc=;
	b=WDKWs14U7ZiWSRTS1dNZz3fAsFG85PwxlyZ6HDj7H8STLBUZokyIKkkBmoXw5emPGurrDk
	HFsuFz7iGEkGlJIlvLlXPd0R6wGzb++KdTcom9JVkcDHHkXy7NYJeyRtNtcE25M69eOamf
	v7cjxFjyBQPRjvFJDABTjeAHGpYl4t0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-tqMFlvNQNoO0QHvxIW5W2g-1; Tue,
 10 Mar 2026 04:41:02 -0400
X-MC-Unique: tqMFlvNQNoO0QHvxIW5W2g-1
X-Mimecast-MFC-AGG-ID: tqMFlvNQNoO0QHvxIW5W2g_1773132061
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6261A1956059;
	Tue, 10 Mar 2026 08:41:01 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.226.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 817D418002A6;
	Tue, 10 Mar 2026 08:40:58 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 10 Mar 2026 09:40:46 +0100
Subject: [PATCH] virtio: Add ID for virtio media
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260310-virtio-media-id-v1-1-be211bcf682b@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TnBVivpKdCjdag9laEgQ/j3pO
 AwzLySKTAkG8UKkzInDWQEbAW6fz40k+8qglW6VQSUzx5uDPMjzXJ1cDGLXr847a6FWV6SVn/8
 4TqV80DA5zGEAAAA=
X-Change-ID: 20260310-virtio-media-id-b31179fcdc44
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 gnurou@gmail.com, Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773132058; l=1361;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=Ay1ky4PAy2AzWSJhsp2FqcwtvyHpN49xECX1Z/0Vi+E=;
 b=xX7216C00qVZGtcBE+P38w8Y2Ykqi9mcNaw9oiqysCfqIRlI1g6m+St9rDLVMMxeJCxf7BiNZ
 fyAgdi0oBnSB+1tHuyMkmk6cb2mnDJ9utoPdRSFLV3Dje1CheU0EjMQ
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: pg3ZxwNYe5xdCFmFmB0nHjYOL2LAJav7AYof_GtOYzw_1773132061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add VIRTIO_ID_MEDIA definition for virtio-media.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
While the Linux driver for virtio media is currently under active
development and review [1], the VirtIO v1.4 specification has
already been published and oficially defines the media device type [2].

Adding the device ID now allows other components and tools to reference it
before the driver lands, and ensures the kernel headers stay aligned
with the specification.

[1] https://lore.kernel.org/linux-media/20250412-virtio-media-v3-1-97dc94c18398@gmail.com/
[2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-82200022
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 6c12db16faa3a..f9056af0c6223 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -69,6 +69,7 @@
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
+#define VIRTIO_ID_MEDIA			48 /* virtio media */
 
 /*
  * Virtio Transitional IDs

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260310-virtio-media-id-b31179fcdc44

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

