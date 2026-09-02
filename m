Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128B47A89B
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356306; cv=none; b=eseEd2eR6FFibtdY7mhPR1Cx1PgL2VWGVBxj1wsh6il1zfNaAzb3s1ewQjDi86p+yh763Kv6i8zGggr3pbZUS2sJwit169+WrRtGcsJ0l0J+k7X22h5D44A5ywr/ofqzZCVUUb0TtyGIiEruNeG0Wylvua7SU0DppsZ3cjvhQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356306; c=relaxed/simple;
	bh=YXDN7vq/imnSsYdudAHyrjR2kibHupd6KUos4uTRU0o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t2NDSOCA8Mo/EhDdKTelPlq6iZfNvjyAEQZWJrnxrEAgfu6Vg0pjj1Frl4/zkjZah6V9az1OTIj4HRECE8WORXcjyiopCwjFXAyLwKrG/dx+q8hzy2tBZSFt96t3mMMOb62bu65iBgontOTtvYpU2I6xksWHIky7CmBsr6k63W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6b1bebb3ae8so294649eaf.1
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 06:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356304; x=1788961104;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4EUl0+l4ijrlzUvXL1HFtDQOMWNs5F7/Y3XbzXQpJ4=;
        b=WQKwl2qYHH1mZmjG1ptKj66aYImziKesYl2wF0nhYvsd55iKDQasCB7jxc/a20wbmZ
         wGcYiYshyBShc+0sT5M+6+R7THOLOunf3HtkDlfzT1lHVDLT9Ia0GI2Coc//kvH+05j8
         FtZ2udy4j6x/lq8l1QYFNsYibyavYF0N8wsysUOC+3jz1x3OFpgjmc2BLXKE7TIkVQur
         sm0+rsN172j0KZeVetVK0UZRO+qpVpZKRlcUz144/ntLdxNtALiZg36uUomjh0XOrx1Y
         o3KT+V4sElzeODXjSr5nALJ6XGKjGMs1r6siWQL4JnXFl5ek0nBxfq+ITxlL6oxuzdBa
         BeHQ==
X-Forwarded-Encrypted: i=1; AHgh+RowsHYsOnF21kk1iAuZiHk/yfAQbaMyvWleKto2PJPJ/IzJSQWgSnMjsmTn+tdDNUEJ1GT3B57DPzq6LwQIew==@lists.linux.dev
X-Gm-Message-State: AFuF++nEO2n5l1ioB8sfxUA6DE7fhE0f8m+LdQCU7ulI3/Vsu+Cjf4tR
	XAG2as3gTtsZwYa2DCHj0gXurMDyZFhW2dDQQXltsoWHCS8n1R5IObJZzpt3XJWvDTxHgVlbC3M
	ELUR3AnEMpSwPqbKxsXMrMNstrknIeDf7ldS3EmPtG0ed7ZpUgS2lN0YE8/c=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:200e:b0:6b1:4d1b:3004 with SMTP id
 006d021491bc7-6b480e38546mr3412140eaf.20.1788356303977; Wed, 02 Sep 2026
 06:38:23 -0700 (PDT)
Date: Wed, 02 Sep 2026 06:38:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9826cf.9266084e.bf0d7.0008.GAE@google.com>
Subject: [syzbot] [dri?] [virt?] WARNING in virtio_gpu_free_object
From: syzbot <syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com>
To: airlied@redhat.com, dmitry.osipenko@collabora.com, 
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	simona@ffwll.ch, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    786262be6048 Merge tag 'edac_updates_for_v7.3_rc2' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160c0125580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-786262be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1729d9f9738d/vmlinux-786262be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce8b90b3526c/bzImage-786262be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#0: syz.2.124/6285
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x944/0x1bd0 kernel/locking/mutex.c:821, CPU#0: syz.2.124/6285
Modules linked in:
CPU: 0 UID: 0 PID: 6285 Comm: syz.2.124 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
RIP: 0010:__mutex_lock+0x94b/0x1bd0 kernel/locking/mutex.c:821
Code: 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 c0 10 00 00 44 8b 05 e8 16 74 05 45 85 c0 75 13 48 8d 3d ac 21 77 05 48 c7 c6 e0 f3 ef 8b <67> 48 0f b9 3a 90 e9 1b f8 ff ff 4d 8d a7 f0 0a 00 00 4c 89 e7 e8
RSP: 0018:ffffc90006017b30 EFLAGS: 00010246
RAX: 0000000000000003 RBX: ffff8880281551c0 RCX: 1ffffffff228a580
RDX: 0000000000000000 RSI: ffffffff8beff3e0 RDI: ffffffff914836d0
RBP: ffffc90006017ca0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888027efeb60
FS:  00007f5302d486c0(0000) GS:ffff8880d5b64000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055619ef79490 CR3: 000000005c38c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 virtio_gpu_remove_from_restore_list drivers/gpu/drm/virtio/virtgpu_object.c:70 [inline]
 virtio_gpu_free_object+0xec/0x280 drivers/gpu/drm/virtio/virtgpu_object.c:106
 drm_gem_object_free+0x60/0xa0 drivers/gpu/drm/drm_gem.c:1164
 kref_put include/linux/kref.h:65 [inline]
 __drm_gem_object_put include/drm/drm_gem.h:562 [inline]
 drm_gem_object_put include/drm/drm_gem.h:575 [inline]
 drm_gem_object_put include/drm/drm_gem.h:572 [inline]
 drm_client_buffer_delete drivers/gpu/drm/drm_client.c:201 [inline]
 drm_client_buffer_delete+0x1d8/0x270 drivers/gpu/drm/drm_client.c:185
 drm_fbdev_shmem_fb_destroy+0xc5/0x110 drivers/gpu/drm/drm_fbdev_shmem.c:67
 put_fb_info drivers/video/fbdev/core/fbmem.c:61 [inline]
 put_fb_info+0xb8/0xf0 drivers/video/fbdev/core/fbmem.c:56
 fb_release+0x13e/0x190 drivers/video/fbdev/core/fb_chrdev.c:381
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5301d9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5302d48028 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f5302025fa0 RCX: 00007f5301d9e159
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000000
RBP: 00007f5301e35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5302026038 R14: 00007f5302025fa0 R15: 00007fffc5d9f388
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   4:	38 d0                	cmp    %dl,%al
   6:	7c 08                	jl     0x10
   8:	84 d2                	test   %dl,%dl
   a:	0f 85 c0 10 00 00    	jne    0x10d0
  10:	44 8b 05 e8 16 74 05 	mov    0x57416e8(%rip),%r8d        # 0x57416ff
  17:	45 85 c0             	test   %r8d,%r8d
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d ac 21 77 05 	lea    0x57721ac(%rip),%rdi        # 0x57721cf
  23:	48 c7 c6 e0 f3 ef 8b 	mov    $0xffffffff8beff3e0,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 1b f8 ff ff       	jmp    0xfffff850
  35:	4d 8d a7 f0 0a 00 00 	lea    0xaf0(%r15),%r12
  3c:	4c 89 e7             	mov    %r12,%rdi
  3f:	e8                   	.byte 0xe8


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
