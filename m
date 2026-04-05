Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6443822AF
	for <virtualization@lists.linux.dev>; Sun,  5 Apr 2026 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775424762; cv=none; b=dBA39/8DtdWyfyjkf6f0b1/0en1JfPnAEDhks7mNMs9gVC7GFIt+Eo5zOI7jtfZ88HV9gcjvcREZ/oOOVbclsuw5rs1kjlCkji4ZV773bJSW443He2aTTnkeWgVS8cj37bwzVFUinMGQCboMGUcfm+4LyDR8r6DmfG92qtby9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775424762; c=relaxed/simple;
	bh=LGeHUz1nkm0cmVZj4JP3rWQRQUF8C7HFzf77++2/i0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6O0EKgRyWuofofd0oeaY6aSAQ2VD0Pb4qahHw53V5hc3BeGwXeMGaM2fmvzAVP5BQ/ul8oNEBx9vUPcuwoOKVEK639eDqI/heytfhTJ63LmT0sMRFaRr4N0yomPmAD16aXHtE24hc8j6PFzpppDP7I121XyLJWVy1sO4/1UnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcFCQ6SX; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcFCQ6SX"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56d93355337so2530763e0c.0
        for <virtualization@lists.linux.dev>; Sun, 05 Apr 2026 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775424759; x=1776029559; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZQLuPBBkhC/cjq6fqBTSFddeeLKb5qHOa+I9HI+Wdc=;
        b=qcFCQ6SXZE2HUcrNYWodQfQBjYD1v5t2RIKavzfPGalQz6XHBh+NTEKi9kj5SGKSa8
         2lXRraHwyhcvSeEGLzeBUE4NtcGRX4+UB8uU+IH6AQ9SLweqhKl6uwashimygDxPjq+j
         FhNSzmH8qSGr9e8HUrqQBAE5r5TAjZz1cEJKkDSY7uwGSENnu6DQWgdxZfE4rkBw90c9
         zVs6iTDbHbfz9MzuMxL5lAKke8NAO63LVSi29Pwf+bgFMkCKOBMYhLlGWp98PRLLvoKX
         naYxfnoU1Jn6tPyzO9oy5pMPypgCsly8uIf6uH/0J13QOljA5NzKCO1m464zDo6UlpzW
         t0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775424759; x=1776029559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZQLuPBBkhC/cjq6fqBTSFddeeLKb5qHOa+I9HI+Wdc=;
        b=KxGYOoA7JeMgndlz/2C2NTHqLt7JT7bB6tEq/Kf5N6VqmLHvmk0PiosFeqR3JWpPz/
         7sV93uhj+zuEnJLADliz3DX3Bx6kFdBeUbsRHmBroTJmkNrywbzEU1CpFIVmqI6JSvNu
         JrcI8jHCgpEEKppPIU6+T9BPAxdh9NznCJRCj2orcwchI0g8UCtEwL7K/s0+JXT9w+sc
         7qfz8SnbegP6xMD1Nl0p6tFvHwVWyxs2pNdon2nBEPl6d5L21xU69/ySXts+vfv+NI9y
         nqj0/HhwX4+U5O8ljbmrxP6CFQ+OyaLeN/nBjNUf5MizF1DYoYx9SkZ17HhU5JyMR3bZ
         c30A==
X-Forwarded-Encrypted: i=1; AJvYcCWJTQ8jOb7NHxtJhunRQOGXCOsy/fuksjBJxJ1mx7/GAtxNGmoOOw2bXuRPAb3HChCRq146uJZaYtsm9euqew==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjL3H9A66JYRDK6Oj0LOkS9NO4v7yUbWh0kq/5jH5z6xPb0tX/
	saSR8IuIlTndixIZKfUoTBGCi1HThW8oGWuFcI+VJzkuFaurgl6wbGXS
