Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFE40D585
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782697540; cv=none; b=NNm1wUfeNzDL6s12BDMa+8gUbAfMzD4JhLwr2whDZSZrmP3JsTd8XFJETBAy5MH2J23ZS6g8X1O3cyWhroW+wK5hb0Dh4kqYLzfByMy7MzICZHqIGuQZS4U1HDD0hH9AmCtFu9Z/vRZg8tQJK05ZINBJmEJ42dqCU8ojPiWY+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782697540; c=relaxed/simple;
	bh=yntFMUzD/ii2OqD5HS1hjbqyMZks/DiA0fVR83FEiGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=BzEovPYaECo0ze4Jpniv6AfGXxPv4CKetryi5i5ZlqYEs+9Iu3tVQMmGBb//qlk8lbPRKVYEkjqeCHTOSjhAH3eZ+aVw0hM674OT27nKGIxeR/6Dlogaf6ShJJGCHmCPehxtOmLCzvNphHbhueNW4PirHD5ZfiU2J7Qw4UZRbmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMJdHDH8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMJdHDH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782697536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AehoOCJmWEBUGxUzdNE1sQa+qNVdV0emwrzzm73CHcA=;
	b=IMJdHDH8BhSK7JkRrELOVBja2DlkKb9sli0Rq9+9QLmWGcu77FCOaN8oWje6iKWJNeWzNI
	lPb4qGyWuJwE1SUju0VJASCP601tbyvFmWnODLxC6qNXZM1EQGlqGgOVRHrHmuuTQBhqjd
	1cND8fPteIc6o2NN3C7XSjpefev5CQ4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-QPuz-6PJMNmj_mWUnSXbEw-1; Sun, 28 Jun 2026 21:45:35 -0400
X-MC-Unique: QPuz-6PJMNmj_mWUnSXbEw-1
X-Mimecast-MFC-AGG-ID: QPuz-6PJMNmj_mWUnSXbEw_1782697534
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fc0aaa94cso879665a91.1
        for <virtualization@lists.linux.dev>; Sun, 28 Jun 2026 18:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782697534; x=1783302334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AehoOCJmWEBUGxUzdNE1sQa+qNVdV0emwrzzm73CHcA=;
        b=BDWNrzyRVeRb+siUoV2qCVsrWtV9BvxDCwkaH1HID6LFp0EK7rQSWZh7QJ+Gme06N2
         MdbOqCe/ElE5zzocsodV1TGuISiuTwvbEwiD8VnBvyknbxm/aHpMarH/D5+DHXhZk50R
         ZznL9hddXqEjt/wdkdEFBqVIkL7oyCgShpoAu+lJ03iNXBCqIu1jMJoVm6G98zT2DikI
         C0jixYxMmNH3Kx1v84BbnpLZRaQZC8V9qcKOYbl7VgdLx0PvjvDzyYzsAFRvE4HRnnp8
         UKFRzyPOunKmry4lQrRiQHt9YON0sDTa3hhTlAORzWgd5VycsPnxslMTI2UcaUQ3r5HL
         Dvhw==
X-Forwarded-Encrypted: i=1; AHgh+RqaMsZ5mNZw+/h9rr2oW8pudTorfDjrtTSJon7mnRqsKxud2cu4zvG57OcLDE5iUbkw1Hov4z4Orxw21DI52w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlikAHpJX26bv8D0XjrogBYEstgevVgSWti21A1gCenANrHJyN
	01p3J4DrbdvlXBAd4jjOfO/Mk36Xp+F07sdYNBkACnpULj856edqEJ8BZiNoaj3XmbvMyNBvObB
	ujf2bOjXmztY1xhMKPUw/aKQQ5kNYgFrivL+GDLuYL2T/a+53CYMOkDe7bBA1vRBya0rJ
X-Gm-Gg: AfdE7cm3urmur4L2E9/m5xmeu1/nK8WRAjCB6O9i3o8YC9xpRvZBl9wlEeKJPOAnq8V
	U+kV1ZKaxwmu5WmIyT2Wi2aKh6xQb0Ke/OpJwj7Kn7HSV9jcvnq2/BDOpoqmDYL/XL55ik2peaL
	/EL8x5kBcBLlEeiuPKNeKMDq4c3xjdedcFD3OiHqrxHmC+3F9QTa1DW7BoLERKGrcRNksOc0yFl
	lYhpvgVphLKLbAHFYqA6L4cO5jUnXbQP6RweCKmfGuSNFF/2E9CJRIDbkjyludh474g/QwvD5Jd
	CmMJfhjeFuSqH54VDTd5qTeCwPdUrKKd7VgmFl+DOyGiHXZIdUQczjzhMJY9/V8U8b86qvbXuJ6
	+2a+dMW8NlzYRTRJ5g6EZtQ==
X-Received: by 2002:a17:90b:1fcf:b0:37e:a40:e71a with SMTP id 98e67ed59e1d1-37f81594261mr7017627a91.14.1782697533946;
        Sun, 28 Jun 2026 18:45:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1fcf:b0:37e:a40:e71a with SMTP id 98e67ed59e1d1-37f81594261mr7017618a91.14.1782697533423;
        Sun, 28 Jun 2026 18:45:33 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37f464b5dadsm4464301a91.5.2026.06.28.18.45.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Jun 2026 18:45:32 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2] MAINTAINERS: Update Jason Wang's email address
Date: Mon, 29 Jun 2026 09:45:24 +0800
Message-ID: <20260629014525.16297-1-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QxpLYgJ0FWE1rydWmwhYeIStqu_xr5Hybflcyr_7IA8_1782697534
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

I will use jasowangio@gmail.com for future review and discussion.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Add mailmap entry
---
 .mailmap    |  1 +
 MAINTAINERS | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 23eb9a4b04f4..e7e639aeb23c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -373,6 +373,7 @@ Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@opinsys.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
+Jason Wang <jasowangio@gmail.com> <jasowang@redhat.com>
 Jason Xing <kerneljasonxing@gmail.com>  <kernelxing@tencent.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..40d9641cbc7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27520,7 +27520,7 @@ F:	drivers/net/ethernet/dec/tulip/
 
 TUN/TAP DRIVER
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 S:	Maintained
 W:	http://vtun.sourceforge.net/tun
 F:	Documentation/networking/tuntap.rst
@@ -28512,7 +28512,7 @@ F:	include/uapi/linux/virtio_balloon.h
 
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
@@ -28541,7 +28541,7 @@ F:	include/uapi/linux/virtio_console.h
 
 VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
@@ -28619,7 +28619,7 @@ F:	include/uapi/linux/virtio_gpu.h
 
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
@@ -28634,7 +28634,7 @@ F:	kernel/vhost_task.c
 
 VIRTIO HOST (VHOST-SCSI)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 M:	Mike Christie <michael.christie@oracle.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
@@ -28674,7 +28674,7 @@ F:	include/uapi/linux/virtio_mem.h
 
 VIRTIO NET DRIVER
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	netdev@vger.kernel.org
-- 
2.54.0

