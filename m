Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61286378D6D
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241828; cv=none; b=ngoDAmisMVw9Mtrh9BXn2ipwBnS/2LF+P2X/YZVrqI4993dskx7uywouvItXCtfrYXYeOzkC+A6BtQhV87B2gdsFZSJiQE/Sr5vxwgrLT1fBKUP+3ZA1kfcKVzhArxqKZ/mzCl6vvguStCVKneu526045WH/Bt1R8nf2T1th2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241828; c=relaxed/simple;
	bh=afHfmAvZQj+2iviHBO+ZSMwR+6N2HvPs0NvXrGSkTRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYB9r2heCSEBXPsaAvBuxTuclJpbflOOJaiwPq8vc4u9sKYFQby+45xWVFXrvH7HERRTsiyoyOcdxrqaCYWhWzjg3h5PJJIOpwo39NVDiMb5fE3cp7ydEYPrYuYSAZQqpwY0EXrWE3QuuNk2vY+TwriyZq2vyb/3ADLAedYgLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrGMeY8u; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrGMeY8u"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f416c0473so1559360b3a.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241820; x=1768846620; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhpaAlKW26OhYlxc15mNDWFg1nSuNxZpLWCT9AQiLQU=;
        b=BrGMeY8uHA1XSs6d0IcSdYxdpoz08kIGbjc/sQVTwzIec5WxIYTWHVW9fXM6sQSI9j
         dLu+r9ZWn5dhjovpRks7HzKC5h6qMF/dvUDb3sxbFHoQ87JMCQjl16e9sjaJCi2eyESb
         RKVrf1X0+1FP6PV9tLyrfaVs7fvupRvZ78wFOgDawa9uuMd2DCNYl9hFYlZkIQoM/igX
         KI3mBfiUydLIv/9wKI4WuJiM8FBzM1JhLdZwefODpIQQKox2GSKXpEuGscr8VUfR/aIm
         pR1pJpDoEQUGutoUktZSa5yC/YQzOIPQrTHyPvT8L8d43YdjjmzgBbazRqxEyDEdqePR
         nHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241820; x=1768846620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhpaAlKW26OhYlxc15mNDWFg1nSuNxZpLWCT9AQiLQU=;
        b=U+aOtEp+7uL3JSLSiziIEf8kc25CEucRopUKTH0fpzuEYVOtWSYbSOJcjF+edh83bA
         UtOAsV6ujJXFVToM1DxBGsFMr0zchal2Hw4sdU1jT7tfankLsay8m+rex3/W+FfsIcZF
         fhKNeu2OHkmmv5WIwnrzLhWRyj52SP+cQF863KDeN3RFYzwYwHNlRHK8J7ZE28OHy4/z
         QrQJf9oUOd2r1Yq7RAGRHOCRdYMzRCvOU5oAzxlU+iA0WOcv9lGTNLwOHg2XtchbvIQh
         TdxbcG/tmWsEhRcIktKN+0yb4+MlKKhmthnPPgNr+ryuNvnuEbXHW3A5NzU9rUYgDMXy
         vVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCURuhVOhrE+HoHPfATbHH2tE9gFOkYnM7aCPOj+cMBHCt5HMYCpfVzNL72iz61QowAcKl4dRRM760x7caP+SA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoA4VSZ5F6W+ZaT53ylD+z0cYBOUWceTjx31lP4XJ58BePu1GJ
	+IwzXJlFtZE1flrWhDO1vD66Lxl+MzO78MmLN1b9MHoY9Z+rnnD8CrhX
X-Gm-Gg: AY/fxX78HtT7XPnDueggy7KcrOyP9nWVnxON0J1sKJgGQweY9wGddtuNBut4ZROXKNo
	FLCla12k54gMz2GhIPZWOO9Nik00VrrVnhpV+UHBTFKDl4QlvHVkgRmMElqwIVZ+ehCeMYNCnov
	s08mQSC+WmWC0V4Lz82uGqJcWx9NUe4t/j796dJd5ps11jMHl44VO/RaYDhdiiwW9cwdYpFq/qN
	JqiAg28aO2zzrhhX0rFct+SpWGjJioqm5Hhz98obxXCbCVVlEMOKUBOa+WNwrE5vEA21f2e2kpW
	8kllZEgUcqTcUtk7Tr+ph1Z9R00+NjxOmdFvGxgc2GmgZ6A70vChawHJai2y41j1NMsoemn73xo
	kGDbhV43htrnjzdkBEzgWwrNAhYb8mphhpxt5MfyUz2FfqIXm4inXwYbup36FJdgb2unTA4lFZ9
	QfqgfyF6Z9unOAwNTdbpa5Dinh3qPbyCNV//mIEn8/5/as0WEp3r4y1Ah/VXN4S+vJfg==
X-Google-Smtp-Source: AGHT+IHCbvxDzVKglJnQ5DCOnCgrWdajUJ3xC4WJMbnpDbcyewmJC9+3bPGSnBu1mkm93FTZAHDPBA==
X-Received: by 2002:a05:6a21:6da4:b0:375:4426:e78b with SMTP id adf61e73a8af0-3898f9f0e9dmr17726103637.71.1768241819635;
        Mon, 12 Jan 2026 10:16:59 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:16:58 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	intel-wired-lan@lists.osuosl.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v8 0/6] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Mon, 12 Jan 2026 23:46:20 +0530
Message-ID: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
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

This refactor has the secondary benefit of stopping set rx_mode
requests from building up as only the most recent request (before the
work has gotten a chance to run) will be confirmed/executed.

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

I Viswanath (6):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndo_write_rx_mode callback
  e1000: Implement ndo_write_rx_mode callback
  8139cp: Implement ndo_write_rx_mode callback
  vmxnet3: Implement ndo_write_rx_mode callback
  pcnet32: Implement ndo_write_rx_mode callback

 drivers/net/ethernet/amd/pcnet32.c            |  57 +++-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  59 ++--
 drivers/net/ethernet/realtek/8139cp.c         |  33 ++-
 drivers/net/virtio_net.c                      |  61 ++--
 drivers/net/vmxnet3/vmxnet3_drv.c             |  38 ++-
 include/linux/netdevice.h                     | 112 +++++++-
 net/core/dev.c                                | 265 +++++++++++++++++-
 7 files changed, 522 insertions(+), 103 deletions(-)

-- 
2.47.3

