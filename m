Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E5433BBD
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423523; cv=none; b=CEC6IOeXoIE1GgrwR2pzxvVmcIsho2mlOil6WXiCWIyc+VBtpJ3+FYNDg1M8dG/DycWYbDMqmwg+IGKN2/rC+a4FDxjIWDMNFuAiUpoStUpb/iLfHrz9+xD+fAZuUOuXuv2RZYcXQgQ7z3E6Nn5DJmCw02t5gNji3XEO/VfcZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423523; c=relaxed/simple;
	bh=WR3dfnOeT4WurqYtlL7iyaDmTW3gL+bV/FceCVUT7QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m4bdwlhvfpQFr3iBI/SdC62aOM658OPWn5jhfqxQoQWKuK4YOWXHOqybGCNYTnt1dZrJoNJnFUdgIa+xwHnRbp+TLMQw8aplZ+gSbjFgPL6DAHg6EutRfoTmcbKkWw5/yZS6UpPjDE+MY9nhXkNOiSeUzUBf93ZhooCGsqZN8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ee/PVo/7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee/PVo/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788423520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YoiG0j4TGuT1x5zHOr5l+yaeNhzEJ2vYtpYbINKT21Y=;
	b=ee/PVo/7W56MAVS5B8k/WBoLcpkmDrh0e5tI/nT8eGWqyzOyDe5quWWtv4NelTg/frF715
	ujX5YAsHa2OAfzFbOUqhYdwjdIBiMO7VKfgI3vrmaOzn1N5C9ZwJg0YyZj5XLVS0jPx1pX
	VfA99Pf5lLu/Pxt8W9l6e8uio3CBfn8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-zhKJWLWzMhaSPsnHq0fQRQ-1; Thu,
 03 Sep 2026 04:18:37 -0400
X-MC-Unique: zhKJWLWzMhaSPsnHq0fQRQ-1
X-Mimecast-MFC-AGG-ID: zhKJWLWzMhaSPsnHq0fQRQ_1788423516
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B7881944CD1;
	Thu,  3 Sep 2026 08:18:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.131])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE6A71955F0D;
	Thu,  3 Sep 2026 08:18:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	jen@redhat.com,
	Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2] =?UTF-8?q?virtio:=20add=20Eugenio=20P=C3=A9rez=20as=20?= =?UTF-8?q?Maintainer?=
Date: Thu,  3 Sep 2026 10:18:31 +0200
Message-ID: <20260903081831.2129729-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: wRUYa-NfvEmNC8Q1hnIOuC98JMnYpVFCq4jlfi3i5Ec_1788423516
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v2: Reorder entries so M entries are ordered before than R.
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..a7edb2709960 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28876,8 +28876,8 @@ F:	include/uapi/linux/virtio_console.h
 VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowangio@gmail.com>
+M:	Eugenio Pérez <eperezma@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
-R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
@@ -28954,7 +28954,7 @@ F:	include/uapi/linux/virtio_gpu.h
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowangio@gmail.com>
-R:	Eugenio Pérez <eperezma@redhat.com>
+M:	Eugenio Pérez <eperezma@redhat.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
@@ -29009,8 +29009,8 @@ F:	include/uapi/linux/virtio_mem.h
 VIRTIO NET DRIVER
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowangio@gmail.com>
+M:	Eugenio Pérez <eperezma@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
-R:	Eugenio Pérez <eperezma@redhat.com>
 L:	netdev@vger.kernel.org
 L:	virtualization@lists.linux.dev
 S:	Maintained
-- 
2.55.0

