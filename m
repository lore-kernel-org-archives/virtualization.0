Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F5DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 09:37:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E79600D4
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 09:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14E79600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C962C8268F;
	Thu, 28 Oct 2021 09:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G6tBCOhE8QUd; Thu, 28 Oct 2021 09:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5972682681;
	Thu, 28 Oct 2021 09:37:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D460C0019;
	Thu, 28 Oct 2021 09:37:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00A6EC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC7FA40267
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VI_a6-ylVIBf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:37:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E235D401FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635413868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2QTjDpNpjldtKRyTYzyEdCjNo5JsWlxQ2MFU2IP3I8=;
 b=NUwXk41l/qKZjTuhf6tbl+AyKk0hu01+Qn3Uq5rs6PO4rkobt7CoNzvjLXkEGdTJAx9Fe0
 4XccXz58V9IIScPPkycpde+/OPwkTq1EJr/5wcTf8aCIju2k52fI4IDXDVnz7qX6Hyiqgt
 /+glX/BsK4FmMLNHh1jbp+NVyOnRVJo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-0SUdNekRMtuL0ur1UCwE9Q-1; Thu, 28 Oct 2021 05:37:45 -0400
X-MC-Unique: 0SUdNekRMtuL0ur1UCwE9Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 s18-20020a056402521200b003dd5902f4f3so4973986edd.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d2QTjDpNpjldtKRyTYzyEdCjNo5JsWlxQ2MFU2IP3I8=;
 b=6C7ZR5mPWWrcZOCYYD0MCmNVNfmQqksP5lBIfvmbpzaIrPZeI4emMntZO7XjEhr+xA
 mUQehn8NKDp5ZkWXutpHBYodRcWINCfo9+ID+Vh9ygXJN7wFrp05D2T8m6gpmzeB2C4h
 5nI3IqGHQNXgOLnBtfYPDNq8Jks9zpF8mGnv9C9KWNjK7kHvDfMTqM8HMFZlwiEubkvl
 SeHZ9KWBxfFlRVW0qH6iwy1lwxQtFMo1jhgEoCpTVaDYZZkdaC4QJTzRj/PyXD8lG6fl
 ycp1aewbFkBSAKJIXAXheS+vDEkkrskc4eHnIrr2b+F5tsardQLesfsbsZq3UURnYNo2
 WADg==
X-Gm-Message-State: AOAM533xsrIeUWgMO/4v3SaprcGP/EZzMpZeiNwb9pEh3W8trxWJvUEn
 8kBsRiUC+lBRiM2Ct/ACbjKV56/OonKetAlj5l0KQ/5ExITpFVO9Pmc1H8bGB9gel0A9RVP1izX
 O0XOy3C1HsFjQf37FQE3Lbgkks3rAxLGMTYlAGxapRA==
X-Received: by 2002:a05:6402:1e95:: with SMTP id
 f21mr4720132edf.160.1635413864304; 
 Thu, 28 Oct 2021 02:37:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0TS0Dr+vI/BQ1/nHI0197vljUzfUPdFvM+xMxoXiStV251hrBC6jc1AWIcCZykSQdciOz6g==
X-Received: by 2002:a05:6402:1e95:: with SMTP id
 f21mr4720114edf.160.1635413864125; 
 Thu, 28 Oct 2021 02:37:44 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id qa19sm1076737ejc.54.2021.10.28.02.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 02:37:43 -0700 (PDT)
Date: Thu, 28 Oct 2021 11:37:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: vDPA bus driver selection
Message-ID: <20211028093740.jv7gfqrgrmq7elje@steredhat>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027154728.qkrtl6jtfoqlbwfu@steredhat>
 <PH0PR12MB548104D8BE92D2C5DC49A7A4DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548104D8BE92D2C5DC49A7A4DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>, Michael Tsirkin <mst@redhat.com>
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

On Wed, Oct 27, 2021 at 03:56:16PM +0000, Parav Pandit wrote:
>Hi Stefano,
>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>> Sent: Wednesday, October 27, 2021 9:17 PM
>> To: Parav Pandit <parav@nvidia.com>
>> Cc: Jason Wang <jasowang@redhat.com>; Michael Tsirkin <mst@redhat.com>;
>> Linux Virtualization <virtualization@lists.linux-foundation.org>; Eli Cohen
>> <elic@nvidia.com>
>> Subject: Re: vDPA bus driver selection
>>
>> Hi Parav,
>>
>> On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
>> >Hi Stefano,
>> >
>> >> From: Stefano Garzarella <sgarzare@redhat.com>
>> >> Sent: Wednesday, October 27, 2021 8:04 PM
>> >>
>> >> Hi folks,
>> >> I was trying to understand if we have a way to specify which vDPA bus
>> >> driver (e.g. vhost-vdpa, virtio-vdpa) a device should use.
>> >> IIUC we don't have it, and the first registered driver is used when a
>> >> new device is registered.
>> >>
>> >> I was thinking if it makes sense to extend the management API to
>> >> specify which bus driver to use for a device. A use case could be for
>> >> example a single host handling VMs and bare-metal containers, so we
>> >> would have both virtio-vdpa and vhost-vdpa loaded and we want to
>> >> attach some devices to VMs through vhost-vdpa and others to containers
>> through virtio-vdpa.
>> >>
>> >> What do you think?
>> >>
>> >One option is, user keeps the drivers_autoprobe disabled for the vdpa
>> >bus using,
>> >
>> >$ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac
>> >00:11:22:33:44:55 $ echo 0 > /sys/bus/vdpa/drivers_autoprobe
>> >
>> >And after vdpa device creation, it manually binds to the desired driver
>> >such as,
>> >
>> >$ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
>> >Or
>> >$ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind
>>
>> Cool, I didn't know that. This is very useful, but do you think it might be better
>> to integrate it with the netlink API and specify at creation which bus driver to
>> use?
>I think it is useful; for vduse case we need the ability to say "none" 
>as well and when nothing specified it should be default driver.

Yep, the default can be the actual behaviour.

>
>More than netlink, I think we need the ability in the core kernel to 
>make this choice.

Okay, but I think we can include that in the vdpa tool.

>I haven't explored what is already available to make that happen.

Me too, I only saw the .match() callback of "struct bus_type" that could 
be used for this purpose.

>If/once its available, I am sure it has more users than just vdpa.

Make sense. I'll spend some time next week.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
