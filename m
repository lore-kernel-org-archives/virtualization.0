Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7478C6FA82
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 17:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5991783F47;
	Thu, 22 Sep 2022 17:00:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5991783F47
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L6wuZ5nb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DlupFPBUGuA8; Thu, 22 Sep 2022 17:00:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E54C883EFA;
	Thu, 22 Sep 2022 17:00:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E54C883EFA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB47FC0033;
	Thu, 22 Sep 2022 17:00:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2428C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC0CA61118
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:00:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC0CA61118
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L6wuZ5nb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 706hfw3l-b1s
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:00:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09F34610EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09F34610EA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663866026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lpqtzBDyUF+YoNh/as65yVQC8Z6APw6kJNzNcMP1bJg=;
 b=L6wuZ5nbtO7M7vzkRO8lzg9ZtuV3b31XlSilfPTfMHysqcpn8jZSR/Re8mzt3HSEkgg6E6
 L6TS1EEDmBMYHv6XHSzfvyvI+VAgfi878MbXXScm2P/8ReGLqxm95zOJjw5gIs8em9RQMg
 M22d5bzLuPbhcU8+hzfLGDC8peiXH5M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-D-fzWBviPPCANP0drGMx1A-1; Thu, 22 Sep 2022 13:00:24 -0400
X-MC-Unique: D-fzWBviPPCANP0drGMx1A-1
Received: by mail-wm1-f69.google.com with SMTP id
 7-20020a05600c020700b003b4ce6e6b12so989652wmi.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=lpqtzBDyUF+YoNh/as65yVQC8Z6APw6kJNzNcMP1bJg=;
 b=1fa23wXdcxyW5n5N4mtx2FEw1bVvst8ArGZ6wZU63Bt4kOraAVsHwrbpBWZhcTN4Xg
 Y6wdQVIZUEGa3bGZ8pd9P+Jg9/h2WUu3n7ag3dAIbH1ZNJPb+2899pwHaJ4WGG7fvVfQ
 iofmsx9JY0E36PzQGKB4uf3Zqp08981EDwinq3WJfvIM+LW7dR68DlKek3rE5XDEXla8
 phIK90HXTYS/X7It36O7Vxloc7YTt3iFOt9V1ivoVYteGZBhnYRXc1/F2ANuz46BS6ci
 CktUAiBqc6D/8dWQEE0NOENu7zg+vvnYe8yfPVUENBCZ7NwAPZdL1L5WvVJXJm3nltdm
 58EA==
X-Gm-Message-State: ACrzQf0syLHay2XCLFSRX1OpcwCLeNMEAqCGb8mOJciX+9uEJvi83yjI
 Qqq34NUz4znjAIraO9mncw5u05R7EIRJyWeB90sbs4ygQwPgGRvBUJj2xdWv2frkfRwxsRkRqtK
 PM6X/Q3oj7qtWj9AnNjnguiM6yOxtEdbBTfdZxYeb0Q==
X-Received: by 2002:a05:600c:4352:b0:3b4:84c0:2006 with SMTP id
 r18-20020a05600c435200b003b484c02006mr3138038wme.205.1663866023559; 
 Thu, 22 Sep 2022 10:00:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7TAL8Zf9tRSjFHYNy9qzrsmDdXGu0hYtvhYtefN+dR9vQzHAoHLyVH/HDZQw/WTeBuq3z/eQ==
X-Received: by 2002:a05:600c:4352:b0:3b4:84c0:2006 with SMTP id
 r18-20020a05600c435200b003b484c02006mr3138026wme.205.1663866023327; 
 Thu, 22 Sep 2022 10:00:23 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 r1-20020a05600c434100b003b3401f1e24sm31108wme.28.2022.09.22.10.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 10:00:22 -0700 (PDT)
Date: Thu, 22 Sep 2022 13:00:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
Message-ID: <20220922125911-mutt-send-email-mst@kernel.org>
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <20220918091848-mutt-send-email-mst@kernel.org>
 <CAJs=3_B4sTo-X9ZkqAZjzLi0EGRNW_jwUtgUBj17p907qVkNoQ@mail.gmail.com>
 <20220918110951-mutt-send-email-mst@kernel.org>
 <CAJs=3_AdHBZZKXypXh=wZDB58jADyoec6RnH42b_-UphPqFGSA@mail.gmail.com>
 <YyoCHV3s0kd0e3aG@fedora>
MIME-Version: 1.0
In-Reply-To: <YyoCHV3s0kd0e3aG@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 virtualization@lists.linux-foundation.org
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

On Tue, Sep 20, 2022 at 02:10:37PM -0400, Stefan Hajnoczi wrote:
> On Sun, Sep 18, 2022 at 07:07:34PM +0300, Alvaro Karsz wrote:
> > > sounds good. Add a code comment?
> > 
> > I will.
> > 
> > >  yes but I now see two places that seem to include this logic.
> > 
> > 
> > Yes, this is because the same logic is applied on 2 different pairs.
> > 
> > * secure_erase_sector_alignment and discard_sector_alignment are used
> > to calculate  q->limits.discard_granularity.
> > * max_discard_seg and max_secure_erase_seg are used to calculate
> > max_discard_segments.
> > 
> > > I am not 100% sure. Two options:
> > > 1- Add a validate callback and clear VIRTIO_BLK_F_SECURE_ERASE.
> > > 2- Alternatively, fail probe.
> > 
> > 
> > Good ideas.
> > 2- Do you think that something like that should be mentioned in the
> > spec? or should be implementation specific?
> > 
> > How about setting the value to 1? (which is the minimum usable value)
> > 
> > > which is preferable depends on how bad is it if host sets
> > > VIRTIO_BLK_F_SECURE_ERASE but guest does not use it.
> > 
> > 
> > I'm not sure if it is that bad.
> > If the value is 0, sg_elems is used.
> > sg_elems is either 1 (if VIRTIO_BLK_F_SEG_MAX is not negotiated), or
> > seg_max (virtio config).
> > 
> > """
> > err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
> >                                           struct virtio_blk_config, seg_max,
> >                                           &sg_elems);
> > /* We need at least one SG element, whatever they say. */
> > if (err || !sg_elems)
> >          sg_elems = 1;
> > """
> > 
> > So the only "danger" that I can think of is if a device negotiates
> > VIRTIO_BLK_F_SEG_MAX and  VIRTIO_BLK_F_SECURE_ERASE, sets
> > max_secure_erase_seg to 0 (I'm not sure what is the purpose, since
> > this is meaningless), and can't handle secure erase commands with
> > seg_max segments.
> 
> Given that SECURE ERASE is new and the VIRTIO spec does not define
> special behavior for 0, I think the virtio_blk driver should be strict.
> 
> There's no need to work around existing broken devices. I would fail
> probing the device. This will encourage device implementors to provide a
> usable value instead of 0.
> 
> Stefan



What I worry about is that down the road we might want to add
special meaning to currently unused values.
If doing that just clears VIRTIO_BLK_F_SECURE_ERASE then
we have forward compatibility. If it fails probe then we
won't be able to do use these values.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
