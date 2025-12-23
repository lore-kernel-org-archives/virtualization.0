Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089D32FA1B
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503624; cv=none; b=pVRBB0faB0fmf6iCSbwJezrWn9HW8kOMV9BQzhqfq79n87Gs2p/ktoup+15rReurobCJYfLgqJGaRzatpYTGw2Ha63qpUrBUcqVPzKOOGoJhxeSfmmclzyGot4kqb57ydt97E5Szjbh1igFpwh6Z413CNPb5XwdUk959vP4Y3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503624; c=relaxed/simple;
	bh=FNjOWXAmMiSFDurxbAY5FmfDgB2timg7UJONSCEV91w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dt1tH6n+d6s3xVXA28MtCVtqmZ3Fd7Rd7eIjciz77yIesRl0wnW+GEr2E9opCaR3b5+SJ4OKQBj57ooBxvTNqx5hmBf4XcuT3S9RUvujV1bzNTXvvYk8AQOMdbXNqTcNW1O6GmJ289DIYT2xZ0hjctxj8Ola/3ugDUO7zsLFIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbrlPr/N; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbrlPr/N"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c3259da34so5056769a91.2
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503622; x=1767108422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Te/v2waHQmamwOq0sULQpKzWYSQXa6/bK0ITErWJeQ=;
        b=VbrlPr/NNwEvBdWrmYjYuylqKJNrMvdafXcKi8gk5QEQV5VXEWewa3ro5pzcDOybbY
         VrLanHKJ2DJJUndvpgSvNO6jAf1Us2FfcQelZY0ey7peTSIKTZQh2AbT8uiwPu+MZQTe
         NjKrDjgH15+TYu5ZGT7RSIg2bWydh9pKxabhvHqhg+7Dvzce3Y16o0HS2VPSg8Qegc86
         MomYpuq66dawCbGQieQOORjupQSY7KfGPKbEY8yauDVQ1MfLg2fI2CKf//QDF4gdRNLg
         O9WXrSY07N+uIDo63fhHdieqRcTxVV0nn/a6hl+V+9bLOKXU1pFwRk3OaTFlnUdUgf6H
         M3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503622; x=1767108422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Te/v2waHQmamwOq0sULQpKzWYSQXa6/bK0ITErWJeQ=;
        b=adTw+0qDQtRIYbZdvTBctG2r1+3NgQBnlihtaPZWYD7+vhoG5Dc06aYI8hpmmo5qKZ
         rOPcamsHvotKou4sPnlKwf6Q/9d9lLCyzgfMc/UoGniItzi0xZtATKiVvWHjX7zpGQkI
         3L9+M29Hir9DhzQ+Lc+sFoDhMmefd8TELmwnY5GbCvDC7xn3UPiMNZRdaIf0ie7Op4Vs
         cAYSzTbOczRc93AeJMHfzYfBmSpmfBsLL6A12E/9rwzqxoUkUkoWJlYZ60zc5doi5/+v
         78ikwucbRaWPkk55pPXEBKA7IcqvMJsfyl/+d9O7ecyVrGIQHSiCFA2f14Ilfq1VkAfk
         2EbA==
X-Forwarded-Encrypted: i=1; AJvYcCUUy9CdNziYafyNaZYjHZl96p9VapzoQDxK9m9S2sKu02NaqwURhPmFZN60VS40l5jRyd60uZWNh18meSDhzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ2epi3u36o76WmykFHZPZfuOJwfiqxzWBjvRZzfRDUbjB1wDH
	nA/5OMpH3SLGyh+Dq/vyi79pLp/78aaJ4DArXRuJTlDNAyMKmkdaHovW
X-Gm-Gg: AY/fxX7CO351ZYn1VB2b3W1E55zz0Gkxs/Hu2AcXJEYribEENgklQMW0bJvIwEt8+5W
	jGwlAeC3figqWSQjxLjSBbBEghdZrp9ErTecJziK8VS5V8L0VTByAejR+z0xqzRMLqaYz/MCKol
	CLfl78sA7T4U5XsGD6W7mdky0GkIxM+HGc18BxCOrqQ4tLCmDOsSzmrGqiu1ZGkLCOX0VEMDLt3
	hC+/vCkKVPljx5rNzEmjSMiRHQjB3c508LIdnNQ/wk4UhSUpBkRREogKluUvaITugrgB5TvxHmq
	Xe2LRqwvavzgUjr7nmb33aV5DUjyEz2ooBG2e7RpP6FabIYJenunARAqR/hSmoo7yaRYGo7PAFF
	XshcFE7BnCNv3I0hGajneJSXIxmiumh+fhSjCqQKfu7aP0CGSbfAHKYwKHNly/kyaEe7gkClk/P
	sxFebtH808VW0xKJLtGxL16Sg+kowJaDgRQpk=
X-Google-Smtp-Source: AGHT+IHs+VCzqx2tYFavwNoq09qWoQGNowOUFffowxOLdmg82RfmPo0+b2W9UfBUYK3AtZWwo3w3Lg==
X-Received: by 2002:a17:90b:5608:b0:34a:9d9a:3f67 with SMTP id 98e67ed59e1d1-34e921f010bmr11520195a91.33.1766503622215;
        Tue, 23 Dec 2025 07:27:02 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:01 -0800 (PST)
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
Subject: [PATCH net 0/3] virtio-net: fix the deadlock when disabling rx NAPI
Date: Tue, 23 Dec 2025 22:25:30 +0700
Message-ID: <20251223152533.24364-1-minhquangbui99@gmail.com>
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

In this series, we make the refill work a per receive queue work instead
so that we can manage them separately and avoid further mistakes.

- Patch 1 makes the refill work a per receive queue work. It fixes the
deadlock in reproducer because now we only need to ensure refill work is
scheduled after NAPI of its receive queue is enabled not all NAPIs of all
queues. After this patch, enable_delayed_refill is stilled called before
napi_enable in virtnet_rx_resume[_all] but I don't how the work can be
scheduled in that window.
- Patch 2 moves the enable_delayed_refill after napi_enable and fixes the
deadlock variant in virtnet_open.
- Patch 3 fixes the issue arises when enable_delayed_refill is moved after
napi_enable. The issue is that a refill work might need to be scheduled in
virtnet_receive but cannot because refill work is disabled. This can lead
to receive side stuck.So we need to set a pending bit, later when refill
work is enabled, the work is scheduled.

All 3 patches need to be applied to fix the issue so does it mean I need
to add Fixes and Cc stable for all 3?

Link to the previous approach and discussion:
https://lore.kernel.org/netdev/20251212152741.11656-1-minhquangbui99@gmail.com/

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: make refill work a per receive queue work
  virtio-net: ensure rx NAPI is enabled before enabling refill work
  virtio-net: schedule the pending refill work after being enabled

 drivers/net/virtio_net.c | 173 ++++++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 82 deletions(-)

-- 
2.43.0

