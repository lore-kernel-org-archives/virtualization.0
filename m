Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA60725B2FE
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274365; cv=none; b=QmxQKX1B0fx1/h7qnjkbmtVaRuDLgLskgikaUup0pMeiu7TnMueCvKpo+n8uQJeIFjp53eYb3rBp4ifIb3JRz8VX3kwGI61Hp0CcV0u+iPXgHUK7MicZztkC86tQvp10li21TSjhmq4QThlIfzlYXo2UUNypaDP1/nHpj+J0UZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274365; c=relaxed/simple;
	bh=QyBw9V3MrwIBLTNTHmBzydrQVjWnsneezFu885BPIXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S15Sa31Hyk3jWWyH9CAJDNTmnsv4w5oMNBZaxhShU1oOD+MzUdQw0+A+f8ymr6+XhDYQ6Q5ays/IxWtyAKEcBw8Bjyt6EOtXEVcESFalNwGK0Qb2qWTtoYl2gFqSektWzSfSnRA8XPQvAq2OG33TdYm2jd9DL9SFix89wFC5YkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAkKrTc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAkKrTc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758274361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DEy+og7tihPhXp1E3SsxMGMOW3TK1N+nPInsY12TsqE=;
	b=QAkKrTc7VwMg2K6b6ZSbVWviBAriaZV+2hDFaM6fwALAnzw3uwLRlsq0EM+jdcgeHXkWR/
	Vq4rzhWufPT0/iYtybjtNQPbFC2o/+sO+ZoVSP5ITNrV9JI04TZ553zETilfTsswqC0134
	pH4DuThhDDdfR5482tDsC0smyKxRVCc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-hy7QeGCANc2LFu018EhOkg-1; Fri,
 19 Sep 2025 05:32:39 -0400
X-MC-Unique: hy7QeGCANc2LFu018EhOkg-1
X-Mimecast-MFC-AGG-ID: hy7QeGCANc2LFu018EhOkg_1758274358
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0C021955F2A;
	Fri, 19 Sep 2025 09:32:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DEE31956045;
	Fri, 19 Sep 2025 09:32:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 0/6] Add multiple address spaces support to VDUSE
Date: Fri, 19 Sep 2025 11:32:25 +0200
Message-ID: <20250919093231.960393-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When used by vhost-vDPA bus driver for VM, the control virtqueue
should be shadowed via userspace VMM (QEMU) instead of being assigned
directly to Guest. This is because QEMU needs to know the device state
in order to start and stop device correctly (e.g for Live Migration).

This requies to isolate the memory mapping for control virtqueue
presented by vhost-vDPA to prevent guest from accessing it directly.

This series add support to multiple address spaces in VDUSE device
allowing selective virtqueue isolation through address space IDs (ASID).

The VDUSE device needs to report:
* Number of virtqueue groups
* Association of each vq group with each virtqueue
* Number of address spaces supported.

Then, the vDPA driver can modify the ASID assigned to each VQ group to
isolate the memory AS.  This aligns VDUSE with vdpa_sim and nvidia mlx5
devices which already support ASID.

This helps to isolate the environments for the virtqueues that will not
be assigned directly. E.g in the case of virtio-net, the control
virtqueue will not be assigned directly to guest.

Also, to be able to test this patch, the user needs to manually revert
56e71885b034 ("vduse: Temporarily fail if control queue feature requested").

PATCH v3:
* Make the default group an invalid group as long as VDUSE device does
  not set it to some valid u32 value.  Modify the vdpa core to take that
  into account (Jason).  Adapt all the virtio_map_ops callbacks to it.
* Make setting status DRIVER_OK fail if vq group is not valid.
* Create the VDUSE_DEV_MAX_GROUPS and VDUSE_DEV_MAX_AS instead of using a magic
  number
* Remove the _int name suffix from struct vduse_vq_group.
* Get the vduse domain through the vduse_as in the map functions (Jason).
* Squash the patch implementing the AS logic with the patch creating the
  vduse_as struct (Jason).

PATCH v2:
* Now the vq group is in vduse_vq_config struct instead of issuing one
  VDUSE message per vq.
* Convert the use of mutex to rwlock (Xie Yongji).

PATCH v1:
* Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
* Using vduse_vq_group_int directly instead of an empty struct in union
  virtio_map.

RFC v3:
* Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
  value to reduce memory consumption, but vqs are already limited to
  that value and userspace VDUSE is able to allocate that many vqs.  Also, it's
  a dynamic array now.  Same with ASID.
* Move the valid vq groups range check to vduse_validate_config.
* Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
* Use of array_index_nospec in VDUSE device ioctls.
* Move the umem mutex to asid struct so there is no contention between
  ASIDs.
* Remove the descs vq group capability as it will not be used and we can
  add it on top.
* Do not ask for vq groups in number of vq groups < 2.
* Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
  VDUSE_IOTLB_GET_INFO.

RFC v2:
* Cache group information in kernel, as we need to provide the vq map
  tokens properly.
* Add descs vq group to optimize SVQ forwarding and support indirect
  descriptors out of the box.
* Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
  part of the struct is the same.
* Fixes detected testing with OVS+VDUSE.

Eugenio Pérez (6):
  vduse: make domain_lock an rwlock
  vduse: add v1 API definition
  vduse: add vq group support
  vduse: return internal vq group struct as map token
  vduse: add vq group asid support
  vduse: bump version number

 drivers/vdpa/ifcvf/ifcvf_main.c    |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c   |   2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c | 506 ++++++++++++++++++++++-------
 drivers/vhost/vdpa.c               |  11 +-
 include/linux/vdpa.h               |   5 +-
 include/linux/virtio.h             |   6 +-
 include/uapi/linux/vduse.h         |  65 +++-
 8 files changed, 467 insertions(+), 132 deletions(-)

-- 
2.51.0