X-Gm-Gg: AeBDietlphRBEiZpwKi8nFnGjU1sRgi31JvN8O24mD2Oslcail3auaZWn/3QnYW5IFs
	6YAtj/FJo2ANzfDvVmbPlx65nUKsIWHZlIdJ6nhUGdGIw9nxCTj9PKZrpNcxAlnEbhfSxNnYNno
	yzZYxgtTDaqort7gBHjAGW+ULcHNF5zB5JVyVPIms689ysT5ppraW26jn1FV6OAPdR6VmmuCSes
	ELQF29inZeP/4gSRmZuRKvnt51Ed0o4ZGTSMQBToZW+XkqPYyw41OS9S+kJLWJpxzq4au6SIC0I
	WBaTT8Js8sJ37taPB+2CQlj2dItRDhX7HGZJ6Q1HqCXCn//cGRTIXQRQwNJCqNKfq9cmOd/bWZr
	0sGmE7n43CFeO7p1d1A3VyLgqGjrjfiTSR+6YEFZ1lE1I7fcYLhLQmxO9Hzy13gXWXsXRI7XXkI
	FrcrUjjEw4l1m5ojbtVz/CN14bx1IkWZc=
X-Received: by 2002:a05:6122:829b:b0:56b:1eb:d396 with SMTP id 71dfb90a1353d-56daba2a7efmr3826650e0c.14.1775424759106;
        Sun, 05 Apr 2026 14:32:39 -0700 (PDT)
Received: from luan-macbookair ([177.235.195.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9bc41sm13790501e0c.11.2026.04.05.14.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 14:32:38 -0700 (PDT)
From: Luan Haickel Araujo <luanharaujo@gmail.com>
To: david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luan Haickel Araujo <luanharaujo@gmail.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] virtio_mem: add bitmap_test_range_all_set/zero helpers
Date: Sun,  5 Apr 2026 18:32:10 -0300
Message-ID: <20260405213210.108533-1-luanharaujo@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Encapsulate find_next_bit and find_next_zero_bit calls into helpers
to verify if a range of subblocks is entirely plugged or unplugged.

This improves readability as requested by the TODO comments in the
source code.

Validation confirms the change is binary-neutral on ARM64, with the
generated instructions remaining identical.

Suggested-by: David Hildenbrand <david@redhat.com>

Signed-off-by: Luan Haickel Araujo <luanharaujo@gmail.com>
---
Hi David,

This is my first patch contribution to the Linux kernel, following up on
your TODO notes in virtio_mem.c.

As part of my learning process (LFX 103), I verified the change in a
QEMU (KVM) environment with test_bitmap. I also compared the generated
assembly on ARM64 and it remains identical, confirming the helpers are
binary-neutral as expected.

I noticed these helpers could also be useful in include/linux/bitmap.h in
the future. If you think it makes sense to move them there, I'd be happy
to work on that in a next step.

Looking forward to your feedback.

Luan.
 drivers/virtio/virtio_mem.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 48051e9e98ab..e94e30af3a5d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -538,6 +538,22 @@ static void virtio_mem_sbm_set_sb_unplugged(struct virtio_mem *vm,
 	__bitmap_clear(vm->sbm.sb_states, bit, count);
 }
 
+static inline bool bitmap_test_range_all_set(const unsigned long *map,
+					     unsigned int start, unsigned int nbits)
+{
+	unsigned int next_zero_bit = find_next_zero_bit(map, start + nbits, start);
+
+	return next_zero_bit >= start + nbits;
+}
+
+static inline bool bitmap_test_range_all_zero(const unsigned long *map,
+					      unsigned int start, unsigned int nbits)
+{
+	unsigned int next_set_bit = find_next_bit(map, start + nbits, start);
+
+	return next_set_bit >= start + nbits;
+}
+
 /*
  * Test if all selected subblocks are plugged.
  */
@@ -550,9 +566,7 @@ static bool virtio_mem_sbm_test_sb_plugged(struct virtio_mem *vm,
 	if (count == 1)
 		return test_bit(bit, vm->sbm.sb_states);
 
-	/* TODO: Helper similar to bitmap_set() */
-	return find_next_zero_bit(vm->sbm.sb_states, bit + count, bit) >=
-	       bit + count;
+	return bitmap_test_range_all_set(vm->sbm.sb_states, bit, count);
 }
 
 /*
@@ -564,9 +578,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
 {
 	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
-	/* TODO: Helper similar to bitmap_set() */
-	return find_next_bit(vm->sbm.sb_states, bit + count, bit) >=
-	       bit + count;
+	return bitmap_test_range_all_zero(vm->sbm.sb_states, bit, count);
 }
 
 /*
-- 
2.53.0

