Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E49142633
	for <virtualization@lists.linux.dev>; Fri,  6 Sep 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603641; cv=none; b=DeSx/0TENdBgXVKwrPi3SbotwgZztJEmjOv8cKWl4PdrCE46Hqgg8DFHumuIl3EdR6+/HJ1w/Q0S5Ir3BL6XhqpCB37uEOBVFYdDu4rGfGCAmymg9BQ+eQ4gOnCnqlb2JHh8Y9honH1L9wqtCBZ/MRzxtbaQ1bZsdurcJc9xPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603641; c=relaxed/simple;
	bh=esbjdp65IiF8cWc7BeseZGw+CsXs9C5mBp/cyFMx28w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QD0SrYkuiB2fHyjzmPercJCMNkGp/UoLMQ/BKnEhBVkTyPokoD8QUw/PgKYVw4149ylD/9H/pNQwredkTbVqqSlSpd4NpNbZMtPaYNis5CRQUYTDp4XYxE3NUjgiBZUqTTdJN93Ic1xqM4oqBB99iN4P43cD37DyNJzqry8XQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=CbG+Mp9x; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="CbG+Mp9x"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5356bb55224so1976048e87.0
        for <virtualization@lists.linux.dev>; Thu, 05 Sep 2024 23:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1725603637; x=1726208437; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCCU3z92u1ieIk3rkKyVrthpR5SXw2l0rI+azBmVBL8=;
        b=CbG+Mp9xYXurJCAoJdVBiU/8SyTQKlPv1o5ngO23MDUWdM54Yeagm5q5EOTlqyyz3A
         +5JMBwdBRbAT7RIifsYAlVb7nWuEnhwo3nYPfNzIL8j3eyybwdtqzXzRXUBULbKQRvc0
         UVo5OWqyw0xjQJir/cR/34nfC9KhTBr/QVDjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725603637; x=1726208437;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCCU3z92u1ieIk3rkKyVrthpR5SXw2l0rI+azBmVBL8=;
        b=bgM8UDxDVYT7V5MKDoQb753cKiiQGQkOCh/pOaawT3chBh0BhMW3EXvzn6oczrjK1u
         1vxuenZWgIx/Ov79PuBImj8oiweTFEM7YlsZLBKVICvyop4rSZFpAE8IsbgmQbLEfbVP
         /mY71cPucvRJzhscCTTxL7gcnkFr9IrDqnq5RhYQjqQPY+BsT/F74r6nyYtUnyMENr1b
         WbqRcafEJmPLvHJI+0no406qGbWv/ilIQFicSSv6yHjH5e5VGN/UWrWCJdc13sjUPw7m
         rHrEJOPpYPzaoZmhiLN2pv0AC1Fh0h8TWW/b7+GNCkUHbPzwuNBrAgakDkFjb1theU7z
         9+ng==
X-Gm-Message-State: AOJu0Yx0z3FIiJ0yxyTnFjjNNXtwFxJcdOHlne9r99Dg7rTt5gxKyOoe
	ShgvdkTqes7iOcxGUyP7JccqKpu0qZmr3zNGj1oudQYTkhDi6knBg5CA28EM7hWvHKjGC5roGzr
	MwTEUX7JePEJ1o5cxdWe8fcZayVEhibdg86jkQSdRBULpoqCp2w==
X-Google-Smtp-Source: AGHT+IFrP7hGRcnTnaEqJLZZk+xhBIKdkMxJDN09ztOKUxYCFiKvXmqn8b9PnXzR0l9/YrxUdhBiYa3iQUsHcsnLBCw=
X-Received: by 2002:a05:6512:3983:b0:536:53fc:e8fc with SMTP id
 2adb3069b0e04-536587ac031mr780529e87.16.1725603636791; Thu, 05 Sep 2024
 23:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Fri, 6 Sep 2024 08:20:10 +0200
Message-ID: <CAK8fFZ6qVutPWxquHg7NEvFqYqDP5BwEdO81hqW8iMFxJFuLSQ@mail.gmail.com>
Subject: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net] with 6.10.7 and packed virtqueues
To: virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

My virtual machine crashed with the message
"0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]". See the full log
below.

I did two changes:
* Updated my VM packages (kernel from 6.9.5 to 6.10.7) on the VM
* enabled "packed virtqueues" by libvirt on host
and it happens after a few hours of uptime.

Any hint how to prevent it or fix this issue?

