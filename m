Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA789C07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 22:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8371E60AE6;
	Tue, 27 Sep 2022 22:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8371E60AE6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gMTwnWsU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HlkmxKNHHvUb; Tue, 27 Sep 2022 22:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF99A60ADE;
	Tue, 27 Sep 2022 22:19:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF99A60ADE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAC5FC0033;
	Tue, 27 Sep 2022 22:19:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAF94C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6CB74088E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:19:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6CB74088E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gMTwnWsU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DM87lr6IsY5K
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13A5D40350
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13A5D40350
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664317157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sPkv0tXRBGRFHsPE4skY8laZ5MwDJA/XEqh88B2Acpo=;
 b=gMTwnWsUCSfmLIhaxYsB9FqoYTzmb84Q+aXWw09dVkDgXItsGvIzlA/kpjyKDTXkiF5ys8
 Q8bcpByNlXzLZC1N4KM/mYL0VRQFh/BTLr6FAl0gu9wdnZXWbU4f9Xw94hTVWrs+YNbKG4
 xV/8zfwOC5y9inBYITZ6a8U6nN6Jqs8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-YrdCrvpmOP2dE685NnhmsA-1; Tue, 27 Sep 2022 18:19:17 -0400
X-MC-Unique: YrdCrvpmOP2dE685NnhmsA-1
Received: by mail-wm1-f71.google.com with SMTP id
 h187-20020a1c21c4000000b003b51369ff1bso40831wmh.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 15:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=sPkv0tXRBGRFHsPE4skY8laZ5MwDJA/XEqh88B2Acpo=;
 b=CJDxyyT3gdSaLtoqVLO+GSJ3lZGBGtZKajab4OXjvBuJVHsMritp0YE8ZP5zpSOU0g
 f94mla3H6fuTZxR7HRQlLJ15a5uzBMArB9ME/d07lSzMsL0NFqVhqc6w3cmTjl7g26Bf
 gLyTyXZD6WmKu8gQY3MZR6kS3TQFjp380MFaZ0/0YgkghJDSbf9qnt2WxfGXbsbfYaGi
 NKQiBrRMGmO1FbDGlAVlRCfMk0R9BDlTcNEaUQ55Xg/eIcKRa3McmJYN4RNb5YrbUEvv
 lEjb4JPC22I6Vsm7M3p9teA7JaDLwaleTuoxYJLEDCeB77/aPmpVYXNb3iUZalW2qhjT
 UlJQ==
X-Gm-Message-State: ACrzQf1/BQS+WIVWCKx96q08AYAayLuFDc2voO2e2zoqHby+dGpm4Re8
 eHOvMAgoEgcmuP5BzYCrOu04V+NUXz2sDqFMOAm+vZjJvGeegNxRNu8vfIfNHk5zxISF9hGzrKq
 X16AeqLtS0J2FdY95wRm9gTxqqr7saNCF3aF9BRMn9Q==
X-Received: by 2002:a7b:cb49:0:b0:3b4:b08a:89b with SMTP id
 v9-20020a7bcb49000000b003b4b08a089bmr4264616wmj.173.1664317152715; 
 Tue, 27 Sep 2022 15:19:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4yVAuON4IWBfCSPhgaypPYe4TWmLMMFvQJVnsSDJhPqJfgdzcdmJoPl9f9OuBfTy70adiwkA==
X-Received: by 2002:a7b:cb49:0:b0:3b4:b08a:89b with SMTP id
 v9-20020a7bcb49000000b003b4b08a089bmr4264604wmj.173.1664317152467; 
 Tue, 27 Sep 2022 15:19:12 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 d37-20020a05600c4c2500b003b332a7b898sm2561817wmp.45.2022.09.27.15.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 15:19:11 -0700 (PDT)
Date: Tue, 27 Sep 2022 18:19:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+21da700f3c9f0bc40150@syzkaller.appspotmail.com>
Subject: Re: [syzbot] linux-next boot error: WARNING in cpumask_next_wrap
Message-ID: <20220927181728-mutt-send-email-mst@kernel.org>
References: <000000000000dfa4f105e9af8c54@google.com>
MIME-Version: 1.0
In-Reply-To: <000000000000dfa4f105e9af8c54@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: sfr@canb.auug.org.au, hawk@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 edumazet@google.com, linux-next@vger.kernel.org, hch@lst.de, kuba@kernel.org,
 bpf@vger.kernel.org, pabeni@redhat.com,
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

