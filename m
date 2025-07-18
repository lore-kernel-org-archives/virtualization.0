Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6203597A
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806292; cv=none; b=aROFZwBea6Wu49ULYYCJTlVy1woorHDM4++UlF4142MDZDZy28qgBF4YAdBdqCicU0ahzVSqPpX9dEvtKBoIkheSZxKd6z1B/Gqe6Lis5nZSMJCWTDhRehBNLvD0fYzLi8f15ulLchjO4L+H00Gt9mJ6/Y3SmVd9N8hPqZBzNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806292; c=relaxed/simple;
	bh=QpxBiEp9y0Xhu9xv+cqFXhLI2Tic9geBrg5P/WVfRdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=o7s7Lp8LL+9aa3xBja+iljPpPUMgF2BpLPiGB4fkZPrBJpZXoktpJpDleRKZ+cKRnFuxN4QK4/fzPQnbKdAcelw2UJIUWBIKGAGqCG/0aLcHoMbbJ07AlHVTIFBaJ5qT8IR62mbCwok27+kgykgLvDkEVf6cdaeHOBKSlQCOaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpJ3ihIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpJ3ihIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752806289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qhQ3N294frcwDHeydRCBzfN/fPYjx9goLUNh8KlXEUI=;
	b=SpJ3ihIMM/jkErfcNYknR7BYdqXCr0L2ENrfsqpUI+N6qCuWUeG9F00GG4dxh+1/mS7Lqk
	8ozPCmucrJkQNjZ/m8TEypewKOBTv1ZXUO/bC1bRi0AejYEonltcJaTS1nDwC0aYzE/xoV
	PlfY3SKBp2AjG8XayqeoHKcvVs59VqQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-oVPhXCrFPV6_Y9fvT2J_ug-1; Thu,
 17 Jul 2025 22:38:06 -0400
X-MC-Unique: oVPhXCrFPV6_Y9fvT2J_ug-1
X-Mimecast-MFC-AGG-ID: oVPhXCrFPV6_Y9fvT2J_ug_1752806285
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C4C2180028F;
	Fri, 18 Jul 2025 02:38:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEA2930001B9;
	Fri, 18 Jul 2025 02:38:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org
Subject: [PATCH V3 0/9] Refine virtio mapping API
Date: Fri, 18 Jul 2025 10:37:49 +0800
Message-ID: <20250718023758.36866-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _W6Sg-YGade9aQ_SGm8DDQqwuyHq09L2qrBt_qXT0iA_1752806285
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Hi all:

Virtio used to be coupled with DMA API. This works fine for the device
that do real DMA but not the others. For example, VDUSE nees to craft
with DMA API in order to let the virtio-vdpa driver to work.

This series tries to solve this issue by introducing the mapping API
in the virtio core. So transport like vDPA can implement their own
mapping logic without the need to hack with DMA API. The mapping API
are abstracted with a new map operations in order to be re-used by
transprot or device. So device like VDUSE can implement its own
mapping loigc.

For device that uses DMA (for example PCI device), the virtio core
will still call DMA API directly without the need of implementing map
ops per device/transport.

Please review.

Changes since V2:

- Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS

Changes since V1:

- Fix build error of mlx5_vdpa driver

Jason Wang (9):
  virtio_ring: constify virtqueue pointer for DMA helpers
  virtio_ring: switch to use dma_{map|unmap}_page()
  virtio: rename dma helpers
  virtio: rename dma_dev to map_token
  virtio_ring: rename dma_handle to map_handle
  virtio: introduce map ops in virtio core
  vdpa: rename dma_dev to map_token
  vdpa: introduce map ops
  vduse: switch to use virtio map API instead of DMA API

 drivers/net/virtio_net.c                 |  32 +-
 drivers/vdpa/Kconfig                     |   8 +-
 drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
 drivers/vdpa/mlx5/core/mr.c              |   4 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  10 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
 drivers/vdpa/pds/vdpa_dev.c              |   3 +-
 drivers/vdpa/solidrun/snet_main.c        |   8 +-
 drivers/vdpa/vdpa.c                      |   5 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
 drivers/vdpa/vdpa_user/iova_domain.c     |   8 +-
 drivers/vdpa/vdpa_user/iova_domain.h     |   5 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  34 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
 drivers/vhost/vdpa.c                     |  11 +-
 drivers/virtio/virtio_ring.c             | 440 ++++++++++++++---------
 drivers/virtio/virtio_vdpa.c             |  15 +-
 include/linux/vdpa.h                     |  22 +-
 include/linux/virtio.h                   |  36 +-
 include/linux/virtio_config.h            |  68 ++++
 include/linux/virtio_ring.h              |   6 +-
 22 files changed, 486 insertions(+), 254 deletions(-)

-- 
2.42.0

