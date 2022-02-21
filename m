Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BE5C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 18:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BA0D40577;
	Mon, 21 Feb 2022 18:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MU530FkFxBMy; Mon, 21 Feb 2022 18:26:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28B3B4053D;
	Mon, 21 Feb 2022 18:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC975C0021;
	Mon, 21 Feb 2022 18:26:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00818C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 18:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E283260E4F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 18:26:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7pGrTnWJcvbD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 18:26:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DB9860E1B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 18:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645467999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZ5IPvV3yb/nAnNH+aq40HHCb2PtQ6O64EyaH6AnGYs=;
 b=bQUsFXRR0NerXsFzAJ0RwsMLTyFQUOxIKXWhxF73Ut3YX7BGbk4yK4AJPowpH5/iF7Dcwu
 0bEI83pjYg6EQaNCxG3+RqkMbBVMM/erlCwXFHm40/2n6H6pxiTHUCrc5068BtxTmXn0HH
 7BzZ8Qg5lwSR1smIjc20yBYr/BSCsO4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-r7_Lo3M_Pa24SQjJm0PcRg-1; Mon, 21 Feb 2022 13:26:37 -0500
X-MC-Unique: r7_Lo3M_Pa24SQjJm0PcRg-1
Received: by mail-qk1-f200.google.com with SMTP id
 l82-20020a37a255000000b0060dd39f5d87so13646030qke.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 10:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JZ5IPvV3yb/nAnNH+aq40HHCb2PtQ6O64EyaH6AnGYs=;
 b=r6rHrUl7VhI1wd5RzGCf8gWfeGaghI8tJ2XccvO854c9H9L7g3aoi3u0mEdQveEa2R
 T6H8Pd5Jmk4/90CNeZSORZ+gyst1qcRXO+B2XhmE3R+v/k6DeduylEwgMPjoEbY45kkU
 baiR557NoLVUpJLBTdcjts6CMKvmRw/ORSdn/n7CGisBQsrq5guxxMGTo43gom4IhD3j
 RFazVzBI3di4wNgjsftvmkw+qLGTxtGvQJ/A0O3LzdS86lr1n047E/0VyibPYgmYeW6N
 +rBps/bk4UPBrUOWWkBxaruMGNYtHsr87imZ8NARXz28qIXqb1EvlN4Zoc7t5HiKQDUX
 KWBQ==
X-Gm-Message-State: AOAM530mvtjbKnt+U3ENuuaHzUV325hzwTzd8bZ+SwF0efpxp/9z0FTm
 ee60DX7NdH+NancOWqu/wbuS/GJcHkw+Y4NESOGEYLhyuQis5s1Cu77z/s19xfO4qtEcioFDNtm
 NwMutWtkTYcviQhe/sra5emmRiCSuiDH2MbGmX2L+wA==
X-Received: by 2002:a37:424a:0:b0:47c:cdc:ce63 with SMTP id
 p71-20020a37424a000000b0047c0cdcce63mr12938103qka.530.1645467994998; 
 Mon, 21 Feb 2022 10:26:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4Os+URRdB/SGPRTo0xBKVVbUYwpunZIvTXStuObgWhuvPS2PN1PoD2ZEPNCiFy8upFn3MwQ==
X-Received: by 2002:a37:424a:0:b0:47c:cdc:ce63 with SMTP id
 p71-20020a37424a000000b0047c0cdcce63mr12938089qka.530.1645467994703; 
 Mon, 21 Feb 2022 10:26:34 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id c12sm832212qtd.45.2022.02.21.10.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 10:26:34 -0800 (PST)
Date: Mon, 21 Feb 2022 19:26:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Anirudh Rayabharam <mail@anirudhrb.com>
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <20220221182628.vy2bjntxnzqh7elj@sgarzare-redhat>
References: <20220221114916.107045-1-sgarzare@redhat.com>
 <CAGxU2F6aMqTaNaeO7xChtf=veDJYtBjDRayRRYkZ_FOq4CYJWQ@mail.gmail.com>
 <YhO6bwu7iDtUFQGj@anirudhrb.com>
 <20220221164420.cnhs6sgxizc6tcok@sgarzare-redhat>
 <YhPT37ETuSfmxr5G@anirudhrb.com>
MIME-Version: 1.0
In-Reply-To: <YhPT37ETuSfmxr5G@anirudhrb.com>
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

On Mon, Feb 21, 2022 at 11:33:11PM +0530, Anirudh Rayabharam wrote:
>On Mon, Feb 21, 2022 at 05:44:20PM +0100, Stefano Garzarella wrote:
>> On Mon, Feb 21, 2022 at 09:44:39PM +0530, Anirudh Rayabharam wrote:
>> > On Mon, Feb 21, 2022 at 02:59:30PM +0100, Stefano Garzarella wrote:
>> > > On Mon, Feb 21, 2022 at 12:49 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > > >
>> > > > vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
>> > > > ownership. It expects current->mm to be valid.
>> > > >
>> > > > vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
>> > > > the user has not done close(), so when we are in do_exit(). In this
>> > > > case current->mm is invalid and we're releasing the device, so we
>> > > > should clean it anyway.
>> > > >
>> > > > Let's check the owner only when vhost_vsock_stop() is called
>> > > > by an ioctl.
>> > > >
>> > > > Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> > > > Cc: stable@vger.kernel.org
>> > > > Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
>> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > > ---
>> > > >  drivers/vhost/vsock.c | 14 ++++++++------
>> > > >  1 file changed, 8 insertions(+), 6 deletions(-)
>> > >
>> > > Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
>> >
>> > I don't think this patch fixes "INFO: task hung in vhost_work_dev_flush"
>> > even though syzbot says so. I am able to reproduce the issue locally
>> > even with this patch applied.
>>
>> Are you using the sysbot reproducer or another test?
>> In that case, can you share it?
>
>I am using the syzbot reproducer.
>
>>
>> From the stack trace it seemed to me that the worker accesses a zone that
>> has been cleaned (iotlb), so it is invalid and fails.
>
>Would the thread hang in that case? How?

Looking at this log [1] it seems that the process is blocked on the 
wait_for_completion() in vhost_work_dev_flush().

Since we're not setting the backend to NULL to stop the worker, it's 
likely that the worker will keep running, preventing the flush work from 
completing.

[1] https://syzkaller.appspot.com/text?tag=CrashLog&x=153f0852700000

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
