Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08B7C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49F46608D3;
	Thu, 25 Nov 2021 07:03:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hubIHw9xWBv6; Thu, 25 Nov 2021 07:03:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C5836608DD;
	Thu, 25 Nov 2021 07:03:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A228BC0038;
	Thu, 25 Nov 2021 07:03:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01F63C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3BF8608DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zt0woAU08MZr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBBCD608D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637823780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKZ4W8dUJsff2qgbh+MXcvWMXfjgct4ziZKazp/bmHw=;
 b=IXqzxXM6vg+aotEZeUxcKiBqxQeiBwkHcWuvZH2YfGamcJGieEEjrIRt7Fp9DrCPxqHgIj
 dijaHVPiSIEJlnWOuRb3SeQcgjnp/G2H4TtKmaHD68HLkYTqhNvmXE2SOJTn03JeEE3QXX
 9sRaECWAYEOgII+MEsVJWBpA6rbtf1k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-OEemo5F7N8WyJCohDurewA-1; Thu, 25 Nov 2021 02:02:59 -0500
X-MC-Unique: OEemo5F7N8WyJCohDurewA-1
Received: by mail-ed1-f72.google.com with SMTP id
 c1-20020aa7c741000000b003e7bf1da4bcso4579175eds.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VKZ4W8dUJsff2qgbh+MXcvWMXfjgct4ziZKazp/bmHw=;
 b=W9V73OxO2mVA4YEu2nlkj8MwfBWHXDt/GnEDLYu/Sm99zv0T6AbGj/p8T0ZFtAxYAN
 hT5CC3cG3IhkxE9xayr8JJ0rVfvzciV9DtAFU0H5DGJfttudgtPCP8KYV6SEGe+l8FSv
 mPDoFY3gphcRaWIrHwb9ttduHvn8LLh5aIZsnGPP+GV4xXdGJLQMNLmt3nBfiypQn3mC
 WfyXMtVgQT9cipW1tZ154HAjtq0g9g+Q/kHA8dfjqkf/h6pSbciobKi0dP81xRWDdlz7
 HIaUK9abwH7FVs18w+J73sjMgxbngvU4aHczWN0hYR2ulyUfdcJBxOkcIzW4qRgMWyCg
 dxIw==
X-Gm-Message-State: AOAM533Ge6ctq/YidnlbIbGW6s+aTMNrQgDHC0WBaPeWL3Do9X28rQg4
 +PS/+S+Uv2p/nCahNA3s25N8v1kkokcs1Q57BgUS8o2Sm3JVRsnPqh6mAmOyinwwJpmPR4j7V2P
 23/v9RMNoslFA/V97CjZQiIQjAKj7d7chK4ztvVJg0w==
X-Received: by 2002:a05:6402:5156:: with SMTP id
 n22mr36646988edd.222.1637823777782; 
 Wed, 24 Nov 2021 23:02:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYcHfM0EP+0ZsTjbg+b2mmor3qHoBJ/QIj7HfoEGeddfE30NFvqno9TE2xCMsIv67T6XnoKg==
X-Received: by 2002:a05:6402:5156:: with SMTP id
 n22mr36646962edd.222.1637823777600; 
 Wed, 24 Nov 2021 23:02:57 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
 by smtp.gmail.com with ESMTPSA id aq14sm992371ejc.23.2021.11.24.23.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 23:02:56 -0800 (PST)
Date: Thu, 25 Nov 2021 02:02:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/2] eni_vdpa: Fix an error handling path in
 'eni_vdpa_probe()'
Message-ID: <20211125020139-mutt-send-email-mst@kernel.org>
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
 <CACGkMEvN0cgFQhJmLF3xDXHt_EyZ-TnfBM8CnpNwA9sKcwpzBg@mail.gmail.com>
 <393fb7b7-653b-eae6-16bd-5ffc7d600619@wanadoo.fr>
 <CACGkMEt3yA+fkFJxKfrXyui-rYVSk78=1AqrT0TYQqzcqTJVyg@mail.gmail.com>
 <069ed3fb-ef99-ff36-136d-a0221ba85a96@wanadoo.fr>
 <20211124185834-mutt-send-email-mst@kernel.org>
 <131b9250-f338-c931-39e6-ca3c1e3a9b66@wanadoo.fr>
MIME-Version: 1.0
In-Reply-To: <131b9250-f338-c931-39e6-ca3c1e3a9b66@wanadoo.fr>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Nov 25, 2021 at 07:34:02AM +0100, Christophe JAILLET wrote:
> Le 25/11/2021 =E0 00:58, Michael S. Tsirkin a =E9crit=A0:
> > On Tue, Nov 09, 2021 at 10:21:44PM +0100, Christophe JAILLET wrote:
> > > Le 09/11/2021 =E0 03:54, Jason Wang a =E9crit=A0:
> > > > On Tue, Nov 9, 2021 at 3:32 AM Christophe JAILLET
> > > > <christophe.jaillet@wanadoo.fr> wrote:
> > > > > =

