Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4E25B31D
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367245; cv=none; b=FE4A/6R9q8yMF1maGMfNvaLTetlEUVriad3CBT6IF7pr6LHt55KYT/925O42aJAqzlP2K6vQOfHhofLw6vEK+NtU+tc2rp3O1cdSuW2TU0Uc5DRls+RHDD/pAfRh/Pr8JDe3qGHwswBl02JicpG8XeIHhoEDv3fW3SCxIX04N8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367245; c=relaxed/simple;
	bh=bEfI9VdyBfyGoJu/InKuPX/XT/uFeqFxXXZCS+SC1Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4vf/LnqaWZron2PDro2nVkaUxEPXSuDQ2DqatvIVScvx6YRxPtYtjgfFwvGKLW1cVqeKcPAAOHwbQzj4Mf1AuyPmSoJ3iHQkswxIdpUPg5tXSMgUVY5fZPOeySCFEqzZEtAury0zjuASW9bQb7IuBwX8G6m7DaOd3XAWksWG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1hET98c; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1hET98c"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0833b5aeeso165525415ad.1
        for <virtualization@lists.linux.dev>; Fri, 02 Jan 2026 07:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367243; x=1767972043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w30MU9We+VQZj/AlvgZCJU00iqT1dGAHAA+FFNT8Fc=;
        b=a1hET98cNX8KM0/eNHxZO6OYhH6tB6Jl9o3/gQ9AVmGig0iDasTll/Z16Z8FKA5FT/
         oV42ORMivcYygnAW8HDy28kr2xMFfYsINRdE4RNf12WNjJm998Ejac4X0z1OqDq+fTlj
         jDReqfabepgC8tARj8HWAKIlXzClQTs90kLHzkVwtiYw+g715bE3/+3MZ3iEsiV+1ESd
         1EUzvRD3aw5fWarCEJ9BSTFf4bLczHK3kaO2zkNAX/v6aHxoi5ywtTU4Mndmf9WewFd9
         XIUCDnS/7wv8MYNPvODwr4Ll3Wlt1Iy6v4mcBxUCWM9a/KUzD5kZjlae+1VI7MyuWYjz
         w+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367243; x=1767972043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w30MU9We+VQZj/AlvgZCJU00iqT1dGAHAA+FFNT8Fc=;
        b=OCfVqY/8sZK3DyLZ2oBL2oJYwwpSVw7+Oi8Bc0LpAJDvBBO9YZrGv/lcr7OOOIGR7W
         kjnjKu0BORdQsrmxUkmEk8B4TS6JXZtwSn1G5q06XQe4LLphQ5TCb/alIlBe3jfvmVAq
         rzbZel3wIrL+ktPPnUgyQKQ23SiDpXZ88H++TcT9R7zDFt0K9/qvu4P2pFyUX0Uv0tfz
         C0vBHw5CHy49PhCrPQNH4gd7Aw+WEvD/VcCmAmlm+lZostYk1mVvcnAW/Y8AKeSRUM+F
         vIzb9aBiCalXnnTfT8idcDXiz8nvhrpLUL57Ti8sn5qslzi6AW9TevzD12u5c+xQeFs+
         X4yA==
X-Forwarded-Encrypted: i=1; AJvYcCUlXqud/VGAp6vCt5wCkK+eTBpj79F8++b63QR3REqyC+FOzEGLxiErcDKa1Ru4407o0Zf6/EFSDCHcXO9Hyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWpXjeeOwOhankpraB0bGrK1MMb8hxbuedjtGvX7Mue/S9yuW2
	zxr1LjFywVTz78meyu9bQrTT3JR4drVkmzYXH2kUMcAQpDtFPgcOLN3+
X-Gm-Gg: AY/fxX6fVOG3i0PJHP0GeUUMSCuurQekeHy6ATpaMLWZNGWnDp9pC98nDat0eGXXrj+
	ln5CNL6eGLKwiYJx6GUwdrObZLovENDznlJipcNrG3lNUWhFZh4C7a3nZwJcL+4bmtm5a93iujA
	k84BhZgSC6M8qeHb0TtHx5Lb63eDQkGFHhnVUthMD+vV731n5Y7Z5BA3hCwSCuPE6lerv7xq2IC
	+aaSqLcmJnx5IQQu1oKn1qMhRVDvxZgf9KvZIqv4eac8s+lHts3iLFAZST3QZZNYvnjrl5c324z
	g3wC8+OS2Vp64CYZhs/mWTDOeFleDyrEKWPvkPWbw0fMxX8nYig6S52R+RAFQZdiZX8f2JSiilK
	kAVRPpjOhS68I3saJ1qPBQi1cdES/c6Er/ntdvf+h4H6cp8/QhGZKwdVnOgQgJ1FAJvqAvTw4xC
	oI5PlyZUn41VHm0AWkepk6MaM=
X-Google-Smtp-Source: AGHT+IFMmIn+2/J2pbEHZ9vcoQ6zTgkAbud3TeSk4TfYXDj4qwzEgISl47tpMlZjJUNUzJ74kzK3hA==
X-Received: by 2002:a17:902:d4c7:b0:2a0:d7f6:e030 with SMTP id d9443c01a7336-2a2f2836757mr413049005ad.29.1767367242912;
        Fri, 02 Jan 2026 07:20:42 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:42 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 0/3] virtio-net: fix the deadlock when disabling rx NAPI
Date: Fri,  2 Jan 2026 22:20:20 +0700
Message-ID: <20260102152023.10773-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
when pausing rx"), to avoid the deadlock, when pausing the RX in
virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
However, in the virtnet_rx_resume_all(), we enable the delayed refill
work too early before enabling all the receive queue napis.

The deadlock can be reproduced by running
selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
device and inserting a cond_resched() inside the for loop in
virtnet_rx_resume_all() to increase the success rate. Because the worker
processing the delayed refilled work runs on the same CPU as
virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
In real scenario, the contention on netdev_lock can cause the
reschedule.

Due to the complexity of delayed refill worker, in this series, we remove
it. When we fail to refill the receive buffer, we will retry in the next
NAPI poll instead.
- Patch 1: removes delayed refill worker schedule and retry refill in next
NAPI
- Patch 2, 3: removes and clean up unused delayed refill worker code

For testing, I've run the following tests with no issue so far
- selftests/drivers/net/hw/xsk_reconfig.py which sets up the XDP zerocopy
without providing any descriptors to the fill ring. As a result,
try_fill_recv will always fail.
- Send TCP packets from host to guest while guest is nearly OOM and some
try_fill_recv calls fail.

Changes in v2:
- Remove the delayed refill worker to simplify the logic instead of trying
to fix it
- Link to v1:
https://lore.kernel.org/netdev/20251223152533.24364-1-minhquangbui99@gmail.com/

Link to the previous approach and discussion:
https://lore.kernel.org/netdev/20251212152741.11656-1-minhquangbui99@gmail.com/

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: don't schedule delayed refill worker
  virtio-net: remove unused delayed refill worker
  virtio-net: clean up __virtnet_rx_pause/resume

 drivers/net/virtio_net.c | 171 +++++++++------------------------------
 1 file changed, 40 insertions(+), 131 deletions(-)

-- 
2.43.0

