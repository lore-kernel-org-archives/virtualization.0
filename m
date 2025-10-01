Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C52C3770
	for <virtualization@lists.linux-foundation.org>; Wed,  1 Oct 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318328; cv=none; b=H8ATVMPcIpy9vykb2n93I7WlOCy71d75mHXJYwiKg/NKsWJWx2kzznG+E/b0EURiObszCxUvW+w9GNU48muQMvSqbepy0YxUhU3ZD83XHwWlQz4so879CwdGBVMj5SaX2dQdxyfGYg8gvM+IdSdnW3+z5DtKgpXYFrsufdJCiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318328; c=relaxed/simple;
	bh=E8TP+jTXRnR5ypNl9rTKJR9W/tHyfS8KQ+ykqiS8ARQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hQSH4oPQTUOW4NgAX/2nrZxKTilBwK59od9fOUxdJnWtVyDoJ5enlTbemF4EQLNoxYT+eQQVH9mkYR6Zf8U8NqHG3bUvq2YuLQ4J4doTo6EPJowW3NOVUT4hJWA3RPNTAXKP/Ba37UEzk+SOwddhBL3q2OQzLhuJMZF3uv2Ygdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2+f/SDI; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2+f/SDI"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D90C61324
	for <virtualization@lists.linux-foundation.org>; Wed,  1 Oct 2025 11:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GWXIgLRqFrSV for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Oct 2025 11:32:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0EE476127A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EE476127A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h2+f/SDI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EE476127A
	for <virtualization@lists.linux-foundation.org>; Wed,  1 Oct 2025 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759318324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iJSRuteQOX9gctlwdxDghNzdOhBrLQto5XenHeU3Vv8=;
	b=h2+f/SDI1lFKzHj2ZfTwofW0QajYgPX4oS0J/GF+mmXbdq+mQcy/x8xt4Gqdc3iQchcYgG
	s3K3t7iiVK/JiU590XAwmaopfOdDG+eXE9wSrcxE0yQtp1FbB1K5ks2qPH7oeQUCb0jHjv
	ksiHdp5DHH9BQE1G9ew9RZZgQ45xMtQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-3LudyXJ1PMO59TxQaKwnLw-1; Wed, 01 Oct 2025 07:32:03 -0400
X-MC-Unique: 3LudyXJ1PMO59TxQaKwnLw-1
X-Mimecast-MFC-AGG-ID: 3LudyXJ1PMO59TxQaKwnLw_1759318322
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so55606845e9.3
        for <virtualization@lists.linux-foundation.org>; Wed, 01 Oct 2025 04:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318322; x=1759923122;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJSRuteQOX9gctlwdxDghNzdOhBrLQto5XenHeU3Vv8=;
        b=baHqpOsMGHlsD6qHsW7jRte+Yr3S+d+MUNoGTJQc5HTW0MDDAPBnzR0gA0C192XVQN
         4MSEkCbisiOaM+VK8htcT2sGXEbbYJmbHMfQ4u721eO/+FvAFXTSgsfRzXb9aHXeIUwc
         mx0hQ8Jzwhv8zKUKJuflO2k9Y+7ioukDTZs3FoSz4HzUwr023X/z/2LXmhw1b4tTYJKl
         Fdyr/HnpHvfKfRj/dixNIYfOhJqr9bKrUyPp0VEEaBhyX/uIUte4DKW6IJ28d0W67Yaw
         13Y+enajsdOPduJ/7Ee0f6ycaoJ9jb+c01UwuCQrBnm5UYq+nkyUWG4mzq2dgMzqKeyj
         p3eg==
X-Forwarded-Encrypted: i=1; AJvYcCVWmguoXvXSaTqmF1TzDEtHhZXGm96p8kLVlIRa30obKxGFadit+U9teZHsoOJvOgNV272g3ylwPl4fRvmA2g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxgK1MGooFpf9tU74Y7yQ4Julfl3lqAT8OzcynHrR1zroIh+ums
	rtb7ou+xO8oR5CnmJnh468VxF6O6JiVp76O6Q+AIKfIVr4ENISuSr2d2NpVhMt+L8Vb2SYtEOIV
	toaU1TVGPeAasnKBwUkIL3u/YpD4LyHBIjrPpthZ5tEiGslbEQzbe2OXXk3N9DfgZy08xaub63z
	S8KPqewp0=
