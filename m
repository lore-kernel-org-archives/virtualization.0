Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3636AF5
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170490; cv=none; b=oIvx4oTDEUPzZdCD9Gbux6dT5nS6y/X7vNaxWJLg9vKGaz3Kwn3DbwF0HMX2/dif4RQf9elMBk9jc9fnE4UE/Pw2nhuYN/bGZQLazVD+6gYpwCvP/LYC2o4E6bKQvEXaPtPv+z9YbFzPYWErz9I5YJg7O5BMk7ybw+Lffe6TH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170490; c=relaxed/simple;
	bh=v7SDKoILYnL+Q07ZcGpDsCXHHRJob/yG3/+kL9fGKLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OvXP50FcUhOfbpGWAFQHp6O73wIA4B6ScYSGBReeAJ0C4vMkwfbiWtL8KbAHjVDBNIirXyxYhSJYI0XmA8Jlm+dnLc4U3v7PNjx+viGbCwmZQ2eLpeh9G1tBbRxGhpdKLTgCGF6GPV6t4SauWmr0DDIKcMWW62PtANwef9K8JEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Rjs15EfR; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Rjs15EfR"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a3b9bc797so14371895ab.2
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713170487; x=1713775287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wfjIlgO/QZNkC/nNAH/lmmSlY11ytftqlWP0lFvruo=;
        b=Rjs15EfRXIKvzpEO2uJjCcisRn0ZL+9/CKUQP/ZI20Yke3D+7mD7S44CYeuDWs43Zh
         GavftG5DLl/8KBjvj/kyTZrCYGpsYSnsj/W0jYDPDG9D2Ssq4n4rZEDzYdOgNT9NssqE
         iGXGcmkMJFRd2G7wAKS5Wf+0oBwPnUmMnwmushHBR2pz9LM+b6J9LnrgUkW+y9Bg8lJP
         yBA7MNKVh7nm9TLfY0LquCDjNJQTn9uh/h8XJFRJFAQd1jUfkM/B37ST4tFmHRIuAUWc
         aitVtMagqR/aJVsclkyGgJtdMgg94HE4nmW1tYRIASt1xCW4P2O+aLzjfA96r+CiB2cK
         BEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170487; x=1713775287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wfjIlgO/QZNkC/nNAH/lmmSlY11ytftqlWP0lFvruo=;
        b=HEUV0gfpUYSqVfOjFnpgHuJlx7RZMkMTbQwI4SVzw9BwXzejBN+h0XvKTqhSsBEvQ9
         9ozfHueiSc4DMGZndf7v82U682fWpbNqUVzWRBLkWTROJ3qOCRAQZmGa25VqbhH9kpD/
         Zuv3LsW6G4yOoF5FecvEDaiFHrukgM5wnFP8wBgMWoguVcQ8LIS34g2P1M5n3n7ZzpL7
         wYvgoh8dxnmsEtonFmNUZSwzsarhHQjIj/MyeYOUG4IwUlkVDAvgUQTk903eESA/f6Yd
         4xDxUpX2/71GZ4ypsTugOvNjOmdMfMQUYBqUUd3yZoKPZyYpQtQDjxuqDrE4nJXq24sl
         73uw==
X-Forwarded-Encrypted: i=1; AJvYcCVo51TFUaeX9es7Hud6Num3zGlw0BAl3QJ+YhW9LwV7q1GP9KNHxNZQUSR003vxXAOA918t/Y+YnVjMNUAb+f/QX4KIpUSpVGOV2Mjmdyg=
X-Gm-Message-State: AOJu0YxZwOQxwIqu0/ODzA/FWwQatDeACfAHk4fBJrmVU2nYhfd7ZJfJ
	Z4ma1u6Rp+bUOvTQ3oirmI8KnK/yz0+2GU+f8s2CEXf3N8b4dSiN5R0saO1Nm1U=
X-Google-Smtp-Source: AGHT+IFVVhy+/eBfwZCCc946KkwERHHh+W5/607TDMXjGxAgcPrElcXF4+Vtf1WNq3+wczBthWoaiQ==
X-Received: by 2002:a05:6e02:1e07:b0:36b:85e:7d69 with SMTP id g7-20020a056e021e0700b0036b085e7d69mr13433947ila.10.1713170487436;
        Mon, 15 Apr 2024 01:41:27 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm6575685pgc.21.2024.04.15.01.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:41:27 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [RFC 0/3] Improve memory statistics for virtio balloon
Date: Mon, 15 Apr 2024 16:41:10 +0800
Message-Id: <20240415084113.1203428-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

When the guest runs under critial memory pressure, the guest becomss
too slow, even sshd turns D state(uninterruptible) on memory
allocation. We can't login this VM to do any work on trouble shooting.

Guest kernel log via virtual TTY(on host side) only provides a few
necessary log after OOM. More detail memory statistics are required,
then we can know explicit memory events and estimate the pressure.

I'm going to introduce several VM counters for virtio balloon:
- oom-kill
- alloc-stall
- scan-async
- scan-direct
- reclaim-async
- reclaim-direct

Then we have a metric to analyze the memory performance:
[also describe this metric in patch
 'virtio_balloon: introduce memory scan/reclaim info']

y: counter increases
n: counter does not changes
h: the rate of counter change is high
l: the rate of counter change is low

OOM: VIRTIO_BALLOON_S_OOM_KILL
STALL: VIRTIO_BALLOON_S_ALLOC_STALL
ASCAN: VIRTIO_BALLOON_S_SCAN_ASYNC
DSCAN: VIRTIO_BALLOON_S_SCAN_DIRECT
ARCLM: VIRTIO_BALLOON_S_RECLAIM_ASYNC
DRCLM: VIRTIO_BALLOON_S_RECLAIM_DIRECT

- OOM[y], STALL[*], ASCAN[*], DSCAN[*], ARCLM[*], DRCLM[*]:
  the guest runs under really critial memory pressure

- OOM[n], STALL[h], ASCAN[*], DSCAN[l], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to cgroup, not the global memory
  pressure.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[h]:
  the memory allocation stalls due to global memory pressure. The
  performance gets hurt a lot. A high ratio between DRCLM/DSCAN shows
  quite effective memory reclaiming.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to global memory pressure.
  the ratio between DRCLM/DSCAN gets low, the guest OS is thrashing
  heavily, the serious case leads poor performance and difficult
  trouble shooting. Ex, sshd may block on memory allocation when
  accepting new connections, a user can't login a VM by ssh command.

- OOM[n], STALL[n], ASCAN[h], DSCAN[n], ARCLM[l], DRCLM[n]:
  the low ratio between ARCLM/ASCAN shows that the guest tries to
  reclaim more memory, but it can't. Once more memory is required in
  future, it will struggle to reclaim memory.

zhenwei pi (3):
  virtio_balloon: introduce oom-kill invocations
  virtio_balloon: introduce memory allocation stall counter
  virtio_balloon: introduce memory scan/reclaim info

 drivers/virtio/virtio_balloon.c     | 30 ++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_balloon.h | 16 +++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.34.1

