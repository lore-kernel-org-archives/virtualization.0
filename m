Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A59288C25
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064126; cv=none; b=EsQ494QnrLkt4cuh1kv0Y3KHM6atw8RyP+98D9bJKJV81HU9l0wZPlVf7f1t/5ZK/Mjhw6IPBRDvaPnxYIRBDeWwn6h9+WnZWDnB0mzkOYgn03+qnvYo6CVuz5N7SKViL81j19knAOX0GaCANxM3UlGKnIJQB00wAw1jSbWFlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064126; c=relaxed/simple;
	bh=8tORJ+sN4leG63mVV3VR/BwdzLBKllceH7JJBcyu5Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGaS21phoF/mTsQq21FzdRoVvzRiqlLRvKEH8mXaheI7sPGlsyjygpQ4jqNPL/o80v6+1uUab5EzKGVuE2ESBAxKn4IDY4j0xB34WYhxDQAo1Z3Y8mIVmIjobXSKZRb1R96KkO1oXphUNQVSTuYPuR45YWkEeU8Qb+KuOXNXnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haBD2jrr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haBD2jrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755064123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qHSj26gK5BZF8STA/OhvCVhnS7fUfKq/EAFNdR1dWWQ=;
	b=haBD2jrrGLETKxGywBNKEoiG882l3bCrVWVCcYiNQsFB1o7S788SNEhRB+LlRe9jr9szdN
	GNOiyhuEY7MQfg+fGjBSvo8e9t8o567vYvCnUHq2aewEEGv9kPjxVjldLiBrbfwHhtNVDV
	F82RH3NuSz9s3MNPDDpiTZbW8GiJZ4Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-nPgfs3qaNke-zY1GES2IlQ-1; Wed,
 13 Aug 2025 01:48:40 -0400
X-MC-Unique: nPgfs3qaNke-zY1GES2IlQ-1
X-Mimecast-MFC-AGG-ID: nPgfs3qaNke-zY1GES2IlQ_1755064119
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 293441956080;
	Wed, 13 Aug 2025 05:48:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B94B41800446;
	Wed, 13 Aug 2025 05:48:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org
Subject: [PATCH V5 0/9] Refine virtio mapping API
Date: Wed, 13 Aug 2025 13:48:22 +0800
Message-ID: <20250813054831.25865-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Changes since V4:

- Rename map_token to mapping_token
- Introduce a union container for opaque token as well as the DMA
  device so we won't lose the type safety
- Do not try to set DMA mask for VDUSE device
- Introduce a new mapper_error op for API completeness

Changes since V3:

- Fix build error of PDS vDPA driver

Changes since V2:

- Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS

Changes since V1:

- Fix build error of mlx5_vdpa driver

Jason Wang (9):
  virtio_ring: constify virtqueue pointer for DMA helpers
  virtio_ring: switch to use dma_{map|unmap}_page()
  virtio: rename dma helpers
  virtio: introduce vring_mapping_token
  virtio_ring: rename dma_handle to map_handle
  virtio: introduce map ops in virtio core
  vdpa: support mapping token
  vdpa: introduce map ops
  vduse: switch to use virtio map API instead of DMA API

 drivers/net/virtio_net.c                 |  28 +-
 drivers/vdpa/Kconfig                     |   8 +-
 drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
 drivers/vdpa/mlx5/core/mr.c              |   4 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  15 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
 drivers/vdpa/pds/vdpa_dev.c              |   5 +-
 drivers/vdpa/solidrun/snet_main.c        |   8 +-
 drivers/vdpa/vdpa.c                      |   5 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
 drivers/vdpa/vdpa_user/iova_domain.c     |   2 +-
 drivers/vdpa/vdpa_user/iova_domain.h     |   2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  76 ++--
 drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
 drivers/vhost/vdpa.c                     |  18 +-
 drivers/virtio/virtio_ring.c             | 471 ++++++++++++++---------
 drivers/virtio/virtio_vdpa.c             |  17 +-
 include/linux/vdpa.h                     |  25 +-
 include/linux/virtio.h                   |  43 ++-
 include/linux/virtio_config.h            |  72 ++++
 include/linux/virtio_ring.h              |   7 +-
 22 files changed, 545 insertions(+), 286 deletions(-)

-- 
2.31.1