[52890.265362] BUG: unable to handle page fault for address: ffff9b94c480000c
[52890.266264] #PF: supervisor write access in kernel mode
[52890.266814] #PF: error_code(0x000b) - reserved bit violation
[52890.267299] PGD 4c3c01067 P4D 4c3c01067 PUD 103be6063 PMD 7849cc063
PTE 7a1dd28f4e77cee7
[52890.267926] Oops: Oops: 000b [#1] PREEMPT SMP NOPTI
[52890.268372] CPU: 14 PID: 0 Comm: swapper/14 Tainted: G            E
     6.10.7-1.gdc.el9.x86_64 #1
[52890.269007] Hardware name: RDO OpenStack Compute/RHEL, BIOS
edk2-20240524-1.el9 05/24/2024
[52890.269853] RIP: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
[52890.270349] Code: e7 e8 85 ef ff ff 49 c7 84 24 80 05 00 00 00 00
00 00 41 0f b7 84 24 ac 02 00 00 48 8d 73 10 45 31 c0 b9 02 00 00 00
8d 50 f0 <66> 89 53 0c 49 8b 3c 24 0f b7 d2 e8 f1 04 9d cb 49 8b 3c 24
48 89
[52890.272173] RSP: 0018:ffffb5dac64f0d60 EFLAGS: 00010246
[52890.272637] RAX: 0000000000001000 RBX: ffff9b94c4800000 RCX: 0000000000000002
[52890.273209] RDX: 0000000000000ff0 RSI: ffff9b94c4800010 RDI: ffffe06380000000
[52890.273772] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffe0639e120008
[52890.274341] R10: 0000000000000000 R11: 00000000000096d0 R12: ffff9b8ebe621800
[52890.274898] R13: ffff9b8ebe621800 R14: 0000000000001000 R15: 0000000000000000
[52890.275476] FS:  0000000000000000(0000) GS:ffff9b9ba3d00000(0000)
knlGS:0000000000000000
[52890.276087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[52890.276592] CR2: ffff9b94c480000c CR3: 00000004c3b1c006 CR4: 0000000000770ef0
[52890.277167] PKRU: 55555554
[52890.277524] Call Trace:
[52890.277869]  <IRQ>
[52890.278198]  ? __die+0x20/0x70
[52890.278580]  ? page_fault_oops+0x75/0x170
[52890.279009]  ? exc_page_fault+0xbe/0x160
[52890.279441]  ? asm_exc_page_fault+0x22/0x30
[52890.279881]  ? virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
[52890.280377]  try_fill_recv+0x22c/0x440 [virtio_net]
[52890.280848]  virtnet_receive+0x1ce/0x230 [virtio_net]
[52890.281334]  virtnet_poll+0x179/0x3a0 [virtio_net]
[52890.281804]  __napi_poll+0x29/0x1b0
[52890.282222]  net_rx_action+0x2b5/0x390
[52890.282641]  ? _raw_spin_unlock_irqrestore+0xa/0x30
[52890.283118]  handle_softirqs+0xd3/0x2b0
[52890.283550]  __irq_exit_rcu+0x9b/0xc0
[52890.283970]  common_interrupt+0x7f/0xa0
[52890.284409]  </IRQ>
[52890.284749]  <TASK>
[52890.285084]  asm_common_interrupt+0x22/0x40
[52890.285526] RIP: 0010:default_idle+0xb/0x20
[52890.285953] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d c3 92 30
00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 90
[52890.287332] RSP: 0018:ffffb5dac436fec0 EFLAGS: 00000206
[52890.287814] RAX: 000000000000000e RBX: ffff9b94c320ce00 RCX: 0000000103227730
[52890.288395] RDX: 000000000000000e RSI: 0000000000000082 RDI: 000000002f3198a4
[52890.288962] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[52890.289533] R10: 00000000000002cd R11: 0000000000000000 R12: 0000000000000000
[52890.290092] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[52890.290657]  default_idle_call+0x2c/0xf0
[52890.291053]  cpuidle_idle_call+0x109/0x120
[52890.291464]  do_idle+0x76/0xb0
[52890.291813]  cpu_startup_entry+0x25/0x30
[52890.292269]  start_secondary+0x113/0x130
[52890.292812]  common_startup_64+0x13e/0x141
[52890.293279]  </TASK>
[52890.293615] Modules linked in: mptcp_diag(E) xsk_diag(E)
raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) tcp_diag(E)
udp_diag(E) inet_diag(E) nf_conntrack(E) nf_defrag_ipv6(E)
nf_defrag_ipv4(E) binfmt_misc(E) zram(E) tls(E) isofs(E) vfat(E)
fat(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E)
i2c_i801(E) virtio_net(E) net_failover(E) failover(E) virtio_gpu(E)
i2c_smbus(E) dimlib(E) virtio_balloon(E) virtio_dma_buf(E) fuse(E)
ext4(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E)
crct10dif_pclmul(E) libahci(E) crc32_pclmul(E) polyval_clmulni(E)
polyval_generic(E) libata(E) ghash_clmulni_intel(E) sha512_ssse3(E)
virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E)
dm_region_hash(E) dm_log(E) dm_mod(E)
[52890.293657] Unloaded tainted modules: edac_mce_amd(E):1
amd_atl(E):2 padlock_aes(E):3
[52890.299716] CR2: ffff9b94c480000c
[52890.300092] ---[ end trace 0000000000000000 ]---
[52890.300101] Oops: general protection fault, probably for
non-canonical address 0x86304c8ed4b709b3: 0000 [#2] PREEMPT SMP NOPTI
[52890.300336] RIP: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
[52890.301177] CPU: 10 PID: 51 Comm: ksoftirqd/10 Tainted: G      D
 E      6.10.7-1.gdc.el9.x86_64 #1
[52890.301472] Code: e7 e8 85 ef ff ff 49 c7 84 24 80 05 00 00 00 00
00 00 41 0f b7 84 24 ac 02 00 00 48 8d 73 10 45 31 c0 b9 02 00 00 00
8d 50 f0 <66> 89 53 0c 49 8b 3c 24 0f b7 d2 e8 f1 04 9d cb 49 8b 3c 24
48 89
[52890.302137] Hardware name: RDO OpenStack Compute/RHEL, BIOS
edk2-20240524-1.el9 05/24/2024
[52890.303074] RSP: 0018:ffffb5dac64f0d60 EFLAGS: 00010246
[52890.303689] RIP: 0010:put_cpu_partial+0x15/0x70
[52890.303895]
[52890.304291] Code: 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 0f 1f 44 00 00 9c 59 fa 48 8b 07 65 4c 8b 40 18 4d 85
c0 74 54 <41> 8b 40 18 85 d2 75 22 83 c0 01 89 46 18 4c 89 46 10 48 8b
07 65
[52890.304556] RAX: 0000000000001000 RBX: ffff9b94c4800000 RCX: 0000000000000002
[52890.304680] RSP: 0018:ffffb5dac6473d48 EFLAGS: 00010082
[52890.305597] RDX: 0000000000000ff0 RSI: ffff9b94c4800010 RDI: ffffe06380000000
[52890.306115]
[52890.306384] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffe0639e120008
[52890.306910] RAX: 00003a3f1c003ff0 RBX: ffff9b99322a16d0 RCX: 0000000000000246
[52890.307010] R10: 0000000000000000 R11: 00000000000096d0 R12: ffff9b8ebe621800
[52890.307574] RDX: 0000000000000001 RSI: ffffe063afc8a800 RDI: ffff9b94cc48fc00
[52890.307927] R13: ffff9b8ebe621800 R14: 0000000000001000 R15: 0000000000000000
[52890.308450] RBP: ffffb5dac6473da0 R08: 86304c8ed4b7099b R09: 00000000001c001b
[52890.309006] FS:  0000000000000000(0000) GS:ffff9b9ba3d00000(0000)
knlGS:0000000000000000
[52890.309543] R10: 0000000000040000 R11: 0000000000000001 R12: ffffe063afc8a840
[52890.310127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[52890.310722] R13: ffffe063afc8a800 R14: ffff9b94cc48fc00 R15: ffff9b9ba3b36100
[52890.311314] CR2: ffff9b94c480000c CR3: 00000004c3b1c006 CR4: 0000000000770ef0
[52890.311735] FS:  0000000000000000(0000) GS:ffff9b9ba3b00000(0000)
knlGS:0000000000000000
[52890.312333] PKRU: 55555554
[52890.312850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[52890.313298] Kernel panic - not syncing: Fatal exception in interrupt
[52891.350776] Shutting down cpus with NMI
[52891.358926] Kernel Offset: 0xae00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[52891.359713] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

Best,
Jaroslav Pulchart
