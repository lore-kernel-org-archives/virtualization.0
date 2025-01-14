Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045C14A60C
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866627; cv=none; b=s0baPQbCt8SxNiap6VLQUWiI9kxBx3fBQHAt+68/38IvuHyX7V6xj7G8x50mqsJBaSBM6tvQ2LST5o2KzCocdjTaqy5RNm4J3Qjyd2o9ufBZxcjkVl7AMD+9SurjWtsbcc4oc6a59CZkWKQni1UncG/KMyyvoJVGtkYA2nGzkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866627; c=relaxed/simple;
	bh=HTFA22eNWJxXFnGKKbal3YaEtsluCEy2Muz7cUakN+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XX7F29pHcA99lJJiPYbPBqDsct6l0+y0ZS3Pqgd8ZEb9T9EuPFM+Fu1BAs6PojnuGs/xSRXyET7uPbifLdJZ73hG7q5E4PSVFu5hbxO9Q7AtxttHVFBxii/Ed78xd5gdjq4SLYuXlEWCUSWutUX5MrtDpSGtREU5IaZRreeZItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAoMPtLk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAoMPtLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736866623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VUijakkdh77F1k0oBFns4Mn48JlV8LGd54/qoNY/73c=;
	b=IAoMPtLkyXLkOGH1tWOBr8kiwJ5h30ifZnc3qE0j3sxU5JOPhMmhVG/SHna9X6FC9oNYG/
	+oRUu/1wtp9TkFrqt5C9M8yGWGy9kyswYbkbdUSptMwudllCJc1kOXzqWAJT10Oq+/YZgm
	J/fnWZ+JHZfdavXnFeP5Bpy9okpCR0g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-XplV_asqMCG8b91mpn4IhQ-1; Tue, 14 Jan 2025 09:57:02 -0500
X-MC-Unique: XplV_asqMCG8b91mpn4IhQ-1
X-Mimecast-MFC-AGG-ID: XplV_asqMCG8b91mpn4IhQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38a891d2aa5so2797484f8f.0
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 06:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866621; x=1737471421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUijakkdh77F1k0oBFns4Mn48JlV8LGd54/qoNY/73c=;
        b=twvSGLpq/Fmgr5ucKrBVOUpI6vESozugMWliKrgjZ9+Xd1tWLf/Y/VTFwdvcNePLNa
         jjTge08U2WdjDiExdWYdNduAYliOir//zEjW9tWnsP1KUJFZDPDhPDSwPUpsaNqsx10o
         uGg1oY+WlFBPNzsNw3IRNcniEWOp5CTlhvZjTG3IaXlo1QI7KIny4DjsjcZl19AZZZhA
         C599VAIkZYWFcUKNF//VU0IvbxU3uzyiTol4dkDRRKAD/zuyzf11z3AdC0YVuSrW5L96
         yy/MHvYNz8Ezvbw52yyXFm3LxwyfNWqOuDSoo4UuopWF2AYbBj2JRQUzm3z8JgIukSBp
         V9TA==
X-Forwarded-Encrypted: i=1; AJvYcCU1EWd8rejaOo5Z+ECnCrbXo2c1s3xa/ulyqK6PFQJ8QT5Mx6orzko14+JiewPhjz4rB4BSVY8ngKKKlmVasg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEA/5Jy7RQX3233ZLH2famT0POlws1KyfH78HYxC0d77sm8MiJ
	o2rdL+SWOCEPuLYq5vXLMMghNyed8NG5m4jgM3yA8scDzE/0yyo/SfSVOriWv+aroHYxtQEpZu0
	6p+M01pC7UffjmXU6SRygzox3BoTVtgR/LPMP5q4so6BZYXwh4mJHnEOPKL/Zb0aK
