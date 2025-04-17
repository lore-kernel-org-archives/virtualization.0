Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E312221561
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874963; cv=none; b=lCrO137kRNWF5RSSpdUkRL0oZzOvNJyQk2ZqiICbrZZNsUQwbFeq+oDh8tIHi3+y34advFu35XjR4PyVVj80b6ehZLEQfcrsfMOEN1CAYKNI8gaq3MeslzcU6m/E5VZ+Ob3t6i4zjLZr0wR/G5BXes7k9Pm33bU12/UdCwjtZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874963; c=relaxed/simple;
	bh=y9TZDQGpXnKwI0UWUN8LOu9Cl+PcOJCJTNXweRk/7W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cd4WXHcbrvRoKqwH5iIfxpIrHGxBGqvGnr7rcajitOKBI0hl9nLAXoyf3mox4ps7LfcDu+nzXT0EOq2BL1YWIi2ctT2sBpclubK2op6ROcrNWjScLk1njBUaVmgPVoY8SYjIa3IlvjD9vJosWFsOk4nDAPZ9rkZL4lX4Ma2QGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXT+njma; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXT+njma"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7376dd56eccso469512b3a.0
        for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874961; x=1745479761; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbhaIlXKAU6n8hzVFN1a+GS8NGL/eiRsd2Kom/nuTD4=;
        b=OXT+njma80r3p1XN31Z4krVWBsI6QcR6FgTkp4ytSKXPuvKjgkR+aezsfl+07cY0hj
         1PnDDu18KvdZun+dB+L1P0UyYDpdbBsFvGuLEfL+rRBONzGfsjwnoA4ZjNssHnrtDPz+
         D3bJNjE/7mfyCljQ1a/SLXzSrOWm3JXTTmTsVpqgP4MB/Gewm7Ze5bjdBLTjZi2ommnK
         0z0RAwp9x/IXj1M+PNxlRu/j8elYslHWjOsB4mAUOlr8sureRdfmx/uQNQkgJ0QtBpbC
         Tq7CWQo3/WE3TVeqj8PS11poSfWy8FOLoMEGHD4lG0UkEHw8UeVdh6b0xB43VbqYp5a1
         8Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874961; x=1745479761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbhaIlXKAU6n8hzVFN1a+GS8NGL/eiRsd2Kom/nuTD4=;
        b=uuonI1p70zdIubvIBk2Hv8qpg2Y8Gi57zzAVHDDPuiBYdR+6X1gAAfnfrbef7kyFpe
         o+B72KyTG56G4johtOfdwULz7hwqu5RlxrQYGJ8sfZmLXv3hrvesgJR+AkjNC/oYqUa4
         Fxk5ygZOOMepMGSajEP600DHyNyHRi6kulOyJFuY75Fuh/hBkVlI2pFVrTBjgLLez1fQ
         G3ElWGPr9s3KQSbVeGQdpn4+xUVMqe4y8PAzDNkNNtMQxpdB4JDpCOjjaPgAKmLcWoHk
         DczOVgmRW5SmNssYJ/Nv5H6TlpBa6LxlOxFkW5dt7wcUsfjsTgAD+GxOTObjm0j76cmN
         hlQw==
X-Gm-Message-State: AOJu0YybbjGHYVrfWNJ+p/unAzbB2tmJvp5RB9CZu/Llv2Twa7Wb8MJa
	XexkGxFNXgCG5Low84QMgnMtFWt11/DE9+tE8JgGHkHqTMejdwbNlj3OitgbhtI=
X-Gm-Gg: ASbGncs6tgQAh9u3SADLWcOQC7stU5k3OEpQLJ+0VAnuSMsQ3VOKmA7dQD6QI27gxxS
	Swh2/1seWSiGm4OPZnsmWpI20uSir6JuLmayh2PhjfRa5t1eSCqgGVmANb9MHN/XP1eCkRpX16l
	xasWzzNrEv8Ssdz9DmHugYJ4HT9tO6FQDG2H6NHDlQ0yNBdbKfpE08gyNP4b1D4V+KoFC95XJx6
	IL04YAyXYrGE7EiTszuJgIkfn1nY0gDrFxmXrWbXIPPw0jggpKuVB1dZeKxT35ooVXw+nrLS14R
	K73jIdncCLZpgAvHMF8dfGu1ScmhhV9cToqVZYCK3MNwJA0HzP1XEkAJSsFJRmY5kUw=
X-Google-Smtp-Source: AGHT+IFzEblk8eZ9i/5b7FlNpqvFEMtawQArN9INdKriryj2jHy81r0kRCXNbZYM8rVezBQJYW1ZKg==
X-Received: by 2002:a05:6a20:43a8:b0:1f5:8e54:9f07 with SMTP id adf61e73a8af0-203b3ecd617mr7221150637.24.1744874960903;
        Thu, 17 Apr 2025 00:29:20 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:20 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v4 0/4] virtio-net: disable delayed refill when pausing rx
Date: Thu, 17 Apr 2025 14:28:02 +0700
Message-ID: <20250417072806.18660-1-minhquangbui99@gmail.com>
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

Version 4 changes:
- Add force zerocopy mode to xdp_helper
- Make virtio_net selftest use force zerocopy mode
- Move virtio_net selftest to drivers/net/hw

Version 3 changes:
- Patch 1: refactor to avoid code duplication

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (4):
  virtio-net: disable delayed refill when pausing rx
  selftests: net: move xdp_helper to net/lib
  selftests: net: add flag to force zerocopy mode in xdp_helper
  selftests: net: add a virtio_net deadlock selftest

 drivers/net/virtio_net.c                      | 69 +++++++++++++++----
 tools/testing/selftests/drivers/net/Makefile  |  2 -
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/virtio_net.py    | 65 +++++++++++++++++
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../{drivers/net => net/lib}/xdp_helper.c     | 13 +++-
 8 files changed, 138 insertions(+), 18 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/virtio_net.py
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (90%)

-- 
2.43.0

