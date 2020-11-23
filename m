Return-Path: <SRS0=KpU2=E5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59760C56202
	for <virtualization@archiver.kernel.org>; Mon, 23 Nov 2020 14:31:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49C220781
	for <virtualization@archiver.kernel.org>; Mon, 23 Nov 2020 14:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49C220781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3C90420005;
	Mon, 23 Nov 2020 14:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0R56ZjXBmWEi; Mon, 23 Nov 2020 14:31:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1A3AA1FCB5;
	Mon, 23 Nov 2020 14:31:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF0E0C163C;
	Mon, 23 Nov 2020 14:31:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18319C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 14:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 03FF785FAE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 14:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JIn8VbGE48gi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 14:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 236FC85FA6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 14:31:32 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 81FC820758;
 Mon, 23 Nov 2020 14:31:30 +0000 (UTC)
Date: Mon, 23 Nov 2020 09:31:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <20201123093128.701cf81b@gandalf.local.home>
In-Reply-To: <20201123110855.GD3159@unreal>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
 <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
 <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
 <20201118091257.2ee6757a@gandalf.local.home>
 <20201123110855.GD3159@unreal>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 Amit Shah <amit@kernel.org>, virtualization@lists.linux-foundation.org,
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

On Mon, 23 Nov 2020 13:08:55 +0200
Leon Romanovsky <leon@kernel.org> wrote:


>  [   10.028024] Chain exists of:
>  [   10.028025]   console_owner --> target_list_lock --> _xmit_ETHER#2

Note, the problem is that we have a location that grabs the xmit_lock while
holding target_list_lock (and possibly console_owner).


