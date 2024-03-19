Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D375473F
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834117; cv=none; b=nm5rNlH+ji1PqpUZGWMtVqz9QDQ9gwL03yhC3kQGhSQSpj1JpPdGQuhaxgH4J+n6GxDL4uEFbgsozoEj29GJZVfpBhoCq18Wqx5ispPwQ4JjLnHe3P0E9mo8Yi1D+gv36aVhiLkiZkHc0Yrl2fddS4VmV4Sh9QdcFt6Yg2A//3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834117; c=relaxed/simple;
	bh=2crLoEVLnwiq99cE6HQUHEb+ylseepzZNYcoRSHN6zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AFVa0cZlUeztJJJ4nbBIezmAYUZ5oUVtRYGxLGVMaBcglmbj6Qr9xASfWXAq2YpKiseUI3moKndHXj70M2ewkPIe6Q9DkHDcFXLj4FZImYbVJHneTvganvK14dxGqSQOJRC/kNp9RiA0Fd99OXo1MJXddIu1/6XD2KCTgAp89hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uu+P8N19; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uu+P8N19"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D29AF81764
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 07:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Woj9xehJ0-r8
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Mar 2024 07:41:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 99A208146E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99A208146E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uu+P8N19
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 99A208146E
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 07:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710834113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sTsSPri+D6Wdelir2mIVSESP1KmjuvB/LjDkRovj8pE=;
	b=Uu+P8N19DBOsip+SS2CDg3oLJDUyn5kdE1ttiBF3zMB7oOD505ERiBlLSy51Tya0GyP5Nh
	zaQ9bXHWtZYWUqYyqkA+tVO1kmOSJTTdGCZaDhpPCguddB1ZmwOQGFcTs9uyAQXExC8xZK
	FMFbH9JoHXZk1BwNXxFs/LIVOH52fAI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-k8uhEfIXNMqZzbwPwDKVAg-1; Tue, 19 Mar 2024 03:41:49 -0400
X-MC-Unique: k8uhEfIXNMqZzbwPwDKVAg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ed22facfeso2055353f8f.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 00:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710834109; x=1711438909;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTsSPri+D6Wdelir2mIVSESP1KmjuvB/LjDkRovj8pE=;
        b=X6iqRXFe9ZlqZobDLsyLSzsS6XRB3kkRHvegYT0AnfbYEbOeiNDA83YFm9eFLmQIuZ
         qfuhhbStj+BeM5ZyMBDaNtIWvXSL9rl3k8UphbdWpdv0NAi2AxNi3t0NeQ24GGFfVlHA
         kcVuORo7wp2dHRs8tggpTSLM9/FbTGiNBw097FXalubFmNrKduT/CjDE+dg1FmiQR7mx
         dPMIG9i1mVVZ+SJzsalH2ksWHFeOIVyoqUNt8r2ZcYjll/T7/4QxcdzHx9wPQDDNunnY
         Tu3TjpAHYN12R0OVqDY4g5AY8SP8/tyw/uyqIYz4Mfx/w0KLhU7TktMftY8RtcjDbn6G
         eKJg==
X-Forwarded-Encrypted: i=1; AJvYcCWp3pUW5tUI1QDCJdGNnrMY6T0ddzOs6RufhtI7lh/vqPY5RoopRzEkNdGBCivSTGnTeNifjsQ9R7OLuB4rCw5HLjiLRSZDSVDaviqaAuOE9UnmJLAGenfxsA==
X-Gm-Message-State: AOJu0YxnSaD1WbcsgtH8Lq0zfI3Z61Ofqk+G8paCavlKmgkwcCxTqEBn
	ud7qhsaUVF3GPH0W+7rEjHl9yOzRJs/ElAoUZ5plP5q0ZMCFfOhdOLxowJ25zQpveCO6E2s5xzJ
	h9De+0YbEP+S8eSkypHwWJ5nOcA31gVQUFt7H98NOMlb9w7XWuSsxgx8kql0yrjtdSFO0TUhJAk
	Msjfk=
X-Received: by 2002:a5d:4e11:0:b0:33e:7adc:516c with SMTP id p17-20020a5d4e11000000b0033e7adc516cmr10534530wrt.57.1710834108687;
        Tue, 19 Mar 2024 00:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAK2WGJat4vmdPSy7ECLAOOCSKt1cm0uCh7BMlmPoT49BMQqI0q9+XAAprgAMQmNyXP8ysuQ==
X-Received: by 2002:a5d:4e11:0:b0:33e:7adc:516c with SMTP id p17-20020a5d4e11000000b0033e7adc516cmr10534503wrt.57.1710834108096;
        Tue, 19 Mar 2024 00:41:48 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d42d2000000b0033e456f6e7csm11781382wrr.1.2024.03.19.00.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:41:47 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:41:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com, andrew@daynix.com, david@redhat.com,
	dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com,
	gregkh@linuxfoundation.org, jasowang@redhat.com,
	jean-philippe@linaro.org, jonah.palmer@oracle.com,
	leiyang@redhat.com, lingshan.zhu@intel.com,
	maxime.coquelin@redhat.com, mst@redhat.com, ricardo@marliere.net,
	shannon.nelson@amd.com, stable@kernel.org,
	steven.sistare@oracle.com, suzuki.poulose@arm.com,
	xuanzhuo@linux.alibaba.com, yishaih@nvidia.com
