Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D41AB500
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942286; cv=none; b=juo/+oWJFIEQ6A0HY1BvjWnbMavD/SLMqCCU+crfn/PPJp1gC180RnbUrJjyDi5EBuOKwUhedV7kb6z8bJYiEEpyhFCLz7VidEptIP4QLSt5cI9CNvKoIcgAxPltYH81BWIIsLfSd66PzVXXgH5/iBvJbwBhc4BP1sieCYzgrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942286; c=relaxed/simple;
	bh=kO6eLj8b5GtxEvWv1FM9fpVAw32heo0eC6Eie2vwPK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvVot8zbmPfprmTkoUheJL0wBDT2Om0i2eP30n0BYDa5Gy2iebja+uCplvTWefTU/ntxzKpUmT953JeAJbqk8yFkVSuNSL3tgMPJhTU3wEuPOBZUCgABrF5oxwFnorn4AzcbzO2pr8Lmz+okpotLV9wwqWaxgekfXaibnC/CXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Si2uskA+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Si2uskA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724942284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QA7bpSUbSKgzhSzKQGbcEto2ZPij1K94G2+gp5Ocka0=;
	b=Si2uskA+C7pZ9SqE3s8PnD2StOTNO/AqveYGv5bGgAEev4i/kPlXBJSRk/6zRjNJtsbziV
	NEFeOQ0RmxR171Qk1JMkO0UulYPQgWqAuRnU1kQRfB5UX6olcAdnRW7/l2aS0cxsii1HSE
	66XxHrC/X9ukL5jmbxkVmEnme/oOroA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-LMaS3w8_PSWtxTTP3iwFuw-1; Thu, 29 Aug 2024 10:38:02 -0400
X-MC-Unique: LMaS3w8_PSWtxTTP3iwFuw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8677df5ba1so70352966b.0
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 07:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942281; x=1725547081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA7bpSUbSKgzhSzKQGbcEto2ZPij1K94G2+gp5Ocka0=;
        b=RxPbnFMVuPNkZa2JT7htd9c/oZ9dpCMpAiFp78DpTnAMpDbKwkNlGLF3fdJh3oOVdk
         jflqrE2TbIvdNrLnf7BMTcw/7OR3/t6rrAHuKezHa83kJ7fC5+jOdtOj/SNvBFdi7fnR
         VbwgKT+lBy5pXIo/AP4t7yfiovjFe53QBedicbUSFpgkZHPRMvVtACn4ihrH0zJ98Qwa
         Z/wGPvZNKymFfJCVcUyL9wm5UV3VRhBIM/5Qw2E9DJMF5w/ykppvksjY76jIWcIfbIbF
         0CnGx9Xd/7nZRoi/5t7MzR+jZqcB6YwR3mXaYq2mLRGlb14L1g113fjeGZlI/MqxksY5
         ULEQ==
X-Gm-Message-State: AOJu0Yx5TGGhpsYyqv7O81tv4EOjAw0CLThRtgaIbTXD+W1eJmXw1isN
	o+guOYld0eq6M7gVWl9p3xDx0UHlkDTbPhtmDKkofdmGBVsIjwI/9RtB2VnEDme0xfBmb8VdnJ5
	IbXWsQ3aiT4tgpJuU2RStfy+DeRESS34qKnRJDLJiesC+LdMFYfLs/baZ13ST7TD2ez7ctf1TMV
	VSzveYiiNTAvgn4cS0DubevsJKQ3lLae/hU0NvH4+Izwd85bY2
X-Received: by 2002:a17:907:9726:b0:a86:8cfe:ec0e with SMTP id a640c23a62f3a-a897f930bfbmr235825366b.36.1724942281343;
        Thu, 29 Aug 2024 07:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOsYeMoocTHM57DyV7DV7gjAjfbPxGEazD11vV1FPO79V3FNyyGgNXMYOj2hU1lGbIQbSmFw==
X-Received: by 2002:a17:907:9726:b0:a86:8cfe:ec0e with SMTP id a640c23a62f3a-a897f930bfbmr235824066b.36.1724942280376;
        Thu, 29 Aug 2024 07:38:00 -0700 (PDT)
Received: from step1.. ([193.207.133.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fef4c3sm86159766b.32.2024.08.29.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:37:59 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH] MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
Date: Thu, 29 Aug 2024 16:37:57 +0200
Message-ID: <20240829143757.85844-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The virtio-vsock driver is already under VM SOCKETS (AF_VSOCK),
managed pricipally with the net tree, and VIRTIO AND VHOST
VSOCK DRIVER. However, changes that only affect the virtio part
usually go with Michael's tree, so let's also put the driver in
the VIRTIO CORE section to have its maintainers in CC for changes
to the virtio-vsock driver.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 878dcd23b331..6dcea63f396e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24218,6 +24218,7 @@ F:	include/linux/vdpa.h
 F:	include/linux/virtio*.h
 F:	include/linux/vringh.h
 F:	include/uapi/linux/virtio_*.h
+F:	net/vmw_vsock/virtio*
 F:	tools/virtio/
 F:	tools/testing/selftests/drivers/net/virtio_net/
 
-- 
2.46.0

