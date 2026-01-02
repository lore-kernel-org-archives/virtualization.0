Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7113148BD
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377156; cv=none; b=Ys7KLgZUrOSDOeL2kSJTmiUubalshcb7DilHzvZcUDQ4S8vWa8jI6q5C8I+zDL4t2J9VzqVQlj7ceDmTtYhKCz/P2bl9ybVTHLdl1rjuUFk/0R4zVYGJaMDZPmIwWgvCaulCIECwXJjGiJquk69tKQ0+Qr4jxdzEMECk3Ad8VQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377156; c=relaxed/simple;
	bh=phyFSkUrMB3Pksaf6iExh+d+KbAxAj4rwZwi5QGD5y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5CNcMUFxn1geJqEc8cbeMmidp/4JFdE+vW0sRsQDQ10bbz+Yf2bMUNOuUiz85w+0W614q7RQ94SrkiXDmnevFDux6uEBkE77PsvlOOrzHmeblK9aPQCsFgmtRre4hfCs0+TbfcwHDkuGXGSe6RSSRKL0WITZdVzdOzRnMVH4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltaA1k6d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltaA1k6d"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso126705535ad.1
        for <virtualization@lists.linux.dev>; Fri, 02 Jan 2026 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767377148; x=1767981948; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IEjIvWEXiVpq+xSctei6hnvY2nWGFZMrfiOy4jnM8k=;
        b=ltaA1k6dwrsae681vE+u2JWB003bYM4ze0ILuAOs1koKvbn13/EXYtur6gUyxBFOGd
         WM06NdAfTdIDKFS6tobFkdVnBFMpMI8QiBQXTybjKksKuxyqmBu0bOxSu2lZbcEHz1L5
         Pv/eJQLYQoe9Uw5uNmAQQ28KOcZ8z5ofDYampm8KYDmlhG4qz3H7vKHZ1cO5qDsVx3+g
         xO0rvERLzuNP251U39BBn/aVDi55TqRav89N9aqrdAkAiD5yU6Wto8G9gtWe89s5VDf7
         /5qm18dMy6Q6DhwhX8YVsHuX6LviIz/56W78E0MsqLiWilCcPHyi6xfBFjQfzv+IV/A5
         V4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767377148; x=1767981948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IEjIvWEXiVpq+xSctei6hnvY2nWGFZMrfiOy4jnM8k=;
        b=Qk0v3v3i7KtA7aUsXFmAySKcQkzRrbmHDhjUJWMQyjpWYa5MwNV/ETa0iyr1lrFrQP
         p4IAYAXbpbo4RZv1Y/wiT+g0eN2zH2VlLqihiY13878eTLUuic6XU/a06wBpGXudJpbm
         aDkxGhMwR6clz7cs2w/vq/V3DIJt3O6+O4rD8C+A6XUUZseJC6VVdbhnIzBRNnoQZrCL
         ZLRNmCQOhcK3bK7eAWiEfB2Jn+be8E4GCQu0O61VrMVwUuOx4WjzazpaJMMCg7tcTYy9
         exqq/GEobq8H635hIO1bNgPL95UKSL95MBnRUIBTPA9TBEYvDmnBjyqvwLvojehPEblK
         UeOA==
X-Forwarded-Encrypted: i=1; AJvYcCVhkWMwhS03+6SvED0E1aj3w3M7RkwqqnAGuBQuGlbF8/k5yk3pTQH1YxFDAEyW4VWOg4FF38ogA+hc6V7emw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywyhbxiqn17WXTsGU/aygE9esALHFceKRBQmcaNI1RraRzCjfvb
	AJMmn92x5gi+NPl9bgJilRS3iyZJ3T5MsXDCvnsHO2FwwpfviJXg2mA4
