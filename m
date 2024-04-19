Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566478676
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519563; cv=none; b=V60cYHP2Xs6iUKirmFLb47UnG5OK7ws2omd4ikFNUx5A1MDMCj32ADdtemd4C82vmGzbIZYzTBJxIcxWhKJLbpPaV5m4D7w8GsNtbNzP2H7tCNhMdJdr/Qo2E/Y0nBXZKr1jKQoaqaGRoAeWF6MF5NgY4SluvFvMv8eh9eVfj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519563; c=relaxed/simple;
	bh=6jZSfvpaaCKq0bj6HshxiI6mvjEzGREzydJPX5Hx7QA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ddAaYBMgzG2BNyFrhFQ1yhop4E2uR8H29KOM7pBHpD1DXaJRK5/nW8qaWkXQhTKZ3DRXMCCk75Z/mCSJithD1n0XEBWEbQ8cY2Q+We7VuPKzobzk2PPdd8M99YfaFsvZbyEhyRWGDhJGT2q6Ht3B9UaaZREDoS4yqRnyE6nX348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da41c4b1eeso115933139f.2
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713519561; x=1714124361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODz03erUT5lzWIHfBAq/6sw2VW7YfSONQgBGKH/0fxg=;
        b=thF88YKLePlACx7ZHtRsUiSDPgS0FV3xe55QDB1njswsAg19t+7bmT7woVv5dkYxPZ
         doWpXw2gv+4tj0QvYMi5azIFJuQeDup6ORwXz5UqO5lqLKdcPN5/6WRc+jMDINagvop9
         j/JP3KTnoh/wUrj9EsgehpNL9CJuP2WwPTdQC5esk7Ore9rtzb5xiWyUD/NT0I1dke4f
         ghOOeohWeh7oat6rVJqkgqGzrh8SOlKMik1FgA6pjS7SjTY7Sg4A3aMqMjkuuU82A537
         7jcgbK5aWEKmmh3Bf4Ad9lEG3H+r85fMgVMh/6DaYyG/ibjtBPSLIG1yCcJRcECbfnzE
         vknA==
X-Forwarded-Encrypted: i=1; AJvYcCWIeROCfvpYsdNvID9EwS/mAxTON9LvpTNzv2WW2g8Uvo2I3piwPN9xN+X/ykLbt6FauUYDRLTpW180kf9VS23iHsiMrYTLWsKCBUmpqVI=
X-Gm-Message-State: AOJu0YywAuUdwz4TP5hTcn2vBUh0+6b+4m1YnFjnLiA8AHe5WDSqSve9
	AAbSiKDUXhBWODapOf/DklvEEuNJp9qwSM+hyA2MHavYVl8IACS5+91/uRndquLCCaAJDyQyI3e
	YMH40pZQQ0yw7lypGUEnU9Cgk0EObFLBlPbkJZ9FsNU0V06I65PxvI1k=
X-Google-Smtp-Source: AGHT+IEJ9Ehw0UhWltGbzxsJAftrUeesQISQsqjJJIr8Psi97w8LN8Pw9FgIykxBpjSAzIn1CZxAdiJtph5FMolLQC/uEHB4vBX4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:f0a:b0:7cc:2522:f5fd with SMTP id
 hl10-20020a0566020f0a00b007cc2522f5fdmr24643iob.1.1713519560898; Fri, 19 Apr
 2024 02:39:20 -0700 (PDT)
Date: Fri, 19 Apr 2024 02:39:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be4e1c06166fdc85@google.com>
Subject: [syzbot] [virt?] [net?] KMSAN: uninit-value in vsock_assign_transport (2)
From: syzbot <syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8cd26fd90c1a Merge tag 'for-6.9-rc4-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=102d27cd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=6c21aeb59d0e82eb2782
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e38c3b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e62fed180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/488822aee24a/disk-8cd26fd9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba40e322ba00/vmlinux-8cd26fd9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f30af1dfbc30/bzImage-8cd26fd9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in vsock_assign_transport+0xb2a/0xb90 net/vmw_vsock/af_vsock.c:500
 vsock_assign_transport+0xb2a/0xb90 net/vmw_vsock/af_vsock.c:500
 vsock_connect+0x544/0x1560 net/vmw_vsock/af_vsock.c:1393
 __sys_connect_file net/socket.c:2048 [inline]
 __sys_connect+0x606/0x690 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x91/0xe0 net/socket.c:2072
 x64_sys_call+0x3356/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:43
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 vhost_vsock_dev_open+0x44/0x510 drivers/vhost/vsock.c:659
 misc_open+0x66b/0x760 drivers/char/misc.c:165
 chrdev_open+0xa5f/0xb80 fs/char_dev.c:414
 do_dentry_open+0x11f1/0x2120 fs/open.c:955
 vfs_open+0x7e/0xa0 fs/open.c:1089
 do_open fs/namei.c:3642 [inline]
 path_openat+0x4a3c/0x5b00 fs/namei.c:3799
 do_filp_open+0x20e/0x590 fs/namei.c:3826
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1432
 x64_sys_call+0x3a64/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5021 Comm: syz-executor390 Not tainted 6.9.0-rc4-syzkaller-00038-g8cd26fd90c1a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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
