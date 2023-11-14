Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C45156E2
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvSDTrMm"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47AED41774
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 09:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47AED41774
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OvSDTrMm
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NHAgVcgssn_o
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 09:03:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D94D4169B
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 09:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D94D4169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699952608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fB6oSytBEVo/aVKGE9jZjnpX5GsNTs29nVa4/6HWH6o=;
	b=OvSDTrMmJfySHAFMPt4MmHTN5BxTD1LygJwr30w73lFdXZ1knAnhrWIhpjRA2L6uIDY31i
	/2i8ru1tMeyf8Sso1VyiBujIirs6yTcXe3Dais6anbtlwfx4mf696Nt3YWaObFIfRyaqbF
	NtfZkPAocjXgIE7efFhFQ8Joyf8xaNk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-SfuqzX0qOKqq-cSTe8CwkQ-1; Tue, 14 Nov 2023 04:03:24 -0500
X-MC-Unique: SfuqzX0qOKqq-cSTe8CwkQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079630993dso5130264e87.1
        for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 01:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699952602; x=1700557402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB6oSytBEVo/aVKGE9jZjnpX5GsNTs29nVa4/6HWH6o=;
        b=vF+maTeFmsBPJAJngJdS/U66VR/cCLf6D5ytx2uPTSYF+UDNIIviBlzP40eyxuGW8I
         wHYRZDpBCQauPYcVdb2vIOVaj5D/GgzVfI6ZNC3eWRrGD5vt7F8ZQcK4/6+GePLFVzMv
         gaDzP0LJTc72cOJred/RwMA/0EWrER00ztrdkb3EGsRkg7GSug0WDOpbxPiUriK6Lur5
         bI2EwlePEB+dvXgwkQW20fF6MOS671r5TCXm5ODqiiYApzUommDisX3Mes7V+T2ptoaq
         aOxRNkf4E4BpcbJFr1cx/kDK6G46m4uJ9pbloc74wF5A5ry+jmGd9ETmP4qZbTkkI9vk
         yctA==
X-Gm-Message-State: AOJu0YxfLUpz5ejyOAITgfHhQaOz8ICVmO+xFGet+GavxbLoS2Ht7qMU
	3NExlMb1XV67JhD4slKS06kuCbUJ4PzZmduqNTaMTW6iOhy1mt2t1l3Qnyg5juIG0UL6Uca9Ksf
	xzcucYlY2y+VS4dtHsyTOPzis/yOEo4IpVlNRg3u0NV2tHTni0zYGyTLc+w==
X-Received: by 2002:ac2:4545:0:b0:50a:6fb6:8ed5 with SMTP id j5-20020ac24545000000b0050a6fb68ed5mr5313526lfm.63.1699952602542;
        Tue, 14 Nov 2023 01:03:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjV1jsVG3HdXLx39lUBmvHYXoA3XU1P03aSWH24t3p1zJoEkWpB0HfInIk1nYQggmizwoC6Y00uUt9/QL/Dgc=
X-Received: by 2002:ac2:4545:0:b0:50a:6fb6:8ed5 with SMTP id
 j5-20020ac24545000000b0050a6fb68ed5mr5313509lfm.63.1699952602250; Tue, 14 Nov
 2023 01:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231110221802.46841-1-shannon.nelson@amd.com>
 <20231110221802.46841-4-shannon.nelson@amd.com> <CACGkMEuhn5zrfnqCU0Ovir4o_F9fXj86_pxmqAEEepESYM++tg@mail.gmail.com>
In-Reply-To: <CACGkMEuhn5zrfnqCU0Ovir4o_F9fXj86_pxmqAEEepESYM++tg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 17:03:11 +0800
Message-ID: <CACGkMEtV8+Cyf1cCPkuPkka5j6eOLKD+qE9R6gKvvHXzEoBBPw@mail.gmail.com>
Subject: Re: [PATCH virtio 3/3] pds_vdpa: set features order
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	brett.creeley@amd.com, lkp@intel.com, drivers@pensando.io
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:13=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Sat, Nov 11, 2023 at 6:18=E2=80=AFAM Shannon Nelson <shannon.nelson@am=
d.com> wrote:
> >
> > Fix up the order that the device and negotiated features
> > are checked to get a more reliable difference when things
> > get changed.
> >
> > Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> > ---
> >  drivers/vdpa/pds/vdpa_dev.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> > index 9fc89c82d1f0..25c0fe5ec3d5 100644
> > --- a/drivers/vdpa/pds/vdpa_dev.c
> > +++ b/drivers/vdpa/pds/vdpa_dev.c
> > @@ -318,9 +318,8 @@ static int pds_vdpa_set_driver_features(struct vdpa=
_device *vdpa_dev, u64 featur
> >                 return -EOPNOTSUPP;
> >         }
> >
> > -       pdsv->negotiated_features =3D nego_features;
> > -
> >         driver_features =3D pds_vdpa_get_driver_features(vdpa_dev);
> > +       pdsv->negotiated_features =3D nego_features;
>
> I may miss something, but I don't see how things have changed here.

Ok, I think I get it. driver_feautres here means the old negotiated feature=
s.

We probably need a better name (not a native speaker though).

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks
>
> >         dev_dbg(dev, "%s: %#llx =3D> %#llx\n",
> >                 __func__, driver_features, nego_features);
> >
> > --
> > 2.17.1
> >

