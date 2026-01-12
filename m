Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD535770A
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219802; cv=none; b=dzlUnW1JmGBJpXZ7XvMvaYNaASbjq4waes9C1ES1SgXgMbdTjpGCjbwZhhqkJi371UIbSYU6B6ym4GnD0Nrxo3Lpnn+6jIiPEZCJYljaVfPHQUsQfZfqMjbZ04AUb+PTfP8hgp+R+ycv0OYSVAyQqT0G5EF9WpQq/bGylGyDESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219802; c=relaxed/simple;
	bh=IHK9UFaWjR9zl6O4eQyCMxzOLpcpyqblvD2L9YfjGs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOCTx7ZVJkopAcmNyogc5rSWjvOeswAQMd+/Ml7QC1FzwrSOqQCFo94pmmg27N1oUlcpVvciDruIWwn9vM+6u8rg7w7ESlKedxLrgjUcuXBTzyDjlgwocHIkMZB8Ymgu0+DSZAjsFNHTv9C2d1rvQPE/952YgZ8Vy/KFlMh7MSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT/TwLEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT/TwLEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768219799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcTwmbBIDr/S+4Qu8Fixqc2LgZZzz1F/x8NlXacYz60=;
	b=AT/TwLEkiHiim/PnoQHP/mdm814JAk+rd1yEXpQOqdT1mf18R/ShYyffRhEcO8XQ+hfIJQ
	uNc1bN/vxmffvb3hf4Nrshu4TtpzkU3+w5gVXxZOMD5kD9m1yFR4U7gSxjLLHk4HiVGl96
	/kVto4ddkSL1LlGuelp6Bnhsq7uCS2U=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-TxHu_edLOIqFRR5M_gObJw-1; Mon, 12 Jan 2026 07:09:56 -0500
X-MC-Unique: TxHu_edLOIqFRR5M_gObJw-1
X-Mimecast-MFC-AGG-ID: TxHu_edLOIqFRR5M_gObJw_1768219796
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-645535ac027so9275312d50.0
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 04:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768219796; x=1768824596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fcTwmbBIDr/S+4Qu8Fixqc2LgZZzz1F/x8NlXacYz60=;
        b=aqA/KAvYnSutqd7qxEtYOm/oERaG1+W4MSVS7CvwAqoTfaH/fVw093Nhj3d6aWOWzu
         zr6muMgE0/uRh9YqeuWA6fLBV/jKdIqDHUF8nhe8vMW2F1oVbFs7NreG/kqTpKzPVzBB
         mxuYXV+lA52ttl0Ih+/tg/6aSLfY65RsGA5icSm1ZPwpg9aTREKdN2qk8veFver+dWcP
         +ZNJDEVIDzr1to214MF24jmlUvINsS4rVEwtcS1rOWBAFy4/kqAxKEHdR2Mp676G6mJu
         9Mqg5OIxJkk1ZCd2vGdLNwC3wMLKAUHkoMmoI20qUNNFyRrOled5/GFhyayeAyiHG29y
         jgng==
X-Forwarded-Encrypted: i=1; AJvYcCWcE/QyA3WbZJvbTGLli19UkHSPMeFAyutUHq/M4JslnK+sCYh2FIM/fI00exXWdfi0dzzblm2E2IaCpetfrg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznix1RcdyBHCzcRXtItp0pn4z1eZnOdbVGoaS7jFDKMS3s4Yxn
	P5TohPTvjcbKpqND9Z6oZfVjNQF5hWaiAbQgbQkKBUyxil3LufX/VOt3LYxSY3OVCH4WXAM8d/a
	UGaQp6vQQEnb/0GPTTxe79iYgkQu6ajkhPBLZnwkeagc/MRE7SBrnAVHke8iULv4amLdCnBUTZD
	EbIEYJf58muEMJ5p4ldoZQeLFbzVhpWPIqVUXLYfhQD/U=
