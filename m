Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AF3B47E5
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161986; cv=none; b=X9PYbl7z0Ev332wiNTzW5S25ghJjyyO6joFPucJkLJS/wzFNIqBLJS+LzTGDOXnp4zy5grR+3NOZQkCR0DiMAqU93hAZ+jOIsx0iyyOEZPrK3yzOca0FmU2t5TmiOIMREkVUJr6FqUU0uuhJZ+ExbSIX5R8toLL5ov7lsegGF/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161986; c=relaxed/simple;
	bh=5Fmuk1WPgZ6FNiG4XsMRoLQLg665mOSxeBLCg1WHEJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMtb+e7W5TSDSnjF3jFNr65HnhhF/M4IgWCLqjTXUIynL6wtRjSrgKePpatXLlNojSyd1+6EL8+1lzPLBez8m48X+4k8J0PNnirJMLoOkRSPfSYBJyV+kigHCyixLhd3iO8k/WtmwmqC4gqjjcZqAuXvjj2mzrTBsMCUbS8UNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYyFzxXw; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYyFzxXw"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7dd3f176f84so87339837b3.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161983; x=1781766783; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBX/SP+Br7VLRns9PD3V50R59mUWLcgOroTlWmFsbRo=;
        b=DYyFzxXwC4/JmogUtu/VQvqJLJBpknT0eRVikGi6+9gE6+SpVkzo+7bFsDjBXzQ1Tq
         lkUNncPgRK/8IWYyzxEUiTGO3AJOkB4YBKg7XNB92fVi72HcKhJqHe/CndSYvficuBZY
         O+445LekqF4jIq/W8IDjl+/JkGm54uWAH0d6YY6DRZsbGthDDY70TNfaO6WL83wu25lI
         0oYds/poPzGZco7OKX3nN3TXEE8A14xSF6eFCdOJrX/jNqZMpcB6ourrq45IGrOHsIsm
         ERUEMkRic0inrkM92g+kF65g2xRO3mDbpFSCbbQBk/4LteQzwvZTty8nDOhk6pxHYoG0
         Y2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161983; x=1781766783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBX/SP+Br7VLRns9PD3V50R59mUWLcgOroTlWmFsbRo=;
        b=iuD2JC7dIaPkJVj/oeo0lNT+ptBaO2SwNIi6JDu2IXwHMv9J1cr8LmtzwK63Faqzcx
         5HzGtMj5zoIP3PVGw+Gxf2MLIdJoTWRt5Flyroghtavf4q1Z4ALfvo642UZZHvbL35Ma
         qvv2WPlJxeJB+nVUVAZ6Sha/AoatdC+6VbTwna0hYpXdtCTh5txvnM0I73NDg9oqyBtR
         ixR72XoT13WTQmAxCRvJVa8CFPZFfBTsCtOAhpwRpTF69IeJ9HVuxYKeltQf+fQMv0I8
         PO9LouvgxJjpKWUdQTq1TVYNA1l4RNi2IdMkE1+DRjkF82xLNAYjWsJ+n1Zz5Qxl4mRH
         jQgg==
X-Forwarded-Encrypted: i=1; AFNElJ/T31WfOOQdAqge0EVndY6SzUjbsXRoOvwRmH9JmKErFTW4syUn/YaJ4396czmHijd2vg3AhLZV4Vss9Epo8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuWtbq5zxJcLx5DGKLuPICf8IO6V+Fwyg2jRcVxKqIPrAgJpDm
	B9ZAU0k9qaTL8HS3UHlMiLhvwUnFCk7m7kyZMha/IHsMw53+An8vAbWz
X-Gm-Gg: Acq92OGLDrkPSRijdmpbYFKcXbkd8koAsEWRo0HG+6qAVR2Dql8mLiBhTBo/WZqbCE5
	TU12OGYSjH6nufX5v9jucsyVWtunxSuRXfp17zUhgeZ+z6IcxjgfKPaVbh98yQLeeguy53yxcL1
	INcGsrSfNmZ9/3aUTrwMKMvXpCSmDTe8nlKCkwWidokyEV6pe37IPpJmE2nV+KnZlP40V9wYyte
	RVLtM4zE27sBpsIWO4QmPK/T2anNOz3/XCxRj2N9kHKZg/3ApELR59u98AGScadgrr0veGsAsrE
	Qv5vTZMIQmG6lUx7gQRUhpa+m3jhR1OyZAK0goTgOCYOnahDUiRlvMJNkcNF7bfCBy6iIlZgi+E
	4aSMoFPE6gP+P5Vmrk5d0sfFb1u13K7/x2Ddak2o86EwM3ZTz/QKnmxMkXHE+98qmIsgidrnRRh
	Mh4ffEK/9ZLrPE4dRTLcmBy0eObmPNeAUN3aybMEvxyHJ1UEEarpk=
X-Received: by 2002:a05:690c:6c13:b0:7db:f8b1:cd80 with SMTP id 00721157ae682-7f654f04a6fmr17001257b3.2.1781161983511;
        Thu, 11 Jun 2026 00:13:03 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:03 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/3] xsk: support tx napi busy_poll
Date: Thu, 11 Jun 2026 15:12:39 +0800
Message-ID: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

For now, we use sk_busy_loop() in __xsk_sendmsg() to send the data in tx
ring. The sk_busy_loop() will poll on the target NAPI. However, for the
nic driver that support the tx napi, such as virtio-net, it can't schedule
the tx NAPI, but only the rx NAPI. If we enable the busy_poll for xsk and
use virtio-net, we can't send data, as the rx NAPI in virtio-net doesn't
handle the packet sending.

Fix this by introduce the sk_tx_busy_loop(), which will poll on the tx
NAPI if available. To get the tx NAPI from the napi_id, we add the
"tx_napi" field to napi_struct, which is ugly :/

Another choice is to call virtnet_xsk_xmit() in virtnet_poll() too. But
this a little contradict the design of tx NAPI.

Menglong Dong (3):
  net: busy-poll: introduce sk_tx_busy_loop()
  virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
  xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()

 drivers/net/virtio_net.c  |  1 +
 include/linux/netdevice.h |  1 +
 include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
 net/core/dev.c            | 23 +++++-----------------
 net/xdp/xsk.c             |  2 +-
 5 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.54.0

