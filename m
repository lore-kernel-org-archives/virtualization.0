Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E311B3937
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567884; cv=none; b=pb7ZpOr3+LicTeSKj7np+js5LDRZb2haKOEDIiFWQFBnC9BwN2mEHb5jxXKusgNy+ta5TAM7oqsKczeqemTa50uKWxtNwOrBKx87PL1smIQrqNLiMwcR9RjeuXj/46Rt9Xo4VgsESV6RamdU9ByLYtApEcLigMrO2Or1NWEgqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567884; c=relaxed/simple;
	bh=Qv/D8tIzjeILxjfH4bpInhYPx0KH69gbI+qfB6bxniU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CmvDN6LP83P7vJMefodP1dPOeUDxr67NTiZ8o0hQ+s6a52QGb7k2ALLsTwWlDj+0CteLNLst33QwRaICHFpyFXdX6kGyPF4QspK0vrmzQxnuMt/kMMp8f0vh10E8u3hIYcePajxvbDpStOe4aDlbxGanGC3D6/aNZO49utj8q9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgFr45+C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgFr45+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754567881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9JmYnucsvaEuFLG2nfmRwc0GhvX0U7PC/ZVkWS7PBPY=;
	b=MgFr45+CfhqH/FNs5JdvuH7EwWSyxUy1VKCKbRyDqHonGdl/tiFOaoGjLczbgEqSa8C6T6
	l1F6jMpemY0ILaZAnw7KlR7+xr2Pn5HU7RDVNm4Ux9Vbg06Qt1l1sgihHxXo1XEicbu1P6
	PB8EYM8SsHZJ/U+W3XSGs1MdNks4pNk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-lX7gC7joPTiuyxO_o3XB1w-1; Thu,
 07 Aug 2025 07:58:00 -0400
X-MC-Unique: lX7gC7joPTiuyxO_o3XB1w-1
X-Mimecast-MFC-AGG-ID: lX7gC7joPTiuyxO_o3XB1w_1754567879
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1A1419560AA;
	Thu,  7 Aug 2025 11:57:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66F6530001A5;
	Thu,  7 Aug 2025 11:57:54 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	jasowang@redhat.com,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [RFC v2 0/7] Add multiple address spaces support to VDUSE
Date: Thu,  7 Aug 2025 13:57:45 +0200
Message-ID: <20250807115752.1663383-1-eperezma@redhat.com>
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
isolate the memory AS.  This aligns VDUSE with gq}vdpa_sim and nvidia
mlx5 devices which already support ASID.

This helps to isolate the environments for the virtqueues that will not
be assigned directly. E.g in the case of virtio-net, the control
virtqueue will not be assigned directly to guest.

This is still a RFC as it depends on the series that reworks the virtio mapping
API:
https://lore.kernel.org/all/20250718091616.6140-1-jasowang@redhat.com/

As some changes has been requested to it, these will need to be applied here
too.

Also, to be able to test this patch, the user needs to manually revert
56e71885b034 ("vduse: Temporarily fail if control queue feature requested").

v2:
* Cache group information in kernel, as we need to provide the vq map
  tokens properly.
* Add descs vq group to optimize SVQ forwarding and support indirect
  descriptors out of the box.
* Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
  part of the struct is the same.
* Fixes detected testing with OVS+VDUSE.

Eugenio Pérez (7):
  vduse: add v1 API definition
  vduse: add vq group support
  vdpa: change get_vq_map_token type to void *(*cb)
  vduse: return internal vq group struct as map token
  vduse: add vq group asid support
  vduse: send update_iotlb_v2 message
  vduse: bump version number

 drivers/vdpa/mlx5/net/mlx5_vnet.c  |   2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c | 389 +++++++++++++++++++++++------
 include/linux/vdpa.h               |   2 +-
 include/uapi/linux/vduse.h         |  64 ++++-
 4 files changed, 371 insertions(+), 86 deletions(-)

-- 
2.50.1

