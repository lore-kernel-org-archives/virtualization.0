Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931F5C19F2C
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 07:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3823E40616;
	Thu,  4 Aug 2022 07:27:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3823E40616
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBKX+XNc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y7uD6xikndLw; Thu,  4 Aug 2022 07:27:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B9DE540503;
	Thu,  4 Aug 2022 07:27:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9DE540503
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 799C3C0032;
	Thu,  4 Aug 2022 07:27:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A481EC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E9FA60C2A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E9FA60C2A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBKX+XNc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2pDRD3VQOV0X
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:27:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7EC060C26
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7EC060C26
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659598035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CgcnTIvXlfoYGke6w6OKBJ8Vj03zJWKLpCqeNsfcThg=;
 b=HBKX+XNchc9qiJQ9zXpM/1BU3NAxJ04JEEcsPVzTrN2Oq+cPjlJitIuKcKpxLxNy9b8iy8
 NK0bjIL/8OOBK0LqEejHcglDCMfrFtrwdy0SfIFfisApiAdhI5h8FmUJyv0HY4eI8Su6bc
 jYFoyPch/qRtbw34Zy/ziW7cgzgy2Vg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-qp2tGtErOb6QtrhHCOJRHQ-1; Thu, 04 Aug 2022 03:27:14 -0400
X-MC-Unique: qp2tGtErOb6QtrhHCOJRHQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 p8-20020a056512234800b0048b12cb7738so1805233lfu.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Aug 2022 00:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CgcnTIvXlfoYGke6w6OKBJ8Vj03zJWKLpCqeNsfcThg=;
 b=6XP3jbm39YxsohYN+XP8BJmbqBd6jmtyHycrb7NpwNESRikBaj0t4/rSAI1ZTf3uOB
 aASOAMJ9Xnz+ijcqfEQVwEv/eLegs6we0wYwOFvO5/vcQH2tDEbQnLP9ANXFXqN12Km5
 MmSnyLKH5a7tTEescemxeR1W5zTc7D6PUaaiU6WUgAOl7SOGWQgjBc/59aH3CZ1pa/eF
 mwhrzcZemRI//UrEYOuQiG5I1Lb689rkFo4YGA48RiE4kTgjzXAzSj0ncMNWn0vd5m3s
 NaPvJGUW+/Z656XU9foLjQqZ5NXCk3YozEcXpDh+iuK42xPG/c/wXHesmhzOJ0fdIZTt
 dPqw==
X-Gm-Message-State: ACgBeo21qHybpospet+vLYzrVcqM0PoNRy7qT/1WoRHHkWdcE4+TDO5z
 5HFQUQZPv6Qhw/UmD1eZ4goX+c8rLjZWU8DTDBiL641K0qW6Tr46Q0gSojwZ+XVzcb6UxjtjsyH
 +4V833sa5CQInGkgw2RMGEKmlFwfRB4guDqU6Wqk6R1B9yyVH6nL0RrvYgQ==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr256088lfa.124.1659598032951; 
 Thu, 04 Aug 2022 00:27:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4HLzK59SDBRkeG4Csvj7YFB4NwLjgY/1RiMDKZGdRNtz01qiJhziKtlgKfnlhtdVOdUaClw0/wqjFZcEHwxiQ=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr256082lfa.124.1659598032787; Thu, 04
 Aug 2022 00:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <780fba4c-458f-0abc-ae48-4cf806401228@virtuozzo.com>
 <CACGkMEtLutWVnG_SHbP9+K851k4ZN3hdtZGxaYpbAz3wzEvSGA@mail.gmail.com>
 <20220804063911.c6w7f757yqnfep4u@sgarzare-redhat>
In-Reply-To: <20220804063911.c6w7f757yqnfep4u@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 15:27:01 +0800
Message-ID: <CACGkMEvBXF2TnkhxVyYjPNLOvnbt-Jh=NehzN0xsqNwzHCTHgQ@mail.gmail.com>
Subject: Re: memory locking in vhost-vdpa
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
 virtualization <virtualization@lists.linux-foundation.org>, den@virtuozzo.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Aug 4, 2022 at 2:39 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Aug 04, 2022 at 09:52:47AM +0800, Jason Wang wrote:
> >On Thu, Aug 4, 2022 at 1:46 AM Andrey Zhadchenko
> ><andrey.zhadchenko@virtuozzo.com> wrote:
> >>
> >> Hi!
> >>
> >> Recently I sent vhost-blk patchset and Stefano suggested to instead join
> >> efforts on developing vdpa-blk.
> >> I played with it a bit and looks like vdpa itself pins the whole guest
> >> memory. Is there a way to control it or reduce pinned amount to the
> >> device pages?
> >> Looks like even vdpa-sim requires all memory to be pinned [1]. Pinning
> >> this much will surely impact guest density.
> >
> >It depends on the parent.
> >
> >When allocating the vDPA device, the parent can clams it supports
> >virtual address then pinning is avoided:
> >
> >/**
> > * __vdpa_alloc_device - allocate and initilaize a vDPA device
> > * This allows driver to some prepartion after device is
> > * initialized but before registered.
> >...
> > * @use_va: indicate whether virtual address must be used by this device
> > */
> >
> >The only user so far is VDUSE which is a software parent in the
> >userspace with a customized swiotlb for kernel drivers.
> >
> >Simulator came before this feature so we stick to the pinning method,
>
> I based vdpa-blk PoC on the simulator and didn't realize this, maybe I
> should have used this.
>
> >technically we can switch to use the va mode, but it might have some
> >performance impact (mostly the copy_from|to_user()).
>
> Would the cost be comparable to implementing a vhost-blk device? (IIRC
> vq in vhost uses copy_from/to_user, right?)

It would not be that simple. We need to differentiate kernel va from
userspace va at least, since the buffer could belong to kernel (via
virtio-vdpa).

Thanks

>
> Thanks,
> Stefano
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
