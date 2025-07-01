Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB96B660
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332456; cv=none; b=meG5gG/CUrcpj3AwjdIEwEr8AlBlFOimGxpWpKa1MKW9FXGUQMudvBUep9mUX2DXHNHtDMrTrIXSvmxMFO7Sff0FIRZmnb6lmQKG2wc/M55/3zA86L5GYz9prm8cjQ6gkJ+ATsNV2rnIVp1hqYjmauET+6kU1oC4DRerYuIpAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332456; c=relaxed/simple;
	bh=XkeZ/W7R7uJJgTpVhG8GUB87rZj4NsF/whf372deIG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SsxCGHpIWhQfXxbAFE/mbh1BnYlrDF5YgcjsMdQhR9pjGhjoDpp9iqQviH3bspI/8LGjrO6l4NQ3cfbk+30o0W5fmWYjgJAAC4eEaAmYA2WQrJ6YzhPPUcMCnrlPZemJEQjx8q5o+y/WmYM59pxFqIpXTaVN+7fNZNZCPhvxW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwYxCj5v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwYxCj5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751332453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QrIjcCx706fQWFFH4EkxErfqPhyvfTmDbbhOUGJv6Qg=;
	b=DwYxCj5vYXE/Y8eKyTt2QRXAbomhBGAdvjnCT/0lIVvR31Gu8gP4/Xee4paerF3ELpxxyj
	nFsi15mGdHAd87OLH5rZ95Spj6jfkd6TPLzbCi43+kHARaj5lFxwDAnXCnAyLuF9kyN0hc
	32C3HPu7OQH5WCkHLHnCzDYEEVTBiUU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-jDeXJOS4OBe_qySYCDXKCw-1; Mon,
 30 Jun 2025 21:14:11 -0400
X-MC-Unique: jDeXJOS4OBe_qySYCDXKCw-1
X-Mimecast-MFC-AGG-ID: jDeXJOS4OBe_qySYCDXKCw_1751332450
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 353BE1800368;
	Tue,  1 Jul 2025 01:14:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DEE530001B1;
	Tue,  1 Jul 2025 01:14:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	xieyongji@bytedance.com
Subject: [PATCH 0/9] Refine virtio mapping API
Date: Tue,  1 Jul 2025 09:13:52 +0800
Message-ID: <20250701011401.74851-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Please review.

Thanks

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
 drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
 drivers/vdpa/pds/vdpa_dev.c              |   3 +-
 drivers/vdpa/solidrun/snet_main.c        |   4 +-
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
 19 files changed, 476 insertions(+), 238 deletions(-)

-- 
2.34.1

