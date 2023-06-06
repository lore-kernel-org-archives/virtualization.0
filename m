Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9702C77B7A
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 10:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3756C40933;
	Tue,  6 Jun 2023 10:09:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3756C40933
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CMzI+gQA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3v1eHm94Pakf; Tue,  6 Jun 2023 10:09:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F339B4092C;
	Tue,  6 Jun 2023 10:09:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F339B4092C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3079C0037;
	Tue,  6 Jun 2023 10:09:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D2BBC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 10:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A8D2819B8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 10:09:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A8D2819B8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CMzI+gQA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jNi1ti26QU3A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 10:09:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0091181852
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0091181852
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686046158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iCQQ1LZ3gBqjk1nNTdvMqD1fo9eGMxkBs1BPtbczoAU=;
 b=CMzI+gQAyItCHDIMjj9NsirIK23I57OXEt5I0alg3zLUGAoLX9v78ZP6SkzKq5m6gqW32P
 nVZLIBeyJOF2mpfuKxgN2PFQQnDYixMr6H2Utzr8ER5wglpS9UlDHiYqkdmXQN6tx3qnVc
 bu/I08NvQlmXr1uOq0uvChWDQEmfpuE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-ulLX3WBCPqCzwD3kfsUkMg-1; Tue, 06 Jun 2023 06:09:17 -0400
X-MC-Unique: ulLX3WBCPqCzwD3kfsUkMg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f73283f6c7so12703055e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jun 2023 03:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686046156; x=1688638156;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCQQ1LZ3gBqjk1nNTdvMqD1fo9eGMxkBs1BPtbczoAU=;
 b=VU+W5La2LBZNtvdvpmAgoWwCbO8RjgGRpKIUOkuRvYl0GLUi2VKv2nAIV+9RG0puG2
 N9ER6ooRWtd/kDsneQT9C/kuq6sZlpuTwZof6XubzKS7cFMjQ6A8/JZaBln6FgwKTbuN
 1NP2dj+IcxJfztDt8iByPFWR0bUCEFGui4YHGFKzYnhJadCvtCI0v8IDzdKfGhCY//J/
 gExyXJFmwFxDOV5wAE0zOccsF4HD4NpTQ79uCvQXcuZfgsfRKdH1WclnLTjowmN/Hjh+
 5K2bysg8x8Jd9K0y4PG+MZRFHp/v7C4W0EBIFdXDo/TbQy1vpTABD/SewZyYldBR9Fq/
 SmlQ==
X-Gm-Message-State: AC+VfDw5vjqKtyMEWyjhYS33UwwGOrmn2978EvyPm4hCHLw73W2V4Nnt
 UgheunI3nKncc1GyGDwIkQf6GJV6yqOtHco7gI5Fj8O/DyuLMEFYCDwyGDjmITwHmCQlOmJs6xS
 QcWelfoRrMuxXOe8UYBtJOqrkBpRYibDK3ed4DaSkvA==
X-Received: by 2002:a05:600c:3797:b0:3f7:9b05:928e with SMTP id
 o23-20020a05600c379700b003f79b05928emr1391402wmr.0.1686046156247; 
 Tue, 06 Jun 2023 03:09:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52QSnNnJkRGc6Nqh1PipbVz5Hr4kx9RIOGdzDonWM60PuLaRTr//cxK7weQ3RmRxLry7a9hQ==
X-Received: by 2002:a05:600c:3797:b0:3f7:9b05:928e with SMTP id
 o23-20020a05600c379700b003f79b05928emr1391380wmr.0.1686046155959; 
 Tue, 06 Jun 2023 03:09:15 -0700 (PDT)
Received: from sgarzare-redhat (93-44-29-47.ip95.fastwebnet.it. [93.44.29.47])
 by smtp.gmail.com with ESMTPSA id
 f4-20020adff8c4000000b00307a83ea722sm12052625wrq.58.2023.06.06.03.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 03:09:15 -0700 (PDT)
