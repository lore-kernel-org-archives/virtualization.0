Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4F2CCC1
	for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607347; cv=none; b=XVMUR8W7KceEcf0cBXybZngT6kySbHgj8bRBQmUoIaGAettgwiya5ltNMZLwuthdpKO/10chWHzwnkwV9HzeQCtJz2/KRB8Ng0ipl/NXNLi9T+HVEcOyhYgPJsoOGkUfktD4FIfSuRjED+2W3LA0YGtWXjCcbgCeXYumA4GcJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607347; c=relaxed/simple;
	bh=EUELgt4hMnMMJOO/U7NuEFbDX9SHw5BmfrFvM/ORxqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZd3DShHYvQIqVrzbObDUAQaFa39gpQBVavBxAzSVzXI6OwzgMnSvVO6VCkstn3X5vp391nDkTAr6CG9388EXJp/Pk4NMXbH5KtRLmQLmigQMQFtb+oLtwPkb+Owu47CGD2MOnl+g5/HaEFF82nKcsL0DocDjSjtCAeg8Pbjt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V12kWFJB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V12kWFJB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22548a28d0cso57172625ad.3
        for <virtualization@lists.linux.dev>; Sun, 13 Apr 2025 22:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744607345; x=1745212145; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fej5fA5t2ol5BfFTXsvj0x2AUS/N3lMaLna6woIGmM=;
        b=V12kWFJBYDPmnPeZ39QxwpdK4W7uYU7+9vbJKBh9Fpq4y5PXOEQ8VVOMYaJHsN2MYR
         TxOsP1cmFV4DHndMA5Ht1w/L6/g7fsHbDy+ggpzshExlVBTNxjMAMpOwkY/Dt7ALMN65
         N6BsP3L6nx2l+sSYmSNd4W6qqgvDjilxMRefc63px2vPmxPsyw8ZTesBxgSgiqnHcGOn
         ScYzL8x4jKfyGNNe8y4d0Tc8YEd42L2cmul0HzdMH7usRD1MB+hBD22K3i9gMnQ3FFW5
         tReDrrEGPRXkIEfJYvOZATQGWM7aLS6xovSHhLhei1fvLoUrLEgNaCk/dReTfRbD3VPC
         gHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607345; x=1745212145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fej5fA5t2ol5BfFTXsvj0x2AUS/N3lMaLna6woIGmM=;
        b=u98ri2OUVXa95c2HmclysMNyV4XgT9e0UrJj5b9CbvkCHAijKi4UeHrPxEEiARBSDs
         IhunlOkW/n8R0L/g+O8irl3wza1E/UcA5RPabLVPz1gYRovhq3xNj8p//ryfyFcUBqyM
         q4UsyAgTOM5cNR9jDXg1Y4L9bmiOIkIkf+jihOU+uDjJrvliYIuBZSNd4Y7WYerDqvHC
         vBqF5GBUsRPVK2WYwY74JhUGQnrms6rubMv5C2P/znxUruYJMTTb27kYUIYDVJ3bcsoc
         B4qc/QmjzYCbVOLiZMmKytupaDmpx5cT2rfA/ZaRIc9iPSqfjdmxN9uWm5EZSXGzF/Gx
         6I/g==
X-Gm-Message-State: AOJu0YyxpqKLs4FrFpfZ79Haau9pw+6a3bQ/OVVVMZB9CrJomxJm4ywG
	p8KCJU7yCwzYzpZuK+hobzsu7dxTA/Uk7PArlbNXmZ5M7hIZbCZhUD6PaCfG1YY=
X-Gm-Gg: ASbGncsxBoS+YBodYC0g9gc/wSrXUPvFOfTcHN5+gaVAXQK1A5UTRWGXPSD8Pvo5gwo
	CV6dYx3VEKxH39mvmOPGDxecR6D7rXWt1SDStaRdWvCrvE2vastf8PIFBPCRBrHDqIJQ64Ntn0a
	5fK5gbQ6ieVljzHg/hWhIBhvqyt1aw1bFB3Om25Eh+UyzR/zHk/dJ58Di69rKs9kuOrvPHDVOxA
	r6au21DyXq0U5kSOqd7BR0O2muRoDKJhhWrmLNY6gVPdxymY2s7Iry9KEa7MF/geP/NStKAccWf
	ndZX2DkiLH0hcd818XaT6UJYOgLxEcDVjVm5dsPHOnX3J6jnpbiDpXJS0s5eQN21lw==
X-Google-Smtp-Source: AGHT+IGdtrEP7ucqfNOc8FOWb04RISSfzP7ZCyxG4G1woJVwa1KuxSGZbHjR22opAFd/Nl338AzsgQ==
X-Received: by 2002:a17:902:c951:b0:220:e5be:29c8 with SMTP id d9443c01a7336-22bea4f185dmr178332735ad.32.1744607344881;
        Sun, 13 Apr 2025 22:09:04 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:b80:9edb:557f:f8a7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm90778665ad.170.2025.04.13.22.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:09:04 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v2 0/3] virtio-net: disable delayed refill when pausing rx
Date: Mon, 14 Apr 2025 12:08:34 +0700
Message-ID: <20250414050837.31213-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series tries to fix a deadlock in virtio-net when binding/unbinding
XDP program, XDP socket or resizing the rx queue.

When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
napi_disable() on the receive queue's napi. In delayed refill_work, it
also calls napi_disable() on the receive queue's napi. When
napi_disable() is called on an already disabled napi, it will sleep in
napi_disable_locked while still holding the netdev_lock. As a result,
later napi_enable gets stuck too as it cannot acquire the netdev_lock.
This leads to refill_work and the pause-then-resume tx are stuck
altogether.

This scenario can be reproducible by binding a XDP socket to virtio-net
interface without setting up the fill ring. As a result, try_fill_recv
will fail until the fill ring is set up and refill_work is scheduled.

This fix adds virtnet_rx_(pause/resume)_all helpers and fixes up the
virtnet_rx_resume to disable future and cancel all inflights delayed
refill_work before calling napi_disable() to pause the rx.

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: disable delayed refill when pausing rx
  selftests: net: move xdp_helper to net/lib
  selftests: net: add a virtio_net deadlock selftest

 drivers/net/virtio_net.c                      | 60 ++++++++++++++++---
 tools/testing/selftests/Makefile              |  2 +-
 tools/testing/selftests/drivers/net/Makefile  |  2 -
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 .../selftests/drivers/net/virtio_net/Makefile |  2 +
 .../selftests/drivers/net/virtio_net/config   |  1 +
 .../drivers/net/virtio_net/lib/py/__init__.py | 16 +++++
 .../drivers/net/virtio_net/xsk_pool.py        | 52 ++++++++++++++++
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../{drivers/net => net/lib}/xdp_helper.c     |  0
 11 files changed, 127 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)

-- 
2.43.0

