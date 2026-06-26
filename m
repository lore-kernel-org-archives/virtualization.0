Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98A2E2840
	for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440455; cv=none; b=tUBwBYXjn6oUsOKfsTkaate1xWf5S5BX7gItmqgTxn74Lpk0GAhiwSt5vARZaCCabZZijiGisS7lB1mFjGMMuTeZEUMMH+EflUff3btImmdOD7jv+GltETgKTAi8kP1ZOsSRoH9eeLsm+Y0H5TEtt5uUoug/QlJZMX1hQNeoJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440455; c=relaxed/simple;
	bh=gHGXhrZOWUzF27PW7grMsw/KKp/8O4H77hQXuFerhXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Y5gRvHiakHO+Fj0sFh6eLLt8YNJE4hNWyreGpim24jvVy+B+Ie8tfdmioRsF/rf98wSweIgM5PHUV3RD9SD7L/xZlHCoGYp5hrVMHspIh7ft0PEbX14UcEj4OTNeK3BE7JO814y0R041MxJF1MzVgmhSwHwt6zrCgZZYf3/aeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTZEflaX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTZEflaX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782440453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OxGcjxwlLcC8nEz7JDYi3CbjxSnldr+NBxZJ+E8h6AQ=;
	b=cTZEflaXqvKwl/mjryT6QAHAOUGWC7fvSeoMSP2w7n/MYuyQ358QmaLu20pCr9qRt8apVv
	DXjv9GA33+Yn//iUCAUTSTbJYROvLT/xUmj59o2PD2qh1HfMyrqosQb7nOy+iKMsxSiZ5F
	hbKJ0SyH1aPhin1mFQvg47Ur8SV/XAY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-GNgrdMvxPR-iT6VSXX0vMg-1; Thu, 25 Jun 2026 22:20:51 -0400
X-MC-Unique: GNgrdMvxPR-iT6VSXX0vMg-1
X-Mimecast-MFC-AGG-ID: GNgrdMvxPR-iT6VSXX0vMg_1782440450
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37df6354960so335317a91.2
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 19:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782440450; x=1783045250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxGcjxwlLcC8nEz7JDYi3CbjxSnldr+NBxZJ+E8h6AQ=;
        b=hqHYJ4zVm867kCSqkY4QrXLQPslnmjhLaVjdCn1ipmFHaDqPtJS/bJ1GHL75urhFDw
         Ufy2zK3lb9eYIdiuVjjnDJoGgzQmpy9s2DBjBxlV1GYS0T8TN8kxQz4XUs2eqyaepwyY
         6VGj7adpLm+WZebMI9IzPnr83YzPCGrvKnkhB1EuTk6SgStCvRHI8S3Lot8SM1y3ZQ/+
         GvyBwIjdmBgow0weBDRVHwl5pobJQzvrPHaeT+UlC0ermUF5Plg2MTIXvS5Ez8FrLuTy
         MTHahy6jI06ACLNGgTwfx473nOgYqEyU8AnQ0ePmFbC7wy2oza9X/q96YN6ru6WvkdJJ
         Syzw==
X-Forwarded-Encrypted: i=1; AHgh+Rryyvy+7AftANP37NNaxetRx17dSB0U1DxJVmYJzm21swwyzdtaEYpoTD2AUqbSoE3T1hkZd3hDWVOvt7JJhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvlZ32rUqT6dO/k65PSHyOivLyzp7MkhIe5RGU6TYMoJHCLnl6
	kztyctvzfiUJvMz2oxuFBn3EKYsRpBpoTAzsZ43o41YzQXFI2FH8nuD9NA6NWG6oJFulIpvR4Ya
	BKxFkghOKr1a03CpEmv62rgZZAZx5a3YqeFxHFWsxmyQL6TF8N86kz1A+QBdgZj6iyLAr
X-Gm-Gg: AfdE7ckPiXdKT0h1/Nc/u2qzNlWOQidUXz7OevmjQpbX+BkA5Gz300ZUI68NFKaYizZ
	6NOkjBNb7O1PkOWLflPVl8/2klGe0Ga2CwwOe5JF0lDmIdoXTHQy6zOqe8mH766s4QfvIMmeSA1
	dtlVg7BMp/Q4uvLogaGx0o8jMFF7cGY3wpMJw23axDtvOeCdxAQhhSKlNjAEnZuN8d/PewEdZbY
	36UC1IunsfQcpZ78E6x5R/cPhtxC9Vh4AF4OhuBEAmKr18oqG7nEo9ZQbye+GLnQh2wL7feLCG8
	i3hvfXXGKkXJAN/D4kV5gk+yc2VFW3hM91zooVtXeQd9L6JUrKHOPJYgMAecmy3gJhNHrBu7/EN
	zpdOSMmBSk1aiosLpz73StQ==
X-Received: by 2002:a17:90b:4fcb:b0:36b:7ad1:df70 with SMTP id 98e67ed59e1d1-37dfa19c345mr4397850a91.2.1782440450278;
        Thu, 25 Jun 2026 19:20:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcb:b0:36b:7ad1:df70 with SMTP id 98e67ed59e1d1-37dfa19c345mr4397791a91.2.1782440449574;
        Thu, 25 Jun 2026 19:20:49 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e058a010fsm1284571a91.7.2026.06.25.19.20.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 19:20:49 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH] MAINTAINERS: Update Jason Wang's email address
Date: Fri, 26 Jun 2026 10:20:38 +0800
Message-ID: <20260626022039.96139-1-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q9lt6lIx4LpIMcth-NnDymbiX6os2sy887UbNCVq8Q8_1782440450
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

I will use jasowangio@gmail.com for future review and discussion.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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

