Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1054C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 09:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33EC540494;
	Wed,  2 Mar 2022 09:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvNuKfnvXe21; Wed,  2 Mar 2022 09:18:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6BF5B40395;
	Wed,  2 Mar 2022 09:18:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EA93C0082;
	Wed,  2 Mar 2022 09:18:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A72B5C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D724401CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwFw77ODZab4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:18:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5737B40186
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646212701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/k2VmYz+o3cpXUbtVkQoEKWCQmbl907XuCsT2KacOa0=;
 b=gonmRGb/T1H/zDeYcb5H9+bENL5KQvtYJ6vOpFt4C1Y+Co1QP7btYbERw5Fmp58LJ4Np/3
 0SW3CC41L4K5p4esFVTk0JesGdrqLuQITCpwK0atNcWlOPKfehQFi/yW3l8NB4R5DtSp7M
 EHtnubEbbil/scRIJDBINZL+F56VLqA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-54N1aOt3P_u128_b8WLBOg-1; Wed, 02 Mar 2022 04:18:18 -0500
X-MC-Unique: 54N1aOt3P_u128_b8WLBOg-1
Received: by mail-qv1-f71.google.com with SMTP id
 a9-20020ad45c49000000b004352ae97476so19589qva.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 01:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/k2VmYz+o3cpXUbtVkQoEKWCQmbl907XuCsT2KacOa0=;
 b=7lYYbtx/Qyy/PJnISkuNb6W0Oty/RvtM8k6YhZrnuUTLNpVBK/S3m/cfto32FTuIZw
 /bupDZw0zWwVGK3RBqJlKlJVeywUSLygcsi4HeG8p155jDBcYCU2PUve0NRfkEzDRWyB
 ry1ZFVXnKQJicGHMU61DPPxi8Ou2or8Xgx8lGRuYQss2pcrpw1UlVO/zPOAmkFnRJUiU
 b49APM9+il41/UKj8+iXtL0aPqdtnmAYzEhaJF81X6xztZM8WqFfwer/T8OMRNeoCVC2
 064iEIp7E3Il11exm7tmH/Ey8wv21x9ZaVhgQs3eVnigVHaHYjeZrouKJqYNlW4W8hXT
 imiQ==
X-Gm-Message-State: AOAM531xUUxCCk5iAwq+BitTjHiOjUmZffbjSJyNSz6mMlu72xEAgRA3
 +NXMuxcKcTxh+DRe3ngMS2ApxMqIpsI76kZCGJaCMhSd/J9gkF4XgeyDJK6C9TpQ626vHXC+HaN
 B1OeGr+clZezlei0fipCVtgpwdXYX3tcA6yeqvMqEBQ==
X-Received: by 2002:a0c:d991:0:b0:432:c0c0:a6c5 with SMTP id
 y17-20020a0cd991000000b00432c0c0a6c5mr16665685qvj.23.1646212697392; 
 Wed, 02 Mar 2022 01:18:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjYadbC0ZzXIcUVFlYssKE6/+21ynY+c3z8ydk8SARiLY20dVrDd2uNAQv/wlX6S8u2FOpWQ==
X-Received: by 2002:a0c:d991:0:b0:432:c0c0:a6c5 with SMTP id
 y17-20020a0cd991000000b00432c0c0a6c5mr16665675qvj.23.1646212697118; 
 Wed, 02 Mar 2022 01:18:17 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 f7-20020a05622a104700b002d4b318692esm10885790qte.31.2022.03.02.01.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 01:18:16 -0800 (PST)
Date: Wed, 2 Mar 2022 10:18:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220302091807.uyo7ycd6yw6cx7hd@sgarzare-redhat>
References: <00000000000070ac6505d7d9f7a8@google.com>
 <0000000000003b07b305d840b30f@google.com>
 <20220218063352-mutt-send-email-mst@kernel.org>
 <Yh8q9fzCQHW2qtIG@google.com>
MIME-Version: 1.0
In-Reply-To: <Yh8q9fzCQHW2qtIG@google.com>
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

On Wed, Mar 02, 2022 at 08:29:41AM +0000, Lee Jones wrote:
>On Fri, 18 Feb 2022, Michael S. Tsirkin wrote:
>
>> On Thu, Feb 17, 2022 at 05:21:20PM -0800, syzbot wrote:
>> > syzbot has found a reproducer for the following issue on:
>> >
>> > HEAD commit:    f71077a4d84b Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
>> > git tree:       upstream
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=104c04ca700000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
>> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1362e232700000
>> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11373a6c700000
>> >
>> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > Reported-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com
>> >
>> > ------------[ cut here ]------------
>> > kernel BUG at drivers/vhost/vhost.c:2335!
>> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> > CPU: 1 PID: 3597 Comm: vhost-3596 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b #0
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> > RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2335
>> > Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 b7 59 28 fd e9 74 ff ff ff e8 5d c8 a1 fa <0f> 0b e8 56 c8 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
>> > RSP: 0018:ffffc90001d1fb88 EFLAGS: 00010293
>> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>> > RDX: ffff8880234b0000 RSI: ffffffff86d715c3 RDI: 0000000000000003
>> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>> > R10: ffffffff86d706bc R11: 0000000000000000 R12: ffff888072c24d68
>> > R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888072c24bb0
>> > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
>> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > CR2: 0000000000000002 CR3: 000000007902c000 CR4: 00000000003506e0
>> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > Call Trace:
>> >  <TASK>
>> >  vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
>> >  vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
>> >  kthread+0x2e9/0x3a0 kernel/kthread.c:377
>> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>>
>> I don't see how this can trigger normally so I'm assuming
>> another case of use after free.
>
>Yes, exactly.

I think this issue is related to the issue fixed by this patch merged 
some days ago upstream: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9

>
>I patched it.  Please see:
>
>https://lore.kernel.org/all/20220302075421.2131221-1-lee.jones@linaro.org/T/#t
>

I'm not sure that patch is avoiding the issue. I'll reply to it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