On Tue, Sep 27, 2022 at 02:44:35PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1bd8b75fe6ad Add linux-next specific files for 20220927
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=109d3404880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fab8618a7c989c9d
> dashboard link: https://syzkaller.appspot.com/bug?extid=21da700f3c9f0bc40150
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b150a04debdc/disk-1bd8b75f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2bf7d4b812bc/vmlinux-1bd8b75f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+21da700f3c9f0bc40150@syzkaller.appspotmail.com
> 
> ACPI: button: Sleep Button [SLPF]
> ACPI: \_SB_.LNKC: Enabled at IRQ 11
> virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> ACPI: \_SB_.LNKD: Enabled at IRQ 10
> virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> ACPI: \_SB_.LNKB: Enabled at IRQ 10
> virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
> virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
> N_HDLC line discipline registered with maxframe=4096
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
> 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> Non-volatile memory driver v1.3
> Linux agpgart interface v0.103
> ACPI: bus type drm_connector registered
> [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
> [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
> Console: switching to colour frame buffer device 128x48
> platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
> usbcore: registered new interface driver udl
> brd: module loaded
> loop: module loaded
> zram: Added device: zram0
> null_blk: disk nullb0 created
> null_blk: module loaded
> Guest personality initialized and is inactive
> VMCI host device registered (name=vmci, major=10, minor=119)
> Initialized host personality
> usbcore: registered new interface driver rtsx_usb
> usbcore: registered new interface driver viperboard
> usbcore: registered new interface driver dln2
> usbcore: registered new interface driver pn533_usb
> nfcsim 0.2 initialized
> usbcore: registered new interface driver port100
> usbcore: registered new interface driver nfcmrvl
> Loading iSCSI transport class v2.0-870.
> scsi host0: Virtio SCSI HBA
> st: Version 20160209, fixed bufsize 32768, s/g segs 256
> Rounding down aligned max_sectors from 4294967295 to 4294967288
> db_root: cannot open: /etc/target
> slram: not enough parameters.
> ftl_cs: FTL header not found.
> wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
> wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
> MACsec IEEE 802.1AE
> tun: Universal TUN/TAP device driver, 1.6
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at include/linux/cpumask.h:110 cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
> WARNING: CPU: 0 PID: 1 at include/linux/cpumask.h:110 cpumask_check include/linux/cpumask.h:117 [inline]
> WARNING: CPU: 0 PID: 1 at include/linux/cpumask.h:110 cpumask_next include/linux/cpumask.h:178 [inline]
> WARNING: CPU: 0 PID: 1 at include/linux/cpumask.h:110 cpumask_next_wrap+0x139/0x1d0 lib/cpumask.c:27
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc7-next-20220927-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
> RIP: 0010:cpumask_check include/linux/cpumask.h:117 [inline]
> RIP: 0010:cpumask_next include/linux/cpumask.h:178 [inline]
> RIP: 0010:cpumask_next_wrap+0x139/0x1d0 lib/cpumask.c:27
> Code: df e8 1b 07 3e f8 39 eb 77 64 e8 c2 0a 3e f8 41 8d 6c 24 01 89 de 89 ef e8 04 07 3e f8 39 dd 0f 82 54 ff ff ff e8 a7 0a 3e f8 <0f> 0b e9 48 ff ff ff e8 9b 0a 3e f8 48 c7 c2 00 ae e1 8d 48 b8 00
> RSP: 0000:ffffc90000067920 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
> RDX: ffff88813fe50000 RSI: ffffffff893e3c59 RDI: 0000000000000004
> RBP: 0000000000000002 R08: 0000000000000004 R09: 0000000000000002
> R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000002 R15: ffffffff8de1ac10
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  virtnet_set_affinity+0x35a/0x750 drivers/net/virtio_net.c:2300



Also related to affinity things?
I wonder what does virtio do wrong?


>  init_vqs drivers/net/virtio_net.c:3578 [inline]
>  init_vqs drivers/net/virtio_net.c:3564 [inline]
>  virtnet_probe+0x110f/0x2ea0 drivers/net/virtio_net.c:3868
>  virtio_dev_probe+0x577/0x870 drivers/virtio/virtio.c:305
>  call_driver_probe drivers/base/dd.c:560 [inline]
>  really_probe+0x249/0xb90 drivers/base/dd.c:639
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
>  __driver_attach+0x1d0/0x550 drivers/base/dd.c:1190
>  bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
>  bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
>  driver_register+0x220/0x3a0 drivers/base/driver.c:246
>  virtio_net_driver_init+0x93/0xd2 drivers/net/virtio_net.c:4074
>  do_one_initcall+0x13d/0x780 init/main.c:1306
>  do_initcall_level init/main.c:1381 [inline]
>  do_initcalls init/main.c:1397 [inline]
>  do_basic_setup init/main.c:1416 [inline]
>  kernel_init_freeable+0x6ff/0x788 init/main.c:1636
>  kernel_init+0x1a/0x1d0 init/main.c:1524
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
