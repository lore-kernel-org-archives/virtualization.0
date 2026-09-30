Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EF30C157
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756415; cv=none; b=i6Ej1EcIDfCeJQPoPDdEWiQDL0/T/s07ywlQ0SEdytUd4yQ4T3MaZ5thx2fuz9vpLRWiym6JQSqEMzxrqt0xV/10iYpJ/TjAkUY1ZKUFAKul48DB3E6eavjrD0mQG/dCzLXGSPZARpyzlfYFTHK7EtTJfXhsp5/DsPC3h9O6vaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756415; c=relaxed/simple;
	bh=ycztRh6KW31aMbR9JOx+NIxGDJnhNwHNSAWSFQMDw7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHWKVhZi2//ci0EMB4ib5lMme6hhm//p/mfpouO6oY1mHYlld4M25bZHgvSGvlToSW/RgxMi8jKdhsx0Mr68f1EVAw3oNN8t466lZksU7zvDhnz/6la1BLq23+085I8+mKVuL7fo/kitFzlXxSaxO3857ETxoGLFseqdz0bUhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-885cd98d226so516154b3a.1
        for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 01:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756409; x=1791361209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlT9uucan4516HjvpINSh7L9WJQ72N4e/zzaGJgPCFg=;
        b=O8LPd/gDtibvPGg437F5Z1QxOWBGwravZr0jU0cvOxCUJK9P6/GsT6uyNd5XPKV+HS
         Rxj9ExEJwrlDCTPgY1ozuoTHUJPZRZG4xK1zpfqmv4Fv32gUu/aWnJ8L4C7tKiG1wcua
         GwWBgtPwoePtViUvYGxqulh67MzlfgzmUq/MXYymAng9GjzL+OKhmzn/OSJ4b9PE7LYL
         skLvvzoHeNVPfhhMMGxJF9SJlqSbVVPO15n8PuomuWLUMoLyIv6fpGPTGaG4XkY5Mie4
         se2yLY7JD9RKK53Foeyw1nel1P3g5Q/AXLFR4KzBkHkY5VZjqM7mmU5F0dpcZhYQJmXN
         uY3g==
X-Forwarded-Encrypted: i=1; AKwUvBxzZsq96tUyYd/ba0Id+qmt6tGjOb/29wNHZM0SaFMH1Iy7A4xUkKy7cfYJwQTVDgBfZs4F6N4JcL/6pxXX5g==@lists.linux.dev
X-Gm-Message-State: AFq9FYICkr75xvghKslpy4ae88/9ODJHHgX/Oo6JAm8TldDYH+uP/n37
	klxpNlS1dQfPtn1V8oN/MdSQu/++sEg0YGWeS803BCZs/q6lL2geJXok
X-Gm-Gg: AYBFou3bu70Rmpj7hcZbe+NNvpK/4VHOpvwjp6YbUhvi34IWrh0L1xntFI0/cz+fxem
	PzesX/CfSOx25CmSz1f4ggjDUTFtPuIEij510FiSPIZVbSAYGqsCw8Jo2h7oKINppe6TsnyvXKY
	cOiAEhp+naSZ7LazjuLRW8af+c/cQ06tjaKWe4AcC44t2d3uTGyS57HGyVMXkruUWbjgXF9S2VR
	nh5RpMNa5tPPQWrTPgRlCYNOSwPSf+JFwaNI3Xmas0dWcJSWSRX2VZ8yA0qrZ6OXjtLcWDDb4ty
	ATd9qCNCdBgqpijQkvJ/GMR3Jy8Q+VnQ5Z6nWjDgzbCuprsLu/ZXGcnT9zpHmCIzhjp0o3pXzzy
	aa6mhG3+xSfz9wMK3jWQ3us95S9yPimpFVLNmSmI6e7YoRIyB2U7/SjLC3LLd+oFvdX9vpgOIQ+
	GsIySV70/t8Vp6pAQLpLyjqQULvVdM1R2mohpyvg1TyewducDqRoFE5MvibhleRFAO6Ck09l2Kw
	j/yvt5DZW/nRC0L49s=
X-Received: by 2002:a05:6a00:22d4:b0:887:29b1:27f3 with SMTP id d2e1a72fcca58-8874e34619amr311376b3a.44.1790756408640;
        Wed, 30 Sep 2026 01:20:08 -0700 (PDT)
Received: from foxmail.com ([120.239.72.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8872643904asm419955b3a.45.2026.09.30.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:20:08 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: [PATCH 0/2] virtio-net/dim: fix irq moderation init failure unwind
Date: Wed, 30 Sep 2026 16:19:50 +0800
Message-ID: <cover.1790751008.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net_dim_init_irq_moder() leaves dev->irq_moder dangling when profile
allocation fails.  virtio-net probe then skips virtqueue teardown if
that init fails after init_vqs().

Patch 1 makes the dim init failure path clear irq_moder, so
net_dim_free_irq_moder() is a no-op.

Patch 2 sends the virtio-net failure through the existing
free_irq_moder unwind (reset + del_vqs), matching the page-pool
failure path.

Patch 2 depends on patch 1.

Jianlin Shi (2):
  dim: clear irq_moder on init failure
  virtio-net: unwind VQs when irq moderation init fails

 drivers/net/virtio_net.c | 2 +-
 lib/dim/net_dim.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

