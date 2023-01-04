Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDDAC4708D
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 03:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D2C761000;
	Wed,  4 Jan 2023 03:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D2C761000
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLlbIW2k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GsDzAHqUnhOq; Wed,  4 Jan 2023 03:39:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 284B160FFD;
	Wed,  4 Jan 2023 03:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 284B160FFD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6C26C0032;
	Wed,  4 Jan 2023 03:39:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE95C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 03:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 046D2400DD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 03:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 046D2400DD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLlbIW2k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lc3zF_CkHQCH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 03:39:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67DAD400FE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67DAD400FE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 03:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672803567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLEOnNfnmWkj2vt/eKqMGmTtrEyeN38VkEbI9YRGYgo=;
 b=YLlbIW2k5IsX/mqxNxPnDtIMDSr4zJXgHBbe0VH1f/qDu870mfwBSGknzL3Vnqph/n7Z7A
 WA2/sv3Q02PfnEp6qC2m3/UkXdJ8u8X87M71UeQFqjWOOnaRWm0IRx5Zjc4cbUYoQY1sHt
 2YnrPy6Zg9sUZgNiFgP0JaDodM3oV6w=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-523-T1NJ4HE8ORmqFOGVKWGuXg-1; Tue, 03 Jan 2023 22:39:25 -0500
X-MC-Unique: T1NJ4HE8ORmqFOGVKWGuXg-1
Received: by mail-ot1-f72.google.com with SMTP id
 e15-20020a0568301e4f00b006783b3a27c3so16904579otj.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Jan 2023 19:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zLEOnNfnmWkj2vt/eKqMGmTtrEyeN38VkEbI9YRGYgo=;
 b=q4ixBqZrGbZ/RpbXNww77qS4canFSyS96u9/E2P2cmTAZhbPGPJw+iBOfd9Id0dwVw
 lsPJ0ZOnEAmnDCpqayx0imEzHjBRM2K9mKcS9IKtHuMiacjHn953cTEFHIPWRKhXt6eR
 A43q5+E841MvhfsyViWqS0avcKTbAuT4SC0HQ5Yj15W0Aix0jtmi+KPJ3k4HKIgxd8Cf
 rDwXG6J1Bm3EXRe0xWLEed9/al2aldnMSlc4t+izW00a2gi21OS6F9gKQVNFafeD8fcJ
 l389X5wjxDG9p79PYIpbjBCC571LissoYW997qEstGmm3m3GL1vVqZAKNNuWB61cO+Sa
 V7Zw==
X-Gm-Message-State: AFqh2krXrZLWup5GTA6wjqdsFj7nlJVRRI6DX9qjUe5JDy/jFdGTs2lP
 ao/ccLVBIk4rLobpiVtYPfi9BDJrAi8bSlP0hcSqzEB3pA2/dwEzN/sogh0zMCBHBK/+a34KZlD
 xjL89lq5n2puwRqxJFoi+QPFOQNaSnchSWq8Eno4ueMwSPccGzRhP91Bezg==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr2348268oah.35.1672803564724; 
 Tue, 03 Jan 2023 19:39:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVz1cKwujH6GJv25hk0r6sfgtJJRuq35xoLxJxoW7+KupoECbyLNoo6T6L/PrFgD6xJ2gklNlIzgvWJxAkF8c=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr2348254oah.35.1672803564372; Tue, 03
 Jan 2023 19:39:24 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005315c105f1652480@google.com>
In-Reply-To: <0000000000005315c105f1652480@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Jan 2023 11:39:13 +0800
Message-ID: <CACGkMEv7Dbat08DJw3SQ3QXK7H73aYLAMB0jLkuAmyYkLf_Q=w@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in rds_message_put
To: syzbot <syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Cc: rds-devel@oss.oracle.com, mst@redhat.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, santosh.shilimkar@oracle.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jan 4, 2023 at 8:19 AM syzbot
<syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c183e6c3ec34 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1161aa7c480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8ca07260bb631fb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=f9db6ff27b9bfdcfeca0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1370b478480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab141a480000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9b693820fb05/disk-c183e6c3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e449d80e60dc/vmlinux-c183e6c3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/08e31763ce79/bzImage-c183e6c3.xz
>
> The issue was bisected to:
>
> commit 1628c6877f371194b603330c324828d03e0eacda
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Mon Jan 4 06:55:02 2021 +0000
>
>     virtio_vdpa: don't warn when fail to disable vq
>

There's little chance for this commit to be the first bad one. It only
removes a WARN_ON().

