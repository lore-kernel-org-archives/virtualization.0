Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2423350A0A
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604339; cv=none; b=KAww5ivi37LVyh1Hj4igAQXtksl9uqlx5UAx5mbvtUFOFvKviz0pSRUj6ahMNYaNOeW27t9W60M6XYPbLCz82sei16k2eD9LoBHcgN75pKVKm0lCtyVsd19mE9VpTfhhF7xWhvJqZ6EWlvGFRfL3TODQmwTB8ZPnyFnPdqUCLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604339; c=relaxed/simple;
	bh=E6Sa2Q78Iy9c8FmYTOKsDohRUBKgQ6ZQZ6OHimV8TBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dt6gIPR9uKKZISFGCe633wyUADggL1bztQ9kjkYwLzecA/D5VZ31LjyBWkeYVJbNn9WKPIZCjxhvGBFxzjZ7QWpWkedximG5n9Eo9kkh3NVZfDXneu7kHi2OCtCtm+pxAqjEIYMiAsfPXP+Mr2bHFqO5xdgy7yWcRUJkvn9wdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEcN6nrL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEcN6nrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769604336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mf/hCnCx2w+8lw8XKUOQCqVxNoMN3Kwt49H0ibw/CjI=;
	b=bEcN6nrL8gPK6pp6oZmw7lsUJ5EycGRfemgYNkhDq5yh2C55rHU+JTPNlXbUIk9HpS/hL/
	STf0/H7pxMEcSRtmIFntujA9FAYBANCwIlzf1xPW5/Pmes8whAbJNqOhVFarvVwhscN3sc
	7Xn1aVqM2dB+68+SCC9oBYoIQfoGXdc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-O2XVbCmzNY6gd0WG9oNZyQ-1; Wed,
 28 Jan 2026 07:45:33 -0500
X-MC-Unique: O2XVbCmzNY6gd0WG9oNZyQ-1
X-Mimecast-MFC-AGG-ID: O2XVbCmzNY6gd0WG9oNZyQ_1769604331
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0454F1955D93;
	Wed, 28 Jan 2026 12:45:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA31530002D6;
	Wed, 28 Jan 2026 12:45:26 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 0/6] Add queue ready message to VDUSE
Date: Wed, 28 Jan 2026 13:45:18 +0100
Message-ID: <20260128124524.875271-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series introduces a new VDUSE message for VDUSE userland instance to
detect when a VirtQueue (VQ) is enabled, replacing the polling.

VirtIO net devices' dataplane is started after the control virtqueue so QEMU
can apply the configuration in the destination of a Live Migration. Without
this feature, the VDUSE instance must poll the VQs to check when (and if) a VQ
has been enabled.

This series also implements VDUSE feature flags allowing the VDUSE devices to
opt-in to the VQ ready message.  Devices that opt-in to this feature will
receive explicit notifications when a VQ is ready. Devices that do not set this
flag remain unaffected, ensuring backward compatibility without indefinitely
incrementing API versions.

The VDUSE features is a 64 bit bitmap for simplicity, the same way as vhost and
vhost-net started.  It can be extended as a flexible array of bits when we
reach so many features, but it seems unlikely at this point.

This series depends on
https://lore.kernel.org/lkml/20260119143306.1818855-1-eperezma@redhat.com/

Eugenio Pérez (6):
  vduse: ensure vq->ready access is smp safe
  vduse: store control device pointer
  vduse: Add API v2 definition
  vduse: add VDUSE_GET_FEATURES ioctl
  vduse: add F_QUEUE_READY feature
  vduse: advertise API V2 support

 drivers/vdpa/vdpa_user/vduse_dev.c | 100 +++++++++++++++++++++++++----
 include/uapi/linux/vduse.h         |  30 ++++++++-
 2 files changed, 115 insertions(+), 15 deletions(-)

-- 
2.52.0