X-Gm-Gg: ASbGncuq2RIU015KgTnfRfJsBNgqJQN9wk1DgeUMChHB5WPFaEVNmgWvH5gmWwkjUK9
	gauFDOG5niHe2GV3tn4cv3TfP+9d30hpHs3GondKEme3+/MeFl1itIhPIQkgiTVghtIMZfGVAqW
	h/H6tG3vRwt/ihltnAjxWlGiaNDszrk2dY/TqmOYr6apOi3kEgBIVj0JXvMzmQZYbGeunwL15G8
	V4zJwCafj1Pb+67H8tJsstbdYaxwqo372s4V+RPNV4veagnz7m1KvtALBTiYAhSkVlPjZ7vmS+g
	e8ORrVRe3bSB2AuXxJlHIwlbN//4LJUry6Ozoj0=
X-Received: by 2002:a05:600c:45d0:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-46e612bc7f7mr25101225e9.18.1759318321580;
        Wed, 01 Oct 2025 04:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGstrQbPl2ux574MZQ5paDC88d3YGXhrfcZSAq6ToKm0J+thPm2S97lL7iQ8LvaDhELHu4bFA==
X-Received: by 2002:a05:600c:45d0:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-46e612bc7f7mr25100985e9.18.1759318320967;
        Wed, 01 Oct 2025 04:32:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c3b75sm34870125e9.7.2025.10.01.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:32:00 -0700 (PDT)
Date: Wed, 1 Oct 2025 07:31:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, leiyang@redhat.com, mst@redhat.com,
	rongqianfeng@vivo.com, sgarzare@redhat.com,
	sheng.zhao@bytedance.com, zhangjiao2@cmss.chinamobile.com,
	zhao.xichao@vivo.com
Subject: [GIT PULL] virtio,vhost: fixes, cleanups
Message-ID: <20251001073158-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N9WkeH91Kut9I7fkiSBvNZ3n413znJVaV1CJMPCNbg0_1759318322
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e5f0a698b34ed76002dc5cff3804a61c80233a7a:

  Linux 6.17 (2025-09-28 14:39:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to ed9f3ab9f3d3655e7447239cac80e4e0388faea8:

  virtio-vdpa: Drop redundant conversion to bool (2025-10-01 07:24:55 -0400)

----------------------------------------------------------------
virtio,vhost: fixes, cleanups

Just fixes and cleanups this time around.  The mapping cleanups are
preparing the ground for new features, though.
In order patches were almost there but I feel they didn't
spend enough time in next yet.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (9):
      virtio_ring: constify virtqueue pointer for DMA helpers
      virtio_ring: switch to use dma_{map|unmap}_page()
      virtio: rename dma helpers
      virtio: introduce virtio_map container union
      virtio_ring: rename dma_handle to map_handle
      virtio: introduce map ops in virtio core
      vdpa: support virtio_map
      vdpa: introduce map ops
      vduse: switch to use virtio map API instead of DMA API

Michael S. Tsirkin (1):
      vhost: vringh: Fix copy_to_iter return value check

Qianfeng Rong (1):
      virtio_balloon: Remove redundant __GFP_NOWARN

Sheng Zhao (1):
      vduse: Use fixed 4KB bounce pages for non-4KB page size

Xichao Zhao (1):
      virtio-vdpa: Drop redundant conversion to bool

zhang jiao (1):
      vhost: vringh: Modify the return value check

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
 drivers/vdpa/vdpa_user/iova_domain.c     | 132 ++++++---
 drivers/vdpa/vdpa_user/iova_domain.h     |   7 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  79 +++---
 drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
 drivers/vhost/vdpa.c                     |   6 +-
 drivers/vhost/vringh.c                   |  14 +-
 drivers/virtio/virtio_balloon.c          |   2 +-
 drivers/virtio/virtio_ring.c             | 459 +++++++++++++++++++------------
 drivers/virtio/virtio_vdpa.c             |  22 +-
 include/linux/vdpa.h                     |  25 +-
 include/linux/virtio.h                   |  46 +++-
 include/linux/virtio_config.h            |  72 +++++
 include/linux/virtio_ring.h              |   7 +-
 24 files changed, 635 insertions(+), 334 deletions(-)

