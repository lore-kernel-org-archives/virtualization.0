Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86753FF1AE
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427116; cv=none; b=qhvaFUm/GBCNLGPwKXZS2yPSBtKzOrWMbcSe5BKjP2GjK2reYKjuucEjIbdzOpOhZsYCoqC18aGNJocrLERhqr97rIl4yN6YgI6239nhj1jxBfL8EMJKkfR94kRzL5GYl984953/vE/CS4PL5oGQ6pG1Y0YSsenPsov0Py7Elvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427116; c=relaxed/simple;
	bh=zCMkxBhSClNfSycJF3S0+/VIsZ6EOUsoISC8a0UUr+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gl6XMZVE1gwdKRGxWD92/Vr0y6lvH5PhwifjPmSgDGLqpRPW9QtHe6KBXdkNvE784ag8g1C0tA/nNsDSVCeyH0aLZelBKjr5jW1LbPsStLidQhB04owVQF0p5FfbRQwq/NKE6NJl8hQ17a4zr+T9pNHu0YTtu8juRr1+zucXPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDcM7fV6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDcM7fV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783427114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7a1kK8XGyphOTKedUz27EjWLwCpWdLZ+EPSmO22D7Uk=;
	b=iDcM7fV6XnV6PLPITgGzgibFQzjSAj4dmwJ+qgcmxn/zUPJr4SuEzAzkBllCAdQdy+cVri
	gFvHSXWkOfZDEd1++9yeJGeKtbJodkeMcYkirSPfPM0QmXZ4Oc/tCOqT1i0WOnYWXQy67K
	amDkJeTmuyrlQA3bcKrjNG48jm3H3HI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-rES_tGBWNz-9MXdOh9rxJg-1; Tue,
 07 Jul 2026 08:25:09 -0400
X-MC-Unique: rES_tGBWNz-9MXdOh9rxJg-1
X-Mimecast-MFC-AGG-ID: rES_tGBWNz-9MXdOh9rxJg_1783427108
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E28CF1954B3F;
	Tue,  7 Jul 2026 12:25:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C0811800595;
	Tue,  7 Jul 2026 12:25:03 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH v4 0/4] Add queue ready message to VDUSE
Date: Tue,  7 Jul 2026 14:24:58 +0200
Message-ID: <20260707122502.239022-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 2PnJjvJHkFqRTqdqrjA8vICfwnyBfg1XCRYFCsMb93I_1783427108
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
feature will receive explicit notifications when a VQ is ready.  Devices
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
* Try to set invalid features.
* Test regular initialization of single queue devices with and without
  VDUSE_F_QUEUE_READY set.
* Test expected behavior when VDUSE userland instance returns
  VDUSE_REQ_RESULT_FAILED from VDUSE_SET_VQ_READY message.
* Repeat all the tests with multiqueue devices, by reverting
  56e71885b0349 ("vduse: Temporarily fail if control queue feature requested").

v4:
* Create its own spinlock for vq->ready instead of relying on kick and
  call spinlocks.
* Add VDUSE_SET_FEATURES ioctl and the corresponding validation paths instead
  of using device config.

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

Eugenio Pérez (4):
  vduse: store control device pointer
  vduse: add VDUSE_GET_FEATURES ioctl
  vduse: add VDUSE_SET_FEATURES ioctl
  vduse: add F_QUEUE_READY feature

 drivers/vdpa/vdpa_user/vduse_dev.c | 111 +++++++++++++++++++++++------
 include/uapi/linux/vduse.h         |  24 +++++++
 2 files changed, 115 insertions(+), 20 deletions(-)

-- 
2.55.0

