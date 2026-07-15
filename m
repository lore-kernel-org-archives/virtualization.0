Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900D3AF64F
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133707; cv=none; b=j6hai0CIsRcZjRA6C9nde3rTt0oCNAPLHHARE3VAPjcvZw0bZ09U5fpp2a0c7UEbfh7UGHfH31EuoAJ62jkfE9SZ8UaoI4Y3YrDR7nNPT1Ol/mvhjXiufNixE5+WFfE+Iam8DdOe/Pmz19joJg7lhcQ7J3N+qgIG+eTyxcVwGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133707; c=relaxed/simple;
	bh=as2NseqLHB8OpIJRUSf7g5/LPjW5htjv0klwLkaYtF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFDytKfEBEdP8p2+BNFhQ7pu5z4bDknKuEZxEzSrPjp6u6K/dBBO8oSloFE48eJ1TprF+GF9OM7fte8uITX/UYst/+LSLuOEGzPy68DgCbzx+Lc84g0+FpYSEntpfnlUKENBEY/X+hRZeaNlr5lMSM6VU8I95KobPbXneD4PUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhvFHrtP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhvFHrtP"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so10447693a12.1
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784133704; x=1784738504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NFSo1vQVlWE8/tJS9jN6+QBQqVdI/OFH03uGFW+Opk=;
        b=NhvFHrtPpSnEV2Gbji8PB9zvh4aRfWjDYgDd9sQQHfUllJ/dbBX0ceE634Zhuj3fBs
         5NCUI0iQn3VfLw7brnDMG236WE69mwhRCnOSonzWLSFW7ltKYqv+pYdvv7crT5y0tKX0
         +BEl4aryOPM5+BW/nSnBNJXlvKESEv14iJeBPd5CmhBOXyCxlMBrwo2u+3pHlWHo3WVG
         vxaEt7UJmbwZKkBPLEFXApwB5JpIXRl6xs8dukLysHPAmrhfnfDBZFFpaM3tX4jjBc5R
         HV/5hlfJDutlQq2JAnQpifUoaE3gIFni4HRDAkLVnHZxPB/i7CjHx5tiC+ugt5BGN9zO
         JN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784133704; x=1784738504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NFSo1vQVlWE8/tJS9jN6+QBQqVdI/OFH03uGFW+Opk=;
        b=cXgGsS5lWwPL/BwtKc0A/xGwDF2Pln/tVn0TBS26tq+qIj07dxzKnK5UpM5YMeiG5p
         XvFqEoZqWed6Veh7rYryCa+xisFBYXf8gZjAR2/0ctUyC82u6mozWSYWo0Z8pY3lOaMX
         xsdrm0WEn3NP5rOiFA36GaaJOpvLjQNt6uOoknIhHptsSWlBOeTsJGhBtHxCNTyIfjk4
         GhtASePP7zdVTSWv7S1XVxf6L3UExt/PAdxstoV4a4XYK6nxEFcsuSebGiuBeJk/k5Z+
         G0F9dcQsc41ZOgcsGoH8F0dF0t69tRHA0RvLP5cY7h1cp2jf2pMLUPOtAQ6RKIhKPmSE
         O9Ng==
X-Forwarded-Encrypted: i=1; AHgh+Rrcx75l5jaThIzn4PL9BkCFIJNpV3z5VmmyNedHMOfPg5KqWHVfKswRVsiz3Z5QWmuBeC9ZcnFM0E2j8VKKLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhgjXOHWLx32296JUArCTke7+UQmp7/jwSl71kF1CYEMCOLIOe
	AEUMHoZFAqHDb7ozDXQ3ZiWv9RoXFAosVx3m7zSKTfb3BTOqUFz7tzh+
X-Gm-Gg: AfdE7cmgC3u1W/0AukNxD8gJsvpi0F1lLgY5nmu/4ypswEfCcrnWFfWTov+CjHOyxmB
	0NzsLJr/isNVPyzJ6x1kk2lF0i7Zcg8wD3LLq0eFPsFKW/fbzawpmz48oi0fZnFgsMfIzDAn8FU
	Fl9VTgpUtbfMSKSUEkIMZ67R4FDcAsYhUqZEz1zW8uYsDsBS7ahndxv/6GBRxL4E1H0GJLPM6B8
	7sjNR6OtPwggbBKmX2i8c2NwFJTkElkWF3flDWPQuhXAlDsR9IZj6sXWvexr5szHproOwLc6bKU
	B3RK+qsytxCSQVJsH8ODNNoVuReIawcPQDya7xgRMFDj/gVzHRevKrYXfe9Qw32LUreWbwCUGPe
	z1OulZRzFqsK0WOjBNvz+NQQuuoJeiMa0EaUNjBBsc/eN7cXVWc6rKc0UXnlQUduAFfi7gVVpLv
	6ZTq4rbQzQfMfck7fuPEc9PrE9W+XKB3fh2TR2Nuu7tNBv29fnc6hH0eRl3wIURSY9yZDCSwnTh
	38v
X-Received: by 2002:a05:6402:524d:b0:69a:aa50:32b8 with SMTP id 4fb4d7f45d1cf-69e19be95b5mr2052572a12.36.1784133704261;
        Wed, 15 Jul 2026 09:41:44 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd26e239esm3355874a12.0.2026.07.15.09.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:41:43 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Date: Wed, 15 Jul 2026 18:41:16 +0200
Message-ID: <20260715164139.40957-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-2-harimishal1@gmail.com>
References: <20260715142337.22811-2-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device_block_size read from the virtio-mem config space is used as a
divisor and also in ALIGN_DOWN() further down the code path in the
driver without further validation. A zero value leads to a division by
zero, and a non-power-of-two value corrupts the ALIGN_DOWN() bitmask
arithmetic leading to a misreporting of guest-usable ram, post crash.

Reject both at init time instead of trusting the device.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
v2: dropped the redundant explicit zero check, since
    is_power_of_2(0) already returns false.

 drivers/virtio/virtio_mem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 11c441501582..0e04fec458af 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2847,6 +2847,12 @@ static int virtio_mem_init(struct virtio_mem *vm)
 			&vm->plugged_size);
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
 			&vm->device_block_size);
+	if (!is_power_of_2(vm->device_block_size)) {
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

