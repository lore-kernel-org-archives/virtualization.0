Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186E3C0634
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456388; cv=none; b=VYbwqlxof41/TDaw1TDvDYDCNXjQniok+5w3LV3eJaxe8g3kHuspeBYtZ1HqUZ0BWYheeVID5Hdv0n+h6EUDfzG53I3DsRZikkk8XNjgu6tNQfRIjz3tXIH0gkkPQ4hjvZ+IOiHbChO5JVsEhV5YfaIAMwv+uQbgs+ZCEcUbYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456388; c=relaxed/simple;
	bh=ARMJiQK4b4zHEIL+biAYPcz6LCdoox4fSNhJKM3B3YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=juH3CwmWPTxfPM5ho2Cqn+lRmOORiZHl5EJlDTM9Poi9h4V4h7VVgri5TgA0iYrCKEXAG2B1Y8QxB45gGMW4pvLUZGSR3xBTOBTgevut7ydOnP7u9dwkpy63fzjSj/xryeb9upG1eqktmf8BFBKmwKkIXLWhwF0FZLYvavbmOek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFPoNwfJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFPoNwfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777456386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvJ3vxSBzk5FsPg5bvaaE5ZBFTyjjD6iz6OfCrAzyHs=;
	b=gFPoNwfJKL1+khEnUCaNoV22nOtsD1WxEXQ21U4UwZgIzlvIcvGYz0uVKv32pdq1qjYlrn
	khRmBRqmcnI7rkNnNoBT5X4hAJJC2CQDnCqJPdcuHUDDm9kd2F8+VF0jZ0JhNHu8GmrFUK
	BPFBCg1dEReH2YRTzOar4LDG3dz5zFA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-V9A2mvalNouziWZdFQOlFQ-1; Wed,
 29 Apr 2026 05:53:00 -0400
X-MC-Unique: V9A2mvalNouziWZdFQOlFQ-1
X-Mimecast-MFC-AGG-ID: V9A2mvalNouziWZdFQOlFQ_1777456378
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56E531800D92;
	Wed, 29 Apr 2026 09:52:58 +0000 (UTC)
Received: from f43vm.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 897461800480;
	Wed, 29 Apr 2026 09:52:53 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: Chia-I Wu <olvaffe@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
Date: Tue, 28 Apr 2026 21:44:49 +0200
Message-ID: <20260428194450.518296-3-slp@redhat.com>
In-Reply-To: <20260428194450.518296-1-slp@redhat.com>
References: <20260428194450.518296-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 18YJNz7qgAL7cWqwokbcEpULyzAMEfKiEfan-2a2tqo_1777456378
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
aligned to blob_alignment. Validate this in verify_blob() so that
invalid requests are rejected early.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c33c057365f8..d0c4edf1eaf4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->size = rc_blob->size;
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
+
+	if (vgdev->has_blob_alignment &&
+	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.53.0

