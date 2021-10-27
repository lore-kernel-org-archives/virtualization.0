Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805DAC433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 15:47:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171FB610A0
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 15:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 171FB610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0D5A40542;
	Wed, 27 Oct 2021 15:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PuoSXEngYWjt; Wed, 27 Oct 2021 15:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 68928403B6;
	Wed, 27 Oct 2021 15:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26385C0012;
	Wed, 27 Oct 2021 15:47:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2D42C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB92840431
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4p_R62N72Ex6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:47:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23B6A403B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635349657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qojTVlChUGuAo6lu+uazXKMgFp3Ts7McYxeAvDlSyq0=;
 b=L8T/p5muiXTrtJkXdOfzYK0qv95WTKKQvwLpPwqv9czfcGZ2bOo60RZ+Wh8q4l3YZoDxQZ
 33UhX8eSRWQnyHa17dK5p9CeK0Ch8L6CbKX1RbhMtzIbj+fdby/XDxDI26Wf1j0iYedkRh
 vZC9bukRPqRYqbV8zo/MrISOPHeTdts=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-tsczvhhqNF2WTrvmHgbCcQ-1; Wed, 27 Oct 2021 11:47:33 -0400
X-MC-Unique: tsczvhhqNF2WTrvmHgbCcQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 u10-20020a50d94a000000b003dc51565894so2685095edj.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 08:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qojTVlChUGuAo6lu+uazXKMgFp3Ts7McYxeAvDlSyq0=;
 b=FhEmwy8O2PY7VHqQVga6izBw0hU69y2sg2BC9oQj3xDaIvwMQLgmI/bctv9NbF+Yk5
 iL/2DJQwOhalpExl1KgRFy3xXDNe9b6NX2sd7BSsh2uVIepg+2q+0TMoyooD2s5t6ICG
 Uv42vma9TmltEu4eE66p82ar1u6MA+y+tetPiVOhUfmJ3kxCVxbhPcWG0LhAJiFD7Sx5
 pPVIavr2mN7eK0mBKopDRx+mcyWOwpA+rb/l5+MUX82ObBm8XyfTDbXPgE4FYOYLNlP0
 pIHvBaBO476JkbxW3M0KVt2JyEUdyStTHh0Q4Y0SDyEePlrE5xaQ4qcdFUeRaSAzw2L4
 saKw==
X-Gm-Message-State: AOAM533bx3QZO/itBSJSi/Yr2RY2EdR5tXo0Iz25rQHqfKLOGHpX+h8X
 x5tdOcARUpJ/RGUnSW6r92jKggZIinQ3SWkRRNLaSvfDK1RhluewaqdeyJVAXCSw7z+2OE+Dyt3
 eYn5oS5Mq9aVBaIOR6/EZrDcqvKbsHwad8+6Z5blWxw==
X-Received: by 2002:a50:da4e:: with SMTP id a14mr46145815edk.154.1635349652665; 
 Wed, 27 Oct 2021 08:47:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFQMZaD/+s6v009vYlcJHwsR4qnL6jJ0BpJ5aUlr16KfDHnv679ZlnTS8dWXBK9HvtGTURGQ==
X-Received: by 2002:a50:da4e:: with SMTP id a14mr46145788edk.154.1635349652374; 
 Wed, 27 Oct 2021 08:47:32 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id dz13sm282735edb.28.2021.10.27.08.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 08:47:32 -0700 (PDT)
Date: Wed, 27 Oct 2021 17:47:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: vDPA bus driver selection
Message-ID: <20211027154728.qkrtl6jtfoqlbwfu@steredhat>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
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

Hi Parav,

On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
>Hi Stefano,
>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>> Sent: Wednesday, October 27, 2021 8:04 PM
>>
>> Hi folks,
>> I was trying to understand if we have a way to specify which vDPA bus driver
>> (e.g. vhost-vdpa, virtio-vdpa) a device should use.
>> IIUC we don't have it, and the first registered driver is used when a new device
>> is registered.
>>
>> I was thinking if it makes sense to extend the management API to specify which
>> bus driver to use for a device. A use case could be for example a single host
>> handling VMs and bare-metal containers, so we would have both virtio-vdpa
>> and vhost-vdpa loaded and we want to attach some devices to VMs through
>> vhost-vdpa and others to containers through virtio-vdpa.
>>
>> What do you think?
>>
>One option is, user keeps the drivers_autoprobe disabled for the vdpa bus using,
>
>$ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac 00:11:22:33:44:55
>$ echo 0 > /sys/bus/vdpa/drivers_autoprobe
>
>And after vdpa device creation, it manually binds to the desired driver such as,
>
>$ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
>Or
>$ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind

Cool, I didn't know that. This is very useful, but do you think it might 
be better to integrate it with the netlink API and specify at creation 
which bus driver to use?

>
>In an case of VDUSE, it makes more sense to bind to the one of the 
>above driver after user space has connected the use space backend to 
>the kernel device.

Yep, make sense.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
