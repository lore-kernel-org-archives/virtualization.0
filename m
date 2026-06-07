Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9283254B2
	for <virtualization@lists.linux.dev>; Sun,  7 Jun 2026 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836537; cv=none; b=uudZ1epMPqn8XbO65lm6TpBByKQJnH3cTAiNnpUD/fzSp9ofVz8aPZeVxiw9lOckG49z+E3UpVFslv4M+SELn2k8Is7w8muApW64vTLmhDPNUmjwwbfiycSVgvhZ8nrlJWbXY9MP4z33cQxAKqhP0zsOszu2vCs0O1c2CPZMGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836537; c=relaxed/simple;
	bh=BV6AJGuw/xsMgOxl9SY8FG8RrXLJqtI4CTPX962LxYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezTX5ZGaIz0xJsfuzUhxwH7NlEM0yNX7jO7cZe2U28oUyTo7mueQqVBoxlKTOgr5tGz6XWcmmjkhsF2yE7aWX+OwLDj+kAIsBSceBkMIC7BdPvX1W2e0qiSojkwAthN9E3ZihbAJW8wJEh1XJgp9JZy30vrr+hzhcFbmHLpJo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB0+Rr35; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB0+Rr35"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9156b74006aso245274985a.0
        for <virtualization@lists.linux.dev>; Sun, 07 Jun 2026 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780836534; x=1781441334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/ItvRwkdkhyOcV5EUqgABZkU2mcEZg+Gfh/gQJ+RwE=;
        b=AB0+Rr35GRWTsLckwmThSXGUu4JH5k6KgI6iROH2DxLxNqMgTPzs2fm++aMhdvJS50
         Ox74qDd0Ehk7e72UtR6q8fZ5tWj6aWbtpc9ouUk0wLh/T0PHuro6ZtcSujD0ukyXIYxG
         hVIQ9pmGLI74dYLp/T8mcUI2OY6u4dxLlCRbJbUHsuXCoeb1nidLgX8ZNdPM501jE36i
         EaPuim+8vO2ZT3uHeNr31NZ1JOiRH2kbj8/Y0/fbb7Vqs9VfTiAkiVa3i/cID1xMI1gy
         98f3p5a30CzfgLrETurwLb956W5qp4dW+IeEmbwC+viGrm16+EYvTU9mwZyu6jlfVkRK
         NCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780836534; x=1781441334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/ItvRwkdkhyOcV5EUqgABZkU2mcEZg+Gfh/gQJ+RwE=;
        b=rPX20QqpkknynP/InvINw05YjWgi5qqSkxGRACnJZA8NGjAiUIAIYITdbQBHxq0uQ1
         jy3xVrNaQvAY8aaKSbAZiu7yw4k0/y77mrqVeRmy4tYmxmhC8B7LY+qWIZKTsbXWntnx
         JOGSV2pEnlP/D/WRM5nidN8J1ZzjNkhAR09KzAwDx55J5Pb73g/GmATWkIIVER+e4rIr
         de1Nbvrcy2V/F7k8MoEvW5mrxJsiOnadZnIm3roEsMs2hvB4wVBMENOCOJekZ30gYj+B
         SzVXjjJi+kPJa3k0/gbOnGNrczFdweNy/mIM9Hf1SolfF/cdH9CugUZ/2eZXyYUhE8pU
         YQeg==
X-Forwarded-Encrypted: i=1; AFNElJ/IZfg7/6BbtciS3EanN/XbI2QKmljMYo5e0gBx70+HugWAZNUtdB0UWEqmjJurL0abkOLE6Nfx9CwY9KTMpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym1ryzFosqAZuoFHTfVXeXUXQEmw/bZvBwUFZH4fVuADobiLhz
	TJrPPTrvjuydKyxnONt4hTdG2vkTUaUw/ew7OCeDbhQshe8bH3Kj5QuT
X-Gm-Gg: Acq92OGgpEdF2EUO7lAeIn8AJlm0HjqG+GsJgFyKsqSYlxEIo1ZMO/c7IO+bj0Puda/
	vQAv3uCDuvTfwUpykNC/R3t7a3A9qIhjTKh59rhgAheY/u1sK6nAsoMlIi0w0vb/F4v+2sdMngE
	2JW1dkMNT+FiyN3AqL/I2iiNrgXRaaNfXsUwTG/t+GkdBaDOJX2dvEpK94MQPV+Hyemlwq2b6jL
	rybyWwXnpyt4N+XuEke8zU1QQC/rR+b1yUu5BrderOg83KTuVVkA7y++7r0Hw28Kgt5B8Eeb7uM
	B1Tznbu0AECnB3r/pBvx4XJZv3TwS82V3J/cBvl0Qhzn1zTxUVlOJNyHMCFIwz4ljO/Rk6wOxsn
	5INjR3sIglfpA5J90kQJXk2ux88/jX8btShzytsJsL2bt6EZuw/GnHpI2L62OS/aeVSFuYxMmsO
	DGRhaY3CmRk2l3yiAeme+GKmulLFt5Z9G6rp2rQRK5oNxj+qXjqSf/Qo6W2t0o47duFmDyakZSx
	+4u1RWQPwbnBl2fxvgZTte3ZNZWvPg=
X-Received: by 2002:a05:620a:1d01:b0:914:bb8e:915c with SMTP id af79cd13be357-915a9cac9afmr1892160485a.22.1780836534090;
        Sun, 07 Jun 2026 05:48:54 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37cae4sm1419467485a.29.2026.06.07.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 05:48:53 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio-blk: clamp zone report to the report buffer capacity
Date: Sun,  7 Jun 2026 08:48:34 -0400
Message-ID: <20260607124834.3059944-1-michael.bommarito@gmail.com>
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
v2: drop the explanatory comment per Michael S. Tsirkin's review; the
    clamp itself is unchanged.

 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b1c9a27..32bf3ba 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -689,6 +689,8 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 
 		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
 			   nr_zones);
+		nz = min_t(u64, nz,
+			   (buflen - sizeof(*report)) / sizeof(report->zones[0]));
 		if (!nz)
 			break;
 

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0
