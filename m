Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E699185925;
	Fri, 13 Sep 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217044; cv=none; b=pzs8ZX05qd9dBINgDGHMPBhvEAx9vAirTlr7Z8j0YUoutRTTz+1t8fnuzPenyqJzI1XoWSUjYp0JtAlqeuWyiTYJIVaFeJAQ4EPX55LJTZZrjB1DueAfVVK6iMh5tfvVvIDjeIY5CJhm1l2sPMAELaQLSvigOY5kCDQk8HjKHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217044; c=relaxed/simple;
	bh=PfiCRg/l631phrsQIiLFBYqLjdTp9IhmvDJNNYpl9Ic=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=g/IE9qiX5M/oS6cZLtLn9qvknX1ZzpLMFhpdvs19QHPX3Ug2WalwyfOExv8srp6v+awx6oo+xEdbKAZu7yoEHEhBpjlRUKm5022Q3wIShBIIA/7L1FpugHYOy0tetVwv8vux1Cj9aKwMKRXVud6eD35KSLIB9J0hXL/D2IqjBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=otovcHNM; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="otovcHNM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726217033; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=IQGMEuLjEu6xADavjYeMrvjiMf2IkogI6wCwqH1ddWI=;
	b=otovcHNMSry6NX+bHBYgD/HgtzbjFYW+9Erj9pYzYS6JkL6bJ3ArDrevTAE59f8kt5vhja3CaTmRcs+3auzPGjCB84S26BMQkFmUoYy3tXZej3iqIvjLV8VbCmaQiEJfu9A3BV/C7ofAXqtLteX/tSH+TRqpBIQwOnap0kZtL+k=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEuBMJb_1726217031)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 16:43:52 +0800
Message-ID: <1726216954.7439098-1-xuanzhuo@linux.alibaba.com>
Subject: Re: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net] with 6.10.7 and packed virtqueues
Date: Fri, 13 Sep 2024 16:42:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <CAK8fFZ6qVutPWxquHg7NEvFqYqDP5BwEdO81hqW8iMFxJFuLSQ@mail.gmail.com>
 <CAK8fFZ5N7EbU=uLbfyeSkQ273NSm+GELWUu1O1OBCpaSwjv6FA@mail.gmail.com>
 <422f35b3-7834-4df7-bcea-e3be12707aef@leemhuis.info>
In-Reply-To: <422f35b3-7834-4df7-bcea-e3be12707aef@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 13 Sep 2024 10:26:57 +0200, "Linux regression tracking (Thorsten Le=
emhuis)" <regressions@leemhuis.info> wrote:
> [CCing a few people that know more about this stuff than I do]
>
> On 13.09.24 09:50, Jaroslav Pulchart wrote:
> >
> > actually I'm getting random memory corruption related crashes after
> > updating to 6.10.y. My expectation is that it relates to this issue:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219154
> > It looks like it is almost 1 month ago
>
> A lot of developer ignore bugzilla.
>
> > already from the last comment
> > there, However the patches fixing the regression are not reverted from
> > the 6.10.y tree which surprises me.
> >
> > I will try to revert them from our builds and see if it helps to avoid
> > random daily happening crashes.
>
> Not my area of expertise, but to me it sounds like the problem will be
> resolved my "Revert "virtio_net: rx enable premapped mode by default"":
> https://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba=
.com/


YES. That is merged into net.

Thanks


