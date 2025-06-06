Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06183286D73
	for <virtualization@lists.linux.dev>; Fri,  6 Jun 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210625; cv=none; b=JeudADcrWd13eJFubFHkLIU5e8ZJFws1p4mDcOcfPqfKZz0H3iKvxU6XYKhTsyBn+K9TwwqfDv7mlVg1bdq0amQAw7p6dZEteQbAFL/lfd3Rx6JA3fIJupsxpedbomPEv6jwO55Xj0osI+GX2p+eABzu76SMjgPT9J9LqIE1w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210625; c=relaxed/simple;
	bh=XY8CgEm+gfYiIn55Z9BrkbO2R0Hv7ngcaj+noUQ/ZaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WGTBPl9R8TksBHx0zLITedMgLYDFUZXa9X3WsOMGXmR+AkEzQh7//+yIl5PPQcJVs/4SCpAYmi1qzyabY9V8GvfgxT6ITEJuW7lg5EFsjNlx7gwmEsFNdeVKxe0QdmBZGhwOJgsoVfCa0yus1ufELa8Jub09omce3d5Ktx/eJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZ//8IYN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ//8IYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pAESjvW/CQELSi4D5e2qzw/1nEgJ9ev8dcIeNCsprbU=;
	b=KZ//8IYNUOIQLCrOdPHDiR6gZdGntafqiEyCHQo5OnNV/m5q9dJ0Rkb+Lk8mntp8mGyPS1
	qmU5LHoZbqx3p7iwU/5d/eqn/pXayR53BPVH/OreSMYL/x5mJNIVwBhNPnR0FGSAwTSA3Q
	yMVj71I9TczUISsFpNo4vMulTJl5OXU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-_VADKSl_NMWy0wzWPgeDUg-1; Fri,
 06 Jun 2025 07:50:19 -0400
X-MC-Unique: _VADKSl_NMWy0wzWPgeDUg-1
X-Mimecast-MFC-AGG-ID: _VADKSl_NMWy0wzWPgeDUg_1749210618
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2272195604F;
	Fri,  6 Jun 2025 11:50:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EA8419560B2;
	Fri,  6 Jun 2025 11:50:14 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: jasowang@redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [RFC 0/6] Add multiple address spaces support to VDUSE
Date: Fri,  6 Jun 2025 13:50:06 +0200
Message-ID: <20250606115012.1331551-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When used by vhost-vDPA bus driver for VM, the control virtqueue
should be shadowed via userspace VMM (QEMU) instead of being assigned
directly to Guest. This is because QEMU needs to know the device state
in order to start and stop device correctly (e.g for Live Migration).

This requies to isolate the memory mapping for control virtqueue
presented by vhost-vDPA to prevent guest from accessing it directly.

This patches introduces the multiple address spaces support for VDUSE
device. This idea is to identify a specific address space via an
dedicated identifier - ASID.

The VDUSE device needs to report the number of virtqueue groups and the
association with each virtqueue, and also the number of address space
supported.  Then, the vDPA driver can modify the ASID assigned to each
VQ group to isolate the memory AS.  This is already done for vdpa_sim and
nvidia mlx5 devices.

This helps to isolate the environments for the virtqueues that will not
be assigned directly. E.g in the case of virtio-net, the control
virtqueue will not be assigned directly to guest.

This is an RFC has only been tested with vhost_vdpa, so it deserves more
testing  with virtio_vdpa. And it still has some TODOs pending.  Sending
to gather early feedback.

Also, to be able to test this patch, the user needs to manually revert
56e71885b034 ("vduse: Temporarily fail if control queue feature requested").

Eugenio Pérez (6):
  vduse: add v1 API definition
  vduse: add vq group support
  vduse: add vq group asid support
  vduse: send update_iotlb_v2 message
  vduse: reset group asid in reset
  vduse: bump version number

 drivers/vdpa/vdpa_user/vduse_dev.c | 307 ++++++++++++++++++++++-------
 include/uapi/linux/vduse.h         |  64 +++++-
 2 files changed, 298 insertions(+), 73 deletions(-)

-- 
2.49.0

