Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644F2C25B06
	for <virtualization@archiver.kernel.org>; Sat,  6 Aug 2022 08:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCB0F833A3;
	Sat,  6 Aug 2022 08:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCB0F833A3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BBa5UUBo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ac3zd9vcx5eM; Sat,  6 Aug 2022 08:17:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E85B82496;
	Sat,  6 Aug 2022 08:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E85B82496
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C3C2C0033;
	Sat,  6 Aug 2022 08:17:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 770CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 08:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EBD840239
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 08:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EBD840239
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BBa5UUBo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjyHtbB9aMPx
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 08:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CFB840192
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CFB840192
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 08:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659773863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUhhyhwWziHPf4owDIioKjw2klBpNCGgWh43vGMAw90=;
 b=BBa5UUBoTzCGZvCIjvPW7kP2dE/dAg/tM17ZabRf00hDc9u0JNb9NsVL+8MDZI2ujLTsrS
 34bmNz+YklS6CyuKoD9AY/3Z+p1XugkHnNxRvAMJLCyh6U5eSiK51b0RfEoOhTS2QuUV3a
 rLxBqKDyZtNp0+9TeeyvRGKju7uOcGA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-5IixzkNnNSONLS0XYRa7yQ-1; Sat, 06 Aug 2022 04:17:42 -0400
X-MC-Unique: 5IixzkNnNSONLS0XYRa7yQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 bl27-20020a05620a1a9b00b0069994eeb30cso3770359qkb.11
 for <virtualization@lists.linux-foundation.org>;
 Sat, 06 Aug 2022 01:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=QUhhyhwWziHPf4owDIioKjw2klBpNCGgWh43vGMAw90=;
 b=OYQ+VTEv8lAZKwmjRGFXBCDLiwURtQok4hdCJnl72JqvA0BQ3/x4owRsV8c9OFcisA
 3ubOWBZjcAWXm8JRQ6lrqItgKwQq2l4eQfYPggFDkMZ3C3w+PU8l6BAEiJ40lKBD1YIn
 DdRuiB4+9PtLk7KkMNuoslVqwBHehQMicJyVzPIo4VSaxeYghgYzfknjbQKTkCzaqrKY
 rnWdR2+UCRzgbTm+w7e67QKNLON5syqHJkP1/C/8tnxXUMTW0okd5orod2zJkp9Vptcv
 SuJsG0oJhTbD1io44ZRW826WWvFNFPN9rlRDTwpM+vpBfeEOu3Rp+g0Ec2evW9eCnKq2
 36VA==
X-Gm-Message-State: ACgBeo2GAehteRO4RxBCcKAPC/FRdk+PfhcOsaFrbwWoR1Wu66b+7yG/
 p65mNJyhI2/XmgbjWZmqYYco1R5II7SkAkt6ax9M0Kk6c7JyvKCxAqtOA8Rk2SqzAufHIYZpvIE
 VM4uBK3zbmcif/gjIS4ySWdANFtgvDg0nklKAPS04rA==
X-Received: by 2002:a05:622a:d5:b0:31e:eb65:e832 with SMTP id
 p21-20020a05622a00d500b0031eeb65e832mr9059524qtw.92.1659773862201; 
 Sat, 06 Aug 2022 01:17:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7tYxINyBqtVppCff7bDw/5gEb1ZvpfEu6NMMMRX3xBGvdOSDUK2l2oCDIf8Yd83eFnoOADtA==
X-Received: by 2002:a05:622a:d5:b0:31e:eb65:e832 with SMTP id
 p21-20020a05622a00d500b0031eeb65e832mr9059511qtw.92.1659773861963; 
 Sat, 06 Aug 2022 01:17:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 u4-20020a05620a430400b006b5988b2ca8sm4658290qko.40.2022.08.06.01.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Aug 2022 01:17:40 -0700 (PDT)
Date: Sat, 6 Aug 2022 10:17:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, mst@redhat.com,
 jasowang@redhat.com
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220806081732.a553jsoe2sfwghjg@sgarzare-redhat>
References: <20220805181105.GA29848@willie-the-truck>
 <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 maz@kernel.org, keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, Will Deacon <will@kernel.org>
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

