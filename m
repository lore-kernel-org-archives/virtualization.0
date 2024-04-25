Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC8111A1
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008978; cv=none; b=NijBqEW0w8AD6ONq35lJf2R1CP482eQPOabCml4QpdZuiukeearfAMkucoMv1QVqqbM3msj3RXz/Xvu7iuw6IlkJuyT2vIPlCsjiM9oBELlRAa6qa//P5MNMxWb3g7B8cPgLxgr+QZPgEAyLyy87By5IHtgBSf8IWM7OsZWrw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008978; c=relaxed/simple;
	bh=OYZOIiMVGrjpLAGzPdLgl+swk58Tp9BY5qQ7cKzmASM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LV4gMujl5bIYBfhLozeXa+eEw51us75Fkp9EzUyryDh5ftVeGyiruxFIJX6St6lVSI7LwBkLCBbrPrRx7XZO/MTIjnckQJDle9hml8tgEElTDT2v3velqEil88o4Vokga7jG2PVYU5ASnyWNqv8sZo/D76A137DYOzM7LzVZRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfHBNw8m; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfHBNw8m"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4378C82284
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 01:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oNkhtUSXqhjA for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Apr 2024 01:36:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4983D82278
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4983D82278
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XfHBNw8m
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4983D82278
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 01:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714008973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpCIALRhH6s1EwiBqcuDDSTBd5kPwwUWzmPiht3kNis=;
	b=XfHBNw8mp5YVlihzcEawfFj3a57O4kLDP2VzApT2P4a2UlNswn7EZVG9xa4TT11gkKRoZU
	jVasONv+rVJWO/6VXoCG8eKCuW3e+//ZaHGuyTdqWYg6Q/2AFws90SNpV4izuupWQ+poPx
	tkuLSIly7hydeFMaQl1fUfbFfIqqdzg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-oGu3KoE9P4Kfj315qmr_Pw-1; Wed, 24 Apr 2024 21:36:11 -0400
X-MC-Unique: oGu3KoE9P4Kfj315qmr_Pw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a5066ddd4cso591359a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 18:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714008970; x=1714613770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpCIALRhH6s1EwiBqcuDDSTBd5kPwwUWzmPiht3kNis=;
        b=O4uUDXaO1tHfIeO9opIS/geTb86oWU7fWZHDbpe0QkBqG0u/aXrbFa2Irp3OWRUiwP
         VldUlSi/du6t2uOerdLiFa8wZGHIhZdIyEUHFGApCEOb2Pu/C2Ca6V2FySJGCTgEjzSG
         65J4/Iqq5+bByowexasBh2Rtog3e3I7qBUYBz8Lfb+TxOtGTKKQwu7kfVhFu/tROhcC0
         wX4nqXKz2DGFGj1fQez1n8NgmLyxUiBIOFV9EEWQshzo/Pzf5+79UVt0GsQss6csEWoG
         85a2DHk/iBDjCJb5xy+m1QJnFzIGj0VIYg2+exHDTNqq5UFGUftjWjCPTCmgchJCm2ye
         gNlw==
X-Forwarded-Encrypted: i=1; AJvYcCV/kRVpXt9UTQR7QenuoPSWa70ANozDDobpTLXbYj+MxbFIkS5Q4+nbaMtMLkNO/L8gBVeaPuH5bReYXsqfD0X/B0WVvUB7nkF+HAi3zq1NHujUzlRth8r3/g==
X-Gm-Message-State: AOJu0YwihX0tZg4VmeE3Ya9MRpsDkP6i21RySaTG2JKjUjqGiL5Vv3m3
	ME33brjZoKWRyyX8R/3Kd5PK78+bYLLZwTvE0/jLI1B8X7fziSMcJXD0P68k4zTWO+UAervpwlS
	tspzu75VKnnaF1nS/M93fKuJ1aPvmez+BSMyrY414RE3FIw22qlsIiuvaWp2bnI9IGFzA6FE2mX
	WvzYM7xvSQvf4WpV/ilO8zNJ6S0IDE2iDLTLhsvIH4jkqP+ur1ZES1qA==
X-Received: by 2002:a17:90a:f6c8:b0:2ad:ec71:b7e5 with SMTP id er8-20020a17090af6c800b002adec71b7e5mr4056464pjb.33.1714008970493;
        Wed, 24 Apr 2024 18:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCYK3BKE5mGR4DRabWx3KJUsQiI9ul/+yxnnCH+JAugha/KAI9C2EmP0KFnDfSAsDmXu/TMVd1PQAmdTgPqbA=
X-Received: by 2002:a17:90a:f6c8:b0:2ad:ec71:b7e5 with SMTP id
 er8-20020a17090af6c800b002adec71b7e5mr4056453pjb.33.1714008970137; Wed, 24
 Apr 2024 18:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org> <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org> <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
 <20240424055108-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240424055108-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Apr 2024 09:35:58 +0800
Message-ID: <CACGkMEtosWhV-eJbPetgPtp-Thg31CLUBGaENbQRknYtzEV3bQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Apr 24, 2024 at 08:44:10AM +0800, Jason Wang wrote:
> > On Tue, Apr 23, 2024 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > > On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > > These functions allow vduse to allocate and free memory for=
 reconnection
> > > > > > > > information. The amount of memory allocated is vq_num pages=
.
> > > > > > > > Each VQS will map its own page where the reconnection infor=
mation will be saved
> > > > > > > >
> > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++=
++++++++++++
> > > > > > > >  1 file changed, 40 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > > >       int irq_effective_cpu;
> > > > > > > >       struct cpumask irq_affinity;
> > > > > > > >       struct kobject kobj;
> > > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  struct vduse_dev;
> > > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effectiv=
e_cpu(struct vduse_virtqueue *vq)
> > > > > > > >
> > > > > > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > > > > > >  }
> > > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_de=
v *dev)
> > > > > > > > +{
> > > > > > > > +     unsigned long vaddr =3D 0;
> > > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > > +
> > > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > > +             /*page 0~ vq_num save the reconnect info for =
vq*/
> > > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > > > > > >
> > > > > > >
> > > > > > > I don't get why you insist on stealing kernel memory for some=
thing
> > > > > > > that is just used by userspace to store data for its own use.
> > > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > > create a regular file anywhere in the filesystem.
> > > > > >
> > > > > > Good point. So the motivation here is to:
> > > > > >
> > > > > > 1) be self contained, no dependency for high speed persist data
> > > > > > storage like tmpfs
> > > > >
> > > > > No idea what this means.
> > > >
> > > > I mean a regular file may slow down the datapath performance, so
> > > > usually the application will try to use tmpfs and other which is a
> > > > dependency for implementing the reconnection.
> > >
> > > Are we worried about systems without tmpfs now?
> >
> > Yes.
>
> Why? Who ships these?

Not sure, but it could be disabled or unmounted. I'm not sure make
VDUSE depends on TMPFS is a good idea.

Thanks

