Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E760214809
	for <virtualization@lists.linux-foundation.org>; Mon, 31 Mar 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438855; cv=none; b=UX69VPBQ/AfSdxYiuSQY94GkX7TaRTiQnnXsRMu915I0jXLOi/k6zTAJAplhpXQ3JDDIULh0IfE8JmczqD6OhHoR8fqRv41xS3EtHq1nKFWWI1FyHd+gjyusCKBRH6ivCXvYcg/sUzIazkJ5A3prosepiQU9aMXt+yIa9zljRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438855; c=relaxed/simple;
	bh=LyymiZcnvyCARp+PZ9YDJ/WjZzd+um0odXUXVVG8jWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TAA3vbZ1pAnEw2nqTpRMfX/dOqy2vgBSeby1SL9mp/rkH9VO18n/nPVWX+x0W3ATaUKZmtP3TrIDw1o31o84AXqoXJ4GfKEPprfnUvRTsqlIG/gXW9dyjOQhSlfpySubFqg0ynvmt+TJeBJYcLfjxLqKf1kB/AUZXuQvBWtJ01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UF4MBujQ; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UF4MBujQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F64460855
	for <virtualization@lists.linux-foundation.org>; Mon, 31 Mar 2025 16:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pna9ORuc1_ui for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Mar 2025 16:34:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F9C96076D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F9C96076D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UF4MBujQ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F9C96076D
	for <virtualization@lists.linux-foundation.org>; Mon, 31 Mar 2025 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743438851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=buRU4hcgPy2p/+OGQ7gQUBzV/bybYL5hkzFKdPTt7bo=;
	b=UF4MBujQ8sYrKPxc2J3IpGdlRIFP2AACCveL1IlsBvhYMcB+u05jWbewIBW8THsrMz1QXr
	R7mnTUYfZ57DFTHIzOV+SOFu8kH4VBjTBsOv2xYzq8jhEjzBOQNqc5WyZbZSynRzfASiN1
	VJS967WZi5sZtc4Y45RZo6AwTmh5d/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-jhKQwZgbP9KZ4oT95UYzlA-1; Mon, 31 Mar 2025 12:34:09 -0400
X-MC-Unique: jhKQwZgbP9KZ4oT95UYzlA-1
X-Mimecast-MFC-AGG-ID: jhKQwZgbP9KZ4oT95UYzlA_1743438849
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so44762915e9.3
        for <virtualization@lists.linux-foundation.org>; Mon, 31 Mar 2025 09:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743438848; x=1744043648;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buRU4hcgPy2p/+OGQ7gQUBzV/bybYL5hkzFKdPTt7bo=;
        b=XU6nCz98Wda2BdecwPxk8wb6AHgA+SfOzUBN9Yfm/bMqFMGwtUS7a2ighze/K84OrP
         o0otvSTzqzWIKQVkg3ILN5Gl7Dy5DCDBsYBriupD+jCGARb8Ib3QGhr7VK0I+YGlRu7w
         YSL1fVkr9uile9Hy2wuSfpqz1vyNfqSAr11S3euaCK3O31ENHxMx+VKiJyOCIN903o3x
         aP3slGvbpGcYAv7553/X18AcYxNzE1uOL9ubf800cs1vzRWIROL7e+q5AIy/MCpqQFEw
         GpBSsul0UrJyWvDvUfroFcQj3jG/SzyyQ6KpdZ3aOIE2KDdxQ78cFcoFRaZXk1ekKqc/
         yAVg==
X-Forwarded-Encrypted: i=1; AJvYcCVbJ3F7J/x5pbnX8qVNOIsQc7BYCJmz2K1mgjQ0lVJHuqSmyNy86ibGWxtoFT3tUOzv6v6jMPjJY8jrzR2baA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw5R2pP4gJkNycsfseyz75wauQ/kW0zumhUGKNl3a4SgT9m+cQ9
	XW90dv+e0Vz71qEvJHpvKIW+lO1lO8pQCRSKuWQqx4JBA4krsc5Vpaxiq6sagLy/0tpiF9XG+Vy
	SXer/oFNKfBiX6/gf/5AlrQPSgVLZCot8qaMDQDTzwJASIuW2pv7Nbuy0dH35A8xFmpszh2DcjP
	czRcA=
