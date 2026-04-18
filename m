Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2D2E1F02
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776470438; cv=none; b=L7T79MOuFojtD7w1pOYYsrKdYYORDizkjLbsUU0deu41YgNVieaMEO9nU4/rMFODtZwEIn0aoyQ91V5JCGu8fguLaCsJFQZ6ls9toRdn2ad4xt9jTbgIMQRuz5qF1YS185diJSPTWt8gTtoegQF0/ZtHckLM4MaqdIGU/gbFNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776470438; c=relaxed/simple;
	bh=VgKe8iFflgwtOjq/LvxdBo/bfxTBZ9KGHbm3sUMHjCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPP2V1mn1z+gNHwDLlMsxgXD5SU3oz5MDHskwxEw4/V/8aSU6t4MQfFonRp9k22GJ8AmUXa72Q4BRnTodEDzx0Kw4i5f+2sl5e27ARGzq93iDsd/ZSoHYEDUlvwppYA2eU7oWcK4ORnUjocTXpvaYCjX6X2GvQGKvN9VmYL5gZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg8WDxJg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg8WDxJg"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50babbce85fso15229571cf.2
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776470436; x=1777075236; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvNKPemwZlMkOovK4sC9B+rfORfnUbg+z9O/DbhsGC0=;
        b=bg8WDxJgz/gSmp4WSRYnU0zxDji9vDTLkvuDYrwvhYwN8h+QYUeowXiJ5/yZOkFOCa
         oh6JwANz/vWPZJ6ssE+J96AQmkJyOynoyOOiOJTIyvuu7ZZvrJ0sBUcCG8Ab/Mf8GYJa
         N80rEk0UkmxN17zGHE1aSM6aM+VNsvPMfHhyAxb5J+LYoIf3sdz4d7IhvFeyvoPzAvMk
         9MfaW7WshbsR9AsFUIdeFJgVIFiqTGAztKPIa0XB597hv+KwQOsItsd4T+U8Vtz3yMbw
         6eqFRJ1YcCfuXNah5VgEr+Yz1P/aNTBHWOzbGA3lWpt57j8/s5jPakCqNkIHSeYeJUL3
         SfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776470436; x=1777075236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvNKPemwZlMkOovK4sC9B+rfORfnUbg+z9O/DbhsGC0=;
        b=RYKvtotots4pt04En7xD2ord/aB/jZqUh7MHIhdfYvgtM8Y9m076LupGr+u/95NOPj
         jhxjJmVrolSsWJJL4yWlIP16EKFiYB4yytID9yHObGjs5xjj8ZU78SzJFg7lyspwrhTk
         qYQyGz+9C6jqn6tSuLiv9iBz9qNrupn06xw71htYTe9sQtS8powyxD0HF/8a0Ra9iCaO
         Me9RK2UgPNsGYTOzWoH2CD/bKEBwQ2DNGHYNFlw/8Vjl3df8767e1kFQ+8cDrM2G92+k
         f2x1/m9xzk0Ew50WnMvgxRQn63Gf3sZrliNc7lHFRX9C9fPZJ6S4Fi4GMffi0jidRQB/
         /rNg==
X-Forwarded-Encrypted: i=1; AFNElJ+4XewLl6QKh/0Nv7Om78Z7CpiGIQ1+2WR5M6v+Q+cAY/yI32YQbOpZLpaIpYZ/FrtW4mIDcxUZXih9SI6GAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWZzwlo2L8Q46PUanL79KvjFgRHd6mWSJ775ZsMLmSo/lSKG7Y
	VY5QYGzJkgUESB6OnS0vteqzdjyd5vqcoal3mYG/NI6lnJX76bsyJzid
