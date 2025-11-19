Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9931ED79
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535371; cv=none; b=ED+nssCeskzQSRelJaVX6PurXwYVMSAvVcWNdb4E+pqXfYU8F4t92FK04H47MbwSvDycg6qlmFhm+1s5Jf6+Sm7uSF8O9DHfP8wbg+OU0/oV7+6B58Q7r3SUX5x9WGk0HpvbcznG5kQFgZj5gVlY7Z5/P8hjcf1LMWg9sVOeQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535371; c=relaxed/simple;
	bh=GyfSo7GRhRJcvExEgBEBjmrBQ6fPTWANuTch3a+uOeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ulDvu5VhbkCUIalKaKusG5hvjwcjnrXSqkCei35nsSqzngHc/UbsgnyZh7WrLuo4tU414pHAtOx3Oy5VXYxMz8O6Ddai8lX8CxQJu6c3lyJkId9JmEjcM1scXtlhoVBR95uOF8O7Y1FuIPMs9++80nxEfZIJ8NbDrcH/bXNNUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahxuepY3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahxuepY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763535368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1GXW/47p5KYAzR+xLHfgvFAZFeojlBZnCiCIbgpKfrU=;
	b=ahxuepY3wFGuxQxRS3ODEiPyBhIghq59hNT3rEmVY616WTYnK9NIy4DfXtw+i6dUwTMMdh
	EaFfvOeDx6nkzZDd/9IzgZ7UApm0J7pUGe7Bupz1ZLOwtwNPF5dyAk9NBPcT0nJ7P/RmsW
	2koH/PBzYVSc89VvfSfN7Yonnf4ln7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-MaHQ08TWPDSZYqdPCkpCHA-1; Wed, 19 Nov 2025 01:56:07 -0500
X-MC-Unique: MaHQ08TWPDSZYqdPCkpCHA-1
X-Mimecast-MFC-AGG-ID: MaHQ08TWPDSZYqdPCkpCHA_1763535366
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563e531cso57938845e9.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 22:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535366; x=1764140166;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GXW/47p5KYAzR+xLHfgvFAZFeojlBZnCiCIbgpKfrU=;
        b=DZS8DurF3fedxOkoE0rvSlNoh8yOM2byskGH07btjlQNTbOZoD5VJ1RNTL4Uiya/sc
         oK7sHMBoswWQ/6Aa59zHrQZgvXo6a0QZEVqV3bZbRHT8xGCBTDJJiAYD1HgzwCnyaw85
         gsg/W/oi7hLH3F8DiHEdS0Ob1IaYQmsk38wn0szQG69ylwm4N1S7twxO7u4yuePNH/0E
         zStTnr3BoqwrZQOW99/B518dyLWvj0dKnfznC1xVrM6UBV6x5jkZsr+r3n6c89ZxYSQl
         T6znWjGpPgpfiFGvG5em/TqN7L9kVIF9AJYsqFVdvikl2DRUFoHYcbizf+xmH8wwehxE
         NBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWanM+lvxBF8yxFHH37+BsvuYjLAoqj4NZriMy2Xa9l+8ddEARRPKnzTcZ/eiKp60dn6zS3z9rJLI63qeVDew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8I36sjnG13wvwyquv69s5YQpjDeyK8Fw1aYi8GeIz6poZH2T3
	v2SvT61CJTECjUnlBWYGgylq5V5qtf25RiZCJmNtIQtHq3HeAzUMB3isBpPf+6zqJDgbFa1mmXm
	8Lc3zF6xELjdxrJuXinciNf9jjDZ/DLZtyRmEkO5i5m20qxcFu7Zj/5vUIAGFqxWkZaf/
X-Gm-Gg: ASbGnctGKhkEBc7tmElFi0fWWOAHe9O8Q82/Qv5ix/YDiGyPpC1XY9dUCmwoTzM8JKY
	wf7yCrg28web1qm2fDyI4q+oR85LfkxH61Q1hdP/qV4fck0+/QjrutAGXz9wDYIFIx+ahN/9yPq
	B3VjRUMNPc5kkDgKhEbMBcRvTkDx1w0yih4Z38ngFKgQSVEdCxPVlHENbHyEl8mkdzFDMDAzJy2
	UpFbdxxEFnlDoNhGPUg+d9Qasacgo9MhpoRkGBOSbg1FtoqpZ5NVAWFfLnIf8OnMUyz2lXxJToO
	m3oEdgtEofJEpzLuuOtTOpc99uTurEQZPUe2/yOY8/jOQyVq9S6EzCIjzaY/o+qNTXF6bMu28N/
	ugnZx09CcOIpqu0LsFetW4vKy1CjB6w==
X-Received: by 2002:a05:600c:1f12:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4778fe9b250mr167665415e9.20.1763535366053;
        Tue, 18 Nov 2025 22:56:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEetJ08lSQkJzMIG3q3l0sJy/M/dXSieWoKBbfoeE/JkwOCxIrn4ihXVjwkL75zuD4vBsqxag==
X-Received: by 2002:a05:600c:1f12:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4778fe9b250mr167665235e9.20.1763535365687;
        Tue, 18 Nov 2025 22:56:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19664sm37289405f8f.36.2025.11.18.22.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:56:05 -0800 (PST)
Date: Wed, 19 Nov 2025 01:56:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>, virtualization@lists.linux.dev
Subject: [PATCH v2] virtio_pci: drop kernel.h
Message-ID: <7a73b6c6af67e13b86633cd7bf11ad56b5d9809b.1763535341.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w3f-CmVC-FkCXH6nEG1Osrc9f-GnEvdym6mbS9SYk34_1763535366
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio UAPI headers really have no business pulling in kernel.h
Replace it with const.h which seems to be what's needed
for __KERNEL_DIV_ROUND_UP.

Fixes: 7c1ae151e812 ("virtio_pci: Introduce device parts access commands")
Cc: "Yishai Hadas" <yishaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index c691ac210ce2..e732e3456e27 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -40,7 +40,7 @@
 #define _LINUX_VIRTIO_PCI_H
 
 #include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/const.h>
 
 #ifndef VIRTIO_PCI_NO_LEGACY
 
-- 
MST

