Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A001BC088;
	Fri, 13 Sep 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216022; cv=none; b=TX7mACHUvxpXq7w5tjEikbxXjR11IBHLj/T/nnB4gOvEooxm/KB71bqmClcVUAbgJs8eNwMbyuEFx9qEDvYwwybxUFi6fITovintekGpjc6jLvkXa/vqYQbs5dIG2hK9+no10inXndrEU7yc0lMqBVFJCnAHnkWK3ISEy43/4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216022; c=relaxed/simple;
	bh=fnSrls3l/5EOexa1izdk7EpoTGDFHvsswO2kA6/ol9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Bw2KjgG+vyD/m1nqmtzwZBLnvCRCJ56alYURHiIyRfUSMc/ilenzKqXaWPD7zEqsf6MoxjErmLEo70rqYAReSnUUdDPDoiGQaZ6CGJgwJy0GaQKTYfsWYgLQPXREF7VT7jmMpf5JvO/EWzOTgecH6Humzyriu6p21yzHq9aJaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=UcnAZypW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="UcnAZypW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=wJgLvJRFhROt60AJU+va3LMzdG34mC6iRwieSzZxFk0=;
	t=1726216020; x=1726648020; b=UcnAZypWIe9gyhCwOFvCgFbAXr+cJ5vwUjFKu62NYg3YQst
	bBolOL9y5px/QsxhJmj8f+KbHyP8EBvRWIOtiZfQperwj3W1DFNAPOwAoTOZktP0iyvqzHcfuz1Mo
	nkPCMh3YKBev0A6RYtGXjVZHbhHvlpeaDaQVyL9z6noGTarwm8vrtXgSCOrwDuMeIRxyP1LWP5EKm
	TZFMy3Fd6fsLRTfTmi36xuh5Go31/cFu4xGTeQ7K2M1AVqSWaZjEa2svwdSyKSuGiVPyEJQIUT6N6
	w6qj2p0IHaUd0RCVuna0YxHeDpofi56Qyb1826hgdDP+MEmBS08kTwFk/qh5xvVg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sp1dq-0005Ki-Fn; Fri, 13 Sep 2024 10:26:58 +0200
Message-ID: <422f35b3-7834-4df7-bcea-e3be12707aef@leemhuis.info>
Date: Fri, 13 Sep 2024 10:26:57 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net] with 6.10.7 and
 packed virtqueues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <CAK8fFZ6qVutPWxquHg7NEvFqYqDP5BwEdO81hqW8iMFxJFuLSQ@mail.gmail.com>
 <CAK8fFZ5N7EbU=uLbfyeSkQ273NSm+GELWUu1O1OBCpaSwjv6FA@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 virtualization@lists.linux.dev
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAK8fFZ5N7EbU=uLbfyeSkQ273NSm+GELWUu1O1OBCpaSwjv6FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1726216020;eb48507e;
X-HE-SMSGID: 1sp1dq-0005Ki-Fn

[CCing a few people that know more about this stuff than I do]

On 13.09.24 09:50, Jaroslav Pulchart wrote:
> 
> actually I'm getting random memory corruption related crashes after
> updating to 6.10.y. My expectation is that it relates to this issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=219154
> It looks like it is almost 1 month ago

A lot of developer ignore bugzilla.

> already from the last comment
> there, However the patches fixing the regression are not reverted from
> the 6.10.y tree which surprises me.
> 
> I will try to revert them from our builds and see if it helps to avoid
> random daily happening crashes.

Not my area of expertise, but to me it sounds like the problem will be
resolved my "Revert "virtio_net: rx enable premapped mode by default"":
https://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com/

That set just landed in mainline. It's likely to be backported to 6.10.y
within a week or two, but it's not ensured due to the lack of a stable
tag. So you might keep an eye on it.

Ciao, Thorsten

