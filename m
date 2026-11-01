Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552003;
	b=TRY6Gqh4t1BI2IRhuMR03r4W1Aj9InaXb9F6LIjee/U+KTt6LfIUs5H5M+C7kDVA5gpw
	 Uts2OJoZdx1zjvB6nLXX7CQVKxi3McAo8NeRj/+4tNnJtRXgVNe5vqP8Z7059MqC03Grj
	 bFP4/ZeTXrI6X8hn9/BNYSgMFl/Uxa/qIJkINvkQzzBxr3jn7EoarU9gZGvD+eRLjJZ+O
	 bs5bIOX3M0o2gL5/a1c47pGo0Tz+9gIoAzVkVLpqxQ+OOj9eoCSMWsUQ7sm9KBHYqkYkI
	 CF2ghZnICdTCSgs8Rr/3KAXHHwqaua9T6JydWKZnAXZ/XSwAmdWCHFq4+rDu0413mkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=097R5J/xw41Xh61+p10blxCYZ8kZHC4U5wK3EMQFzX0=;
	b=yJpltJgN229P/Cm/TEj5uyqvw3prVEIC4XlBxzElOQCCUAynrt7qqTrvv9BCrQ7JbJY4
	 0hySsja1L6hS6ux1eN/Jq7BdIR6uu03XgI+5bnMYlcc5UG9mb0tIsO4a5bXuZweNXZv2I
	 AF9/twTujYk3sqyxB0+PHRcJ9IDHkGFlLMu8FGKSd7J2l50PwP4MiLn3Yf9tSy0g05+QI
	 z47mpnhGQfLADHHWD3qhtsM7AdIsRjPLIcoh6TxOzcnDb4FKdrgZ8I/t0WL3rzwgjXKjO
	 zob8IUl1x9ivJfyVksPsPb56ZhFOUf9A+0ftghceUf70rxRv3sNryveBYYtNHYvxerA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bCCag73P;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A509606A327
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 16:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A509606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bCCag73P
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so13278405e9.3
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793552001; x=1794156801; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=097R5J/xw41Xh61+p10blxCYZ8kZHC4U5wK3EMQFzX0=;
        b=bCCag73Pa1x9JBTBLY91uZn0/XiRaPvckHG/jfALCKi4JNIp7MwibCu1Hmg6fOZ5FX
         +Z2og7TX1ykdSWBJ0XAd8mrnc4uSZ9OfgpJKNWxG/6fKVtbiUwYWc1m5MavdRO3CqqA1
         oIF3VvBcVsN+IX+gX/DMLu7NbOdJjhsWj0YPRk3LEjvuhWYSp/VGd7bPR5yZQ+jf53JR
         5fIZJPc2zBUSCAEpX8+ePkB+/2tb6nhVA6RJDyRvUDh5yEf+Wo4Bl7dcnjLsh8XL6pBY
         TgJy8U0bz94G8wJO/X/bqdEpC1sRJIwu/KlwV90CylGRb+SVxwqJgvwnXnw3ap0E8wJl
         F+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552001; x=1794156801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=097R5J/xw41Xh61+p10blxCYZ8kZHC4U5wK3EMQFzX0=;
        b=zZyWTAoeVarIPpxuoerqWzttZv8berAxIPwJ9yrrb77clGIj2mb86Dvj1aGR2ykPee
         Fw6WylVWrFSKBlLgFq9B6USRBxYr1No9vfKPWqHsp3V4Liz/2OT03QfQKufmQwjTFZiC
         aEbFTRNBCkeTIbUvIesI8xnvskz1B1uKd18/6V/IM9NYIUX4b0+o50TsCSZSxTdZWtlz
         E8/AEdDjG4TxFdDxxivZbJt6b+EXyKbqJxRZ1JnDMlq7J+dcBqx/a1mGFA/QkhViu92C
         p27ljRqgE3JF9Tbted4U8v4+qimy4tiu1JZ1a+7tb8mV3xIUG9t46CdohfqOi6I4woEe
         WqXw==
X-Forwarded-Encrypted: i=1; AKwUvBwscRm/M/1pkEZsW6XreS4zDripJj7iJDrmJiUsnHU+yAGZ4BJ9Etfg3IuxE4eIoJ4xtt1SrBYB0oTDITl4sw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIdE3WQvLVec0zmBOpMfmhXAHROc2jNID1geO1INFf9BoDuksxM
	O/TbS4WNpoai4eTW+3t1S83lLKUIktwkXpGb+eyPp0jxws7rd1a2T2ab
