Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162052BE658
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572308; cv=none; b=qJic20wu/7tVdBFOjKkxAd+w/XDa4QkAAosLDnuFOMh7arAEkdBjMv3o1oeNc3NpGS/VHeWnPmFtHYe+AxdOqF/fCsqkZ+cXxJOW/oNZsTLwYKAUvK1yycixdutxGR+EfkXQcA27+JYLJ3YH9UquIbsMb3+3CmrODVBV5EF6SnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572308; c=relaxed/simple;
	bh=Xgs5hQtv2r2wXj45+M5ldcLKX3yzQFtnuyM0Ib3PhVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdrEBNHypqWGj/7mXoN5i9Fi2CIAC5LeGnwriL1NeFN/NTo/8Wm3s/ZPi/e06HrKmiaSVStgUMXXTgKBAjjI1gkOhroEwrPju3cUFHGSy7n+XZzkVMj7HQgognBVwTdeqj7wSRWjYv5qfIYIR3z29BrEWkz5ZisJaBhx7t/NIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdiodx+s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdiodx+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768572306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GQxcL1w9Fh5dnKM+fLnv+sFa1mkvBZ9nqDg/z7B9yGs=;
	b=fdiodx+sDOi2hBIfuCvzbeSvczXvMeU+BZoZnhJYWb2370EzaucpxZdw6UBIaM9EANvdl1
	lXOOi3Ntgqr9nrilAxibHk3R7Q2Fi+a51PpInVaCkJeUJrB51aN7bGsJysp7pGltWrsT+G
	6irnVO5osQ9M5BuLKnDNSNVEgq9R6pg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-SVQcPz2TMTaIZb2emmapLg-1; Fri,
 16 Jan 2026 09:05:02 -0500
X-MC-Unique: SVQcPz2TMTaIZb2emmapLg-1
X-Mimecast-MFC-AGG-ID: SVQcPz2TMTaIZb2emmapLg_1768572301
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5681D18005AE;
	Fri, 16 Jan 2026 14:05:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B1D730002D6;
	Fri, 16 Jan 2026 14:04:57 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v14 00/13] Add multiple address spaces support to VDUSE
Date: Fri, 16 Jan 2026 15:04:42 +0100
Message-ID: <20260116140455.1560491-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Also, to be able to test this patch, the user needs to manually revert the
56e71885b0349 ("vduse: Temporarily fail if control queue feature requested")
commit.

Tested by creating a VDUSE device OVS with and without MQ, and live migrating
between two hosts back and forth while maintaining ping alive in all the
stages.  All tested with and without lockdep, with the old VDUSE_IOTLB_GET_FD
and the new VDUSE_IOTLB_GET_FD2, and with the VDUSE API 0 and 1.

A few workaround were needed in some parts to test live migration with
vhost_vdpa:
* Do not enable CVQ before data vqs in QEMU, as VDUSE does not forward
  the enable message to the userland device.  This will be solved in the
  future.
* Share the suspended state between all vhost devices in QEMU:
  https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.html
* Implement a fake VDUSE suspend vdpa operation callback that always
  returns true in the kernel.  DPDK suspend the device at the first
  GET_VRING_BASE.
* Remove the CVQ blocker in ASID.

The driver vhost_vdpa was also tested with version 0, version 1 with the
old ioctl, version 1 with the new ioctl but only one ASID, and version 1
with many ASID.

Also tested with virtio_vdpa with just one ASID, and by creating two threads
that maps and unmaps memory randomly while ASID is changed [1].

[1] https://lore.kernel.org/lkml/CAJaqyWeDjBfzrA93riYTmefY4oLbctWWBMPcpR5Q6r50dUGOEw@mail.gmail.com

PATCH v14:
* Add header documentation for VDUSE_SET_VQ_READY VDUSE message to userspace.

PATCH v13:
* Fix s/VDUSE_IOTLB_GET_INFO/VDUSE_VQ_SETUP/ in Documentation.
* Document VDUSE_SET_VQ_GROUP_ASID VDUSE message (Jason).
* Fix doc typos (MST and Jason).

PATCH v12:
* Add API version 1 usage in Documentation/userspace-api/vduse.rst.
* Assume API version 0 by default if the VDUSE instance does not ask
  (Jason).
* Using scoped guards for vq group rwlock, so the one queue optimization
  is not missed (Jason proposed to factor them into helpers).
* Add the _v2 suffix to vduse_iova_range_v2 struct name fixing the doc
  (MST).
* Avoid dereferencing map_file if not assigned in vduse_dev_iotlb_entry
  function (MST).
* Avoid free_pages_exact(NULL, size) in case vduse_domain_alloc_coherent
  fails (MST).
* Add Fixes: tag (MST).
* s/verion/version/;s/accomodated/accommodated;s/behavious/behaviour in
  patch messages, and more rewording of them (MST).
* Remove trailing ; after a comment (Jason).
* Change the style of checking for vq group == 0 in VDUSE_VQ_SETUP dev
  ioctl if api_version < 1 (MST).

PATCH v11:
* Remove duplicated free_pages_exact in vduse_domain_free_coherent (Jason).
* Move the vduse_iotlb_entry_v2 argument to a new ioctl, as argument
  didn't match the previous VDUSE_IOTLB_GET_FD.
* Do not reset the vq group ASID in vq reset (Jason).  Removed extra function
  vduse_set_group_asid_nomsg, not needed anymore.
* Do not take the vq groups lock if nas == 1.
* Move the asid < dev->nas check to vdpa core.
* Rename vq->vq_group to vq->group (Jason).
* Do not reset vq group at virtio reset (Jason).

PATCH v10:
* Back to rwlock version so stronger locks are used.
* Take out allocations from rwlock.
* Forbid changing ASID of a vq group after DRIVER_OK (Jason)
* Remove bad fetching again of domain variable in vduse_dev_max_mapping_size
  (Yongji).
* Remove unused vdev definition in vdpa map_ops callbacks (kernel test robot).

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

Eugenio Pérez (13):
  vhost: move vdpa group bound check to vhost_vdpa
  vduse: add v1 API definition
  vduse: add vq group support
  vduse: return internal vq group struct as map token
  vdpa: document set_group_asid thread safety
  vhost: forbid change vq groups ASID if DRIVER_OK is set
  vduse: refactor vdpa_dev_add for goto err handling
  vduse: remove unused vaddr parameter of vduse_domain_free_coherent
  vduse: take out allocations from vduse_dev_alloc_coherent
  vduse: merge tree search logic of IOTLB_GET_FD and IOTLB_GET_INFO
    ioctls
  vduse: add vq group asid support
  vduse: bump version number
  Documentation: Add documentation for VDUSE Address Space IDs

 Documentation/userspace-api/vduse.rst |  53 +++
 drivers/vdpa/mlx5/net/mlx5_vnet.c     |   3 -
 drivers/vdpa/vdpa_sim/vdpa_sim.c      |   6 -
 drivers/vdpa/vdpa_user/iova_domain.c  |  27 +-
 drivers/vdpa/vdpa_user/iova_domain.h  |   8 +-
 drivers/vdpa/vdpa_user/vduse_dev.c    | 540 +++++++++++++++++++-------
 drivers/vhost/vdpa.c                  |   4 +-
 include/linux/vdpa.h                  |   4 +-
 include/linux/virtio.h                |   6 +-
 include/uapi/linux/vduse.h            |  79 +++-
 10 files changed, 553 insertions(+), 177 deletions(-)

-- 
2.52.0

