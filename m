Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552009;
	b=gBt6XxFBCjqRWo9wyC82B6JCPhwUY4lZJxGwnTKNeevacexKlJnEviryftyrb0e7Ulmc
	 c8b4xadOR10wnwGX7+WkXoUj6ZpLO/byPoEqrbGQKGv2fWEIEzDnhN+u5yEiWCNYh8x5A
	 +Jkku+lFlpQbTCvexBeHPRHQ13DuuD7MTdyZ0KR/8tPy06YFLA4oTyoNLJHBLKWkuQ/eK
	 bYX1ZdwMhDE+zNNx88Ii+2X9pgC4l1K2edbHQ1PRtMiPk49GBLdJuGWHyJdWU0s6LREEI
	 QXVEt40ZemSfi2hVAvM2U6rWfLyiFO8GYX1IEBOcz72RnRin7AoGfq+MyTymjyQezHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XNRrcw/P1Mej9G9gW7ieLo3ycxjD6V+M/Loq7iMzpSU=;
	b=n72aSv2QnZADb63dpy/wHRlErG2zsZnlJzvUYS46Fif4vaeQOU/a3YiM+sXd4OKf3nLz
	 mThXDUInOxDu2dRZ6ZdmZQ7fAlvBfWD5s4jTANJSfs02kZ7v0ReHDtmHzqwb/96YyhRwh
	 KcTI5jusXosMUDE2C9qffQDLNgIeY13SLNcLf5JLL2aSWGQSjTBgtODeKIHvUwfp4r7uO
	 f8hVkXm1yCR+aZW0saiZMHCAeDPBuIJqBVDLiZW+rJtc+pKRlkIyuR9BhAf9ltl/Ax0m/
	 nxZWQivgo0kVOuGBwxANx44roEzUE12P5UB5H+erW/1m5g0L9m7SF/vh7HYyyKf0NRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwa5ezxn;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD70606A32F
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 16:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD70606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwa5ezxn
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so14260085e9.2
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793552006; x=1794156806; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNRrcw/P1Mej9G9gW7ieLo3ycxjD6V+M/Loq7iMzpSU=;
        b=xwa5ezxnJrfeNogR1RDpAE4nuk0Au8w0ViMZBLmz0nDHacpumu0grHh8R/kMCl7ZTu
         gq0DccqZSoRxSr/922dysjPh3AHnxvKsfmNZG0VdS0cXtZcChu7aMsFTaj1BT9pPmrbN
         r3ninVCPefN6hXCcwtGN7n6KL7Bzqus/p3SroqERU8/0w1RelS8J5GI3aQOIXvgeYYDD
         Vz5PNxcVBzqdrmo7N28wfTaeFZoSLWVvMpBHlcMwAJKMZ9qjfsTxItXC4oMtvs0pAnK9
         Wjzbh1F2aN3JGDzrIzjF4OaUn6ffr9NN21LnQ41RrSJaYRF47Zkm+fUq3dHphO1DPinb
         TU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552006; x=1794156806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XNRrcw/P1Mej9G9gW7ieLo3ycxjD6V+M/Loq7iMzpSU=;
        b=Gf4OnLUB/uixhTB84Qd+f7hqTUxVhbGEymfkb+DhM9nqRibW/YYS6bUGVMZjHLc2Uw
         ZkyUqByc8upKYJrBMMQwUPRXhC5iTzjsyQnRF1vIV+BavSvfUWvoBL+YCknS1RrJuMlF
         xGW/CIXfFz0/eno9ou6jn69O8xlNABpLH8FrBNl+Tvz8V8Azcdw4gZCgB4MO5/vLlpKf
         yVw2Udoy47FS4/lfPrfY8+Vnzr2M8yFJLNygNeeNa7ZpHusoQLRblEK2LjCWaA5rs8yn
         HCoPMx8YFNAYK2sC7LHlC5RHYjo6IT4pTMTcd+Ezbrb+QKxl2+OVRT1VCZY3F8Fljp/3
         XrRQ==
X-Forwarded-Encrypted: i=1; AKwUvBym9eyP3KsmNtuBkCugTo5opjGWKtK8InuHDUI2/Qk2d69VBkw0SZAOdAa0xzXa28bkBy8GEfGtDLbW+NV3ZQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIhCrtsGlBIqEhDFLj9ST75+ocRFOhROGz0bhMn9xEMhm+8J6JP
	bRRg4f9zF+4WMAkPuodZF3j3UvMl6q+w0cv1AmAvwiUNi1DD7oHZrMhr
