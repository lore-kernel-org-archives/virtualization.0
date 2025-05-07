Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CA6217F40
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606514; cv=none; b=ilrBDHOvDr/xlp4bR55HktlmsK16BUZ8TnNL7DSbxS6CvR10/UfTx1lMGaKXDYm3f/F51ZqeCx+un4qPgjoSFt5lcUh5QN2C2wU2EtJMY+kiaOOrXNYVyyzkauusSLLKlFbBmEnS3lVPf5xvD2PI+E5iFkdjSIQMqbGoE6Y3UNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606514; c=relaxed/simple;
	bh=LQLDtHyEMv6WC5tvlSF6xAtjEa1TBJ6NL16bqwQ1zBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQwy1KymODHbV9w/CvpdTV/onJ2eFVwCFe0eJpsk3NsI/sxQWnUd0YC7lEac6gE/JD5z7A3IW+z1g4Z5zSUCvNQIk5RVnH1K9USrrrPuuSPKPYpwcEedy/BknbEhTqEoYKc4Q4gD9w/8Z3j8BGPstoShIx+2xdydGNsuH0LKLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiscVOSE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiscVOSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746606511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VxMpeAEp5/qbopqS26YNMKfIvvwVGQ66Rj7oYRD3BHo=;
	b=UiscVOSEf0aNJIri7oSEsaymd54y+S/GOjOOuY9/5Yz0WhhYp/fAaYeK//gaFdAOEZpw3i
	YbOIIKuJZQcCx7Ksvom4EEJNfDyqqv/YpUlLcUClU6Bficdw+wOH08LpnqmcUOIPHEDhcG
	BWbtAncpcx239TOg/6gktX+f0JhRPqA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-CuZZ52rhOlqxuf7sqjYhSA-1; Wed,
 07 May 2025 04:28:27 -0400
X-MC-Unique: CuZZ52rhOlqxuf7sqjYhSA-1
X-Mimecast-MFC-AGG-ID: CuZZ52rhOlqxuf7sqjYhSA_1746606506
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D61E0180045C;
	Wed,  7 May 2025 08:28:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.80])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7A4D19560AA;
	Wed,  7 May 2025 08:28:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6EDA318000B2; Wed, 07 May 2025 10:28:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev (open list:VIRTIO GPU DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: implement virtio_gpu_shutdown
Date: Wed,  7 May 2025 10:28:21 +0200
Message-ID: <20250507082821.2710706-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Calling drm_dev_unplug() is the drm way to say the device
is gone and can not be accessed any more.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index e32e680c7197..71c6ccad4b99 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 
 static void virtio_gpu_shutdown(struct virtio_device *vdev)
 {
-	/*
-	 * drm does its own synchronization on shutdown.
-	 * Do nothing here, opt out of device reset.
-	 */
+	struct drm_device *dev = vdev->priv;
+
+	/* stop talking to the device */
+	drm_dev_unplug(dev);
 }
 
 static void virtio_gpu_config_changed(struct virtio_device *vdev)
-- 
2.49.0

