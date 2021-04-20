Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4014C433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 15:42:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C7C613B0
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 15:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C7C613B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 996A683A83;
	Tue, 20 Apr 2021 15:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYtRFviBOA3O; Tue, 20 Apr 2021 15:42:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FE5583B76;
	Tue, 20 Apr 2021 15:42:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0509AC000E;
	Tue, 20 Apr 2021 15:42:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64A5DC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 15:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45A134021B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 15:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r0qf-n745ima
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 15:42:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41CA4401F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 15:42:43 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id m13so39336086oiw.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Naz1DrVXxBH7tywhff0dCWs4H+8+B3WWxTeFXFlsQuE=;
 b=SbGPqz13+mfAi7LATakrKqCDK4XrVrapAn34oVBsaSJqLoFBh3xaLGRufJZd6OxGhy
 f2efxMaWXjn+lvbpgB3SoReNcmFh7/y0rh0f6ZNHowMDIBHzyc7m1cGRcyue0ElPLCyG
 kebJlLhd8z++4+aE8jbHAEwbAYp+SkVGwH4Qbqy4pCsumXgsu9KxxYz04UrXs4W7AbWc
 UZSy4sdK9phXuEMGGMIcGgCpJ7nZ1Ygt0oTQSOxCqeY41MdjtY6Fxr4TOWMhXdlq+PaM
 EYjtW4QwV7SuBxPVw+hLEbZK3AEQMJRQ3/vmhUfblEK17GR1S0J0ai0gq/65rf4G2otr
 Ll7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=Naz1DrVXxBH7tywhff0dCWs4H+8+B3WWxTeFXFlsQuE=;
 b=PAWaPRot8nOdwyztXARchLXRs50+pLsiz/94JNoN+Y/1/fG589RkD1b/pHy5D5H78U
 swbmfwg2LUXFYgkmmSMonXLF2/Kl4cv8jyWLoViOfGWuJ9tfYWSSa52Nd8B0uRJBco+z
 npALW8NzLudpIMRW/KAQCa1D7vuZ6PGbEOjZ+nR0kxFbOn/EvzlHhEj/DH51Es3g27Bg
 /wkAkeUEchmlD+P5SNJD6v5jvs5bjW/BnD0NRQ3qEUjm9p/q3YwsZS5ytG8fdbqRhxwR
 dnHMc1xlrQqJ45HUcPR+w1giPIPp+/Df0Gl2Kp2MLQPvSk6LKoXASJDYW8nlDx2th2uk
 U5MQ==
X-Gm-Message-State: AOAM530U9oc+R0LPHmDgxuFJ3sR3IU51Zzv+7eAdgFAeaW8n35Xuev9F
 KkUlWee3dA/La9kLh8mu0EQ=
X-Google-Smtp-Source: ABdhPJy7oWbL3xBCLefOgKl1bfsBdFxw1tLrUONDmmODKjn8fx/DzBWva/SG4G6a5XsN4NkuMS1hLg==
X-Received: by 2002:aca:916:: with SMTP id 22mr3626010oij.66.1618933362360;
 Tue, 20 Apr 2021 08:42:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a73sm2369719oib.23.2021.04.20.08.42.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 20 Apr 2021 08:42:41 -0700 (PDT)
Date: Tue, 20 Apr 2021 08:42:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] virtio-net: fix use-after-free in page_to_skb()
Message-ID: <20210420154240.GA115350@roeck-us.net>
References: <20210420094341.3259328-1-eric.dumazet@gmail.com>
 <c5a8aeaf-0f41-9274-b9c5-ec385b34180a@roeck-us.net>
 <CANn89iKMbUtDhU+B5dFJDABUSJJ3rnN0PWO0TDY=mRYEbNpHZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANn89iKMbUtDhU+B5dFJDABUSJJ3rnN0PWO0TDY=mRYEbNpHZw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 virtualization@lists.linux-foundation.org, syzbot <syzkaller@googlegroups.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>
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

