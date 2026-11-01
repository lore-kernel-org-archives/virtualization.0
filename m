Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793548839;
	b=BHo89tyjKdFvIg4cjU/ybYEi16memdOGuPOdVTixONYnP+MKeKPagXZE/PurHXg8Nc91
	 1/2ZbKwPPpjb1JM6K+RUAOQ+q2I2Es4835Paq3isqoUxsaCRRDM37S0EQS3u7G7WAAe9l
	 0IGEeYagoVb/qB8vy4YDbgY7nKcLCTKI+ELno2IlGCNjIWNeqL0pDk/1K3PCqCTjbHkbu
	 pcsqLwPm3X1D9TkTGjXjwYr4AiuGVd+/D7QbXnC18l/qn9TrDBBpaGUpb/GEY3M5l+IIl
	 m+1cOo67KnZUntr1UWNCXWeGzvBtSI7/1eS6PuVozdYAQmqAuYnwHLLggNcLmotYC3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548839;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=UhXEfhl/pFR08gfk1jrd02f01IjoE2CLAVLpgU6OHQ4=;
	b=b2veqYF+qJKQukCS8mnjmryyum678+gsl/YRvBR6/0846xtUvx5F0IpgC3kqA/2tyQKm
	 E2pKp9Fv9yGkNoULlrvPN4NyJsUV3gaXXYUVcNj3ryqY7RA662KlsWJcaPTft2yYyausU
	 XbsPaopvzFSi6nb0V6Zrb69E/64E+GA/aWVJhP9mJN4LDIZ/N6AwrtHIqx3tIJe68yhAR
	 FoXU5OG/3aduEJtkRIsxegRxiWLvEGcfD6YLgYOac5SBkEP9V3PcXqAGptRhP51dL3NUq
	 5CT+JLBeBkuzgkUJr8tODSgw3L9W/9ZHW2XIRWu2Rp9MO/SlzHl7jpI8si8a5OU/3WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44887606A325
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 16:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44887606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-54dbbf252cdso3534404b6e.2
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 08:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793548838; x=1794153638;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhXEfhl/pFR08gfk1jrd02f01IjoE2CLAVLpgU6OHQ4=;
        b=FEWttqO0UO4N7IeI1p1fA2MI+XBeRdpfdYRn1YzGbO7fC1ZgtsgKhMYqRFL2Vx82iP
         Jao1lx/87E8nPxk+SsSdDNG/S0dqQdYLUg1jpVwZnOtKwfx2fHKUQx5KStYDIt8BxhMs
         pTNCa5khJG3Z1R+AZ2eHKtb23GI6dlnBcQAq88nXllt4EFnlmLLcD4t9Pt9M/6kVCWEo
         Ub4+ZZpgVWXevRspV+nm4zpD6VPTPdZ3DFzk8pK8gVQ8GvTrm3WqsiPd90PVGcQk42MJ
         nPE4IDSud0+3aW1BCQWxlJ/yDZi/DEiAuQ+pFSOPnnpJ/Wg9ij+LMkjNYvPBuwb1ZW90
         ZHzw==
X-Forwarded-Encrypted: i=1; AKwUvBy5vTs0UMTFDlMnS6hg+M0O+9Pl8v8CVStnLYKYFlSPQ1CMGNh3g2BUQRllJEJRJSWQqIi17RgIAsIUgA9vaw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK7B5Q10eHyBTJOs1YE0ttUSiW/3CeRkxTRo/keasMwTEC47SlN
	r7E5I0t88VInbOCLX9UpLrKIpyHbjqkMJDZ24sMpJrYAo9kGhKT0OjCA5xAiq/dwMJDgE72XPCH
	dXcJvQvvfX0bHwPNuy+WHkwUItYRejgcR+IYopuWjRCXn8yikQsX0qi9tEx8=
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b26:b0:563:e8b6:c5d5 with SMTP id
 5614622812f47-5640dde7ff7mr4588371b6e.44.1793548838261; Sun, 01 Nov 2026
 08:00:38 -0800 (PST)
