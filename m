Return-Path: <SRS0=mz8r=PR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F53C433F5
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 14:32:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D2A60FC1
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 14:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12D2A60FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5A3940119;
	Fri, 29 Oct 2021 14:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0bB9flIFIYH; Fri, 29 Oct 2021 14:32:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5349940295;
	Fri, 29 Oct 2021 14:32:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02D01C0019;
	Fri, 29 Oct 2021 14:32:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79213C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 14:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50B8760610
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 14:32:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id keVZheQ01fy3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 14:32:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7245D605FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635517965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CH2B+5IrG0xt0oUBxFEHEtxPkhZjc/Lrujck6nOpjbE=;
 b=b7tEeg1jNTyMRKc//sJ7yTTtKqfaZyKfCfN4Kmrh9c8NvAEyj0nBRFFfMAJ5LrqXaEJr0f
 dnLXZjy2hgPJERRBP2/Are5Z0ftMMSk8LPY2ghknadbcr9oFFqkDNdpyN/RLJPvRmhQKIc
 ADdFuTOnTiSuvuF7QtQ9Z503TusvcL8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-JRBkimsBPGGt-Hp1rBhTgg-1; Fri, 29 Oct 2021 10:32:42 -0400
X-MC-Unique: JRBkimsBPGGt-Hp1rBhTgg-1
Received: by mail-ed1-f70.google.com with SMTP id
 f4-20020a50e084000000b003db585bc274so9357114edl.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 07:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CH2B+5IrG0xt0oUBxFEHEtxPkhZjc/Lrujck6nOpjbE=;
 b=RIGvO1WVMEedYu03zyeGKsLOoNZSPAHpwlJXwDE//Tg6I6Lp1cLtRHKOIdu11S0AjR
 tyqYBT/KqIm9qJZs+sDSkabFaWx0d4JFTp5PFElIscphjKiDZL8W+yZnqwh2/BPDqD7J
 dhvHRiyGLUY+PknF2ReEQHuta1Vj5wCExWITK3QVWpNdsrmx+AJfEep+0kpIaEWVtlQ/
 n/TRK+8IPrEu4XH9I4VcMSg+jk1M/Qs/pX0b9XD/27i3BuDiDMTwLdN85+bCo5qZul9J
 93No89tVr1xqmmb3zp+G75fK8DbA/oQsN4Qrl5yhQ5rxr+FN0EmKEXsapql20CkuBbVF
 IRyw==
X-Gm-Message-State: AOAM532zqfKXXoB0aElwaoR1Qdtm7Zrcv5hzjHXFw7yAOfedHDPWkqtS
 GtWtYQed7LaViRcDDMfMSMU5iVMaqYabHL4O2fI5gonfYQz0qe3kCQPUPKRKud8j34ySGeQObRG
 5Ey9xei40DsAxmsQXR9zuU8qErI82tN3BJkf2hnDBLg==
X-Received: by 2002:a17:907:1c25:: with SMTP id
 nc37mr170707ejc.333.1635517961556; 
 Fri, 29 Oct 2021 07:32:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaTmd/lmEEnlfxahNIPs0AD593I3JH/6MMKc4uTicpEqiVnZKoBaEHEUu/GkeybSobCDHqyg==
X-Received: by 2002:a17:907:1c25:: with SMTP id
 nc37mr170683ejc.333.1635517961363; 
 Fri, 29 Oct 2021 07:32:41 -0700 (PDT)
Received: from steredhat (a-ol3-4.tin.it. [212.216.181.35])
 by smtp.gmail.com with ESMTPSA id m3sm3693875edc.36.2021.10.29.07.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Oct 2021 07:32:40 -0700 (PDT)
Date: Fri, 29 Oct 2021 16:32:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: vDPA bus driver selection
Message-ID: <20211029143238.c63gylmuxotmqim6@steredhat>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027161446-mutt-send-email-mst@kernel.org>
 <CACGkMEuh_1Z39J2C220Ra6u3y=oZqsGgnmoCrtUpAGLkcD_0jQ@mail.gmail.com>
 <20211028094711.e6mm7ump5mrl7jpf@steredhat>
 <CACGkMEtNAQDg9b03Xv3JRUX0EGXAv9JFogHGkpRbfgVghOiuuQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtNAQDg9b03Xv3JRUX0EGXAv9JFogHGkpRbfgVghOiuuQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Oct 29, 2021 at 10:31:22AM +0800, Jason Wang wrote:
>On Thu, Oct 28, 2021 at 5:47 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Oct 28, 2021 at 10:24:47AM +0800, Jason Wang wrote:
>> >On Thu, Oct 28, 2021 at 4:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>
>> >> On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
>> >> > Hi Stefano,
>> >> >
>> >> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> >> > > Sent: Wednesday, October 27, 2021 8:04 PM
>> >> > >
>> >> > > Hi folks,
>> >> > > I was trying to understand if we have a way to specify which vDPA bus driver
>> >> > > (e.g. vhost-vdpa, virtio-vdpa) a device should use.
>> >> > > IIUC we don't have it, and the first registered driver is used when a new device
>> >> > > is registered.
>> >> > >
>> >> > > I was thinking if it makes sense to extend the management API to specify which
>> >> > > bus driver to use for a device.
>> >
>> >Actually, we want to support this in the first version of vDPA bus.
>> >But for some reason it was dropped. The idea is to specify the device
>> >type 'virtio' or 'vhost'. But a concern is that, it may encourage
>> >vendor to implement e.g virtio specific device (without DMA
>> >isolation).
>>
>> Yep, I see the issue about device type, so I think make sense to require
>> the support of both, how it is now basically.
>>
>> So instead of defining the type of the device, we could provide the
>> possibility to choose which bus to connect it to,
>
>I think you meant the "bus driver" here?

Yep, sorry!

>
>> in this way we
>> continue to require that both are supported.
>>
>> As Michael suggested, instead of specify it at the creation time as 
>> was
>> in my original idea, we can provide an API to attach/detach a device 
>> to
>> a specific vDPA bus.
>
>Does such an API exist in driver core?

I need to check better, Parav showed something with sysfs to bind a 
device to a driver, so maybe yes.

I just tried the following and it worked:

$ vdpa dev add mgmtdev vdpasim_net name vdpa0

$ readlink -f /sys/bus/vdpa/devices/vdpa0/driver
/sys/bus/vdpa/drivers/vhost_vdpa

$ echo vdpa0 > /sys/bus/vdpa/devices/vdpa0/driver/unbind

$ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind

>
>>
>> Of course, providing a default behaviour like now, which connects to the
>> first registered.
>
>If we want to change this, we can introduce "driver_override".

Yep, I'll take a look.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