X-Gm-Gg: AYBFou0QI132ho7XT/pzaptlVpdgqtl6cdlC+l4mKEfgl21u4ccxp4m6+3wKicFwdZY
	zBs1RooidogT8jKyzoQBjScAMfFZvzgxikJJEi+c8MwC9qUGAYf3zKQ2eHjqEUSYACR8XW5mSkY
	7hEI3g27HlO+w2JdwkvOge9b1Bdd8ySzLuEGspEvjuZq278/1gjn6ky5Z43hedIfYbJFDROCIVT
	7JhaQCXKvk5ZL6lvk+x9YsjklPxASVcLJlo8EMycZYuV+fXc38M6No2PCVC8ydmwM+xzxzldgu1
	aRL6Zvbasb1zc1RVLzsySiOfIgH06TOp1jj2HkldiblG1hPKDUmXTHa6MiVhutpr1Ld+EwgT0Qt
	25SE/XA5FJq1H741NHAQHGS2tbNOZ++uNCnTZqMXyh1vxx6b4qkQGubQvg5N69wDhowiJD/EEfv
	6LWlxD7kMnFeDgvJWHzmhLWkUOc7r45lKp4JAeI4xOFXT4mzkmjjETORWsJflc/TAsA1Gg3Pk5g
	dlTb9Uy5MiDKkd/no1a77cenzvCpRWUdX+m2bIoXYemHYhC0g/gnKT4J4+baEAoPybnd9Oq4vun
	E8av9EcuzXda6idbK+6jfA64ytST03vQ4KcBqDUH8pGOs8Uct4CSGuQ3C6QFsSwsqqgsfltHpi3
	3
X-Received: by 2002:a05:600c:3f0a:b0:4a3:7344:13b4 with SMTP id 5b1f17b1804b1-4ac1709a2d0mr182481895e9.14.1793552001474;
        Sun, 01 Nov 2026 08:53:21 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:5058:2b49:7a78:eb6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm223903095e9.10.2026.11.01.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:53:21 -0800 (PST)
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
Subject: [PATCH 0/2] virtio_blk: fit requests to virtqueues without indirect descriptors
Date: Sun,  1 Nov 2026 17:53:05 +0100
Message-ID: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A virtio-blk device without VIRTIO_RING_F_INDIRECT_DESC needs one ring
descriptor per segment of a request, plus one for the header and one for
the status. virtio_blk takes max_segments from the device's seg_max
without checking that against the size of the virtqueues, so a device
that offers a seg_max above its queue size minus two gets requests that
can never be added to the ring. virtqueue_add_split() warns, returns
-ENOSPC, and the request waits for ring space forever. A virtqueue with
fewer than three descriptors cannot hold any request, and depending on
the queue depth the probe then either fails without saying why or hangs
on the first I/O.

I ran into this while writing the virtio-blk device of Hearth, a small
KVM-based VMM, with queue sizes and seg_max values like these:

  virtqueue  seg_max  queue_depth  before                    after
  ---------  -------  -----------  ------------------------  -------------------
  128        126      default      boots                     boots
  128        127      default      WARN, hangs loading init  boots, 126 segments
  128        254      default      WARN, hangs loading init  boots, 126 segments
  1          -        default      -EINVAL, no reason given  -EINVAL, message
  1          -        128          WARN, hangs on first I/O  -EINVAL, message

where the message is "virtqueue size 1 is too small for a request". A
virtqueue of 2 is rejected the same way, with either queue depth.

Patch 1 checks the virtqueue sizes in virtblk_probe(), before the queue
depth is derived from them, and fails the probe with a reason when one
is too small for a request, whatever the queue depth: the last two rows
and the virtqueue of 2. Patch 2 then clamps max_segments to the smallest
virtqueue minus two when indirect descriptors are not negotiated: the
seg_max rows.

The seg_max case also reproduces with QEMU, which with seg-max-adjust=off
offers seg_max 126 whatever the queue size:

  -device virtio-blk-pci,drive=d0,indirect_desc=off,queue-size=64,seg-max-adjust=off

Before the series this warns and hangs loading init, after it the guest
boots with 62 segments. With QEMU's defaults nothing changes.

The seg_max cases were tested by booting a busybox guest that reads its
disk with O_DIRECT in 1 MiB blocks, the others by looking at the probe
messages, on v7.3-19954-gcbbddb6b08cc, x86_64.

These patches were written with the help of an AI assistant, as the
Assisted-by tags say. I reviewed and tested them, and I can answer for
every line.

Stjepan Poljak (2):
  virtio_blk: fail the probe when a virtqueue is too small for a request
  virtio_blk: fit max_segments to the virtqueue without indirect
    descriptors

 drivers/block/virtio_blk.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

-- 
2.53.0