X-Gm-Gg: ASbGncs5qjAymaV7TF5Qa3wChwtdto9/dCIm0hTXRf9DKJ7KZJ8Os2n2TD860hHyouB
	nzAZ2aRCwPVtK4iLDOV6wdR+Gd9wMt8xI6iH5Lb2qo+qubUYoUWMn5Wwgn3zjvpPAm31ZOXlQN1
	zY/yQGqqvGxB8iG+D8E5jqwqZ1oxLdK6Yha6Scp4ACakHYv9gA7N/N+c8EgxLFh9og32dU/KooB
	C/qa3XLhTue69lLODSc2iOtdtKkPFfbSobIpa7RishiSAPnUm3UsELrWCLqwxddXF+OphMWQQEy
	gAb9mmOemgRamNR0MxfWBQ7oMZV7CMZr
X-Received: by 2002:a05:6000:1aca:b0:386:3bde:9849 with SMTP id ffacd0b85a97d-38a8b0caa82mr18421612f8f.12.1736866620901;
        Tue, 14 Jan 2025 06:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCP91uu46e/jEbUuINxGe4a5ZsNPBFZVoE7sSyinJziv16S4z5OLpR3IZRQqC31KBZxEE0xw==
X-Received: by 2002:a05:6000:1aca:b0:386:3bde:9849 with SMTP id ffacd0b85a97d-38a8b0caa82mr18421571f8f.12.1736866620190;
        Tue, 14 Jan 2025 06:57:00 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e3853b6sm14915975f8f.44.2025.01.14.06.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:56:59 -0800 (PST)
Date: Tue, 14 Jan 2025 15:56:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com>
Cc: bobby.eshleman@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux-foundation.org, virtualization@lists.linux.dev
Subject: Re: [syzbot] [net?] [virt?] general protection fault in
 vsock_stream_has_data
Message-ID: <g3mn4fcltag3c6l46s3rxqzpl6mo5hxbv7cnv4fxh2x234t34w@r4zh3zfql4s2>
References: <67867937.050a0220.216c54.007c.GAE@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <67867937.050a0220.216c54.007c.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: 4DQ_qfyAL2pIVoQ8y5Bg0PQ6gZNFodpGuyqXaAA_Zd0_1736866621
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jan 14, 2025 at 06:48:23AM -0800, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    25cc469d6d34 net: phy: micrel: use helper phy_disable_eee
>git tree:       net-next
>console+strace: https://syzkaller.appspot.com/x/log.txt?x=15faeef8580000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=d50f1d63eac02308
>dashboard link: https://syzkaller.appspot.com/bug?extid=71613b464c8ef17ab718
>compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e374b0580000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1778d3c4580000
>
>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/1a1fa1071012/disk-25cc469d.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/3fcf28733f5e/vmlinux-25cc469d.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/ed476a847c4e/bzImage-25cc469d.xz
>
>The issue was bisected to:
>
>commit 71dc9ec9ac7d3eee785cdc986c3daeb821381e20
>Author: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Date:   Fri Jan 13 22:21:37 2023 +0000
>
>    virtio/vsock: replace virtio_vsock_pkt with sk_buff
>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102b1ef8580000
>final oops:     https://syzkaller.appspot.com/x/report.txt?x=122b1ef8580000
>console output: https://syzkaller.appspot.com/x/log.txt?x=142b1ef8580000
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>
>Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN PTI
>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.13.0-rc6-syzkaller-00898-g25cc469d6d34 #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>Workqueue: vsock-loopback vsock_loopback_work
>RIP: 0010:vsock_stream_has_data+0x46/0x70 net/vmw_vsock/af_vsock.c:873

This seems really related to the same issues we tried to fix with the
series [1] we just merged in the net tree [2], so let's try to test if
that series fixes also this report:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 665bcfc982deef247016a9ff679cdf45ae37162c

[1] https://lore.kernel.org/all/20250110083511.30419-1-sgarzare@redhat.com/
[2] https://lore.kernel.org/all/173685543253.4153435.8360593210112873590.git-patchwork-notify@kernel.org/