On Tue, Apr 20, 2021 at 04:00:07PM +0200, Eric Dumazet wrote:
> On Tue, Apr 20, 2021 at 3:48 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 4/20/21 2:43 AM, Eric Dumazet wrote:
> 
> > >
> >
> > Unfortunately that doesn't fix the problem for me. With this patch applied
> > on top of next-20210419, I still get the same crash as before:
> >
> > udhcpc: sending discover^M
> > Unable to handle kernel paging request at virtual address 0000000000000004^M
> > udhcpc(169): Oops -1^M
> > pc = [<0000000000000004>]  ra = [<fffffc0000b8c5b8>]  ps = 0000    Not tainted^M
> > pc is at 0x4^M
> > ra is at napi_gro_receive+0x68/0x150^M
> > v0 = 0000000000000000  t0 = 0000000000000008  t1 = 0000000000000000^M
> > t2 = 0000000000000000  t3 = 000000000000000e  t4 = 0000000000000038^M
> > t5 = 000000000000ffff  t6 = fffffc00002f298a  t7 = fffffc0002c78000^M
> > s0 = fffffc00010b3ca0  s1 = 0000000000000000  s2 = fffffc00011267e0^M
> > s3 = 0000000000000000  s4 = fffffc00025f2008  s5 = fffffc00002f2940^M
> > s6 = fffffc00025f2040^M
> > a0 = fffffc00025f2008  a1 = fffffc00002f2940  a2 = fffffc0002ca000c^M
> > a3 = fffffc00000250d0  a4 = 0000000effff0008  a5 = 0000000000000000^M
> > t8 = fffffc00010b3c80  t9 = fffffc0002ca04cc  t10= 0000000000000000^M
> > t11= 00000000000004c0  pv = fffffc0000b8bc40  at = 0000000000000000^M
> > gp = fffffc00010f9fb8  sp = 00000000df74db09^M
> > Disabling lock debugging due to kernel taint^M
> > Trace:^M
> > [<fffffc0000b8c5b8>] napi_gro_receive+0x68/0x150^M
> > [<fffffc00009b409c>] receive_buf+0x50c/0x1b80^M
> > [<fffffc00009b58b8>] virtnet_poll+0x1a8/0x5b0^M
> > [<fffffc00009b58ec>] virtnet_poll+0x1dc/0x5b0^M
> > [<fffffc0000b8d17c>] __napi_poll+0x4c/0x270^M
> > [<fffffc0000b8d670>] net_rx_action+0x130/0x2c0^M
> > [<fffffc0000bd6cb0>] sch_direct_xmit+0x170/0x360^M
> > [<fffffc0000bd7000>] __qdisc_run+0x160/0x6c0^M
> > [<fffffc0000337b64>] do_softirq+0xa4/0xd0^M
> > [<fffffc0000337ca4>] __local_bh_enable_ip+0x114/0x120^M
> > [<fffffc0000b89554>] __dev_queue_xmit+0x484/0xa60^M
> > [<fffffc0000cd072c>] packet_sendmsg+0xe7c/0x1ba0^M
> > [<fffffc0000b53338>] __sys_sendto+0xf8/0x170^M
> > [<fffffc0000cfec18>] _raw_spin_unlock+0x18/0x30^M
> > [<fffffc0000a9bf7c>] ehci_irq+0x2cc/0x5c0^M
> > [<fffffc0000a71334>] usb_hcd_irq+0x34/0x50^M
> > [<fffffc0000b521bc>] move_addr_to_kernel+0x3c/0x60^M
> > [<fffffc0000b532e4>] __sys_sendto+0xa4/0x170^M
> > [<fffffc0000b533d4>] sys_sendto+0x24/0x40^M
> > [<fffffc0000cfea38>] _raw_spin_lock+0x18/0x30^M
> > [<fffffc0000cfec18>] _raw_spin_unlock+0x18/0x30^M
> > [<fffffc0000325298>] clipper_enable_irq+0x98/0x100^M
> > [<fffffc0000cfec18>] _raw_spin_unlock+0x18/0x30^M
> > [<fffffc0000311514>] entSys+0xa4/0xc0^M
> 
> OK, it would be nice if you could get line number from this stack trace.
> 

Here you are:

napi_gro_receive (net/core/dev.c:6196)
receive_buf (drivers/net/virtio_net.c:1150)
virtnet_poll (drivers/net/virtio_net.c:1414 drivers/net/virtio_net.c:1519)
clipper_srm_device_interrupt (arch/alpha/kernel/sys_dp264.c:256)
virtnet_poll (drivers/net/virtio_net.c:1413 drivers/net/virtio_net.c:1519)
__napi_poll (net/core/dev.c:6962)
net_rx_action (net/core/dev.c:7029 net/core/dev.c:7116)
__qdisc_run (net/sched/sch_generic.c:376 net/sched/sch_generic.c:384)
do_softirq (./include/asm-generic/softirq_stack.h:10 kernel/softirq.c:460 kernel/softirq.c:447)
__local_bh_enable_ip (kernel/softirq.c:384)
__dev_queue_xmit (./include/linux/bottom_half.h:32 ./include/linux/rcupdate.h:746 net/core/dev.c:4272)
packet_sendmsg (net/packet/af_packet.c:3009 net/packet/af_packet.c:3034)
__sys_sendto (net/socket.c:654 net/socket.c:674 net/socket.c:1977)
__d_alloc (fs/dcache.c:1744)
packet_create (net/packet/af_packet.c:1192 net/packet/af_packet.c:3296)
move_addr_to_kernel (./include/linux/uaccess.h:192 net/socket.c:198 net/socket.c:192)
__sys_sendto (net/socket.c:1968)
sys_sendto (net/socket.c:1989 net/socket.c:1985)
sys_bind (net/socket.c:1648 net/socket.c:1646)
entSys (arch/alpha/kernel/entry.S:477)

Guenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
