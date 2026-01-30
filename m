Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D323A566
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739437; cv=none; b=j2LGt1g77R3IhY0WszPtBCCxO0dZHy97ghSnZd9lcmZhGVZLzdYgc0eKDYwGPUqYlHduWVgtJIUc4pgtwKQaPf3ZjbeMR6niFqlyJtCcBrzQ9/PKbkpWPbPcmGn2WscxvPAAUg8Soan4h5vdDsnkTYHL83IcGfoel+kk+gbnvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739437; c=relaxed/simple;
	bh=VaDXNKg1zLDsPVQV1M1IPj+nBh6OZf9cSBReTExYSG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgS6WlZway2Vb3IH46577vWUmaaY8U1DVplusur0P0uzXnSuMXqO66JM5WiIMYBOjZT4inkLM1Vu7aLUHIosOrRQ1KZf30l6KFfPA+CCv1HeFEUTQYcvDaCVKQQdgIAp16Z9wa2x1upEN3E/YhCrQix/U9o+2qX1WKfVpb+eIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/W1gCrS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/W1gCrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769739435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHZy4zOSqhLqMEIqffqOuKbwS3CdmKZgiB1TF+biyac=;
	b=U/W1gCrSdx0QK2YFdMBUwbeSx2bqoyfDDJwc8XeY9uBJDEghC3jn8jXdMwjZsDWUyxRs6w
	tY5xEP34Ir6rWzDTFAFgFdjaGuwFUrak4KPkULM855vuPXVCpUYuBqOAXpuhqZaFqDzYbm
	p/T7z7Q+hY8Yz5vVIEnPdFdMXFiDhyM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-c9gXSTUPPgy1unSDw2SjiA-1; Thu, 29 Jan 2026 21:17:13 -0500
X-MC-Unique: c9gXSTUPPgy1unSDw2SjiA-1
X-Mimecast-MFC-AGG-ID: c9gXSTUPPgy1unSDw2SjiA_1769739433
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso1584554a91.3
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 18:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769739433; x=1770344233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHZy4zOSqhLqMEIqffqOuKbwS3CdmKZgiB1TF+biyac=;
        b=FCsuqXLtYI+MpeXXJkoTFJRbzObmqmBs1mvrdmLaVYk2FBpw4bvIVnL4pbo/ALdfVV
         zG5TMABIXhLSaoz+HXnyDkFIR+F8s97jy2Nst0B5Cc7LUIakN4BLx9de5D+GVN1EHHBh
         X9vSvsv1/yHtpIIx54NyawdPaGZabq0GU2TQp0kTrjtBpXjqt/6F/F3F9IUXeBHiSKMc
         EUEgZu1W1vEuLvUgfGbI+/+JvmDEfcSLVkbIGSuJ2Xav+bUKBO45vfVdlQV/bHdHKBNP
         DuRJNQs2aK6E9RCgULqv9IAY29vJHlJqcCiyNsHeEz4Z0OuYU3DkfOR5b2ruqkXrK5r/
         wctg==
X-Forwarded-Encrypted: i=1; AJvYcCXM2oiXt7Vz2szWWCCiXnfLly0U74bqb61zdijO69/6KfFg381/tPsEfJ+lTF3/eJIhB4y7Uv5WnyIldysXxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2KvaTxxyih4HyjN1ZpxV3tbFVtwml4NplFIYxOxrwxtODWyG6
	0z/VRwU5uUqrFzUmx4diUs5wIkvr0HuZTTL4O82xMcH+Tqi4ffu6cfbQMwFg8YCYRRLzwU5a/0W
	dqiop4PXLzY3xGSlg+Fk1yrbBKjvWZI9C4OyLSl/8HCebNENxDnMn2bYhY144lB4JJQfGX4ND1t
	yOEEyKJG1O/cGCueHEkKWwiCeE9Kvf0jj/UVnaWacn/OY=
X-Gm-Gg: AZuq6aLStdzGlcjLGibCgL2KOngE/oV3XcpcQVlrW07afVTB+XD3hjOpALz+tPTB3p9
	3PPTmT4gCSemCV5K/FexrFwIRvgbmdVx5JXrbIqJchKDghQKJAVK8/Ko2r2+loW+HquQeEZaPpn
	ekI9bLj1rFvk9yC5URQKpXaQCqwbjXzQi1uHDZjMuUu9Gl149Fl7VjukJeDLUdOuCW
X-Received: by 2002:a17:90b:1343:b0:352:c9c9:75b8 with SMTP id 98e67ed59e1d1-3543b41d89bmr1281636a91.36.1769739432740;
        Thu, 29 Jan 2026 18:17:12 -0800 (PST)
X-Received: by 2002:a17:90b:1343:b0:352:c9c9:75b8 with SMTP id
 98e67ed59e1d1-3543b41d89bmr1281618a91.36.1769739432291; Thu, 29 Jan 2026
 18:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-4-eperezma@redhat.com>
 <CACGkMEspErSiv7y5=zHAfJ-G7HVxv5Yr=AA+ttfyxWVVs7Rmmw@mail.gmail.com> <CAJaqyWeMuGouepjgVg3Q1nyL04pjJMeVKa6kVZJ-sS_LBBXQXg@mail.gmail.com>
In-Reply-To: <CAJaqyWeMuGouepjgVg3Q1nyL04pjJMeVKa6kVZJ-sS_LBBXQXg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jan 2026 10:17:00 +0800
X-Gm-Features: AZwV_Qg1PNftP9G0hyF0evjRZJGAdKQOej4DGIGiHWykDXeFLPzLrGr5DYTnx_U
Message-ID: <CACGkMEt9YODRPZqstZy8tdNuy66ofz33NfZizhYN-jQsjor4SQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: Add API v2 definition
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4qGvSs7VFpEEe6_0_qHRfoq1Dz9B_XK2Ji9TRfsKZjA_1769739433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 4:08=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jan 29, 2026 at 3:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Introduce the definition for VDUSE API V2.  This version serves as a
> > > gateway for feature negotiation.
> > >
> > > The kernel uses this version to determine if the userspace device
> > > supports feature flags. Devices that do not explicitly negotiate API =
V2
> > > will be blocked from querying available VDUSE features, ensuring
> > > backward compatibility.
> > >
> > > The next patches implement the new feature incrementally, only enabli=
ng
> > > the VDUSE device to set the V2 API version by the end of the series.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  include/uapi/linux/vduse.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index 68b4287f9fac..dea89ed281a7 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -14,6 +14,10 @@
> > >
> > >  #define VDUSE_API_VERSION_1    1
> > >
> > > +/* Features support */
> > > +
> > > +#define VDUSE_API_VERSION_2    2
> >
> > If we can catch the next release cycle, I would perfer not bumping
> > VDUSE version twice in the same release.
> >
>
> Following the number of versions that ASID required I don't expect
> this one to be ready for the next release cycle :).

Then it's probably fine.

>
> But if you ack the patches related with the vduse features handling,
> MST is ok with that, and we're still in time to reach linux-next and
> the next Linux, I can prepare a series where I add the features bits
> to V1 API. Then, all ASID and VQ_ENABLE will be handled by feature
> bits. Would that work for both of you?

Maybe you can start with V1 and if we can't catch this release, a
respin will be needed anyhow.

>
> If we're out of time, I'd prefer ASID to reach the next release cycle
> as the series is already big.
>
> Thanks!

Thanks

>

