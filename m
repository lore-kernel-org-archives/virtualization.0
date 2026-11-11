Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418199;
	b=WFZZnu3t/uyTiTLuzVt79r7eFZCZqClsbkH2LjqyUdBP/7bUKyYF6tWVPV+uNLJezhBw
	 LsP/QLcDk9/R7NAWt2FRpezVQ/hVFEXonbRyd0NU1sYxdfzEgwybN5vjH9uu23bYHVa1p
	 Kwo4vF1xLeuEmVSNGoQUQnfemUUmRT2iKb/AHNUyk3O7+d1kP8V1zvvyS4z46sgxPoZjn
	 c9JsxfvshtpL+aUxki1xNuEFz1aZnU6Xw9MGlmxo2M2Xe3svheYxqoHHCDIt5wGDGSZ4w
	 WhdllUe4K2elsy3G4Oi6kvuSTvupoBxoU4Jg+qGihehuaH8XFtxCA/3rD/Aie0xKiOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hWVnipVnpqlmDrtqQEQzI1nIW+peyVDfq10bD9YNiNU=;
	b=WNQmwRC8dq1V4CZdG+mtwR+KuKJEoR1dHeBO621jWbGcKep1mQwD0dz+aIOPBGT0b797
	 nynnHlVnVXeuQBxWM1uzlA46GaKF6QN4fMhoqEGn4Ma3EsdbkoyhIYZvZkpkdRh5PBCJZ
	 YmDUkvYjSTsb27hDCrAVng8LzEu3YxHFcUokZt3TP6bqjHkZPi3C9Hcldxw89aApNP1ee
	 mAYgPEkkT3Xy4VY+8GBg5GJXIY4bijQ8o8LaV9onp38fq7WhDlXjQfZUDkc4uy1CXV6ja
	 uq4IUy4wU+FaKIgPnI1HL6y8jE5d42n4EkYsdvzS/hOk2/tPYm/iPxA+r48EAL5gb1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBFblN6D;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D422606A330
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 17:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D422606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBFblN6D
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so29059025e9.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794418198; x=1795022998; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWVnipVnpqlmDrtqQEQzI1nIW+peyVDfq10bD9YNiNU=;
        b=lBFblN6D2TeslKWgqgi6JX/KF9Z6mNF+RLnTO0E14GJfwrnUoLy2+u7ZxOUEMBhKD4
         BR/El/Gww8nj5bc4cyjQshFPCZkbrVySUcQCRDnZvNzOLUxjgIW5hjfH0R5rYZhb1F0w
         zund9kni9SGdP7y1kqBxtPcwZHaRMiXvUpZaRlaZWFRVxw0I9itH5sgyhviaWgSrkfKQ
         M3Sz5JYOi5Nt+9MrVd1SerYnVk7TNIBLCppwZyNk+UFKg+uZ/lM2zUucgKDR30AVHDrX
         Tcv3kKhIO6/LLkUjD4vSu6q/D7SVVIHJY2tZDkMLWVVUK4sRzrBOa2vBmMo65sVaJXuF
         qPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418198; x=1795022998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hWVnipVnpqlmDrtqQEQzI1nIW+peyVDfq10bD9YNiNU=;
        b=v3L8Ghr7HHV+sX2qN4uVMMhWTPF2oixRWirWa0NhdDnnixwGijwknc93OTigmK/CLs
         rPcUyi3YzpLgNsfSEA113EP8loAZWLkHNPlQ9BemFt2m4jL7oFQAXKzimoq4bukHIVML
         L59wjwg+1yb4+82WlVHMfd5szu6cwyx7q0sJq4aYXKhkCL02q0bdVi8RDBPx9amoRfel
         f85M+lS60qFN+HpBZN6k4hbnVYcURr4iQNlIGKIqyZ2QI2Ck6nIBgf45hzF0JXc0KKiX
         zZU0E9MYabAyT17KKOcK0AOyb8qabksIPUjhRod3ORdo9VWw4O+X2+St2WcPZoxGzHH2
         Vyhw==
