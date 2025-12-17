Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4742BE7AD
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970668; cv=none; b=oudgqwL5nbQUR0La0ktFIliQPaK6Hx6rFqXbdc6BowGt9L1b0Jx/+Mrg2ESImRlHrFEr4ziYKg6lPdcTejcM6vK+5w+FU1OwrM8AFekeRa6xNHDDcTmCCmzxyo8qpraybxwoYwmCc9k4BLbybDoNohBtJBXCMmpzJH0YWAa0wxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970668; c=relaxed/simple;
	bh=Qs8c8ilzX2dcMXBlmKy/kP8U6lCP99iEgt8Iv90U9qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HohNG/fUOJUWXqv/IOjDbRD0KxYiX1eFMaQqO0mDW9pBk07TBVS9se+8enq0+iAC7VeeApBrZosuE3uHVqWGLw7LFVPo857gDxI5lNHpBPTyDAG3eUfIDoRTl0AloarFv04sL5Ux26OHSmO1GH7cjNdOQ4Dq5uEYd7yNPOVN+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3ffa7/y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3ffa7/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765970663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FfXrhi7LMI5Q8TgyUnh0Rt45NV2TPYOSEzkzQHfRyY8=;
	b=c3ffa7/yFDfy/8RBNDWBlIQmOzMHU/W4k7AhKGS5WljFDcG6ftw6IeJDUT3DrYoJV7vJms
	AQ6fqNADPcD/4aoGpfSY88M0Mf4GMEU4YMecRcB7RZjO7Qv/Csr+8RYTwXlgIk6l7WX1O4
	VEMs+/0MJ5/AXyQyngp3/cl/P4rlEy8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-WESbVY3iOLiI5KtqVbmo0g-1; Wed,
 17 Dec 2025 06:24:22 -0500
X-MC-Unique: WESbVY3iOLiI5KtqVbmo0g-1
X-Mimecast-MFC-AGG-ID: WESbVY3iOLiI5KtqVbmo0g_1765970661
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF02C1800358;
	Wed, 17 Dec 2025 11:24:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82A3E180049F;
	Wed, 17 Dec 2025 11:24:16 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v10 0/8] Add multiple address spaces support to VDUSE
Date: Wed, 17 Dec 2025 12:24:06 +0100
Message-ID: <20251217112414.2374672-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Tested by creating a VDUSE device OVS with and without MQ, and live migrating
between two hosts back and forth while maintaining ping alive in all the
stages.  All tested with and without lockdep.

PATCH v9:
* Change to RCU.

PATCH v8:
* Revert the change from mutex to rwlock (MST).

PATCH v7:
* Fix not taking the write lock in the registering vdpa device error path
  (Jason).

PATCH v6:
* Make vdpa_dev_add use gotos for error handling (MST).
* s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?/
  in group and nas handling at device creation (MST).
* Fix struct name not matching in the doc.
* s/sepparate/separate (MST).

PATCH v5:
* Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
  ioctl (Jason).
* Properly set domain bounce size to divide equally between nas (Jason).
* Revert core vdpa changes (Jason).
* Fix group == ngroup case in checking VQ_SETUP argument (Jason).
* Exclude "padding" member from the only >V1 members in
  vduse_dev_request.

PATCH v4:
* Consider config->nas == 0 and config->ngroups == 0 as a fail (Jason).
* Revert the "invalid vq group" concept and assume 0 if not set.
* Divide each domain bounce size between the device bounce size (Jason).
* Revert unneeded addr = NULL assignment (Jason)
* Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
  return; } (Jason)
* Change a bad multiline comment, using @ caracter instead of * (Jason).

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

Eugenio Pérez (8):
  vduse: add v1 API definition
  vduse: add vq group support
  vduse: return internal vq group struct as map token
  vduse: refactor vdpa_dev_add for goto err handling
  vduse: remove unused vaddr parameter of vduse_domain_free_coherent
  vduse: take out allocations from vduse_dev_alloc_coherent
  vduse: add vq group asid support
  vduse: bump version number

 drivers/vdpa/vdpa_user/iova_domain.c |  10 +-
 drivers/vdpa/vdpa_user/iova_domain.h |   5 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 469 +++++++++++++++++++++------
 include/linux/virtio.h               |   6 +-
 include/uapi/linux/vduse.h           |  67 +++-
 5 files changed, 434 insertions(+), 123 deletions(-)

-- 
2.52.0

