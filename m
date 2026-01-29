Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815537AA6F
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674086; cv=none; b=RYb64vZyFkH14dNJrLX320wmx+UiPn9ZfIzfoprQ3sY/LeyWPhZ5SbTn3c+IZiw6+ba6di5PvufHa3pxoT6R9spIJ1Ayv4pvzmAZT10S9Zu+PbxWL99dBAlDEQTPAyjpYA12VACLP3U7HUSnduRLmyuIOj9p/JInJYmG0JNC2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674086; c=relaxed/simple;
	bh=RDZd1XDZOb12bQalVM9Buy+Q/ujHr6OjighcCFf+fhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTRK6Ggcjsf2uWMkdwnjUQC9dpyyTsLouIvTUyKLvMJVbW7pnJluuKioDQWNyKCOE+3kQN6Q2r1hr4GFe9j8PgIoFlo4V1cq9GPPFvr+3dl1T/ButxTQLQs8n6vv/1CtrNDnbCsR71Tj/GAsdOjfQ8ZUzj2LSK8QJNN7JhHKzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WX0Z8aVu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX0Z8aVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769674084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QY996VA0VzTb4IlNzzhJrTkp8LX9guUA4A9e5fDLMRc=;
	b=WX0Z8aVuwPhpb2O69ekVN+/kC+hmWlkCymBUYt3MCHLw920J/3bAuAmHjXccdOikRuK0nN
	+Qm2vaWsf9ADZ3z5EM877L1C7Y3gKiOiXg4lEQmZG6gdbrJYdwISXKDY3cm1vGFnRDR8vH
	K7oxN9Ed0x2XN19QptbCvjwNCCauyCQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-azwmINFKNZqXFEBnzQ1sfA-1; Thu, 29 Jan 2026 03:08:00 -0500
X-MC-Unique: azwmINFKNZqXFEBnzQ1sfA-1
X-Mimecast-MFC-AGG-ID: azwmINFKNZqXFEBnzQ1sfA_1769674080
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79269803c05so8090867b3.2
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 00:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674080; x=1770278880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QY996VA0VzTb4IlNzzhJrTkp8LX9guUA4A9e5fDLMRc=;
        b=SVMfeWtt3Axt3U6j1rN0nzHWG31/W9REWVrYhYr6yhaWhC75crAU2hnXWwFIUr3GP0
         rIVNHgEKf5mNbX7Rq9spbmERjwv/q5+aaoBqxqTSs8lTtb8FvUKAQiBOAmVXX5em6/Kk
         heWTJ7E5Rl0pCrfyoPtzXPkM31/JnYnW3Aa7lLUN+e+UpEp0e+GmJdUERB9GUPI5ixzV
         qP3ZOlyoWG5HEoIU6tsKIDjwsjsG+LsoWNEbOZxt2e+kQwdVguPo7LtdUXlagHdiK1SS
         95cP9utid+SJbHjJien5wi/1NcyGrwwy8o+8BNOsI0HlO5N4q0feXXaA4VicdKFt68y7
         Jgiw==
X-Forwarded-Encrypted: i=1; AJvYcCVn/TQ/aRDQ3pw+I7ilOc6EyNw9G9x7IhsGkUn1SHl7EJ+BsTe4dPUnl8WV0MXGadDWxMV1hY/hONnBWdoYIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfEiZ9cqrWJnFGCLPW7iuA+IgSFimILCLGmnIanJ574ohycR3j
	EhKJx07tZhOLbJiNUPDVfnZkCA8UOt98UVyplI1OXnCzwx8M+AckKmBlpwGo7R9A1b41QmFpj1Z
	YRtPDszewnJlhPI9PqrICTUUG1R5uKqzYTsbMKsmR6ZbH/lo060T5mt7ap48m9yUzbYWIHKT3xZ
	ZSuclQgsjmLYD9+l5ZB3io2lIw8AkfkVqeqGZLTwSbkVw=
X-Gm-Gg: AZuq6aJgWSEHw7tfVK/un1NrwVpQVCycQoZ7NSGb0KjfgrOCwiEyoiYzWfKsFFa+B+t
	GEVWcekhT1qoGEQKmRJmBvKMgADUbDTKlEXo6xX8YokDKIgHzIDm20550P6R7Aeonsj30axCjTq
	tHJB6Cu15LNfy72ndHxPFmaEdVYohiRC91iX/s2AvoKT98QedDTFH/fX3pjknHrMHhFA==
X-Received: by 2002:a05:690c:4d05:b0:792:6c16:110c with SMTP id 00721157ae682-7947ac9bdbbmr57781587b3.61.1769674080059;
        Thu, 29 Jan 2026 00:08:00 -0800 (PST)
X-Received: by 2002:a05:690c:4d05:b0:792:6c16:110c with SMTP id
 00721157ae682-7947ac9bdbbmr57781427b3.61.1769674079699; Thu, 29 Jan 2026
 00:07:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-4-eperezma@redhat.com>
 <CACGkMEspErSiv7y5=zHAfJ-G7HVxv5Yr=AA+ttfyxWVVs7Rmmw@mail.gmail.com>
In-Reply-To: <CACGkMEspErSiv7y5=zHAfJ-G7HVxv5Yr=AA+ttfyxWVVs7Rmmw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Jan 2026 09:07:23 +0100
X-Gm-Features: AZwV_QjGE1FP-lycGMTBlraMGfrJQzK_puvQQb1qgw_WLCfaBYyVPiuprjJyE44
Message-ID: <CAJaqyWeMuGouepjgVg3Q1nyL04pjJMeVKa6kVZJ-sS_LBBXQXg@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: Add API v2 definition
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J7yY_5BO6BljuGObCf1mViyJx3ZSz3_GHUGvdI5JW8Y_1769674080
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 3:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Introduce the definition for VDUSE API V2.  This version serves as a
> > gateway for feature negotiation.
> >
> > The kernel uses this version to determine if the userspace device
> > supports feature flags. Devices that do not explicitly negotiate API V2
> > will be blocked from querying available VDUSE features, ensuring
> > backward compatibility.
> >
> > The next patches implement the new feature incrementally, only enabling
> > the VDUSE device to set the V2 API version by the end of the series.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  include/uapi/linux/vduse.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 68b4287f9fac..dea89ed281a7 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -14,6 +14,10 @@
> >
> >  #define VDUSE_API_VERSION_1    1
> >
> > +/* Features support */
> > +
> > +#define VDUSE_API_VERSION_2    2
>
> If we can catch the next release cycle, I would perfer not bumping
> VDUSE version twice in the same release.
>

Following the number of versions that ASID required I don't expect
this one to be ready for the next release cycle :).

But if you ack the patches related with the vduse features handling,
MST is ok with that, and we're still in time to reach linux-next and
the next Linux, I can prepare a series where I add the features bits
to V1 API. Then, all ASID and VQ_ENABLE will be handled by feature
bits. Would that work for both of you?

If we're out of time, I'd prefer ASID to reach the next release cycle
as the series is already big.

Thanks!

