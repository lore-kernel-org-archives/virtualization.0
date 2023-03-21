Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3785C74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 17:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A61740C19;
	Tue, 21 Mar 2023 17:55:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A61740C19
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XodGdR1o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M-8qHgOJWnPg; Tue, 21 Mar 2023 17:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 349DD40496;
	Tue, 21 Mar 2023 17:55:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 349DD40496
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0655BC0071;
	Tue, 21 Mar 2023 17:55:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF12EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 17:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF84741703
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 17:55:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF84741703
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XodGdR1o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 48fpGaGS7kyP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 17:55:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A4414146F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A4414146F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679421303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6OO5ZIxJDvOympMMqka+XvitUlu/HzW9BC/npWTX1zg=;
 b=XodGdR1oVIC9cAaN2YNUK3FA5yXAT9lO0URLrLwRkXuuPzs/31YUiw7focZLZAXkflRkDM
 Tt5zF25LIe6kGgOxpr6Yq3sfz4AdICUmthwCWDbJD+zELfKkEl1IOffnFvLR/kMXIWKZL2
 8NMi1iHZaTLOmqJi/UG93dbIhknwIlI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-N7H0eFc-NRS3S756MJcNAw-1; Tue, 21 Mar 2023 13:55:01 -0400
X-MC-Unique: N7H0eFc-NRS3S756MJcNAw-1
Received: by mail-wm1-f69.google.com with SMTP id
 k29-20020a05600c1c9d00b003ee3a8d547eso1133963wms.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 10:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679421300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OO5ZIxJDvOympMMqka+XvitUlu/HzW9BC/npWTX1zg=;
 b=givxB1/t3Kt3O8Zqhs8d5OOkHPMJJYY6ZU7gP4e7Cx3qmFXhJ+t2eDnQXfehpIcXmG
 vgBmyS9W5pY6EeL/L6N79VCkcU3bd7qMS9Ec0ic8oG5Hy56G0HqqW7CNXL60CnYsLow6
 +LSgadv4h2ODoKjcX7N3CJlJcSWQClOyOYI6eveF/q0NmXWc+XethOWexTllj7Fs5jTf
 fCUZp6Ae/IvqiVc13zxTK+y1v9RypZZbYNSR9JN3NG07bp2h4CnPBD4XWjqEcg+7GAn/
 H7EdCWgbn3SUZVPV+3D9f0+mgsPCuKNe7nU5vJT86MgkxQExJnFWTxllw0wOZcgSkBrO
 Qacw==
X-Gm-Message-State: AO0yUKWFxmksvsWQ6SFhBR7Ujj/UIcqyprsyRcdRx1Gs9DNClR4WDOik
 70bGRX6qOMZTJUhgdnLwgie0XeeetEIsjzuE0Eu1g1Z/VsyXYowfMgkXgJHhuOmFiL6aHFrud7u
 Bij6NX35513GD9YURHrMJD3WNs7BigSFoSdfcStzeZQ==
X-Received: by 2002:a05:600c:2148:b0:3ed:de58:1559 with SMTP id
 v8-20020a05600c214800b003edde581559mr3453846wml.2.1679421300512; 
 Tue, 21 Mar 2023 10:55:00 -0700 (PDT)
X-Google-Smtp-Source: AK7set9RelBID8PX2Oo4YRgLh3yCs4x5rXDJQ5I40J+dfydiTGBSMryWryZAvLCGcoPwCihyPe5BdA==
X-Received: by 2002:a05:600c:2148:b0:3ed:de58:1559 with SMTP id
 v8-20020a05600c214800b003edde581559mr3453827wml.2.1679421300186; 
 Tue, 21 Mar 2023 10:55:00 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 y16-20020a056000109000b002c56013c07fsm11771399wrw.109.2023.03.21.10.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 10:54:59 -0700 (PDT)
Date: Tue, 21 Mar 2023 13:54:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] [kernel?] general protection fault in vhost_task_start
Message-ID: <20230321135427-mutt-send-email-mst@kernel.org>
References: <0000000000005a60a305f76c07dc@google.com>
 <2d976892-9914-5de0-62e0-c75f1c148259@oracle.com>
MIME-Version: 1.0
In-Reply-To: <2d976892-9914-5de0-62e0-c75f1c148259@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brauner@kernel.org, kvm@vger.kernel.org,
 syzbot <syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Mar 21, 2023 at 12:46:04PM -0500, Mike Christie wrote:
> On 3/21/23 12:03 PM, syzbot wrote:
> > RIP: 0010:vhost_task_start+0x22/0x40 kernel/vhost_task.c:115
> > Code: 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 53 48 89 fb e8 c3 67 2c 00 48 8d 7b 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 0a 48 8b 7b 70 5b e9 fe bd 02 00 e8 79 ec 7e 00 eb
> > RSP: 0018:ffffc90003a9fc38 EFLAGS: 00010207
> > RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 0000000000000000
> > RDX: 000000000000000c RSI: ffffffff81564c8d RDI: 0000000000000064
> > RBP: ffff88802b21dd40 R08: 0000000000000100 R09: ffffffff8c917cf3
> > R10: 00000000fffffff4 R11: 0000000000000000 R12: fffffffffffffff4
> > R13: ffff888075d000b0 R14: ffff888075d00000 R15: ffff888075d00008
> > FS:  0000555556247300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ffe3d8e5ff8 CR3: 00000000215d4000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  vhost_worker_create drivers/vhost/vhost.c:580 [inline]
> 
> The return value from vhost_task_create is incorrect if the kzalloc fails.
> 
> Christian, here is a fix for what's in your tree. Do you want me to submit
> a follow up patch like this or a replacement patch for:
> 
> commit 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process")
> 
> with the fix rolled into it?
> 



> 
> >From 0677ad6d77722f301ca35e8e0f8fd0cbd5ed8484 Mon Sep 17 00:00:00 2001
> From: Mike Christie <michael.christie@oracle.com>
> Date: Tue, 21 Mar 2023 12:39:39 -0500
> Subject: [PATCH] vhost_task: Fix vhost_task_create return value
> 
> vhost_task_create is supposed to return the vhost_task or NULL on
> failure. This fixes it to return the correct value when the allocation
> of the struct fails.
> ---
>  kernel/vhost_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 4b8aff160640..b7cbd66f889e 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -88,7 +88,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
>  
>  	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
>  	if (!vtsk)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>  	init_completion(&vtsk->exited);
>  	vtsk->data = arg;
>  	vtsk->fn = fn;
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
