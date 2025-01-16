Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DE141987
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006804; cv=none; b=RSeA3zwptgnyYD7SiHpGoUCWZYpyQyDi5RIUSqlKozsAY3gXxNEH7qnp+2DLJoV3hbgPHQtUetcgnJO6Kc+sjGnLPEjmHdLaqlxxYq0qpVEqW3zA+uSuGrgyii9pSWN0IybHRNV3tvq7XLMNEJwtqlYYDGKCltOhVy4jI9PyE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006804; c=relaxed/simple;
	bh=PxaGUABDfZwGHALMhA6EDFWJE56G41dezvHCy/3MZPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jDsuhkF0/FffXy2EyNRFF4w8roIyjuD54u9Fxk12e76lzyw/7tGSbxrRXwKxYDsz7Dgtl3bPeokxsIY+lbQPcMcYUV1n7Q9ZYZB4nOK80+ug/0/yoauZhoddJu6RSL9wBvuL7wgvMFSJp85vtC+aeSw+V8BzLR8C6ewV1/Gj9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OqHSPMPe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OqHSPMPe"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21634338cfdso11450585ad.2
        for <virtualization@lists.linux.dev>; Wed, 15 Jan 2025 21:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006802; x=1737611602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1r+E3A1LZoi68KOlSIiDg+UrGp1t+qLs3TwuwgbmtBg=;
        b=OqHSPMPeS/tADiwsFBWmL53F4aLxVy65Ej901Gnq5VpNn0nVUD/elShwtrP/ccUBTT
         LpGBer9lodswPAHJa8hiTb3rCTRdoAznRfERIbWut1F37ckdSNkr4gaftPZY5bK4toiT
         AFeUe2Xs9jPV/+HN34wbE4cCPGw22QMCzzBmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006802; x=1737611602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r+E3A1LZoi68KOlSIiDg+UrGp1t+qLs3TwuwgbmtBg=;
        b=VuxDZkxFs0uKdv49NHXX4/mGN9xpt58wUOPSIl+K0xY6IXBs+VfiCgd+Iq+EJgvz79
         cn4HeSs/WwN6loQChcE+uUvZrj0tvtpELQ+IdePKcevlgZqZs12cr9Og193zMQinjdVz
         D4gtni/axceEo94mwhip7XJtc6rZL4kxs6tNepWHlZDxbp7gkcDvQkQV0dnS0N4tV5hT
         oAQyLGwZ4GcL0q1V+pREVBekKRnH75f6fEKc1J0ia2obwaHQ37QaxC8nfIcuetQj18R1
         QvpkSGM9XG5q8lf4FeiGa3PS+m1v5Qocs97YNhnfN5I4BfSIlakGXLoeTm8TjVGV3Chx
         MWwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTgcID3hyYStNu1/zw54TiFmn00B80/DKzNC5gMNXz/K0BHMPn1OPopaOqNPsmL8inf4YmvWuRWrbBfFB8qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy87cF4ClLhLMNZXW1D2AdKkuV5AxiamaHT7ZKOFcN4m2p4y3Gd
	IqAkxJOLRVRHv3OoL6fl+1R5n7phe2YlC2BIkVR4lEikNXgS85uiVfMZZK5IYtY=
X-Gm-Gg: ASbGncsYIsoV/OVPyRr8k7WOX1TYAjfXkXs9LphW1Gp835qBWl3rXDOCKRQmD9xr+Gg
	56fJ0ANjAaVRK1jnMeARh+D7QMABJnNLsZ4XqbcqDVzWMzdxhHac/HaSBI5mS5mayVp/9oIOC9f
	wmbEQv5/R0GZTda74aSnmhwEv6o5qZME45OY85xSqqGIzFaVwz+2/TFiC9OgSqXRreKXRLhuM83
	5wWf4/YzgTZZ/xtPq6ajoT1pyXeqZ8TlkxEWObceqFFwgFHIVQhZg1NztcIRPsk
X-Google-Smtp-Source: AGHT+IFNdCXa8QX/05yvf/OWy2KJnL5/tksWkjrm/Z5QSwf5RL8iWi8wxNrXPyaNMxgtOmHTEyqogA==
X-Received: by 2002:a17:902:d482:b0:215:b058:28a5 with SMTP id d9443c01a7336-21a83f52831mr439294615ad.18.1737006802656;
        Wed, 15 Jan 2025 21:53:22 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:22 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v2 0/4] virtio_net: Link queues to NAPIs
Date: Thu, 16 Jan 2025 05:52:55 +0000
Message-Id: <20250116055302.14308-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

Recently [1], Jakub mentioned that there were a few drivers that are not
yet mapping queues to NAPIs.

While I don't have any of the other hardware mentioned, I do happen to
have a virtio_net laying around ;)

I've attempted to link queues to NAPIs, using the new locking Jakub
introduced avoiding RTNL.

Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
As such, I've left the TX NAPIs unset (as opposed to setting them to 0).

Note: I tried to handle the XDP case correctly (namely XDP queues should
not have NAPIs registered, but AF_XDP/XSK should have NAPIs registered,
IIUC). I would appreciate reviewers familiar with virtio_net double
checking me on that.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/

v2:
  - patch 1:
    - New in the v2 from Jakub.

  - patch 2:
    - Previously patch 1, unchanged from v1.
    - Added Gerhard Engleder's Reviewed-by.
    - Added Lei Yang's Tested-by.

  - patch 3:
    - Introduced virtnet_napi_disable to eliminate duplicated code
      in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
      refill_work as suggested by Jason Wang.
    - As a result of the above refactor, dropped Reviewed-by and
      Tested-by from patch 3.

  - patch 4:
    - New in v2. Adds persistent NAPI configuration. See commit message
      for more details.

Jakub Kicinski (1):
  net: protect queue -> napi linking with netdev_lock()

Joe Damato (3):
  virtio_net: Prepare for NAPI to queue mapping
  virtio_net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c      | 47 +++++++++++++++++++++++++++++------
 include/linux/netdevice.h     |  9 +++++--
 include/net/netdev_rx_queue.h |  2 +-
 net/core/dev.c                | 16 +++++++++---
 4 files changed, 60 insertions(+), 14 deletions(-)


base-commit: 0b21051a4a6208c721615bb0285a035b416a4383
-- 
2.25.1

