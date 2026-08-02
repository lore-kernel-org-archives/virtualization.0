Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1C2765E2
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785655591; cv=none; b=oEcptdDBtoQwfKRyctmyybbKvbzmSCRdLRKREbRQEzSf4owR46Vmf4Xp3EqiRJlEqyUpsBxsUjmNsNgqZ6xTWJCACWcuNidAmd4+HRmU/iqqCImE6ffJCJOWDkhbVgcLECefILCJcY7FVu+3ycN/oy600ifsUZxfFBHmXuRhs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785655591; c=relaxed/simple;
	bh=ecvRhkpEPZSsJ4bF9YrNd86GWe7gBEeb6Cqm7Vy+pQE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Sr0lJZNhiIpDYC+suh0prX0S2s1DyHfKPSsNfDj4qZpHQk4+8kZ+9GkKhkeBJ6055QR3JAbeMQ9tGCkCsiG7rFVP34jmFBEXHOer2lZ+rs3/n63l0oJzYisxDVBHyv82kh9YR3oO2YYjNzCO9Tl5vh57bKiht0U6aCHOjnT8hUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a45b3f0bdfso3005693b6e.1
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 00:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785655589; x=1786260389;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFAZOHpoOzdEC72mhCLaIi2Ir9J0fgzUfWqu96TAK+A=;
        b=S7fQ37BWIJvvfOsz2ve6paR99nXV4bg+oknADCheZGV9xMKl1e13ofIjsATxI1WG6L
         ajFtRiwe23M44JyWpec57sRJ6M6q9X5Ni/srgY7Ke/590ClMOnPDf2myDSAwIREdQQPl
         pDvO98r9AnVJMcqydgaZVRlg8Z4hZLqIba6/DfvQnkM76agCv3/kjmw1PObxmHKE8xgG
         MggqOSPIXbABNZ/H73AxpQYLy0IKoKNMbvoU+UE7YqhDCvPn/X4+m+aCx9yc9FdN8bxW
         e8d+TLVnkEURAhkZhRzs2868WmkgrbGKft0Q+5vAbe6ciRRbkvZUWHuvHX144TCTFqBn
         OgcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJMmW0VbXOdXYK79UJvz4wmmAPA1y8QnugHddGyccDHZ3OH4+tBQrx/KyMVibmv3h67/gxRLq+v4ru0HbMDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzrf9Aj8DvJSokW2ftzlXrZPlqDNO4RILCGqoScuCpbMrYI3tDQ
	1v+7x/t/CfYr/07OBHJcLSsjipZQuz7L87hGzYbYPE4KknWzrQCM4Rh7RgSG074D/JRaJbKuzbS
	q0MVVhKKnuC2afJHPXw2PRbyxrw/ZS67B7gxRZYsUNbeVWj0Evwk9B9v/uKY=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3986:b0:4a0:d9a1:1a95 with SMTP id
 5614622812f47-4af5e39474emr9225337b6e.14.1785655588794; Sun, 02 Aug 2026
 00:26:28 -0700 (PDT)
Date: Sun, 02 Aug 2026 00:26:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6ef124.d606a800.1705cf.000a.GAE@google.com>
Subject: [syzbot] [virt?] [dri?] WARNING in virtio_gpu_free_vbufs
From: syzbot <syzbot+06f9b2a53ba4a5a47644@syzkaller.appspotmail.com>
To: airlied@redhat.com, dmitry.osipenko@collabora.com, 
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	simona@ffwll.ch, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    02dc699f83d0 Merge tag 'kbuild-fixes-7.2-1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ee74c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=06f9b2a53ba4a5a47644
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-02dc699f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/faf03a1fb300/vmlinux-02dc699f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a48e50ceca1d/bzImage-02dc699f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06f9b2a53ba4a5a47644@syzkaller.appspotmail.com

Slab 0xffffea0000db2e80 objects=29 used=2 fp=0xffff888036cba000 flags=0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
Disabling lock debugging due to kernel taint
------------[ cut here ]------------
1
WARNING: mm/slub.c:1244 at __slab_err+0x15/0x20 mm/slub.c:1244, CPU#1: syz.5.2129/14034
Modules linked in:
CPU: 1 UID: 0 PID: 14034 Comm: syz.5.2129 Tainted: G    B        L      syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE, [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__slab_err+0x15/0x20 mm/slub.c:1244
Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 5b fd ff ff be 01 00 00 00 bf 05 00 00 00 e8 dc ba a2 00 90 <0f> 0b 90 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000636f738 EFLAGS: 00010083
RAX: 00000000000205dc RBX: ffffc9000636f788 RCX: ffffc9000c781000
RDX: 0000000000080000 RSI: ffffffff81c709bd RDI: ffff88802996ca80
RBP: ffff888027f80558 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001ea0
R13: ffff888036cbbfb8 R14: ffff888027f80540 R15: ffffea0000db2e80
FS:  00007f9b5db516c0(0000) GS:ffff8880d5ed8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c30fb1e CR3: 000000005bdcb000 CR4: 0000000000352ef0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 list_slab_objects mm/slub.c:7994 [inline]
 free_partial mm/slub.c:8015 [inline]
 __kmem_cache_shutdown.cold+0x16e/0x177 mm/slub.c:8058
 kmem_cache_destroy mm/slab_common.c:569 [inline]
 kmem_cache_destroy+0x73/0x190 mm/slab_common.c:527
 virtio_gpu_free_vbufs+0x38/0x80 drivers/gpu/drm/virtio/virtgpu_vq.c:86
 virtio_gpu_release+0x5c/0x1c0 drivers/gpu/drm/virtio/virtgpu_kms.c:312
 drm_dev_release drivers/gpu/drm/drm_drv.c:912 [inline]
 kref_put include/linux/kref.h:65 [inline]
 drm_dev_put.part.0+0xbd/0x140 drivers/gpu/drm/drm_drv.c:948
 drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:947
 virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3961
 device_unregister+0x1d/0xe0 drivers/base/core.c:4002
 unregister_virtio_device+0x39/0x60 drivers/virtio/virtio.c:594
 virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:758
 pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0x120/0x160 drivers/pci/remove.c:93
 pci_stop_and_remove_bus_device+0x58/0xa0 drivers/pci/remove.c:128
 pci_stop_and_remove_bus_device_locked+0x1a/0x20 drivers/pci/remove.c:136
 remove_store+0x123/0x140 drivers/pci/pci-sysfs.c:523
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9b5cb9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9b5db51028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9b5ce25fa0 RCX: 00007f9b5cb9e019
RDX: 0000000000000001 RSI: 0000200000000800 RDI: 0000000000000006
RBP: 00007f9b5cc3500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9b5ce26038 R14: 00007f9b5ce25fa0 R15: 00007ffeee83f378
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