Subject: [GIT PULL] virtio: features, fixes
Message-ID: <20240319034143-mutt-send-email-mst@kernel.org>
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

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5da7137de79ca6ffae3ace77050588cdf5263d33:

  virtio_net: rename free_old_xmit_skbs to free_old_xmit (2024-03-19 03:19:22 -0400)

----------------------------------------------------------------
virtio: features, fixes

Per vq sizes in vdpa.
Info query for block devices support in vdpa.
DMA sync callbacks in vduse.

Fixes, cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Andrew Melnychenko (1):
      vhost: Added pad cleanup if vnet_hdr is not present.

David Hildenbrand (1):
      virtio: reenable config if freezing device failed

Jason Wang (2):
      virtio-net: convert rx mode setting to use workqueue
      virtio-net: add cond_resched() to the command waiting loop

Jonah Palmer (1):
      vdpa/mlx5: Allow CVQ size changes

Maxime Coquelin (1):
      vduse: implement DMA sync callbacks

Ricardo B. Marliere (2):
      vdpa: make vdpa_bus const
      virtio: make virtio_bus const

Shannon Nelson (1):
      vdpa/pds: fixes for VF vdpa flr-aer handling

Steve Sistare (2):
      vdpa_sim: reset must not run
      vdpa: skip suspend/resume ops if not DRIVER_OK

Suzuki K Poulose (1):
      virtio: uapi: Drop __packed attribute in linux/virtio_pci.h

Xuan Zhuo (3):
      virtio: packed: fix unmap leak for indirect desc table
      virtio_net: unify the code for recycling the xmit ptr
      virtio_net: rename free_old_xmit_skbs to free_old_xmit

Zhu Lingshan (20):
      vhost-vdpa: uapi to support reporting per vq size
      vDPA: introduce get_vq_size to vdpa_config_ops
      vDPA/ifcvf: implement vdpa_config_ops.get_vq_size
      vp_vdpa: implement vdpa_config_ops.get_vq_size
      eni_vdpa: implement vdpa_config_ops.get_vq_size
      vdpa_sim: implement vdpa_config_ops.get_vq_size for vDPA simulator
      vduse: implement vdpa_config_ops.get_vq_size for vduse
      virtio_vdpa: create vqs with the actual size
      vDPA/ifcvf: get_max_vq_size to return max size
      vDPA/ifcvf: implement vdpa_config_ops.get_vq_num_min
      vDPA: report virtio-block capacity to user space
      vDPA: report virtio-block max segment size to user space
      vDPA: report virtio-block block-size to user space
      vDPA: report virtio-block max segments in a request to user space
      vDPA: report virtio-block MQ info to user space
      vDPA: report virtio-block topology info to user space
      vDPA: report virtio-block discarding configuration to user space
      vDPA: report virtio-block write zeroes configuration to user space
      vDPA: report virtio-block read-only info to user space
      vDPA: report virtio-blk flush info to user space

 drivers/net/virtio_net.c             | 151 +++++++++++++++---------
 drivers/vdpa/alibaba/eni_vdpa.c      |   8 ++
 drivers/vdpa/ifcvf/ifcvf_base.c      |  11 +-
 drivers/vdpa/ifcvf/ifcvf_base.h      |   2 +
 drivers/vdpa/ifcvf/ifcvf_main.c      |  15 +++
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  13 ++-
 drivers/vdpa/pds/aux_drv.c           |   2 +-
 drivers/vdpa/pds/vdpa_dev.c          |  20 +++-
 drivers/vdpa/pds/vdpa_dev.h          |   1 +
 drivers/vdpa/vdpa.c                  | 214 ++++++++++++++++++++++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  15 ++-
 drivers/vdpa/vdpa_user/iova_domain.c |  27 ++++-
 drivers/vdpa/vdpa_user/iova_domain.h |   8 ++
 drivers/vdpa/vdpa_user/vduse_dev.c   |  34 ++++++
 drivers/vdpa/virtio_pci/vp_vdpa.c    |   8 ++
 drivers/vhost/net.c                  |   3 +
 drivers/vhost/vdpa.c                 |  14 +++
 drivers/virtio/virtio.c              |   6 +-
 drivers/virtio/virtio_ring.c         |   6 +-
 drivers/virtio/virtio_vdpa.c         |   5 +-
 include/linux/vdpa.h                 |   6 +
 include/uapi/linux/vdpa.h            |  17 +++
 include/uapi/linux/vhost.h           |   7 ++
 include/uapi/linux/virtio_pci.h      |  10 +-
 24 files changed, 521 insertions(+), 82 deletions(-)

