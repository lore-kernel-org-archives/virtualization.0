Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57747C77B7A
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 11:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B82E460706;
	Tue, 30 May 2023 11:24:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B82E460706
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TKwsr6dV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jd6wxmtAaZMA; Tue, 30 May 2023 11:24:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2148060F82;
	Tue, 30 May 2023 11:24:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2148060F82
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD0F1C0035;
	Tue, 30 May 2023 11:24:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3EB0C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 11:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71C614074E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 11:24:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71C614074E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TKwsr6dV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jxvwfJZH6O13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 11:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F396400F1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F396400F1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685445853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FFKpZXmHv3EVEcNDqoXlVak203z2YTZFcHMcY6d15bo=;
 b=TKwsr6dVPFOoTFhwRivD/dM5azroGX9EbK48TzjuvA9/dDbnsVM1UfgdvJItyqbcI2v8J7
 v/LSaSWW+OQ3Oe4AUG/oODgepVkcPC1jnT0p019vgvx/nfPe0gQATRWd3gb08hQ/LmEonc
 CXjsIZi1+Ka2Fz1WcbDjabv7vJgIb6c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-2kUpT8EePaSQxLe-M_eSJg-1; Tue, 30 May 2023 07:24:12 -0400
X-MC-Unique: 2kUpT8EePaSQxLe-M_eSJg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f6038dc351so16326195e9.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 04:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685445851; x=1688037851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFKpZXmHv3EVEcNDqoXlVak203z2YTZFcHMcY6d15bo=;
 b=Z37wC/nVqHl5OR83Ntm9BNpY6F85wU0gn4Vsc7z6bFSW5k1V2m+j09m5zt/vI7wAff
 jFMR+FQ+tdC1ZLsk2ZWsqL/yOIPGVO6MV5XheI5Y/Eej5xH4gwuUzjDcRiIWr3CYwe+X
 A4k+yOpy30Z0gbkaZVKtfBEHsiyXrEIBVi8y4Mpi6fmbgHA06ncSgNs2HRVdjAlJ9mZM
 77K65cvkZC346D9Q8mHcZgDA+Rj2x/3cMnQYStEm/ilFoRyN5HBiC+ra2EwCADbdYpGp
 TfShhRpPngOnpQ0v2HAFIQEddRFDlU60Q9yok6SdNjI4oaZOZfzxfbJ9l25N3dOaTYaz
 1xLw==
X-Gm-Message-State: AC+VfDyEgTZwhgs9iQOhI9zT9GrNdAMTZW10PvOrvMywqzBQfcjjM9ng
 5xXaqSMPq38gGPuevhOueevvxMn3w3sSI3uLqXIQ/Lxy9OMC+BWhyZDgUvdyW4BEfP/t8hj7GJj
 zG9CHjfG7uopq6vsqxp0WKccDcCs+ETtGatfSgmaT8g==
X-Received: by 2002:a05:600c:228b:b0:3f6:13e1:16b7 with SMTP id
 11-20020a05600c228b00b003f613e116b7mr1442247wmf.28.1685445850792; 
 Tue, 30 May 2023 04:24:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4olrB3T4242Hm657dR8k3m6TNwqGT1KzpvGbXMckpc6fTPwJMFCqvnLyJXIIbYPJ8cvXRQRA==
X-Received: by 2002:a05:600c:228b:b0:3f6:13e1:16b7 with SMTP id
 11-20020a05600c228b00b003f613e116b7mr1442231wmf.28.1685445850463; 
 Tue, 30 May 2023 04:24:10 -0700 (PDT)
Received: from redhat.com ([2.52.11.69]) by smtp.gmail.com with ESMTPSA id
 k10-20020a7bc40a000000b003f606869603sm20719249wmi.6.2023.05.30.04.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 04:24:09 -0700 (PDT)
