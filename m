Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8033B6DA
	for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648142; cv=none; b=MqTr4TEOCfApRe50K3j80GXl4EQG0hlSC2CfROEmfpN0ch03RcupXJgXjSNAkncTtENuwyLvZuM1UVBn2lJT71Res/Sp03fCxjAUBwOinDHSytJ4vlp6Y4ufjMgQbaDHS9WqN122osorayvvDfbKfLjYYaJS+xNti3UJqPlCbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648142; c=relaxed/simple;
	bh=URcRCRZc27ATehNsnD5wCfBb0enqn8YbmGPfjxgsNAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NlitLRKmBWGufY0mRHNslHKJNZ7ySX6lfBiOJ4ZA7zoRmP0nTox3VTX7f8OwEV39d8Xua64VTg9JIf04NanulqI6YS7U0DynisfW0O4azagTH8D3y2hYGJFv1ve9C4PCeIhpLC9MxMzkCJbxabEdzHWSZa8YZUeXdYOjH5h/hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuDDILJA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuDDILJA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2955623e6faso11934425ad.1
        for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 06:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763648140; x=1764252940; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1w0vRPTrSQYB1FNs5Alcq6MmQhD4iwCtva78BRmz+fY=;
        b=CuDDILJADbMeGSWLAwi8x0dHgCi87LlTS2AjDHGTdzPJTrU9sblQ2UGgz/5U0Iw4f8
         AQ8DUX4Y85nJCzv1HqO3bpXUgf+LmjPsF/KIQ5YfBsZ4HCPdYS1ylJ/Sjs+vqfYZoQed
         8D1qLwiLx2oMZqiOvDsf0+VQ0zGXgiEfdr3otFTE/cOk2cr6gL63NByP/RHuDW3iFq1c
         I0OmhBG66TTav02wE6YsFqn7gUO78sUOstYti8EMRab+0OQocGg+u0yZFXZfhRoK+6aK
         AVOQS3PED5KPn3WDurKcWeFEI9gbTAZOQ4e6bWMc/Ou7z07te67YTLCp5DX3Mj9A0uZs
         WPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648140; x=1764252940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w0vRPTrSQYB1FNs5Alcq6MmQhD4iwCtva78BRmz+fY=;
        b=G0EgXJ82wmkaE8Lct0f3/SFL0jEca/RoQJyBQz6qTbsXBflntaxP6jwYpSdLdm2zbi
         FC8WbDwv6VCe9KoTBEO0L4bE7dPt2SOQmKDCveEOeyxfn444IsAE/WWnzyLNz2hBGSvS
         k5j/42n0PwutjTmZ0Xt02qbHjimeJGHAc9RCGoNGaBr9qXziQjK4b4hG3y9MzrkJpEHp
         gADhhTBEqACGIJVdVeH8BHF0wuPDIHVOAIiHUUbbyPVzE6hS8eM9TEau7xMQilWsvpEB
         zm41FRvO4eYA5UO9Dl8jfMnfWwCgESnEO7sjTHjzaAbSczKpmvs6Oqq/TvzKkprVcVA7
         GunA==
X-Gm-Message-State: AOJu0YwccIhCa0Tnmm7mfCt0ROl+S4aFZ7Oz/m3hkkbnDehl3OvSXyUl
	xPYqUk8mzyi7YQhJegunEJsm3i7Twe/N7yO0zDeVU3Y3D3W1VT4iTOeX
X-Gm-Gg: ASbGncuXblk4t2SOZxXtNE911A6g2i0FsPkcb4LRVeEqmYnIM9L9pVES8su1tMregIj
	oqCxoeodvoOn3oP3RacgxzOH57eF/4wLnptCwCsWkGWLQ3mlMubiPYkUqjzi8RWLRfYFVw5fwjs
	nBkckPthWO0dxKnniyUqe9Apxj2VET8/1kRfrBXotae9vGI4PUAySCMb6vVpFJRzLY4nCPKhzOe
	0eBIskolr/QqeDi900VAoYBKjoCqc5769HFbFAejlIQadeI6zyhbsuyXa+D/LV/IR/YyJFsG+Zv
	l7k1N+u4P4eXVfTmVPQipARiFbHMKcNkQ0FVEVGx4GBGD5hN0Qh5tDdNVuJRDSg+IyVD+hxpc0o
	sLixGFNTpdRpQWKPYgoiAMQE9kU10C/06kYYIpkk8TbCobtOKjNlcHy/ybwCMjVZS+0yN7HzV4k
	ZzVmqgfjdhyIIF7QEjPF4JZEa4tukZQ1M=
