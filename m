Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471BC4BF94E
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605299; cv=none; b=bvhduD9+03EmHZugRMQ7/+YXZr6FphlYt2ng2XK91OlXgQckXegHAwtZLtdRjfj9LeOE3yQMRGDSDla5dEHF6WHPiRTy3/fcDsjPiWxL4DED4+hAsuORtJMEtKZQzflNX+obS1PAwQx1dfbazFrhftvX/SRRQu1jdX5eYYlq+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605299; c=relaxed/simple;
	bh=l8LnOTZIQoA0h2h21hFNgU7pEPJnhkdZGBQKHKFCzbs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Md27jjJb84pUCz3ceu2m8Y4KXhplk5hCtBtKgvTBf/9mOkT9Bae3zrT1zK0gDxmA2MZtPdFasRCW/f8F7qTpL8SeZLb82Iw9JIWqPkT20U8DSLP/VJkOPIbFXxueFpnUH4e2DtgVFiQHvu9m80vyr3aQNStF9/SasTh6GzXVHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a7de733fa9so5176534b6e.3
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 07:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605297; x=1791210097;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vubk7muu+YkhKRkIvbgFvnTZh6exw+2ow1dFCKoAylI=;
        b=Qmcp4iWGtJHBJzbr5Utq8kKVohrXh/B7swglZ/oRjzsSpPRShP2F43fb1UOBs0/MPb
         L8RrpzfXaGtjlkGmb3sxQHcokNoq+V78zvw3kYP/uz9QPpCWGz6ysXFxUKqrgzTGJIYC
         sufpwp+icbLcwhr5qsMASqa10mdtMvdEgZq+r33E9xrnIfpt+rwgHqeU/Hn0QQiYt7KE
         5Wzn0R+4drR9pzRbtLijPOTS4SQDdNWkWZG8noyAe/KeFBrVe/1oHwDVtC21OHgXVS1Z
         D+6ae3hz5DRtyGBOoo66+0wTCoGqNIOKnORx1nqor0lMe0NBrH59jR5k177aO//hWOgs
         Varw==
X-Forwarded-Encrypted: i=1; AKwUvBwrESRrG03pvwZyJIi6Wv8H+D49fxQUGKE8Ih4siqZV9Sq610GROQyuDTu/1PGmOZUwlEcgZwxmolfArvE6Cw==@lists.linux.dev
X-Gm-Message-State: AFuF++kCeg7w52FD4CMtK5nhT11uqzqtyA2Y60coWpUIIftVJ59ZBYJ6
	FhlBpQ5l6iyQPzf4T3BNCroU5k2mmA0sSx4p/YIgZfGyaQR/SRzBFkh2O/sIBZkG5EZ33yymF2f
	VAueAcr644tebNpkxx0LuJdS9kGmuwPbfgWL7SBfT8UAIAJVFH58XhMxLvc0=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1914:b0:4ca:8d6f:4258 with SMTP id
 5614622812f47-4d72e06ff3dmr12786028b6e.37.1790605297180; Mon, 28 Sep 2026
 07:21:37 -0700 (PDT)
Date: Mon, 28 Sep 2026 07:21:37 -0700
In-Reply-To: <6a9826cf.9266084e.bf0d7.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aba77f1.e548f532.1ca396.0049.GAE@google.com>
Subject: Re: [syzbot] [dri?] [virt?] WARNING in virtio_gpu_free_object
From: syzbot <syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com>
To: airlied@redhat.com, dmitry.osipenko@collabora.com, 
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	simona@ffwll.ch, syzkaller-bugs@googlegroups.com, tao1.yu@intel.com, 
	tzimmermann@suse.de, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    72d3fcf802c4 Linux 7.3-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168a2ac9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118a2ac9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1324e325580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-72d3fcf8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57f8c24b5f88/vmlinux-72d3fcf8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6587a00eaa7f/bzImage-72d3fcf8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com

Console: switching to colour dummy device 80x25
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#2: syz.0.17/5926
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x944/0x1bd0 kernel/locking/mutex.c:821, CPU#2: syz.0.17/5926
Modules linked in:
CPU: 2 UID: 0 PID: 5926 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
RIP: 0010:__mutex_lock+0x94b/0x1bd0 kernel/locking/mutex.c:821
Code: 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 c0 10 00 00 44 8b 05 e8 55 71 05 45 85 c0 75 13 48 8d 3d ac 61 74 05 48 c7 c6 c0 f6 ef 8b <67> 48 0f b9 3a 90 e9 1b f8 ff ff 4d 8d a7 f0 0a 00 00 4c 89 e7 e8
RSP: 0018:ffffc900043f7b30 EFLAGS: 00010246
RAX: 0000000000000003 RBX: ffff888100b551c0 RCX: 1ffffffff228b180
RDX: 0000000000000000 RSI: ffffffff8beff6c0 RDI: ffffffff914897d0
RBP: ffffc900043f7ca0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888027028b60
FS:  0000555564139500(0000) GS:ffff8880d5d4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f24008 CR3: 00000000296f3000 CR4: 0000000000352ef0
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
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1e7cf9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb76db628 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fffb76db710 RCX: 00007f1e7cf9e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000000e123 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b32320000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1e7d225fac R14: 00007f1e7d225fa8 R15: 00007f1e7d225fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   4:	38 d0                	cmp    %dl,%al
   6:	7c 08                	jl     0x10
   8:	84 d2                	test   %dl,%dl
   a:	0f 85 c0 10 00 00    	jne    0x10d0
  10:	44 8b 05 e8 55 71 05 	mov    0x57155e8(%rip),%r8d        # 0x57155ff
  17:	45 85 c0             	test   %r8d,%r8d
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d ac 61 74 05 	lea    0x57461ac(%rip),%rdi        # 0x57461cf
  23:	48 c7 c6 c0 f6 ef 8b 	mov    $0xffffffff8beff6c0,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 1b f8 ff ff       	jmp    0xfffff850
  35:	4d 8d a7 f0 0a 00 00 	lea    0xaf0(%r15),%r12
  3c:	4c 89 e7             	mov    %r12,%rdi
  3f:	e8                   	.byte 0xe8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
