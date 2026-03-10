Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4A3C3BE9
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169693; cv=none; b=HsghB5fSGUi5oqn/Qiq4f4liOS4e6CZpnY+iPo1u+U2DFS3XRS2vGARDrOUA31vfuPLsYHPDFqeVkLL/iusii/bHRT01lMKoZY54Rrh3KOW2KWELIOdbDLnZGBXabvjRgY4f5JRviql85pHCTJ2iBW9GpyXltMyuDW8e9peZSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169693; c=relaxed/simple;
	bh=56IOPl2XaxFLw+/zsnb8H2/Ft+m9nfTJC3VKqOrzJ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UxZLdHhQTtzwZhnS6ulKfjYTLmF9uBjgauHEwDKaPITx0NRXu/RVUmmiGdpgJwO5LmPry6bzfTb5oorpRVH73Z4lBSBw/ZypA52W4r5le43+LBJhAgqTUiEAn0XSVhKqTnzJpqRmW+eEIkBSv+FjfGga7GAn/Iqu9LlaN+Xb2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8MKaSDM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8MKaSDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773169690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gEv5dVAlJbcyKvFkaHHNBA+rwJbHZoRw86mlVVpI/Xw=;
	b=O8MKaSDMm2laJQ/3KxNasCtnVv/SUUYp3cKuaC8g+DSyzzP5IJ2EyK/0JSKy2yyzhsXAmp
	2KGqTUEyZVwh2mwxs1pyRFSAIEqFv5/kSDi+Q0ePoWAsjpkfq+yL8EVI3CoCzgrvElTFob
	o4NJ84g32cM7JtwRZTV/Ju53xwX+Icg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-KGLBiCnYMoaKHLkriC6RiQ-1; Tue,
 10 Mar 2026 15:08:06 -0400
X-MC-Unique: KGLBiCnYMoaKHLkriC6RiQ-1
X-Mimecast-MFC-AGG-ID: KGLBiCnYMoaKHLkriC6RiQ_1773169685
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25091195609D;
	Tue, 10 Mar 2026 19:08:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.202])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42FCD3000223;
	Tue, 10 Mar 2026 19:08:00 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 0/3] Add queue ready message to VDUSE
Date: Tue, 10 Mar 2026 20:07:56 +0100
Message-ID: <20260310190759.1097506-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 5jpHOq-eyLUfZTYVMwAl5f1kvi7qiC9zbBSEsacrmUo_1773169685
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series introduces a new VDUSE message for VDUSE userland instance
to detect when a VirtQueue (VQ) is enabled, replacing the polling.

VirtIO net devices' dataplane is started after the control virtqueue so
QEMU can apply the configuration in the destination of a Live Migration.
Without this feature, the VDUSE instance must poll the VQs to check when
(and if) a VQ has been enabled.

This series also implements VDUSE feature flags allowing the VDUSE
devices to opt-in to the VQ ready message.  Devices that opt-in to this
feature will receive explicit notifications when a VQ is ready. Devices
that do not set this flag remain unaffected, ensuring backward
compatibility without indefinitely incrementing API versions.

The VDUSE features is a 64 bit bitmap for simplicity, the same way as
vhost and vhost-net started.  It can be extended as a flexible array of
bits when we reach so many features, but it seems unlikely at this
point.

Error cases tested:
* Call VDUSE_GET_FEATURES without get the API VERSION (so API == 0) and
  with API VERSION set to 1 with VDUSE_SET_API_VERSION (-EINVAL returned
  from VDUSE_GET_FEATURES ioctl).
* Try to create a device with config->features different than 0 without
  fetch the api version (so API == 0) and with API_VERSION set to 1
  (-EINVAL returned from VDUSE_CREATE_DEV ioctl).
* Test regular initialization of single queue devices with V2 with and
  without VDUSE_F_QUEUE_READY set in device->config.
* Test expected behavior when VDUSE userland instance returns
  VDUSE_REQ_RESULT_FAILED from VDUSE_SET_VQ_READY message.
* Repeat all the tests with multiqueue devices, by reverting
  56e71885b0349 ("vduse: Temporarily fail if control queue feature requested").

This series depends on
https://lore.kernel.org/lkml/20260119143306.1818855-1-eperezma@redhat.com/

v3:
* Remove API_VERSION bump to 2
* Add comment about struct vduse_dev_config:vduse_features is only valid
  if VDUSE_GET_FEATURES success.

v2:
* Fix comment of vduse_dev_request.vq_ready
* Set vq_ready before sending the message to the VDUSE userland
  instance, avoiding the need for SMP sync after receiving the message.
* Return -EINVAL if control ioctl called with version < 2, so userland
  visible reply is kept (Jason).

Eugenio Pérez (3):
  vduse: store control device pointer
  vduse: add VDUSE_GET_FEATURES ioctl
  vduse: add F_QUEUE_READY feature

 drivers/vdpa/vdpa_user/vduse_dev.c | 41 +++++++++++++++++++++++++++---
 include/uapi/linux/vduse.h         | 25 +++++++++++++++++-
 2 files changed, 61 insertions(+), 5 deletions(-)

-- 
2.53.0