X-Gm-Gg: AYBFou14vBtgDyY4dAbL9XIElc93pwHcY9kC3XODdOezPwwovX4Dm0A55wteC5GpWRa
	Z6bTRAoMprLV3WputE1LV3/5Ko4HvP2BtHSXj4tdyvxzIe/8bA2pIVbbqVmR+Iso0sa4NwBEWym
	7WaCN5WNkxNnc9LQS/NXF17mc9GXAgzImC1VxpWFQWsIa8eEsN2rFjK44871ZJTJZ5Dlb0oUgZY
	ndy4vYwM10vXEaDLYhMrYWfopARhO+9xzOsD0e11AzRO0SlHXUk7SdBpz1XhbjdWKt4ZLL9638W
	kToCCO7vC1C+B8sThUfW0h+jMLVmm5okbi/iHwSn1V5eIqwzzQvVKPcydT0D+SrtFgFbfSCljoD
	swtmEVNF46E+a00yHmRXohfit4XEtjnQcuTNUDRpBA70GbvRBi293jrGfRuc+KHy02sWX6siv6Y
	56mejGkDjYJrT47YSp0utC/yuT6vIh2j1JloiuL962+SRbzzZVwFGSSN4jxw2AkxU+rKWtv1vP1
	1LKUE5DIsRZmzTLLxOb5+XHWR0U3jZZebDua1CQ72fcllil8XoJVar7+pUNQsSDxikzP8Oxl3ce
	OfOCoW4NGuDSW4lcRJiT9RHoC2uPNa+1UrnuyST3jsnaGU0JRYuYsPlIvQRDKiwHJws2TaC707E
	S
X-Received: by 2002:a05:600c:8b2c:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4ac150b3dbfmr190239205e9.4.1793552006429;
        Sun, 01 Nov 2026 08:53:26 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:5058:2b49:7a78:eb6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm223903095e9.10.2026.11.01.08.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:53:26 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] virtio_blk: fit max_segments to the virtqueue without indirect descriptors
Date: Sun,  1 Nov 2026 17:53:07 +0100
Message-ID: <20261101165307.2557421-3-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
References: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
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

virtblk_read_limits() takes max_segments from the device's seg_max and
only clamps it to VIRTIO_BLK_MAX_SG_ELEMS - 2, which fits the largest
virtqueue the spec allows, not the one the device has. Without
VIRTIO_RING_F_INDIRECT_DESC every segment takes a descriptor in the
ring, next to the header and the status. A device that offers a seg_max
above its queue size minus two thus lets the block layer build requests
that can never be added: virtqueue_add_split() warns that the request
is larger than the ring and returns -ENOSPC, and the hardware queue is
stopped to wait for descriptors that even an empty ring does not have.
The I/O hangs.

Seen with a device that offers seg_max 254 on a 128-entry queue without
indirect descriptors, where the boot hangs loading /sbin/init:

  WARNING: drivers/virtio/virtio_ring.c:688 at virtqueue_add_split+0x6c0/0x850
  ...
   virtqueue_add_sgs+0xd1/0x120
   virtblk_add_req+0xe2/0x140
   virtio_queue_rq+0x79/0x1a0

With seg_max 126 it boots, with 127 it hangs.

Without indirect descriptors, clamp max_segments to the size of the
smallest virtqueue minus two. The previous commit makes the probe fail
for a virtqueue smaller than three, so at least one segment is left.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
---
 drivers/block/virtio_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0a2af22f2365..5f05aaa079c2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1280,6 +1280,16 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	/* Prevent integer overflows and honor max vq size */
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
+	/*
+	 * Without indirect descriptors a request takes one ring descriptor
+	 * per segment, plus one for the header and one for the status, so
+	 * it has to fit in the smallest of the virtqueues. A larger request
+	 * would never fit and would wait for ring space forever.
+	 * virtblk_probe() made sure every virtqueue holds at least three.
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
+		sg_elems = min(sg_elems, virtblk_min_vring_size(vblk) - 2);
+
 	/* We can handle whatever the host told us to handle. */
 	lim->max_segments = sg_elems;
 
-- 
2.53.0

