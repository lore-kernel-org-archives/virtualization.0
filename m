Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A2C433F5
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 23:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9113640222;
	Wed, 24 Nov 2021 23:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uz3Jq328-Wme; Wed, 24 Nov 2021 23:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 30BED4023B;
	Wed, 24 Nov 2021 23:58:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0853C002F;
	Wed, 24 Nov 2021 23:58:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A98A9C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80D8340133
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uF_Id_zj4OiC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:58:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F060400BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637798334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sm4004y9B1V+tnHfPgzjYss0IWvCFu8ljdIxWHi+//4=;
 b=Yo055GzP2frrxgN+fCDSeC80y7+fHRVXsJ0sGG9OaX+jenlSQoU8BVtTOCicyDQ0Q1D4HH
 O6ssekd4OtYp9R683rWH3LinWTxqis0pOuBghYwfsWPyi2P7ZcrdvbYMaUaZQN8ws21GAd
 bSC8synVHpNMms5FdF8OK0aH/b/1Z0U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-d2Y8W8wwNVab7v2zVyR7Dg-1; Wed, 24 Nov 2021 18:58:51 -0500
X-MC-Unique: d2Y8W8wwNVab7v2zVyR7Dg-1
Received: by mail-ed1-f70.google.com with SMTP id
 q17-20020aa7da91000000b003e7c0641b9cso3804319eds.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sm4004y9B1V+tnHfPgzjYss0IWvCFu8ljdIxWHi+//4=;
 b=uLtcWNjL9I/ZVj5sy1SMU83Sr3Df5rKHAS8brXIVnkjQ0X2DQxo57LUg/8p0YrNN3L
 8b6dfKH394sswa5oGyLuUJty45kSMUZn/MUf5MxBTYgkcJJzuUWaia7uOI7VkZiIzxj7
 YCw7nP2fVn6Bjhb7+WMNH4WL0xOuOIWkGPkBy33X4t5ZFtEZwmaqmXlT7WSZ46Tv+B3m
 Qj07lUqcqhB2tgBMtVuMzPESTR7Z34qnbUX/yGJGfZvK6oV87AX+oRZ97JTN4IxrRXrg
 TWuHrXajOSeqIBg96riF9j++1NYS4K8X3OHCdau2IHIL6w1nTXJhefG1/hXtleyOhZNY
 8GWA==
X-Gm-Message-State: AOAM532dbrCkPQm/Hc4ttTq1tz3vtCkAQQQJQlvysc/STNCsTcrQANRw
 6jCbSjwD6BVt02rVVnrbP8MHwl1S3OhbSe0dQ5NoiS6AjLQuTtKBynqiKTPZIfi8WfuL+DSdnSV
 ix9/R2uRird2LNV7sVM0iPD+FzA6oIZjxRwr/Xq32cg==
X-Received: by 2002:a17:906:8c3:: with SMTP id
 o3mr26240448eje.10.1637798330716; 
 Wed, 24 Nov 2021 15:58:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysCDZ92JnLx5p8B8EgDT3JbOAJxcL7cO996KXojwt2y2dxDKYm/THtO3luW2U+EJQ7p/PYcw==
X-Received: by 2002:a17:906:8c3:: with SMTP id
 o3mr26240417eje.10.1637798330482; 
 Wed, 24 Nov 2021 15:58:50 -0800 (PST)
Received: from redhat.com ([2a0e:1c80:14::66])
 by smtp.gmail.com with ESMTPSA id hc16sm593664ejc.12.2021.11.24.15.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 15:58:49 -0800 (PST)
Date: Wed, 24 Nov 2021 18:58:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/2] eni_vdpa: Fix an error handling path in
 'eni_vdpa_probe()'
Message-ID: <20211124185834-mutt-send-email-mst@kernel.org>
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
 <CACGkMEvN0cgFQhJmLF3xDXHt_EyZ-TnfBM8CnpNwA9sKcwpzBg@mail.gmail.com>
 <393fb7b7-653b-eae6-16bd-5ffc7d600619@wanadoo.fr>
 <CACGkMEt3yA+fkFJxKfrXyui-rYVSk78=1AqrT0TYQqzcqTJVyg@mail.gmail.com>
 <069ed3fb-ef99-ff36-136d-a0221ba85a96@wanadoo.fr>