Date: Tue, 30 May 2023 07:24:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 vhost_work_queue
Message-ID: <20230530072310-mutt-send-email-mst@kernel.org>
References: <0000000000001777f605fce42c5f@google.com>
MIME-Version: 1.0
In-Reply-To: <0000000000001777f605fce42c5f@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Tue, May 30, 2023 at 12:30:06AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    933174ae28ba Merge tag 'spi-fix-v6.4-rc3' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=138d4ae5280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f389ffdf4e9ba3f0
> dashboard link: https://syzkaller.appspot.com/bug?extid=d0d442c22fa8db45ff0e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/21a81b8c2660/disk-933174ae.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b4951d89e238/vmlinux-933174ae.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/21eb405303cc/bzImage-933174ae.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> CPU: 0 PID: 29845 Comm: syz-executor.4 Not tainted 6.4.0-rc3-syzkaller-00032-g933174ae28ba #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/16/2023
> RIP: 0010:vhost_work_queue drivers/vhost/vhost.c:259 [inline]
> RIP: 0010:vhost_work_queue+0xfc/0x150 drivers/vhost/vhost.c:248
> Code: 00 00 fc ff df 48 89 da 48 c1 ea 03 80 3c 02 00 75 56 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 8d 7b 70 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 42 48 8b 7b 70 e8 95 9e ae f9 5b 5d 41 5c 41 5d e9
> RSP: 0018:ffffc9000333faf8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000d84d000
> RDX: 000000000000000e RSI: ffffffff841221d7 RDI: 0000000000000070
> RBP: ffff88804b6b95b0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff88804b6b00b0
> R13: 0000000000000000 R14: ffff88804b6b95e0 R15: ffff88804b6b95c8
> FS:  00007f3b445ec700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2e423000 CR3: 000000005d734000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 000000000000003b DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  vhost_transport_send_pkt+0x268/0x520 drivers/vhost/vsock.c:288
>  virtio_transport_send_pkt_info+0x54c/0x820 net/vmw_vsock/virtio_transport_common.c:250
>  virtio_transport_connect+0xb1/0xf0 net/vmw_vsock/virtio_transport_common.c:813
>  vsock_connect+0x37f/0xcd0 net/vmw_vsock/af_vsock.c:1414
>  __sys_connect_file+0x153/0x1a0 net/socket.c:2003
>  __sys_connect+0x165/0x1a0 net/socket.c:2020
>  __do_sys_connect net/socket.c:2030 [inline]
>  __se_sys_connect net/socket.c:2027 [inline]
>  __x64_sys_connect+0x73/0xb0 net/socket.c:2027
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f3b4388c169
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3b445ec168 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 00007f3b439ac050 RCX: 00007f3b4388c169
> RDX: 0000000000000010 RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 00007f3b438e7ca1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f3b43acfb1f R14: 00007f3b445ec300 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:vhost_work_queue drivers/vhost/vhost.c:259 [inline]
> RIP: 0010:vhost_work_queue+0xfc/0x150 drivers/vhost/vhost.c:248
> Code: 00 00 fc ff df 48 89 da 48 c1 ea 03 80 3c 02 00 75 56 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 8d 7b 70 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 42 48 8b 7b 70 e8 95 9e ae f9 5b 5d 41 5c 41 5d e9
> RSP: 0018:ffffc9000333faf8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000d84d000
> RDX: 000000000000000e RSI: ffffffff841221d7 RDI: 0000000000000070
> RBP: ffff88804b6b95b0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff88804b6b00b0
> R13: 0000000000000000 R14: ffff88804b6b95e0 R15: ffff88804b6b95c8
> FS:  00007f3b445ec700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2e428000 CR3: 000000005d734000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 000000000000003b DR6: 00000000ffff0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 5 bytes skipped:
>    0:	48 89 da             	mov    %rbx,%rdx
>    3:	48 c1 ea 03          	shr    $0x3,%rdx
>    7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>    b:	75 56                	jne    0x63
>    d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   14:	fc ff df
>   17:	48 8b 1b             	mov    (%rbx),%rbx
>   1a:	48 8d 7b 70          	lea    0x70(%rbx),%rdi
>   1e:	48 89 fa             	mov    %rdi,%rdx
>   21:	48 c1 ea 03          	shr    $0x3,%rdx
> * 25:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   29:	75 42                	jne    0x6d
>   2b:	48 8b 7b 70          	mov    0x70(%rbx),%rdi
>   2f:	e8 95 9e ae f9       	callq  0xf9ae9ec9
>   34:	5b                   	pop    %rbx
>   35:	5d                   	pop    %rbp
>   36:	41 5c                	pop    %r12
>   38:	41 5d                	pop    %r13
>   3a:	e9                   	.byte 0xe9


Stefano, Stefan, take a look?


> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
