Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AC6FBF
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776996156; cv=none; b=kmj9OPggiaH7jnyNFodqehbrVba4cGG+BFCwNMHnB43B7Oef88YTJBdKQSQ0Hj20QZ15paelSvPu2ZY3L0HBzC9qy7rVgcArqsZ1KQd+vZe0FkD4Al0KYKwHjSuWYp3SN2opTgY0JwRMJjRL0upLoYxX0/Qn5wNJ/0o8E5mnixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776996156; c=relaxed/simple;
	bh=Ix1ii9fXrEzTcqkCz+c0607KCuN/OSfpHXVOLLAAlk8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HiKvI4EVdQ3XlTSofxNtQP2VmOv5Y7Qp4tiFqiRQKvxtXyb+voeS19AFD+bN0BQwCkqSaIRKqacPcQkimdEDl4L7MuyJVlAeVe9cUiEO1eNxDvK8upifpCDQHagpQlYq8lXEWWOXooyGsEQOoYeytM0mU8+qkbFoAB/BjTRNrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-40f09403c56so15942463fac.1
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 19:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776996153; x=1777600953;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3uC8NU4AwArWZSQvkNDOrhg+SGZrdOSXtX1ixWx9v0=;
        b=awn6l2MsfD05PWrgyWdL8NpIaOWNMNW7a4El02rrWGnE6YIBzwhU+18odx89nAkJMy
         QFyEXLbSKP5oqaf+JZXfm5ADUGO26VDflkIy/hb8TJF08H6CcSgAbtlXXwtmMq4aUmFc
         JbmZkC7MZ4FUN06MsnpU476wWex5eJDbXQHHJmmAZO8jYj0qp6Nrrp2+wHu625xshDl4
         DSc9F8hWJIMTl3qbBIx035vOHEese6X+CA9OEVmIebCP9osqNqIKfmdjK8ynqi6phfsN
         Havc3ykEdReGqIjJ1dprydYbTPAqKvX4G64plUIOw9284wm3Z4Vzh9xEmew5g8c4TQBr
         +Rtg==
X-Forwarded-Encrypted: i=1; AFNElJ+ltBBeweetpPabL/RosHPWXD22Vak3LwlbUj/hvtSaVOBHx0GSNZEra10B/Gl/hAZHzsJMlnV+6yAhb71j4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1WV0PxIhbyOlwD2XsSPXRhdpcKA1kHtsVNeoHKPSvX9kaoKO0
	iBwcy97ZhepAlhY6rTxo9b/rIs4qHmOLw2l4dSro6n+i8ogE8ShrF4wXdHk9kXw5FOtmjg6C3hF
	52u9MlOQk4R0Uyvxb7DC3/q7/3QgiogQ7ZbUUTeOV313e5e3c7lzg3OtNAak=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8589:20b0:687:5a16:dea1 with SMTP id
 006d021491bc7-6946381984emr10914198eaf.28.1776996153506; Thu, 23 Apr 2026
 19:02:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 19:02:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69eacf39.a00a0220.17a17.004d.GAE@google.com>
Subject: [syzbot] [virt?] [net?] memory leak in __vsock_create (2)
From: syzbot <syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1f318b96cc84 Linux 7.0-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14db28ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12db28ba580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1215175a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4ebd240d832/disk-1f318b96.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9548f49a7dec/vmlinux-1f318b96.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4e16f2bcfc7d/bzImage-1f318b96.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com

2026/03/09 23:37:29 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888128bb6d00 (size 1272):
  comm "kworker/0:1", pid 10, jiffies 4294944453
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc 31367ed9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4876
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2239
    sk_alloc+0x36/0x460 net/core/sock.c:2301
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:893
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1557 [inline]
    virtio_transport_recv_pkt+0x855/0xfc0 net/vmw_vsock/virtio_transport_common.c:1685
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881141e93a0 (size 32):
  comm "kworker/0:1", pid 10, jiffies 4294944453
  hex dump (first 32 bytes):
    f8 6e 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .n..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc e7f5c8b3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_sock_alloc security/security.c:4375 [inline]
    security_sk_alloc+0x2d/0x290 security/security.c:4391
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2248
    sk_alloc+0x36/0x460 net/core/sock.c:2301
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:893
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1557 [inline]
    virtio_transport_recv_pkt+0x855/0xfc0 net/vmw_vsock/virtio_transport_common.c:1685
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888128bfa8a0 (size 96):
  comm "kworker/0:1", pid 10, jiffies 4294944453
  hex dump (first 32 bytes):
    00 6d bb 28 81 88 ff ff 00 00 00 00 00 00 00 00  .m.(............
    00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00  ................
  backtrace (crc 1fd60988):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __kmalloc_cache_noprof+0x377/0x480 mm/slub.c:5378
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    virtio_transport_do_socket_init+0x2b/0xf0 net/vmw_vsock/virtio_transport_common.c:923
    vsock_assign_transport+0x309/0x3a0 net/vmw_vsock/af_vsock.c:642
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1575 [inline]
    virtio_transport_recv_pkt+0x8bc/0xfc0 net/vmw_vsock/virtio_transport_common.c:1685
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888129e1e800 (size 1272):
  comm "kworker/1:3", pid 5832, jiffies 4294944454
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc 4bfb7c57):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4876
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2239
    sk_alloc+0x36/0x460 net/core/sock.c:2301
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:893
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1557 [inline]
    virtio_transport_recv_pkt+0x855/0xfc0 net/vmw_vsock/virtio_transport_common.c:1685
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888114372e80 (size 32):
  comm "kworker/1:3", pid 5832, jiffies 4294944454
  hex dump (first 32 bytes):
    f8 6e 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .n..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc e7f5c8b3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __do_kmalloc_node mm/slub.c:5262 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5275
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_sock_alloc security/security.c:4375 [inline]
    security_sk_alloc+0x2d/0x290 security/security.c:4391
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2248
    sk_alloc+0x36/0x460 net/core/sock.c:2301
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:893
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1557 [inline]
    virtio_transport_recv_pkt+0x855/0xfc0 net/vmw_vsock/virtio_transport_common.c:1685
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881054d0ea0 (size 96):
  comm "kworker/1:3", pid 5832, jiffies 4294944454
  hex dump (first 32 bytes):
    00 e8 e1 29 81 88 ff ff 00 00 00 00 00 00 00 00  ...)............
    00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00  ................
  backtrace (crc 72501265):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4547 [inline]
    slab_alloc_node mm/slub.c:4869 [inline]
    __kmalloc_cache_noprof+0x377/0x480 mm/slub.c:5378
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    virtio_transport_do_socket_init+0x2b/0xf0 net/vmw_vsock/virtio_transport_common.c:923
    vsock_assign_transport+0x309/0x3a0 net/vmw_vsock/af_vsock.c:642
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1575 [inline]
    virtio_transport_recv_pkt+0x8bc/0xfc0 net/vmw_vsock/virtio_transport_common.c:1685
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
