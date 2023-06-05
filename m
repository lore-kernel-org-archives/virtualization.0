Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72518C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 13:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFF0F41675;
	Mon,  5 Jun 2023 13:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFF0F41675
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gmS4diiY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ba7VOUOFQNov; Mon,  5 Jun 2023 13:30:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 23B1B4162C;
	Mon,  5 Jun 2023 13:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23B1B4162C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2D4DC007A;
	Mon,  5 Jun 2023 13:30:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D12C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3ED060D8E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:30:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3ED060D8E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gmS4diiY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 526TiH9Lfo_a
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:30:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D83F6607FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D83F6607FF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685971844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09h7AR4TuCkDh4zJT0E+2xZhXl8jzj6eU3ZdjKoNbek=;
 b=gmS4diiYn7Pm676p7UuGn+xWBH7IrpP9pEBE/qaXOsQf+V5KZA89Y379YFE0t1vUZt9YMS
 naiPfy5exKaWj+EESF6tEaLXQqpvc7vDj1r/wVjfmgKG5qg3WPcRoncJ59VD0lBNckY2eS
 cJpSC7g31RzM/Gi0fr2gnxrBtFfdt1w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-p1m8_R5mPdqT4qPglF-fxA-1; Mon, 05 Jun 2023 09:30:43 -0400
X-MC-Unique: p1m8_R5mPdqT4qPglF-fxA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6260b40eac6so34484106d6.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 06:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685971843; x=1688563843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09h7AR4TuCkDh4zJT0E+2xZhXl8jzj6eU3ZdjKoNbek=;
 b=LtR0BqDoAGPXAsbWVV4ygoYhLnl8OQbdu1TGcPfQjr6OIjJpwsTJGzUpNYTqFh9EDl
 d3FOt6n/VKREHIiiTsRjSm9LyvpfqTFtAnSOUJ8bYbF0MhnoDfsfpRnAnraNEpM4UJZ7
 aqbdrKfBLFjwJWkFnGzMh9m2toreEWueqDPXdavyXwQAiQV+I+eRrBnFYf4KEjBjf+D8
 UJcPN8rLvQfRRxPELo13GSRV66W/AC2Vx3Znkx3uZlMBpYLvycwxLB58HySL0oxfqQqS
 L0V2+obKCD40LyV91qNU9IyBgh9SrK9MPnM29M8Tg2ZBXc8tprHtcIJ0A/vgdiJHn1RK
 f0Tg==
X-Gm-Message-State: AC+VfDxsJiIdSYThpLyYwnSOWKdzgT2kw67Qb3O+51LpJSV8W5mPcoU1
 2YvQAIGqADA9pvLKeNPofKOMrqqCJ4EAfL2OibSm8mrpovGhwR5jYWW6ZJv1LbV5lVxV0W+zyAh
 i5+osj7nV3OEAcG2EHx0PbHcSp/dEbPVGcKyVuCoTNg==
X-Received: by 2002:a05:6214:240b:b0:623:9a08:4edd with SMTP id
 fv11-20020a056214240b00b006239a084eddmr8345306qvb.25.1685971843171; 
 Mon, 05 Jun 2023 06:30:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59eKAQLHTpxMz4/t5AgUGvFz9F83N7jM9XvbTEJ6IWLoINLpCKUzwbDeHXyzeu5z0HI4vP9w==
X-Received: by 2002:a05:6214:240b:b0:623:9a08:4edd with SMTP id
 fv11-20020a056214240b00b006239a084eddmr8345276qvb.25.1685971842889; 
 Mon, 05 Jun 2023 06:30:42 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.106])
 by smtp.gmail.com with ESMTPSA id
 ph12-20020a0562144a4c00b0061c83f00767sm4623347qvb.3.2023.06.05.06.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 06:30:42 -0700 (PDT)
Date: Mon, 5 Jun 2023 15:30:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230605085840-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
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

On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
>On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
>> On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
>> > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
>> > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
>> > > don't support packed virtqueue well yet, so let's filter the
>> > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
>> > >
>> > > This way, even if the device supports it, we don't risk it being
>> > > negotiated, then the VMM is unable to set the vring state properly.
>> > >
>> > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >
>> > > Notes:
>> > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>> > >     better PACKED support" series [1] and backported in stable branches.
>> > >
>> > >     We can revert it when we are sure that everything is working with
>> > >     packed virtqueues.
>> > >
>> > >     Thanks,
>> > >     Stefano
>> > >
>> > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
>> >
>> > I'm a bit lost here. So why am I merging "better PACKED support" then?
>>
>> To really support packed virtqueue with vhost-vdpa, at that point we would
>> also have to revert this patch.
>>
>> I wasn't sure if you wanted to queue the series for this merge window.
>> In that case do you think it is better to send this patch only for stable
>> branches?
>> > Does this patch make them a NOP?
>>
>> Yep, after applying the "better PACKED support" series and being sure 
>> that
>> the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
>> patch.
>>
>> Let me know if you prefer a different approach.
>>
>> I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
>> interprets them the right way, when it does not.
>>
>> Thanks,
>> Stefano
>>
>
>If this fixes a bug can you add Fixes tags to each of them? Then it's ok
>to merge in this window. Probably easier than the elaborate
>mask/unmask dance.

CCing Shannon (the original author of the "better PACKED support"
series).

IIUC Shannon is going to send a v3 of that series to fix the
documentation, so Shannon can you also add the Fixes tags?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
