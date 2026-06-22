Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802536492D
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161056; cv=none; b=TIX9jg5eh0w1GDT+FR3F/WXGdNH/eEFH1FLOUZq4XQA1RQZL2hWPIbbKQwGgEqjCbHx1Hp4T5kVKfboPFiL8r9Ch38iQVjOm+Ppvh+EXpAYAtlUGeRFQEn+AMK/jgEWAnToLgsupEse4HbOdJ1WgohRzAajDx7jeMUcq+U59EME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161056; c=relaxed/simple;
	bh=rZdLN5tzkGsE01tHBYLqly9HFJvaHp5kpnYWUOkPpCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TqDEq0WM3zR/rpn/ivZz2JSzcQfTk7nvscVfYKH5VjwCDonz4O+TVxEH2mP8ZX0rWUCz+8ANXHDDal/uWAh/A+8WUspYujifFstnkWCgMfsfDVZZY49BeCx/5trfcDLt1f1Y4AmF/a+gHn2UwID+aHA6eToRYEYKuGGaxAI2YzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLX19o4B; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLX19o4B"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-517787172b0so91469141cf.0
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782161052; x=1782765852; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=56mHhpj/siMw9Lq+ab4+IGXdy9XN2OLNariufEr+eMk=;
        b=LLX19o4BYqPNUcElrDzBpxQ//oIFuTc/XwG+KHSm1brkpFnDWTqsr+MQw7u6BZU094
         yrVYr+oZip4OHc1xLZTDNQ6fP1g6J4qStdhNr9G1skK6oN7eWyLtwdf/7kKcfmZB6s+a
         4oofUX7CTeyZ7tdCFihkTBgyJR9LipOHSq8L/WmilxCntyTsbRDPOYyZuHe2sFO8nBgK
         h8erJHMBG564qZ9iGlOltjN1rg0ZayrtPZ82emJczBylNijFjzdcs7xoc/aKjgyPiWWh
         bvMkPiH3JyUTx+O3FUYU1y5bnL4gKek4MGaACSaAe5G9GuUJV78T5p7sy277ZPioKTFU
         dBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782161052; x=1782765852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56mHhpj/siMw9Lq+ab4+IGXdy9XN2OLNariufEr+eMk=;
        b=D6GC/isHcmjZeY2wBB3FRFAZ+hIiHJsR63HJnSo0HbLvXdj27MSs/zEUmSw4+KUhRR
         Qh7afQkNDaEU2fUG8kgDVj+dUe7Eq5gaoeUNlIPKswV12lVLNuJ48Lwgkt18Yow1/4Hu
         t9rJo97u8YqVMrufcPGn/MzwH6M3f5cMrJ2yYi/zyHlcYcOe4EghIGBP6src2fieyT7F
         ky3A44HWbqdl1iRlXCVhXseC4dXUAE24LKiMNcp1SLnOj0pDMeNBRrlxB2QjhwCUssfm
         pXeHaGEuWaitK+sxPEleIzGfdAK8ZiUP5UTxVZjZTpRa/GGP9l5mmSVqcBjGupzZFC1t
         J9Hg==
X-Forwarded-Encrypted: i=1; AFNElJ+Nt5JEgrDwKTC1+EwC7XuUzxxJcg4Jlp8MSlzTqG1FBwoAg6ZWS4bjBNttLICEKctisXyU6GWI6gSZrH1T+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YziJBUhm6siCDProT9BYqglGpCKlBoKnIpuLvaDwd2t8n+/2vO2
	3nfFs6IPswj26YpzuOoN6Huh/c5fxdd2QM8JNMi0HEGQ4VcNiLsLhKcMxNI+qPRjXiHrVkhanlD
	GsemAj1Ip0peApy4odMjiZUTiQAGL
X-Received: from qtam14-n2.prod.google.com ([2002:a05:622a:e10e:20b0:516:d746:4e0f])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2d0d:b0:519:f8e2:dae4 with SMTP id d75a77b69052e-519ff3f4bb9mr159603471cf.39.1782161051759;
 Mon, 22 Jun 2026 13:44:11 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:43:42 -0400
In-Reply-To: <20260622204343.1994418-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622204343.1994418-8-briandaniels@google.com>
Subject: [PATCH v4 7/8] media: virtio: Add virtio-media to the build system
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: acourbot@google.com, adelva@google.com, aesteve@redhat.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandre Courbot <gnurou@gmail.com>

Add Kconfig and Makefile entries for the new virtio-media driver.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/Kconfig         | 13 +++++++++++++
 drivers/media/Makefile        |  2 ++
 drivers/media/virtio/Makefile |  8 ++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 drivers/media/virtio/Makefile

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 6abc9302c..7bc7306fa 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -136,6 +136,19 @@ config MEDIA_PLATFORM_SUPPORT
 
 	  Say Y when you want to be able to see such devices.
 
+config MEDIA_VIRTIO
+	tristate "Virtio-media Driver"
+	depends on VIRTIO && VIDEO_DEV && 64BIT && (X86 || (ARM && CPU_LITTLE_ENDIAN))
+	select VIDEOBUF2_CORE
+	select VIDEOBUF2_MEMOPS
+	help
+	  Enables the virtio-media driver.
+
+	  This driver is used to virtualize media devices such as cameras or
+	  decoders from a host into a guest using the V4L2 protocol.
+
+	  If unsure, say N.
+
 config MEDIA_TEST_SUPPORT
 	bool
 	prompt "Test drivers" if MEDIA_SUPPORT_FILTER
diff --git a/drivers/media/Makefile b/drivers/media/Makefile
index 20fac24e4..357e786cc 100644
--- a/drivers/media/Makefile
+++ b/drivers/media/Makefile
@@ -23,6 +23,8 @@ obj-$(CONFIG_DVB_CORE) += dvb-core/
 # There are both core and drivers at RC subtree - merge before drivers
 obj-y += rc/
 
+obj-$(CONFIG_MEDIA_VIRTIO) += virtio/
+
 obj-$(CONFIG_CEC_CORE) += cec/
 
 #
diff --git a/drivers/media/virtio/Makefile b/drivers/media/virtio/Makefile
new file mode 100644
index 000000000..1d69d5fd4
--- /dev/null
+++ b/drivers/media/virtio/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the virtio-media device driver.
+
+virtio-media-objs := scatterlist_builder.o virtio_media_ioctls.o \
+			virtio_media_driver.o
+
+obj-$(CONFIG_MEDIA_VIRTIO) += virtio-media.o
-- 
2.55.0.rc0.799.gd6f94ed593-goog

