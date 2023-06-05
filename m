Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D11C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 14:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 070A260899;
	Mon,  5 Jun 2023 14:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 070A260899
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HmLcKQwl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vnz7cMrZ9cZJ; Mon,  5 Jun 2023 14:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5712A60792;
	Mon,  5 Jun 2023 14:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5712A60792
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AE6AC0037;
	Mon,  5 Jun 2023 14:56:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B0CFC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 468124036E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:56:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 468124036E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HmLcKQwl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWGe2bJMHITR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:56:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10677401ED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10677401ED
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685977002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iM7FqUtZoblM2J1vfVR4GtdyLSINqEtLQvkMkp8oaNA=;
 b=HmLcKQwlB/y3tWxgbZXxkssRTQOgsBaf5TpixlHGtpWkw9Yg2mqA1r1AHxNyzIeBMzFfAf
 Aox+HV59/Ow7QDFfBFSqY7XjExdMoaZGMiQWzZMGgT4q7GbzKXLgN3QpkEBxLoab4k9Fye
 KZCfBRIMaVIC7xUNVIzHJCsMxrDUDAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-NJmorwDkOsqDZp5tPfjfQA-1; Mon, 05 Jun 2023 10:56:41 -0400
X-MC-Unique: NJmorwDkOsqDZp5tPfjfQA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f70f9995aeso24187455e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 07:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685977000; x=1688569000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM7FqUtZoblM2J1vfVR4GtdyLSINqEtLQvkMkp8oaNA=;
 b=DsIXK4qpi2fJKG9z0u+v5fvZMvYwjWdWkPUSl/4FQzgNEsG2akVqeKHeI1Q+7od5yS
 XVx2iY8IAT1wAT3PM3CVjpIaTcymrSNzQSJkDQKuMmsxmhK1OYFISrsF5cDxCHPMCdv4
 Yy14elHT72z0hUC4Hea1gwt4SaukjkgEro+BQafmF6gAafNRlw8xmLC+OKiKgx+en91l
 Mny31LUnwViCsyeINJ0YnOVjOjPIhpWUxc3uQySjuqk5M7YR03zoaBhIO7WaE6EkEtAf
 kEQjBREp7O6xEpi6hTpCc/bpPci/ZqB+MlfLZOcqihV2E/E6vdbRT8sVhYaedrdJjZsV
 GCnw==
X-Gm-Message-State: AC+VfDxo2G6xILcn0MJRyyPKgeV1Qm4iT01AJvDMzs1SVHAyzSdn37OW
 2CR1y5Im0IjkKpBICrgrAKS5cB6guAnuK3tUWlJDhYfqIAzv++6cMRBi5KSBXf+WoUFF4I66MeS
 pxov4SS03+T1yg2sqiuL8oUmMPzFfNkXxbKgBooBa8Q==
X-Received: by 2002:a7b:c3d0:0:b0:3f6:1a3:4cee with SMTP id
 t16-20020a7bc3d0000000b003f601a34ceemr7047075wmj.14.1685977000614; 
 Mon, 05 Jun 2023 07:56:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7l4TdvDr6o9XW/L55yGS61L3quL2CQtXB9IsLkpcz4S8Wf/T1gUnxE76eS3+xlCYUvLcEtYw==
X-Received: by 2002:a7b:c3d0:0:b0:3f6:1a3:4cee with SMTP id
 t16-20020a7bc3d0000000b003f601a34ceemr7047062wmj.14.1685977000262; 
 Mon, 05 Jun 2023 07:56:40 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.106])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c4fc700b003f71ad792f2sm20247339wmq.1.2023.06.05.07.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 07:56:39 -0700 (PDT)
Date: Mon, 5 Jun 2023 16:56:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230605095404-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
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

On Mon, Jun 05, 2023 at 09:54:57AM -0400, Michael S. Tsirkin wrote:
>On Mon, Jun 05, 2023 at 03:30:35PM +0200, Stefano Garzarella wrote:
>> On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
>> > On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
>> > > On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
>> > > > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
>> > > > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
>> > > > > don't support packed virtqueue well yet, so let's filter the
>> > > > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
>> > > > >
>> > > > > This way, even if the device supports it, we don't risk it being
>> > > > > negotiated, then the VMM is unable to set the vring state properly.
>> > > > >
>> > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> > > > > Cc: stable@vger.kernel.org
>> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > > > ---
>> > > > >
>> > > > > Notes:
>> > > > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>> > > > >     better PACKED support" series [1] and backported in stable branches.
>> > > > >
>> > > > >     We can revert it when we are sure that everything is working with
>> > > > >     packed virtqueues.
>> > > > >
>> > > > >     Thanks,
>> > > > >     Stefano
>> > > > >
>> > > > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
>> > > >
>> > > > I'm a bit lost here. So why am I merging "better PACKED support" then?
>> > >
>> > > To really support packed virtqueue with vhost-vdpa, at that point we would
>> > > also have to revert this patch.
>> > >
>> > > I wasn't sure if you wanted to queue the series for this merge window.
>> > > In that case do you think it is better to send this patch only for stable
>> > > branches?
>> > > > Does this patch make them a NOP?
>> > >
>> > > Yep, after applying the "better PACKED support" series and being
>> > > sure that
>> > > the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
>> > > patch.
>> > >
>> > > Let me know if you prefer a different approach.
>> > >
>> > > I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
>> > > interprets them the right way, when it does not.
>> > >
>> > > Thanks,
>> > > Stefano
>> > >
>> >
>> > If this fixes a bug can you add Fixes tags to each of them? Then it's ok
>> > to merge in this window. Probably easier than the elaborate
>> > mask/unmask dance.
>>
>> CCing Shannon (the original author of the "better PACKED support"
>> series).
>>
>> IIUC Shannon is going to send a v3 of that series to fix the
>> documentation, so Shannon can you also add the Fixes tags?
>>
>> Thanks,
>> Stefano
>
>Well this is in my tree already. Just reply with
>Fixes: <>
>to each and I will add these tags.

I tried, but it is not easy since we added the support for packed 
virtqueue in vdpa and vhost incrementally.

Initially I was thinking of adding the same tag used here:

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")

Then I discovered that vq_state wasn't there, so I was thinking of

Fixes: 530a5678bc00 ("vdpa: support packed virtqueue for set/get_vq_state()")

So we would have to backport quite a few patches into the stable branches.
I don't know if it's worth it...

I still think it is better to disable packed in the stable branches,
otherwise I have to make a list of all the patches we need.

Any other ideas?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
