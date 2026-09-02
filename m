Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C3A415F29
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341110; cv=none; b=aO7FaNOVKA0O4wONh5QHLGfwPtedcjNCWynFt/88EHTkx87jz5nlMyDRZ0Mn/yHxxFPjBQo0mmCgTQBKMecCOa9giU1ncahh23xAkcoM7LTNF+Co4/Lx61LgaNlu+7FE1ra4FuREQAmsYKGj6I4WQwNgGyPkZGxzglApZ6hYTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341110; c=relaxed/simple;
	bh=FlaO25gqB/twgCzUaB0N1ObHl5Wc1UY32hZDskIQa88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YT5seoHR4uCBC3yfAkLZHkEMaqUHnr5af/WH2DENTKLoPi/PSEDxXAvbe2iQuMxlWY1LWXLVGneZmALv6vNCqW1SvjIFQKsZQnYlX2r/g9VoV3nvKz4ZNgDqewfae1aEnDqg4OlYFylNur7rVLD23KOiJ8gz+xvNyRIYfehnUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7FaMKIo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7FaMKIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788341107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dggw3aZELjkrZngRu3p06M3tFtYsn+wILS1Ok2qcUPQ=;
	b=L7FaMKIoIpXeo7lDLNoXmQ3mPOX6bL3TZhdbJdpi40b91hQPYx8oRrRoyCm2qUFWO18V8k
	m1DuRJf2m+L4L3mukcu4csxAZtCQoNnGNmIniwgP+4ljbGuUHx/kdRHlopwTW1a1zGuKZq
	Ifx2sNcmdCAywVKXfa07u2isfgBv/mY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-ki7hp8qhMk2qiJ9C8w23OA-1; Wed,
 02 Sept 2026 05:25:06 -0400
X-MC-Unique: ki7hp8qhMk2qiJ9C8w23OA-1
X-Mimecast-MFC-AGG-ID: ki7hp8qhMk2qiJ9C8w23OA_1788341105
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D89618089B6;
	Wed,  2 Sep 2026 09:25:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.49.19])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE2AC195608A;
	Wed,  2 Sep 2026 09:25:01 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	jen@redhat.com,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] =?UTF-8?q?virtio:=20add=20Eugenio=20P=C3=A9rez=20as=20Mai?= =?UTF-8?q?ntainer?=
Date: Wed,  2 Sep 2026 11:24:59 +0200
Message-ID: <20260902092459.1983909-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 1dzbAPasGfmxMj7-BLyCfbyBRY05sir_oOQigsj57PE_1788341105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..a92c5712d8cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28877,7 +28877,7 @@ VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
-R:	Eugenio Pérez <eperezma@redhat.com>
+M:	Eugenio Pérez <eperezma@redhat.com>
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

