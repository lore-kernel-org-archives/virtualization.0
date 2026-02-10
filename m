Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A806F30FF26
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711968; cv=none; b=mNGsqGwR3a4DxnD57AQqym0DDxsMBIF45JqHDRNoiCo1nBpoeWxmP3hz7aTg0hdMcLgZUYGrP2Az3iG+IsF2Dgfj1D5GPZk1DvmBsfbdVJqYIxJ+bbl6bjIkhbBObVtIdFFb4glUuYFidEf5QH+3RlxVpEx1ILqmA0X2hRc5MJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711968; c=relaxed/simple;
	bh=5nDw7drIMPUTQOWa+nF4dfAWrqqTko3Vgm5q2FRvKyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TvQn27q4ZOz+Yntlw54aPqUCypupmnc4r69mUaP499jhc7TOk5OcdeSMXXzjUbSHTeY43dKOc8L+B6OLGpfAHjPqdbM9RCpDkIFgEBtm4v2oWjzQLTqNtoFW6iV/mQ2z9QFObztuE1ZKkL23fS/TehfXolHHFee/v/XpbTz5wq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMa5qTrP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMa5qTrP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770711965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JyL4BZTjvjcWTrtVObGHvPJLZx5hdEZJdOpMkCffIDg=;
	b=PMa5qTrPmZge4oJC/L11FNeMFwEcdAyB8IdivctIipQ8wW/t6d1gHozLfA0u9f6omkInyL
	nQ1+poiSYiATJELvQ0A1APgDB4uMgrSgvaitgrkBXzCrTrAjj1V6gw+szBIeJaizWWTFxU
	AXexPMnQN5Y7p6bLRP4zbIsB5ft4rjs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-HdDwdz76PMCASwVQiRz8xA-1; Tue,
 10 Feb 2026 03:26:02 -0500
X-MC-Unique: HdDwdz76PMCASwVQiRz8xA-1
X-Mimecast-MFC-AGG-ID: HdDwdz76PMCASwVQiRz8xA_1770711961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18F31195608F;
	Tue, 10 Feb 2026 08:26:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F1711956056;
	Tue, 10 Feb 2026 08:25:56 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2 0/5] Add queue ready message to VDUSE
Date: Tue, 10 Feb 2026 09:25:49 +0100
Message-ID: <20260210082554.1582553-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: -fm89d3zL-S5Rd4GFVJ-hGVwGOG99An6ZUTJRHaZbZg_1770711961
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

v2:
* Fix comment of vduse_dev_request.vq_ready
* Set vq_ready before sending the message to the VDUSE userland
  instance, avoiding the need for SMP sync after receiving the message.
* Return -EINVAL if control ioctl called with version < 2, so userland
  visible reply is kept (Jason).

Eugenio Pérez (5):
  vduse: store control device pointer
  vduse: Add API v2 definition
  vduse: add VDUSE_GET_FEATURES ioctl
  vduse: advertise API V2 support
  vduse: add F_QUEUE_READY feature

 drivers/vdpa/vdpa_user/vduse_dev.c | 66 +++++++++++++++++++++++++++---
 include/uapi/linux/vduse.h         | 29 ++++++++++++-
 2 files changed, 88 insertions(+), 7 deletions(-)

--
2.53.0

