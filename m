Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404C1A285
	for <virtualization@lists.linux.dev>; Sat,  6 Jun 2026 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780765460; cv=none; b=C+pkwxJIr9+5yPucBSvIZ6QE27ILo8/cD9dLGx8h5gr23mTJe2BQIF2AojVuzSaOcPPkwR7dCaLsFSLsCps+URuKiWk/ARfJxi6RJrFSZEQSlQ1FhDV6zPcTDZWHGzNj8FhtC821SOsuWb4lUQVDt2Myh5/dNtbtj6PpRav6ZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780765460; c=relaxed/simple;
	bh=q2NQZY+epqVHr2W7oOJcKG76cTiGmU8+/2BHRpz2gI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7dgpPCy60rfmmDEYLKQZAp4kQhWxsKw94Gs22/MOoE3CCdrwhjYQRgK/DZAwboDWBilOTj/b7zk57EMI3p1QI/oMj1t5KH2Qnw+iiQlflLP0ln2V6WKpU4dtBB/l+/0QNIjBPSmyjhMowceFwmlEZqjN2oiebOwYULFYO0uDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqOdvEK6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqOdvEK6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce65629acaso34313906d6.3
        for <virtualization@lists.linux.dev>; Sat, 06 Jun 2026 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780765458; x=1781370258; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByUZh0lFBgTCiciJpjsG9ZXS068Tz2mmn6cEtLPjSXA=;
        b=HqOdvEK6n8yF4BN82Ba3i3wwH1rrhZNG+gygYUhEYGG9lrD4qDVuDPIqsYlSSDh6FG
         7c79l5ntAPBc2GsQyVMQc7HGFsd1pFyp/w/vqgZ/R9FfJsX0H7RfQBbd6XzM5JPDau+X
         9l3zwPpKDsvDCo6IjIzLqUy2+IymaZleBEDzWdG4w/UiqexIe4OQ1USB9FEiO5t9yUDK
         41wd55rs7e1WcEY78j1MHoKwuA5uXiEWZ6y1cGnqEzbsv6NKqXx6Un6PN8y3tqfnuFQ6
         EPXQJOiyg2oGxUSt6RzPClPX0IFwIKTYDvzPV+v1P/CQywWTKHhfNOPM+qJlYZaMuKJv
         VeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780765458; x=1781370258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByUZh0lFBgTCiciJpjsG9ZXS068Tz2mmn6cEtLPjSXA=;
        b=TzmG2CiO7yazyfeHyORpuR+DxQAcRfJOQidV9SgrV+q/XqqDVdtpi3OY3PEkGpkYdd
         hdvh8GDcF4FKgv6nYR9M7Y6aZh0+feTptZuzy5Y2TsCz5octPL5sck5S/navat/XCU3c
         Pqvj08h3d97H1+iuKrTqqiVWI99Omw60/zrcJesNcHSr2fYk5SXHHHe1ByQwNP0jm2mc
         14g/iytHKIFQWxkKLvps1ctEDB2kbAXhGg/jgOhK52hHbftUTAa4yuesvG3/ay/WKmeK
         BSDrbIu80dUtCOEN+UDyG4alTzkQlKDxBgQTseBQsR07xz/b7MjtH32wjIOvDgmOo5we
         Z/qA==
X-Forwarded-Encrypted: i=1; AFNElJ/fbTba2gb7tZQkoYxjTLiw7bwuxoKS2MIrrIH1O17dNp8pu7hff2q85BAF9/muuku6OclOPHxN0/WL4IRIhw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyoj0P4r1Bly3B3w927W2X7bLz5wkgAkU8GzsXifmggH/syFdno
	wq32Td/0v7bH0PBX38HqVRVrduMHlm7mDo4R4GlaKri9JgrsJS1TRTOo
X-Gm-Gg: Acq92OHfjws4rOkkvlSXEBlWfVWY1nU4tJPMKqXDUdBenB9EyxhA4O8UpVpxzNa6ti8
	r0cNfe+9lwSmESVAS8HE3axH5jX29piNlhx0uu9iaqS12uunQgx3EJT6PZXBHK6UR5oQDW5/ozr
	ZjrCeeDcwP3CUY8Wz7wMcGuaoEaE0bHWsIJDAVJdK3l2bVj++xv24O1ov/7k+XjXKDlGgSsJiZL
	0mrPPqnkVBExB4y83oqc8ZzcDKEZdgfK+o5qZWnR+puMBz2l49ON18uu1/AIY9zXSUYYWodWS23
	tZeLVBdInM3jkGLx5y3LaFQ0tBSJEOjDcXPu/GwNbKSR5n0QWcXbh0BFZ2nFlUuUZjbzo9aHBEC
	D7QBMeJE3TDHO0NXprfQnREv74hqisbs6YKWxn/2nE4kK7tjD3iN2qffE69NdP3tiGcyOMUy4qe
	AGS7GyGPSyi+diXhRePeA/a4Bw6Mjl+o1u2ViJFfZqD+fL9HQrFV8XNfZESUrstY43VXbPc/uZZ
	omrt2gLcTr42aXF9Io7ZtiOUM47Jjw=
X-Received: by 2002:a0c:f10c:0:b0:8cc:ee52:3e60 with SMTP id 6a1803df08f44-8cee5f99418mr119842996d6.3.1780765458414;
        Sat, 06 Jun 2026 10:04:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fc7dsm112977966d6.5.2026.06.06.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:04:17 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-blk: clamp zone report to the report buffer capacity
Date: Sat,  6 Jun 2026 13:04:15 -0400
Message-ID: <20260606170415.1523660-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

virtblk_report_zones() trusts the device-reported number of zones when
walking the report buffer:

	nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
		   nr_zones);
	...
	for (i = 0; i < nz && zone_idx < nr_zones; i++) {
		ret = virtblk_parse_zone(vblk, &report->zones[i], ...);

The buffer is allocated by virtblk_alloc_report_buffer(), whose size is
capped by the queue's max hardware sectors and max segments and can
therefore hold fewer descriptors than nr_zones. nz is bounded only by
the device-supplied report->nr_zones and the requested nr_zones, never
by the buffer's descriptor capacity. At probe time the request count is
unbounded (blk_revalidate_disk_zones() calls report_zones() with
nr_zones == UINT_MAX), so the device-supplied report->nr_zones is the
sole gate: a device that reports more zones than fit in the buffer
drives the loop to read report->zones[i] past the end of the allocation.

A malicious or buggy virtio-blk device that reports an inflated nr_zones
triggers this during zone revalidation at probe. KASAN reports a
vmalloc-out-of-bounds read in virtblk_report_zones() against the report
buffer allocated a few lines earlier.

Clamp nz to the number of descriptors that actually fit in the report
buffer.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/block/virtio_blk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b1c9a27fe00f3..d50aaf956d558 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -689,6 +689,14 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 
 		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
 			   nr_zones);
+		/*
+		 * The device-reported nr_zones is untrusted; clamp it to the
+		 * number of descriptors that actually fit in the report buffer
+		 * so a malicious or buggy device cannot drive the parse loop
+		 * past the allocation.
+		 */
+		nz = min_t(u64, nz,
+			   (buflen - sizeof(*report)) / sizeof(report->zones[0]));
 		if (!nz)
 			break;
 

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