>Code: 8d 9e 50 05 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 58 82 5c f6 48 8b 1b 48 83 c3 60 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 3b 82 5c f6 4c 8b 1b 4c 89 f7 5b
>RSP: 0018:ffffc900000d7748 EFLAGS: 00010206
>RAX: 000000000000000c RBX: 0000000000000060 RCX: ffff88801cac5a00
>RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888077bf08c0
>RBP: ffff888077bf08c0 R08: ffff888077bf0927 R09: 1ffff1100ef7e124
>R10: dffffc0000000000 R11: ffffed100ef7e125 R12: dffffc0000000000
>R13: ffffffff8ffeb820 R14: ffff888077bf08c0 R15: dffffc0000000000
>FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00007ffca709b000 CR3: 000000007b69c000 CR4: 00000000003526f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> <TASK>
> virtio_transport_do_close+0x64/0x3d0 net/vmw_vsock/virtio_transport_common.c:1214
> virtio_transport_recv_disconnecting net/vmw_vsock/virtio_transport_common.c:1452 [inline]
> virtio_transport_recv_pkt+0x1755/0x2b10 net/vmw_vsock/virtio_transport_common.c:1661
> vsock_loopback_work+0x3e9/0x530 net/vmw_vsock/vsock_loopback.c:133
> process_one_work kernel/workqueue.c:3229 [inline]
> process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
> worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> kthread+0x2f0/0x390 kernel/kthread.c:389
> ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> </TASK>
>Modules linked in:
>---[ end trace 0000000000000000 ]---
>RIP: 0010:vsock_stream_has_data+0x46/0x70 net/vmw_vsock/af_vsock.c:873
>Code: 8d 9e 50 05 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 58 82 5c f6 48 8b 1b 48 83 c3 60 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 3b 82 5c f6 4c 8b 1b 4c 89 f7 5b
>RSP: 0018:ffffc900000d7748 EFLAGS: 00010206
>RAX: 000000000000000c RBX: 0000000000000060 RCX: ffff88801cac5a00
>RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888077bf08c0
>RBP: ffff888077bf08c0 R08: ffff888077bf0927 R09: 1ffff1100ef7e124
>R10: dffffc0000000000 R11: ffffed100ef7e125 R12: dffffc0000000000
>R13: ffffffff8ffeb820 R14: ffff888077bf08c0 R15: dffffc0000000000
>FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00007ffca709b000 CR3: 00000000334b6000 CR4: 00000000003526f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>----------------
>Code disassembly (best guess):
>   0:	8d 9e 50 05 00 00    	lea    0x550(%rsi),%ebx
>   6:	48 89 d8             	mov    %rbx,%rax
>   9:	48 c1 e8 03          	shr    $0x3,%rax
>   d:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
>  12:	74 08                	je     0x1c
>  14:	48 89 df             	mov    %rbx,%rdi
>  17:	e8 58 82 5c f6       	call   0xf65c8274
>  1c:	48 8b 1b             	mov    (%rbx),%rbx
>  1f:	48 83 c3 60          	add    $0x60,%rbx
>  23:	48 89 d8             	mov    %rbx,%rax
>  26:	48 c1 e8 03          	shr    $0x3,%rax
>* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
>  2f:	74 08                	je     0x39
>  31:	48 89 df             	mov    %rbx,%rdi
>  34:	e8 3b 82 5c f6       	call   0xf65c8274
>  39:	4c 8b 1b             	mov    (%rbx),%r11
>  3c:	4c 89 f7             	mov    %r14,%rdi
>  3f:	5b                   	pop    %rbx
>
>
>---
>This report is generated by a bot. It may contain errors.
>See https://goo.gl/tpsmEJ for more information about syzbot.
>syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>syzbot will keep track of this issue. See:
>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
>If the report is already addressed, let syzbot know by replying with:
>#syz fix: exact-commit-title
>
>If you want syzbot to run the reproducer, reply with:
>#syz test: git://repo/address.git branch-or-commit-hash
>If you attach or paste a git patch, syzbot will apply it before testing.
>
>If you want to overwrite report's subsystems, reply with:
>#syz set subsystems: new-subsystem
>(See the list of subsystem names on the web dashboard)
>
>If the report is a duplicate of another one, reply with:
>#syz dup: exact-subject-of-another-report
>
>If you want to undo deduplication, reply with:
>#syz undup
>

