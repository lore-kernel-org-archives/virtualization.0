Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D9EC54EE9
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 22:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CFF34091A;
	Tue, 27 Sep 2022 22:20:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CFF34091A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jK7QVrku
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9iYC-skUegPy; Tue, 27 Sep 2022 22:20:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F32540918;
	Tue, 27 Sep 2022 22:20:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F32540918
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14D37C0033;
	Tue, 27 Sep 2022 22:20:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09D06C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E57B780F5D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E57B780F5D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jK7QVrku
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id smgcMdVFP3dg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:20:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B822981498
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B822981498
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664317228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7hn20Zeqkcubja41/WChKWpPqLMVS3GAmGLnKHDhAU=;
 b=jK7QVrkugy/c8vquSglbIXga7Gf3M45j/e0biiTjoMeTG7Zdkl/guT9Y9INb+kgQGXX4P9
 0nXPytHLTHzIcrMMiYHn1KVhBJ2a67gzAzMtBPQLozeGZQEwHkjkJ3iFIE0Kq+7W9S+Ya5
 qCNmF+2e07Zo2EYEhQJjP5emgiGiF6I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-_4kUxRF8OXq6OVT4nn62ug-1; Tue, 27 Sep 2022 18:20:27 -0400
X-MC-Unique: _4kUxRF8OXq6OVT4nn62ug-1
Received: by mail-wm1-f72.google.com with SMTP id
 h133-20020a1c218b000000b003b3263d477eso6148325wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 15:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=B7hn20Zeqkcubja41/WChKWpPqLMVS3GAmGLnKHDhAU=;
 b=MZ/TstmueGNSBmhKINS2QlbCpGqgTvXx8+48tmooy31FVHWstKiksgFNtui/5Kk+Tz
 FvNfrMDRoYjyzKJnCwJwjaQxjri7sjEM7G9Leyb2HHDXrU9JX2zgC82+UhyA9zGWcjqG
 VoTpo8tgoSuTFSNC3CvBecQO2IzMvJ/2FJdkrqQ+pqfgvXPhRdUJpIREgxeAFNrlBMtV
 Pp/reiYj8raaCHJ3w3+5NoH/XeeKNg22WlZXmLkXC+im1RbmsePfsaJCQ4lQHPOz3jWV
 MBxZZM+ZpsfIZs22crDwOJsB9pS6+neulx0KqJUxyFrmYwmCluph4BP4hi3NS5xXJqfR
 z2Vw==
X-Gm-Message-State: ACrzQf3NixFlb9qRm4T3A/d/Q9uV0i1HA84EmL1I0qBg01XXvW1fBUzJ
 wepM25CtFLnrnqdlGXoem8WGAsiFaVKivcAZSvPG9NnDNOtENkGHsNhjTELVAH/JgkrRh1DV2Y5
 RRJVjyJUqwU9bBDrKY66YvU8YU8OgmwKa7hiNBjAfBQ==
X-Received: by 2002:a05:6000:1d9d:b0:22a:745b:9f00 with SMTP id
 bk29-20020a0560001d9d00b0022a745b9f00mr18158791wrb.280.1664317226254; 
 Tue, 27 Sep 2022 15:20:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6oB7tbkGtVRI3gvZ8k+SQXcKmBMF8mKtNbT7iyUkMcWoAG8FRHgS74kE0f7DBUAGmZvRbnXA==
X-Received: by 2002:a05:6000:1d9d:b0:22a:745b:9f00 with SMTP id
 bk29-20020a0560001d9d00b0022a745b9f00mr18158769wrb.280.1664317225999; 
 Tue, 27 Sep 2022 15:20:25 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 i1-20020a5d4381000000b002205cbc1c74sm2663721wrq.101.2022.09.27.15.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 15:20:25 -0700 (PDT)
Date: Tue, 27 Sep 2022 18:20:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+0cb3309ee74d3c0c431c@syzkaller.appspotmail.com>
Subject: Re: [syzbot] usb-testing boot error: BUG: unable to handle kernel
 paging request in virtnet_set_affinity
Message-ID: <20220927181950-mutt-send-email-mst@kernel.org>
References: <0000000000008d61ee05e6d9bb0a@google.com>
MIME-Version: 1.0
In-Reply-To: <0000000000008d61ee05e6d9bb0a@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: hawk@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 edumazet@google.com, hch@lst.de, kuba@kernel.org, bpf@vger.kernel.org,
 pabeni@redhat.com, virtualization@lists.linux-foundation.org,
 davem@davemloft.net
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