X-Forwarded-Encrypted: i=1; AL+hErHT0puO84+AinEHGTfCxl3DVS9ARHzhIdjY+YwikLdChIWSl01KsYeBdGBW8Ou/NBbkcQBr0KBR+7bGeAS9jw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9rvrnDITgevQKBX9yg9+3jl/1YzHbC7umj0KF6yrXXBFU47oyu
	trGh17yCU2g9+ujXbdk4hAjM40YWZNOq3X3dWdzNAWiU25Y/gow7uqZe
X-Gm-Gg: AYBFou2Vw5n/uyReAlKiSp0gOwW0VyhovD2lKYveOouB3+tBZMBeZGwM2jCu+x+lgrp
	wKM2Hnw5+z9x/D0niYCqLpYkhuKJP12f2VdB1YY6jZFv4aazJurwRfu6trmxrmZr77Y232EYyEM
	2hdSeE4/aWGu+KPWoVsooA8TWs4PG/sZzTGpWsyVEfH6/hKYuWiKwIPsiTLCqvkhbVaUPrublEy
	F+qCK6tnIpPplVoMV1M6k00ph78XFSAbN9o/v4g+n2/zy1inFwmQGvGkRUDNlEwux/E8Gsp4Tch
	FD1lYouyYSa6f0oRnMvOa0NTMcZ8AbSig95xXNoS8igOMci9OvnHQpSrdvCLZpCi64OyoVejReO
	Pxljt5rh2V24U/yvvPKOMms0wci6YW0qU+0xYHXtQto62lC7yaT38rA2mhtrt079R/0e2gNJHi/
	91RJUEPMqXTFxY9sMVMtoaOcZjqy81EJrHr/yxAbK7lGamOD7v2Amw2uph1dyxVBXACLnkKDykq
	fLmcW4diBAaU6inHGsVCGH/x1ym+EJDlf+vesIYufTHsCe4vKjpIRNo7pkOnabdzQhXrp5iIKsT
	qUy85bX5KvhveVO1L4Kuh9VBhG8zI3j7lHOIATvNCGY/CvAl5nLMbBlvrNSYXNgypdb67TSVUqx
	p
X-Received: by 2002:a05:600c:4e45:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4ba0936efc4mr61545245e9.14.1794418197595;
        Wed, 11 Nov 2026 09:29:57 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:d655:6a9b:5ab8:7f68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e26700fsm3134525e9.10.2026.11.11.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:29:57 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] virtio_ring: reject a split ring size that is not a power of two again
Date: Wed, 11 Nov 2026 18:29:37 +0100
Message-ID: <20261111172947.3579982-2-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
References: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The split ring indexes its avail and used rings with num - 1 as a mask,
so its size must be a power of two. Commit 2a2d1382fe9d ("virtio: Add
improved queue allocation API") moved that check from
vring_new_virtqueue() into the new allocation path, which
vring_new_virtqueue() does not use.

remoteproc calls vring_new_virtqueue() with a ring size from the
firmware, checked only to be non-zero. With 100 entries, for example,
the driver would put buffers 4 and 8 in avail slot 0. The device would
look for them at slots 4 and 8, possibly reading the wrong data.

Put the check back for the split ring; the packed ring has no such
restriction.

Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
---
remoteproc still reports this as -ENOMEM, although the "Bad virtqueue
length" warning names the cause. Returning an error pointer from
vring_new_virtqueue() is left for later; the same change for
vring_create_virtqueue() is here:
https://lore.kernel.org/r/20261106055635.3019889-1-stjepan.poljak@gmail.com
---
 drivers/virtio/virtio_ring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f683a2d6a200..8da9bd0e70f4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3513,6 +3513,12 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 						    name, map);
 	}
 
+	/* The split ring indexes its rings with num - 1 as a mask. */
+	if (!is_power_of_2(num)) {
+		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
+		return NULL;
+	}
+
 	vring_init(&vring_split.vring, num, pages, vring_align);
 	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				     context, notify, callback, name,

base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
-- 
2.53.0

