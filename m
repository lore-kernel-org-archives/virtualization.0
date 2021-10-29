Return-Path: <SRS0=mz8r=PR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B71C433F5
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 14:41:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB66610CB
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 14:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BB66610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 148EB60618;
	Fri, 29 Oct 2021 14:41:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XQlFounBwa3A; Fri, 29 Oct 2021 14:41:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B4100605F8;
	Fri, 29 Oct 2021 14:41:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76F0BC0019;
	Fri, 29 Oct 2021 14:41:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7518C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 14:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B08F14029D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 14:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hf3_pd_T3n_t
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 14:41:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A5E24029A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635518465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z1nxmUAxUG/x4Dg/ouJeQudwFeZUvW0lsB6jmZSInk0=;
 b=gUenk8Lco++udN5K+u4z+wzz9hHlCavbni34Rz39Sr995uy1HzdyOY6tEuezPaglB1Biy/
 jFb0PnzLBeFK1fWbWMFRIo/5zwX5Rkm/FZJY2wrKjquvsA0FgvHW/19tolksX04zpKDIJv
 z6ROury2PmDWZt7IufmqcI72mtbS9wc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-Wja-WDT3M1qeBPV1kgJX5w-1; Fri, 29 Oct 2021 10:41:04 -0400
X-MC-Unique: Wja-WDT3M1qeBPV1kgJX5w-1
Received: by mail-ed1-f72.google.com with SMTP id
 u10-20020a50d94a000000b003dc51565894so9380709edj.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 07:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z1nxmUAxUG/x4Dg/ouJeQudwFeZUvW0lsB6jmZSInk0=;
 b=JPIS5cRPr1SvU7IGw+7+jMT7CSl6QvXdaofxp7z7r0emfSAy94KHzyiNTnWOP9Xbat
 PgfzVW5F1kbDMb3jmh3jnV9Me8Ol95aTtN/xw3pSxCXxRkHfwM8iJAsFRteb0yXNSGMo
 8rGgpfxrgP0bl6wDRq34mnFlNBOtEb2aVlJTmey1z8LnTKw5vVmbTAEEExF3hcJVWuiy
 GxAL6bfd/F7/a9wpGmXzCXWnslz4Ba7/R1T6cqH7FrY6MFB3bjrp9xl1ryPw7bBecnIa
 QjOz4kY05BiMXms26Ce1qix8ij2LtsG86gJBOFMxZbchD/uJXOA32srKCuH1yZFVYvT5
 Tkrg==
X-Gm-Message-State: AOAM533kCISWP6zWO27AorNofAqsi95i80nqDPaAE9dPqD21KNWzAso2
 iswquZIW5yTREvL454XWWILLRoBBHHXbVupnTVEE8qfkAuY0paZEVHwTs3e3owNQkkIQ6gM5PO8
 pIKjhWHdxaow46Om4Gwmra8jmd4V2Q0fldLIx39431g==
X-Received: by 2002:a17:906:2cd5:: with SMTP id
 r21mr14458007ejr.435.1635518462838; 
 Fri, 29 Oct 2021 07:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMtGOdp6kLMM6j5MwAl4v/tlZWSQr/6mJpJuQePSvW7cB2HwhgXEwJFCYlDciwM6f24F06Bw==
X-Received: by 2002:a17:906:2cd5:: with SMTP id
 r21mr14457984ejr.435.1635518462664; 
 Fri, 29 Oct 2021 07:41:02 -0700 (PDT)
Received: from steredhat (a-ol3-4.tin.it. [212.216.181.35])
 by smtp.gmail.com with ESMTPSA id ak17sm1168486ejc.10.2021.10.29.07.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Oct 2021 07:41:02 -0700 (PDT)
Date: Fri, 29 Oct 2021 16:41:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: vDPA bus driver selection
Message-ID: <20211029144100.eybykx7o4tpwmjph@steredhat>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027154728.qkrtl6jtfoqlbwfu@steredhat>
 <PH0PR12MB548104D8BE92D2C5DC49A7A4DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211028093740.jv7gfqrgrmq7elje@steredhat>
 <PH0PR12MB54813F6CFDF8A1E1F7AE68B8DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt+iwKc=O552rsMUWdmT1MGVpUJrKsjdjv7mv=4uX1uOQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt+iwKc=O552rsMUWdmT1MGVpUJrKsjdjv7mv=4uX1uOQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Michael Tsirkin <mst@redhat.com>
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

On Fri, Oct 29, 2021 at 10:34:00AM +0800, Jason Wang wrote:
>On Thu, Oct 28, 2021 at 5:48 PM Parav Pandit <parav@nvidia.com> wrote:
>>
>>
>>
>> > From: Stefano Garzarella <sgarzare@redhat.com>
>> > Sent: Thursday, October 28, 2021 3:08 PM
>>
>> > >> >$ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac
>> > >> >00:11:22:33:44:55 $ echo 0 > /sys/bus/vdpa/drivers_autoprobe
>> > >> >
>> > >> >And after vdpa device creation, it manually binds to the desired
>> > >> >driver such as,
>> > >> >
>> > >> >$ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
>> > >> >Or
>> > >> >$ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind
>> > >>
>> > >> Cool, I didn't know that. This is very useful, but do you think it
>> > >> might be better to integrate it with the netlink API and specify at
>> > >> creation which bus driver to use?
>> > >I think it is useful; for vduse case we need the ability to say "none"
>> > >as well and when nothing specified it should be default driver.
>> >
>> > Yep, the default can be the actual behaviour.
>> >
>> > >
>> > >More than netlink, I think we need the ability in the core kernel to
>> > >make this choice.
>> >
>> > Okay, but I think we can include that in the vdpa tool.
>> If functionality and interface exists in other part of the it is hard to wrap that in vdpa tool that does the duplicate work.

Got it.

>>
>> >
>> > >I haven't explored what is already available to make that happen.
>> >
>> > Me too, I only saw the .match() callback of "struct bus_type" that could be used
>> > for this purpose.
>> >
>> > >If/once its available, I am sure it has more users than just vdpa.
>> >
>> > Make sense. I'll spend some time next week.
>>
>> Ok. yeah, may be a desired driver can be stored in the vdpa_device that match() routine can use.
>> And if that driver is not available,  it returns EPROBE_DEFER; so whenever such driver is loaded it can be bind.
>>
>> But I think before wrapping something in vdpa, need to find a reason why the current interface doesn't solve the problem and also to figure out plumbing.
>

Yep, when I started this thread I wasn't aware of that APIs available 
through sysfs.

It could be useful to start documenting vDPA (life cycle, management 
API, etc.).  I have a plan to add some vDPA docs in linux/Documentation, 
maybe we can include also these things.

>I agree. If it's something that can easily be addressed by the
>management code (just a matter of the extra steps for manual setup).
>It's probably not worth bothering.

Yep, I agree too. It seems we can easily switch the vDPA bus driver at 
runtime.

Maybe the only missing point is a way to specify the default bus driver 
to use for a device. Of course the workaround is to unbind it and bind 
to the desired one.

Thank you so much for this very helpful discussion,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