Thanks

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1479f7da480000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1679f7da480000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1279f7da480000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com
> Fixes: 1628c6877f37 ("virtio_vdpa: don't warn when fail to disable vq")
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.1.0-syzkaller-11778-gc183e6c3ec34 #0 Not tainted
> ------------------------------------------------------
> syz-executor390/18169 is trying to acquire lock:
> ffff8880763af100 (&rm->m_rs_lock){..-.}-{2:2}, at: rds_message_purge net/rds/message.c:138 [inline]
> ffff8880763af100 (&rm->m_rs_lock){..-.}-{2:2}, at: rds_message_put+0x1dd/0xc20 net/rds/message.c:180
>
> but task is already holding lock:
> ffff88802afafa70 (&rs->rs_recv_lock){...-}-{2:2}, at: rds_clear_recv_queue+0x33/0x350 net/rds/recv.c:761
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&rs->rs_recv_lock){...-}-{2:2}:
>        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
>        _raw_read_lock_irqsave+0x49/0x90 kernel/locking/spinlock.c:236
>        rds_wake_sk_sleep+0x23/0xe0 net/rds/af_rds.c:109
>        rds_send_remove_from_sock+0xb9/0x9e0 net/rds/send.c:634
>        rds_send_path_drop_acked+0x2f3/0x3d0 net/rds/send.c:710
>        rds_tcp_write_space+0x1b5/0x690 net/rds/tcp_send.c:198
>        tcp_new_space net/ipv4/tcp_input.c:5483 [inline]
>        tcp_check_space+0x11b/0x810 net/ipv4/tcp_input.c:5502
>        tcp_data_snd_check net/ipv4/tcp_input.c:5511 [inline]
>        tcp_rcv_established+0x93e/0x2230 net/ipv4/tcp_input.c:6019
>        tcp_v4_do_rcv+0x670/0x9b0 net/ipv4/tcp_ipv4.c:1721
>        sk_backlog_rcv include/net/sock.h:1113 [inline]
>        __release_sock+0x133/0x3b0 net/core/sock.c:2928
>        release_sock+0x58/0x1b0 net/core/sock.c:3485
>        rds_send_xmit+0xafc/0x2540 net/rds/send.c:422
>        rds_sendmsg+0x27d3/0x3080 net/rds/send.c:1381
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        sock_sendmsg+0xd3/0x120 net/socket.c:734
>        __sys_sendto+0x23a/0x340 net/socket.c:2117
>        __do_sys_sendto net/socket.c:2129 [inline]
>        __se_sys_sendto net/socket.c:2125 [inline]
>        __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2125
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> -> #0 (&rm->m_rs_lock){..-.}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3097 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>        validate_chain kernel/locking/lockdep.c:3831 [inline]
>        __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
>        lock_acquire kernel/locking/lockdep.c:5668 [inline]
>        lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
>        rds_message_purge net/rds/message.c:138 [inline]
>        rds_message_put+0x1dd/0xc20 net/rds/message.c:180
>        rds_inc_put net/rds/recv.c:82 [inline]
>        rds_inc_put+0x13e/0x1a0 net/rds/recv.c:76
>        rds_clear_recv_queue+0x14b/0x350 net/rds/recv.c:767
>        rds_release+0xd8/0x3c0 net/rds/af_rds.c:73
>        __sock_release+0xcd/0x280 net/socket.c:650
>        sock_close+0x1c/0x20 net/socket.c:1365
>        __fput+0x27c/0xa90 fs/file_table.c:320
>        task_work_run+0x16f/0x270 kernel/task_work.c:179
>        resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>        exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>        exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
>        __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>        syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
>        do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&rs->rs_recv_lock);
>                                lock(&rm->m_rs_lock);
>                                lock(&rs->rs_recv_lock);
>   lock(&rm->m_rs_lock);
>
>  *** DEADLOCK ***
>
> 2 locks held by syz-executor390/18169:
>  #0: ffff8880719a3210 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
>  #0: ffff8880719a3210 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release+0x86/0x280 net/socket.c:649
>  #1: ffff88802afafa70 (&rs->rs_recv_lock){...-}-{2:2}, at: rds_clear_recv_queue+0x33/0x350 net/rds/recv.c:761
>
> stack backtrace:
> CPU: 0 PID: 18169 Comm: syz-executor390 Not tainted 6.1.0-syzkaller-11778-gc183e6c3ec34 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
>  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
>  check_prev_add kernel/locking/lockdep.c:3097 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>  validate_chain kernel/locking/lockdep.c:3831 [inline]
>  __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
>  lock_acquire kernel/locking/lockdep.c:5668 [inline]
>  lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
>  rds_message_purge net/rds/message.c:138 [inline]
>  rds_message_put+0x1dd/0xc20 net/rds/message.c:180
>  rds_inc_put net/rds/recv.c:82 [inline]
>  rds_inc_put+0x13e/0x1a0 net/rds/recv.c:76
>  rds_clear_recv_queue+0x14b/0x350 net/rds/recv.c:767
>  rds_release+0xd8/0x3c0 net/rds/af_rds.c:73
>  __sock_release+0xcd/0x280 net/socket.c:650
>  sock_close+0x1c/0x20 net/socket.c:1365
>  __fput+0x27c/0xa90 fs/file_table.c:320
>  task_work_run+0x16f/0x270 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>  exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
>  do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f4a3a75f5fb
> Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 03 fd ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 41 fd ff ff 8b 44
> RSP: 002b:00007ffff26fde60 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f4a3a75f5fb
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 0000000000000032 R08: 0000000000000000 R09: 00007f4a3a7f51ae
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007f4a3a8284ec
> R13: 00007ffff26fdeb0 R14: 00007ffff26fded0 R15: 00007ffff26fdf40
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
