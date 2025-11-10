Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152D30F54C
	for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779149; cv=none; b=Fv54UakWj2rGflDgIB5h/M3/xlJPUcz8/IuspVkDYwsQKJwQC7lIuQw3Yqy9l9qpIxJ/q2kzuEQPYR10UnWatQwk4in95R8EfPouYkENv7e13FuyRnqV7y9HgKpgkUpBEsj3KFxtOhIPA4Y1HO95vvP9M36AbxdwEs3zgxZ/uBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779149; c=relaxed/simple;
	bh=xjUeeV053GJKecTR0AWKzoeAhMEw0ZfcFmMTQxeOML0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rhjLxTsCx749aAbQ8k6HWVmLV2JAqQuXx2gZlzyuNYT9sM28AScQMykjooVXDTQFqOueEqpG0QRU98XfQj9zDC8VYjvQoX6vO+UW/n4e035uvJ6uXmGcglDUb4FFhtxs1Y9q0J9D1gt/R6+th2RQQO3tY4/YauRnokVNebxaOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrbBoSNh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrbBoSNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762779146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JcJYU3WDwqdzIu+aLHL5NcHMFk3kNTsHllL5m0lKIkE=;
	b=SrbBoSNh3W47CCBtbv4dvfZAT88GevPgUj+ydQVl+99WZ2CGlVpHlJA3g3MbZ7VEaOnK3X
	p8sCRKbYHtJWdZuPGLoGDTUaYWs5cs+GHh9UtQPGYmu0BJqUD42Of52Kg1E6u8AR8dXsf3
	ENaQ8V+is7wpkJQSFiV1WXY8Jpeq9UE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-UwUdTfggPuSep0266AaU8g-1; Mon,
 10 Nov 2025 07:52:23 -0500
X-MC-Unique: UwUdTfggPuSep0266AaU8g-1
X-Mimecast-MFC-AGG-ID: UwUdTfggPuSep0266AaU8g_1762779142
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B9231800370;
	Mon, 10 Nov 2025 12:52:21 +0000 (UTC)
Received: from slp-asahi.redhat.com (unknown [10.44.32.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2612F30001B9;
	Mon, 10 Nov 2025 12:52:14 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH 0/3] drm/virtio: introduce F_BLOB_ALIGNMENT support
Date: Mon, 10 Nov 2025 13:52:10 +0100
Message-ID: <20251110125213.12633-1-slp@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There's an incresing number of machines supporting multiple page sizes
and on these machines the host and a guest can be running, each one,
with a different page size.

For what pertains to virtio-gpu, this is not a problem if the page size
of the guest happens to be bigger or equal than the host, but will
potentially lead to failures in memory allocations and/or mappings
otherwise.

To deal with this, the virtio-spec was extended to introduce with the
VIRTIO_GPU_F_BLOB_ALIGNMENT feature [1]. If this feature is negotiated,
we must use the "blob_alignment" field in the config to ensure every
CREATE_BLOB and MAP_BLOB is properly aligned before sending it to the
device.

We also introduce the VIRTGPU_PARAM_BLOB_ALIGNMENT parameter to allow
userspace to query the alignment restrictions for blobs.

This supersedes "drm/virtio: introduce the HOST_PAGE_SIZE feature" [2].

[1] https://github.com/oasis-tcs/virtio-spec/commit/f9abfd55cb663837dda1153b826216dcf4d25b84
[2] https://lkml.org/lkml/2024/7/23/438

Sergio Lopez (3):
  drm/virtio: support VIRTIO_GPU_F_BLOB_ALIGNMENT
  drm/virtio: honor blob_alignment requirements
  drm/virtio: add VIRTGPU_PARAM_BLOB_ALIGNMENT to params

 drivers/gpu/drm/virtio/virtgpu_drv.c    |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 +++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  |  5 +++++
 drivers/gpu/drm/virtio/virtgpu_kms.c    | 14 +++++++++++---
 drivers/gpu/drm/virtio/virtgpu_object.c |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_prime.c  |  7 +++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 12 +++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vram.c   | 10 ++++++++--
 include/uapi/drm/virtgpu_drm.h          |  1 +
 include/uapi/linux/virtio_gpu.h         |  9 +++++++++
 10 files changed, 58 insertions(+), 11 deletions(-)

-- 
2.51.0