On Mon, Aug 22, 2022 at 12:48:32PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ad57410d231d usb: gadget: rndis: use %u instead of %d to p..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=17472b85080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=0cb3309ee74d3c0c431c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0cb3309ee74d3c0c431c@syzkaller.appspotmail.com
> 
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> software IO TLB: mapped [mem 0x00000000bbffd000-0x00000000bfffd000] (64MB)
> RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
> clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb6feccdd0, max_idle_ns: 440795259471 ns
> clocksource: Switched to clocksource tsc
> Initialise system trusted keyrings
> workingset: timestamp_bits=40 max_order=21 bucket_order=0
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
> 9p: Installing v9fs 9p2000 file system support
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> io scheduler mq-deadline registered
> io scheduler kyber registered
> usbcore: registered new interface driver udlfb
> usbcore: registered new interface driver smscufx
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> ACPI: button: Power Button [PWRF]
> input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> ACPI: button: Sleep Button [SLPF]
> ACPI: \_SB_.LNKC: Enabled at IRQ 11
> virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> ACPI: \_SB_.LNKD: Enabled at IRQ 10
> virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> ACPI: \_SB_.LNKB: Enabled at IRQ 10
> virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
> virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
> 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> Non-volatile memory driver v1.3
> Linux agpgart interface v0.103
> ACPI: bus type drm_connector registered
> usbcore: registered new interface driver udl
> loop: module loaded
> usbcore: registered new interface driver rtsx_usb
> usbcore: registered new interface driver viperboard
> usbcore: registered new interface driver dln2
> usbcore: registered new interface driver pn533_usb
> usbcore: registered new interface driver port100
> usbcore: registered new interface driver nfcmrvl
> scsi host0: Virtio SCSI HBA
> scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
> sd 0:0:1:0: Attached scsi generic sg0 type 0
> Rounding down aligned max_sectors from 4294967295 to 4294967288
> db_root: cannot open: /etc/target
> BUG: unable to handle page fault for address: ffffdc0000000000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 100026067 P4D 100026067 PUD 0 
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-syzkaller-00005-gad57410d231d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> RIP: 0010:virtnet_set_affinity+0x2e4/0x600 drivers/net/virtio_net.c:2303
> Code: e8 03 42 80 3c 30 00 0f 85 de 02 00 00 48 8b 44 24 10 48 8d 1c 80 48 8b 44 24 18 48 c1 e3 08 48 03 58 20 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 a9 02 00 00 4c 8b 23 49 8d 7c 24 20 48 89 f8
> RSP: 0000:ffffc9000001f980 EFLAGS: 00010a06
> RAX: 1fffe00000000000 RBX: ffff000000000000 RCX: 0000000000000000
> RDX: ffff8881002a8000 RSI: ffffffff82fd75e3 RDI: 0000000000000004
> RBP: 0000000000000001 R08: 0000000000000004 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc9000001f9f8
> FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffdc0000000000 CR3: 0000000007825000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  init_vqs drivers/net/virtio_net.c:3611 [inline]
>  init_vqs drivers/net/virtio_net.c:3597 [inline]
>  virtnet_probe+0x11ed/0x30f0 drivers/net/virtio_net.c:3904
>  virtio_dev_probe+0x577/0x870 drivers/virtio/virtio.c:305
>  call_driver_probe drivers/base/dd.c:530 [inline]
>  really_probe+0x249/0xb90 drivers/base/dd.c:609
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:748
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
>  __driver_attach+0x223/0x550 drivers/base/dd.c:1150
>  bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
>  bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
>  driver_register+0x220/0x3a0 drivers/base/driver.c:240
>  virtio_net_driver_init+0x93/0xd2 drivers/net/virtio_net.c:4108
>  do_one_initcall+0xfe/0x650 init/main.c:1296
>  do_initcall_level init/main.c:1369 [inline]
>  do_initcalls init/main.c:1385 [inline]
>  do_basic_setup init/main.c:1404 [inline]
>  kernel_init_freeable+0x6ac/0x735 init/main.c:1611
>  kernel_init+0x1a/0x1d0 init/main.c:1500
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
> Modules linked in:
> CR2: ffffdc0000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:virtnet_set_affinity+0x2e4/0x600 drivers/net/virtio_net.c:2303


So this is not new it turns out.  Was on vacation and missed it.

> Code: e8 03 42 80 3c 30 00 0f 85 de 02 00 00 48 8b 44 24 10 48 8d 1c 80 48 8b 44 24 18 48 c1 e3 08 48 03 58 20 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 a9 02 00 00 4c 8b 23 49 8d 7c 24 20 48 89 f8
> RSP: 0000:ffffc9000001f980 EFLAGS: 00010a06
> RAX: 1fffe00000000000 RBX: ffff000000000000 RCX: 0000000000000000
> RDX: ffff8881002a8000 RSI: ffffffff82fd75e3 RDI: 0000000000000004
> RBP: 0000000000000001 R08: 0000000000000004 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc9000001f9f8
> FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffdc0000000000 CR3: 0000000007825000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	e8 03 42 80 3c       	callq  0x3c804208
>    5:	30 00                	xor    %al,(%rax)
>    7:	0f 85 de 02 00 00    	jne    0x2eb
>    d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
>   12:	48 8d 1c 80          	lea    (%rax,%rax,4),%rbx
>   16:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
>   1b:	48 c1 e3 08          	shl    $0x8,%rbx
>   1f:	48 03 58 20          	add    0x20(%rax),%rbx
>   23:	48 89 d8             	mov    %rbx,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
>   2f:	0f 85 a9 02 00 00    	jne    0x2de
>   35:	4c 8b 23             	mov    (%rbx),%r12
>   38:	49 8d 7c 24 20       	lea    0x20(%r12),%rdi
>   3d:	48 89 f8             	mov    %rdi,%rax
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
