Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1766C63697
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:33:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4743B2223D
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4743B2223D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EFE0885B12;
	Tue, 17 Nov 2020 14:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6nA9Qtmr7xPx; Tue, 17 Nov 2020 14:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9FC4E85604;
	Tue, 17 Nov 2020 14:33:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84471C0891;
	Tue, 17 Nov 2020 14:33:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5135C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A65E08705B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OJxnNPztDxr9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A7B8B8704A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:28 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEB1A2222E;
 Tue, 17 Nov 2020 14:33:26 +0000 (UTC)
Date: Tue, 17 Nov 2020 09:33:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <20201117093325.78f1486d@gandalf.local.home>
In-Reply-To: <20201117102341.GR47002@unreal>
References: <20201117102341.GR47002@unreal>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Ran Rozenstein <ranro@nvidia.com>, Itay Aveksis <itayav@nvidia.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 17 Nov 2020 12:23:41 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> Hi,
> 
> Approximately two weeks ago, our regression team started to experience those
> netconsole splats. The tested code is Linus's master (-rc4) + netdev net-next
> + netdev net-rc.
> 
> Such splats are random and we can't bisect because there is no stable reproducer.
> 
> Any idea, what is the root cause?
> 
> [   21.141117] netpoll: netconsole: local port 6666
> [   21.141947] netpoll: netconsole: local IPv4 address 10.236.251.7
> [   21.143138] netpoll: netconsole: interface 'eth1'
> [   21.143988] netpoll: netconsole: remote port 62517
> [   21.145127] netpoll: netconsole: remote IPv4 address 10.236.251.1
> [   21.146206] netpoll: netconsole: remote ethernet address 68:05:ca:aa:99:49
> [   21.149464] =====================================================
> [   21.149466] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> [   21.149467] 5.10.0-rc4_for_upstream_min_debug_2020_11_16_13_03 #1 Not tainted
> [   21.149468] -----------------------------------------------------
> [   21.149469] modprobe/596 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> [   21.149471] ffff000194b4e298 (_xmit_ETHER#2){+.-.}-{2:2}, at: virtnet_poll_tx+0x84/0x120
> [   21.149478] and this task is already holding:
> [   21.149478] ffff8000093d4018 (target_list_lock){....}-{2:2}, at: write_msg+0x6c/0x120 [netconsole]
> [   21.149483] which would create a new lock dependency:
> [   21.149484]  (target_list_lock){....}-{2:2} -> (_xmit_ETHER#2){+.-.}-{2:2}
> [   21.149491] but this new dependency connects a HARDIRQ-irq-safe lock:
> [   21.149492]  (console_owner){-.-.}-{0:0}
> [   21.149496] ... which became HARDIRQ-irq-safe at:
> [   21.149496]   __lock_acquire+0xa78/0x1a94
> [   21.149498]   lock_acquire.part.0+0x170/0x360
> [   21.149498]   lock_acquire+0x68/0x8c
> [   21.149500]   console_unlock+0x1e8/0x6a4
> [   21.149500]   vprintk_emit+0x1c4/0x3c4
> [   21.149501]   vprintk_default+0x40/0x4c
> [   21.149502]   vprintk_func+0x10c/0x220
> [   21.149503]   printk+0x68/0x90
> [   21.149504]   crng_fast_load+0x1bc/0x1c0
> [   21.149505]   add_interrupt_randomness+0x280/0x290
> [   21.149506]   handle_irq_event+0x80/0x120
> [   21.149507]   handle_fasteoi_irq+0xac/0x200
> [   21.149508]   __handle_domain_irq+0x84/0xf0
> [   21.149509]   gic_handle_irq+0xd4/0x320
> [   21.149510]   el1_irq+0xd0/0x180
> [   21.149511]   arch_cpu_idle+0x24/0x44
> [   21.149512]   default_idle_call+0x48/0xa0
> [   21.149513]   do_idle+0x260/0x300
> [   21.149514]   cpu_startup_entry+0x30/0x6c
> [   21.149515]   rest_init+0x1b4/0x288
> [   21.149515]   arch_call_rest_init+0x18/0x24
> [   21.149516]   start_kernel+0x5cc/0x608
> [   21.149518] to a HARDIRQ-irq-unsafe lock:
> [   21.149519]  (_xmit_ETHER#2){+.-.}-{2:2}
> [   21.149523] ... which became HARDIRQ-irq-unsafe at:
> [   21.149524] ...  __lock_acquire+0x8bc/0x1a94
> [   21.149525]   lock_acquire.part.0+0x170/0x360
> [   21.149526]   lock_acquire+0x68/0x8c
> [   21.149527]   _raw_spin_trylock+0x80/0xd0
> [   21.149527]   virtnet_poll+0xac/0x360
> [   21.149528]   net_rx_action+0x1b0/0x4e0
> [   21.149529]   __do_softirq+0x1f4/0x638
> [   21.149530]   do_softirq+0xb8/0xcc
> [   21.149531]   __local_bh_enable_ip+0x18c/0x200
> [   21.149532]   virtnet_napi_enable+0xc0/0xd4
> [   21.149533]   virtnet_open+0x98/0x1c0
> [   21.149534]   __dev_open+0x12c/0x200
> [   21.149535]   __dev_change_flags+0x1a0/0x220
> [   21.149536]   dev_change_flags+0x2c/0x70
> [   21.149536]   do_setlink+0x214/0xe20
> [   21.149537]   __rtnl_newlink+0x514/0x820
> [   21.149538]   rtnl_newlink+0x58/0x84
> [   21.149539]   rtnetlink_rcv_msg+0x184/0x4b4
> [   21.149540]   netlink_rcv_skb+0x60/0x124
> [   21.149541]   rtnetlink_rcv+0x20/0x30
> [   21.149542]   netlink_unicast+0x1b4/0x270
> [   21.149543]   netlink_sendmsg+0x1f0/0x400
> [   21.149544]   sock_sendmsg+0x5c/0x70
> [   21.149545]   ____sys_sendmsg+0x24c/0x280
> [   21.149545]   ___sys_sendmsg+0x88/0xd0
> [   21.149546]   __sys_sendmsg+0x70/0xd0
> [   21.149547]   __arm64_sys_sendmsg+0x2c/0x40
> [   21.149548]   el0_svc_common.constprop.0+0x84/0x200
> [   21.149549]   do_el0_svc+0x2c/0x90
> [   21.149550]   el0_svc+0x18/0x50
> [   21.149551]   el0_sync_handler+0xe0/0x350
> [   21.149552]   el0_sync+0x158/0x180
> [   21.149553] other info that might help us debug this:
> [   21.149555] Chain exists of:
> [   21.149556]   console_owner --> target_list_lock --> _xmit_ETHER#2

So somewhere we have target_list_lock taken while holding the console_owner
lock (which can happen in interrupt). And what this is saying,
target_list_lock is held somewhere where _xmit_ETHER#2 is taken (which I'm
guessing from the back traces is the xmit_lock taken in virtnet_poll_tx().

Thus, you can have a deadlock with three CPUs (I need to update the lockdep
output to make it proper one of these days).

	CPU0			CPU1			CPU2
	----			----			----
    lock(xmit_ETHER#2)

			    local_irq_disable()
			    lock(target_list_lock)
			    lock(xmit_ETHER#2)
			    [blocked]

						    local_irq_disable()
						    lock(console_owner)
						    lock(target_list_lock)
						    [blocked]
    <interrupt>
    lock(console_owner)
    [blocked]

 *** DEADLOCK! ***


> [   21.149563]  Possible interrupt unsafe locking scenario:
> [   21.149564]        CPU0                    CPU1
> [   21.149565]        ----                    ----
> [   21.149566]   lock(_xmit_ETHER#2);
> [   21.149569]                                local_irq_disable();
> [   21.149570]                                lock(console_owner);
> [   21.149572]                                lock(target_list_lock);
> [   21.149575]   <Interrupt>
> [   21.149576]     lock(console_owner);
> [   21.149579]  *** DEADLOCK ***
> [   21.149580] 3 locks held by modprobe/596:
> [   21.149581]  #0: ffff800011a1efe0 (console_lock){+.+.}-{0:0}, at: register_console+0x144/0x2f4
> [   21.149586]  #1: ffff800011a1f108 (console_owner){-.-.}-{0:0}, at: console_unlock+0x17c/0x6a4
> [   21.149590]  #2: ffff8000093d4018 (target_list_lock){....}-{2:2}, at: write_msg+0x6c/0x120 [netconsole]
> [   21.149596] the dependencies between HARDIRQ-irq-safe lock and the holding lock:
> [   21.149596]  -> (console_owner){-.-.}-{0:0} ops: 1191 {
> [   21.149601]     IN-HARDIRQ-W at:
> [   21.149602]                          __lock_acquire+0xa78/0x1a94
> [   21.149603]                          lock_acquire.part.0+0x170/0x360
> [   21.149604]                          lock_acquire+0x68/0x8c
> [   21.149605]                          console_unlock+0x1e8/0x6a4
> [   21.149606]                          vprintk_emit+0x1c4/0x3c4
> [   21.149607]                          vprintk_default+0x40/0x4c
> [   21.149608]                          vprintk_func+0x10c/0x220
> [   21.149610]                          printk+0x68/0x90
> [   21.149611]                          crng_fast_load+0x1bc/0x1c0
> [   21.149612]                          add_interrupt_randomness+0x280/0x290
> [   21.149613]                          handle_irq_event+0x80/0x120
> [   21.149614]                          handle_fasteoi_irq+0xac/0x200
> [   21.149615]                          __handle_domain_irq+0x84/0xf0
> [   21.149616]                          gic_handle_irq+0xd4/0x320
> [   21.149617]                          el1_irq+0xd0/0x180
> [   21.149618]                          arch_cpu_idle+0x24/0x44
> [   21.149619]                          default_idle_call+0x48/0xa0
> [   21.149620]                          do_idle+0x260/0x300
> [   21.149621]                          cpu_startup_entry+0x30/0x6c
> [   21.149622]                          rest_init+0x1b4/0x288
> [   21.149624]                          arch_call_rest_init+0x18/0x24
> [   21.149625]                          start_kernel+0x5cc/0x608
> [   21.149625]     IN-SOFTIRQ-W at:
> [   21.149627]                          __lock_acquire+0x894/0x1a94
> [   21.149628]                          lock_acquire.part.0+0x170/0x360
> [   21.149629]                          lock_acquire+0x68/0x8c
> [   21.149630]                          console_unlock+0x1e8/0x6a4
> [   21.149631]                          vprintk_emit+0x1c4/0x3c4
> [   21.149632]                          vprintk_default+0x40/0x4c
> [   21.149633]                          vprintk_func+0x10c/0x220
> [   21.149634]                          printk+0x68/0x90
> [   21.149635]                          hrtimer_interrupt+0x290/0x294
> [   21.149636]                          arch_timer_handler_virt+0x3c/0x50
> [   21.149637]                          handle_percpu_devid_irq+0x94/0x164
> [   21.149673]                          __handle_domain_irq+0x84/0xf0
> [   21.149674]                          gic_handle_irq+0xd4/0x320
> [   21.149675]                          el1_irq+0xd0/0x180
> [   21.149676]                          __do_softirq+0x108/0x638
> [   21.149677]                          __irq_exit_rcu+0x17c/0x1b0
> [   21.149678]                          irq_exit+0x18/0x44
> [   21.149679]                          __handle_domain_irq+0x88/0xf0
> [   21.149680]                          gic_handle_irq+0xd4/0x320
> [   21.149681]                          el1_irq+0xd0/0x180
> [   21.149682]                          smp_call_function_many_cond+0x3cc/0x3f0
> [   21.149683]                          kick_all_cpus_sync+0x4c/0x80
> [   21.149684]                          load_module+0x1eec/0x2734
> [   21.149685]                          __do_sys_finit_module+0xbc/0x12c
> [   21.149686]                          __arm64_sys_finit_module+0x28/0x34
> [   21.149687]                          el0_svc_common.constprop.0+0x84/0x200
> [   21.149688]                          do_el0_svc+0x2c/0x90
> [   21.149689]                          el0_svc+0x18/0x50
> [   21.149690]                          el0_sync_handler+0xe0/0x350
> [   21.149691]                          el0_sync+0x158/0x180
> [   21.149692]     INITIAL USE at:
> [   21.149694]                         __lock_acquire+0x2e0/0x1a94
> [   21.149695]                         lock_acquire.part.0+0x170/0x360
> [   21.149696]                         lock_acquire+0x68/0x8c
> [   21.149697]                         console_unlock+0x1e8/0x6a4
> [   21.149698]                         vprintk_emit+0x1c4/0x3c4
> [   21.149699]                         vprintk_default+0x40/0x4c
> [   21.149700]                         vprintk_func+0x10c/0x220
> [   21.149701]                         printk+0x68/0x90
> [   21.149702]                         start_kernel+0x8c/0x608
> [   21.149703]   }
> [   21.149704]   ... key      at: [<ffff800011a1f108>] console_owner_dep_map+0x0/0x28
> [   21.149705]   ... acquired at:
> [   21.149706]    lock_acquire.part.0+0x170/0x360
> [   21.149707]    lock_acquire+0x68/0x8c
> [   21.149708]    _raw_spin_lock_irqsave+0x88/0x15c
> [   21.149709]    write_msg+0x6c/0x120 [netconsole]
> [   21.149710]    console_unlock+0x3ec/0x6a4
> [   21.149711]    register_console+0x17c/0x2f4
> [   21.149712]    init_netconsole+0x20c/0x1000 [netconsole]
> [   21.149713]    do_one_initcall+0x8c/0x480
> [   21.149714]    do_init_module+0x60/0x270
> [   21.149715]    load_module+0x21f8/0x2734
> [   21.149716]    __do_sys_finit_module+0xbc/0x12c
> [   21.149717]    __arm64_sys_finit_module+0x28/0x34
> [   21.149718]    el0_svc_common.constprop.0+0x84/0x200
> [   21.149719]    do_el0_svc+0x2c/0x90
> [   21.149720]    el0_svc+0x18/0x50
> [   21.149722]    el0_sync_handler+0xe0/0x350
> [   21.149723]    el0_sync+0x158/0x180
> [   21.149724] -> (target_list_lock){....}-{2:2} ops: 4 {
> [   21.149729]    INITIAL USE at:
> [   21.149730]                       __lock_acquire+0x2e0/0x1a94
> [   21.149731]                       lock_acquire.part.0+0x170/0x360
> [   21.149732]                       lock_acquire+0x68/0x8c
> [   21.149734]                       _raw_spin_lock_irqsave+0x88/0x15c
> [   21.149735]                       init_netconsole+0x148/0x1000 [netconsole]
> [   21.149736]                       do_one_initcall+0x8c/0x480
> [   21.149737]                       do_init_module+0x60/0x270
> [   21.149738]                       load_module+0x21f8/0x2734
> [   21.149739]                       __do_sys_finit_module+0xbc/0x12c
> [   21.149740]                       __arm64_sys_finit_module+0x28/0x34
> [   21.149741]                       el0_svc_common.constprop.0+0x84/0x200
> [   21.149742]                       do_el0_svc+0x2c/0x90
> [   21.149743]                       el0_svc+0x18/0x50
> [   21.149744]                       el0_sync_handler+0xe0/0x350
> [   21.149745]                       el0_sync+0x158/0x180
> [   21.149746]  }
> [   21.149747]  ... key      at: [<ffff8000093d4018>] target_list_lock+0x18/0xfffffffffffff000 [netconsole]
> [   21.149748]  ..
> [   21.149750] Lost 190 message(s)!

It really sucks that we lose 190 messages that would help to decipher this
more. :-p

Because I'm not sure where the xmit_lock is taken while holding the
target_list_lock. But the above does show that printk() calls write_msg()
while holding the console_lock, and write_msg() takes the target_list_lock.

Thus, the fix would ether require disabling interrupts every time the
xmit_lock is taken, or to get it from being taken while holding the
target_list_lock.

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
