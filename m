Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F79334C2E
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711903; cv=none; b=pk87eN7QpBteuv8717abcpZcqYuBgwz6kz0/UHu4UBbrkzXg5e41lmfjrNXzBEJEtBmFq6MxuXjv9Ok1UMgPDxCHKvfF3v0HzHI5E6d3g0ti/ikT0TQ8VqmHbx8d29ASFjwbfhGW+NGSC5ipUmPWR3zYdTXCj4UnFldQm53Osek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711903; c=relaxed/simple;
	bh=K8FNQhu5SnEcTiEsafwMNNxOn2K2Q9Ac3Y0d7g04XP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLlRDvgjd/zZlGTfHXPcPoVlkUJEyQNtSea7ssgSOcSYPx7fZNPJxvJa12rZekAwoJH4ttiUabdYU17beXxT8zlv0uOAu9pX/DM2n0R30CjjHrD5vQvIexd2K0Pr+QdfBpscTXNISpmFaxFvHkomg0+OiWDt8LgD8AdwX8Txvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9s+sXpF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9s+sXpF"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso593166a12.1
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 07:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711900; x=1768316700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1gvuv/xyGr58xg9+znTKspBZ7TugLg/fG73JU/AoDE=;
        b=V9s+sXpFu/UYCvI213HRj5W60my+/AO5QzgAl7103AEZ/Hrso82kbtIKg0xr6zUZ05
         oSZMg0QNFPRMUa+eyRwvOnC0WdT/RJtxG1DzPdn39VqRyEHDNBGZi83h85SyN+KRKBao
         aLEjdj8gcGTGUPuUDY9c5UR4BQhZgVQXHcmn15EU0fHprlaVp/+tj0J5RzattczmZfv4
         Pm0aS0AjjaergyUqX7951LhqK9i1LPgk/8VYeRbwtKFJ2n7yMKRi9Y9QmNOeqCqd9b1+
         BaJHw5KkYoL8XKBB3+c38lTnXA+Rmo6sZ528PBgeS2X8jQyvMKMIYf776Mx3qzVt5kAi
         u2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711900; x=1768316700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1gvuv/xyGr58xg9+znTKspBZ7TugLg/fG73JU/AoDE=;
        b=V+sQQiLV8qp6uuRYT6yAtQLIUtH0qG6EEzbKtmj4LVCX+AXo1BdujUzmKPMdPT+X+U
         yE6/SqNMuuTiZxk5ExmJI999wS3wI1lQQiGm2gnD5iznPOGAoIZzf30reFKymXEUTrCa
         LBeM+7ifYnFkmRbkyHNaWh91lvlbNmzntyXLfbjWJqBtq0k9BRmVkFo7ogE4q/LaYuDB
         MMx86rTAWTLn6x8hzPVrOIQsd+SUZce81XB1+f+05srAa1BE1SCZOaUJjJhzW7QTxShO
         w/PbTpEInefYyZr94xWwvaAB69/oNU3IJ3GtIlRjNZUbmKn6ep7Gg5X57vyU7Kr+Ux7U
         qy/g==
X-Forwarded-Encrypted: i=1; AJvYcCUNqh/LOlPpww7cenDXVcWZbfKNJNkBxEYToby7r8yGqhFOcmvhxUSQ3cSfeLh2Auys7bmUPeSGYrzsiBGwOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQH/qbnzFYMY9kZlbvRpQcMDJi/d8VmTHB6Z4xQUCj2tsYzR/C
	jvLUdMTieC9i3SK3CmTnAR5I+9THLssF+FI4zIf5oQSM5aJX6YqJOiE7
X-Gm-Gg: AY/fxX5j1L2rPSLF77N7bNXcYFbxj9FNIZ4EX5o9KGcyoNEtqydcoL2imUUXCZ9QA+T
	FEFynz/98PACH1ugLOeIooy7ieG6kZAhNbeuIvxTVT0CkZEkLfHPcHqBRmEHok9Cj0R0V9lR7SY
	p74y5069loDNTAikafCyvn+3VNtLVueA7D0kC68rlP0gk7GNw9Yf5QctGLS1CaSxutO4UQv1ilH
	bTnjc+W7lNMINPwGSRf+NMz+xu45zF7eHZ2qivmKGcKA4//+9Dg/myelvAUlTe2imaBgwLT2Znn
	Pen5CbEIi2Y32Y6WYDJdnejLw+Ls6HqCcwSfadkWIIE5EwcUBPhIqzbyINVZJw1WNvdkpCXD9BQ
	Fk9n6emDkAKxNKanuKd/pDLaX9oKizmNMQbYe5QUcZ8cYEx9DQ58VjEIz18vqKRdVi+a7SDuAmN
	Tlp1VjESh9
X-Google-Smtp-Source: AGHT+IFU3Mhn1OWQ/XPfwYIXmQDx2yFG2njwZ4vCzwkyE0zpboeIRz229vtkdBQ3LSp9Eg2BDinhtg==
X-Received: by 2002:a05:6a20:4310:b0:35f:5fc4:d88c with SMTP id adf61e73a8af0-38982246c6emr2858508637.13.1767711894829;
        Tue, 06 Jan 2026 07:04:54 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:04:54 -0800 (PST)
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
Subject: [PATCH net v3 0/3] virtio-net: fix the deadlock when disabling rx NAPI
Date: Tue,  6 Jan 2026 22:04:35 +0700
Message-ID: <20260106150438.7425-1-minhquangbui99@gmail.com>
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

Changes in v3:
- Patch 1: return budget when needing to retry in next NAPI in
virtnet_receive, fix comments and commit message
- Patch 2: edit the commit message
- Link to v2:
https://lore.kernel.org/netdev/20260102152023.10773-1-minhquangbui99@gmail.com/

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

 drivers/net/virtio_net.c | 164 +++++++++------------------------------
 1 file changed, 35 insertions(+), 129 deletions(-)

-- 
2.43.0

