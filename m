Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F28C43219
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 09:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 701EB6123D;
	Fri, 14 Oct 2022 09:41:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 701EB6123D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E7ap9B8/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NPuukF_78Nrk; Fri, 14 Oct 2022 09:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CAA6E61236;
	Fri, 14 Oct 2022 09:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAA6E61236
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB97C0033;
	Fri, 14 Oct 2022 09:41:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 323F9C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 044D842233
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 044D842233
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E7ap9B8/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NaOEafSPSChR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:41:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7792B4223C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7792B4223C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665740493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wKlR+CcE/XKB9cJEzU9OvSSq3ilgCUyh56aB2R9hIbY=;
 b=E7ap9B8/wQiRoLT+tT5M07d9+drxqI5u/Cm9RrzYa0EefB8WSOgYKPQnHfQpauSH+6qKBY
 NWYsPNcEMzQDp5+RmPUwRFF+XIhSTWSkMr7VthjjOLSdV2gp35Ht4c9xT7hVsmNBujjatS
 sZwcotRVbvbzD9fXqEmkzrVaYwZM2tI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-216-zRY9vG0eM0asGMem-omrLA-1; Fri, 14 Oct 2022 05:41:30 -0400
X-MC-Unique: zRY9vG0eM0asGMem-omrLA-1
Received: by mail-wm1-f72.google.com with SMTP id
 v23-20020a1cf717000000b003bff630f31aso1922085wmh.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 02:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKlR+CcE/XKB9cJEzU9OvSSq3ilgCUyh56aB2R9hIbY=;
 b=Ttid2nIV6CfmjriyiVqIa9WVvXS8WTo/FejGZI7PB/fLR8GFJVLHEQZQX0qAOFTXrU
 PuhMSh1y++zS3yge3f9ihJ836bJYfVLeIUVF2Se7P25iYYnSxScXHQK3+kHhGQHJGm6t
 0D3xWuEGlZYfB1M4jaAMRmBpYJxLmSynHUPHGZiYgUug5B6yyGnaJEqpvGLwrgHAYLE0
 8M+yizADVp0euGw+2EIqfpPhBaIHIQ9TlKGdGFQhE7PkJo4m5NviOoGGPgoQKUC/lJLT
 oV68RFL9AtIEDqoNyvib8Q+D2fST2Q882RLtmXGDFZjfv77hJM0SZHMOkDuLas/uVye7
 x3WA==
X-Gm-Message-State: ACrzQf0btXdE615ayKBtU9DrgiR3nRUt5flD6iw+8f5yvFBs2YQQC9Gb
 bkwHF76lstpcJjRRgx5fDpi4cs7fFcuRxEFSnU7W9H9xjoQawjK4HKXDyj6Zc5wrd9UT69aQk7B
 FfXqJA4OnBfrVpHPLLSRZ+Is0QZbZW+nkoQNQrRC75A==
X-Received: by 2002:a05:600c:358f:b0:3c6:da94:66f9 with SMTP id
 p15-20020a05600c358f00b003c6da9466f9mr2762406wmq.142.1665740488798; 
 Fri, 14 Oct 2022 02:41:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6w3cEiR6rQvgkTTtlNrYW5Q7DNktZGWlaya7vja/FrE/eQqGE4HHUEag6zb93Od1CS7LyiTg==
X-Received: by 2002:a05:600c:358f:b0:3c6:da94:66f9 with SMTP id
 p15-20020a05600c358f00b003c6da9466f9mr2762380wmq.142.1665740488423; 
 Fri, 14 Oct 2022 02:41:28 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 d5-20020adfe845000000b0022b1d74dc56sm1510165wrn.79.2022.10.14.02.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 02:41:27 -0700 (PDT)
Date: Fri, 14 Oct 2022 05:41:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+28ec239d5c21a2d91f3d@syzkaller.appspotmail.com>
Subject: Re: [syzbot] usb-testing boot error: WARNING in cpumask_next_wrap
Message-ID: <20221014054043-mutt-send-email-mst@kernel.org>
References: <0000000000001207f205ead6dc09@google.com>
MIME-Version: 1.0
In-Reply-To: <0000000000001207f205ead6dc09@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: hawk@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 edumazet@google.com, kuba@kernel.org, bpf@vger.kernel.org, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, davem@davemloft.net
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

On Wed, Oct 12, 2022 at 07:03:39AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    49da07006239 Merge tag 'memblock-v6.1-rc1' of git://git.ke..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=1361eb1a880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8be1ac10ff2d4692
> dashboard link: https://syzkaller.appspot.com/bug?extid=28ec239d5c21a2d91f3d
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d41d7d5418ab/disk-49da0700.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9ffb9548d913/vmlinux-49da0700.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+28ec239d5c21a2d91f3d@syzkaller.appspotmail.com


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git b0d0538b9a8c47da2e3fb2ee44cd3dacc75509a6


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
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at include/linux/cpumask.h:110 cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
> WARNING: CPU: 1 PID: 1 at include/linux/cpumask.h:110 cpumask_check include/linux/cpumask.h:117 [inline]
> WARNING: CPU: 1 PID: 1 at include/linux/cpumask.h:110 cpumask_next include/linux/cpumask.h:178 [inline]
> WARNING: CPU: 1 PID: 1 at include/linux/cpumask.h:110 cpumask_next_wrap+0x139/0x1d0 lib/cpumask.c:27
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-syzkaller-11414-g49da07006239 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
> RIP: 0010:cpumask_check include/linux/cpumask.h:117 [inline]
> RIP: 0010:cpumask_next include/linux/cpumask.h:178 [inline]
> RIP: 0010:cpumask_next_wrap+0x139/0x1d0 lib/cpumask.c:27
> Code: df e8 6b 9e 80 fb 39 eb 77 64 e8 12 a2 80 fb 41 8d 6c 24 01 89 de 89 ef e8 54 9e 80 fb 39 dd 0f 82 54 ff ff ff e8 f7 a1 80 fb <0f> 0b e9 48 ff ff ff e8 eb a1 80 fb 48 c7 c2 80 dc e3 88 48 b8 00
> RSP: 0000:ffffc9000001f920 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
> RDX: ffff8881002b0000 RSI: ffffffff85c61b89 RDI: 0000000000000004
> RBP: 0000000000000002 R08: 0000000000000004 R09: 0000000000000002
> R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000002 R15: ffffffff88e3da90
> FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000007825000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  virtnet_set_affinity+0x35a/0x750 drivers/net/virtio_net.c:2303
>  init_vqs drivers/net/virtio_net.c:3581 [inline]
>  init_vqs drivers/net/virtio_net.c:3567 [inline]
>  virtnet_probe+0x12ae/0x33a0 drivers/net/virtio_net.c:3884
>  virtio_dev_probe+0x577/0x870 drivers/virtio/virtio.c:305
>  call_driver_probe drivers/base/dd.c:560 [inline]
>  really_probe+0x249/0xb90 drivers/base/dd.c:639
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
>  __driver_attach+0x1d0/0x550 drivers/base/dd.c:1190
>  bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
>  bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
>  driver_register+0x220/0x3a0 drivers/base/driver.c:246
>  virtio_net_driver_init+0x93/0xd2 drivers/net/virtio_net.c:4090
>  do_one_initcall+0x13d/0x780 init/main.c:1303
>  do_initcall_level init/main.c:1376 [inline]
>  do_initcalls init/main.c:1392 [inline]
>  do_basic_setup init/main.c:1411 [inline]
>  kernel_init_freeable+0x6fa/0x783 init/main.c:1631
>  kernel_init+0x1a/0x1d0 init/main.c:1519
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
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
