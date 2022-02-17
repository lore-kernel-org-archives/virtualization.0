Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CFEC433EF
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 07:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A958A83EE4;
	Thu, 17 Feb 2022 07:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFjkaWK4WxtS; Thu, 17 Feb 2022 07:34:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39F6083145;
	Thu, 17 Feb 2022 07:34:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05B6AC002D;
	Thu, 17 Feb 2022 07:34:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3CDEC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB16C4179E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:34:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iy-A0W8fQCav
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:34:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B3E941789
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645083272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6FNb/hL4W43voQSLwLvNA7AH00yby7ekKu9J1pXf9E=;
 b=CskLGqyYU0gTUqDYVbRFfZFyQfi1PJu3MAtu4zH8QIgaDbHO7YML+Pg/c0vQujVuQQ8tEU
 zhzmGmQVREFNoAacPBoi75EHqiKvta2ouKA4PchiJJLhU9I6cngU3gzEmZmlHeF1Lwyue0
 DvR0M82104ngeaa68opM3AwHAAuDyQY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-0D28xGScNByf4KQXeRJr7A-1; Thu, 17 Feb 2022 02:34:26 -0500
X-MC-Unique: 0D28xGScNByf4KQXeRJr7A-1
Received: by mail-lf1-f71.google.com with SMTP id
 m13-20020a19520d000000b00443423ff116so1548341lfb.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 23:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c6FNb/hL4W43voQSLwLvNA7AH00yby7ekKu9J1pXf9E=;
 b=IgNext4odLefYlz6H88Q68OLbZaZ+M84G2lFsSwVoyMXuSk/Urfi64ryLZ50b4UKIf
 2+sbgaZxR9LFzAEcX3G4JC4jjI4SC7TJzBO3wofTglTe18BD54uoMD6mUUXBcrj0Suth
 8NIyVdOmWHjckgLncnZCqHCcDk0z8i0HqHKCEK3x+OeYOBu3t40b8V0IKdzyGmVprRPT
 i7hnAX+ohRw4ue7aSVPQ/vpIYh0Bpu72OsVplIrm9UwPhvKa1Gm3Y841hCtGDHdTYn42
 YIgaDX57pWAwcghkodE7tu3S0MI9PlKZOvJ/3GrFoW6aZlYmhZbtj0Dsg4KoCWHRx4QT
 OAqg==
X-Gm-Message-State: AOAM531i9bklcD5Hm8idjSz5HUufKxmV/gspRFFuZE+oj9CZIShwvAXp
 MuC1+/dgdHLtm3aI5BzH8zvJ/k5RCm5Fp6OnP6xDQk1bKWOvkhRbRjcXxr3I6zrjNdUrRERcPvO
 GFhwEOZWGkViNF0a7SU641oT3xW+cdYpraLk4ZPpYGMPsSqTi43LHbm+9Xw==
X-Received: by 2002:a05:6512:6c4:b0:437:9409:984c with SMTP id
 u4-20020a05651206c400b004379409984cmr1228083lff.199.1645083264467; 
 Wed, 16 Feb 2022 23:34:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCsXdhjl0wj4TBnHBnfKwMgEHk/ZSnUA2mQPfASqIHy1lxNAnvtj8QYS65ONbXtrbhqgm+OdVIRXU0OIq3mS0=
X-Received: by 2002:a05:6512:6c4:b0:437:9409:984c with SMTP id
 u4-20020a05651206c400b004379409984cmr1228069lff.199.1645083264248; Wed, 16
 Feb 2022 23:34:24 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006f656005d82d24e2@google.com>
In-Reply-To: <0000000000006f656005d82d24e2@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Feb 2022 15:34:13 +0800
Message-ID: <CACGkMEsyWBBmx3g613tr97nidHd3-avMyO=WRxS8RpcEk7j2=A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in vhost_dev_cleanup (2)
To: syzbot <syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Thu, Feb 17, 2022 at 10:01 AM syzbot
<syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=132e687c700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> dashboard link: https://syzkaller.appspot.com/bug?extid=1e3ea63db39f2b4440e0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
>
> WARNING: CPU: 1 PID: 10828 at drivers/vhost/vhost.c:715 vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
> Modules linked in:
> CPU: 0 PID: 10828 Comm: syz-executor.0 Not tainted 5.17.0-rc4-syzkaller-00051-gc5d9ae265b10 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715

Probably a hint that we are missing a flush.

Looking at vhost_vsock_stop() that is called by vhost_vsock_dev_release():

static int vhost_vsock_stop(struct vhost_vsock *vsock)
{
size_t i;
        int ret;

        mutex_lock(&vsock->dev.mutex);

        ret = vhost_dev_check_owner(&vsock->dev);
        if (ret)
                goto err;

Where it could fail so the device is not actually stopped.

I wonder if this is something related.

Thanks


> Code: c7 85 90 01 00 00 00 00 00 00 e8 53 6e a2 fa 48 89 ef 48 83 c4 20 5b 5d 41 5c 41 5d 41 5e 41 5f e9 7d d6 ff ff e8 38 6e a2 fa <0f> 0b e9 46 ff ff ff 48 8b 7c 24 10 e8 87 00 ea fa e9 75 f7 ff ff
> RSP: 0018:ffffc9000fe6fa18 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: ffff888021b63a00 RSI: ffffffff86d66fe8 RDI: ffff88801cc200b0
> RBP: ffff88801cc20000 R08: 0000000000000001 R09: 0000000000000001
> R10: ffffffff817f1e08 R11: 0000000000000000 R12: ffff88801cc200d0
> R13: ffff88801cc20120 R14: ffff88801cc200d0 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2de25000 CR3: 000000004c9cd000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  vhost_vsock_dev_release+0x36e/0x4b0 drivers/vhost/vsock.c:771
>  __fput+0x286/0x9f0 fs/file_table.c:313
>  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
>  exit_task_work include/linux/task_work.h:32 [inline]
>  do_exit+0xb29/0x2a30 kernel/exit.c:806
>  do_group_exit+0xd2/0x2f0 kernel/exit.c:935
>  get_signal+0x45a/0x2490 kernel/signal.c:2863
>  arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
>  handle_signal_work kernel/entry/common.c:148 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>  exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
>  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f4027a46481
> Code: Unable to access opcode bytes at RIP 0x7f4027a46457.
> RSP: 002b:00007f402808ba68 EFLAGS: 00000206 ORIG_RAX: 0000000000000038
> RAX: fffffffffffffffc RBX: 00007f402622e700 RCX: 00007f4027a46481
> RDX: 00007f402622e9d0 RSI: 00007f402622e2f0 RDI: 00000000003d0f00
> RBP: 00007f402808bcb0 R08: 00007f402622e700 R09: 00007f402622e700
> R10: 00007f402622e9d0 R11: 0000000000000206 R12: 00007f402808bb1e
> R13: 00007f402808bb1f R14: 00007f402622e300 R15: 0000000000022000
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
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
