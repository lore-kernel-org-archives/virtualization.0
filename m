Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5322541B
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697262; cv=none; b=T39RezqAhqiqdWxXnlcVWp2D8ffXWcZJgML2k1FsjkFytjdX588Q1BxSMoxo1PzfBTQcv5jfiDRD49Pg2V9g9k4a+GiTdn5qzx7J9Bp9wtd6c/6Q51o1Um1KJYbzvJdf9mOgt1gs8INt6jJka1DPxjDUzK3VxiathK4nWWtmRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697262; c=relaxed/simple;
	bh=I0a7rVPJ44Xfxl8Rp+yQVZtLu1K/AejUB+fgH7g7yi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2iF/XJXWCCVC2GLDEOHKesI/He26jD/z0vBM15HMOMisvA90kexoaiolOma1unM7Wl4gZZxXGcADzhBuJIADpMvLS0mV5T+udWjqfJyko17cK9oE6t+AcDCbX5Yzycoo3Cv+q9+JsBSsU0SLYLydHd9LuAMlXFW6iEwBsn488g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVIsW/Hw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVIsW/Hw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758697259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3s6WSpa8MQ7Wctb9Z8KxRAVzwFwLWxluun8ISqvxvM=;
	b=JVIsW/HwMxPhP5n/akZHSlvnqs+ue+d+RODgkrgMyn3nTTQM3+MJ/A+j/TjK95goxdfaAG
	MLHyU0VDuzJea9AM9J4B7Um9PhVamPnhplFh1lffDzh3EbLQybiY5zEqbva+u8I9Ct6VQh
	Z94JuKLtUq8uPq2di6jv26j98mXUE/s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-QRBwU-whPrSFC0YYoeTeKw-1; Wed,
 24 Sep 2025 03:00:55 -0400
X-MC-Unique: QRBwU-whPrSFC0YYoeTeKw-1
X-Mimecast-MFC-AGG-ID: QRBwU-whPrSFC0YYoeTeKw_1758697254
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B263195609F;
	Wed, 24 Sep 2025 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.172])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 241F1300018D;
	Wed, 24 Sep 2025 07:00:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 0/2] Use virtio map API for VDUSE
Date: Wed, 24 Sep 2025 15:00:43 +0800
Message-ID: <20250924070045.10361-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi all:

With the introduction of the virtio map API, there's no need for VDUSE
to be hacked with DMA API to work. So this series switches to use
virtio map API for VDUSE so VDUSE can get rid of the DMA API
completely.

Please review.

Thanks

Changes since V6:

- Typo fixes

Jason Wang (2):
  vdpa: introduce map ops
  vduse: switch to use virtio map API instead of DMA API

 drivers/vdpa/Kconfig                     |  8 +--
 drivers/vdpa/alibaba/eni_vdpa.c          |  3 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |  3 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 +-
 drivers/vdpa/pds/vdpa_dev.c              |  3 +-
 drivers/vdpa/solidrun/snet_main.c        |  4 +-
 drivers/vdpa/vdpa.c                      |  3 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.c     |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.h     |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       | 79 ++++++++++++------------
 drivers/vdpa/virtio_pci/vp_vdpa.c        |  3 +-
 drivers/virtio/virtio_vdpa.c             |  4 +-
 include/linux/vdpa.h                     | 10 ++-
 include/linux/virtio.h                   |  4 ++
 16 files changed, 74 insertions(+), 62 deletions(-)

-- 
2.31.1

