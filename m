Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D061C6AB
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFshD34x"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D84A56112B
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 16:28:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D84A56112B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFshD34x
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8JMEGOOGy1oh
	for <virtualization@lists.linux-foundation.org>;
	Tue, 16 Jan 2024 16:28:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D824B61039
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 16:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D824B61039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705422515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OF/f9SqDfQjcSElQnS0yY6s/dBYlZKzDcj9s0+Wh2f8=;
	b=AFshD34x282Vr2XmVuuol3SNpEAG6rMqPLhY8aAXX/LlXI8gfsXuMOHjA3525reUltdZzN
	HypDg1CmjjPSN/eso24bvkIXSex0LpHfCQNjpL/SqBEHlYhPeUAn74QGRZw9OKZX0kdo9e
	scVvruX6mK1zQAkbBJVDABMYsWtEhYM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-zHqw-oHiOdWak2xEpCMK_Q-1; Tue, 16 Jan 2024 11:28:33 -0500
X-MC-Unique: zHqw-oHiOdWak2xEpCMK_Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e74771019so18313465e9.3
        for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 08:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705422512; x=1706027312;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OF/f9SqDfQjcSElQnS0yY6s/dBYlZKzDcj9s0+Wh2f8=;
        b=UDx2h2Cy/wa6qLk6Ku/ct8Pk9NpeAiZFruLXkY3gCMUEQ46jY9Q51T7KhgRWaz2EVK
         ntr/rUZkwr7Ecm3TqNpbhku5mExLEF24KbVTv3Hov87VL6DQyYSkhzkmq/1fRgymnNyE
         fhYixtEXRFSzmPNXMT9jzNqx5FwWYjHz4WP5Brigo8mMzdO/xnxV3TaCJ4BkMFEqG6Mo
         231eSUsvxEDKedKatAwLZtjHQbblRuy5ME3DLUsKUouzuIDo/upWp5qNcagrrwSRoPRA
         qaCS8UpwOlgPFbbi5IOS6A55htEDKucO04XF09l4zLu5rKUCnLFxXjs/MEwg/gh8j+xY
         k/fg==
X-Gm-Message-State: AOJu0YxaXPhsuaJZ8VtOuVF4nLhCmplQKAYTQxOF9UH2QdCZGq9mfroE
	AgCGSYYQ2NBQvSFTvlzte0shrHzpyUaxqOh6HHGpdLbAu3A5fNgT31ZHJTKW3mJpIhiTzZ4oVjM
	o9OLXOa3zrN0XwFfSXA4GjUbw6AHOfzBEcwPoHTsiFVu2+gJTpQ==
X-Received: by 2002:a05:600c:257:b0:40e:7e40:10c6 with SMTP id 23-20020a05600c025700b0040e7e4010c6mr739611wmj.182.1705422512777;
        Tue, 16 Jan 2024 08:28:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4EwY4rnvc1dXkvUnzrtlQb0sW9f8GFlzYKtabODe5zsH9sA7U7cGUZRKyhXjVGQXqLCiWCQ==
X-Received: by 2002:a05:600c:257:b0:40e:7e40:10c6 with SMTP id 23-20020a05600c025700b0040e7e4010c6mr739594wmj.182.1705422512444;
        Tue, 16 Jan 2024 08:28:32 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e3733a32bsm23560519wmb.41.2024.01.16.08.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:28:31 -0800 (PST)
Date: Tue, 16 Jan 2024 11:28:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	changyuanl@google.com, christophe.jaillet@wanadoo.fr,
	dtatulea@nvidia.com, eperezma@redhat.com, jasowang@redhat.com,
	michael.christie@oracle.com, mst@redhat.com,
	pasha.tatashin@soleen.com, rientjes@google.com,
	stevensd@chromium.org, tytso@mit.edu, xuanzhuo@linux.alibaba.com
Subject: [GIT PULL] virtio: features, fixes
Message-ID: <20240116112828-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b8e0792449928943c15d1af9f63816911d139267:

  virtio_blk: fix snprintf truncation compiler warning (2023-12-04 09:43:53 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to f16d65124380ac6de8055c4a8e5373a1043bb09b:

  vdpa/mlx5: Add mkey leak detection (2024-01-10 13:01:38 -0500)

----------------------------------------------------------------
virtio: features, fixes

vdpa/mlx5: support for resumable vqs
virtio_scsi: mq_poll support
3virtio_pmem: support SHMEM_REGION
virtio_balloon: stay awake while adjusting balloon
virtio: support for no-reset virtio PCI PM

Fixes, cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changyuan Lyu (1):
      virtio_pmem: support feature SHMEM_REGION

Christophe JAILLET (2):
      vdpa: Fix an error handling path in eni_vdpa_probe()
      vdpa: Remove usage of the deprecated ida_simple_xx() API

David Stevens (2):
      virtio: Add support for no-reset virtio PCI PM
      virtio_balloon: stay awake while adjusting balloon

Dragos Tatulea (10):
      vdpa: Track device suspended state
      vdpa: Block vq property changes in DRIVER_OK
      vdpa/mlx5: Expose resumable vq capability
      vdpa/mlx5: Allow modifying multiple vq fields in one modify command
      vdpa/mlx5: Introduce per vq and device resume
      vdpa/mlx5: Mark vq addrs for modification in hw vq
      vdpa/mlx5: Mark vq state for modification in hw vq
      vdpa/mlx5: Use vq suspend/resume during .set_map
      vdpa/mlx5: Introduce reference counting to mrs
      vdpa/mlx5: Add mkey leak detection

Mike Christie (1):
      scsi: virtio_scsi: Add mq_poll support

Pasha Tatashin (1):
      vhost-vdpa: account iommu allocations

Xuan Zhuo (1):
      virtio_net: fix missing dma unmap for resize

 drivers/net/virtio_net.c           |  60 +++++------
 drivers/nvdimm/virtio_pmem.c       |  36 ++++++-
 drivers/scsi/virtio_scsi.c         |  78 +++++++++++++-
 drivers/vdpa/alibaba/eni_vdpa.c    |   6 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  10 +-
 drivers/vdpa/mlx5/core/mr.c        |  73 ++++++++++---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 209 +++++++++++++++++++++++++++++++++----
 drivers/vdpa/vdpa.c                |   4 +-
 drivers/vhost/vdpa.c               |  26 ++++-
 drivers/virtio/virtio_balloon.c    |  57 ++++++++--
 drivers/virtio/virtio_pci_common.c |  34 +++++-
 include/linux/mlx5/mlx5_ifc.h      |   3 +-
 include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
 include/uapi/linux/virtio_pmem.h   |   7 ++
 14 files changed, 510 insertions(+), 97 deletions(-)

