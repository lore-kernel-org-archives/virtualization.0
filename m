Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A13112AB
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309385; cv=none; b=iMbE3dlkZZC4Kj9gMLmi+X4A9d2HEvZJALD2ogKIuwdk3L9u+KRn881x9IllIjnKgUcZcjZXbs0udKpxkn8xovacr810ag9p29ljkFi4OkzgVIz/P6qt4KgqxFuIkchpG8FVam/C3wfRiBCkIKsugAq2fw+hpJZOtpOb03EQk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309385; c=relaxed/simple;
	bh=luA2KX0Z34rhPkgzK7yNqNk7xkX7wwA6aGAVl+/mfao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fp/O0ICOIVvMJl5eofdTe1ScoAuRUVWMdf9BGLeCPJDao12fsfFz12KeClj6ms7Ix8ght+68BJBH1bGe5k4o9OLDxRoL1O/OBcSmTSzoOtcjxVI6mzmz5STED01sgzW2sjm8d3M1bs/67rBUFeJ9JlJDMiegpgFBNPv+p2CTTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c76bfd7b9cdso4221628a12.3
        for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 10:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309383; x=1777914183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqkLNi8dFGLs0xZQNCmzoFuZ2bTIPgGk7WM+gkuVShA=;
        b=k8dESzyW2IkNkuJAV6+pd7ZP6h0c7YOzg+Aj6DUuND20YK7ZVZuM0blAGGQAd3hAIX
         /w0Z9yXAPzK3+cxlYXeI0B8w7Uid5Ouh+oAdLVTqSmF+FsaBMUMtJv33OG6GElRSLcfX
         E0KT4OFAxKTQOjr2eZaEMEzlFYsXfsr3aTYvYTm1SW/jq/S/q+BBPAlD38BsPiEWdSVG
         UrfVUE6hYx0AJT44ebwqq/7iHuJU+X3gY3Eexi27tpz3Ohlifh+m/NCHb2/s0ym5ptmD
         yTBGz5MCIix9ldIqpHP4TJf8PTxei4xTM3PAH5Hi5fK+Ln02VxLNjBiF0xf+6gYnH1lL
         EVNA==
X-Forwarded-Encrypted: i=1; AFNElJ8k7WUIhbOqeUp3UeLUpQNBEydBEkjM+KWSEEcFdo9sW6tTFthNYgWk9snFlGY7zQRymz4BRkCiYNlfOOvAlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJPOTod32xZ37c+A8fKNMBuduf0QCt8jpfAdOdoQSb/K2hlzIE
	HGQ3KX77Qi6THVAh7sqC0XmKsHuIr9TxPRc2d/1Ue/VFFWyuqprzh5EPr/YPav3ycxzorgxN+sw
	Ud8m0sbD1EG3LcJBJiGNFh6BcAxtHVcbJQ6kQj45KNxmNCFvZTkcad5w2UjA=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6a20:4311:b0:39b:e40b:fcae with SMTP id
 adf61e73a8af0-3a398c0323fmr237146637.10.1777309382959; Mon, 27 Apr 2026
 10:03:02 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:03:02 -0700
In-Reply-To: <ae-MTiL0vf-y7Ygz@sgarzare-redhat>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ef96c6.a00a0220.38d690.0001.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] memory leak in __vsock_create (2)
From: syzbot <syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in prepare_creds

2026/04/27 17:01:37 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888103b7b900 (size 184):
  comm "syz-executor", pid 6458, jiffies 4294946243
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5efbd4bc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    kmem_cache_alloc_noprof+0x36c/0x480 mm/slub.c:4905
    prepare_creds+0x22/0x600 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x920/0x2cf0 kernel/fork.c:2123
    kernel_clone+0xde/0x700 kernel/fork.c:2723
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2864
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810ad103a0 (size 32):
  comm "syz-executor", pid 6458, jiffies 4294946243
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 56 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .V..............
  backtrace (crc 109407f3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:218
    lsm_cred_alloc security/security.c:235 [inline]
    security_prepare_creds+0x2d/0x290 security/security.c:2866
    prepare_creds+0x395/0x600 kernel/cred.c:215
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x920/0x2cf0 kernel/fork.c:2123
    kernel_clone+0xde/0x700 kernel/fork.c:2723
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2864
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888111516800 (size 1272):
  comm "kworker/1:3", pid 5684, jiffies 4294946243
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc 5e448183):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    kmem_cache_alloc_noprof+0x36c/0x480 mm/slub.c:4905
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2241
    sk_alloc+0x36/0x460 net/core/sock.c:2303
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:907
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1566 [inline]
    virtio_transport_recv_pkt+0x88d/0xfb0 net/vmw_vsock/virtio_transport_common.c:1693
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88812daab5e0 (size 32):
  comm "kworker/1:3", pid 5684, jiffies 4294946243
  hex dump (first 32 bytes):
    f8 56 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .V..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 79381f4a):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:218
    lsm_sock_alloc security/security.c:4478 [inline]
    security_sk_alloc+0x2d/0x290 security/security.c:4494
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2250
    sk_alloc+0x36/0x460 net/core/sock.c:2303
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:907
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1566 [inline]
    virtio_transport_recv_pkt+0x88d/0xfb0 net/vmw_vsock/virtio_transport_common.c:1693
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b1a75a0 (size 96):
  comm "kworker/1:3", pid 5684, jiffies 4294946243
  hex dump (first 32 bytes):
    00 68 51 11 81 88 ff ff 00 00 00 00 00 00 00 00  .hQ.............
    00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00  ................
  backtrace (crc 428f2031):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __kmalloc_cache_noprof+0x371/0x480 mm/slub.c:5410
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    virtio_transport_do_socket_init+0x2b/0xf0 net/vmw_vsock/virtio_transport_common.c:925
    vsock_assign_transport+0x3a3/0x460 net/vmw_vsock/af_vsock.c:656
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1582 [inline]
    virtio_transport_recv_pkt+0x8e5/0xfb0 net/vmw_vsock/virtio_transport_common.c:1693
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888111516300 (size 1272):
  comm "kworker/1:3", pid 5684, jiffies 4294946244
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc e1cd45d1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    kmem_cache_alloc_noprof+0x36c/0x480 mm/slub.c:4905
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2241
    sk_alloc+0x36/0x460 net/core/sock.c:2303
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:907
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1566 [inline]
    virtio_transport_recv_pkt+0x88d/0xfb0 net/vmw_vsock/virtio_transport_common.c:1693
    vsock_loopback_work+0x104/0x140 net/vmw_vsock/vsock_loopback.c:142
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         39ff9a4a vsock/virtio: fix socket leak on close_timeou..
git tree:       https://github.com/stefano-garzarella/linux.git fix-syzbot-memleak-vsock-create
console output: https://syzkaller.appspot.com/x/log.txt?x=1742b896580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfcc8f993a958a78
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
