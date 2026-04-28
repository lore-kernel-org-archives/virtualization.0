Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44D3B5304
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456377; cv=none; b=WuRqj5UTPbM1sib1lCCfwedO9x8+XjdkcS8+XtGZ71Hr2dQ1c+GM3tgMkHtkj+6FaeO7xVMyLMJZ0rmdI94P97uiRhtmva4mznS2TvkCBdyNbegfcCQphAabFxVhw3vYZ8Y7/LlNb4Kh3KsA8sfEAkodLUYbZpoWPdn7VqPMCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456377; c=relaxed/simple;
	bh=iYiw0CmhW1uNO52r6h06DT39V6K9yOrh40nBJUPbNT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGfigsrYQE/aPWR318RN2yPbdFtkXMm0sh4DgZuZK4yoI9PxnSy5o7+Johj2Nz5ntoexqvO/MxpDNOfNfrAN9ZGBCS61Cvm2kOhXb87bwPh5zHR9bH1NDGXsjZomVznVAVoLTLeq8OiSlk6QhiRHqZ9d7IEszdLjeAguosGqwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjILmRL+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjILmRL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777456375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tEgMhSGkxaVa76ywFFeR7i2nWi7ewgciMk8C9+6QmjI=;
	b=MjILmRL+nm79B1kxU4NIIdPmh9JFtjxrLEFN8SCrnMjM4zqXuqDoJggiz2NE5khxE+P+Zb
	UdxUaZGbWWDVicWm+yL4/FOF7eGpQpY9vE7ss/DgQlonUFePKOpoHPgO6duOYk+rxRMBIK
	5/7uFcFaQAqBiLQnCIjGhF54TJlpebQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-zBYbRCtwO1m14iD81uuuJA-1; Wed,
 29 Apr 2026 05:52:51 -0400
X-MC-Unique: zBYbRCtwO1m14iD81uuuJA-1
X-Mimecast-MFC-AGG-ID: zBYbRCtwO1m14iD81uuuJA_1777456369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5742D19560AE;
	Wed, 29 Apr 2026 09:52:48 +0000 (UTC)
Received: from f43vm.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A80FF1800345;
	Wed, 29 Apr 2026 09:52:43 +0000 (UTC)
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
Subject: [PATCH v2 0/3] drm/virtio: introduce F_BLOB_ALIGNMENT support
Date: Tue, 28 Apr 2026 21:44:47 +0200
Message-ID: <20260428194450.518296-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 3AmdKVt59R0NvejrUDOVpFY0SpS-67c9WolQH7vWFpI_1777456369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There's an increasing number of machines supporting multiple page sizes
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

Changes in v2:
- Rebased.
- Moved blob size alignment validation to verify_blob(), rejecting
misaligned sizes early in the ioctl path instead of checking in
virtio_gpu_cmd_resource_create_blob() and virtio_gpu_cmd_map()
(Dmitry Osipenko).

Sergio Lopez (3):
  drm/virtio: support VIRTIO_GPU_F_BLOB_ALIGNMENT
  drm/virtio: honor blob_alignment requirements
  drm/virtio: add VIRTGPU_PARAM_BLOB_ALIGNMENT to params

 drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 10 ++++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   | 14 +++++++++++---
 include/uapi/drm/virtgpu_drm.h         |  1 +
 include/uapi/linux/virtio_gpu.h        |  9 +++++++++
 6 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.53.0