> > > > > Le 08/11/2021 =E0 06:55, Jason Wang a =E9crit :
> > > > > > On Mon, Nov 8, 2021 at 12:15 AM Christophe JAILLET
> > > > > > <christophe.jaillet@wanadoo.fr> wrote:
> > > > > > > =

> > > > > > > In the error handling path, a successful 'vp_legacy_probe()' =
should be
> > > > > > > balanced by a corresponding 'vp_legacy_remove()' call, as alr=
eady done in
> > > > > > > the remove function.
> > > > > > > =

> > > > > > > Add the missing call and update gotos accordingly.
> > > > > > > =

> > > > > > > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba E=
NI")
> > > > > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo=
.fr>
> > > > > > > ---
> > > > > > >     drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
> > > > > > >     1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > =

> > > > > > > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/a=
libaba/eni_vdpa.c
> > > > > > > index 3f788794571a..12b3db6b4517 100644
> > > > > > > --- a/drivers/vdpa/alibaba/eni_vdpa.c
> > > > > > > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > > > > @@ -501,7 +501,7 @@ static int eni_vdpa_probe(struct pci_dev =
*pdev, const struct pci_device_id *id)
> > > > > > >            if (!eni_vdpa->vring) {
> > > > > > >                    ret =3D -ENOMEM;
> > > > > > >                    ENI_ERR(pdev, "failed to allocate virtqueu=
es\n");
> > > > > > > -               goto err;
> > > > > > > +               goto err_remove_vp_legacy;
> > > > > > >            }
> > > > > > > =

> > > > > > >            for (i =3D 0; i < eni_vdpa->queues; i++) {
> > > > > > > @@ -513,11 +513,13 @@ static int eni_vdpa_probe(struct pci_de=
v *pdev, const struct pci_device_id *id)
> > > > > > >            ret =3D vdpa_register_device(&eni_vdpa->vdpa, eni_=
vdpa->queues);
> > > > > > >            if (ret) {
> > > > > > >                    ENI_ERR(pdev, "failed to register to vdpa =
bus\n");
> > > > > > > -               goto err;
> > > > > > > +               goto err_remove_vp_legacy;
> > > > > > >            }
> > > > > > > =

> > > > > > >            return 0;
> > > > > > > =

> > > > > > > +err_remove_vp_legacy:
> > > > > > > +       vp_legacy_remove(&eni_vdpa->ldev);
> > > > > > =

> > > > > > Won't vp_legacy_remove() be triggered by the put_devic() below?
> > > > > =

> > > > > Hi, I'm sorry but i don't see how.
> > > > > =

> > > > > My understanding is that:
> > > > >      - on "put_device(&eni_vdpa->vdpa.dev);", the corresponding r=
elease
> > > > > function will be called.
> > > > > =

> > > > >      - This release function is the one recorded in the
> > > > > '__vdpa_alloc_device()' function.
> > > > > =

> > > > >      - So it should be 'vdpa_release_dev()'.
> > > > > =

> > > > >      - This function, AFAIU, has no knowledge of 'vp_legacy_remov=
e()' or
> > > > > anything that could call it.
> > > > > =

> > > > > =

> > > > > Unless I misread something or miss something obvious, I don't see=
 how
> > > > > 'vp_legacy_remove() would be called.
> > > > > =

> > > > > =

> > > > > Could you elaborate?
> > > > =

> > > > I think the device should release the driver (see
> > > > device_release_driver()) during during its deleting.
> > > =

> > > Hi, I still don't follow the logic and I don't understand how
> > > 'vp_legacy_remove()' will finely be called, but it is not that import=
ant.
> > > =

> > > If it's fine for you, it's fine for me :)
> > > =

> > > CJ
> > =

> > So pls post just patch 2?
> =

> Patch 2/2 should apply cleanly with or without patch 1/2.
> Do I really need to send a v2 just for dropping the first patch? :/
> =

> CJ

It is preferable, yes. A patch in isolation is not the same as a patch
in the series.

> > =

> > > > =

> > > > Thanks
> > > > =

> > > > > =

> > > > > CJ
> > > > > =

> > > > > > =

> > > > > > Thanks
> > > > > > =

> > > > > > >     err:
> > > > > > >            put_device(&eni_vdpa->vdpa.dev);
> > > > > > >            return ret;
> > > > > > > --
> > > > > > > 2.30.2
> > > > > > > =

> > > > > > =

> > > > > > =

> > > > > =

> > > > =

> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > =

> > =

> > =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
