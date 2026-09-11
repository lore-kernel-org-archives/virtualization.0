Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109A35E1AD
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161614; cv=none; b=QIaIr+kAHIcbT9fq+PnBz9J9bhFQggrAv/9HCy9Xa3CnbtGMqIcgYecbwi227a35QqqfICdBRfJOA+LbOMe90Fp8VzDQjrz23d3q2Ib0tbAlPlRrxFczdbXI0g7qVmzPMvInOrHs1rmqmKt8m2eehXCoASjPIdy22v4A8gHBKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161614; c=relaxed/simple;
	bh=/9FF5fmnYmsdPuZ3HFtP7Y+pDjKKXbLbEbhwpauKOXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AM5G4AagpqbTl+cn5/DKbgmC/tDMG+g9McBhIXT43z/eHinqufcQrLtKVfe4rYTYFZKrJ2qSJZmxa11byv7O9xiyXEzCAHnj2Cu0ZbTg5KOVdsHvXi8xoR6HUTKdjC6Sj1nDWyij81XMwLpC4Qdkh7mZQX/NHdGKBEXkE3k5o58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eunEb5m5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eunEb5m5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789161612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pV7huyjZiJZG4cWVrdUKjI6VdJ9E0y5yBTEYPT1U8tw=;
	b=eunEb5m5Y3iXD4C1geqrRdAyp2+DYeFC0pT/laXc0xZ+malAmD4z703tMXG6qylNDr4x+w
	8K4CcadkrgaPKfM6MGy0UJdztz8v07qLrzjDMKi801YGcQcAUl7uO8OBgaAFGeKoveKyE+
	xyUEIGYIxSSYbpT6TodUZsdJNXbvBnE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-vy47lAnDPyiEkwCol0reYA-1; Fri, 11 Sep 2026 17:20:10 -0400
X-MC-Unique: vy47lAnDPyiEkwCol0reYA-1
X-Mimecast-MFC-AGG-ID: vy47lAnDPyiEkwCol0reYA_1789161610
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cf4cc2125so5939435e9.2
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 14:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161610; x=1789766410;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pV7huyjZiJZG4cWVrdUKjI6VdJ9E0y5yBTEYPT1U8tw=;
        b=L3G+IAXXUnKWoGuovU0ewVDATpbNwZNjtltARC3YXHF13Qaf6xlXUpXCSEPAfe/Ag2
         B2Te2A7ZUqX8hDoFPWR9cld8xb/iOd9HTd6KhwsHrCtPDa6KRCDgIeK4tU97xQO/eTm6
         C/kzAWKuv5ef8ZQ8E9nriEVNnsv0jBG+0pKSi2F8zNqXTt2p2a5NSIx1z6teh17Ty//d
         boDcYZD9A6rgJBhSmPd90tt4gxgTnvk20dCbFX3LqabMygSyj29p9qL6xTrMZdI7Pu8J
         wByy3obVqCO7f9NhqzdQ/lckQl4cX67ZXjxLtEgaAOANV3JjjbxRYNiTnskbC2mRKrAQ
         D/1A==
X-Gm-Message-State: AFuF++lFqwxd1wUxa5mY1k2M+X3YKj5Z1aYGxCqcnTbZ1mDmoqDfOise
	RvKdjmEo7UuvfWnyvFvEZgyU3LJ0/ftyDMgq70MwQY3dh2NJEwqzQo+wdAMn1sXZAi+JXurq3tO
	vTgg8rrvH/iakYyCI/gzmrshVfg8+8uXxfc0nbkBLRVQz4Ij5zHtoji4s+xQTZwwj1onIBbGlAC
	8rZXcER+DxJ95QQFN6/gK5l80wLG8EIKMFV9VJgEWZ/8fE3g==
X-Gm-Gg: AYBFou1IRFN5r91RiOR9h0MQVz8oIt1GVhARSoR9EwuFPmEg1iosJtg7X/WVqTrVWwO
	e4xWqzMWuNNWuwmfQU5ZHYj3P0wEscrH/ZkgqOn5aM3v6Zort2OsVYwO23novAb3zs5A4VBGzcv
	tEaobKi1wk1P1sKvM5GJxV1GXVIOWucZ1rI2Aqu5NI0CyH6JXi28Va70TESrDkyqNmrHK3cdDEu
	8i7+AdaGIfWGBwvd9HTfMMdYH8lZLwZcxeolHRfxFZcbD0NTpyT3HSvtBd6lS7hTPr/3DUG8kzF
	9qC7UVXccDEzl/g7G6VVC5AUWY9KYLL3GUDUhjs6nyBcyKVdCDX/7UAh5f953zWOPWw=
X-Received: by 2002:a05:600c:c493:b0:49d:2607:4ada with SMTP id 5b1f17b1804b1-49e619bf31cmr119115805e9.14.1789161609648;
        Fri, 11 Sep 2026 14:20:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:49d:2607:4ada with SMTP id 5b1f17b1804b1-49e619bf31cmr119115275e9.14.1789161609057;
        Fri, 11 Sep 2026 14:20:09 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49db038401fsm181919475e9.13.2026.09.11.14.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:20:08 -0700 (PDT)
Date: Fri, 11 Sep 2026 17:20:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtualization@lists.linux.dev
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	jiri@resnulli.us, kmehltretter@gmail.com, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] virtio: fix callback synchronization and avq cleanup
 on reset
Message-ID: <cover.1789160982.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QwNkK9OLQJ3fbJQ4G8af5mD3xKdvPqBbzTsV8aiTuyw_1789161610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Two issues with virtio device reset:

1. Karl Mehltretter reported that virtio_reset_device() promises
   callbacks are not in progress after reset, but only PCI transports
   actually synchronize callbacks - other transports leave a window
   where a handler already executing keeps running while the driver
   tears down state.

2. sashiko reported a race in virtio_pci_modern: the avq interrupt
   handler calls virtqueue_get_buf concurrently with
   virtqueue_detach_unused_buf in vp_modern_avq_cleanup, and there
   is no synchronize_irq between reset and cleanup.

Fix 1 by adding virtio_synchronize_cbs in the core after reset,
then dropping the now-redundant per-transport sync calls. Fix 2 by
moving avq cleanup from vp_reset to vp_del_vqs, which runs after
callbacks have been synchronized - and is where buffer teardown
conceptually belongs.

Changes v2->v3:
    patch 1: unchanged
    patch 2: split from v2 patch 2 - legacy part only
    patch 3: new - v2 just dropped the sync from modern vp_reset,
        leaving avq_cleanup there before the removed sync. v3
        moves avq_cleanup out of vp_reset entirely into vp_del_vqs,
        fixing the race. Adds NULL check for admin_vq.info needed
        because find_vqs error paths call vp_del_vqs before it is
        allocated.

Michael S. Tsirkin (3):
  virtio: synchronize callbacks after device reset
  virtio_pci_legacy: drop callback sync on reset
  virtio_pci_modern: move avq cleanup from reset to del_vqs

 drivers/virtio/virtio.c            |  2 ++
 drivers/virtio/virtio_pci_common.c |  2 ++
 drivers/virtio/virtio_pci_common.h |  1 +
 drivers/virtio/virtio_pci_legacy.c |  2 --
 drivers/virtio/virtio_pci_modern.c | 10 ++++------
 5 files changed, 9 insertions(+), 8 deletions(-)

-- 
MST

