Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BEE279359
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881685; cv=none; b=prDHN6cRHAvmEC+OkPcQ1CATcbKah49xHsled4RdKA2280fjogUwHHXRXvA48hk6dDzRS3KHKeqthgBHjZqktIOa7NOTSYdk0hoU21KflG6+/pt6UgDF9/8wGJEsGGU5py1hz2sPo4tvY6mXCv16GypcCnpFTMImioV9LbeDwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881685; c=relaxed/simple;
	bh=BdS9LCCtMb3pfxuYo+0RIpHxA/nqFj9j4ZD49Z3uGzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=owtVK7C++FYsGLCEkSxrGn6hydk2HWlF2cIka8LJsYsRocKNYIY3BySTekB3j1Xz2mg6Iutoek+u4nqzwLX04PlwsetZEXmOwb4X28+7lPqWdDA6aUm1CD2YJ0Pw995xR+HarJwD94wbgd3MnisrPaIXTSPo19M+1fZA42H7Xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmEl40f8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmEl40f8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758881683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQEaYX675f3MoT4kitsMxiauXtIyVigLQAH4igtdjrQ=;
	b=YmEl40f8CIBVtIWKEsyj7WtSXieR4dGLC3Fn2sLypndC5QR5+EN/CrF6msMmmsxs8IvW/Q
	5/xvCcobH79w1cFWPoWTb5EBhu3byegUe6zbPvCY65njwQf/BZD41kUtlJxuS714FLg2fN
	hN2CuwfmbIbBYBbebf3WpWwd0Z18p8c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219--5aDCMzfOf-pc8DyGlUNbg-1; Fri,
 26 Sep 2025 06:14:40 -0400
X-MC-Unique: -5aDCMzfOf-pc8DyGlUNbg-1
X-Mimecast-MFC-AGG-ID: -5aDCMzfOf-pc8DyGlUNbg_1758881679
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B274180035C;
	Fri, 26 Sep 2025 10:14:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.141])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BCA01956095;
	Fri, 26 Sep 2025 10:14:33 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: [PATCH v5 0/6] Add multiple address spaces support to VDUSE
Date: Fri, 26 Sep 2025 12:14:26 +0200
Message-ID: <20250926101432.2251301-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

This series depends on the series that reworks the VDUSE mapping API:
https://lore-kernel.gnuweeb.org/all/20250924070045.10361-1-jasowang@redhat.com/

Also, to be able to test this patch, the user needs to manually revert
56e71885b034 ("vduse: Temporarily fail if control queue feature requested").

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

Eugenio Pérez (6):
  vduse: make domain_lock an rwlock
  vduse: add v1 API definition
  vduse: add vq group support
  vduse: return internal vq group struct as map token
  vduse: add vq group asid support
  vduse: bump version number

 drivers/vdpa/vdpa_user/vduse_dev.c | 492 ++++++++++++++++++++++-------
 include/linux/virtio.h             |   6 +-
 include/uapi/linux/vduse.h         |  67 +++-
 3 files changed, 441 insertions(+), 124 deletions(-)

-- 
2.51.0

