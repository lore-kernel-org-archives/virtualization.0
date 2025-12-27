Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDA1D86DC
	for <virtualization@lists.linux.dev>; Sat, 27 Dec 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857395; cv=none; b=ie5Z/u+ZihF3sbAbS6cxvjBrsZL/udYVPEj2cEydwlSfY4cZCvkGlfn5tMRfNuBCwD6u4XsCFicjSz60gCw6k+x9Ainwza0XzqO9MTpEBHoAj/Z5MaT9O2Rg1x8hyMhR8WdUdwOgicemOkcyq9STsNt3+bpIayjOMLydOxjIOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857395; c=relaxed/simple;
	bh=zya6eudqFNUg2R4LDLSq15ykdX+OhLWmVjCDblpk9UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibTbyuFwz28G69tsA/r5ntW0r7sGpuMfAtDlIjMmTKrI+RLilO7wzfzKCcGBvH+hJuyeD8a/oxyP1N9iXFvAVpeuXHw+6lABOU5pd7qLfyLlg/PhgrmkbyXjHRVbBhS3zY+e8s4fsBqgjenfzL/qTGTL+OFQsVsapbaXYwRdAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irMvDc3x; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irMvDc3x"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c565b888dso8911288a91.0
        for <virtualization@lists.linux.dev>; Sat, 27 Dec 2025 09:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766857391; x=1767462191; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBXOEZOUK7n4tZthXr4hdpVGwQOJx//vwGzsCud0JP4=;
        b=irMvDc3xqjRilMHdldgVa32q+cg90E1PdAHWbdFXPTcq0lzev630Lu3v4cZI//FDRt
         HhPZOzxPPXeOOKKkGU/YAWILrv1duPiORv17vTg6RWZEhfd9jM7om3o4unC3yoicDECU
         FO+DJzVHmdly8QNXho6gn694V5YUfX3CKsqdkOOteOhiI2GiIT+x1L0gm0SGstQEuH3Z
         kcRKi8KXA7EaucKJ5M2fYxj6Q1h/gri0FUkSG08LTSaNJXOz8JdFlsMylk41KELpb6ON
         Gzqp3Omue6795/+yb0hQXUV5QpX+SQnfCaeRMpjBv4P4LiQ6ZGjD7pXtY9VWKLsbiUQQ
         5aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766857391; x=1767462191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBXOEZOUK7n4tZthXr4hdpVGwQOJx//vwGzsCud0JP4=;
        b=BkmwpcrjPEhJs3NNs7i6LEnkwA33EosynOFuKPVCLl5WnAxPR8cA5bRubtbUIgpA24
         Sq9II5ywAJJ97UF5Y+W26QZOpr+REZ7KbjFUDaKdG3u7kPc1sIWyUCjYl6PEZdEzHRrr
         lWmq6Eznssi3SLpwL5lWHCnHooFnWNzhY0PfZ9o+bX+fYEH1zkOGdseJ0Nb/7+aDImlQ
         44a1+aPRTmmEF84e/zIYzUmX7lsrSG8Q8TOTyd+zL1n1APst0Qo+fJT1k4Eqsb5TyNi+
         JFVebZt2yJl7Oj7VqYNBzFdvKosPDo6JDRsJR6603V9b5FHTElacXqrhqkhO1CVwTZbS
         b1xA==
X-Forwarded-Encrypted: i=1; AJvYcCVnc2EEyvP0F5Ut3eozq2BHGXJTb49JQDqRc34fNhNvpJiAOaPTcYKhfTBMWB3KjWUIJrxE4VhBPi2v76gKQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGjKnUee+aw33rDQ0YuKAwir55eb4GfPOCWZPeu1kOcM9LXu6/
	p6+i8ftSIu/KhW2PNft51CkbXf47oejeNV2VGTfahmT+KF7xU7A4rcvO
