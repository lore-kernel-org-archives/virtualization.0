Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5CA84DFD
	for <virtualization@lists.linux.dev>; Sat, 25 May 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716653548; cv=none; b=fZhsIyYUwg4gOclHW9YFrQCse7U9z5Y9s41+kQAxPz39BFrN+QZZ9KZC0qRrYex61OPc9zJCrVSBo92oIsyWVAa37wWMMpyFMWRXxDJGHCrImAfXKB67XrK23dcG7THWztTPLXI7PJRHnc/4Tvt+sNyUjmHYtM778L5H4XZuGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716653548; c=relaxed/simple;
	bh=OZepftTAC1FcRyFWhPRaHCFE/Oetkj5/jAjnZ3hLibA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MRQYVnK3nEgCHnUQyAOovHfWN254XvZTKgpw35mxQL2B4mBfAVJK1tcpbXIQQzg3lSCgF5gJJH2UKvon4Y3P7j9HRbMZbXtLZtv16DwynGMDOolwTHAzaPmM0g+HN1oeYjx/ukUc9c0GdltbjiMvySzVIwVEL0ZLb3I8u6BJzlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ea27057813so82986639f.2
        for <virtualization@lists.linux.dev>; Sat, 25 May 2024 09:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716653546; x=1717258346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qppKSing007VFbuzxdWD4I4aBmnaSOSGhNYLuq1/gO0=;
        b=XwJpkguHYsEbMC93I6bwv9aC2Igo7OfOG91t2el9NDXWfh/feGj394Qq5/9I3AquA0
         uYVCSh48NoWd5L6FsLZePdq9n4Ydm6TbGHrH1ctGRTU/unsGhiXpRFup6/Qqu+RP9H27
         d3Zdf9aEV9Df/ynMjZMf2rJal3nikRL6ZUL1hXtYneeeF4D7Fcz4iwCtDxzJ4VHc42yx
         EiSsoMvXWs3UfkW1db+DV3FeLcu+jmjkcPQIzvkdGWMAjmJp9+WK4WWBaW1zfVcykpZ8
         iKOKAaSMHuMFr/NoRifxkpm+2Yvvfas/n2kHZ44kaa27s2VdCaZPDhvt5ggigJHAgdj0
         0RFg==
X-Forwarded-Encrypted: i=1; AJvYcCWC0Lvm+gEz3Vxpsh8JCXu2HdL7kx6qNoVa7TxPQZWuANxQx+Ztvrep+NAGNLMZvivYOuT1Nsk2A6b7h9ZrmJ6nSomEASHWgnYY6Lf7jd0=
X-Gm-Message-State: AOJu0YzBIZ9oYagx4WbyRt7RK6840C7ipM+KZY3QRD2glH6qK8zlc6N0
	psI1IbH77/qqXB0xi51StISBuh4quhuSr9WpYp36t589G99BYcB5YoMEZ/WVflht3geSd/+Mzw9
	Kf/C2Nti95KIXgr6jXFdGtyOnziKNKR4y3SRc0JQ7QuC2VCzARUVM3WM=
X-Google-Smtp-Source: AGHT+IFKB6dxIXo20KL7IU/S43qkYCImShfkQ1rrrWxgWmlP/1ZQWw0SdtCYvsToAyRolY3zDerrrSGnA6FzJT8ksEeM8onZUX+T
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8419:b0:4b0:8e83:8222 with SMTP id
 8926c6da1cb9f-4b08e838603mr61406173.5.1716653546076; Sat, 25 May 2024
 09:12:26 -0700 (PDT)
Date: Sat, 25 May 2024 09:12:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d10c260619498c25@google.com>
Subject: [syzbot] [net?] [virt?] upstream test error: KMSAN: uninit-value in receive_buf
From: syzbot <syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	jasowang@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157a5462980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6c22bca89a3565
dashboard link: https://syzkaller.appspot.com/bug?extid=799fbb6d9e02a7a1d62b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/39a256e13faa/disk-56fb6f92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4ecc47a8198/vmlinux-56fb6f92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d37bfdfb0ca/bzImage-56fb6f92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in receive_mergeable drivers/net/virtio_net.c:1839 [inline]
BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd0 drivers/net/virtio_net.c:1955
 receive_mergeable drivers/net/virtio_net.c:1839 [inline]
 receive_buf+0x25e3/0x5fd0 drivers/net/virtio_net.c:1955
 virtnet_receive drivers/net/virtio_net.c:2259 [inline]
 virtnet_poll+0xd1c/0x23c0 drivers/net/virtio_net.c:2362
 __napi_poll+0xe7/0x980 net/core/dev.c:6721
 napi_poll net/core/dev.c:6790 [inline]
 net_rx_action+0x82a/0x1850 net/core/dev.c:6906
 handle_softirqs+0x1ce/0x800 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0x68/0x120 kernel/softirq.c:637
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:649
 common_interrupt+0x94/0xa0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
 kmsan_get_shadow_origin_ptr+0x86/0xb0 mm/kmsan/shadow.c:116
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:36 [inline]
 __msan_metadata_ptr_for_load_4+0x24/0x40 mm/kmsan/instrumentation.c:91
 stack_trace_consume_entry+0x16f/0x1e0 kernel/stacktrace.c:94
 arch_stack_walk+0x1ca/0x2d0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:74 [inline]
 kmsan_internal_poison_memory+0x49/0x90 mm/kmsan/core.c:58
 kmsan_slab_alloc+0xdf/0x160 mm/kmsan/hooks.c:68
 slab_post_alloc_hook mm/slub.c:3946 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 __do_kmalloc_node mm/slub.c:4120 [inline]
 __kmalloc_noprof+0x660/0xf30 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 tomoyo_realpath_from_path+0x104/0xaa0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x1ef/0xc50 security/tomoyo/file.c:771
 tomoyo_file_open+0x271/0x360 security/tomoyo/tomoyo.c:334
 security_file_open+0x9a/0xc60 security/security.c:2962
 do_dentry_open+0x5b1/0x22b0 fs/open.c:942
 vfs_open+0x49/0x60 fs/open.c:1089
 do_open fs/namei.c:3650 [inline]
 path_openat+0x4ab0/0x5b70 fs/namei.c:3807
 do_filp_open+0x20e/0x590 fs/namei.c:3834
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1431
 x64_sys_call+0x128b/0x3b90 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4683
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2336
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2920
 virtnet_rq_alloc+0x43/0xbb0 drivers/net/virtio_net.c:882
 add_recvbuf_mergeable drivers/net/virtio_net.c:2110 [inline]
 try_fill_recv+0x3f0/0x2f50 drivers/net/virtio_net.c:2155
 virtnet_open+0x1cc/0xb00 drivers/net/virtio_net.c:2434
 __dev_open+0x546/0x6f0 net/core/dev.c:1472
 __dev_change_flags+0x309/0x9a0 net/core/dev.c:8780
 dev_change_flags+0x8e/0x1d0 net/core/dev.c:8852
 devinet_ioctl+0x13ec/0x22c0 net/ipv4/devinet.c:1177
 inet_ioctl+0x4bd/0x6d0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0xb7/0x540 net/socket.c:1222
 sock_ioctl+0x727/0xd70 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:893
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
 x64_sys_call+0x18c0/0x3b90 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 4772 Comm: ssh-keygen Not tainted 6.9.0-syzkaller-12277-g56fb6f92854f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


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