Hi Linus,

On Fri, Aug 05, 2022 at 03:57:08PM -0700, Linus Torvalds wrote:
>On Fri, Aug 5, 2022 at 11:11 AM Will Deacon <will@kernel.org> wrote:
>>
>> [tl;dr a change from ~18 months ago breaks Android userspace and I don't
>>  know what to do about it]
>
>Augh.
>
>I had hoped that android being "closer" to upstream would have meant
>that somebody actually tests android with upstream kernels. People
>occasionally talk about it, but apparently it's not actually done.
>
>Or maybe it's done onl;y with a very limited android user space.
>
>The whole "we notice that something that happened 18 months ago broke
>our environment" is kind of broken.
>
>> After some digging, we narrowed this change in behaviour down to
>> e13a6915a03f ("vhost/vsock: add IOTLB API support") and further digging
>> reveals that the infamous VIRTIO_F_ACCESS_PLATFORM feature flag is to
>> blame. Indeed, our tests once again pass if we revert that patch (there's
>> a trivial conflict with the later addition of VIRTIO_VSOCK_F_SEQPACKET
>> but otherwise it reverts cleanly).
>
>I have to say, this smells for *so* many reasons.
>
>Why is "IOMMU support" called "VIRTIO_F_ACCESS_PLATFORM"?
>
>That seems insane, but seems fundamental in that commit e13a6915a03f
>("vhost/vsock: add IOTLB API support")
>
>This code
>
>        if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>                if (vhost_init_device_iotlb(&vsock->dev, true))
>                        goto err;
>        }
>
>just makes me go "What?"  It makes no sense. Why isn't that feature
>called something-something-IOTLB?

I honestly don't know the reason for the name but 
VIRTIO_F_ACCESS_PLATFORM comes from the virtio specification:
   https://docs.oasis-open.org/virtio/virtio/v1.2/cs01/virtio-v1.2-cs01.html#x1-6600006

   VIRTIO_F_ACCESS_PLATFORM(33)
      This feature indicates that the device can be used on a platform
      where device access to data in memory is limited and/or translated.
      E.g. this is the case if the device can be located behind an IOMMU
      that translates bus addresses from the device into physical
      addresses in memory, if the device can be limited to only access
      certain memory addresses or if special commands such as a cache
      flush can be needed to synchronise data in memory with the device.
      Whether accesses are actually limited or translated is described by
      platform-specific means. If this feature bit is set to 0, then the
      device has same access to memory addresses supplied to it as the
      driver has. In particular, the device will always use physical
      addresses matching addresses used by the driver (typically meaning
      physical addresses used by the CPU) and not translated further, and
      can access any address supplied to it by the driver. When clear,
      this overrides any platform-specific description of whether device
      access is limited or translated in any way, e.g. whether an IOMMU
      may be present.

>
>Can we please just split that flag into two, and have that odd
>"platform access" be one bit, and the "enable iommu" be an entirely
>different bit?

IIUC the problem here is that the VMM does the translation and then for 
the device there is actually no need to translate, so this feature 
should not be negotiated by crosvm and vhost-vsock, but just between 
guest's driver and crosvm.

Perhaps the confusion is that we use VIRTIO_F_ACCESS_PLATFORM both 
between guest and VMM and between VMM and vhost device.

In fact, prior to commit e13a6915a03f ("vhost/vsock: add IOTLB API 
support"), vhost-vsock did not work when a VMM (e.g., QEMU) tried to 
negotiate translation with the device: 
https://bugzilla.redhat.com/show_bug.cgi?id=1894101

The simplest solution is that crosvm doesn't negotiate 
VIRTIO_F_ACCESS_PLATFORM with the vhost-vsock device if it doesn't want 
to use translation and send messages to set it.

In fact before commit e13a6915a03f ("vhost/vsock: add IOTLB API 
support") this feature was not exposed by the vhost-vsock device, so it 
was never negotiated. Now crosvm is enabling a new feature (not masking 
guest-negotiated features) so I don't think it's a break in user space, 
if the user space enable it.

I tried to explain what I understood when I made the change, Michael and 
Jason surely can add more information.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
