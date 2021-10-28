Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4299EC433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 02:25:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F1F60C4A
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 02:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6F1F60C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7FD080E86;
	Thu, 28 Oct 2021 02:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0qoBue4SyXJ1; Thu, 28 Oct 2021 02:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D39D80D9E;
	Thu, 28 Oct 2021 02:25:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 330EBC0019;
	Thu, 28 Oct 2021 02:25:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFA9EC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D77DA40150
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tny9ZLaK2Ocw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:25:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9333A4010E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635387901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xvvTYvuUAPhIBLa9iFi5fJORPbiXKMCJ8EWR1aO3OUo=;
 b=cROrXnJzyIydzraP47mKn3ECUjbxB62wbwkk3wlRA/W9dVmcMfsYcLcAO9UOo00ISIYYwV
 vt+9N3e8hwYK8MgkxCt9UZARmBRy2JCo/xwO0OQIaM85g6itB+r1aOk3S/8DX2XrNGtvnU
 r/LzuiHG6z/J7RxeINfHMX4u5c/fIB4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-z1dbkX5jN0Sc6u_Z6l1JVA-1; Wed, 27 Oct 2021 22:24:59 -0400
X-MC-Unique: z1dbkX5jN0Sc6u_Z6l1JVA-1
Received: by mail-lf1-f71.google.com with SMTP id
 x7-20020a056512130700b003fd1a7424a8so2157143lfu.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xvvTYvuUAPhIBLa9iFi5fJORPbiXKMCJ8EWR1aO3OUo=;
 b=qJU/GWp2p/Xkh8+z2JH3HYERFtDm+I1N0Ra/6suwLfbGluccj3I16pY4qPPeX5jgBg
 4dol8rKKk3yzDWDTtdjznTpfwu1KdQQ7ZigthDJXK5HfaLO4Dpqt9TJaTlGkieQimN9/
 LOmMCeP3+BF7fMLqJIQwcf4NM7eF4dy+NkOFAU1DxYeknLFUDb0yUbmHHMgQem1HINy4
 H3xafZdiSsUecNpPg34UCgMhJu/HHAodUdxxPtb59MQIpUoyWa2Xf8ZXExw4sS+JbhDn
 PL4sEhjvmwQnnwcYoCI/0wUb+EFzEnBeMaJ2ohUrRQd315BDw3Kwn/PPAwVlDn6oGkP1
 ht1Q==
X-Gm-Message-State: AOAM5317pjZ2DQ84bEyl1x8V4r0IH2zaByz++Q5RYvUGowmkSaH49IEs
 /eDHloDdYpd+C+NZnhmB2b2bIEma3JcVLrnL7WB6sE/NC32ln9IABW2tOogn33c1/OydwWM32Ih
 HtoLfOne5Gs8rcMyMrIMfAfa8yFq3wRN4xPwGsga9Dlif4Y9ORJYnfpirxQ==
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr1441796lfg.498.1635387898328; 
 Wed, 27 Oct 2021 19:24:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1deplkGDlVshRt4Pbt5z4n+K2KN01oxs2c8oool8fUDEd/UuIQjora9EBcNpFMWPtAvllCwUTliqJfHv9r/Q=
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr1441780lfg.498.1635387898135; 
 Wed, 27 Oct 2021 19:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027161446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211027161446-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Oct 2021 10:24:47 +0800
Message-ID: <CACGkMEuh_1Z39J2C220Ra6u3y=oZqsGgnmoCrtUpAGLkcD_0jQ@mail.gmail.com>
Subject: Re: vDPA bus driver selection
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Oct 28, 2021 at 4:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
> > Hi Stefano,
> >
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > Sent: Wednesday, October 27, 2021 8:04 PM
> > >
> > > Hi folks,
> > > I was trying to understand if we have a way to specify which vDPA bus driver
> > > (e.g. vhost-vdpa, virtio-vdpa) a device should use.
> > > IIUC we don't have it, and the first registered driver is used when a new device
> > > is registered.
> > >
> > > I was thinking if it makes sense to extend the management API to specify which
> > > bus driver to use for a device.

Actually, we want to support this in the first version of vDPA bus.
But for some reason it was dropped. The idea is to specify the device
type 'virtio' or 'vhost'. But a concern is that, it may encourage
vendor to implement e.g virtio specific device (without DMA
isolation).

>A use case could be for example a single host
> > > handling VMs and bare-metal containers, so we would have both virtio-vdpa
> > > and vhost-vdpa loaded and we want to attach some devices to VMs through
> > > vhost-vdpa and others to containers through virtio-vdpa.
> > >
> > > What do you think?
> > >
> > One option is, user keeps the drivers_autoprobe disabled for the vdpa bus using,
> >
> > $ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac 00:11:22:33:44:55
> > $ echo 0 > /sys/bus/vdpa/drivers_autoprobe
> >
> > And after vdpa device creation, it manually binds to the desired driver such as,
> >
> > $ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
> > Or
> > $ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind
> >
> > In an case of VDUSE, it makes more sense to bind to the one of the above driver after user space has connected the use space backend to the kernel device.
>
> The only annoying thing is that manual bind is not validated.
> E.g. if one makes a mistake and binds an incorrect device,
> it just tends to crash IIRC.
> Another is that it all needs to be root.

I'm not sure it's worth bothering with. As discussed, switching
between vendor drivers and vfio requires manually bind/unbind as well.

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
