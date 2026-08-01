Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9463515D4
	for <virtualization@lists.linux.dev>; Sat,  1 Aug 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543336; cv=none; b=bFUcLPwWn0cqiUShu+zzPwFwfRojdRMVcGBdM48xyq8w2fZiANcV68Op4x1t3XuWEhD5sFIbhOyl14iEiud3AA01E0Jl9/nyoYluJ/+gNA+H6bX0J6gNIMFtBbSBMVg+hqkRY3MGd6FMm/JykOjEOubklDC402SoF4I3LGDeM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543336; c=relaxed/simple;
	bh=OQmH73Fp7E4tVFkaIFBqOQJ1hTe12cSQAM/uqyBxicM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HM9xsKk/C6eRG3sqONPNX3Qw8DqxPcOfzQZi+n2m07wNR8MSaLZAoHzP92+V/lLiQ+TK24sYZSrwCytlnyt03WrwLg6YITzzi2mI0EXIVwU0XBxPrVNaYCXHPZo35yM19U4Sp3HfG1lOdZtWt2giAzpXv1pxPq01wb7DDTdKhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXknlL9+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXknlL9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785543331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ2ogwdFfsI7RDCk267qTcVewuakRgC0nqg3uHZarr8=;
	b=UXknlL9+VjLCKRWtCag//OOFK2puOBf7bVoORdXvqLALDGYQ3+o+ToLsQEJZIAqXIhEOWA
	wIWJNv4pnGK+TPPgm62F7NeD3XmZhTpK8QGB6ipG79r/38ppiJ0ZdGKeGAz6Yj85N+QSDv
	kbbVdmKw7yib5WtoOiMSOq/HhRVfJlg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-xz11gQ_sMmqdETIx8AXqag-1; Fri, 31 Jul 2026 20:15:30 -0400
X-MC-Unique: xz11gQ_sMmqdETIx8AXqag-1
X-Mimecast-MFC-AGG-ID: xz11gQ_sMmqdETIx8AXqag_1785543329
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so2488025e9.2
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 17:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785543329; x=1786148129;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQ2ogwdFfsI7RDCk267qTcVewuakRgC0nqg3uHZarr8=;
        b=h/Dv5IU1YN2XedF1+QIvisvK7wfv0sAfF59DrEZcNT78ZiP7j0rhHCBIVBr8h5amqW
         3E1GjtY+AZlrbqm4T7ohXI5GO00ye7/fCpwb6+Hygy9f6BINL6qSSsCIxtFpfA1RQJU6
         27IuL0G24H+yn97pDB0OcVGced8NFO58c3RYJQ/x14nOqaELmPfi7uPDXFlhiTM8CQna
         CyE6IfOIUzp4FDn0KQa8r/8ISg17W8gMwhi47s1JRHSnmHjFiEuVN+GTI3OH7WD4a8+i
         WnNnnsa+YOcCpr2JW7aEIqVwIt2YuhWEMRJrhi8zgn6+EbihDhm1rM1nJIj+9INYrGhy
         WY+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoJg0hcEgdrFY+9MyK0Ti0CdXLlYh/czkMM/JY+KDYxz45VPFPkQ9QMgkZ6oNYUuK0xPzU1etjzh3F8lZAIPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn8WwhNTnQFh1oF5FR1z3KXz9VTAEHrNeEyUFDddQaaOR+XNQ3
	RfMgjF9cYxyt13eYCljr/PvQU0j3OXTmVjo1QEZMdPuRaLhYYz9DE9/0NXORHBTVHdJP7OQ7Mt1
	6BQAbIapMpWZ0GmwRqBoRX8kNwDJetEmmALfayS6Z+e5pbicWaphn+udcGoKMHoxJ9pSk2WDjAZ
	Yl
X-Gm-Gg: AR+sD114+h10jr6Ph7L1LkWBxfMDoHHBGCiB4+WsDIOt6jRCXfAz3O3CiIc5VrP8rbt
	1QZ/YWkoF/Ah0KtR3mTkVXRD+4qSOMAurD/7OHmJwqw+CqKOH9XW3yOAvDwYSVv3+LUgepUu3G4
	bbeiO5FQgnytug0Xtn/2xuKQbAX+a1AQgQ/3j70q3LsMVVj74Q4D6VJqjKpk6okyj1qpugWkbMq
	tY2Kz/c9q/LHovqcrvFLMMFnAgZrycnLO+WcxkgfgHCJzNzR7REhfRixo8xhaqO05zaHTx0Psep
	86tsuIUazW7U/evOS4NbImqrbCkwcCMXLcSlKCCmPmtJxdLzM9j4/a1Ej7HvCqFAYkkCt4/QNtn
	XMs4fCNgYan9GzOxonhPU5zg=
X-Received: by 2002:a05:600c:c113:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4980c674e1dmr3327585e9.10.1785543328896;
        Fri, 31 Jul 2026 17:15:28 -0700 (PDT)
X-Received: by 2002:a05:600c:c113:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4980c674e1dmr3327215e9.10.1785543328417;
        Fri, 31 Jul 2026 17:15:28 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980869106csm7586885e9.9.2026.07.31.17.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 17:15:27 -0700 (PDT)