Date: Sun, 01 Nov 2026 08:00:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae76226.e91b1aea.38328a.0003.GAE@google.com>
Subject: [syzbot] [virt?] BUG: soft lockup in mac80211_hwsim_beacon (3)
From: syzbot <syzbot+a009aa73657fb9a84de5@syzkaller.appspotmail.com>
To: ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4235cb24ec1e Merge tag 'vfs-7.2-rc5.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f3a7b1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7079b368dcec295
dashboard link: https://syzkaller.appspot.com/bug?extid=a009aa73657fb9a84de5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/efc7b2f0cdd3/disk-4235cb24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd4a09c82e14/vmlinux-4235cb24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a0b50818a22/bzImage-4235cb24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a009aa73657fb9a84de5@syzkaller.appspotmail.com

 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
sched: DL replenish lagged too much
watchdog: BUG: soft lockup - CPU#0 stuck for 220s! [kworker/u8:4:58]
Modules linked in:
irq event stamp: 252177
hardirqs last  enabled at (252176): [<ffffffff81b76dff>] kvm_wait arch/x86/kernel/kvm.c:1096 [inline]
hardirqs last  enabled at (252176): [<ffffffff81b76dff>] kvm_wait+0x11f/0x160 arch/x86/kernel/kvm.c:1078
hardirqs last disabled at (252177): [<ffffffff8bb9a31e>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1062
softirqs last  enabled at (158208): [<ffffffff81c8d222>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (158208): [<ffffffff81c8d222>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (158208): [<ffffffff81c8d222>] __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
softirqs last disabled at (158217): [<ffffffff81c8d222>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (158217): [<ffffffff81c8d222>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (158217): [<ffffffff81c8d222>] __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
CPU: 0 UID: 0 PID: 58 Comm: kworker/u8:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: 66 8d 02 e9 8e 98 56 f5 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d c3 de 11 00 fb f4 <e9> 67 98 56 f5 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc90000007970 EFLAGS: 00000252
RAX: 000000000003d910 RBX: 0000000000000003 RCX: 0000000000000004
RDX: 0000000000000000 RSI: ffffffff8e1a9f82 RDI: ffffffff8c400980
RBP: ffffffff8ffb6540 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000003
R13: 0000000000000003 R14: ffff8880b843c600 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888123dde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c35a1d7 CR3: 000000005a286000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
 kvm_wait arch/x86/kernel/kvm.c:1096 [inline]
 kvm_wait+0x124/0x160 arch/x86/kernel/kvm.c:1078
 pv_wait arch/x86/include/asm/paravirt-spinlock.h:83 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:466 [inline]
 __pv_queued_spin_lock_slowpath+0x4b0/0xc00 kernel/locking/qspinlock.c:325
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt-spinlock.h:35 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/paravirt-spinlock.h:66 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x1e0/0x260 kernel/locking/spinlock_debug.c:116
 spin_lock include/linux/spinlock.h:342 [inline]
 mac80211_hwsim_tx_frame_no_nl+0x745/0x1830 drivers/net/wireless/virtual/mac80211_hwsim_main.c:1963
 mac80211_hwsim_tx_frame+0x1b7/0x250 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2417
 __mac80211_hwsim_beacon_tx drivers/net/wireless/virtual/mac80211_hwsim_main.c:2430 [inline]
 mac80211_hwsim_beacon_tx+0x56c/0xa00 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2493
 __iterate_interfaces+0x2e6/0x650 net/mac80211/util.c:775
 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:811
 mac80211_hwsim_beacon+0xe5/0x2a0 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2525
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x17d/0x2c0 kernel/time/hrtimer.c:2113
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0x58e/0x1870 kernel/smp.c:912
Code: b8 00 00 00 00 00 fc ff df 48 8b 54 24 08 49 89 d5 49 89 d4 49 c1 ed 03 41 83 e4 07 49 01 c5 41 83 c4 03 e8 54 99 0c 00 f3 90 <41> 0f b6 45 00 41 38 c4 7c 08 84 c0 0f 85 a8 10 00 00 8b 45 08 31
RSP: 0018:ffffc900015f6848 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81fda5f2
RDX: ffff88801e725d00 RSI: ffffffff81fda5cc RDI: ffff88801e725d00
RBP: ffff8880b8541380 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000003
R13: ffffed10170a8271 R14: 0000000000000001 R15: ffff8880b843c9c0
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1077
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:46 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x45f/0x16f0 arch/x86/mm/tlb.c:1451
 flush_tlb_page arch/x86/include/asm/tlbflush.h:345 [inline]
 ptep_clear_flush+0x148/0x170 mm/pgtable-generic.c:104
 page_vma_mkclean_one.constprop.0+0x3a2/0x7b0 mm/rmap.c:1138
 page_mkclean_one+0x1cd/0x2b0 mm/rmap.c:1186
 __rmap_walk_file+0x383/0x680 mm/rmap.c:3064
 rmap_walk_file+0x1d8/0x2a0 mm/rmap.c:3097
 rmap_walk mm/rmap.c:3108 [inline]
 folio_mkclean+0x2af/0x4e0 mm/rmap.c:1218
 folio_clear_dirty_for_io+0x1ba/0x960 mm/page-writeback.c:2909
 mpage_submit_folio+0x84/0x330 fs/ext4/inode.c:2085
 mpage_map_and_submit_buffers+0x5f2/0xb50 fs/ext4/inode.c:2347
 mpage_map_and_submit_extent fs/ext4/inode.c:2537 [inline]
 ext4_do_writepages+0x23a4/0x3ed0 fs/ext4/inode.c:2949
 ext4_writepages+0x347/0x750 fs/ext4/inode.c:3043
 do_writepages+0x278/0x600 mm/page-writeback.c:2571
 __writeback_single_inode+0x164/0x1300 fs/fs-writeback.c:1787
 writeback_sb_inodes+0x766/0x1c50 fs/fs-writeback.c:2079
 __writeback_inodes_wb+0xf8/0x2d0 fs/fs-writeback.c:2155
 wb_writeback+0x6f6/0xb50 fs/fs-writeback.c:2266
 wb_check_old_data_flush fs/fs-writeback.c:2370 [inline]
 wb_do_writeback fs/fs-writeback.c:2449 [inline]
 wb_workfn+0x93f/0xc80 fs/fs-writeback.c:2477
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5624 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:mark_lock+0x76/0xa20 kernel/locking/lockdep.c:4774
Code: a3 05 4e 3e 85 14 73 5b 48 8d 04 80 48 8d 04 80 48 8d 04 c5 e0 ed 6a 96 4c 89 f1 48 23 48 60 0f 84 03 03 00 00 b8 01 00 00 00 <48> 8b 54 24 68 65 48 2b 15 45 74 7e 12 0f 85 ea 07 00 00 48 8d 65
RSP: 0018:ffffc90000a08010 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff8880355d4b30 RDI: ffff8880355d3e00
RBP: ffffc90000a080b0 R08: 0000000000000001 R09: 0000000000000003
R10: 000000000000000a R11: 000000000000000a R12: ffff8880355d4b30
R13: ffff8880355d3e00 R14: 0000000000000001 R15: 0000000000000001
FS:  0000555590080500(0000) GS:ffff888123ede000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8aabb556b8 CR3: 000000005a278000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 mark_usage kernel/locking/lockdep.c:4639 [inline]
 __lock_acquire+0x10a8/0x1a40 kernel/locking/lockdep.c:5191
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:158
 spin_lock include/linux/spinlock.h:342 [inline]
 advance_sched+0xe5/0xd20 net/sched/sch_taprio.c:930
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2096
 hrtimer_interrupt+0x3e5/0x940 kernel/time/hrtimer.c:2215
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x109/0x470 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x51/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x5e/0x370 kernel/locking/lockdep.c:5872
Code: 05 fb 4d 7e 12 83 f8 07 0f 87 da 00 00 00 48 0f a3 05 86 cc 3c 0f 0f 82 ac 02 00 00 8b 35 2e 00 3d 0f 85 f6 0f 85 c7 00 00 00 <48> 8b 44 24 30 65 48 2b 05 9d 4d 7e 12 0f 85 ec 02 00 00 48 83 c4
RSP: 0018:ffffc90000a084e0 EFLAGS: 00000206
RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8e1840ee RDI: ffffffff8c400980
RBP: ffffffff8ebe8180 R08: 00000000cda50cb6 R09: 0000000000000007
R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock include/linux/rcupdate.h:840 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1183 [inline]
 unwind_next_frame+0xd1/0x2090 arch/x86/kernel/unwind_orc.c:495
 __unwind_start+0x3cd/0x7e0 arch/x86/kernel/unwind_orc.c:787
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x73/0xf0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 kmem_cache_alloc_node_noprof+0x27d/0x6b0 mm/slub.c:4989
 kmalloc_reserve+0x148/0x350 net/core/skbuff.c:615
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 skb_copy+0x1ca/0x3a0 net/core/skbuff.c:2185
 mac80211_hwsim_tx_frame_no_nl+0xc7f/0x1830 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2020
 mac80211_hwsim_tx_frame+0x1b7/0x250 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2417
 __mac80211_hwsim_beacon_tx drivers/net/wireless/virtual/mac80211_hwsim_main.c:2430 [inline]
 mac80211_hwsim_beacon_tx+0x56c/0xa00 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2493
 __iterate_interfaces+0x2e6/0x650 net/mac80211/util.c:775
 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:811
 mac80211_hwsim_beacon+0xe5/0x2a0 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2525
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x17d/0x2c0 kernel/time/hrtimer.c:2113
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__folio_rmap_sanity_checks include/linux/rmap.h:335 [inline]
RIP: 0010:__folio_dup_file_rmap include/linux/rmap.h:498 [inline]
RIP: 0010:folio_dup_file_rmap_pte include/linux/rmap.h:544 [inline]
RIP: 0010:copy_present_ptes mm/memory.c:1192 [inline]
RIP: 0010:copy_pte_range mm/memory.c:1320 [inline]
RIP: 0010:copy_pmd_range mm/memory.c:1408 [inline]
RIP: 0010:copy_pud_range mm/memory.c:1445 [inline]
RIP: 0010:copy_p4d_range mm/memory.c:1469 [inline]
RIP: 0010:copy_page_range+0x1d2c/0x5b20 mm/memory.c:1555
Code: 90 0f 0b 90 e9 3e 15 00 00 e8 90 fe aa ff bd 00 10 00 00 83 44 24 38 01 bb 08 00 00 00 e9 e5 fd ff ff e8 77 fe aa ff 44 89 ee <bf> f4 00 00 00 e8 da f8 aa ff 41 81 fd f4 00 00 00 0f 84 61 25 00
RSP: 0018:ffffc90002f37548 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffea00015f8680 RCX: ffffffff825f3643
RDX: ffff8880355d3e00 RSI: 0000000000000000 RDI: ffff8880355d3e00
RBP: ffffea00015f86b4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea00015f8698
R13: 0000000000000000 R14: ffff88805a29c098 R15: ffffea00015f8680
 dup_mmap+0xd44/0x21b0 mm/mmap.c:1840
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm kernel/fork.c:1595 [inline]
 copy_process+0x4588/0x8030 kernel/fork.c:2289
 kernel_clone+0x176/0x9d0 kernel/fork.c:2748
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2889
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8aaadc6912
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffdc2535310 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffdc2535310 RCX: 00007f8aaadc6912
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffdc253549c R08: 0000000000000000 R09: 0000000000000001
R10: 00005555900807d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 000000000001a791 R15: 00007ffdc25354f0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
