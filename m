Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FA33BBCD
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416589; cv=none; b=Hz9z75DjmwyAYloV8kgwsJo0XYGz0LUWAtA9zgxXBZv+vkraXyqnbnmEA/MxDB67b3KGiGgUZcwH44j2A6vAJzPySPQaJkqw1OXPqlpTKLt//ubBg9CDeaJusVH0Fk6F+qnX3ZUzCtqs0uKLf6lk1930PqvjF2ThDLOThySw1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416589; c=relaxed/simple;
	bh=vJLTQtxpPimtRM7TuxPRbTnNVZmEDshXZd3IwBBx9Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSOWF0jZLrOVU+Wzb65RxvdgePQ8cYgX7sp8Uz/9v3SBYPDrDiQPdWRrVHwiS8RjmPcVCkIr9VHxD5L+3ObtMOSD4YJnjrZw7b/stKGukC2JlHdx8TWwjoFb+t6uwShsGdYe3eTfCqYFRpKDPz1WMgrQnT5PmzJUj5YOwwYXRxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/A7OnOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/A7OnOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768416584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uchnxoxwryga9vkWm95sOYYbL2I2w5BScVB//ENJPdU=;
	b=e/A7OnOtIV30/BMv9BcmSJun0r2S/H8tYwG3nTWTlyXRpqpE+2spMN1g+zgJj0FKXdIO5o
	qFVDGPQO1lZAPHz/guDzq6pXcx3axeaB0lfmOMmbU8bAhYvv3XZajn4yi4pUJx6l76+4nZ
	0HzbwyKfZ6XaPcv147GVIlMRQWVHzIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-iPMqeZ7fN_6Rv9BflRBEoQ-1; Wed,
 14 Jan 2026 13:49:43 -0500
X-MC-Unique: iPMqeZ7fN_6Rv9BflRBEoQ-1
X-Mimecast-MFC-AGG-ID: iPMqeZ7fN_6Rv9BflRBEoQ_1768416582
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E5231955E7F;
	Wed, 14 Jan 2026 18:49:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5CFE19560A7;
	Wed, 14 Jan 2026 18:49:38 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v12 13/13] Documentation: Add documentation for VDUSE Address Space IDs
Date: Wed, 14 Jan 2026 19:48:39 +0100
Message-ID: <20260114184839.926884-14-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-1-eperezma@redhat.com>
References: <20260114184839.926884-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Address Space IDs allows the VDUSE framework to support devices able to
expose different virtqueues to different part of the drivers.  For
example, to let QEMU handle the net device control virtqueue, so QEMU
always knows the state of the device like mac address or number of
queues enabled, while leaving the dataplane passtrhough to the guest
intact.  This enables live migration.

Expands the VDUSE documentation to explain how to use the new ioctls or
the new struct members of old ioctls.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v12: New in V12. Requested by Jason.
---
 Documentation/userspace-api/vduse.rst | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
index bdb880e01132..66110d918815 100644
--- a/Documentation/userspace-api/vduse.rst
+++ b/Documentation/userspace-api/vduse.rst
@@ -230,4 +230,53 @@ able to start the dataplane processing as follows:
 5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ_IRQ ioctl
    after the used ring is filled.
 
+Enabling ASID (API version 1)
+------------------------------
+
+VDUSE supports per-address-space identifiers (ASIDs) starting with API
+version 1. Setup it with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/control` and
+pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
+ioctl(VDUSE_CREATE_DEV).
+
+Afterwards, you can use the member asid of ioctl(VDUSE_IOTLB_GET_INFO) to
+select the address space of the IOTLB you are queryng. Similarly, you can use
+ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file descriptor describing an IOVA
+region of an specific ASID. Example usage:
+
+.. code-block:: c
+
+	static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t iova,
+	                        uint64_t *len)
+	{
+		int fd;
+		void *addr;
+		size_t size;
+		struct vduse_iotlb_entry_v2 entry = { 0 };
+
+		entry.v1.start = iova;
+		entry.v1.last = iova;
+		entry.asid = asid;
+
+		fd = ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
+		if (fd < 0)
+			return NULL;
+
+		size = entry.v1.last - entry.v1.start + 1;
+		*len = entry.v1.last - iova + 1;
+		addr = mmap(0, size, perm_to_prot(entry.v1.perm), MAP_SHARED,
+			    fd, entry.v1.offset);
+		close(fd);
+		if (addr == MAP_FAILED)
+			return NULL;
+
+		/*
+		 * Using some data structures such as linked list to store
+		 * the iotlb mapping. The munmap(2) should be called for the
+		 * cached mapping when the corresponding VDUSE_UPDATE_IOTLB
+		 * message is received or the device is reset.
+		 */
+
+		return addr + iova - entry.start;
+	}
+
 For more details on the uAPI, please see include/uapi/linux/vduse.h.
-- 
2.52.0

