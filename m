Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9B1C4332F
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 04:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFDB981F0E;
	Wed,  4 Jan 2023 04:21:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFDB981F0E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=buKztwR6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Juo6bxyGRtPG; Wed,  4 Jan 2023 04:21:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 025D881F0B;
	Wed,  4 Jan 2023 04:21:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 025D881F0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C94D5C0033;
	Wed,  4 Jan 2023 04:21:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DAFCC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 04:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 541BC81F0E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 04:21:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 541BC81F0E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mW_wWRILp37Z
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 04:21:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5618D81F0B
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5618D81F0B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 04:21:29 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id v14so23646041qtq.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Jan 2023 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fwgv2eicuwo/NGVPBJiv4KyGrUQY0NMr/gc3eEOFYIc=;
 b=buKztwR68+nlAxNnQppQAnx3I0XDPTQzEetS1MYmv2Fh++uFmvDkPKwdkdURxSqDDo
 MxVybYk0KPbgjF8Jgxsd5RMzrsFsmHMLlM6aiEtFWLrE8GYKWRpPcvm5vm//FmgKtG3y
 SRxHtwx08+l3OORzX35LIxl78JBr7iOoQDo9su26stJN0BpjiMS93KD23iPxoQUAD5G0
 wtphCQWztsW6vpDVZHHz6K8ymtrSgwwIzaBkWVU30BxdAxKWe9o0vKvxoUJ+bXBtxWdC
 /yo3oicseBQWj4OlWJgzFfnLqBdnQoffK7HRkL1RgjH9sfQU5bdW1QlxMiCpSNRqYjBV
 9Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwgv2eicuwo/NGVPBJiv4KyGrUQY0NMr/gc3eEOFYIc=;
 b=0jBLdXKi+B0H/ZfQx5MQdlMXvIrIdgXHwoI3hkfSlKV1zfpZv/FE9Uk+4zgRNpy0zI
 GdLKL0Lun9BvBKcVjiL14NYrQSEhWev0y/rrPMH+w500e8/n3BHLt+js+vbvKF4+6Nh9
 nzRJif6rwnHAwNYp2I5wAI3nVKD/R8L/oLooUhlDEzsZ7YpFMOLwcrviz+qDWLj4fHfx
 PK32lpim9Vv/HpqxpgARzFzU/AXO9uh+VYWAPCeuRkU4qJTHfVQsjzqSgKMGKPAy6Ma7
 pyTgEUV8oJR5cR8lr2FQWOglZlFNIcpliAoQwI7vD0Ehl6gjhfGnzp/ogcd7va3gbfI+
 lnnw==
X-Gm-Message-State: AFqh2kr15W+mAmWxkMJG8XXfqvsQ0f5uzV8A7+njd5J3lo5cTFP6pC32
 q3Xn6cQin6bSOBe8xArw0d8=
X-Google-Smtp-Source: AMrXdXtm7CfDJFGVc6riV93VYawxzBcTnj2M3gc8P35nYo3mk4p6sCzZ3BMERo30gsmJ6a9LT2moZg==
X-Received: by 2002:a05:622a:4188:b0:3a7:e4ae:7937 with SMTP id
 cd8-20020a05622a418800b003a7e4ae7937mr67109409qtb.6.1672806088047; 
 Tue, 03 Jan 2023 20:21:28 -0800 (PST)
Received: from localhost ([2600:1700:65a0:ab60:6d6a:6e9c:6668:39d5])
 by smtp.gmail.com with ESMTPSA id
 133-20020a37088b000000b006bb2cd2f6d1sm22954069qki.127.2023.01.03.20.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jan 2023 20:21:27 -0800 (PST)
Date: Tue, 3 Jan 2023 20:21:25 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: syzbot <syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com>
Subject: Re: [syzbot] kernel BUG in vhost_vsock_handle_tx_kick
Message-ID: <Y7T+xTIq2izSlHHE@pop-os.localdomain>
References: <0000000000003a68dc05f164fd69@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0000000000003a68dc05f164fd69@google.com>
Cc: bobby.eshleman@gmail.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com
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

On Tue, Jan 03, 2023 at 04:08:51PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c76083fac3ba Add linux-next specific files for 20221226
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1723da42480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c217c755f1884ab6
> dashboard link: https://syzkaller.appspot.com/bug?extid=30b72abaa17c07fe39dd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc414c480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1604b20a480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e388f26357fd/disk-c76083fa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e24f0bae36d5/vmlinux-c76083fa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a5a69a059716/bzImage-c76083fa.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com

+bobby.eshleman@gmail.com

Bobby, please take a look.

Thanks.

> 
> skbuff: skb_over_panic: text:ffffffff8768d6f1 len:25109 put:25109 head:ffff88802b5ac000 data:ffff88802b5ac02c tail:0x6241 end:0xc0 dev:<NULL>
> ------------[ cut here ]------------
> kernel BUG at net/core/skbuff.c:121!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5072 Comm: vhost-5071 Not tainted 6.2.0-rc1-next-20221226-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:skb_panic+0x16c/0x16e net/core/skbuff.c:121
> Code: f7 4c 8b 4c 24 10 8b 4b 70 41 56 45 89 e8 4c 89 e2 41 57 48 89 ee 48 c7 c7 40 04 5b 8b ff 74 24 10 ff 74 24 20 e8 09 8e bf ff <0f> 0b e8 1a 67 82 f7 4c 8b 64 24 18 e8 80 3d d0 f7 48 c7 c1 40 12
> RSP: 0018:ffffc90003cefca0 EFLAGS: 00010282
> RAX: 000000000000008d RBX: ffff88802b674500 RCX: 0000000000000000
> RDX: ffff8880236bba80 RSI: ffffffff81663b9c RDI: fffff5200079df86
> RBP: ffffffff8b5b1280 R08: 000000000000008d R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000000 R12: ffffffff8768d6f1
> R13: 0000000000006215 R14: ffffffff8b5b0400 R15: 00000000000000c0
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000380 CR3: 000000002985f000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  skb_over_panic net/core/skbuff.c:126 [inline]
>  skb_put.cold+0x24/0x24 net/core/skbuff.c:2218
>  virtio_vsock_skb_rx_put include/linux/virtio_vsock.h:56 [inline]
>  vhost_vsock_alloc_skb drivers/vhost/vsock.c:374 [inline]
>  vhost_vsock_handle_tx_kick+0xad1/0xd00 drivers/vhost/vsock.c:509
>  vhost_worker+0x241/0x3e0 drivers/vhost/vhost.c:364
>  kthread+0x2e8/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:skb_panic+0x16c/0x16e net/core/skbuff.c:121
> Code: f7 4c 8b 4c 24 10 8b 4b 70 41 56 45 89 e8 4c 89 e2 41 57 48 89 ee 48 c7 c7 40 04 5b 8b ff 74 24 10 ff 74 24 20 e8 09 8e bf ff <0f> 0b e8 1a 67 82 f7 4c 8b 64 24 18 e8 80 3d d0 f7 48 c7 c1 40 12
> RSP: 0018:ffffc90003cefca0 EFLAGS: 00010282
> RAX: 000000000000008d RBX: ffff88802b674500 RCX: 0000000000000000
> RDX: ffff8880236bba80 RSI: ffffffff81663b9c RDI: fffff5200079df86
> RBP: ffffffff8b5b1280 R08: 000000000000008d R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000000 R12: ffffffff8768d6f1
> R13: 0000000000006215 R14: ffffffff8b5b0400 R15: 00000000000000c0
> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdc6f4a4298 CR3: 000000002985f000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