> pá 6. 9. 2024 v 8:20 odesílatel Jaroslav Pulchart
> <jaroslav.pulchart@gooddata.com> napsal:
>>
>> Hello,
>>
>> My virtual machine crashed with the message
>> "0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]". See the full log
>> below.
>>
>> I did two changes:
>> * Updated my VM packages (kernel from 6.9.5 to 6.10.7) on the VM
>> * enabled "packed virtqueues" by libvirt on host
>> and it happens after a few hours of uptime.
>>
>> Any hint how to prevent it or fix this issue?
>>
>> [52890.265362] BUG: unable to handle page fault for address: ffff9b94c480000c
>> [52890.266264] #PF: supervisor write access in kernel mode
>> [52890.266814] #PF: error_code(0x000b) - reserved bit violation
>> [52890.267299] PGD 4c3c01067 P4D 4c3c01067 PUD 103be6063 PMD 7849cc063
>> PTE 7a1dd28f4e77cee7
>> [52890.267926] Oops: Oops: 000b [#1] PREEMPT SMP NOPTI
>> [52890.268372] CPU: 14 PID: 0 Comm: swapper/14 Tainted: G            E
>>      6.10.7-1.gdc.el9.x86_64 #1
>> [52890.269007] Hardware name: RDO OpenStack Compute/RHEL, BIOS
>> edk2-20240524-1.el9 05/24/2024
>> [52890.269853] RIP: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
>> [52890.270349] Code: e7 e8 85 ef ff ff 49 c7 84 24 80 05 00 00 00 00
>> 00 00 41 0f b7 84 24 ac 02 00 00 48 8d 73 10 45 31 c0 b9 02 00 00 00
>> 8d 50 f0 <66> 89 53 0c 49 8b 3c 24 0f b7 d2 e8 f1 04 9d cb 49 8b 3c 24
>> 48 89
>> [52890.272173] RSP: 0018:ffffb5dac64f0d60 EFLAGS: 00010246
>> [52890.272637] RAX: 0000000000001000 RBX: ffff9b94c4800000 RCX: 0000000000000002
>> [52890.273209] RDX: 0000000000000ff0 RSI: ffff9b94c4800010 RDI: ffffe06380000000
>> [52890.273772] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffe0639e120008
>> [52890.274341] R10: 0000000000000000 R11: 00000000000096d0 R12: ffff9b8ebe621800
>> [52890.274898] R13: ffff9b8ebe621800 R14: 0000000000001000 R15: 0000000000000000
>> [52890.275476] FS:  0000000000000000(0000) GS:ffff9b9ba3d00000(0000)
>> knlGS:0000000000000000
>> [52890.276087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [52890.276592] CR2: ffff9b94c480000c CR3: 00000004c3b1c006 CR4: 0000000000770ef0
>> [52890.277167] PKRU: 55555554
>> [52890.277524] Call Trace:
>> [52890.277869]  <IRQ>
>> [52890.278198]  ? __die+0x20/0x70
>> [52890.278580]  ? page_fault_oops+0x75/0x170
>> [52890.279009]  ? exc_page_fault+0xbe/0x160
>> [52890.279441]  ? asm_exc_page_fault+0x22/0x30
>> [52890.279881]  ? virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
>> [52890.280377]  try_fill_recv+0x22c/0x440 [virtio_net]
>> [52890.280848]  virtnet_receive+0x1ce/0x230 [virtio_net]
>> [52890.281334]  virtnet_poll+0x179/0x3a0 [virtio_net]
>> [52890.281804]  __napi_poll+0x29/0x1b0
>> [52890.282222]  net_rx_action+0x2b5/0x390
>> [52890.282641]  ? _raw_spin_unlock_irqrestore+0xa/0x30
>> [52890.283118]  handle_softirqs+0xd3/0x2b0
>> [52890.283550]  __irq_exit_rcu+0x9b/0xc0
>> [52890.283970]  common_interrupt+0x7f/0xa0
>> [52890.284409]  </IRQ>
>> [52890.284749]  <TASK>
>> [52890.285084]  asm_common_interrupt+0x22/0x40
>> [52890.285526] RIP: 0010:default_idle+0xb/0x20
>> [52890.285953] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90
>> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d c3 92 30
>> 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
>> 00 90
>> [52890.287332] RSP: 0018:ffffb5dac436fec0 EFLAGS: 00000206
>> [52890.287814] RAX: 000000000000000e RBX: ffff9b94c320ce00 RCX: 0000000103227730
>> [52890.288395] RDX: 000000000000000e RSI: 0000000000000082 RDI: 000000002f3198a4
>> [52890.288962] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>> [52890.289533] R10: 00000000000002cd R11: 0000000000000000 R12: 0000000000000000
>> [52890.290092] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> [52890.290657]  default_idle_call+0x2c/0xf0
>> [52890.291053]  cpuidle_idle_call+0x109/0x120
>> [52890.291464]  do_idle+0x76/0xb0
>> [52890.291813]  cpu_startup_entry+0x25/0x30
>> [52890.292269]  start_secondary+0x113/0x130
>> [52890.292812]  common_startup_64+0x13e/0x141
>> [52890.293279]  </TASK>
>> [52890.293615] Modules linked in: mptcp_diag(E) xsk_diag(E)
>> raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) tcp_diag(E)
>> udp_diag(E) inet_diag(E) nf_conntrack(E) nf_defrag_ipv6(E)
>> nf_defrag_ipv4(E) binfmt_misc(E) zram(E) tls(E) isofs(E) vfat(E)
>> fat(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E)
>> i2c_i801(E) virtio_net(E) net_failover(E) failover(E) virtio_gpu(E)
>> i2c_smbus(E) dimlib(E) virtio_balloon(E) virtio_dma_buf(E) fuse(E)
>> ext4(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E)
>> crct10dif_pclmul(E) libahci(E) crc32_pclmul(E) polyval_clmulni(E)
>> polyval_generic(E) libata(E) ghash_clmulni_intel(E) sha512_ssse3(E)
>> virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
>> raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E)
>> dm_region_hash(E) dm_log(E) dm_mod(E)
>> [52890.293657] Unloaded tainted modules: edac_mce_amd(E):1
>> amd_atl(E):2 padlock_aes(E):3
>> [52890.299716] CR2: ffff9b94c480000c
>> [52890.300092] ---[ end trace 0000000000000000 ]---
>> [52890.300101] Oops: general protection fault, probably for
>> non-canonical address 0x86304c8ed4b709b3: 0000 [#2] PREEMPT SMP NOPTI
>> [52890.300336] RIP: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net]
>> [52890.301177] CPU: 10 PID: 51 Comm: ksoftirqd/10 Tainted: G      D
>>  E      6.10.7-1.gdc.el9.x86_64 #1
>> [52890.301472] Code: e7 e8 85 ef ff ff 49 c7 84 24 80 05 00 00 00 00
>> 00 00 41 0f b7 84 24 ac 02 00 00 48 8d 73 10 45 31 c0 b9 02 00 00 00
>> 8d 50 f0 <66> 89 53 0c 49 8b 3c 24 0f b7 d2 e8 f1 04 9d cb 49 8b 3c 24
>> 48 89
>> [52890.302137] Hardware name: RDO OpenStack Compute/RHEL, BIOS
>> edk2-20240524-1.el9 05/24/2024
>> [52890.303074] RSP: 0018:ffffb5dac64f0d60 EFLAGS: 00010246
>> [52890.303689] RIP: 0010:put_cpu_partial+0x15/0x70
>> [52890.303895]
>> [52890.304291] Code: 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90
>> 90 90 90 90 90 0f 1f 44 00 00 9c 59 fa 48 8b 07 65 4c 8b 40 18 4d 85
>> c0 74 54 <41> 8b 40 18 85 d2 75 22 83 c0 01 89 46 18 4c 89 46 10 48 8b
>> 07 65
>> [52890.304556] RAX: 0000000000001000 RBX: ffff9b94c4800000 RCX: 0000000000000002
>> [52890.304680] RSP: 0018:ffffb5dac6473d48 EFLAGS: 00010082
>> [52890.305597] RDX: 0000000000000ff0 RSI: ffff9b94c4800010 RDI: ffffe06380000000
>> [52890.306115]
>> [52890.306384] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffe0639e120008
>> [52890.306910] RAX: 00003a3f1c003ff0 RBX: ffff9b99322a16d0 RCX: 0000000000000246
>> [52890.307010] R10: 0000000000000000 R11: 00000000000096d0 R12: ffff9b8ebe621800
>> [52890.307574] RDX: 0000000000000001 RSI: ffffe063afc8a800 RDI: ffff9b94cc48fc00
>> [52890.307927] R13: ffff9b8ebe621800 R14: 0000000000001000 R15: 0000000000000000
>> [52890.308450] RBP: ffffb5dac6473da0 R08: 86304c8ed4b7099b R09: 00000000001c001b
>> [52890.309006] FS:  0000000000000000(0000) GS:ffff9b9ba3d00000(0000)
>> knlGS:0000000000000000
>> [52890.309543] R10: 0000000000040000 R11: 0000000000000001 R12: ffffe063afc8a840
>> [52890.310127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [52890.310722] R13: ffffe063afc8a800 R14: ffff9b94cc48fc00 R15: ffff9b9ba3b36100
>> [52890.311314] CR2: ffff9b94c480000c CR3: 00000004c3b1c006 CR4: 0000000000770ef0
>> [52890.311735] FS:  0000000000000000(0000) GS:ffff9b9ba3b00000(0000)
>> knlGS:0000000000000000
>> [52890.312333] PKRU: 55555554
>> [52890.312850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [52890.313298] Kernel panic - not syncing: Fatal exception in interrupt
>> [52891.350776] Shutting down cpus with NMI
>> [52891.358926] Kernel Offset: 0xae00000 from 0xffffffff81000000
>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [52891.359713] ---[ end Kernel panic - not syncing: Fatal exception in
>> interrupt ]---
>>
>> Best,
>> Jaroslav Pulchart
> 
> 
> 

