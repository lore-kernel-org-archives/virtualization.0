Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822B0C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 09:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C0F960EA4;
	Tue, 22 Feb 2022 09:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m35D3GBp01ab; Tue, 22 Feb 2022 09:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0BAF860EA2;
	Tue, 22 Feb 2022 09:06:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D54A7C0021;
	Tue, 22 Feb 2022 09:06:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 991BEC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 09:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 824F081767
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 09:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wG9H_jgPupdt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 09:06:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38A1A813D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645520760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n95hjcK3W4o+MmDITLyeBOBOgMA4dIl+GTEujgQXs3M=;
 b=X4ohnVg0UUit3fKyLCeWRAZBNQQxHm645lgOMEVX3rags7rjM2P1jeKyLniLEfr1RAFOBr
 i84jTlw6Fd66Aoon2kUMWITY7JJjLIX67YFVCscypJll0VXsFSp9HgNw0r6EJAOpv+k9e/
 ues9BJyZvwIFjIyIbKuVOEctuep52Mc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-Q1CgAwBoOTOJp63mR6TOOA-1; Tue, 22 Feb 2022 04:05:58 -0500
X-MC-Unique: Q1CgAwBoOTOJp63mR6TOOA-1
Received: by mail-qk1-f198.google.com with SMTP id
 t10-20020a37aa0a000000b00605b9764f71so17089715qke.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 01:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n95hjcK3W4o+MmDITLyeBOBOgMA4dIl+GTEujgQXs3M=;
 b=1A4v49JkDZYaXrpbWmHu9bUlL1Yj0xyWvq1ZHs2B0QI67VSMUzbZ+vUMMNTs5n1O2W
 KGUt/Pukih1AxgfZaGeg/WFZDEuxZsCYoHzrTPhZoWq84DUzrQvb9/uEdyrLUUIixbCg
 9+lZHvv2MYgU8kXpj59vVVDZ7BTJ8kquw0MgHiDS29hG/uOZGxTef421tnH9n7pEL36A
 63jYz0V2gd6gJJ7LE4BGzWoP1KW06mlcAXgod2MrCcgpbZ4JUYMMM+xwU9gzZOnE/ysZ
 WoOdDaBOxY4GqwVjnPwuUYmjExRrBbKZmf6CzMkBTLDX/CkuyLsWrVVtEE0jGgYeARko
 1oTA==
X-Gm-Message-State: AOAM530+E0bFsLCXSf7UjqqnHTw/Kynxy3a1pP5UlQbmJScXzgKAS/jq
 dRz0Hma0H5roUN/uWD3i5070El+GarRmZ1YqGZ43giL/I/ZfEMLwz9qRemwhEDHgLOqW12VXWf5
 01MSn7yJFeD3X57H1gQ1tMtZzVGQMk/hAEU4/xEEsCQ==
X-Received: by 2002:a05:620a:165b:b0:62c:ecc8:c795 with SMTP id
 c27-20020a05620a165b00b0062cecc8c795mr10836984qko.82.1645520758433; 
 Tue, 22 Feb 2022 01:05:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwS9dXNMBTyZjFRzRaVicdBY9VjlIvSE10BjYtbw4zFc28c6qtGpYGes7034CgvhIY4gqaD/w==
X-Received: by 2002:a05:620a:165b:b0:62c:ecc8:c795 with SMTP id
 c27-20020a05620a165b00b0062cecc8c795mr10836977qko.82.1645520758216; 
 Tue, 22 Feb 2022 01:05:58 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id p66sm14199658qkf.12.2022.02.22.01.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 01:05:57 -0800 (PST)
Date: Tue, 22 Feb 2022 10:05:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Anirudh Rayabharam <mail@anirudhrb.com>
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <20220222090550.5wokee4tfynr36jn@sgarzare-redhat>
References: <20220221114916.107045-1-sgarzare@redhat.com>
 <CAGxU2F6aMqTaNaeO7xChtf=veDJYtBjDRayRRYkZ_FOq4CYJWQ@mail.gmail.com>
 <YhO6bwu7iDtUFQGj@anirudhrb.com>
 <20220221164420.cnhs6sgxizc6tcok@sgarzare-redhat>
 <YhPT37ETuSfmxr5G@anirudhrb.com>
 <20220221182628.vy2bjntxnzqh7elj@sgarzare-redhat>
 <YhPprNUAqYS3RVtU@anirudhrb.com>
MIME-Version: 1.0
In-Reply-To: <YhPprNUAqYS3RVtU@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Hillf Danton <hdanton@sina.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 22, 2022 at 01:06:12AM +0530, Anirudh Rayabharam wrote:
>On Mon, Feb 21, 2022 at 07:26:28PM +0100, Stefano Garzarella wrote:
>> On Mon, Feb 21, 2022 at 11:33:11PM +0530, Anirudh Rayabharam wrote:
>> > On Mon, Feb 21, 2022 at 05:44:20PM +0100, Stefano Garzarella wrote:
>> > > On Mon, Feb 21, 2022 at 09:44:39PM +0530, Anirudh Rayabharam wrote:
>> > > > On Mon, Feb 21, 2022 at 02:59:30PM +0100, Stefano Garzarella wrote:
>> > > > > On Mon, Feb 21, 2022 at 12:49 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > > > > >
>> > > > > > vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
>> > > > > > ownership. It expects current->mm to be valid.
>> > > > > >
>> > > > > > vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
>> > > > > > the user has not done close(), so when we are in do_exit(). In this
>> > > > > > case current->mm is invalid and we're releasing the device, so we
>> > > > > > should clean it anyway.
>> > > > > >
>> > > > > > Let's check the owner only when vhost_vsock_stop() is called
>> > > > > > by an ioctl.
>> > > > > >
>> > > > > > Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> > > > > > Cc: stable@vger.kernel.org
>> > > > > > Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
>> > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > > > > ---
>> > > > > >  drivers/vhost/vsock.c | 14 ++++++++------
>> > > > > >  1 file changed, 8 insertions(+), 6 deletions(-)
>> > > > >
>> > > > > Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
>> > > >
>> > > > I don't think this patch fixes "INFO: task hung in vhost_work_dev_flush"
>> > > > even though syzbot says so. I am able to reproduce the issue locally
>> > > > even with this patch applied.
>> > >
>> > > Are you using the sysbot reproducer or another test?
>> > > In that case, can you share it?
>> >
>> > I am using the syzbot reproducer.
>> >
>> > >
>> > > From the stack trace it seemed to me that the worker accesses a zone that
>> > > has been cleaned (iotlb), so it is invalid and fails.
>> >
>> > Would the thread hang in that case? How?
>>
>> Looking at this log [1] it seems that the process is blocked on the
>> wait_for_completion() in vhost_work_dev_flush().
>>
>> Since we're not setting the backend to NULL to stop the worker, it's likely
>> that the worker will keep running, preventing the flush work from
>> completing.
>
>The log shows that the worker thread is stuck in iotlb_access_ok(). How
>will setting the backend to NULL stop it? During my debugging I found
>that the worker is stuck in this while loop:

Okay, looking at your new patch, now I see. If we enter in this loop 
before setting the backend to NULL and we have start = 0 and end = (u64) 
-1 , we should be there forever.

I'll remove that tag in v2, but the test might fail without this patch 
applied, because for now we don't stop workers correctly.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
