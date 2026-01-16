Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B737A497
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563821; cv=none; b=Kgc3hJQWLgbiIqdRKdk4GT8KlHSRgLnqhJLenv994vExzJhMFf1Y4K5cDIrQN7sU8YJFVLH6LMMKF2xEsQPROblbko26Ow9saqmBYfimIgWnciDZKigfuIszPTIq4yvM6mu1+0jEHHr1vJuCfRhELUiBghgv+eOMdcwE+OI2xD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563821; c=relaxed/simple;
	bh=4EwCR6GlI45bds4ADtR+kW2/e8FFpywDhKtJPD7Llug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+Y5R5O1OjaJunZpyQH/QCRTQcezc/V60bTgwzFeRwwl9mFLigyx9Dk+1Ewu9IywT+NkB80f+rv8oa2n5r6BgP2vEVLRKjaIkz4A+gnJu96KeyMyf26YmXGQq/ZmZkHQAB+luRVOAFlhMMfF/P56dj/AWfF6FED1a5tF3XlEHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXjCtkeu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXjCtkeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768563819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBNRZryqSqW24NxPnEz/S1Ky8CSJvJTqZ/Uc5bpSyY0=;
	b=gXjCtkeubpksAjHj2opj8ZhLRrLhhrUukV7B6eWM+r0hHfbSEtwmuK27IDHAws1cwVdZ5c
	nURJ+B4gjoxkKqFrDGZqJvrPANu46L21AJYVnYjrXe2OEdw+5O+BUJ/WrmDq98zhRrg4HG
	ZZaPEPq1uVC5IMMi93BDER6RCof6i+E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-17j-zwzrPG2bpIGB74Zv6g-1; Fri,
 16 Jan 2026 06:43:36 -0500
X-MC-Unique: 17j-zwzrPG2bpIGB74Zv6g-1
X-Mimecast-MFC-AGG-ID: 17j-zwzrPG2bpIGB74Zv6g_1768563815
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 217331956050;
	Fri, 16 Jan 2026 11:43:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6EC3180049F;
	Fri, 16 Jan 2026 11:43:31 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	jasowang@redhat.com
Subject: [PATCH v13 13/13] Documentation: Add documentation for VDUSE Address Space IDs
Date: Fri, 16 Jan 2026 12:42:31 +0100
Message-ID: <20260116114231.1474306-14-eperezma@redhat.com>
In-Reply-To: <20260116114231.1474306-1-eperezma@redhat.com>
References: <20260116114231.1474306-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Address Space IDs allows the VDUSE framework to support devices able to
expose different virtqueues to different part of the drivers.  For
example, to let QEMU handle the net device control virtqueue, so QEMU
always knows the state of the device like mac address or number of
queues enabled, while leaving the dataplane passthrough to the guest
intact.  This enables live migration.

Expands the VDUSE documentation to explain how to use the new ioctls or
the new struct members of old ioctls.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v13:
* Fix s/VDUSE_IOTLB_GET_INFO/VDUSE_VQ_SETUP/.
* Document VDUSE_SET_VQ_GROUP_ASID VDUSE message (Jason).
* Fix typos (MST and Jason).

v12: New in V12. Requested by Jason.
---
 Documentation/userspace-api/vduse.rst | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
index bdb880e01132..aa067da92cf5 100644
--- a/Documentation/userspace-api/vduse.rst
+++ b/Documentation/userspace-api/vduse.rst
@@ -230,4 +230,57 @@ able to start the dataplane processing as follows:
 5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ_IRQ ioctl
    after the used ring is filled.
 
+Enabling ASID (API version 1)
+------------------------------
+
+VDUSE supports per-address-space identifiers (ASIDs) starting with API
+version 1. Set it up with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/control`
+and pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
+ioctl(VDUSE_CREATE_DEV).
+
+Afterwards, you can use the member asid of ioctl(VDUSE_VQ_SETUP) argument to
+select the address space of the IOTLB you are querying.  The driver could
+change the address space of any virtqueue group by using the
+VDUSE_SET_VQ_GROUP_ASID VDUSE message type, and the VDUSE instance needs to
+reply with VDUSE_REQ_RESULT_OK if it was possible to change it.
+
+Similarly, you can use ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file descriptor
+describing an IOVA region of a specific ASID. Example usage:
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

