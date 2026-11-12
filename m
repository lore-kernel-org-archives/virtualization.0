Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498579;
	b=FuHRLsdhq7BgxQy9to4xMRwhCihDs3bAhWHcAdecDAmGzHxGubUGRg60vTFspXYZ++H+
	 ixjhSZRPqM8oT0DrsFoYFdZB4WnKgU3DKuNF5hg2PEssplgMTFvwabOWi8B6S1/ZBd4ZP
	 urMGkKunZIsceGgbxu/vPOrVdwlxNRBJLqDRV63cIp3keiQfSzvBNqlHynrPLdJPLSNe7
	 Y+Ue3k7aeBfKm2mhpOlBfA/Jb6yaRwV9nypvKYpCL7BeWFLlhHdsMQDSJfNf4TLoYd2dN
	 9Yc2oanjhxkVZZZcX2NimKJYVthhGtBjShzgdB+/uq0Ps04JCRUrrrmq+HCQ4b7at/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ve1FkPgDNt0jdst6TwlwSyNCOB8aJhkSUavfhKtflTs=;
	b=UT8qHJj7NYt1OzjFR0a2IKphJHNIaqi8bCy0ys6X69fxf/NdIrACEyLfEFOjhAanKW1v
	 eHIXOhMebCG153oI4pX+9LYZ65otQmyaKpDCk1deIOQBnk/Y+mfp0DEEiQIHabghB2FDP
	 A8ilRohPBXa7vUr/tAd3MHdn3yk5wgi+adfRuwq0aK79jp8IkgVQBshn+giIURV1bDeAv
	 OsqifCpQch+K1cyVe7qbG+M25RODsIxUX4EdXdhcqbE0VgwN8uP7yPrDF9+HlSGrVSDY9
	 XoZmNsVmWoRZsHs6XKzA01Cz842XgUThLreyMkjYFG6b1+29cVHEbHFSUDmSX5loWcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4Dgh38R;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023F606A88F
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 15:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0023F606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4Dgh38R
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so12430905e9.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 07:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498577; x=1795103377; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ve1FkPgDNt0jdst6TwlwSyNCOB8aJhkSUavfhKtflTs=;
        b=j4Dgh38RPuBv5V7lVQEIYWx38fPbN3tMfz4T0f15zcfnPDLGAv/edo3xHH3sn1kbtG
         9Qxv6nFzPa8KzWxka4Q/RHfavi4pBMG25GaqOFo2165pSvR6f8L4VfZFoepWcdQlcq47
         djcUjN5FbPUqWI3EHIOlHwWY47w6+vuljfRgRcQX+yVcy/SIkEAyReWVFILULK7yt9oi
         KUXDFA2vc4qKx4kfR1S2AXs/HomPHf1Em2lhoAa8xnWYjKxReZeiqhFf1ekSGWv3pGqd
         ndAj7PAp4P6+ojt7GePkNjjtxRiDBTRkvkkX+ZmxJKP02+1Hxx56Ieudgudi5RWRDnps
         7uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498577; x=1795103377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ve1FkPgDNt0jdst6TwlwSyNCOB8aJhkSUavfhKtflTs=;
        b=P+nVJYmCanUaUZYcPUAAhYt6dpbMs47MdxZSKtfESUYfsYlYUikiATI30mbi2QMayj
         bb//zOUNj4/voQbdo7tIqzRp9FLOx83iB+Vz6n/QottjaZeDU+kZ0Sj5ZJNEtjSRUB12
         MbgYNTnvv4kiBjcByVFDiPho7h+l8h+Udg3jxohMk1LEBZgrnilqPqQN9pZpzb9RHKvh
         5b+aRApz0DIezG3VQgP2ZB4oRWrhA5aR3eVELW3T+JyuOo8mhGKe6mcmZL986kwjC3TG
         819uo/qE+Ec06dRn5gcb/X+wSfYUU2sT2dLVC6jhlu4lTuSTsIjmC/QQfmYZsAFi23i8
         IjQg==
X-Forwarded-Encrypted: i=1; AL+hErGXEA7zIWUeu6+xhTJHZXn89/8Z1v+VKsuzXxr7iDXOMDW1Mm261ZiGJiFOuXOCCTcJwhgAQfutnkGr8S4oOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+gwQObA77CO06Tmbau8W0qbhmhPcP012AMCKLInX4qyrfOnFFM
	yDd5JUCUa4ZJTfdn7W86zbA4NUVJrgP4leE9kpplJzF5lsoTNuQVM7ZU
X-Gm-Gg: AYBFou0+JDG3Iqdfvab/QrLihW3h32mi4kL1m+U1GO3j3Iq3tKjqY2SJ6gRtRrwlczp
	xuJdcqW6KHFGzuXINyxYsTr+hWNGcnkmlRBJhVjcmxrBM3vpJvYI/CJBNvL01B+OlWOADgComrF
	2rZSl5JyEOvs+tzi0IgTDxtkoWbED2SOU+BSQkMi2NLStgIGI+SRE3GfmdflMia5H98fS+sE1vg
	QjyYdDKp/a2vXFNHs8ifU3u1/W5uG1oNcQoXLnrPj05kytK4+T/RKjQo3Ll/XP52eTOJpJAsyVe
	A2fioSSoT2cncHP6aj209rL0AH2B/nWtZJm6ehTeo6WxmwOGyArWEYedL7DMDxcYL+FZd2XjV/f
	mhPq2lj9QEZzIkjRnX8YBFh3zI6BbEd/i21Z086L2wbUnwqUOyfuguthv+5gZQcBNTP3qc77XG4
	gHSqh7eJLbf3XfNDmphGf8JeEIMewHY2wXgfgE3aBm3qivuOYjx4yzTYBmTEu4UZ1B9hdOCTugt
	VubYXTBamhzLVkRtb8/Ojig9XRfAC70zRMzK8tyNDAXWPm7rcCJloqNJnyI/ZpPkNuYA864RYpQ
	e/lxSNeLyF9TT3U+5kDNjayg9f7nNxnOW3TaSHiEnq/+HrzxRabGkmpV3kas77/2k7BV+t7IDD9
	s
X-Received: by 2002:a05:600c:19cd:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb4e28d076mr63675105e9.11.1794498577427;
        Thu, 12 Nov 2026 07:49:37 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:4868:f22e:b51d:7cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm139337155e9.1.2026.11.12.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:49:37 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Francesco Valla <francesco@valla.it>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] virtio_ring: reject a split ring size that is not a power of two again
Date: Thu, 12 Nov 2026 16:49:16 +0100
Message-ID: <20261112154927.4004184-2-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112154927.4004184-1-stjepan.poljak@gmail.com>
References: <20261112154927.4004184-1-stjepan.poljak@gmail.com>
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
length" error names the cause. Returning an error pointer from
vring_new_virtqueue() is left for later; the same change for
vring_create_virtqueue() is here:
https://lore.kernel.org/r/20261106055635.3019889-1-stjepan.poljak@gmail.com

v2:
- Log with dev_err() rather than dev_warn(), and say in the message why
  the length is bad (Francesco)
---
 drivers/virtio/virtio_ring.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f683a2d6a200..f855b8d41575 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3513,6 +3513,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 						    name, map);
 	}
 
+	/* The split ring indexes its rings with num - 1 as a mask. */
+	if (!is_power_of_2(num)) {
+		dev_err(&vdev->dev,
+			"Bad virtqueue length %u (not a power of two)\n", num);
+		return NULL;
+	}
+
 	vring_init(&vring_split.vring, num, pages, vring_align);
 	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				     context, notify, callback, name,
-- 
2.53.0