X-Gm-Gg: AY/fxX5lnwDMfh8GA0brHS6PrkDLYWuA/MIGnlsHnnY0MNo5doMEDhlaNZcEep2+DRd
	fSl3IEqbsxPujoFUT4O3YNIQzIByXvDZZqZ/r/NV33iMm8lTpInTnmvWcWwwEQQ3McIDS6lSGN7
	uImE6A+6n0pBNlTlnzyHFSGK6mQ7ZNFI5JkPXNaCOiH247mejrh5rOSKKAVU+KPrbUR8975LIK7
	llFSlp/e3VVrgFXiPNDyOAJzg//r38hgBZcpS/EBh9ARvQclJhfCSpbjTOq9wFDcAkD5HWQLBQC
	Un1iT/f4jdxsKcftbFv+w5c9k6WWulxl00N4fQ1WvVK1qBjAUAT8vE1YhN3OFHfWxIeAqIXoa5b
	1IPhaGjHL/p6Ag79OXeMVUhtDxA1weYmFEBCUWBj8O4Cs8iNaCg8fSbQvXD7ysyfzshVojJEyBA
	P9b62lhbMBdQup4Bih8twbhdz/PhK8E4cNhjk8orUHIDs7Z7Lpkb45vSCZPdLVhOFHzoU=
X-Google-Smtp-Source: AGHT+IGjBOyVzjSp6FfpPdKVvmhw705V4tllHiS+cveb+fAujtHJ8wxvUD8lPZQFKwc3BpWzbtF73A==
X-Received: by 2002:a17:902:d488:b0:2a0:8f6f:1a12 with SMTP id d9443c01a7336-2a2f222ac10mr369988605ad.17.1767377147961;
        Fri, 02 Jan 2026 10:05:47 -0800 (PST)
Received: from localhost.localdomain ([223.181.108.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77566sm386297585ad.97.2026.01.02.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:05:47 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v7 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Fri,  2 Jan 2026 23:35:28 +0530
Message-ID: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
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
change the semantics of set_rx_mode and add a new ndo write_rx_mode.

The new set_rx_mode will be responsible for customizing the rx_mode
snapshot which will be used by write_rx_mode to update the hardware

In brief, the new flow will look something like:

set_rx_mode():
    ndo_set_rx_mode();
    prepare_rx_mode();

write_rx_mode():
    use_snapshot();
    ndo_write_rx_mode();

write_rx_mode() is called from a work item and doesn't hold the 
netif_addr_lock spin lock during ndo_write_rx_mode() making it sleepable
in that section.

This model should work correctly if the following conditions hold:

1. write_rx_mode should use the rx_mode set by the most recent
    call to prepare_rx_mode() before its execution.

2. If a make_snapshot_ready call happens during execution of write_rx_mode,
    write_rx_mode() should be rescheduled.

3. All calls to modify rx_mode should pass through the prepare_rx_mode +
	schedule write_rx_mode() execution flow. netif_schedule_rx_mode_work()
    has been implemented in core for this purpose.

1 and 2 are implemented in core

Drivers need to ensure 3 using netif_schedule_rx_mode_work()

To use this model, a driver needs to implement the
ndo_write_rx_mode callback, change the set_rx_mode callback
appropriately and replace all calls to modify rx mode with
netif_schedule_rx_mode_work()

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---

In v5, apart from the bug with netif_rx_mode_flush_work, netif_free_rx_mode_ctx() was problematic
because it needed to cancel and wait for the work to complete before freeing memory.

The problem was that the work needed to grab the RTNL lock while the RTNL lock was held as this function
was part of dev_close()

This means we are guaranteed a deadlock in case the work was pending. 

cancelling the work should be done in a context that doesn't hold the RTNL lock. The only existing
function in the teardown path that did this was free_netdev and it isn't ideal to do the cleanup there.

My solution is to introduce a new struct netif_cleanup_work and a new net_device member cleanup_work.
I am not sure if there is a better solution than this.

cleanup_work will be a work item scheduled by dev_close() that will execute the cleanup functions that 
need a RTNL lock free context.

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

I Viswanath (2):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndo_write_rx_mode callback

 drivers/net/virtio_net.c  |  55 +++-----
 include/linux/netdevice.h | 111 +++++++++++++++-
 net/core/dev.c            | 264 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 389 insertions(+), 41 deletions(-)

-- 
2.47.3

