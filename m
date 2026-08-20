Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3673C4174
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213066; cv=none; b=eGGVY+cRRh0+aFamyb39gYMu3dBC2wMTXtzboMrdqPoo+TJvEic0vA4wR1dKPEONv26ibZggRcjYskdFis4G9BvB4kUVmk6lrFwLZQM+mbQCXKkTTsfljzubIhz2u+cu/9buv/JAs0C5auz8+d/a9ejv5LeYk6tX7OL+RHEtJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213066; c=relaxed/simple;
	bh=ru4qweuJqGlhKUthy5/6S5+Rr1FUsZoR9Bxo6pxBe84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WdgvOnQsazeatUFwEG47D4aJfrLh7FfL8lSrwE8YTgQI8i95I6d++tZpROUkBhjyB2tr5qtv7t7EfUSWwvdFbiBbY1n4ZUQCrCEO4Qd7TwDjDxjvO2M+F4QdjHB5TmTwSMUebVqql02O7g7VCfokO01qUKm2Mjm4M3p2N80pmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi7wasdx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi7wasdx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab973140bso23473715ad.3
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213063; x=1787817863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x78ErVeCRHN6nIR5BE2bLaNonVUmCkwh6pqCr+oiUKE=;
        b=hi7wasdxCkcbvq+b/FsjvDrmkW3e58iIBXidsgh6loopN+oUK56FiPc212WE4ftyzJ
         B5BdO+ZH06wrbYeXN9+10F9vcLtD0rnU7ouWxHf0loBxk6aVfs3XC2Jdhf6DjGEaKm2y
         cohrX82qqgUqwWsTHFkP8Lky4bgKx1BWPq9LhaGZjPD786ISAMNtZaOrTxtiFfx3l1a2
         tIYgCJIQFDLv3iujMotP/7CoySsoY3yEOF2D1t8qYE6r3TSVNzLz71O0YI+EyR2w9Sqj
         V6HkGqz+k3IyIrmcoI5lYg4bRb7Y6U2j0Gt0T3lyvhQvSwHno5khlQGdaJ1XKs8RofHj
         urUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213063; x=1787817863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x78ErVeCRHN6nIR5BE2bLaNonVUmCkwh6pqCr+oiUKE=;
        b=diZbGn6HfYOsy5RToKVSzy4mL2Y2hRzf4aWrAQuWvwP+YN4qjI/6XvAYslBsySNEz+
         qUhGBXQFPNkuvO7iTV2xWUWcnfgm8xqFAvrIJc90xLwtEZHVEEFvG1bQtBE+pymy7tKQ
         8Bxzx1+tburrVIVe0UhSU8MZ7eil8k6DUEY+QFOssHfWsgRgiOeTw7tMqy4yjcxsoEpO
         gQKTndQ5Na/+Vx0cNrU9peQ+aHrMGDMOGifYwkCsT1z3qwjUArPFkL58P+fDjTp5mQF4
         F5nSZIhish1TZytD5N0tFnIfCo50fKlCNlT3Z8lKFBoBLh5CqWyAMBx5uH5faIS5nlmL
         8n8g==
X-Forwarded-Encrypted: i=1; AHgh+Rp1C4J3bFtTqyUk2Qv9QY/0+BGd/4WSuDjuacL8mSD6crigK9cjTa1q+e/rqBLRJIeHR1psqVhbP/2KamMXAA==@lists.linux.dev
X-Gm-Message-State: AFuF++kKZOZyFl7d5i3UqXslvFC3VJ/cuL621k1Qp3K2T9woaUI96OgJ
	4eNY1/wHvYErQUfW1w7KKcDzx6xXYGH9d9oSgtn4f1/Su+L/qEM0kXuT
X-Gm-Gg: AR+sD132AieOM8CGqY/fzry2IMc/KYV4Cen/9gn+Uy+FPAgVyM9cpyjT2LY7pNLLpT1
	zZoZQm4LXfxKey6Gi7tCdvHe7QPE5SlgNHuBIYdsfxdo1VX7UGGXV7+79ExM+i2jOmIpfgZCGj6
	yaftcMeFomItdHZopmzhR0nVYBG+SbyWrM95UvREFc6IQ1eKOSKBOuMCrg//mDekh8a4sehGuAo
	N9OjGScRjR5Gqln1xWe+V2u7y2xPYNrQfkZUnX+L+zzMRA4UzdgR1hj/IyZB3YGHZJVLj/Z5opE
	6IMH4mk4hue5/BvN0o3o/3vCN4df936M4DUIGOYDZfrftc3iTzPMU/9NGgqKuHOrWn2opYif7i+
	HXVwjeksJGkW4CFhOtmcE4sxcNcgJxBUtZajh2FZMDi8wZu0tW+f4MqWzzCAwnEr/9QpC9NorNv
	PYyg1eQpaLOkkJR9WrpNdZgf0Bw1GEKR7hNyTRVWDr4BrbvZZa2GSK2T7UMV5tSCvS0gI/Bw==
X-Received: by 2002:a17:903:3887:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d5fd740167mr200442945ad.9.1787213062229;
        Thu, 20 Aug 2026 01:04:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e175sm3556075ad.50.2026.08.20.01.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:04:21 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] vhost: fix device IOTLB feature lifecycle
Date: Thu, 20 Aug 2026 16:03:29 +0800
Message-Id: <20260820080332.313933-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both vhost-vsock and vhost-net can leave the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. They can also replace an
existing IOTLB with a new empty table when a later feature update keeps
ACCESS_PLATFORM enabled, for example when updating logging.

When the IOTLB mode changes, the vring addresses previously supplied by
userspace no longer have the same address-space meaning. Leaving those
addresses installed would allow an old IOVA to be used as a direct
userspace address after the IOTLB is detached.

This series invalidates the vring access state during IOTLB transitions,
makes IOTLB initialization idempotent, and uses a common teardown helper
for vhost-vsock and vhost-net. IOTLB mode changes are applied even while a
virtqueue backend is attached. The device-wide IOTLB is dropped first,
each virtqueue then clears its IOTLB pointer and cached ring access under
its own mutex, and the old table is freed only after every virtqueue has
completed the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses
for the new address mode before data processing can resume. When
ACCESS_PLATFORM is enabled, the usual IOTLB miss/update protocol
repopulates the new table.

Changes since v6:
- rebase on the current vhost tree;
- remove blank lines between commit trailers;
- drop unrelated error propagation changes from the backend patches.

Jia Jia (3):
  vhost: invalidate vring access on IOTLB transitions
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

 drivers/vhost/net.c   |  2 ++
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  4 +++-
 4 files changed, 58 insertions(+), 2 deletions(-)


base-commit: b282418bc366194677eafd1dad180d92254586ac
-- 
2.34.1
