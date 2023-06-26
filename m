Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C870AEB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 15:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BAA5821F8;
	Mon, 26 Jun 2023 15:36:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BAA5821F8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VV5DGGBn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDc2Jh6IYUuJ; Mon, 26 Jun 2023 15:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB49A8215F;
	Mon, 26 Jun 2023 15:36:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB49A8215F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C403DC0037;
	Mon, 26 Jun 2023 15:36:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D88AFC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B41968215F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:36:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B41968215F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LWohu_4edQy3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:36:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB9B6821E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB9B6821E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687793791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Veur/EKeEucIQvMxKWii3PHeDlJfVrEb91ZCZfO5tlg=;
 b=VV5DGGBnYCPdQk78gE9XiAccrPCTm3j9GwOXVakD5uD3CQXH0B++YiGRi/Of0r96cyTSxl
 ocKEGUKEpmrhvCJZowK3dXf6K6LIrvpkhzmq51SzrrZW048gIdmz35okENgiJQbdw1R8Ar
 +Bu+uteg195GC8nuUks+E67mu3zWkwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-y1IHtjgyOt-sTCTFX237kQ-1; Mon, 26 Jun 2023 11:36:29 -0400
X-MC-Unique: y1IHtjgyOt-sTCTFX237kQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fb416d7731so1155745e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 08:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793788; x=1690385788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Veur/EKeEucIQvMxKWii3PHeDlJfVrEb91ZCZfO5tlg=;
 b=UnJSRRElKV0j6erwAKWMipsTWIeBSdoudAShjEefNJxRE/8QmjMNxyU2WDDhogJwBf
 9/Z+VlnUTS2WVqwHS6KVEFz/V57qFy+Ae+XJmLro5Fsbrb1mMzSbB4ILzfrdehlNSb26
 OkIGivBTCZEhg31IruKyj7tZqI42T/2hWwSOV/GSFciK2JjbVBpeSb+MxPkgBS6KbrdS
 bkoNwDFmu8QXhJxmFhIpyjsLeunFf7Rxdz8pfPn0ePzcu3iSblbp2rrxCUsYCXmB73WQ
 tA8iwD0WJ5jEFtJ9NgKHOUu1PCM6uPCtfIj4v1UNfXEozb9nJVgJgH48m37C6BBeIedw
 lNnw==
X-Gm-Message-State: AC+VfDyR2kR8dN+4itf+szOcx6aiT24dlzhXGLdpv6f/+nK9RTXZhmFq
 IHkLZ4ApjgPbiQGAJYGpCmTeqGscFMDXqpO+DX3OkVoieCH9t7Cx2Qg4Wq68cjMBNVvDTOwK/JB
 XqEhC8om8k1ALWGiICq2CbYMZGmAqRwn6TtrTQaNS7Q==
X-Received: by 2002:a05:600c:2041:b0:3fa:7808:3e16 with SMTP id
 p1-20020a05600c204100b003fa78083e16mr7954053wmg.29.1687793788105; 
 Mon, 26 Jun 2023 08:36:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JE+Pa90hkEnWZ1VrQhlMmSsls+KtMOsA3+quZnWIop516YIwu6zTpA6a8rTt6waN7qNK4uA==
X-Received: by 2002:a05:600c:2041:b0:3fa:7808:3e16 with SMTP id
 p1-20020a05600c204100b003fa78083e16mr7954040wmg.29.1687793787831; 
 Mon, 26 Jun 2023 08:36:27 -0700 (PDT)
Received: from redhat.com ([2.52.141.236]) by smtp.gmail.com with ESMTPSA id
 m24-20020a7bcb98000000b003f727764b10sm8134888wmi.4.2023.06.26.08.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:36:27 -0700 (PDT)
Date: Mon, 26 Jun 2023 11:36:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read
 in __vhost_vq_attach_worker
Message-ID: <20230626113540-mutt-send-email-mst@kernel.org>
References: <000000000000df3e3b05ff02fe20@google.com>
 <20230626031411-mutt-send-email-mst@kernel.org>
 <216718d1-1e32-9ebc-bd5e-96beab3fdc1b@oracle.com>
MIME-Version: 1.0
In-Reply-To: <216718d1-1e32-9ebc-bd5e-96beab3fdc1b@oracle.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 syzbot <syzbot+8540db210d403f1aa214@syzkaller.appspotmail.com>
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

On Mon, Jun 26, 2023 at 10:03:25AM -0500, Mike Christie wrote:
> On 6/26/23 2:15 AM, Michael S. Tsirkin wrote:
> > On Mon, Jun 26, 2023 at 12:06:54AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    8d2be868b42c Add linux-next specific files for 20230623
> >> git tree:       linux-next
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12872950a80000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8ac8dd33677e8e0
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=8540db210d403f1aa214
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c1b70f280000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122ee4cb280000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/2a004483aca3/disk-8d2be868.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/5688cb13b277/vmlinux-8d2be868.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/76de0b63bc53/bzImage-8d2be868.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit 21a18f4a51896fde11002165f0e7340f4131d6a0
> >> Author: Mike Christie <michael.christie@oracle.com>
> >> Date:   Tue Jun 13 01:32:46 2023 +0000
> >>
> >>     vhost: allow userspace to create workers
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130850bf280000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=108850bf280000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=170850bf280000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+8540db210d403f1aa214@syzkaller.appspotmail.com
> >> Fixes: 21a18f4a5189 ("vhost: allow userspace to create workers")
> > 
> > Mike, would appreciate prompt attention to this as I am preparing
> > a pull request for the merge window and need to make a
> > decision on whether to include your userspace-controlled
> > threading patchset.
> > 
> 
> Do you want me to resubmit the patchset or submit a patch against your vhost
> branch?

Resubmit pls.

> The bug is that vhost-net can call vhost_dev_reset_owner and that will
> free the workers. However, I leave the virtqueue->worker pointer set so
> we end up referencing the freed workers later on. When I handled a
> review comment between v5 and v6, I deleted that code thinking it was
> also not needed.
> 
> So the fix is:
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ab79b064aade..5a07e220e46d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -607,6 +607,10 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  
>  	if (!dev->use_worker)
>  		return;
> +
> +	for (i = 0; i < dev->nvqs; i++)
> +		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> +
>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
