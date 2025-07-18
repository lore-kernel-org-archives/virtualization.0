Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F61E5B78
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830187; cv=none; b=eGLP7oLjrgGRPTqZvj+RkT6OtV0cV70A3VxdjRMgFBi63tVh5rx5DaDdIk/2UER094LpuMg+HeAWW5YW+ctjL7UhDhr8hz9YuglgomSl8h1zUOBlV5qdCudLRX1XhwoMnQMvxsSsKOAu4pNC6v6KgeXZ+UsODwwZti1TUU4EGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830187; c=relaxed/simple;
	bh=G1sWb3uh2vK5Y6yOFGnk+EWD358ECyel+UpkR0kaByo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=P0Mf/tKEeqVMjHSXnqyUTdueGZ9QAxZ3gkYVkyVRMhHXKteyA3jTb3v8sE22Jt1M/UE1xkr8WKqakVkXUChOvHfDv3kTz5GSdX4xX2mCBIouStezYmukm0cbzXr2Fk6Fd0EyL1mQUdg3gS5jj1eGIxj4KzXGtcu4F7YcUzID9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUWm8eqx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUWm8eqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kFQHrFy1C6pRfX50T1uF7bdqR7oVEpuwtJZqihrwg/E=;
	b=DUWm8eqxtzOfJUEo27E/IxbOB/2iDsq4tWpFeta0ZEaAXW0Uoz+veiZQQbysH9ige0MRzC
	ftHujcH6LL3e5tVGcjQQW3U81VUvHyDhT1b3f/GpABFaY5eIyHLTi5aUL+uioGj+61K5Wt
	rp1aevm7XUx2AtfeW8jfFNBZhnO4Xqo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-gwWEpOAaNl2FaHC1V0m-Xw-1; Fri,
 18 Jul 2025 05:16:23 -0400
X-MC-Unique: gwWEpOAaNl2FaHC1V0m-Xw-1
X-Mimecast-MFC-AGG-ID: gwWEpOAaNl2FaHC1V0m-Xw_1752830183
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 988C31800359;
	Fri, 18 Jul 2025 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3736B195608D;
	Fri, 18 Jul 2025 09:16:18 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org
Subject: [PATCH V4 0/9] Refine virtio mapping API
Date: Fri, 18 Jul 2025 17:16:07 +0800
Message-ID: <20250718091616.6140-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nmE412bmx9zquegAWnbMQAVwpiICh_4ZwXtikCJpHW0_1752830183
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
 drivers/vdpa/pds/vdpa_dev.c              |   5 +-
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
 22 files changed, 487 insertions(+), 255 deletions(-)

-- 
2.47.3

