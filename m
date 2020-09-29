Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51A0C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:01:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221EA207C4
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArrwmDOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221EA207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CFBD985701;
	Tue, 29 Sep 2020 07:01:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aLe2bpBKsRbb; Tue, 29 Sep 2020 07:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C6F488558A;
	Tue, 29 Sep 2020 07:01:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA85FC0889;
	Tue, 29 Sep 2020 07:01:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45640C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 28A37204FA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f5V1PACd+rTv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:01:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by silver.osuosl.org (Postfix) with ESMTPS id D982920481
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:01:29 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id n22so5162753edt.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6FpQU46O4XX7PspnZBfr4+krtVC3YDEqV8ZUznNkTjc=;
 b=ArrwmDOzWhdNaRIIKFZGLmvvV6ddxJx+/n+apInuYhOBMWokidaGcy6mfM75qIYZxv
 b3zGbovXJ4c9eXJu9zZTt9SqP5tSt4gX5UlvcNTzHjMHL2M1RJZ0iJ0RHoKrJfXdKemr
 HCO1R32v7BrUoJahWAaFOUwi3yq12tAMHzcl20evrO424qEBpHy3kKWMn74CALVma/mb
 cNyJrlEKtHjMZyvNDjn6mBUxKSpR2JqheO/FuG2ScROpboVzv3FvGVtf0tK9Jxa8pf6K
 a8Xo6wxFgPo06oEbKmrYNUxc0JLNmCnrDAOckI1fPG6/Rvwzv5gzb4As/oMmLljvGrGy
 Dk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6FpQU46O4XX7PspnZBfr4+krtVC3YDEqV8ZUznNkTjc=;
 b=XCGKeiKR7m3ahKky/h7ifyV+AqUzwFG9B+6+zYWAbrT8919C0ual6hFYz/2rTV+/9H
 jpZGXaiaXH7haW9cxgY2M1xiZvA5Y+FevTLfcyK4lD24EDB9lOO5j2cmYiddQWcKdQeX
 ovfRkr6KRwMMGpzt7qht2bcb/MppFlLqHQhWunYqUEHRc90N+EBVaCf4v4HxBlv3Brg1
 eh/AnzGl9wq0UHHZ/h4VX6zI500MK7waFUYBMEW/X65AGjICatXrg9Dehjl1HxDuSJRH
 NW9ur0tF6jbPFx4/vn45ogEcRSp9ebJ1BSF6hB0q454M9H70SLI3EF4J4fAuIdnkjjmq
 tHrw==
X-Gm-Message-State: AOAM532N6ZBm4Q3EITCvGaQ4Ev/sOq+kHygVQFQ4rQKha+xJIHKj6aej
 PK48xbuXV3d6ha6M+Q8vrNMhXQTrIaybuPqr/50=
X-Google-Smtp-Source: ABdhPJxqaoenk2GDSZXo79HFW8w9lqiOFaaEUGWp51velKCS1oFo9BKRf0EZoyxqGb7U74b/LTi+rTr4odyU7ckH5j4=
X-Received: by 2002:a05:6402:304f:: with SMTP id
 bu15mr1700728edb.201.1601362888358; 
 Tue, 29 Sep 2020 00:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
 <20200929022246-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200929022246-mutt-send-email-mst@kernel.org>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Tue, 29 Sep 2020 14:59:03 +0800
Message-ID: <CAMDZJNWM7eBkrYk9nkEvPyHW7=kt_hTHGQCDB1CPRz=EV6vJcQ@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: don't disable guest csum when disable
 LRO
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Willem de Bruijn <willemb@google.com>,
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

On Tue, Sep 29, 2020 at 2:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 29, 2020 at 09:58:06AM +0800, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > Open vSwitch and Linux bridge will disable LRO of the interface
> > when this interface added to them. Now when disable the LRO, the
> > virtio-net csum is disable too. That drops the forwarding performance.
> >
> > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > ---
> > v2:
> > * change the fix-tag
> > ---
> >  drivers/net/virtio_net.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7145c83c6c8c..21b71148c532 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
> >       VIRTIO_NET_F_GUEST_CSUM
> >  };
> >
> > +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > +                             (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> > +                             (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > +                             (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > +
>
> I think I'd rather we open-coded this, the macro is only
> used in one place ...
Yes, in this patch, it is used only in one place. But in next patch
[1], we use it twice and that make the code look a bit nicer.
Would we open-coded this in this patch ?

[1] - http://patchwork.ozlabs.org/project/netdev/patch/20200928033915.82810-2-xiangxia.m.yue@gmail.com/

> >  struct virtnet_stat_desc {
> >       char desc[ETH_GSTRING_LEN];
> >       size_t offset;
> > @@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
> >               if (features & NETIF_F_LRO)
> >                       offloads = vi->guest_offloads_capable;
> >               else
> > -                     offloads = 0;
> > +                     offloads = vi->guest_offloads_capable &
> > +                                ~GUEST_OFFLOAD_LRO_MASK;
> >
> >               err = virtnet_set_guest_offloads(vi, offloads);
> >               if (err)
>
> > --
> > 2.23.0
>


-- 
Best regards, Tonghao
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
