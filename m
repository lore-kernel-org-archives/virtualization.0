Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D92330B0E
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203582; cv=none; b=hqmic7kVSI/p7uCJgN+sXFf1JL3ilnKU+XaDbqwPUE8L3vZwnv2K9584/BzZepsG5G3ua7kjUmCzWq18R8vp3+18cTFLyr2a2GPRZogbFPBmEeN+/DXf6ij1UGGGqY6Z3VSGc7pXaal+cd9ShzW+6FMr7zefsTaLqedS63urQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203582; c=relaxed/simple;
	bh=aCOsTbdYS7l7YKvpTPzBRY5W2Xr2yTf1nMxBeWepzaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM9QyWCb6rZrwi02eHe7rrSUb8FDdHVdWAN1AJIr6tU1zFHJRbXgId8qGrYpa2zhwR5V2OyEEIE4mfP0MZQl/q5tMxPn13LrDsYnOXOv8rycYK243ob9OTvUPHKFNKsIZVSLCyB4+3492jy1m3PrBKkasiI0mf6aSUyxmCRaE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emWRcZdD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emWRcZdD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768203580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyeHG2bmp2hg8UTb5cCJtNHC3HB2X906isScUNTz5Ys=;
	b=emWRcZdDHc5u1BFTkLRph8p0lySWVnlzaW/TjNNGt+A3VZ/esgMerj9Y3xq4/pi6DRGmJJ
	PSpobHBjgVA3K6IA9efczvRU7pUWvoQgJ/u8wej2lC5+jGwbVqzKAmIQ3oRw7i0piKsWF8
	zpmi0+XhTO/goUHzx+CXLVT2MEpGFxA=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-voxY-189Pryt7sScjfoD2A-1; Mon, 12 Jan 2026 02:39:39 -0500
X-MC-Unique: voxY-189Pryt7sScjfoD2A-1
X-Mimecast-MFC-AGG-ID: voxY-189Pryt7sScjfoD2A_1768203579
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-646faf19e49so9670752d50.2
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 23:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203579; x=1768808379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IyeHG2bmp2hg8UTb5cCJtNHC3HB2X906isScUNTz5Ys=;
        b=WGrPWdEb1FyFC9CZjRRPC8zjaJ/pDxqTMnXllNZA/2zrJlCtkWITG2OkUBTKxpxDu0
         Mn8DJoVTErDu41tpO06pzyPJVzx1JQv8goNaUJxaGEmHfuBX0z3MIK9wSbMzAO6I1/S4
         rkYMy7MLeIXZi9lbeKHSBJ3hl2izvpluTsVQGmAxpA02seWr3izOcGM0KCFDdh6KL7Zs
         OXdTCXPz+JbwEmpmXony03RBG0JX+6OgjkyGcHS+0omzkIxqkVbH6KZc4aSKfwckTWqL
         asX0DWoTZhaY2K45kr8fbT2O6o9937edthg0U1O7/jEnLIOVEkABHdbvtY3OYFx+0ufr
         92jw==
X-Forwarded-Encrypted: i=1; AJvYcCUkMPuKZt34Tm87+HeQfKfbjkJ2csKzUA/1AAdLWRPflHIWnI5D4SRSIk5wdWKGuKxebywkhzB/Gh0YcD2wHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8cbwjRUjp8x2WA1FDBG714xrze2Gitghxbx05N8cYphImaKhZ
	+aqRlDzqFuOsd5bLXI4aUAXJARUZZOeM+tGmkes9o+d/mzU2gEuzEPV7DsTqpH+xlg8dgk7JVY1
	HbAzrSsgl/C1DcNb35Ci2HE/ET+rIK6DXUAMvJ0idRHYBkvLswmk4TrRDjNrWRnEzrxJbiLK8yR
	xrzXLE4dLndD3EaApAMwPl6PU0YrVoG7+A7r8uzhjHraM=
X-Gm-Gg: AY/fxX6K+QuEpZIzz2/yaLtL7YB9hzHwqorWQOiyFqlF7Ou9NzPg41AdYo5rQxQt/vW
	E1OOoko3tSk8qWpuqLQeMDb72PKgszWX5Z8NPb7MWCVkK5xw6YnWGlGuckPFRZb//WA5D6vsJSq
	QK1+NDgiGCecf6xx36oayIWb66aXjTws7MfoMo+82d8XiGiYF3ACzik1v/hPV84sR+rw==
X-Received: by 2002:a05:690e:5cc:b0:640:d038:fafb with SMTP id 956f58d0204a3-64716c79f7amr10815797d50.64.1768203578682;
        Sun, 11 Jan 2026 23:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH78uSCqcmmqMSr2Bd7eagCfp4Rvm3vUF9h0Fs+ff5X3kxP+SksuinDK3RUXVS1hbfHpB1U3/lEnfv95Vh4P40=
X-Received: by 2002:a05:690e:5cc:b0:640:d038:fafb with SMTP id
 956f58d0204a3-64716c79f7amr10815789d50.64.1768203578400; Sun, 11 Jan 2026
 23:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-6-eperezma@redhat.com>
 <20260110184728-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260110184728-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Jan 2026 08:39:01 +0100
X-Gm-Features: AZwV_Qhsiq8BLMEwSZyRmK2zjNQi9K9xp-Rqb1AT7Z6w1C5ElS6HI9IuuizA3A0
Message-ID: <CAJaqyWf8Ad+SvGu9rucpC6Pop=W9c9GbUVMySmxbR5rcUnFQvg@mail.gmail.com>
Subject: Re: [PATCH v11 05/12] vdpa: document set_group_asid thread safety
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ow_M1d6yYaDe2kh5nwcTR8zn4NAWW0Zqc9ZESHFJ9pw_1768203579
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 12:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jan 09, 2026 at 04:24:23PM +0100, Eugenio P=C3=A9rez wrote:
> > Document that the function races with the check of DRIVER_OK.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > Requested at
> > https://lore.kernel.org/lkml/CACGkMEvXdV4ukZE6xhLL0sSN70G=3DAWVQgpRnH98=
Fr4btzMkK9g@mail.gmail.com/
> > ---
> >  include/linux/vdpa.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 4cf21d6e9cfd..cd1b1f1321b9 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -312,7 +312,9 @@ struct vdpa_map_file {
> >   *                           @idx: virtqueue index
> >   *                           Returns the affinity mask
> >   * @set_group_asid:          Set address space identifier for a
> > - *                           virtqueue group (optional)
> > + *                           virtqueue group (optional).  It's not thr=
ead
> > + *                           safe to call this function concurrently w=
ith
> > + *                           set_status.
>
> Let's be explicit about what to do.
> "Caller must prevent this from being executed concurrently with
> set_status"?
>

Sure, I prefer your version too. Rewording for the next version, thanks!

>
> >   *                           @vdev: vdpa device
> >   *                           @group: virtqueue group
> >   *                           @asid: address space id for this group
> > --
> > 2.52.0
>

