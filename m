Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A095C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 09:47:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BB660F70
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 09:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7BB660F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5598B405F0;
	Thu, 28 Oct 2021 09:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sqvv94B3YjHl; Thu, 28 Oct 2021 09:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08DF4405E8;
	Thu, 28 Oct 2021 09:47:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C71D4C0019;
	Thu, 28 Oct 2021 09:47:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5965AC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4191D405ED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AHPMRyuiLpr1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:47:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98308405E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635414436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0FnEp/IRKlVTemeGRvoWP5rv+nRUuc8+dJjjvAyrtA=;
 b=CwAclL1j0rftQ5YpQolrzCkncxpuYbbvDKSN66astSfC0yWSo9Dvw2AFgZBlgutnRqzAET
 NHTBWk03DE7E6wJ3sm4/CU4AWEUjLEG6LHKghSOOpTcTyu2APBTfdzczqzGbhFwXwfchmV
 golRXMb6i5lf1ap420eXUdQLAkxOllI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-vI310TdUMp6VWVQodgouTQ-1; Thu, 28 Oct 2021 05:47:15 -0400
X-MC-Unique: vI310TdUMp6VWVQodgouTQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 y3-20020a056402358300b003dd490c775cso4997212edc.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o0FnEp/IRKlVTemeGRvoWP5rv+nRUuc8+dJjjvAyrtA=;
 b=1uo5GMUs+41CWX49p7td/CPDLX/9jWpEYzZV8CIXu81JTYQ3BOiLCpr2zycPUA1Z4k
 RxNxmECwsIJH49pbKXUetRT8sYn6cFCCS1JyvFirBRavRO9OknqtAk6OFYk3oTpgDha+
 qEeShpLgcMTi7MP+ol23t2fRac0CY/ceDAl8p0JLjOrJFuIa1RNHbb35ZaCIkn5criwb
 9jdpBvvHtId2GcCmKQwJMGu3ApfnNmM+8UBzhUCvZmXD71ULZBMvBdqm5bSomroVU2oB
 jwVSQXlEqD45w2gBockD1uK81RMsjaSlqxlzFg1wKZIJU44ae144uh+Lpw5eIfu/8GzQ
 lFRQ==
X-Gm-Message-State: AOAM5303Cs6qjnRrUR3Fo01O4hQJqwlzgaRT5uL/aHUtJh74NDM2JuNS
 bIGDixaU71PiUMo2qE85OKTYSsfwKI/bMVxzEOVLUjronBEaV6uIhTrPTd1zNlvECiYE1+S0eMx
 7TNETERfWa1kj25AgEhQmXqzQHhYDkPWpCgll0hykiw==
X-Received: by 2002:a17:906:c7c1:: with SMTP id
 dc1mr4166717ejb.6.1635414434005; 
 Thu, 28 Oct 2021 02:47:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOkd+V8EpM6ap+MzGhgTDUbcPmVfpVOJMJmJIF32laKEBdjyF+98344IhzJSitY8egIIe8Dg==
X-Received: by 2002:a17:906:c7c1:: with SMTP id
 dc1mr4166702ejb.6.1635414433850; 
 Thu, 28 Oct 2021 02:47:13 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id r15sm1481589edd.96.2021.10.28.02.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 02:47:13 -0700 (PDT)
Date: Thu, 28 Oct 2021 11:47:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: vDPA bus driver selection
Message-ID: <20211028094711.e6mm7ump5mrl7jpf@steredhat>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027161446-mutt-send-email-mst@kernel.org>
 <CACGkMEuh_1Z39J2C220Ra6u3y=oZqsGgnmoCrtUpAGLkcD_0jQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuh_1Z39J2C220Ra6u3y=oZqsGgnmoCrtUpAGLkcD_0jQ@mail.gmail.com>
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

On Thu, Oct 28, 2021 at 10:24:47AM +0800, Jason Wang wrote:
>On Thu, Oct 28, 2021 at 4:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
>> > Hi Stefano,
>> >
>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > > Sent: Wednesday, October 27, 2021 8:04 PM
>> > >
>> > > Hi folks,
>> > > I was trying to understand if we have a way to specify which vDPA bus driver
>> > > (e.g. vhost-vdpa, virtio-vdpa) a device should use.
>> > > IIUC we don't have it, and the first registered driver is used when a new device
>> > > is registered.
>> > >
>> > > I was thinking if it makes sense to extend the management API to specify which
>> > > bus driver to use for a device.
>
>Actually, we want to support this in the first version of vDPA bus.
>But for some reason it was dropped. The idea is to specify the device
>type 'virtio' or 'vhost'. But a concern is that, it may encourage
>vendor to implement e.g virtio specific device (without DMA
>isolation).

Yep, I see the issue about device type, so I think make sense to require 
the support of both, how it is now basically.

So instead of defining the type of the device, we could provide the 
possibility to choose which bus to connect it to, in this way we 
continue to require that both are supported.

As Michael suggested, instead of specify it at the creation time as was 
in my original idea, we can provide an API to attach/detach a device to 
a specific vDPA bus.

Of course, providing a default behaviour like now, which connects to the 
first registered.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
