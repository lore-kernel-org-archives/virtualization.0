Return-Path: <SRS0=Cini=I5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E4FC433C1
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 10:50:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5C16198F
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 10:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5C16198F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F28084097;
	Wed, 31 Mar 2021 10:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 45xEfgt0hjRf; Wed, 31 Mar 2021 10:50:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF87684065;
	Wed, 31 Mar 2021 10:50:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7C54C000C;
	Wed, 31 Mar 2021 10:50:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48C17C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 10:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FED6405AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 10:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aO4gnFLLZ63i
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 10:50:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5E51405AD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617187840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K86fwwRt3x+/sobik8nvlY4HBVdEdJ4URAAUvyRr474=;
 b=fbQn4MdVH41pEm5dRaZd2+Zt+9nFVCLRJg/TgREkNXBJj+ikJny1pbRCZ7XaE2DhI7wYgL
 CSyP3TunJFSAN3mlluUiLW+H2pY6VDKZD+4hoySgR+Vw+jECSRGN/sU0ZSVR4YqrPg5tPU
 m7T1ZLrSKNThobH0Q7y92/CmSwwqzk8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-MN6rumjKOZuCfg3G1hCJVw-1; Wed, 31 Mar 2021 06:50:37 -0400
X-MC-Unique: MN6rumjKOZuCfg3G1hCJVw-1
Received: by mail-wr1-f69.google.com with SMTP id o11so801392wrc.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 03:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K86fwwRt3x+/sobik8nvlY4HBVdEdJ4URAAUvyRr474=;
 b=PWxY7hEM/zxhIhaIVY0O+D1Ju2pWSa2rdc+F97L2Tfp7wRYICyRsWZMvuY4Cx0Onkg
 UaDimJrDoXHzAdmgaj6QTH6l+Eu2fk3xHbAp7x1Q++Fr5SJXeehxDnXnNV76hc6M42Hj
 kQyFKvRAg0aWQBijuAJSrStAuev5NMv24tqZErBuKbKoLYHYzCfvmpXtIlKAmGCqi0ii
 WbBe2NtSwAh6fxEL8hF3WGInkzpr6Huwnr8o0FEy34Ay4/lwyOxIFrpCa/+GHoJKXnAh
 pQxDRpR64C2Vibnx/ToumO0PWrgP2nepOIqWP5dhR7wthiaBPAETIBXGVXNS3YiGYSUn
 MQUw==
X-Gm-Message-State: AOAM531N9RxSvDASX4BhnbSfWdl/nR+C/G4RMrbSTVNdrJFpnVLgSiU5
 6vL2Z4AKA5OIhGQqjsVtVTM8vA7ETAOJwj0Lbmq57GH7SYGMuj/feQsiocjOCF+4TcoIghNdktf
 eKKQBhIJp393d1qZWUUZBvXXriluzvvVosMft6lj0nw==
X-Received: by 2002:adf:f3cf:: with SMTP id g15mr2983977wrp.57.1617187836186; 
 Wed, 31 Mar 2021 03:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIC8/Tr16sPK/2ZAP1ZkJs01IWqyNA+wZvds0fSxxtRjJOG5bN9sU4mEiY6qpT7l8bVZX1Gg==
X-Received: by 2002:adf:f3cf:: with SMTP id g15mr2983871wrp.57.1617187834744; 
 Wed, 31 Mar 2021 03:50:34 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id a13sm3588406wrp.31.2021.03.31.03.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 03:50:34 -0700 (PDT)
Date: Wed, 31 Mar 2021 12:50:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: memory leak in virtio_transport_send_pkt_info
Message-ID: <20210331105031.ewh4cq2xfe3pcn2v@steredhat>
References: <00000000000069a2e905bad5d02e@google.com>
 <YGQ7EhQ+hlSUdf1C@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YGQ7EhQ+hlSUdf1C@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot <syzbot+24452624fc4c571eedd9@syzkaller.appspotmail.com>,
 kvm@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org, davem@davemloft.net
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 31, 2021 at 10:04:18AM +0100, Stefan Hajnoczi wrote:
>On Mon, Feb 08, 2021 at 08:39:30AM -0800, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    9f29bd8b Merge tag 'fs_for_v5.11-rc5' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11e435af500000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=162a0109d6ff731f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=24452624fc4c571eedd9
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135dd494d00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128787e7500000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+24452624fc4c571eedd9@syzkaller.appspotmail.com
>
>Hi Stefano,
>Looks like tx packets are still queued when the syzkaller leak check
>runs. I don't see a fix for this in linux.git. Have you already looked
>at this?

I missed this report.
Looking at the reproducer it seems to happen when we send a message to a 
socket not yet accept()ed.

I'll take a closer look over the next few days, thanks for bringing it 
up.

Stefano

>
>Stefan
>
>>
>> executing program
>> BUG: memory leak
>> unreferenced object 0xffff88811477d380 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 26.670s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d280 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 26.670s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d200 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 26.670s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d180 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 26.670s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d380 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.040s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d280 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.040s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d200 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.040s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d180 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.040s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d380 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.100s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d280 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.100s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d200 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.100s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d180 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.100s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d380 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.160s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d280 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.160s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d200 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.160s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d180 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.160s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d380 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.230s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d280 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.230s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d200 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.230s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d180 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.230s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d380 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.290s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d280 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.290s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d200 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.290s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811477d180 (size 96):
>>   comm "syz-executor196", pid 8793, jiffies 4294968272 (age 29.290s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
>>     ba 34 8c fe 00 00 00 00 00 00 01 00 01 00 05 00  .4..............
>>   backtrace:
>>     [<0000000051681be3>] kmalloc include/linux/slab.h:552 [inline]
>>     [<0000000051681be3>] kzalloc include/linux/slab.h:682 [inline]
>>     [<0000000051681be3>] virtio_transport_alloc_pkt+0x41/0x290 net/vmw_vsock/virtio_transport_common.c:51
>>     [<0000000036c2d6e6>] virtio_transport_send_pkt_info+0x105/0x1b0 net/vmw_vsock/virtio_transport_common.c:209
>>     [<00000000dd27435f>] virtio_transport_stream_enqueue+0x58/0x80 net/vmw_vsock/virtio_transport_common.c:674
>>     [<00000000d7e8274a>] vsock_stream_sendmsg+0x4f7/0x590 net/vmw_vsock/af_vsock.c:1800
>>     [<00000000d2b531e6>] sock_sendmsg_nosec net/socket.c:652 [inline]
>>     [<00000000d2b531e6>] sock_sendmsg+0x56/0x80 net/socket.c:672
>>     [<00000000803a63df>] ____sys_sendmsg+0x17a/0x390 net/socket.c:2345
>>     [<000000009d42f642>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2399
>>     [<000000000a37ed0e>] __sys_sendmmsg+0xed/0x290 net/socket.c:2489
>>     [<00000000324c1c73>] __do_sys_sendmmsg net/socket.c:2518 [inline]
>>     [<00000000324c1c73>] __se_sys_sendmmsg net/socket.c:2515 [inline]
>>     [<00000000324c1c73>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2515
>>     [<000000004e7b2960>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>     [<000000002615f594>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> executing program
>> executing program
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>>



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