Date: Tue, 6 Jun 2023 12:09:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <kpcujul6foyvw66qhy3wck5bzgedka2gzzixupnaog7byr4h45@6ddbvcy32db4>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <20230605173958-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230605173958-mutt-send-email-mst@kernel.org>
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

On Mon, Jun 05, 2023 at 05:44:50PM -0400, Michael S. Tsirkin wrote:
>On Mon, Jun 05, 2023 at 04:56:37PM +0200, Stefano Garzarella wrote:
>> On Mon, Jun 05, 2023 at 09:54:57AM -0400, Michael S. Tsirkin wrote:
>> > On Mon, Jun 05, 2023 at 03:30:35PM +0200, Stefano Garzarella wrote:
>> > > On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
>> > > > On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
>> > > > > On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
>> > > > > > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
>> > > > > > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
>> > > > > > > don't support packed virtqueue well yet, so let's filter the
>> > > > > > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
>> > > > > > >
>> > > > > > > This way, even if the device supports it, we don't risk it being
>> > > > > > > negotiated, then the VMM is unable to set the vring state properly.
>> > > > > > >
>> > > > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> > > > > > > Cc: stable@vger.kernel.org
>> > > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > > > > > ---
>> > > > > > >
>> > > > > > > Notes:
>> > > > > > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>> > > > > > >     better PACKED support" series [1] and backported in stable branches.
>> > > > > > >
>> > > > > > >     We can revert it when we are sure that everything is working with
>> > > > > > >     packed virtqueues.
>> > > > > > >
>> > > > > > >     Thanks,
>> > > > > > >     Stefano
>> > > > > > >
>> > > > > > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
>> > > > > >
>> > > > > > I'm a bit lost here. So why am I merging "better PACKED support" then?
>> > > > >
>> > > > > To really support packed virtqueue with vhost-vdpa, at that point we would
>> > > > > also have to revert this patch.
>> > > > >
>> > > > > I wasn't sure if you wanted to queue the series for this merge window.
>> > > > > In that case do you think it is better to send this patch only for stable
>> > > > > branches?
>> > > > > > Does this patch make them a NOP?
>> > > > >
>> > > > > Yep, after applying the "better PACKED support" series and being
>> > > > > sure that
>> > > > > the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
>> > > > > patch.
>> > > > >
>> > > > > Let me know if you prefer a different approach.
>> > > > >
>> > > > > I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
>> > > > > interprets them the right way, when it does not.
>> > > > >
>> > > > > Thanks,
>> > > > > Stefano
>> > > > >
>> > > >
>> > > > If this fixes a bug can you add Fixes tags to each of them? Then it's ok
>> > > > to merge in this window. Probably easier than the elaborate
>> > > > mask/unmask dance.
>> > >
>> > > CCing Shannon (the original author of the "better PACKED support"
>> > > series).
>> > >
>> > > IIUC Shannon is going to send a v3 of that series to fix the
>> > > documentation, so Shannon can you also add the Fixes tags?
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > Well this is in my tree already. Just reply with
>> > Fixes: <>
>> > to each and I will add these tags.
>>
>> I tried, but it is not easy since we added the support for packed virtqueue
>> in vdpa and vhost incrementally.
>>
>> Initially I was thinking of adding the same tag used here:
>>
>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>>
>> Then I discovered that vq_state wasn't there, so I was thinking of
>>
>> Fixes: 530a5678bc00 ("vdpa: support packed virtqueue for set/get_vq_state()")
>>
>> So we would have to backport quite a few patches into the stable branches.
>> I don't know if it's worth it...
>>
>> I still think it is better to disable packed in the stable branches,
>> otherwise I have to make a list of all the patches we need.
>>
>> Any other ideas?
>>
>> Thanks,
>> Stefano
>
>OK so. You want me to apply this one now, and fixes in the next
>kernel?

Yep, it seems to me the least risky approach.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
