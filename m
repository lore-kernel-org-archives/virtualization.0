Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36874125BA
	for <virtualization@lists.linux.dev>; Sat, 15 Jun 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718451801; cv=none; b=rmduxve25ron193aCiy9jgptfC15tpe6yJd0l1p2Cqq4PeV0XNqojRJPmxNd0GitjhWkIzknafJDf/gcB94REs1j5sa5BeO1OKsL44v+dRYRS2UPi9ywJbnSuHZehQcLqiZ1NmkTLtDBmuJE+TOaf1vRehhosmVGNQAdFe5hVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718451801; c=relaxed/simple;
	bh=aU+8CTN/tk+oMmXRLpbMCzpvKN/mFsYasuWq3wZilMA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e0+t1cfsXzTWIkGS69L88eOOPUP4e/6hCg7LJRp2yeesoLTWMSk9e0xG0FpkZjk0p4Ycp5esEjxOi3jUnD2puFZ9BQewxDDPIiSu0VpYGOczD2XheAZ7N4h8avf666r0flpvpAh6n80aIzLXEcZ3DqZyRjxOHVzkNZbEF2seoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3746147204eso34240025ab.3
        for <virtualization@lists.linux.dev>; Sat, 15 Jun 2024 04:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718451799; x=1719056599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwrKewFKoP1Xv38Ej/vpUeQCnneXPV1+0WWIZaMLWQc=;
        b=TLeeWKRPbpFMJWLLHHghbZZVmbxSFZbzncyA+ZSGy+NMwYk0B5iyJwKDNRXAO82kz/
         rjSCUs0MTZZQd0H1WJp3dZsicpu7oaHha4WqNYStxJskRsWROEpaS3o5ybtrSLfYTk41
         g3DHhPcmxYa0S9jFLUaFJQZLbS5b/9VRlL06KuNGlkfwkZs6uFEpBbJ+TMBNMHGQf11o
         k4qRlNzIQ3tVEStkRoEveCi1SXXpQOBcG8Z80xZ0vZmRZVt/Rse9GPIcVwNXne7HNyON
         4bjW0XmX/gI0Ge6Z52jYBkOREzDOkwNRAbFqQTQwY7MXLglEW5prSrwft3KGMnr86Jf8
         1nXA==
X-Forwarded-Encrypted: i=1; AJvYcCXf2oaub5hEl/d+VrGXRD2qUxzxb2KpG3/fhzCtTiNKmIFkS3ILcegJMw3sGYg9jmPR7AZtJf6K3lDUbzDM9v+CE7ML96i2jp6TQ51vxM8=
X-Gm-Message-State: AOJu0YyqLKqF2cSn/v6UQqabs0cMHmhuFfioZx0ZDCB7Z4nA5Y+TIwpS
	1MypQrHxiq78Jk/MOq4+eO0tAARWMjl8Q2IMXHAuWiUJ2TQvfGjAJOtfeHXhxjub9WRnKLMFSDO
	jGJxFyh/j2NZyHsINYhirYL7aMhCRAXjwHuACJFtaytLSsA6O4+Qvsz4=
X-Google-Smtp-Source: AGHT+IEmSHSQKL/7cN39gvwoti//yUMRW0eg937Fpjz0egPydK0xGOW+zSVXhF3HkuY2KKHTFNoBjKfRp+eDjPjfOTPhN3qZm5v2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:375:a56d:7719 with SMTP id
 e9e14a558f8ab-375e0e03811mr2934935ab.1.1718451799375; Sat, 15 Jun 2024
 04:43:19 -0700 (PDT)
Date: Sat, 15 Jun 2024 04:43:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010d827061aec3de0@google.com>
Subject: [syzbot] [virt?] KMSAN: uninit-value in virtqueue_add (5)
From: syzbot <syzbot+64dd7c1298e0b0da9299@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116670b6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=64dd7c1298e0b0da9299
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64dd7c1298e0b0da9299@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
BUG: KMSAN: uninit-value in virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
BUG: KMSAN: uninit-value in virtqueue_add+0x1e86/0x65c0 drivers/virtio/virtio_ring.c:2210
 vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
 virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
 virtqueue_add+0x1e86/0x65c0 drivers/virtio/virtio_ring.c:2210
 virtqueue_add_sgs+0x186/0x1b0 drivers/virtio/virtio_ring.c:2244
 __virtscsi_add_cmd drivers/scsi/virtio_scsi.c:471 [inline]
 virtscsi_add_cmd+0x838/0xad0 drivers/scsi/virtio_scsi.c:505
 virtscsi_queuecommand+0x898/0xa60 drivers/scsi/virtio_scsi.c:602
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1609 [inline]
 scsi_queue_rq+0x4cc7/0x5a80 drivers/scsi/scsi_lib.c:1851
 blk_mq_dispatch_rq_list+0x79b/0x3440 block/blk-mq.c:2037
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0x11b7/0x26e0 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0x12f/0x270 block/blk-mq-sched.c:331
 blk_mq_run_work_fn+0xd0/0x280 block/blk-mq.c:2420
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12b7/0x2ae0 lib/iov_iter.c:481
 generic_perform_write+0x4c1/0xc60 mm/filemap.c:3982
 ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
 ext4_file_write_iter+0x208/0x3450
 __kernel_write_iter+0x64d/0xc80 fs/read_write.c:523
 dump_emit_page fs/coredump.c:895 [inline]
 dump_user_range+0x8dc/0xee0 fs/coredump.c:956
 elf_core_dump+0x57c7/0x5ae0 fs/binfmt_elf.c:2083
 do_coredump+0x32d5/0x4920 fs/coredump.c:769
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 dump_user_range+0x4a/0xee0 fs/coredump.c:940
 elf_core_dump+0x57c7/0x5ae0 fs/binfmt_elf.c:2083
 do_coredump+0x32d5/0x4920 fs/coredump.c:769
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 0-4095 of 4096 are uninitialized
Memory access of size 4096 starts at ffff88804137f000

CPU: 0 PID: 55 Comm: kworker/0:1H Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: kblockd blk_mq_run_work_fn
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
