Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70129463
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004978; cv=none; b=Ig1W2DDs8jv2ORsIabqTMARg/FMSpQuOBL03z+n4NohSADdG8CE5rmcvKgPLpKO977HPAff9EoCDEM1dk2FmuOa24umkSoGZJw8rJvUcK5opXNLI84G0LDjbUBXEqOIkkzEBzKgYHDsnAK/g4goLcpf+XxC7nbjNyusgvP5YJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004978; c=relaxed/simple;
	bh=4jlamZdGevMQhmRlakFM+RZJoM+8Sn+L8wwQZntPgbE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ck84yizdN+ZP9J+R3zLtYMq5PA9uO4AJQoCM8v+p5aoHOW5FTTd1gRdegP48o+WUBfJQ2zV9PP71gAEIU5n/CLqHmDgYt/Edf+q0G1tnKU5GVURnKKYbd7JaNtdhbuH7P+E6f5F51d4JOzeMRBkaZjDCX1swuBjlvBVTM3W86gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-430da49fb0aso49348645ab.0
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 17:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004976; x=1761609776;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGtGnSMcxz8uRlspj8XhrY0JQrEt5g0a6j8yhS08xiY=;
        b=AugLeidu4BrizJjY6w5KYN+qgPfoJ4m+mJfYvh/S6bmt+XOdWCyO+jDs2qOD6quj/A
         Rf2M1NMqM7aPk0VGK0Ek5/Mx4Z75lucseAPjQgGp37qeLhOGrfXMWQ+qUdykBHXKiJHk
         MBjib1AB0OOiTFSvmzzDeplZc6sT6WFNHo1UZXdZVKHWIIcb0B2+fojlzxQWlSRJ4g0o
         xeiQFya3uWTvm8m1cV8Z05UBH0Tl+Lhl/L/rxp8RcNTh43I7qVYFiiJdQpffOOW7KiCn
         nFZ8WI+L4PVLCIAnFiYloYLJcP2ztiddyEwcDflwVGG3SQpTE8UiCgBN348Fwmw6DyIX
         SnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfJ0ix0p2QmgMQH8kECIooJl9wfIjHXb4zOXnwbgwlN8LWa9kF1xVnUSRm5t55Vys09qC/N8jl83yR9Vrpag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz0mNWSy31Ed+KhWXXw3yO9HrDCySlyEMfMdjmrbOzvpY8xNOn
	K/KSFAsk3qEe49k77fTf9iHaKHJDt47/biQUZ+rLc73QOjwE91wJaZq8tvWieV5NRBTxxF8Zdj2
	nwQPdARGxHRBTAe2fAdCOl1h9a/fr+HkFy++FNoefL/MVP2sflS/jg+rYCkE=
X-Google-Smtp-Source: AGHT+IEmG+qDHLq+vF+wGve5vCFuV2izBRmasF6GBoQY1Gaf6l+lphX6gWoaecZ2wp1icepziYRG3QQDdn/btL3OCMLOtLGh7NLA
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4415:20b0:430:c536:cfad with SMTP id
 e9e14a558f8ab-430c536d097mr177309805ab.16.1761004976084; Mon, 20 Oct 2025
 17:02:56 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:02:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Subject: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
From: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d9043c79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0546b6eaf1aa/vmlinux-d9043c79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/81285b4ada51/bzImage-d9043c79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6098 is trying to acquire lock:
ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066

but task is already holding lock:
ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (vsock_register_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       vsock_registered_transport_cid net/vmw_vsock/af_vsock.c:560 [inline]
       vsock_find_cid net/vmw_vsock/af_vsock.c:570 [inline]
       __vsock_bind+0x1b5/0xa10 net/vmw_vsock/af_vsock.c:752
       vsock_bind+0xc6/0x120 net/vmw_vsock/af_vsock.c:1002
       __sys_bind_socket net/socket.c:1874 [inline]
       __sys_bind_socket net/socket.c:1866 [inline]
       __sys_bind+0x1a7/0x260 net/socket.c:1905
       __do_sys_bind net/socket.c:1910 [inline]
       __se_sys_bind net/socket.c:1908 [inline]
       __x64_sys_bind+0x72/0xb0 net/socket.c:1908
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_VSOCK){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
       virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
       virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
       vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
       vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1578
       __sys_connect_file+0x141/0x1a0 net/socket.c:2102
       __sys_connect+0x13b/0x160 net/socket.c:2121
       __do_sys_connect net/socket.c:2127 [inline]
       __se_sys_connect net/socket.c:2124 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2124
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(vsock_register_mutex);
                               lock(sk_lock-AF_VSOCK);
                               lock(vsock_register_mutex);
  lock(sk_lock-AF_VSOCK);

 *** DEADLOCK ***

1 lock held by syz.0.17/6098:
 #0: ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469

stack backtrace:
CPU: 3 UID: 0 PID: 6098 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
 lock_sock include/net/sock.h:1679 [inline]
 vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
 virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
 virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
 vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
 vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1578
 __sys_connect_file+0x141/0x1a0 net/socket.c:2102
 __sys_connect+0x13b/0x160 net/socket.c:2121
 __do_sys_connect net/socket.c:2127 [inline]
 __se_sys_connect net/socket.c:2124 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2124
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f767bf8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0a2857b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f767c1e5fa0 RCX: 00007f767bf8efc9
RDX: 0000000000000010 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007f767c011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f767c1e5fa0 R14: 00007f767c1e5fa0 R15: 0000000000000003
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
