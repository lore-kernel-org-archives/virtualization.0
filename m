Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3C1FC0FC
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512922; cv=none; b=DjA94eRW6W47DPrUhbfkoYNE9Yzsfvo9P0rmMiLWkFX3q5Rc4YjJrLoUmJI0Y/Rq0uk1MRxr6IpRVrR5WDNwtI219nclKjQ/O9k2T7frXoiZt+9vW4/IirXO9YnWZoV1R3Hb+dIekMHH2p+DF6swdbZinQ3jMogm4bI6yqVotwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512922; c=relaxed/simple;
	bh=6Dg4ltixbmi+/T9C42BHujX2QGGlZeoJZtMbEA7S5y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbOXAMYS0XGkRY0eoEWVAK242g50C/+keO/xZsDWZ7c3WC+y28Huw2uMWTD31M/wAM27y6AxjwyUiMNxfFZf+KAwt5O3rmd70PxTGr5dxFVNcU2zxmA7BfcNKT3Moj2E5m/xsfqIR+fdFKUV0Kfg9zL6EGfjYnUKqynJtT5EocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crAo+aec; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crAo+aec"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae82df847bso25520135ad.2
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512919; x=1774117719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzRfjfQpWVZCvzWQMidKmnmIxujMBJECx4zb/GyFV+8=;
        b=crAo+aecV0OQezw13Ns8+rg7MDU+WvmoBf2nzFcHEQfDBKu7ho9pv344BdACs/fF3f
         RZz0VKnKM23KMmVtpUzfndKbFdtKrxZoy2hNJVYRL4o9lTn05qu3qaSqyk4ycmP1vJZG
         /c/ZuGmhojGFwvwWYzWSwpJ4Hg5UZLfQpHFiM//vIqNVHdienfDA3Jj78U0ef+du9+Of
         5pXaV6eX1jF+oPd8wBSjPQnROgfKvhjsaDoMvsIr7bTfk2qZhmBYJp8QeK3z41JfRvDq
         9VJ4Kr4y/eWsioos4W9E4nWe3nkV0ukTROq2rBmn2m1udil9+3jTqu/WELyEXiGFYD2p
         gnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512919; x=1774117719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzRfjfQpWVZCvzWQMidKmnmIxujMBJECx4zb/GyFV+8=;
        b=JZdjGIs3sJmBLfXXG9bYTyskpdF2XOH7g+5cO3oVsp9w5pADOzz/AZ0o9PAwbTeQ/M
         ecUXgOEO0k9kWMx0ZEZRp6uZQo4D4d4IgQsq56PP1RRK9I9tiQj3DUKjcwMB+iBOVj7S
         o/7Nrpm0v8L7tzMhtCIxOv/a3cj+m6VE2w3/Zr82tLyPJBpWElkGoK0ZrjPMsjEY08M1
         /5aPSkLYRheCzoKjYgSyK9HFzst7aHwLI7V+jbXmROIRHEktWo7I/lLBoCO3PWaISM/D
         nqeqoerNkeHP0Kgu7qL+1CxyVDEQlcckurRAcy6berGTPUg8VyQxug1S58sT1t1u+0yh
         ddZg==
X-Forwarded-Encrypted: i=1; AJvYcCUdjpBVzo3qtexpNCd3tVuKOhvgQSQfywtVsSEzTlnG+WgwGczGKeMLcpXzVnH0xOPE6OGQpDOJXqxoUNE0pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE/Ci7f8LFNysl7CXsiMCRmCeJXYCdUjzKrOsZ9uGovM/1EgIc
	8HGL6oEXP1feNm+edS5RF9LPRnvz2gim5uK6ArGrNouj6pJDXHi7PxgJ
X-Gm-Gg: ATEYQzy1x4ETg5ZMqJqnHzV3Kf51XL1CPtlahtaHWNR6riqox+cUbKhGhorfrwD8WKb
	7iFanKD+v20qdHXKHpjOndK6X89U1oLPCTDuPNfJeN0cbCJOUKADfmosx7V+q0J/kVnYm84CkfB
	on//CQOyhFV5TyknAk8cE/Nbq/Dtr5VE88ThztTnd5Qim3giT5fHztx8JRnFR0Ouit70x6vqIMM
	N3yP+Ldkd5YK858c1HEhAe8ugzEj4wwzPfVU4W3lXiMDtDG4SIq54isJUkLWdfYIOwYkUXVcbdQ
	mZqKr6fYII+fDtNlGPWUgjftt1hELRVmicNjdSCt9w9R1gJKToLdP5y7gmK8u61W3RQzupCXCaV
	rUQozTyzgFc7y0P5i8ArPoWjx5bD6T+lWQ1PXFVu0sNxoq7GH13k7fwxtaSgUXjwauIdh9Xc/ab
	yuoY+Lx/bbCT/VXvZRZADU/cAVDR8miXAk2pWze0TVTf/MM8joEdpyKa6+JyovEBcbEZczrThba
	1S9Mw==
