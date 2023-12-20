Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF910FC04
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chknElB5"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A077832B3
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 04:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A077832B3
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chknElB5
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3pqqKUpvE96U
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 04:01:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B4AB8329E
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 04:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B4AB8329E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9WrZt2uNhtNYFIXv3cFXVd3+GtJdXG5iynZg0EOskg=;
	b=chknElB5oSKR/I0DEVkmPF47ifFcRid9rYWlyI7FrbJHqIqaztfPq9R6k/7RCXcuA8wcaE
	XBmb56j9B843aMJY0oZdCKCojWT82l39yd3KeS8qsCDS95SkDVEsDsknlOdMnTI0kmXvu6
	nIdsV6copB15bmBOfch4etjKEc50L4s=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-z7WOvd37PDuISU4XAI7WyA-1; Tue, 19 Dec 2023 23:01:20 -0500
X-MC-Unique: z7WOvd37PDuISU4XAI7WyA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6da66541ac5so3442693a34.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 20:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044880; x=1703649680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9WrZt2uNhtNYFIXv3cFXVd3+GtJdXG5iynZg0EOskg=;
        b=gaZyz8sjojeEq7vFC98mihFV1YP9DvSNa6s5jcv3FO+b/eMuY1Zt9Mi4dmMEyxIuJP
         j1s9MR5MHi6dcMZYe6jlZkwr5lVR79X/RXNRXCBIDMpX/aH4W9M12/hlJFR4QeJTQM/v
         G5nPIg/uTn1wjDlF2JSB495n+ATavyEhlpl4lodd2BQd+R/buly/ke5G1wwHYOokaHLC
         kBkOlxanwHDXzAVTurtJ884ERAIzQS1ZVCIhmJ47yipFcAH49LPlh1qfX6949qgR1+vx
         1yJmVLntkDnN6GxjPahk2QrjVLv3BV+Hktpi51AEjcmZvAKojcDxUub4m8Odz2oqjUIU
         Ms4g==
X-Gm-Message-State: AOJu0YwvicCqEuRw6PnFeDwiMI+3ZHUodI4XTkBEOnU+0W2jB4wxrC4J
	EuCumuUByCh3auutBift5xvnH+vpawBahnC9WqvfHhI1Rv1wSw8kRbRf0zt87p4IaAUB0MaCfdh
	nUVbrWBZtLDl7lGewAm7MNGWFZ7cmGHkEsVv5OlPYYD7dcFxKKv32U49qpg==
X-Received: by 2002:a05:6830:111a:b0:6db:a784:e63c with SMTP id w26-20020a056830111a00b006dba784e63cmr1226586otq.52.1703044880107;
        Tue, 19 Dec 2023 20:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKXTTVHkTHwzTIJp3S44KEnYn52QSYOGCVLEeAMGeoIdjhsZpD4pvK8iU+DlF3o79kgP3L8OwSOJhybMg0H+A=
X-Received: by 2002:a05:6830:111a:b0:6db:a784:e63c with SMTP id
 w26-20020a056830111a00b006dba784e63cmr1226573otq.52.1703044879855; Tue, 19
 Dec 2023 20:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a7b0ef1eabd081f1c7c894e9b11de01678e85dee.1666293559.git.christophe.jaillet@wanadoo.fr>
 <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
In-Reply-To: <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:01:08 +0800
Message-ID: <CACGkMEtHy4GxGEQyL9EThK11wHTH=JS44gM+A41gsWSSg9e=QQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Fix an error handling path in eni_vdpa_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 5:14=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 20/10/2022 =C3=A0 21:21, Christophe JAILLET a =C3=A9crit :
> > After a successful vp_legacy_probe() call, vp_legacy_remove() should be
> > called in the error handling path, as already done in the remove functi=
on.
> >
> > Add the missing call.
> >
> > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >   drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni=
_vdpa.c
> > index 5a09a09cca70..cce3d1837104 100644
> > --- a/drivers/vdpa/alibaba/eni_vdpa.c
> > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > @@ -497,7 +497,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
> >       if (!eni_vdpa->vring) {
> >               ret =3D -ENOMEM;
> >               ENI_ERR(pdev, "failed to allocate virtqueues\n");
> > -             goto err;
> > +             goto err_remove_vp_legacy;
> >       }
> >
> >       for (i =3D 0; i < eni_vdpa->queues; i++) {
> > @@ -509,11 +509,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *id)
> >       ret =3D vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
> >       if (ret) {
> >               ENI_ERR(pdev, "failed to register to vdpa bus\n");
> > -             goto err;
> > +             goto err_remove_vp_legacy;
> >       }
> >
> >       return 0;
> >
> > +err_remove_vp_legacy:
> > +     vp_legacy_remove(&eni_vdpa->ldev);
> >   err:
> >       put_device(&eni_vdpa->vdpa.dev);
> >       return ret;
>
> Polite reminder on a (very) old patch.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> CJ
>