X-Gm-Gg: ASbGncsMlbwE5ivh5wwodJvppmsSdbVVCbqHQ6dLeOfbZyMq4cPeF5qaLsHXiM8D1Vt
	Oqnhh63L0TCO03egGlFv/ubNd2FURN20qqcDKxRHlJGUY2WXQxCZulFlfKbazhcPRB0/e9Y8JtZ
	jHtEF40WBOGzTJBnpY08Z0vFlLyFWVpyKSZa2DHLY5nyA0Wcmcn7Qrb9DfKP9ktfj9GN0qu9ock
	ifSWxZmUIU+KfTYDFU1q++jPkmrz8s2HKdmC+zVVj2hZISHS1isBXG7V2k4wbpB2PNhPosg/iV7
	MLQlQpSRQw==
X-Received: by 2002:a05:600c:8117:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-43e8e3cf858mr88891525e9.16.1743438848574;
        Mon, 31 Mar 2025 09:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRJoF9PNksiJNrRvv1RABMA+H1wRnu+cFNlckFr23sh4bFVTCISuxXvKws13VYTTCpsWyCEA==
X-Received: by 2002:a05:600c:8117:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-43e8e3cf858mr88891065e9.16.1743438848107;
        Mon, 31 Mar 2025 09:34:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efeb11sm171403855e9.22.2025.03.31.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 09:34:07 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:34:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	anton.yakovlev@opensynergy.com, bettyzhou@google.com,
	cong.meng@oracle.com, dtatulea@nvidia.com, eauger@redhat.com,
	eperezma@redhat.com, eric.auger@redhat.com,
	hongyu.ning@linux.intel.com, jasowang@redhat.com,
	jstultz@google.com, kernel-team@android.com, kshk@linux.ibm.com,
	linux-sound@vger.kernel.org, michael.christie@oracle.com,
	mst@redhat.com, perex@perex.cz, sgarzare@redhat.com,
	si-wei.liu@oracle.com, stable@vger.kernel.org, stefanha@redhat.com,
	tiwai@suse.com, virtualization@lists.linux.dev,
	wangyufeng@kylinos.cn, wh1sper@zju.edu.cn
Subject: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20250331123404-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B3Hpu8gLbVdvchdWr-XjiNBo_HiKse-3OaFy_OKu_V8_1743438849
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 9d8960672d63db4b3b04542f5622748b345c637a:

  vhost-scsi: Reduce response iov mem use (2025-02-25 07:10:46 -0500)

----------------------------------------------------------------
virtio: features, fixes, cleanups

A small number of improvements all over the place:

shutdown has been reworked to reset devices.
virtio fs is now allowed in vduse.
vhost-scsi memory use has been reduced.

cleanups, fixes all over the place.

A couple more fixes are being tested and will be merged after rc1.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eugenio Pérez (1):
      vduse: add virtio_fs to allowed dev id

John Stultz (1):
      sound/virtio: Fix cancel_sync warnings on uninitialized work_structs

Konstantin Shkolnyy (1):
      vdpa/mlx5: Fix mlx5_vdpa_get_config() endianness on big-endian machines

Michael S. Tsirkin (1):
      virtio: break and reset virtio devices on device_shutdown()

Mike Christie (9):
      vhost-scsi: Fix handling of multiple calls to vhost_scsi_set_endpoint
      vhost-scsi: Reduce mem use by moving upages to per queue
      vhost-scsi: Allocate T10 PI structs only when enabled
      vhost-scsi: Add better resource allocation failure handling
      vhost-scsi: Return queue full for page alloc failures during copy
      vhost-scsi: Dynamically allocate scatterlists
      vhost-scsi: Stop duplicating se_cmd fields
      vhost-scsi: Allocate iov_iter used for unaligned copies when needed
      vhost-scsi: Reduce response iov mem use

Si-Wei Liu (1):
      vdpa/mlx5: Fix oversized null mkey longer than 32bit

Yufeng Wang (3):
      tools/virtio: Add DMA_MAPPING_ERROR and sg_dma_len api define for virtio test
      tools: virtio/linux/compiler.h: Add data_race() define.
      tools: virtio/linux/module.h add MODULE_DESCRIPTION() define.

 drivers/vdpa/mlx5/core/mr.c        |   7 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |   3 +
 drivers/vdpa/vdpa_user/vduse_dev.c |   1 +
 drivers/vhost/Kconfig              |   1 +
 drivers/vhost/scsi.c               | 549 +++++++++++++++++++++++--------------
 drivers/virtio/virtio.c            |  29 ++
 sound/virtio/virtio_pcm.c          |  21 +-
 tools/virtio/linux/compiler.h      |  25 ++
 tools/virtio/linux/dma-mapping.h   |  13 +
 tools/virtio/linux/module.h        |   7 +
 10 files changed, 439 insertions(+), 217 deletions(-)

