Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F641A239A
	for <virtualization@lists.linux.dev>; Sun, 30 Aug 2026 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788057282; cv=none; b=Bk+J3+MsTBGfTB5dsJ/VRyh736f4CJPYT+IzHSQd+cK6ZIHNy0SOmxbHo8cPoCGQTL3mhCf8HJ5Tsb/BYCG9g4N0ilLKDf5X7ZEWK8eRx/90U7IMjpV21sU/c4r8A4stOZKpc2Dx/b4lsFFWe5vsuiDBar7RHcHPnN+pBLFhXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788057282; c=relaxed/simple;
	bh=ovJUopzQwrJDmXOuk4g+6rnmknd9cwWU2S2O6WmOduU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=inYq9msTnPq+waqrkCogSB7uJayjF6yjxy6pEWRNulQH5+TwgP4eJVWxj5Tht4ho4y/ytX4n9mqEM7QT6lbb8nQAlHX6mxHtCJp/ysY8yn4TIV0TYTxsv27nj1+OjX2j8rPzIXzwtaMO7MlnAELOat96FXQppkdEAEcbfTe4z1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tG4wxXpS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG4wxXpS"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3964e480f76so2895560a91.1
        for <virtualization@lists.linux.dev>; Sat, 29 Aug 2026 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788057281; x=1788662081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKjTjg7r4R5L8bCPlD9wnjai8zkrlb8yfJnv3kI4DEQ=;
        b=tG4wxXpSZfcn50xj+yMPaT8c20rX1IwMglRRQo286P+hZNnuho2AEi2jrcaXJDjfx4
         xLYLCnUlK/gPnfX4hsO/clROa1Lfy9DePdhatNmiS8ThspcdHWnf7wHG6d9Zr+/9S07n
         gr9UhquK7IbVh9kTZMTOVrvLECbzfK6GetMwbhXkPJtHTBvYkDNryIboGi5q4RqMTK6f
         sEIgX3wSWYInPzSIwoGeAaN3SkzSyOHTHSWSeA4DoBAr+9bnOvmg5sOeMBW1cz4xhDq1
         +i5JCaZpXUNJ7OqRrgxQz60cX+Ap2luDc5ffXyBKFQ/B2E8i3ghY7RJnCaInUZL6tl63
         Bcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788057281; x=1788662081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKjTjg7r4R5L8bCPlD9wnjai8zkrlb8yfJnv3kI4DEQ=;
        b=cA7AE//GVdnEHnh7KcNp/G/uYfzdvERjV8JMR/IgLF4jqNNNVj0JQwxfjxm8i17cbP
         PYT9nI5INJ5xe1yEi4BTp17CJTFhvJgvxWSNjQXxAtE95KMDDsAu6j2vOzLChuDSN9yD
         bMidimWfuAOELCBiL1pjbcdonvmwMVb2peJXwM1yzvffj18ydf2OQa8turUQrcHgPmBP
         DbmXSdOqVX912AQKtQMdelaQ8ggA0zrQKzWyxbbtdg9ts+U9UIo4Hye59rFfJG3o0qff
         Kp/b77ILCKUHXaz/BDqDZ6LZJbxtf0QU+tGkpCq6/MZDybwpF6md8xW8qEm0gbbtX+/W
         nJHg==
X-Gm-Message-State: AFuF++n3CQgJgaeB7y6ZU0sLMg+ovhR8orrB6P186jYwp2+wQ4ZJdhSV
	n8QDEvRP5c9q9231nCNpo0RADcrTft8OC0Ef1eSsPsPVawM50XWJCNgH
X-Gm-Gg: AYBFou3A32GzcTfzfjwAVkRfU7HzXM8cdVSyyXlZt5a+YJdXKqpdaxloXdGtYuSsMFq
	9nJAD6ZIO9j8rZgM6sK5l/npr9PYmOYDG+lV4sf/lQ28gSBbValkbqw6YKN7irKXFv2ChyHKmOL
	0djNNRkL24CtHZCkpLNPKKWOotWYaN82qvPHjttjwiW9zpNP2YO7y2BroGwGHBefV9WFDkmmfcP
	Y0aJh30qpJZsll2b1PzDqOVW0BnDkyZTLZ8rtQbPzDDul5KMWHBUTACtIYbKMgMZpuBS8MThM0y
	pn2BOXCFYOOSjmWvqrDgKddolfa5Lv0OqxtcfzTDyz1sTkRhkbB9jz8J8z8s6W5qmnN6ngpap9J
	ZXW3vpx9uYIr8NR40RZFb43/I1JgKEOF3GxOzpIy3tblybqNyqzgZYjPLFmhXnPX3vO+1e58Abb
	HbYr5nqfsZLYf7j7YMU6HGG9JdYYdHOcMw3l3WTt+pGB+NBCgFUw7cCNnvVh2B
X-Received: by 2002:a17:90b:39ac:b0:38e:6f90:eabd with SMTP id 98e67ed59e1d1-396d0ea5451mr21542619a91.5.1788057280462;
        Sat, 29 Aug 2026 19:34:40 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396afff2650sm13879102a91.0.2026.08.29.19.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 19:34:40 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	xieyongji@bytedance.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] vduse: validate virtqueue alignment
Date: Sun, 30 Aug 2026 10:33:54 +0800
Message-Id: <20260830023354.115333-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vduse_validate_config() only checks the upper bound of vq_align. Invalid
values can therefore reach vring_create_virtqueue_map(). The split-ring
helpers use align - 1 as a bit mask, so the alignment must be a non-zero
power of two. A zero value makes vring_size() drop the descriptor and
available-ring part and vring_init() leave the used ring pointer NULL.

The VIRTIO spec requires the used ring to start at an address
aligned to at least 4 bytes. Reject values below VRING_USED_ALIGN_SIZE as
well as non-power-of-two values before they reach the virtio ring helpers.

Opening a virtio-net device created with vq_align=0 triggered:

BUG: KASAN: null-ptr-deref in virtqueue_kick_prepare_split+0xe3/0x100
Read of size 2 at addr 0000000000000000 by task systemd-network/1062

Call Trace (relevant frames):
 dump_stack_lvl
 print_report
 kasan_report
 __asan_load2
 virtqueue_kick_prepare_split+0xe3/0x100
 virtqueue_kick_prepare+0x40/0x60
 try_fill_recv+0x857/0x1250
 virtnet_open+0x189/0x460
 __dev_open+0x225/0x390
 __dev_change_flags+0x368/0x3b0
 netif_change_flags+0x56/0xc0
 do_setlink.isra.0+0x68c/0x1e30

Validate the value before it reaches the virtio ring helpers.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2190,7 +2190,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config,
 			return false;
 	}
 
-	if (config->vq_align > PAGE_SIZE)
+	if (config->vq_align < VRING_USED_ALIGN_SIZE ||
+	    !is_power_of_2(config->vq_align) ||
+	    config->vq_align > PAGE_SIZE)
 		return false;
 
 	if (config->config_size > PAGE_SIZE)