>  [   10.028028]
>  [   10.028028]  Possible interrupt unsafe locking scenario:
>  [   10.028029]
>  [   10.028029]        CPU0                    CPU1
>  [   10.028030]        ----                    ----
>  [   10.028030]   lock(_xmit_ETHER#2);
>  [   10.028032]                                local_irq_disable();
>  [   10.028032]                                lock(console_owner);
>  [   10.028034]                                lock(target_list_lock);
>  [   10.028035]   <Interrupt>
>  [   10.028035]     lock(console_owner);
>  [   10.028036]
>  [   10.028037]  *** DEADLOCK ***
>  [   10.028037]



>  [   10.028107] the dependencies between the lock to be acquired
>  [   10.028107]  and HARDIRQ-irq-unsafe lock:
>  [   10.028108] -> (_xmit_ETHER#2){+.-.}-{2:2} ops: 217 {
>  [   10.028110]    HARDIRQ-ON-W at:
>  [   10.028111]                        __lock_acquire+0x8bc/0x1a94
>  [   10.028111]                        lock_acquire.part.0+0x170/0x360
>  [   10.028112]                        lock_acquire+0x68/0x8c
>  [   10.028113]                        _raw_spin_trylock+0x80/0xd0
>  [   10.028113]                        virtnet_poll+0xac/0x360

xmit_lock is taken in virtnet_poll() (via virtnet_poll_cleantx()).

This is called from the softirq, and interrupts are not disabled.

>  [   10.028114]                        net_rx_action+0x1b0/0x4e0
>  [   10.028115]                        __do_softirq+0x1f4/0x638
>  [   10.028115]                        do_softirq+0xb8/0xcc
>  [   10.028116]                        __local_bh_enable_ip+0x18c/0x200
>  [   10.028116]                        virtnet_napi_enable+0xc0/0xd4
>  [   10.028117]                        virtnet_open+0x98/0x1c0
>  [   10.028118]                        __dev_open+0x12c/0x200
>  [   10.028118]                        __dev_change_flags+0x1a0/0x220
>  [   10.028119]                        dev_change_flags+0x2c/0x70
>  [   10.028119]                        do_setlink+0x214/0xe20
>  [   10.028120]                        __rtnl_newlink+0x514/0x820
>  [   10.028120]                        rtnl_newlink+0x58/0x84
>  [   10.028121]                        rtnetlink_rcv_msg+0x184/0x4b4
>  [   10.028122]                        netlink_rcv_skb+0x60/0x124
>  [   10.028122]                        rtnetlink_rcv+0x20/0x30
>  [   10.028123]                        netlink_unicast+0x1b4/0x270
>  [   10.028124]                        netlink_sendmsg+0x1f0/0x400
>  [   10.028124]                        sock_sendmsg+0x5c/0x70
>  [   10.028125]                        ____sys_sendmsg+0x24c/0x280
>  [   10.028125]                        ___sys_sendmsg+0x88/0xd0
>  [   10.028126]                        __sys_sendmsg+0x70/0xd0
>  [   10.028127]                        __arm64_sys_sendmsg+0x2c/0x40
>  [   10.028128]                        el0_svc_common.constprop.0+0x84/0x200
>  [   10.028128]                        do_el0_svc+0x2c/0x90
>  [   10.028129]                        el0_svc+0x18/0x50
>  [   10.028129]                        el0_sync_handler+0xe0/0x350
>  [   10.028130]                        el0_sync+0x158/0x180

[..]

>  [   10.028171]  ... key      at: [<ffff80001312aef8>] netdev_xmit_lock_key+0x10/0x390
>  [   10.028171]  ... acquired at:
>  [   10.028172]    __lock_acquire+0x134c/0x1a94
>  [   10.028172]    lock_acquire.part.0+0x170/0x360
>  [   10.028173]    lock_acquire+0x68/0x8c
>  [   10.028173]    _raw_spin_lock+0x64/0x90
>  [   10.028174]    virtnet_poll_tx+0x84/0x120
>  [   10.028174]    netpoll_poll_dev+0x12c/0x350
>  [   10.028175]    netpoll_send_skb+0x39c/0x400
>  [   10.028175]    netpoll_send_udp+0x2b8/0x440
>  [   10.028176]    write_msg+0xfc/0x120 [netconsole]
>  [   10.028176]    console_unlock+0x3ec/0x6a4

The above shows the problem. We have:

	console_unlock() (which holds the console_owner lock)
	write_msg() (which holds the target_list_lock)

Then we write_msg() calls:

	netpoll_send_udp() {
	  netpoll_send_skb() {
	    netpoll_poll_dev() {
	      virtnet_poll_tx() (which takes the xmit_lock!)

  DEADLOCK!


In netpoll_send_skb() I see this:

			/* tickle device maybe there is some cleanup */
			netpoll_poll_dev(np->dev);

Which looks to me that it will call some code that should only be used in
softirq context. It's called with locks held that are taken in interrupt
context, and any locks that are taken in netpoll_poll_dev() must always be
taken with interrupts disabled. That is, if xmit_lock is taken within
netpoll_poll_dev(), then it must always be taken with interrupts disabled.
Otherwise you can have the deadlock that lockdep reported.

-- Steve




>  [   10.028177]    register_console+0x17c/0x2f4
>  [   10.028178]    init_netconsole+0x20c/0x1000 [netconsole]
>  [   10.028178]    do_one_initcall+0x8c/0x480
>  [   10.028179]    do_init_module+0x60/0x270
>  [   10.028179]    load_module+0x21f8/0x2734
>  [   10.028180]    __do_sys_finit_module+0xbc/0x12c
>  [   10.028180]    __arm64_sys_finit_module+0x28/0x34
>  [   10.028181]    el0_svc_common.constprop.0+0x84/0x200
>  [   10.028181]    do_el0_svc+0x2c/0x90
>  [   10.028182]    el0_svc+0x18/0x50
>  [   10.028182]    el0_sync_handler+0xe0/0x350
>  [   10.028183]    el0_sync+0x158/0x180
>  [   10.028183]
>  [   10.028183]
>  [   10.028184] stack backtrace:
>  [   10.028185] CPU: 14 PID: 638 Comm: modprobe Not tainted 5.10.0-rc4_for_upstream_min_debug_2020_11_22_19_37 #1
>  [   10.028186] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>  [   10.028186] Call trace:
>  [   10.028186]  dump_backtrace+0x0/0x1d0
>  [   10.028187]  show_stack+0x20/0x3c
>  [   10.028187]  dump_stack+0xec/0x138
>  [   10.028188]  check_irq_usage+0x6b8/0x6cc
>  [   10.028188]  __lock_acquire+0x134c/0x1a94
>  [   10.028189]  lock_acquire.part.0+0x170/0x360
>  [   10.028189]  lock_acquire+0x68/0x8c
>  [   10.028190]  _raw_spin_lock+0x64/0x90
>  [   10.028191]  virtnet_poll_tx+0x84/0x120
>  [   10.028191]  netpoll_poll_dev+0x12c/0x350
>  [   10.028192]  netpoll_send_skb+0x39c/0x400
>  [   10.028192]  netpoll_send_udp+0x2b8/0x440
>  [   10.028193]  write_msg+0xfc/0x120 [netconsole]
>  [   10.028193]  console_unlock+0x3ec/0x6a4
>  [   10.028194]  register_console+0x17c/0x2f4
>  [   10.028194]  init_netconsole+0x20c/0x1000 [netconsole]
>  [   10.028195]  do_one_initcall+0x8c/0x480
>  [   10.028195]  do_init_module+0x60/0x270
>  [   10.028196]  load_module+0x21f8/0x2734
>  [   10.028197]  __do_sys_finit_module+0xbc/0x12c
>  [   10.028197]  __arm64_sys_finit_module+0x28/0x34
>  [   10.028198]  el0_svc_common.constprop.0+0x84/0x200
>  [   10.028198]  do_el0_svc+0x2c/0x90
>  [   10.028199]  el0_svc+0x18/0x50
>  [   10.028199]  el0_sync_handler+0xe0/0x350
>  [   10.028200]  el0_sync+0x158/0x180
>  [   10.073569] random: crng init done
>  [   10.073964] printk: console [netcon0] enabled
>  [   10.074704] random: 7 urandom warning(s) missed due to ratelimiting
>  [   10.075340] netconsole: network logging started
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
