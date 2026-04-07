Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F423B5825
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565550; cv=none; b=eDtR1XNVZLZUyDoQZlV88kohBP1AGPt5URaOSi5JRrSQY2YsK8Fmsm6dxBwUCGbfYn89tXhZkNU740dKxtOqtQ3itZk8szf2qCztcrbw6gkWNdubFl7zPACA4/c51KfzZnZpIaZCKvTq3WxLPwIGhjrqi2S0zT3ETyUEgtY7UO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565550; c=relaxed/simple;
	bh=LlczePmo11HdAiD1y4SIKSFtV1mmrXtB4zyncll0Ma0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+P38T3n/sxGgq6ovKSjPVX2iOyJOfQZ7G2f/pUfYtiqYTlSve4oGAJXjq5KUaK558NYAD9yvDS0AXucj2RPj3ji2BWonejE8MpoZRq6pi0WC9gHOuCTrc7oPFS8tBPLb9srwT7qa+q0abrZDJ6GnREioGl3XcPVmgEWP7zRwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdDO6/kS; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdDO6/kS"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d2945e6adso82543071cf.3
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775565548; x=1776170348; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP34ylb0h4VC7XqpC/PSCn9O+y1/BrWb1sbpiz6kncQ=;
        b=KdDO6/kSXtEWxQTW0GVTDyEGXFaOVwAgsTldu+QPw0dTU3uKZJsHPsSet25LBbxd9k
         XWS8wlEmJ/K5bpU608ImxUk8QXqUurR+eWkFJYRtNCGWAA2KtXlGyQAnOL+sn/dGik+h
         w6aalvxoO6KnO4FPDqxLynYN+pmGGCboMBwc7d606/kJayoq6YM8qQK6xwQVxYb+drei
         qw4JwSDbt9V3DFW4HkFU9dZG3HG3qG8D0vNw4zl0q/Rz33lChnkPN0hrigRkGmoaU3gU
         pd3ThdDbaLsFDA1GglnSpBG/nWlMmOkh4jdIqgwnDH3A9zwPdQFGlIjsJJbe9bWj/Seu
         UKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565548; x=1776170348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RP34ylb0h4VC7XqpC/PSCn9O+y1/BrWb1sbpiz6kncQ=;
        b=n5wloTjlLrsVe+Rw+5pZyD0beq71QbH7dRP0HHZvbKhXKjnXhsFyeiKxQTzYsHPbTf
         5TfV2A9vi3Cf89PxsTE4gqISZFs2lWLReAd6bVzzMYcU82tdq7Xo+QLZv7KPRZLhqD+T
         jNVvZYsbqI3VOjlrXDVWDfxjffdGQSbRlC6nWt0FGdQjJgAvPy6VA0AX/nalH1lpQzTn
         FNdkGdFEko2FhHcECXzszx4VTwGK5QxAa9mv4R43uASuodDpgqqAwc7zMrKpdx8bJG1i
         8/nyN6c69tX028kY4VPnCQEL+PV401r5EqwuDSyAoOxOjYnhdUjfNPd8Guz6XSVJeYay
         nDHg==
X-Forwarded-Encrypted: i=1; AJvYcCWdTkezTcivdwJRy9EzfbTeB8pOFjSr/TXh1/c44aoR/JOPZnZFxO0RwItPcyzY6md+O5KOn/rcKLKwG0C2+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO2Y8axuitSGIpbLR7G4Lh2IdxJcBEeza4IDwm76gwzXZj5J3S
	z35thmj36GRadA8by7j6ygDoDzBp0iWNBTqnWrGKWTqArDFzGxCs6JzZDTITVA==
X-Gm-Gg: AeBDievYZn2Aq0ryQXkrpfUuAKBL8C+junRIRoJ9O2H88ywARcrCOdLi68M5KuQbXiM
	jg7QpGSCE/8MqHaFzcIQJrP9ZqMJI6egqfnaO9FBwQpK0QI9ENgBhuQxL3ZJXIWwVbS+MxbZdhG
	T7o8cguFy9qr155MHKEnQXmfLBMy5E6O+Rz6Q8njU81xPzuIgWo4MXI4j2SZaLmDSgz2AAXc/5H
	aQ4vOtPym0By2EI7XUlaNj3Tb1tcZeK/RVOZo4zlcK4d62HXkCELkajZbBz1V1+qDIERpbEg7aj
	FvXlFBxgU9U+zFZPFJHuh8XNSW06u/nisv7/BiovKjzz8DmOLDUdom6mPK9vQknYuo1I84BSihv
	sUPWQYgKWAOolljCVasRJAOfCc1Qgzr+Gtv4YkpblY0TuK4w9T9Z5TXEckcJykXVKSjOLc+CDvn
	KZH/yS9j51Z5KA7GrDkIKH+BW4F/9gz5c+n7/ZyO/IswOxqDP6rYaOPeJWWednPdV9uGANCxlru
	W1NcL6EZxCDGg9KfCDBJjmoBTeaillE7ZD1UbxXlh2mxa4Q+hU0U6/7S3dXT9CKMAwBNQpO7XDv
	BDShYdP+0jdFMIaGNn7jCBCwqVSwpbo=
X-Received: by 2002:a05:622a:6204:b0:501:17a9:5ff5 with SMTP id d75a77b69052e-50d6274e40dmr231091901cf.21.1775565548319;
        Tue, 07 Apr 2026 05:39:08 -0700 (PDT)
Received: from localhost.localdomain ([2600:4041:5c46:7000:d80b:4b87:c7c8:bd46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4d4a034asm133005611cf.6.2026.04.07.05.39.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 05:39:07 -0700 (PDT)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 1/4] virtio-mmio: wait for status readback after reset
Date: Tue,  7 Apr 2026 08:39:01 -0400
Message-ID: <20260407123904.6390-2-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407123904.6390-1-astellman@stellman-greene.com>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio specification requires that after writing 0 to the status
register, the driver must wait until the device has actually completed
the reset (status reads back as 0) before proceeding. vm_reset() writes
0 but returns immediately without confirming the device has reset.

Add a poll loop matching the pattern already used in virtio-pci's
vp_reset(), which calls msleep(1) in a loop until the status register
reads 0.

Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
 drivers/virtio/virtio_mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c227..a477977 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -56,6 +56,7 @@
 
 #include <linux/acpi.h>
 #include <linux/dma-mapping.h>
+#include <linux/delay.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -254,6 +255,8 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+	while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
+		msleep(1);
 }
 
 
-- 
2.34.1

