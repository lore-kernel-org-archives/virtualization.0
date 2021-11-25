Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BBDC433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FF048247F;
	Thu, 25 Nov 2021 07:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RE-3rAAVsiWk; Thu, 25 Nov 2021 07:15:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5B1182470;
	Thu, 25 Nov 2021 07:15:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1C85C002F;
	Thu, 25 Nov 2021 07:15:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 286DCC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23C0F60760
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DRGa76HmxKod
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:15:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F3BD60609
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637824548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szt1FOtN/yKjgweBlM0Od5s5VcOUOXKDzr7rDCCMpLA=;
 b=VzDhVny+W7dJIdDVQKKU/5XqZ56dGVbhbwLpsLjWq1V+Ecv1PJ3H7t3PsQ/K+2rxzl7crW
 as6fTM/jr101+dJjIEPXyyfN0Dw+5hyyXCuC86oBxVrAWXsB1iFXJwJjKUvrbIBturqTep
 EJ35xarwmfYn7ZwDKr5WvX/xVf3m29Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-C6v3Wm0nO26BNGMAzy4k9g-1; Thu, 25 Nov 2021 02:15:46 -0500
X-MC-Unique: C6v3Wm0nO26BNGMAzy4k9g-1
Received: by mail-lf1-f71.google.com with SMTP id
 x17-20020a0565123f9100b003ff593b7c65so2762424lfa.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=szt1FOtN/yKjgweBlM0Od5s5VcOUOXKDzr7rDCCMpLA=;
 b=VHGw7oqBhgHR/2dov/TerBMZRdlDaJ/Xtlav80U2cXm/tNbF6wr447RVKbS1vewv3+
 gbhJPmY5rvwXRKsNtAHfNiNBVAPcp8vB5tgd3ufo5x9GfUQpcByGNGBlSYknHXFBeL3N
 Mlb7LDWwnAePctilJOObzsx7vsHkKAW0hZUIn6HLX7iKNDQ0uwrMIJRtuCHi8H89P0zW
 ouCN56gLzcEn/d6HlWdtcrMoGqnVnEjyx8QLPODO2SrlKXNjXQMIAARD4TcltOYLMKlN
 g/bkUef1T1LWjgWOmpswgszr6mNHbla6f8FlMEq/AbMl8bjEPj2CglRso2q9a1b0fu+t
 Egsg==
X-Gm-Message-State: AOAM533/PVtWFh7PJ/YrmyWQzgFSBDOkOtPsHSe4eDYiCVPnj/pIeoDB
 x5rFfeoaeknkQSdSIN0GF1mbgQyRkdShXh1cHWF1+EHV+MS26IVH+AK0tFJ0ElpzroBc4RXSAUf
 kr7JucregpAcwrpdK81xjg5njGlDRVob681YXQZmCvVixeYvAUtf1Csp2MQ==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr22280534lfv.629.1637824544725; 
 Wed, 24 Nov 2021 23:15:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydNnhWXm+uH7A9B5KzQZ/aiL2nu5QtNv1eSqbQCKNF0zM5qAS0rfIEcPJw8SEUOYhZe5llo1IdPIBthw2VxrE=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr22280511lfv.629.1637824544520; 
 Wed, 24 Nov 2021 23:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125070939.GC211101@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211125070939.GC211101@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 15:15:33 +0800
Message-ID: <CACGkMEsNsQ_XWTvdjaCEdo8sYaLew24zU1UUCJrokM-Koxj4fw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Thu, Nov 25, 2021 at 3:09 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > large max_mtu. In this case, using small packet mode is not correct
> > since it may breaks the networking when MTU is grater than
> > ETH_DATA_LEN.
> >
> > To have a quick fix, simply enable the big packet mode when
> > VIRTIO_NET_F_MTU is not negotiated. We can do optimization on top.
> >
> > Reported-by: Eli Cohen <elic@nvidia.com>
> > Cc: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> >               dev->mtu = mtu;
> >               dev->max_mtu = mtu;
> >
> > -             /* TODO: size buffers correctly in this case. */
> > -             if (dev->mtu > ETH_DATA_LEN)
> > -                     vi->big_packets = true;
> >       }
> >
> > +     /* TODO: size buffers correctly in this case. */
> > +     if (dev->max_mtu > ETH_DATA_LEN)
> > +             vi->big_packets = true;
> > +
>
> If VIRTIO_NET_F_MTU is provided, then dev->max_mtu is going to equal
> ETH_DATA_LEN (will be set in ether_setup()) so I don't think it will set
> big_packets to true.

I may miss something, the dev->max_mtu is just assigned to the mtu
value read from the config space in the code block above  (inside the
feature check of VIRTIO_NET_F_MTU).

Thanks

>
>
> >       if (vi->any_header_sg)
> >               dev->needed_headroom = vi->hdr_len;
> >
> > --
> > 2.25.1
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
