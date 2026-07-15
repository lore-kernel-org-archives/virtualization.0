Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF135AC09
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125434; cv=none; b=Ru+MqfCsnbS3K6c/AAcgNlBQP5UAhN1/z1hI44aGG33oJZDSTMaCaaMJeYvDceofefa/7T9m4rqB4C0+2BlAocwY/vc5N8t4fAhYVhSJ6BgulQx4ooL84c9aP7uQl4kRXKICv+UPkDH0GH3AEz/kmyUwd+vOyRTKxKH0r2hqv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125434; c=relaxed/simple;
	bh=iLWHG7Z9ifkUCPM3I0W59CT2LgsbHMZPMVoaijdCcg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnvkMHGlqFcMkMz7LA/5bjm/6jiwKTtaGbv9lOhPdnigATUvpNYA0k+dZKsNV6IV7E36um4QDGrElgXAgRtHNbyD+7GRIp5aAe7aKiERgX9enIQ8JXH9x5Nn2mY3X+mTChbIyemmfQRvTF3RI7JxKz+LOzTfSv7i6yG6g5cuOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzT74Zb7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzT74Zb7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15f020a223so736964166b.1
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125429; x=1784730229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yo/c4CjAVn9rvKKIkMq0mVxy9jNtcNfgzZTIdJ3Ac40=;
        b=UzT74Zb7VRrdcxOonjcpYYNK7iYmCAR11Xl58ZoEG+8BA1Z1c5b5q36SI8fzGpse41
         /qYDMByCY9m6CTTJ/3qZ8uRfdDPSFlznlkcIrWs8Qq0dmVDMqmWEel9ZeGm4COFpTPcX
         xA0XlxaNTB1jw0dRhFN8sDVrAQMu7jhorK4cYx2i5+2Fv8FDQzwi8fe/oCuIEb2hyAYK
         34pwLTMahanlN8UI9H5YaMV1eYAJv+u/sY1E9AzQiocsq+IuEHD0ZHN09z3EzOsmRh4A
         JTEBKDQVlhTxt1Rk7zj6LJgkjdQnjXKKa2WR1FZiRBYafkYisvrpzuWX/4q2+M2aX5jr
         8zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125429; x=1784730229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yo/c4CjAVn9rvKKIkMq0mVxy9jNtcNfgzZTIdJ3Ac40=;
        b=YROYMwFFZ93aRmdW2jlbNyKcz/XcfWPvp17i87klH7OyLg3p+lq2/RXwbcxbNKMDuu
         kQoa3CdUAc5JMAE1X6GYDILc0chzj5ntd8rbiXtA58l3JQvYRNr4+G/ycixpPGTJnJ6M
         zi61PIdekH/h/ekv4g1mQ5CpmRCSitqzCN1ODklg1FpfHFj+8gvQXpKSvYFIdnRsasoh
         9fWExgHnXW1WcG+ebfHHXjg+egfl0pdkgPJ5+QYMFYUGOBPEYadUnrBH6MbJYWciE5XH
         o71p1RLVGM/9P5RVWaZiTVoRTXxyB7ogrEPOYG9CjMITrRAIfsU2fx2KarTKvZD5eTTP
         2UCw==
X-Forwarded-Encrypted: i=1; AHgh+Rqsef+QUba4fq40dhm8X2RJWJnp3o+BU0+WfxQuSE9A1aVUkjHA3eWQ7kacK9z4P/lpVgbDI+/S4NM6YlBB9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmtaknRF3X16aJh3FhDxdfiWxPL/aH9N6d1demRsRAU9ZpQVBU
	2W3VLzusktl8MOmG4jhaYP+VELKuHYNxNW3TVXIdsbCMrbSXwV2vf9PeOkJdVDGFaym0jg==
X-Gm-Gg: AfdE7cnmEB27DFAxm0wfvqmk/C4iYvDAyeL4OcvdKN2TsciQndh4FpqWVHSnUnoYgX2
	CDfAvs6t5q951N5ImB5UBUWV/os3mFmiWa6sYDbS/JV0OINx4B8eFpQy8vHUAEmt0lDYYlld8xL
	AdfaFbY+G3haybZcZwYLkW366URk8gpL1JCisDZzY+S7z3iRDsm7S8DKhVs0wHHaSBWwEARKoEf
	dG6K+36/3H7upjRrFoik6lroeqQGUg86wtPyVTiKRSyv6T/KG+rbCvgIYTjRJkIn40gsc8a2G0h
	ZDJ4SPmjjUeg59Dr3M1WpWjLmXF+JnWbO5Shs523KdXDRdL1u+qt4Tp9cGKyZduCAj9PskXhpoR
	NVFlfmO0vzTFaPgmk9tKmdydiVFQr5OC0sbcVpaEqKDQ7vIQAyOFVYSu9qD9wfuwog3Fw3+OWVA
	XftKH/Tu88qXwXWdkC2TL968zNq+FK2jePVUFcxwK3UOn1cDAKmQldO1vwoUJMCBe9Uwdq4IuDQ
	wT1fyq6i4xI8mg=
X-Received: by 2002:a17:907:e1ca:20b0:c16:8933:3501 with SMTP id a640c23a62f3a-c1689334452mr16024566b.42.1784125428901;
        Wed, 15 Jul 2026 07:23:48 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:48 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 1/4] virtio-mem: validate device-reported block size
Date: Wed, 15 Jul 2026 16:22:40 +0200
Message-ID: <20260715142337.22811-2-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-1-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device_block_size read from the virtio-mem config space is used
as a divisor and also in ALIGN_DOWN() further down the code path in
the driver without further validation. A zero value leads to a division
by zero, and a non-power-of-two value corrupts the ALIGN_DOWN() bitmask
arithmetic leading to a misreporting of guest usable guest ram, post
crash. Reject both at init time instead of trusting the device.

Assisted-by: gkh_clanker:t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/virtio/virtio_mem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 11c441501582..43d12ec7c323 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2847,6 +2847,13 @@ static int virtio_mem_init(struct virtio_mem *vm)
 			&vm->plugged_size);
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
 			&vm->device_block_size);
+	if (!vm->device_block_size ||
+	    !is_power_of_2(vm->device_block_size)) {
+		dev_err(&vm->vdev->dev,
+			"invalid device block size: 0x%llx\n",
+			(unsigned long long)vm->device_block_size);
+		return -EINVAL;
+	}
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
 			&node_id);
 	vm->nid = virtio_mem_translate_node_id(vm, node_id);
-- 
2.43.0

