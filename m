Return-Path: <SRS0=mz8r=PR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEB9C433EF
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 02:31:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E4760041
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 02:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1E4760041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A0F340607;
	Fri, 29 Oct 2021 02:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id La5ChsnJFLDG; Fri, 29 Oct 2021 02:31:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 30F6C4055D;
	Fri, 29 Oct 2021 02:31:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3F5FC0012;
	Fri, 29 Oct 2021 02:31:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B38EFC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 02:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BF304055D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 02:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UazYg39aWSX4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 02:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F14C640550
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 02:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635474696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KS9YsHERCSqszVKcWnqYLg+VRwD70ond/dLlufrGvBU=;
 b=PKaqUyRS0TLejum8u6cnjKJZzTrvWKhc3IzzhE75y3noizxnysReQiA8BsT+f/u1dJyGn1
 yDowSVidQVeFaA4LGBRF/f5CuB3b1wOtvbNG0Wt+7tKA9MUbkTAUStBuct/hdI4i3cHkSM
 y82XqK9fJ/QyyBVURcjFVP4S1utvWw0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-EUCtfiL2ONKgagJOL0tDpA-1; Thu, 28 Oct 2021 22:31:35 -0400
X-MC-Unique: EUCtfiL2ONKgagJOL0tDpA-1
Received: by mail-lj1-f198.google.com with SMTP id
 v17-20020a2e7a11000000b002118bb7d585so2498945ljc.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 19:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KS9YsHERCSqszVKcWnqYLg+VRwD70ond/dLlufrGvBU=;
 b=eApOC7PJbRZRS/DLUx5BoHMo9sUUMyLNy/vGnd8DlCjOtvRuqR04w9AXhrzdPyMUtB
 34f8tOKZ5rrlHO9+wTENmFPwu7EGJE0YkQs3nRmhm/9LlBIiPh4/zQOoqI8eNEvGbU3I
 vUYeML78wBSKEpkVULVz6eydNt8CjUAO+PyOPkSYMdSiY4JpCAy2ctbULA4MRiGDq61A
 ITDrSj7cqhnBmfj7JAny8LyY7cDKi3YyFuZfVVKikdewVN38qJ9TX2mis+Xo3Rd4zd3M
 isi93P6VaIP2grUSWqdE18koHDXE646z2zt1ZOZwEQ3zHd5q0AoT1lQkXShwzNSkqHwz
 BQaQ==
X-Gm-Message-State: AOAM530Mt7RqUmhi02oo9gHQQTDaSqiyVTEV9s2bkeVD21X3Ek5q9gLA
 NhKKGvbO5eW3wxSjKo+c8OZpV84vaJg/41ES4H8JjZA0FqGIFYW/9sTWFcty/1y3/qRR3zlaweo
 fx8Cad7ewj/lkkZGXbhlYYaujNZN7/VYbd0mvVrqCiB9FbgwroAF5b3/VEA==
X-Received: by 2002:a2e:5344:: with SMTP id t4mr8583496ljd.362.1635474694058; 
 Thu, 28 Oct 2021 19:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkE6KGADBf/EsFrsqvu7IeTg6jQ9kItE5rCj04rJbg+BM0HFLCKAa92csc+yItQEVORKrUCSwnyviVnT62lC4=
X-Received: by 2002:a2e:5344:: with SMTP id t4mr8583479ljd.362.1635474693879; 
 Thu, 28 Oct 2021 19:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027161446-mutt-send-email-mst@kernel.org>
 <CACGkMEuh_1Z39J2C220Ra6u3y=oZqsGgnmoCrtUpAGLkcD_0jQ@mail.gmail.com>
 <20211028094711.e6mm7ump5mrl7jpf@steredhat>
In-Reply-To: <20211028094711.e6mm7ump5mrl7jpf@steredhat>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Oct 2021 10:31:22 +0800
Message-ID: <CACGkMEtNAQDg9b03Xv3JRUX0EGXAv9JFogHGkpRbfgVghOiuuQ@mail.gmail.com>
Subject: Re: vDPA bus driver selection
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, Oct 28, 2021 at 5:47 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Oct 28, 2021 at 10:24:47AM +0800, Jason Wang wrote:
> >On Thu, Oct 28, 2021 at 4:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
> >> > Hi Stefano,
> >> >
> >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> >> > > Sent: Wednesday, October 27, 2021 8:04 PM
> >> > >
> >> > > Hi folks,
> >> > > I was trying to understand if we have a way to specify which vDPA bus driver
> >> > > (e.g. vhost-vdpa, virtio-vdpa) a device should use.
> >> > > IIUC we don't have it, and the first registered driver is used when a new device
> >> > > is registered.
> >> > >
> >> > > I was thinking if it makes sense to extend the management API to specify which
> >> > > bus driver to use for a device.
> >
> >Actually, we want to support this in the first version of vDPA bus.
> >But for some reason it was dropped. The idea is to specify the device
> >type 'virtio' or 'vhost'. But a concern is that, it may encourage
> >vendor to implement e.g virtio specific device (without DMA
> >isolation).
>
> Yep, I see the issue about device type, so I think make sense to require
> the support of both, how it is now basically.
>
> So instead of defining the type of the device, we could provide the
> possibility to choose which bus to connect it to,

I think you meant the "bus driver" here?

> in this way we
> continue to require that both are supported.
>
> As Michael suggested, instead of specify it at the creation time as was
> in my original idea, we can provide an API to attach/detach a device to
> a specific vDPA bus.

Does such an API exist in driver core?

>
> Of course, providing a default behaviour like now, which connects to the
> first registered.

If we want to change this, we can introduce "driver_override".

Thanks

>
> Thanks,
> Stefano
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