Date: Fri, 31 Jul 2026 20:15:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+a1c8effc62c569d4bd25@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, jasowangio@gmail.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] WARNING in virtio_dev_remove
Message-ID: <20260731200905-mutt-send-email-mst@kernel.org>
References: <6a6d3721.13bfb6d0.1ecdd5.024f.GAE@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6a6d3721.13bfb6d0.1ecdd5.024f.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: z82Sv-2Nz4LrafCcYcrCNrSiVfP1dWKkO_UzlQzdLi4_1785543329
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 05:00:33PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11c625b9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
> dashboard link: https://syzkaller.appspot.com/bug?extid=a1c8effc62c569d4bd25
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17405499580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1583649e580000

So I read this reproducer:


  memcpy((void*)0x200000000140, "sys/bus/pci/devices/0000:00:04.0/config\000",
         40);
  res = syscall(__NR_openat, /*fd=*/0xffffff9c, /*file=*/0x200000000140ul,
                /*flags=O_RDWR*/ 2, /*mode=*/0);
  if (res != -1)
    r[0] = res;
  //  pwrite64 arguments: [
  //    fd: fd (resource)
  //    buf: ptr[in, buffer] {
  //      buffer: {00 00} (length 0x2)
  //    }
  //    count: len = 0x2 (8 bytes)
  //    pos: intptr = 0x4 (8 bytes)
  //  ]
  memset((void*)0x200000000180, 0, 2);
  syscall(__NR_pwrite64, /*fd=*/r[0], /*buf=*/0x200000000180ul, /*count=*/2ul,
          /*pos=*/4ul);



So it writes 0 into pci command, effectively killing the device,
and then is unhappy that the driver prints warnings?
Who thought it's a good idea? Why?




> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0afad3dd27f4/disk-11028ab6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2e1441f9c31d/vmlinux-11028ab6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5f0b8bdf00cd/bzImage-11028ab6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a1c8effc62c569d4bd25@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> dev->config->get_status(dev)
> WARNING: drivers/virtio/virtio.c:378 at virtio_dev_remove+0x18b/0x1b0 drivers/virtio/virtio.c:378, CPU#0: syz-executor501/5611
> Modules linked in:
> CPU: 0 UID: 0 PID: 5611 Comm: syz-executor501 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:virtio_dev_remove+0x18b/0x1b0 drivers/virtio/virtio.c:378
> Code: 4c 89 f7 2e 2e 2e 41 ff d3 0c 01 0f b6 f0 4c 89 f7 4d 89 fb 5b 41 5c 41 5d 41 5e 41 5f 5d 2e e9 cb 7e c1 1a e8 96 50 87 fc 90 <0f> 0b 90 e9 6e ff ff ff 44 89 e9 80 e1 07 38 c1 0f 8c c2 fe ff ff
> RSP: 0018:ffffc9000430f7d8 EFLAGS: 00010293
> RAX: ffffffff853e8a5a RBX: ffff8880207766d0 RCX: ffff8880121c8000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000000000ff R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: ffffffff8540e710 R12: 1ffff110040eecda
> R13: dffffc0000000000 R14: ffff888020776000 R15: ffffffff8bd67c98
> FS:  0000555584740400(0000) GS:ffff888125c41000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe020e42e9c CR3: 000000003c1e4000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  device_remove drivers/base/dd.c:616 [inline]
>  __device_release_driver drivers/base/dd.c:1349 [inline]
>  device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
>  bus_remove_device+0x449/0x560 drivers/base/bus.c:664
>  device_del+0x528/0x8f0 drivers/base/core.c:3961
>  device_unregister+0x21/0xf0 drivers/base/core.c:4002
>  unregister_virtio_device+0x37/0x60 drivers/virtio/virtio.c:594
>  virtio_pci_remove+0x7f/0xf0 drivers/virtio/virtio_pci_common.c:758
>  pci_device_remove+0x99/0x1c0 drivers/pci/pci-driver.c:512
>  device_remove drivers/base/dd.c:616 [inline]
>  __device_release_driver drivers/base/dd.c:1349 [inline]
>  device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
>  pci_stop_dev drivers/pci/remove.c:27 [inline]
>  pci_stop_bus_device+0xf6/0x120 drivers/pci/remove.c:93
>  pci_stop_and_remove_bus_device drivers/pci/remove.c:128 [inline]
>  pci_stop_and_remove_bus_device_locked+0x77/0xb0 drivers/pci/remove.c:136
>  remove_store+0xe5/0x150 drivers/pci/pci-sysfs.c:523
>  kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x61e/0xbb0 fs/read_write.c:687
>  ksys_write+0x156/0x270 fs/read_write.c:739
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5f1782a589
> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffded968938 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f1782a589
> RDX: 0000000000000001 RSI: 0000200000000200 RDI: 0000000000000004
> RBP: 0000000000000001 R08: 0000000000000006 R09: 0000000000000006
> R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffded968aa8
> R13: 431bde82d7b634db R14: 00007f5f178bdc40 R15: 0000000000000002
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
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