>
> That set just landed in mainline. It's likely to be backported to 6.10.y
> within a week or two, but it's not ensured due to the lack of a stable
> tag. So you might keep an eye on it.
>
> Ciao, Thorsten
>
> > p=C3=A1 6. 9. 2024 v 8:20 odes=C3=ADlatel Jaroslav Pulchart
> > <jaroslav.pulchart@gooddata.com> napsal:
> >>
> >> Hello,
> >>
> >> My virtual machine crashed with the message
> >> "0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]". See the full log
> >> below.
> >>
> >> I did two changes:
> >> * Updated my VM packages (kernel from 6.9.5 to 6.10.7) on the VM
> >> * enabled "packed virtqueues" by libvirt on host
> >> and it happens after a few hours of uptime.
> >>
> >> Any hint how to prevent it or fix this issue?
> >>
> >> [52890.265362] BUG: unable to handle page fault for address: ffff9b94c=
480000c
> >> [52890.266264] #PF: supervisor write access in kernel mode
> >> [52890.266814] #PF: error_code(0x000b) - reserved bit violation
> >> [52890.267299] PGD 4c3c01067 P4D 4c3c01067 PUD 103be6063 PMD 7849cc063
> >> PTE 7a1dd28f4e77cee7
> >> [52890.267926] Oops: Oops: 000b [#1] PREEMPT SMP NOPTI
> >> [52890.268372] CPU: 14 PID: 0 Comm: swapper/14 Tainted: G            E
> >>      6.10.7-1.gdc.el9.x86_64 #1
> >> [52890.269007] Hardware name: RDO OpenStack Compute/RHEL, BIOS
> >> edk2-20240524-1.el9 05/24/2024
> >> [52890.269853] RIP: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
> >> [52890.270349] Code: e7 e8 85 ef ff ff 49 c7 84 24 80 05 00 00 00 00
> >> 00 00 41 0f b7 84 24 ac 02 00 00 48 8d 73 10 45 31 c0 b9 02 00 00 00
> >> 8d 50 f0 <66> 89 53 0c 49 8b 3c 24 0f b7 d2 e8 f1 04 9d cb 49 8b 3c 24
> >> 48 89
> >> [52890.272173] RSP: 0018:ffffb5dac64f0d60 EFLAGS: 00010246
> >> [52890.272637] RAX: 0000000000001000 RBX: ffff9b94c4800000 RCX: 000000=
0000000002
> >> [52890.273209] RDX: 0000000000000ff0 RSI: ffff9b94c4800010 RDI: ffffe0=
6380000000
> >> [52890.273772] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffe0=
639e120008
> >> [52890.274341] R10: 0000000000000000 R11: 00000000000096d0 R12: ffff9b=
8ebe621800
> >> [52890.274898] R13: ffff9b8ebe621800 R14: 0000000000001000 R15: 000000=
0000000000
> >> [52890.275476] FS:  0000000000000000(0000) GS:ffff9b9ba3d00000(0000)
> >> knlGS:0000000000000000
> >> [52890.276087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [52890.276592] CR2: ffff9b94c480000c CR3: 00000004c3b1c006 CR4: 000000=
0000770ef0
> >> [52890.277167] PKRU: 55555554
> >> [52890.277524] Call Trace:
> >> [52890.277869]  <IRQ>
> >> [52890.278198]  ? __die+0x20/0x70
> >> [52890.278580]  ? page_fault_oops+0x75/0x170
> >> [52890.279009]  ? exc_page_fault+0xbe/0x160
> >> [52890.279441]  ? asm_exc_page_fault+0x22/0x30
> >> [52890.279881]  ? virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
> >> [52890.280377]  try_fill_recv+0x22c/0x440 [virtio_net]
> >> [52890.280848]  virtnet_receive+0x1ce/0x230 [virtio_net]
> >> [52890.281334]  virtnet_poll+0x179/0x3a0 [virtio_net]
> >> [52890.281804]  __napi_poll+0x29/0x1b0
> >> [52890.282222]  net_rx_action+0x2b5/0x390
> >> [52890.282641]  ? _raw_spin_unlock_irqrestore+0xa/0x30
> >> [52890.283118]  handle_softirqs+0xd3/0x2b0
> >> [52890.283550]  __irq_exit_rcu+0x9b/0xc0
> >> [52890.283970]  common_interrupt+0x7f/0xa0
> >> [52890.284409]  </IRQ>
> >> [52890.284749]  <TASK>
> >> [52890.285084]  asm_common_interrupt+0x22/0x40
> >> [52890.285526] RIP: 0010:default_idle+0xb/0x20
> >> [52890.285953] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90
> >> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d c3 92 30
> >> 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> >> 00 90
> >> [52890.287332] RSP: 0018:ffffb5dac436fec0 EFLAGS: 00000206
> >> [52890.287814] RAX: 000000000000000e RBX: ffff9b94c320ce00 RCX: 000000=
0103227730
> >> [52890.288395] RDX: 000000000000000e RSI: 0000000000000082 RDI: 000000=
002f3198a4
> >> [52890.288962] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000=
0000000001
> >> [52890.289533] R10: 00000000000002cd R11: 0000000000000000 R12: 000000=
0000000000
> >> [52890.290092] R13: 0000000000000000 R14: 0000000000000000 R15: 000000=
0000000000
> >> [52890.290657]  default_idle_call+0x2c/0xf0
> >> [52890.291053]  cpuidle_idle_call+0x109/0x120
> >> [52890.291464]  do_idle+0x76/0xb0
> >> [52890.291813]  cpu_startup_entry+0x25/0x30
> >> [52890.292269]  start_secondary+0x113/0x130
> >> [52890.292812]  common_startup_64+0x13e/0x141
> >> [52890.293279]  </TASK>
> >> [52890.293615] Modules linked in: mptcp_diag(E) xsk_diag(E)
> >> raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) tcp_diag(E)
> >> udp_diag(E) inet_diag(E) nf_conntrack(E) nf_defrag_ipv6(E)
> >> nf_defrag_ipv4(E) binfmt_misc(E) zram(E) tls(E) isofs(E) vfat(E)
> >> fat(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E)
> >> i2c_i801(E) virtio_net(E) net_failover(E) failover(E) virtio_gpu(E)
> >> i2c_smbus(E) dimlib(E) virtio_balloon(E) virtio_dma_buf(E) fuse(E)
> >> ext4(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E)
> >> crct10dif_pclmul(E) libahci(E) crc32_pclmul(E) polyval_clmulni(E)
> >> polyval_generic(E) libata(E) ghash_clmulni_intel(E) sha512_ssse3(E)
> >> virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
> >> raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E)
> >> dm_region_hash(E) dm_log(E) dm_mod(E)
> >> [52890.293657] Unloaded tainted modules: edac_mce_amd(E):1
> >> amd_atl(E):2 padlock_aes(E):3
> >> [52890.299716] CR2: ffff9b94c480000c
> >> [52890.300092] ---[ end trace 0000000000000000 ]---
> >> [52890.300101] Oops: general protection fault, probably for
> >> non-canonical address 0x86304c8ed4b709b3: 0000 [#2] PREEMPT SMP NOPTI
> >> [52890.300336] RIP: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
> >> [52890.301177] CPU: 10 PID: 51 Comm: ksoftirqd/10 Tainted: G      D
> >>  E      6.10.7-1.gdc.el9.x86_64 #1
> >> [52890.301472] Code: e7 e8 85 ef ff ff 49 c7 84 24 80 05 00 00 00 00
> >> 00 00 41 0f b7 84 24 ac 02 00 00 48 8d 73 10 45 31 c0 b9 02 00 00 00
> >> 8d 50 f0 <66> 89 53 0c 49 8b 3c 24 0f b7 d2 e8 f1 04 9d cb 49 8b 3c 24
> >> 48 89
> >> [52890.302137] Hardware name: RDO OpenStack Compute/RHEL, BIOS
> >> edk2-20240524-1.el9 05/24/2024
> >> [52890.303074] RSP: 0018:ffffb5dac64f0d60 EFLAGS: 00010246
> >> [52890.303689] RIP: 0010:put_cpu_partial+0x15/0x70
> >> [52890.303895]
> >> [52890.304291] Code: 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90
> >> 90 90 90 90 90 0f 1f 44 00 00 9c 59 fa 48 8b 07 65 4c 8b 40 18 4d 85
> >> c0 74 54 <41> 8b 40 18 85 d2 75 22 83 c0 01 89 46 18 4c 89 46 10 48 8b
> >> 07 65
> >> [52890.304556] RAX: 0000000000001000 RBX: ffff9b94c4800000 RCX: 000000=
0000000002
> >> [52890.304680] RSP: 0018:ffffb5dac6473d48 EFLAGS: 00010082
> >> [52890.305597] RDX: 0000000000000ff0 RSI: ffff9b94c4800010 RDI: ffffe0=
6380000000
> >> [52890.306115]
> >> [52890.306384] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffe0=
639e120008
> >> [52890.306910] RAX: 00003a3f1c003ff0 RBX: ffff9b99322a16d0 RCX: 000000=
0000000246
> >> [52890.307010] R10: 0000000000000000 R11: 00000000000096d0 R12: ffff9b=
8ebe621800
> >> [52890.307574] RDX: 0000000000000001 RSI: ffffe063afc8a800 RDI: ffff9b=
94cc48fc00
> >> [52890.307927] R13: ffff9b8ebe621800 R14: 0000000000001000 R15: 000000=
0000000000
> >> [52890.308450] RBP: ffffb5dac6473da0 R08: 86304c8ed4b7099b R09: 000000=
00001c001b
> >> [52890.309006] FS:  0000000000000000(0000) GS:ffff9b9ba3d00000(0000)
> >> knlGS:0000000000000000
> >> [52890.309543] R10: 0000000000040000 R11: 0000000000000001 R12: ffffe0=
63afc8a840
> >> [52890.310127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [52890.310722] R13: ffffe063afc8a800 R14: ffff9b94cc48fc00 R15: ffff9b=
9ba3b36100
> >> [52890.311314] CR2: ffff9b94c480000c CR3: 00000004c3b1c006 CR4: 000000=
0000770ef0
> >> [52890.311735] FS:  0000000000000000(0000) GS:ffff9b9ba3b00000(0000)
> >> knlGS:0000000000000000
> >> [52890.312333] PKRU: 55555554
> >> [52890.312850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [52890.313298] Kernel panic - not syncing: Fatal exception in interrupt
> >> [52891.350776] Shutting down cpus with NMI
> >> [52891.358926] Kernel Offset: 0xae00000 from 0xffffffff81000000
> >> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> >> [52891.359713] ---[ end Kernel panic - not syncing: Fatal exception in
> >> interrupt ]---
> >>
> >> Best,
> >> Jaroslav Pulchart
> >
> >
> >
>
