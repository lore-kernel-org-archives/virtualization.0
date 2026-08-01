Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85A1F30A9
	for <virtualization@lists.linux.dev>; Sat,  1 Aug 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542437; cv=none; b=H/kS7VVp2J8fk0oQW8aGD3HBxwi33sZRT2HzmVhYmVI9ghcDEMlB+DcWC6nj/pf+D959c0V3y7n8vkNbZQL/CcSg6MB6DGWZituCx1Ecmyvo5WQ5ZonLpbHGCDS+NEGBdw7kiCSKZWqOL+Cjrs+0Fo8VR57eo7XBQ/afTpxntG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542437; c=relaxed/simple;
	bh=xcQaKLhOYTkA7pckCpPw+ZrGK7F8h4TF/ZiWO64SzbI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aXRGgI0D4KwuCGIsxODd0ZsTVwXHbmQ2m2O+7gggXaXFK0YOEq9wqUUtqq4owEgvyuEEFBXG8A3GwVXCPnP1GQVg2HO963YIAOlQPhH9Ve7GiQqO4cHaC83bi52SFQnGBIFAlqa4ckwB6pF5Nwdfi1xQIB1de1hlcgfvWgRJZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-4519ef1babeso913959fac.2
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 17:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542434; x=1786147234;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vJy9s3+Pv4AvQn6wBz/fWiCzj0A6dms/Zyw/d7rMDVQ=;
        b=EWZHehduz4sr6l9NT1UQeltHE7U3yrVCzuQQSBOs9V4gV+1ZNCJHUQJl4EBwaq2L7J
         7fKDiyEYipLt48DkboPXGGN9oH4iKWaBt/URzVuHpvIFQt7u5UiD2qnhLa+Oam9/9OX/
         i4mJWm8ygQK5Cl6EH0msl4UDkVyg3XMPfUCFUs0EPWy2aV+WXND0JN51vUjdkrV0CoTs
         GDWHwhd44afam0CPIngn4ZW5Ve4nrVnvjYpe+jCShTBmxQQ5aV3Unnc8CLHi8r4lTmfb
         s8FGr1q0Kbe25acA9kgP3nlN/WxcK9gKj3v2qdgwo4uTdO2I2NHzO82dS+wjB+jv24Qo
         tYqA==
X-Forwarded-Encrypted: i=1; AHgh+RpnAD/wF9972Ubj7skdwVX37fHEp4Wy3VJzji0MXAzHlzFZxg/hA/J4Kha1/NminZIyMpriDkVKw+Zg2wk+Bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvH7dE4T6YPrLIz8kuEF3Xryj5X06Kq0AigjZl56EBpJQnRxdC
	OT0+KahxNp6S4cbSjTayXtfr7EPq7/QsVhGQVm3+3PA4s+YUtTrWipQHe486L474vbYGo7oQK2l
	yMFHiNV2YjIEcsdS5tqWiNdToGLjBUXLeEnLiVa7oRCp3uos4r2aN3XME0KA=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:50a7:b0:4a4:25b4:a0be with SMTP id
 5614622812f47-4af5dfcc6f9mr4039834b6e.2.1785542433670; Fri, 31 Jul 2026
 17:00:33 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:00:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6d3721.13bfb6d0.1ecdd5.024f.GAE@google.com>
Subject: [syzbot] [virt?] WARNING in virtio_dev_remove
From: syzbot <syzbot+a1c8effc62c569d4bd25@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowangio@gmail.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11c625b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=a1c8effc62c569d4bd25
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17405499580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1583649e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0afad3dd27f4/disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e1441f9c31d/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f0b8bdf00cd/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1c8effc62c569d4bd25@syzkaller.appspotmail.com

------------[ cut here ]------------
dev->config->get_status(dev)
WARNING: drivers/virtio/virtio.c:378 at virtio_dev_remove+0x18b/0x1b0 drivers/virtio/virtio.c:378, CPU#0: syz-executor501/5611
Modules linked in:
CPU: 0 UID: 0 PID: 5611 Comm: syz-executor501 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:virtio_dev_remove+0x18b/0x1b0 drivers/virtio/virtio.c:378
Code: 4c 89 f7 2e 2e 2e 41 ff d3 0c 01 0f b6 f0 4c 89 f7 4d 89 fb 5b 41 5c 41 5d 41 5e 41 5f 5d 2e e9 cb 7e c1 1a e8 96 50 87 fc 90 <0f> 0b 90 e9 6e ff ff ff 44 89 e9 80 e1 07 38 c1 0f 8c c2 fe ff ff
RSP: 0018:ffffc9000430f7d8 EFLAGS: 00010293
RAX: ffffffff853e8a5a RBX: ffff8880207766d0 RCX: ffff8880121c8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000000ff R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff8540e710 R12: 1ffff110040eecda
R13: dffffc0000000000 R14: ffff888020776000 R15: ffffffff8bd67c98
FS:  0000555584740400(0000) GS:ffff888125c41000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe020e42e9c CR3: 000000003c1e4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3961
 device_unregister+0x21/0xf0 drivers/base/core.c:4002
 unregister_virtio_device+0x37/0x60 drivers/virtio/virtio.c:594
 virtio_pci_remove+0x7f/0xf0 drivers/virtio/virtio_pci_common.c:758
 pci_device_remove+0x99/0x1c0 drivers/pci/pci-driver.c:512
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0xf6/0x120 drivers/pci/remove.c:93
 pci_stop_and_remove_bus_device drivers/pci/remove.c:128 [inline]
 pci_stop_and_remove_bus_device_locked+0x77/0xb0 drivers/pci/remove.c:136
 remove_store+0xe5/0x150 drivers/pci/pci-sysfs.c:523
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f1782a589
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffded968938 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f1782a589
RDX: 0000000000000001 RSI: 0000200000000200 RDI: 0000000000000004
RBP: 0000000000000001 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffded968aa8
R13: 431bde82d7b634db R14: 00007f5f178bdc40 R15: 0000000000000002
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
