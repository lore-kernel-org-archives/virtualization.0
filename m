Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178E7262D
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739371; cv=none; b=B8RtmmXari2bsuhFDA+XKGa80/XKG/R2LEsot4nO44Xi2KZ7GfGDIOGZZlB6uyqnddrjgkv62Y3ae+ZDe6gps2Ox2hKioT4xmOeRbQCl+C3xv6QryMURI9PS+W5AziSpypnB5/WLp4GJZe5qmJryZ21BIQ6817eH7i8Pa3VvwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739371; c=relaxed/simple;
	bh=BgDj4PibCrxpiB8DfAYTRrS3UhIcPHZ9+H6G9YHHdc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=U1Pu/lIF+ho+O4/zjzojMK2mfjxP+8/sHTpNBHXXB85fWkSB09FPBvJ/u63GMTV09JkFDbUK6ZQoe2qHbrSmhAmEPyuXSDu84Pm0wYODB+i+QA17DYOVc/gyc+QwMZiw3ehisILvs8seV3F4OV/0qT2u6U8p7robDVk5rc2kz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaJNaNtU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaJNaNtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752739368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AX/f9tSJVFi5CZpxF0+vkvq51JIWK4dOW2DS/LIZuW4=;
	b=BaJNaNtUhLjUiZkJMcfVtzr3tJo0cMtFd9eTh5375YGvY7iDeqMIrPzTmfkKlbaPhYXZ+V
	9t308zCv99werFPoTo5qxG8Oco1hLjjB5Z5R9m61wPSAnrp/ocaJkzwKzxIUmy26m/DRc2
	mSZ9OPhCHYP+X8lC2kEnCnRBx4MHG6s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-4ynXSyBdO4yBS2znhQF9xA-1; Thu,
 17 Jul 2025 04:02:45 -0400
X-MC-Unique: 4ynXSyBdO4yBS2znhQF9xA-1
X-Mimecast-MFC-AGG-ID: 4ynXSyBdO4yBS2znhQF9xA_1752739364
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A06A3180028D;
	Thu, 17 Jul 2025 08:02:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 802921956089;
	Thu, 17 Jul 2025 08:02:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org,
	root <root@dell-per760-18.lab.eng.pek2.redhat.com>
Subject: [PATCH V2 0/9] Refine virtio mapping API
Date: Thu, 17 Jul 2025 16:02:28 +0800
Message-ID: <20250717080237.6518-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8h73OOsoWEdI-1NDOAol-No69Ld8tJHooBvJ2vvfjs0_1752739364
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: root <root@dell-per760-18.lab.eng.pek2.redhat.com>

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
 21 files changed, 485 insertions(+), 247 deletions(-)

-- 
2.47.3

