Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDF0C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 09:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16EF381293;
	Wed,  2 Mar 2022 09:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1UTYHSfbbDnm; Wed,  2 Mar 2022 09:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9A3C181256;
	Wed,  2 Mar 2022 09:23:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67A47C0082;
	Wed,  2 Mar 2022 09:23:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3505FC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 167C881256
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17g_5l86Mw-L
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:23:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F78280D47
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646213009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foExQQknn5+ykqqTjNflz4MN/o7z8a5WlPaDeSuniwY=;
 b=gY+U/zbS5+BSbpai/wKQWnCSZ/Ts7KfaAmlZCnn0JEI5exDNHu7Yk6t9JHDywxcXR8vSLS
 4PpISRc5cF7XScvZ6ZI8/UosJfmQAAx5IIzmzYpSGPcaFHSSQMkcazLdYofj+Qg0aYcjPE
 2xeI2WT+LdSIquCyPu+iokgJkuF1IEw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638--ECLVUqbNi-VxFFbMcOiAw-1; Wed, 02 Mar 2022 04:23:28 -0500
X-MC-Unique: -ECLVUqbNi-VxFFbMcOiAw-1
Received: by mail-qk1-f200.google.com with SMTP id
 a15-20020a05620a066f00b0060c66d84489so678252qkh.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 01:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=foExQQknn5+ykqqTjNflz4MN/o7z8a5WlPaDeSuniwY=;
 b=utxI4t4WL4A0GI5FTr8ZDWFViMd5nWTqMI32xeH88nmv+b3GvziBeZv5Ed5Ag+0U+J
 LndWfZgiBrMDr9pP8P9a3jHj03nst2MGZmQUcmcjGkTwFP9oixG3Tvg+kXxtTE5JLfik
 bLlhi4iaZPZg3xzZDN02dGfMcHYRIdImNxvRmd9BB+I/yhg1CKR+Zzq6qlOdJ0VKMIzv
 DPmhfPT/+P2mkhCuGYL/60fuSu7WiYqWNGeVuUdXY86sTvs5HEDEa0mjqDDTwAOcz9fr
 AoiBzuwEtih+PQF94C/sP92y5zmwMFQPyn22BMG1McWbAVF7XIUiABXyNSSVwtHpyrQr
 N3cA==
X-Gm-Message-State: AOAM531Q1Tqmx2FepxVWu05iyTRTfXe6W+KgwaupNUDdfVvvREBZ3Gr3
 dgsiT0oSqzi2PlfRirA13l1Jcewlkcxp7MH4rtYHdSygNjzXa3g0XR+04EbKg7NH8958iyTlTin
 noDjgWPRGed9rYwJdzNO9qlKt61+/8i2bN13/T0QKxQ==
X-Received: by 2002:a05:622a:1714:b0:2de:755c:2c81 with SMTP id
 h20-20020a05622a171400b002de755c2c81mr22707085qtk.685.1646213008239; 
 Wed, 02 Mar 2022 01:23:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqqlqDsysgnT4+ZcaC5E/HrMnr0i5bndO6omkJInksarmdfs77V4QCgirdVpSITO1M/a7bLA==
X-Received: by 2002:a05:622a:1714:b0:2de:755c:2c81 with SMTP id
 h20-20020a05622a171400b002de755c2c81mr22707073qtk.685.1646213008009; 
 Wed, 02 Mar 2022 01:23:28 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 b17-20020ae9eb11000000b0064917bda713sm7733701qkg.85.2022.03.02.01.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 01:23:27 -0800 (PST)
Date: Wed, 2 Mar 2022 10:23:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220302092321.rfyht3xhyybpohkw@sgarzare-redhat>
References: <00000000000070ac6505d7d9f7a8@google.com>
 <0000000000003b07b305d840b30f@google.com>
 <20220218063352-mutt-send-email-mst@kernel.org>
 <Yh8q9fzCQHW2qtIG@google.com>
 <20220302091807.uyo7ycd6yw6cx7hd@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220302091807.uyo7ycd6yw6cx7hd@sgarzare-redhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org,
 syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
 netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 02, 2022 at 10:18:07AM +0100, Stefano Garzarella wrote:
>On Wed, Mar 02, 2022 at 08:29:41AM +0000, Lee Jones wrote:
>>On Fri, 18 Feb 2022, Michael S. Tsirkin wrote:
>>
>>>On Thu, Feb 17, 2022 at 05:21:20PM -0800, syzbot wrote:
>>>> syzbot has found a reproducer for the following issue on:
>>>>
>>>> HEAD commit:    f71077a4d84b Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=104c04ca700000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1362e232700000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11373a6c700000
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com
>>>>
>>>> ------------[ cut here ]------------
>>>> kernel BUG at drivers/vhost/vhost.c:2335!
>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>>>> CPU: 1 PID: 3597 Comm: vhost-3596 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>>> RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2335
>>>> Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 b7 59 28 fd e9 74 ff ff ff e8 5d c8 a1 fa <0f> 0b e8 56 c8 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
>>>> RSP: 0018:ffffc90001d1fb88 EFLAGS: 00010293
>>>> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>>>> RDX: ffff8880234b0000 RSI: ffffffff86d715c3 RDI: 0000000000000003
>>>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>>>> R10: ffffffff86d706bc R11: 0000000000000000 R12: ffff888072c24d68
>>>> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888072c24bb0
>>>> FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 0000000000000002 CR3: 000000007902c000 CR4: 00000000003506e0
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Call Trace:
>>>>  <TASK>
>>>>  vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
>>>>  vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
>>>>  kthread+0x2e9/0x3a0 kernel/kthread.c:377
>>>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>>>
>>>I don't see how this can trigger normally so I'm assuming
>>>another case of use after free.
>>
>>Yes, exactly.
>
>I think this issue is related to the issue fixed by this patch merged 
>some days ago upstream: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9
>
>>
>>I patched it.  Please see:
>>
>>https://lore.kernel.org/all/20220302075421.2131221-1-lee.jones@linaro.org/T/#t
>>
>
>I'm not sure that patch is avoiding the issue. I'll reply to it.

My bad, I think it should be fine, because vhost_vq_reset() set 
vq->private_data to NULL and avoids the worker to run.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