X-Gm-Gg: AY/fxX7uV5qJsIEdreIPRmaUZyaI1PqsVToXbpWlHX+gAAnnQ6xaAw/xkek9TEKupKk
	8WKK5L18+39vFB8xzsu7X/l4fe3L0SCoTvKMMO6P5lm1tkQIjTKhLwtMzmOBRcYLDF9rQdts1bb
	dWV+8C6RCpHFzVOFqx6O/Bx4sg6dSFtYJ+zxlyVpn+eHFAk3Wkeajb3GqZiyt8Gi8ZlzSt8/bCS
	2k310cMiwMqfXVzV/bYqfCzHb1iP7NqZyhiG+m7pm87xeLME/+IU36NnVykAYA+qyQWvfKjIwai
	3PbAzPnZyPi36xBcVmkLt/nPo6x7TCCeWmaotmTGcMScxxqqAAuiRCnglSWxL/vM6wlI5bE4W6x
	i7Kg254MA1TvMRWC34pEudUsm575X8hKdF/lEN/rKhvoBGti0NRTbDxU+3khUVtGjLaH0wiBNdD
	SAfkCNMWqRBpvLXopV+WgfMKz8MkHA3AuXVSNMNWNcYfFH5qyH4xlTo8dozayEYr/f
X-Google-Smtp-Source: AGHT+IFNmquTnL4mSgvGjHA6RM7ZyAMUrDeb2nPrjWxAHRwCh8hZoqzuRVv9DQyj9Q0boXqZ7FnQ+Q==
X-Received: by 2002:a17:90b:4a44:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-34e921e0556mr25310495a91.27.1766857391299;
        Sat, 27 Dec 2025 09:43:11 -0800 (PST)
Received: from localhost.localdomain ([223.181.117.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223ae29sm23274975a91.16.2025.12.27.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:43:10 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	xuanzhuo@linux.alibaba.com,
	mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v6 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Sat, 27 Dec 2025 23:12:23 +0530
Message-ID: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
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

ndo_set_rx_mode is problematic because it cannot sleep. 

To address this, this series proposes dividing the concept of setting
rx_mode into 2 stages: snapshot and deferred I/O. To achieve this, we
reinterpret set_rx_mode and add create a new ndo write_rx_mode as
explained below:

The new set_rx_mode will be responsible for customizing the rx_mode
snapshot which will be used by write_rx_mode to update the hardware

In brief, the new flow looks something like:

prepare_rx_mode():
    ndo_set_rx_mode();
    prepare_snapshot();

write_rx_mode():
    use_ready_snapshot();
    ndo_write_rx_mode();

write_rx_mode() is called from a work item and doesn't hold the 
netif_addr_lock lock during ndo_write_rx_mode() making it sleepable
in that section.

This model should work correctly if the following conditions hold:

1. write_rx_mode should use the rx_mode set by the most recent
    call to make_snapshot_ready before its execution.

2. If a make_snapshot_ready call happens during execution of write_rx_mode,
    write_rx_mode should be rescheduled.

3. All calls to modify rx_mode should pass through the prepare_rx_mode +
	schedule write_rx_mode execution flow. netif_rx_mode_schedule_work 
    has been implemented in core for this purpose.

1 and 2 are implemented in core

Drivers need to ensure 3 using netif_rx_mode_schedule_work

To use this model, a driver needs to implement the
ndo_write_rx_mode callback, change the set_rx_mode callback
appropriately and replace all calls to modify rx mode with
netif_rx_mode_schedule_work

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---

In v5, apart from the bug with netif_rx_mode_flush_work, this line of code in netif_free_rx_mode_ctx
was problematic:

cancel_work_sync(&dev->rx_mode_ctx->rx_mode_work);

The problem was this function ran as part of dev_close() and hence the RTNL lock is held while it is waiting
for netif_rx_mode_write_active() which needs to grab RTNL lock. 

If the work function was scheduled before a call to dev_close(), we are guaranteed a deadlock. 

The solution to this is cancelling the work in a context that doesn't hold the RTNL lock. The only existing
function in the teardown path that did this was free_netdev and it isn't ideal to do the cleanup there.

My solution was to introduce a new struct netif_deferred_work_cleanup and a new net_device member 
deferred_work_cleanup.

deferred_work_cleanup will be a work item (along with a ptr to dev) scheduled by dev_close() that 
will execute the cleanup functions that require the RTNL lock to not be held

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

I Viswanath (2):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndo_write_rx_mode callback

 drivers/net/virtio_net.c  |  55 +++-----
 include/linux/netdevice.h | 113 +++++++++++++++-
 net/core/dev.c            | 270 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 396 insertions(+), 42 deletions(-)

-- 
2.47.3