X-Gm-Gg: AeBDies4ivpdICCNACUOilrG/qstevnAZhuEhfOc7MQPmj1c5B/sLqMwjSsE0u/pBTi
	ff4oNFJE7vKHDsRjgTc5dafcQYXS5MDx0325GB/HfF1wCknri+2x/dGHxn8rvaY2IhTHTZcJ7a5
	Goewm/rf/rZ39k/lL4SwwWlttyeDGDff3IyERC9+tXqjaNThLFHG3AIq0sp1BtIgBG+PKiWFmiy
	xE2rIIPtD5uChiRZl4Dzuo2tBFJLa+T1zKjL2HtDczUzfLMc6QbijGVzgzklxHYygslHT3JIGLK
	etgVZQIu01U1B7goDCQA8CQyKUwBTiOPcekTQwGsjzCRJP7xr3PDGZEZfMS5mL76IEOjq4GlUMt
	1s40Tjdq3CaG9I5hqINLXT0VCufMslUabT89PimW9PaEMQkpm22uPa6Gu6NDdNHpedG+EhXQl1B
	SDBsVMOQO/1oNWa8E6IUBwPNMlVXl+Zb4xIM3jVmKESYnk8YA/lL3BP8HtQ1aelMD0WxiiZxKN8
	YEvscXv272AJO9sxl5LP/pnS3VmWm7dVFNEadE=
X-Received: by 2002:a05:622a:1894:b0:509:238f:ad8f with SMTP id d75a77b69052e-50e368259f1mr72611171cf.5.1776470435294;
        Fri, 17 Apr 2026 17:00:35 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5ec2dsm23263006d6.29.2026.04.17.17.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:00:34 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] hwrng: virtio: reject invalid used.len from the device
Date: Fri, 17 Apr 2026 20:00:20 -0400
Message-ID: <20260418000020.1847122-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

random_recv_done() stored the device-reported used.len directly into
vi->data_avail without validating it against the posted buffer size
sizeof(vi->data) (SMP_CACHE_BYTES bytes, typically 32 or 64).  A
malicious or buggy virtio-rng backend could set used.len beyond
vi->data so that the subsequent copy_data() in virtio_read() issues
memcpy() from vi->data + vi->data_idx past the end of the inline
array, reading adjacent kmalloc-1k slab bytes into the hwrng core's
buffer and from there into /dev/hwrng consumers and the kernel
entropy pool.

Exploitable most clearly in threat models that do not trust the
hypervisor (confidential-compute guests on SEV-SNP or TDX; vhost-user
split backends).

KASAN confirms the OOB on a guest booted under a QEMU 9.0 whose
virtio-rng backend has been patched to report used.len = 0x10000:

  BUG: KASAN: slab-out-of-bounds in virtio_read+0x394/0x5d0
  Read of size 64 at addr ffff8880089c2220 by task hwrng/52
  Call Trace:
   __asan_memcpy
   virtio_read+0x394/0x5d0
   hwrng_fillfn+0xb2/0x470
   kthread
  Allocated by task 1:
   probe_common+0xa5/0x660
   virtio_dev_probe+0x549/0xbc0
  The buggy address belongs to the object at ffff8880089c2000
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 0 bytes to the right of
   allocated 544-byte region [ffff8880089c2000, ffff8880089c2220)

hwrng_fillfn is a kernel thread that runs as soon as the device is
probed; no guest userspace interaction is needed.

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in USB transport layer"),
which hardened usb9pfs_rx_complete against unchecked device-reported
length in the USB 9p transport.

With the added len-vs-sizeof(vi->data) clamp in place the same
harness boots cleanly: the driver logs "bogus used.len" once and
subsequent reads wait for a honest response.

Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/char/hw_random/virtio-rng.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 0ce02d7e5048..6cff480787ca 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -47,6 +47,18 @@ static void random_recv_done(struct virtqueue *vq)
 	if (!virtqueue_get_buf(vi->vq, &len))
 		return;
 
+	/*
+	 * The device sets used.len; a malicious or buggy backend can
+	 * report more bytes than we posted.  Clamp before it reaches
+	 * copy_data() which indexes vi->data[].
+	 */
+	if (len > sizeof(vi->data)) {
+		dev_err(&vq->vdev->dev,
+			"bogus used.len %u > buffer size %zu\n",
+			len, sizeof(vi->data));
+		len = 0;
+	}
+
 	smp_store_release(&vi->data_avail, len);
 	complete(&vi->have_data);
 }
-- 
2.53.0

