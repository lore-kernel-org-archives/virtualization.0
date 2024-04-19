Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81217F7C3
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524925; cv=none; b=q3NcSZ8N/c39JHz5dxFduYTukntppYZTp1JTJxPIQE7c1gqyrUZ4kG9q71c/YA28/gXbqQb5Kn02x/tqsPyN7MTlJ5/UPC19M1A8BteYqJha+sLgoKoI+J5umh7/rLu66UjqzcXUisTciEdRs6CcREpMnyB0gB78eLVVKmcaAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524925; c=relaxed/simple;
	bh=smqyOBR5ExWRQZS/akMGCa8vQ2leCPNtLysIs/HUbvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umuvdveZCBrsZs3Qam2nm0MoAf/vmCwCvqv51QvxAxy0YfcYPO1/Jpnjf2IYEmBO9xai/vJcrcuyQdU4FDTQTrJ4Axq8a9nZb7wPf0j8SJm+5XQVizPgFewR6d9NabFEY9Mnn50hmN0EmQ2ulG+b2waK/hYdkNViGMu+hb40nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2vO0G6p; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2vO0G6p"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a526a200879so237398066b.1
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713524922; x=1714129722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NnZhMrUZqGRI3vIgYFB4ebY43U9G9SiQu0xqMryWhDA=;
        b=S2vO0G6pBA1nUcsG7jYStmewl4yjIdpvqfc1s5BryO68tw+/qjbJt6CAyKPXn7m4+I
         Xp+m0tL0Y9+WUWDeFj8ep+Drw3DLNYN5lfqRcRVhXYhCG0tiN3vWpGiMC689DAgswjGk
         vPlrz/gcl8zwJSyFibsK2xjhSrDLb8k0tYhBbZKkcPSga22T+XHpW9WGCCVuM/tdzcjC
         1BXVZmxiPag11q+tVPRJdi5wHcNTpOI6qx69VlvANTMWXCClksvX3Ie3rMqE15Ff+1NT
         v9qDYvd8d/qc+2vX7z1VxKu3CPRChM97w8YG+14s4lmRFzbCIXF4bQjgh8o3Hh582Ggy
         wxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713524922; x=1714129722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnZhMrUZqGRI3vIgYFB4ebY43U9G9SiQu0xqMryWhDA=;
        b=bvpFpZfk7vFdl9dD82W3m5AIPKw9PSzsdQeNmcLGyrciAxtR44nF+KsTgNi6kXQoYe
         WzShgsr16zjholQkZDjOt5Jaee14FhQ1qj06pGKtfmptryMiTvmFf+PBJDO5V1yGne1+
         qJx31n3IWMUmNBaORRNT4x4lTxfTVK0GM/9FWCkL2PtUa25NUFwjYh6u9jCANykQ1uMl
         tKqjAaMgaI1RgPWA7RlpgCcgxM54F4n+3WlwMcNH7oJRhrBH+UZNBHqGagrds+LunFST
         MH/HQVAjv1nOTuelwQ+1T5WIXg5yhcmXBLn3uYw/+YBLbcFzHh/3jV8PuU9BvLkTdUWl
         CyvA==
X-Forwarded-Encrypted: i=1; AJvYcCUvd7QvD7kKnF3Obq2ZhTt9piIXWaxL3xOlWzez7sVf5uKmRV7wtdEROoxaJjopyRcwJ6+17g5f4kosCHtCnthTzrvPB24qgQoGCeSIBMs=
X-Gm-Message-State: AOJu0Yydg8AdN4WRyCu52oxwnJFPgPYKlav6j7bdC8QyMUrCOmYW9ZxX
	i6gdFiZdgVF5qf2zrT1xvGZnzQMPgeSXpvYgmkRwNt5Msje/UNuZ
X-Google-Smtp-Source: AGHT+IFFriJFsUnRrRu7HMBSLly/rtS8cinsWTH9ta/+o0dmkBTmaPB9zq5hLrUgZJ2Zq5CyXnzdXQ==
X-Received: by 2002:a17:906:f8c5:b0:a55:5ddd:e5f6 with SMTP id lh5-20020a170906f8c500b00a555ddde5f6mr1225529ejb.28.1713524921685;
        Fri, 19 Apr 2024 04:08:41 -0700 (PDT)
Received: from 127.0.0.1localhost ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm2082525ejp.60.2024.04.19.04.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:08:41 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	asml.silence@gmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>,
	xen-devel@lists.xenproject.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH io_uring-next/net-next v2 0/4] implement io_uring notification (ubuf_info) stacking
Date: Fri, 19 Apr 2024 12:08:38 +0100
Message-ID: <cover.1713369317.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please, don't take directly, conflicts with io_uring.

To have per request buffer notifications each zerocopy io_uring send
request allocates a new ubuf_info. However, as an skb can carry only
one uarg, it may force the stack to create many small skbs hurting
performance in many ways.

The patchset implements notification, i.e. an io_uring's ubuf_info
extension, stacking. It attempts to link ubuf_info's into a list,
allowing to have multiple of them per skb.

liburing/examples/send-zerocopy shows up 6 times performance improvement
for TCP with 4KB bytes per send, and levels it with MSG_ZEROCOPY. Without
the patchset it requires much larger sends to utilise all potential.

bytes  | before | after (Kqps)
1200   | 195    | 1023
4000   | 193    | 1386
8000   | 154    | 1058

The patches are on top of net-next + io_uring-next:

https://github.com/isilence/linux.git iou-sendzc/notif-stacking-v2

First two patches based on net-next:

https://github.com/isilence/linux.git iou-sendzc/notif-stacking-v2-netonly

v2: convert xen-netback to ubuf_info_ops (patch 1)
    drop two separately merged io_uring patches

Pavel Begunkov (4):
  net: extend ubuf_info callback to ops structure
  net: add callback for setting a ubuf_info to skb
  io_uring/notif: simplify io_notif_flush()
  io_uring/notif: implement notification stacking

 drivers/net/tap.c                   |  2 +-
 drivers/net/tun.c                   |  2 +-
 drivers/net/xen-netback/common.h    |  5 +-
 drivers/net/xen-netback/interface.c |  2 +-
 drivers/net/xen-netback/netback.c   | 11 ++--
 drivers/vhost/net.c                 |  8 ++-
 include/linux/skbuff.h              | 21 +++++---
 io_uring/notif.c                    | 83 +++++++++++++++++++++++++----
 io_uring/notif.h                    | 12 ++---
 net/core/skbuff.c                   | 36 ++++++++-----
 10 files changed, 134 insertions(+), 48 deletions(-)

-- 
2.44.0