X-Gm-Gg: AY/fxX6hAxSs59f33/R4w+oXQYX/b+QX71sphpvyvk65+X2ZSYJuSt88tQ9OM1pOmZi
	odtU2jcKHqrokBm9JGtnTXHGUmdp+KlZeHE3kSdS+OLx3L8YuJ46K7U5TqbY7AOsyA/pBNh3zyu
	pcDrlpsEQzThc5s4EZ+ZQROXCHqmH9z/QVHj0ZY+jtjvYa/lXwW1OnDKiiXKDG4M5NEw==
X-Received: by 2002:a05:690e:1c1d:b0:646:bb17:1515 with SMTP id 956f58d0204a3-64716abe6afmr14860271d50.19.1768219796131;
        Mon, 12 Jan 2026 04:09:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAbyL1dZjiFAFD5Y43BeIwK0NHX/Hdz+RDWjODWVTWjX5Akk3GY2AgFc+8/0UHpFw3sg0LdKOm8OHj80czal0=
X-Received: by 2002:a05:690e:1c1d:b0:646:bb17:1515 with SMTP id
 956f58d0204a3-64716abe6afmr14860260d50.19.1768219795778; Mon, 12 Jan 2026
 04:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-3-eperezma@redhat.com>
 <20260110183910-mutt-send-email-mst@kernel.org> <CAJaqyWd4VZaqA3E0NCeCH6ur1q7stu1HgHTKEv5hjRQ=eLn+uA@mail.gmail.com>
 <20260112025737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260112025737-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Jan 2026 13:09:19 +0100
X-Gm-Features: AZwV_QgDWkrR5jBZxeIfoao_pC8Q89bWcq5zM9dWwTcJqDrxyeoKapncbwEcD50
Message-ID: <CAJaqyWd1GjE5SqRi2kmbx=4qxRifvk6yiR8BOpEd+B3FqN3C=g@mail.gmail.com>
Subject: Re: [PATCH v11 02/12] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 38l1gK93i_RrUfWyZspYDFR_z6aU98KN8xIavQjwnEo_1768219796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 9:00=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jan 12, 2026 at 08:35:37AM +0100, Eugenio Perez Martin wrote:
> > On Sun, Jan 11, 2026 at 12:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Fri, Jan 09, 2026 at 04:24:20PM +0100, Eugenio P=C3=A9rez wrote:
> > > > @@ -1252,12 +1266,24 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >               if (config.index >=3D dev->vq_num)
> > > >                       break;
> > > >
> > > > -             if (!is_mem_zero((const char *)config.reserved,
> > > > -                              sizeof(config.reserved)))
> > > > +             if (dev->api_version < VDUSE_API_VERSION_1 && config.=
group)
> > > > +                     break;
> >
> > (Bookmarking the piece of code above as [1] to reference later)
> >
> > > > +
> > > > +             if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > > > +                     if (config.group >=3D dev->ngroups)
> > > > +                             break;
> > > > +                     if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > > +                             break;
> > > > +             }
> > > > +
> > > > +             if (config.reserved1 ||
> > > > +                 !is_mem_zero((const char *)config.reserved2,
> > > > +                              sizeof(config.reserved2)))
> > >
> > > Hmm but if api version is 0 then group should be 0 no?
> > > We should validate.
> > >
> >
> > The check (dev->api_version < VDUSE_API_VERSION_1 && config.group) is
> > above this check in this set of changes [1], am I missing something?
> > Would you prefer it to be reordered here or written differently?
>
>
> Oh you are right. It's just not very clear that everything is covered.
>
>         if (dev->api_version < VDUSE_API_VERSION_1) {
>                 if  (config.group)
>                         ....
>         } else {
>                 ....
>         }
>
>
> would be clearer.
>
>
> BTW I don't really like this idiom of "break to return".
> Just return -EINVAL would be more explicit.
>

I agree. Maybe if I change an entire case block I could move it to
return style in the future, case by case. Would that be ok?

> But this is the way current code handles it, so I'm not demanding
> it is changed as part of this patchset.
>
> --
> MST
>

