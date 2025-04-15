Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2627A90B
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703091; cv=none; b=glk5aMzMJbV3EgU0hMCwEshE2VFloH4PBvjo7NBiGvu1bV0rGBU4NSvyg72owfDPZM0KPgFqYgpKcltq4pPaJ73wcqazFfawUyP559VceC4B+jgKT2KDYayUMvEuMeNV2jX4wAP3wLxBo1/Z6lDLYJDwzHHYz6r4VrTui3+sdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703091; c=relaxed/simple;
	bh=/FMiH6f5AUMprgPLBbbPPAw7emqARXWFCdmaOPkb+7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrnFGzh0ExDLfBowJSePxKQV1a+Np4KyJY8pt78bMX5jNxA2LoEIRLIruOdLi9jbVx0bwwGzsOvx1/01DE0znPIPCoFQKPGMULLAQ53kw/mp0jyU47IbwLukfzAZLh6xo1bcd5BEQeUv+PPWRuvlHIovPXQERQIrGXXmXADpRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4MD9IQj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4MD9IQj"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so4360064b3a.3
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744703088; x=1745307888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INveNnza9CWIqZPyYaWqCh5Ba9wSoB725eCjLaHauL4=;
        b=I4MD9IQjywhX8JwH5u0cMry+gkcO1cEFDUmY01k/1yoHxTD6T62tDtlPZh6C796Wu3
         zgK4K7YQBj4mFAwPX1S9U2rDTLXDXBCdyKvA2hVEULIIFBdSx3sDkXx1HnPEXjhZew7d
         AYJDxRT+BDjt/j/9WzYkis3fKsB9OIl1QxoGgsgmv1vnR8S6etNE2h7Haa+x3HGABMvn
         3dnzhrRheSVGFz/3/PavSZ7659wXeQ0HURW+Ec81TQU6UMp3YInf4pw5vhBqZcD3h9Fa
         SLIStafaTNRddwaLq6UAX/+lSb8oDzA7WO78vcOcQx+UjPg+WLZU+DeepS5ODoWP4n2/
         X+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703088; x=1745307888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INveNnza9CWIqZPyYaWqCh5Ba9wSoB725eCjLaHauL4=;
        b=IBmxYkw+1cCci2eP3hxWKBO6Ybvfl8Q3B+4b/Stdmri54VjYokIqjPId9xd7vJhtPk
         A8B9dWBqfYQtYTAqoJk6es3loFYaO/ZYixRkGlkcqyZgPxz4axDSk77EGWxw821NcVvU
         +5bTmqNUVczjKungn+L/hXzZ13JvPYN1MWPrKIP7LCyw+R8kdj2iNS2qLPmS75E6/svv
         jlOrYpKw3kKysDNiyt7iKRZuRqyUCVlJ7Xs7RmHOQ6EUFEoh12z8t+h94rAD23oPgt2v
         gANpytihJQ8TZpNSMB4yLALh0W8TU/jwxTNtxJbh/otS7h4+ihqt+M0w64HLlpQDuctU
         0xGg==
X-Gm-Message-State: AOJu0YyMVUa3MD3w5R4ZOLERMcqaEr8ATrrBANlQC/yHhuY4KRIJ+iQj
	2AV2Yd24WLmJyL7lnWtE6Y7ThxrypK8ad477D3OtUFSuQH1xv1Ndc+zrmZ5aUoP7gg==
X-Gm-Gg: ASbGnct1a4nV3iKqQ3R3W6IecNp2goiCe6n8XD+KAYMtiEkY6D1DCTJaPHM6hb+nPMu
	lThZuWfNjsjT+HiRXBtCc5GDLl8+PcUTycvSB6tAe0rJzy57Sv2opWtNm8ACpJDCNbT/X0BM8zu
	GGolJTv0uVCc4+NM/80fkTRSUqi5vYjiSqEeiLF5B7ywJ4PChMt2VuicdUH1ffTKm82PLANRbS7
	SEz5gjDd36RyR1MPu/NAZxD8+O6IDk1ITF4tMhElEDgeFwQC5bLm8MtlXGHzyUNIt/VymGdHtf7
	8P5AeHoqBS2VU0qF4HsR1xBYUQKpZ1+U/Zhbt4VvGVhmD1I1Wdhvjl3G
X-Google-Smtp-Source: AGHT+IFe3WANt4aQPrZWoKBiNglIghBIABqDLjBb7Rl9R3Vj+PTaviPvNoVUhpOXPz+mqNiZrIE0qw==
X-Received: by 2002:a17:90b:51c3:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-308235db6f0mr26769695a91.0.1744703088365;
        Tue, 15 Apr 2025 00:44:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2e0b:88f9:a491:c18a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm12299767a91.45.2025.04.15.00.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:44:47 -0700 (PDT)
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
Subject: [PATCH v3 0/3] virtio-net: disable delayed refill when pausing rx
Date: Tue, 15 Apr 2025 14:43:38 +0700
Message-ID: <20250415074341.12461-1-minhquangbui99@gmail.com>
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

Version 3 changes:
- Patch 1: refactor to avoid code duplication

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: disable delayed refill when pausing rx
  selftests: net: move xdp_helper to net/lib
  selftests: net: add a virtio_net deadlock selftest

 drivers/net/virtio_net.c                      | 69 +++++++++++++++----
 tools/testing/selftests/Makefile              |  2 +-
 tools/testing/selftests/drivers/net/Makefile  |  2 -
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 .../selftests/drivers/net/virtio_net/Makefile |  2 +
 .../selftests/drivers/net/virtio_net/config   |  1 +
 .../drivers/net/virtio_net/lib/py/__init__.py | 16 +++++
 .../drivers/net/virtio_net/xsk_pool.py        | 52 ++++++++++++++
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../{drivers/net => net/lib}/xdp_helper.c     |  0
 11 files changed, 133 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)

-- 
2.43.0