X-Received: by 2002:a17:902:ef03:b0:2ae:a429:fc42 with SMTP id d9443c01a7336-2aecac51329mr74086885ad.40.1773512919100;
        Sat, 14 Mar 2026 11:28:39 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:28:38 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: stfomichev@gmail.com,
	horms@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	mst@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v9 0/7] Introduce async callback ndo_set_rx_mode_async
Date: Sat, 14 Mar 2026 23:58:02 +0530
Message-ID: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

The set_rx_mode callback is invoked under the addr_lock spinlock which
makes it illegal to sleep. This means set_rx_mode is prone to
sleep-in-atomic bugs as drivers have a tendency to do the I/O directly
in the callback.

This problem can be avoided if set_rx_mode were done in 2 stages: snapshot
and commit. A handful of drivers implement this idea by implementing the
rx_mode setting as work and scheduling it in the set_rx_mode callback.
This series moves that work to net/core by introducing a new async
netdev op set_rx_mode_async.

In the process of doing this, I encountered problems described in the
the first patch of the series. In brief, the patch introduces a state
variable to keep track of the current netdev state. This should be
useful for async netdev ops in general as nothing about these problems
was specific to set_rx_mode_async.

The rx_mode refactor has the secondary benefit of preventing RX mode
update requests from building up as only the most recent request
(before the work has run) will be committed.

In brief, the new RX mode update flow will look something like:

set_rx_mode():
    ndo_set_rx_mode();
    prepare_snapshot();

set_rx_mode_async():
    fetch_snapshot();
    ndo_set_rx_mode_async();

ndo_set_rx_mode_async() is called from a work item and the handler
doesn't hold the netif_addr_lock spin lock during its execution
making execution sleepable in that part.

This model should work correctly if the following conditions hold:

1. ndo_set_rx_mode_async should use the rx_mode set by the most recent
   call to prepare_rx_mode() before its execution.

2. If a prepare_snapshot() call happens during execution of the work,
   the work should be rescheduled.

3. All calls to modify rx_mode should pass through a new helper
   netif_set_rx_mode (which requires the instance lock or RTNL if the
   driver doesn't use it).

1 is guaranteed by the implementation and 2 by workqueue properties.

Drivers need to ensure 3.

---

v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
Link: https://lore.kernel.org/netdev/20251026175445.1519537-1-viswanathiyyappan@gmail.com/

v3:
- Added RFT tag
- Corrected mangled patch
Link: https://lore.kernel.org/netdev/20251028174222.1739954-1-viswanathiyyappan@gmail.com/

v4:
- Completely reworked the snapshot mechanism as per v3 comments
- Implemented the callback for virtio-net instead of 8139cp driver
- Removed RFC tag
Link: https://lore.kernel.org/netdev/20251118164333.24842-1-viswanathiyyappan@gmail.com/

v5:
- Fix broken code and titles
- Remove RFT tag
Link: https://lore.kernel.org/netdev/20251120141354.355059-1-viswanathiyyappan@gmail.com/

v6:
- Added struct netif_deferred_work_cleanup and members needs_deferred_cleanup and deferred_work_cleanup in net_device
- Moved out ctrl bits from netif_rx_mode_config to netif_rx_mode_work_ctx
Link: https://lore.kernel.org/netdev/20251227174225.699975-1-viswanathiyyappan@gmail.com/

v7:
- Improved function, enum and struct names
Link: https://lore.kernel.org/netdev/20260102180530.1559514-1-viswanathiyyappan@gmail.com/

v8:
- Implemented the callback for drivers e1000, 8139cp, vmxnet3 and pcnet32
- Moved the rx_mode config set calls (for prom and allmulti) in prepare_rx_mode to the ndo_set_rx_mode callback for consistency
- Improved commit messages
Link: https://lore.kernel.org/netdev/20260112181626.20117-1-viswanathiyyappan@gmail.com/

v9:
- Removed cleanup_work and simplified resource cleanup
- Added netif_async_ctx (which includes netdev state tracking) for async ndo handling in general
- Converted netif_schedule_mode_work to a synchronous function netif_set_rx_mode
- Renamed *_write_rx_mode functions to *_set_rx_mode_async

I Viswanath (7):
  net: core: Add state tracking for async netdev ops
  net: core: Introduce callback ndo_set_rx_mode_async
  virtio-net: Implement ndo_set_rx_mode_async callback
  e1000: Implement ndo_set_rx_mode_async callback
  8139cp: Implement ndo_set_rx_mode_async callback
  vmxnet3: Implement ndo_set_rx_mode_async callback
  pcnet32: Implement ndo_set_rx_mode_async callback

 drivers/net/ethernet/amd/pcnet32.c            |  65 +++-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  77 +++-
 drivers/net/ethernet/realtek/8139cp.c         |  49 ++-
 drivers/net/virtio_net.c                      |  85 ++---
 drivers/net/vmxnet3/vmxnet3_drv.c             |  46 ++-
 include/linux/netdevice.h                     | 123 ++++++-
 include/net/netdev_lock.h                     |   8 +
 net/core/dev.c                                | 335 +++++++++++++++++-
 8 files changed, 663 insertions(+), 125 deletions(-)

-- 
2.47.3

