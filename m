Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ABBC433EF
	for <virtualization@archiver.kernel.org>; Fri, 18 Feb 2022 11:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E836611BC;
	Fri, 18 Feb 2022 11:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IuIcR_jpbV4v; Fri, 18 Feb 2022 11:37:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89C61611BD;
	Fri, 18 Feb 2022 11:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B4A9C0011;
	Fri, 18 Feb 2022 11:37:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B669FC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 11:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A30FE41DC3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 11:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u7ca01k1tJee
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 11:37:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3676841DC2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645184255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRz2HhmPOJqUdEguD6ineI0jgT8YXoXhvMfK4d0/iRk=;
 b=E6EOZmJdk6UZAc+Xsgx4M8T/pNMxbnnZBvO7Vm89TXJQqB6LfI/FIzQgz83TLsV6YCqIdO
 famGzqPQ5sS9bEK6/2/hXI8G2ci/2GGEMBcrTv2aTnWXkpwPUD5b7RGJUiwIaI0Z9gIN9u
 fQa32pAKz6zQN4JKdt2PWSxNXzMrHCU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-FpRW1vWUN9u7eFVcZl1PDQ-1; Fri, 18 Feb 2022 06:37:32 -0500
X-MC-Unique: FpRW1vWUN9u7eFVcZl1PDQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 l14-20020aa7cace000000b003f7f8e1cbbdso5344813edt.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 03:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kRz2HhmPOJqUdEguD6ineI0jgT8YXoXhvMfK4d0/iRk=;
 b=FQK3SniAC1b/JSlWaxifuKLWVlUASKjR9YZHkYxBZGhVnQtSeZ5Js3sZXrh9xrPGdu
 A+eWeKXGGTKym7BROTokrsTHvobdhzoiRBBvBQUbj2vTjZ3UjIyX6l55o43gxmdZ6Qc5
 jfkbPULuYoVZCN/0dd3XROfv/Y17j0LisQn6JGAm14Um2l21mrJlCi9j3KqOgJUulZGp
 qI8HNy+MFJiFGng7edfl31A1KmGNgE5Dpn2/ncLWh0dwJccjHjQXnPox90PoLS2f/L/C
 M6YV2p8uv6Fy3x4WuQE4Ue92AUVamQKfht05JrqKCJ4FK43L30xvv5jK0ogUBmLMp4El
 S/rg==
X-Gm-Message-State: AOAM530du2T7UwKtnkmfh9x5rWTOYjRo56JX0v1Nj0hbCOe5wvgOxER0
 oAzXrDUR3CRvZ94vug2z90YJJoC3d2iysFVRcStoJXYZipuBTe1erEPTh8AswHGV1pK3QvDgaY6
 6oDm1pWk1TlN34jUyLMBNfXuKOavOylc2unltay/ouQ==
X-Received: by 2002:a17:906:f293:b0:6b6:bc93:f01f with SMTP id
 gu19-20020a170906f29300b006b6bc93f01fmr5656031ejb.743.1645184251241; 
 Fri, 18 Feb 2022 03:37:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyumwEeTQqcko1h2tOqCFdEjZvTGldy8JfDmmW/0pXvLQMU7H6ovgQWyZGrpbpB4r5tpsNPFQ==
X-Received: by 2002:a17:906:f293:b0:6b6:bc93:f01f with SMTP id
 gu19-20020a170906f29300b006b6bc93f01fmr5656019ejb.743.1645184251001; 
 Fri, 18 Feb 2022 03:37:31 -0800 (PST)
Received: from redhat.com ([2.55.156.211])
 by smtp.gmail.com with ESMTPSA id z18sm2209291ejl.78.2022.02.18.03.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Feb 2022 03:37:30 -0800 (PST)
Date: Fri, 18 Feb 2022 06:37:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220218063352-mutt-send-email-mst@kernel.org>
References: <00000000000070ac6505d7d9f7a8@google.com>
 <0000000000003b07b305d840b30f@google.com>
MIME-Version: 1.0
In-Reply-To: <0000000000003b07b305d840b30f@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Thu, Feb 17, 2022 at 05:21:20PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f71077a4d84b Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=104c04ca700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1362e232700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11373a6c700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at drivers/vhost/vhost.c:2335!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 3597 Comm: vhost-3596 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2335
> Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 b7 59 28 fd e9 74 ff ff ff e8 5d c8 a1 fa <0f> 0b e8 56 c8 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
> RSP: 0018:ffffc90001d1fb88 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff8880234b0000 RSI: ffffffff86d715c3 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff86d706bc R11: 0000000000000000 R12: ffff888072c24d68
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888072c24bb0
> FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000002 CR3: 000000007902c000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
>  vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
>  kthread+0x2e9/0x3a0 kernel/kthread.c:377
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

I don't see how this can trigger normally so I'm assuming
another case of use after free.

>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2335
> Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 b7 59 28 fd e9 74 ff ff ff e8 5d c8 a1 fa <0f> 0b e8 56 c8 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
> RSP: 0018:ffffc90001d1fb88 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff8880234b0000 RSI: ffffffff86d715c3 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff86d706bc R11: 0000000000000000 R12: ffff888072c24d68
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888072c24bb0
> FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000002 CR3: 000000007902c000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