MIME-Version: 1.0
In-Reply-To: <069ed3fb-ef99-ff36-136d-a0221ba85a96@wanadoo.fr>
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

On Tue, Nov 09, 2021 at 10:21:44PM +0100, Christophe JAILLET wrote:
> Le 09/11/2021 =E0 03:54, Jason Wang a =E9crit=A0:
> > On Tue, Nov 9, 2021 at 3:32 AM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> > > =

> > > Le 08/11/2021 =E0 06:55, Jason Wang a =E9crit :
> > > > On Mon, Nov 8, 2021 at 12:15 AM Christophe JAILLET
> > > > <christophe.jaillet@wanadoo.fr> wrote:
> > > > > =

> > > > > In the error handling path, a successful 'vp_legacy_probe()' shou=
ld be
> > > > > balanced by a corresponding 'vp_legacy_remove()' call, as already=
 done in
> > > > > the remove function.
> > > > > =

> > > > > Add the missing call and update gotos accordingly.
> > > > > =

> > > > > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> > > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > > ---
> > > > >    drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
> > > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > =

> > > > > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/aliba=
ba/eni_vdpa.c
> > > > > index 3f788794571a..12b3db6b4517 100644
> > > > > --- a/drivers/vdpa/alibaba/eni_vdpa.c
> > > > > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > > @@ -501,7 +501,7 @@ static int eni_vdpa_probe(struct pci_dev *pde=
v, const struct pci_device_id *id)
> > > > >           if (!eni_vdpa->vring) {
> > > > >                   ret =3D -ENOMEM;
> > > > >                   ENI_ERR(pdev, "failed to allocate virtqueues\n"=
);
> > > > > -               goto err;
> > > > > +               goto err_remove_vp_legacy;
> > > > >           }
> > > > > =

> > > > >           for (i =3D 0; i < eni_vdpa->queues; i++) {
> > > > > @@ -513,11 +513,13 @@ static int eni_vdpa_probe(struct pci_dev *p=
dev, const struct pci_device_id *id)
> > > > >           ret =3D vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa-=
>queues);
> > > > >           if (ret) {
> > > > >                   ENI_ERR(pdev, "failed to register to vdpa bus\n=
");
> > > > > -               goto err;
> > > > > +               goto err_remove_vp_legacy;
> > > > >           }
> > > > > =

> > > > >           return 0;
> > > > > =

> > > > > +err_remove_vp_legacy:
> > > > > +       vp_legacy_remove(&eni_vdpa->ldev);
> > > > =

> > > > Won't vp_legacy_remove() be triggered by the put_devic() below?
> > > =

> > > Hi, I'm sorry but i don't see how.
> > > =

> > > My understanding is that:
> > >     - on "put_device(&eni_vdpa->vdpa.dev);", the corresponding release
> > > function will be called.
> > > =

> > >     - This release function is the one recorded in the
> > > '__vdpa_alloc_device()' function.
> > > =

> > >     - So it should be 'vdpa_release_dev()'.
> > > =

> > >     - This function, AFAIU, has no knowledge of 'vp_legacy_remove()' =
or
> > > anything that could call it.
> > > =

> > > =

> > > Unless I misread something or miss something obvious, I don't see how
> > > 'vp_legacy_remove() would be called.
> > > =

> > > =

> > > Could you elaborate?
> > =

> > I think the device should release the driver (see
> > device_release_driver()) during during its deleting.
> =

> Hi, I still don't follow the logic and I don't understand how
> 'vp_legacy_remove()' will finely be called, but it is not that important.
> =

> If it's fine for you, it's fine for me :)
> =

> CJ

So pls post just patch 2?

> > =

> > Thanks
> > =

> > > =

> > > CJ
> > > =

> > > > =

> > > > Thanks
> > > > =

> > > > >    err:
> > > > >           put_device(&eni_vdpa->vdpa.dev);
> > > > >           return ret;
> > > > > --
> > > > > 2.30.2
> > > > > =

> > > > =

> > > > =

> > > =

> > =

> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