X-Google-Smtp-Source: AGHT+IHNdc6f9RQwfAmaKFzQBgZ1LixjzxJRn7eguePAU93WE2AGCr17VZU7UMlryHgGAufaRcg0Eg==
X-Received: by 2002:a17:903:1b03:b0:295:9627:8cbd with SMTP id d9443c01a7336-29b5b0f760cmr43206965ad.33.1763648140012;
        Thu, 20 Nov 2025 06:15:40 -0800 (PST)
Received: from COB-LTR7HP24-497.. ([223.185.131.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bcbsm28442915ad.29.2025.11.20.06.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:15:39 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	aleksander.lobakin@intel.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v5 0/2] net: Split ndo_set_rx_mode into snapshot
Date: Thu, 20 Nov 2025 19:43:52 +0530
Message-Id: <20251120141354.355059-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
    ready_snapshot();

write_rx_mode():
    commit_and_use_snapshot();
    ndo_write_rx_mode();

write_rx_mode() is called from a work item and doesn't hold the 
netif_addr_lock lock during ndo_write_rx_mode() making it sleepable
in that section.

This model should work correctly if the following conditions hold:

1. write_rx_mode should use the rx_mode set by the most recent
    call to prepare_rx_mode before its execution.

2. If a prepare_rx_mode call happens during execution of write_rx_mode,
    write_rx_mode should be rescheduled.

3. All calls to modify rx_mode should pass through the prepare_rx_mode +
    schedule write_rx_mode execution flow. netif_rx_mode_schedule_work 
    has been implemented in core for this.

1 and 2 are guaranteed because of the properties of work queues

Drivers need to ensure 3

To use this model, a driver needs to implement the
ndo_write_rx_mode callback, change the set_rx_mode callback
appropriately and replace all calls to modify rx mode with
netif_rx_mode_schedule_work

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
Questions I have:

1) Would there ever be a situation in which you will have to wait for I/O 
to complete in a call to set_rx_mode before proceeding further? That is, 
Does netif_rx_mode_schedule_work need the flush argument?

2) Does priv_ptr in netif_rx_mode_config make sense? For virtio_net, I 
can get the vi pointer by doing netdev_priv(dev) and am wondering 
if this would be a common thing

3) From a previous discussion: 
https://lore.kernel.org/netdev/417c677f-268a-4163-b07e-deea8f9b9b40@intel.com/

On Thu, 23 Oct 2025 at 05:16, Jacob Keller  wrote:
> Is there any mechanism to make this guarantee either implemented or at
> least verified by the core? If not that, what about some sort of way to
> lint driver code and make sure its correct?

I am not sure how to automate this but basically we need warnings to be 
generated when the the set_rx_mode implementations are called statically in 
code (From my understanding, usually in the open callback or the timeout function) 
but not when they are called through ops->set_rx_mode. 
Can Coccinelle do something like this?

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

Here’s an enumeration of all the cases I have tested that should be exhaustive:

RX behaviour verification:

1) Dest is UC/MC addr X in UC/MC list:
	no mode: Recv
	allmulti: Recv
	promisc: Recv	

2) Dest is UC addr X not in UC list:
	no_mode: Drop
	allmulti: Drop
	promisc: Recv

3) Dest is MC addr X not in MC list:
	no_mode: Drop
	allmulti: Recv
	promisc: Recv

Packets injected from host using scapy on a TAP device as follows:
sendp(Ether(src=tap0_mac, dst=X) / IP() / UDP() / "test", iface="tap0")

And on the VM side, rx was checked via cat /proc/net/dev

Teardown path:

Relevant as they flush the work item. ens4 is the virtio-net interface.

virtnet_remove:
ip maddr add 01:00:5e:00:03:02 dev ens4; echo 1 > /sys/bus/pci/devices/0000:00:04.0/remove

virtnet_freeze_down:
ip maddr add 01:00:5e:00:03:02 dev ens4; echo mem > /sys/power/state

---

I Viswanath (2):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndo_write_rx_mode callback

 drivers/net/virtio_net.c  |  58 +++++------
 include/linux/netdevice.h | 104 ++++++++++++++++++-
 net/core/dev.c            | 208 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 330 insertions(+), 40 deletions(-)

-- 
2.34.1

