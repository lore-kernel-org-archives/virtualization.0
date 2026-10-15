Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285A511E69
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057267; cv=none; b=ZWoPcBeb4oe5uERHhqeCcbwyCKynfixiLlpgm4hbhammvssLu6QzieJTiWc24TROuJzeo1wTZYnECr3IDSdVUY8RO/+P8qf8uNv91EjOM9kfp7lJJ4H6cXsgs6Q/ciKS5SIrZhlSKvPD6Mbop1h8cUGF1+VxZBuqdT/83NF5IyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057267; c=relaxed/simple;
	bh=jcmAYAvdEcsFMdvikgCEMkfSlfbJawTSfOf8u6XBDu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K2WZmyPGgUyYRIc4v7Xc15b+/KItD0GUjMjSmQerR4Q/LkJo/4KH8OzkXWi7rQXJcm2EnFj3uCD+IXfIPprlEuxGiRgZztWVWzVnuid+goQLRFKdxcICTaOuB1t0jLflFpgd79j3ZfuHo8kzhTbE56LzJHsOoYuS0TJg9y0SFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gA+jo1b8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA+jo1b8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792057258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EKTHpdVjPq7g/VigfEsF6UTQweUIccbtUrCpbcIAEt0=;
	b=gA+jo1b8s97n2ri+4juV2zakT9eJWMxDpW1LxN7eQ2hfP/7zd/y8n6HvcBeo2I4jfivUs7
	guewp8LyTyIdDmlIXo5TMme6qt5CCXPh2QcIrYHqJPj+J/BlTKa7GT9RqJLOw9Ane4YOMv
	60ZOfW0vw6VEPeCUE/NMGZ93AuSfQZU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-PX3QPshYOKiSHjwq8OiKBg-1; Thu,
 15 Oct 2026 09:40:54 +0000
X-MC-Unique: PX3QPshYOKiSHjwq8OiKBg-1
X-Mimecast-MFC-AGG-ID: PX3QPshYOKiSHjwq8OiKBg_1792057254
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB35B1955F6D;
	Thu, 15 Oct 2026 09:40:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.184])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41E9C195608A;
	Thu, 15 Oct 2026 09:40:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Jason Wang <jasowangio@gmail.com>
Subject: [PATCH] MAINTAINERS: add missing virtio/vdpa/vduse/vhost headers
Date: Thu, 15 Oct 2026 11:40:49 +0200
Message-ID: <20261015094049.107999-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: As80XMakwhPgj_ooUNMRI3l_NHICvB4hdL0m1DSWJeg_1792057254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Several headers related to virtio, vDPA, VDUSE and vhost were not
covered by any specific MAINTAINERS entry and fell through to the
catch-all THE REST section:

- include/linux/device-id/virtio.h: not matched by the existing
  "include/linux/virtio*.h" glob, which only matches files directly
  under include/linux/ and does not recurse into subdirectories.

- include/uapi/linux/vdpa.h: the in-kernel include/linux/vdpa.h was
  listed under VIRTIO CORE but its UAPI companion was missing; the
  "include/uapi/linux/virtio_*.h" pattern does not match it because
  the filename lacks the "virtio_" prefix.

- include/uapi/linux/vduse.h: there is no dedicated VDUSE section in
  MAINTAINERS; the driver lives under drivers/vdpa/ which is already
  covered by VIRTIO CORE, so the UAPI header belongs there too.

- include/uapi/linux/vhost_types.h: the VIRTIO HOST (VHOST) section
  explicitly lists include/uapi/linux/vhost.h but omits its companion
  types header.

Assisted-by: claude-sonnet 4.6
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..9f85882f307e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28903,9 +28903,12 @@ F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
 F:	drivers/vdpa/
 F:	drivers/virtio/
+F:	include/linux/device-id/virtio.h
 F:	include/linux/vdpa.h
 F:	include/linux/virtio*.h
 F:	include/linux/vringh.h
+F:	include/uapi/linux/vdpa.h
+F:	include/uapi/linux/vduse.h
 F:	include/uapi/linux/virtio_*.h
 F:	net/vmw_vsock/virtio*
 F:	tools/virtio/
@@ -28979,6 +28982,7 @@ F:	drivers/vhost/
 F:	include/linux/sched/vhost_task.h
 F:	include/linux/vhost_iotlb.h
 F:	include/uapi/linux/vhost.h
+F:	include/uapi/linux/vhost_types.h
 F:	kernel/vhost_task.c
 
 VIRTIO HOST (VHOST-SCSI)
-- 
2.56.0

