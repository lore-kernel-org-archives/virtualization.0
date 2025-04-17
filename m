Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FE252295
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902628; cv=none; b=rrUxA0CI7zio7Pm9H9R+tsH59z2zWmVbyIyGaO5lI5rH+0nu9BIs2x4CHAL0Ll2bzJ+72Q64a0f4ANdI2pS/5GScjG7qbS3SErTUJ3v+K9Xx5+rym8INgyJJ8JH5r/rD9+K1+rNNmj1KlWHdm/zpfBVgCzrA/m93DC1vs0Kpk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902628; c=relaxed/simple;
	bh=NMIIw60GZShTg37kMSUEMuZsYQy8pT1XRO1gez+5lBs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Paz+2xjZQFpaHr+B8r0dSZ7t/J45itl1IwL2H31pvn83n1NlEDUkz+wTN48BXVLJIzhONVXFjlobweXTWiSsHYp+Jfiir0guDhSQc0elaZYAR8Zadr66lYL4jjYV0+IWI7u+SD2xIcYYyWTxacHUXmuTmBzFJ3Iz3JGN/mzShJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-851a991cf8bso165431739f.0
        for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 08:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744902626; x=1745507426;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUjzBO5ydnB/W6FtODgX9yEBNVVZZQFEaYNiWI1bNw0=;
        b=b8YOqll2d2ZVLFiBJBicLTIkZKCTT1Ss0RjsWbvoXCug9l6AGsQk+6ezYXwjlrdwVf
         cK9CnP/ncBECbPahmv7r/R4Zc9dGhVLzmzjTd1Wfsrvpq2QPSsJhTP8AeR4WBwVf8y3d
         qL0GifGebA2Xwt0McfguSLZqnZhZQj7rKZ5yjUTR2oH3iKms5hi7yCI/SADHv7fzjwjG
         nm1Mz/JM9S94IHP/SC+PykZ1+3KLK5UDRsjnZRYATFX+oFycpvLanXVXWyDi8EeFfpVQ
         GYIeeJxEJqXdcdfqLE52aKo/ce/tdzChK/P6PjstJOBp+7V+0YqiM8DPuUwApLpWkq2Y
         cJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNGzxpvgWrBA6yhTf72V2PZ/k67hGdbdclxW1C58KXHbzjHaju8r6E/34r6CKkqCnXGI27QiQuAUZf+ZdQ6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ9eZZ6Yn1YY1vMIyM6HTyNWFIKb0m4yZdJa0O8nFFnkRldIj3
	qxEoHGg3thUFBSPRUiPJFxMIx4853koVqYRcCKMTmvun4h8Pb6EXPFx8leOI/KUm1odadRjSbM9
	bnkzVgcAE4ux5Hjr7zZ/JBIrJH0HfgUeCcIiX5SHsQFPNHijhw0b+buE=
X-Google-Smtp-Source: AGHT+IGZU5H5xeXB3WqaLpJtOEzTMwvl9FOcphlngfzZaGtW+CRzNzUbjQZwcPyUIQN+JeoMHBCgGeib9R8pPPZIn/s4z4eUb2Yf
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c67:b0:3d2:ed3c:67a8 with SMTP id
 e9e14a558f8ab-3d821d3070emr2138045ab.4.1744902625994; Thu, 17 Apr 2025
 08:10:25 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:10:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680119e1.050a0220.243d89.0011.GAE@google.com>
Subject: [syzbot] [dri?] [virt?] WARNING in virtio_gpu_queue_fenced_ctrl_buffer
From: syzbot <syzbot+5afbc12ca70811c2bffb@syzkaller.appspotmail.com>
To: airlied@redhat.com, dri-devel@lists.freedesktop.org, 
	gurchetansingh@chromium.org, kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	simona@ffwll.ch, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7cdabafc0012 Merge tag 'trace-v6.15-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108e7870580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c918722cb7e3d7
dashboard link: https://syzkaller.appspot.com/bug?extid=5afbc12ca70811c2bffb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7cdabafc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0a779724c40f/vmlinux-7cdabafc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/00583806b168/bzImage-7cdabafc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5afbc12ca70811c2bffb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 34 at drivers/gpu/drm/virtio/virtgpu_vq.c:414 virtio_gpu_queue_ctrl_sgs drivers/gpu/drm/virtio/virtgpu_vq.c:414 [inline]
WARNING: CPU: 3 PID: 34 at drivers/gpu/drm/virtio/virtgpu_vq.c:414 virtio_gpu_queue_fenced_ctrl_buffer+0xbcf/0xfc0 drivers/gpu/drm/virtio/virtgpu_vq.c:497
Modules linked in:
CPU: 3 UID: 0 PID: 34 Comm: kworker/3:0 Not tainted 6.15.0-rc1-syzkaller-00325-g7cdabafc0012 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:virtio_gpu_queue_ctrl_sgs drivers/gpu/drm/virtio/virtgpu_vq.c:414 [inline]
RIP: 0010:virtio_gpu_queue_fenced_ctrl_buffer+0xbcf/0xfc0 drivers/gpu/drm/virtio/virtgpu_vq.c:497
Code: df e8 a5 45 d5 fe 48 89 9c 24 a8 01 00 00 c7 44 24 30 02 00 00 00 48 c7 44 24 18 00 00 00 00 e9 4f f6 ff ff e8 f2 97 c3 fb 90 <0f> 0b 90 e9 02 fa ff ff e8 e4 97 c3 fb 90 0f 0b e8 dc 97 c3 fb 90
RSP: 0018:ffffc900006df488 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000fffffffb RCX: ffffffff85f79f81
RDX: ffff88801e2d4880 RSI: ffffffff85f7a57e RDI: 0000000000000005
RBP: ffff888104ea7c00 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffffb R11: 0000000000000000 R12: ffffed10209d4f85
R13: ffff8880245976f8 R14: ffff888025553ac8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880d6cb2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa4a49be440 CR3: 000000000e182000 CR4: 0000000000352ef0
DR0: 00000000000007ff DR1: 0000000000000009 DR2: 0002000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virtio_gpu_update_dumb_bo drivers/gpu/drm/virtio/virtgpu_plane.c:175 [inline]
 virtio_gpu_primary_plane_update+0xda0/0x1540 drivers/gpu/drm/virtio/virtgpu_plane.c:264
 drm_atomic_helper_commit_planes+0x954/0x1010 drivers/gpu/drm/drm_atomic_helper.c:2838
 drm_atomic_helper_commit_tail+0x69/0xf0 drivers/gpu/drm/drm_atomic_helper.c:1788
 commit_tail+0x35b/0x400 drivers/gpu/drm/drm_atomic_helper.c:1873
 drm_atomic_helper_commit+0x2fd/0x380 drivers/gpu/drm/drm_atomic_helper.c:2111
 drm_atomic_commit+0x231/0x300 drivers/gpu/drm/drm_atomic.c:1518
 drm_atomic_helper_dirtyfb+0x5fd/0x780 drivers/gpu/drm/drm_damage_helper.c:181
 drm_fbdev_shmem_helper_fb_dirty+0x1c9/0x340 drivers/gpu/drm/drm_fbdev_shmem.c:117
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:379 [inline]
 drm_fb_helper_damage_work+0x27b/0x5f0 drivers/gpu/drm/drm_fb_helper.c:402
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
