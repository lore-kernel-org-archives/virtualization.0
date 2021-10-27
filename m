Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B44C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E4F610A0
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7E4F610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C7094058E;
	Wed, 27 Oct 2021 20:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OI_WyxWWbQdR; Wed, 27 Oct 2021 20:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E75BA4058B;
	Wed, 27 Oct 2021 20:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF14BC0019;
	Wed, 27 Oct 2021 20:16:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F65CC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E3AF40592
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6g_hXIkBnUVB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:16:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B73B140591
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635365791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0IcSHDa/mVQ8qTDdjAchsitIHUeZAcAq+Et6yXgm3A=;
 b=C4iNxpK3tqJYiX4x71U//V/38QTsd/WWwv6DeSkP9uLpYNs4x7DH+cqaysBGYTWfg5NqfN
 Lf7HwiRXgBbFHtnjGbD06dp0Y+kAe8ufF5p5xfn5Y3+KTfhj1iZ2KyIka90Ley4IgHc32V
 xMuzcI3OAQCDPgwxYE95CnY4oSwEsk0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-B_OluDVUPMKC-UgGpbp-7w-1; Wed, 27 Oct 2021 16:16:30 -0400
X-MC-Unique: B_OluDVUPMKC-UgGpbp-7w-1
Received: by mail-ed1-f69.google.com with SMTP id
 w7-20020a056402268700b003dd46823a18so3384694edd.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 13:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j0IcSHDa/mVQ8qTDdjAchsitIHUeZAcAq+Et6yXgm3A=;
 b=axt6pMUhW6ucuNAxgxsjf5E5fXhBYqpCFesOGGycA0mCBFjtjB0DSgJvMi0aKkJf6c
 c174BP/LzCgoLMWrup4ObyvGrXgwqEnfMQT149TrFGHwxGZmTqNA1duKhuXWBvgoJq3X
 Jz1fvarxFUgr5xXrWuaxfnUWVFeG0b1XFey7GIMQY6maYWCYkgfoW3a5l0dKUgB8anVu
 /kP6WGlDme/gt07VKvqFO32JDeSXa8Wi7HDBf55wugpHteR+w8UfmgKVwXY/L9NeXWnY
 Dh7qywsNgUjyiyBcVj6kxBWKCkO1A+Tb3Q1wbaBlXmzbS9J0h0kgvgFal9oEWjgCYF+Q
 E3ig==
X-Gm-Message-State: AOAM533YLUYCkO9J7wabx1oAqfbsd5uEwdwJC4UrYGDqvv8Fje444JoA
 sRoTsMhzhG5YHmh9Zym4Zq1K9q3eZ4SZEmRIxxA53BiAYG3bka5xnx9F+Pn0iWoirrV0CMHgKqq
 +HR5/KseYO1RKGH4wM5bxermfupB94r2TCOeXRXSh6A==
X-Received: by 2002:a17:906:2d51:: with SMTP id
 e17mr9800067eji.132.1635365789437; 
 Wed, 27 Oct 2021 13:16:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGtGTq5eGd92Yb8SXui1svqa9uEKD1h3x/z3e3btlcHb+7CbBKC65c6WjrwVIJ+erzLxxCkw==
X-Received: by 2002:a17:906:2d51:: with SMTP id
 e17mr9800049eji.132.1635365789241; 
 Wed, 27 Oct 2021 13:16:29 -0700 (PDT)
Received: from redhat.com ([2.55.137.59])
 by smtp.gmail.com with ESMTPSA id b9sm553475edk.62.2021.10.27.13.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 13:16:28 -0700 (PDT)
Date: Wed, 27 Oct 2021 16:16:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: vDPA bus driver selection
Message-ID: <20211027161446-mutt-send-email-mst@kernel.org>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>
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

On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
> Hi Stefano,
> 
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > Sent: Wednesday, October 27, 2021 8:04 PM
> > 
> > Hi folks,
> > I was trying to understand if we have a way to specify which vDPA bus driver
> > (e.g. vhost-vdpa, virtio-vdpa) a device should use.
> > IIUC we don't have it, and the first registered driver is used when a new device
> > is registered.
> > 
> > I was thinking if it makes sense to extend the management API to specify which
> > bus driver to use for a device. A use case could be for example a single host
> > handling VMs and bare-metal containers, so we would have both virtio-vdpa
> > and vhost-vdpa loaded and we want to attach some devices to VMs through
> > vhost-vdpa and others to containers through virtio-vdpa.
> > 
> > What do you think?
> > 
> One option is, user keeps the drivers_autoprobe disabled for the vdpa bus using,
> 
> $ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac 00:11:22:33:44:55
> $ echo 0 > /sys/bus/vdpa/drivers_autoprobe
> 
> And after vdpa device creation, it manually binds to the desired driver such as,
> 
> $ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
> Or
> $ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind
> 
> In an case of VDUSE, it makes more sense to bind to the one of the above driver after user space has connected the use space backend to the kernel device.

The only annoying thing is that manual bind is not validated.
E.g. if one makes a mistake and binds an incorrect device,
it just tends to crash IIRC.
Another is that it all needs to be root.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
