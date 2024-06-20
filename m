Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565A19ADBF
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872672; cv=none; b=pgGyiHahMQ0wzgKo+UDMznxFNtUg1AeLu6NEriyIB9PqNoUYMi4/BG5aLVg6tRxxIGnJz9u1GwY0bFvnznj/I/S5dDU6V5OZe6sDiHAdYPg/VExfvzLRU7ipy4nqdRdIEFBPXRpL13z+dyxBnFTu9+CiCoJGtVNPnZltHBeKmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872672; c=relaxed/simple;
	bh=bPdIpzcTTvLFCUgmLkJzuvuzlJSVU3NMUPwui9LPBWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4BD8J4NYeXg8aNso295/AgX1iC2WyWyYm0jneN+eGFZEidvRwN7UVw+eEEw1yoFNLvebTRzI/IjdnuFL2rb2m9fMoNk3HbQFumh3Qj+w3pb10bkvaNGMfYID9hR9nkGPZq86TPlSe9nYoX/snL1ShzxhhOI6V8xMBa0QDJiCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAFe/+YM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAFe/+YM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DiWfvytz7+zAvxiDWnyDm8IkadAMsfzl6Hj18xLwCY=;
	b=JAFe/+YMYyisWEjbwcrLiYmaJu75UsunhTRUJCI4VsbfxifIpui7q56s8tQqrDSmfpqJyb
	w4xVnC9ZNYs2YbemBGF+nBlBzOP3IL+xbXnAUX0XZMtByIGZ2QFLPmFyFw1blJ9ig0zJKg
	nbnwlIoIY3zXDicJnlumYj2AvoTZ9rY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-l3SBWJXtMoeo2FkFahR92A-1; Thu, 20 Jun 2024 04:37:49 -0400
X-MC-Unique: l3SBWJXtMoeo2FkFahR92A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c24109ad3fso759107a91.0
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872668; x=1719477468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DiWfvytz7+zAvxiDWnyDm8IkadAMsfzl6Hj18xLwCY=;
        b=V2wQK/O1n49KoaF11Go5OphOvrcpWjwkMqR6F8RxKtaXqkk9PwHgK2kXOco0GriQeQ
         6WscWIg7bsi9w0XQT4PF8JNUSXsUUi8Hcnc2I1KhN8B+aZlotgtVXjF7P05G1/KyQBHi
         SHm2HgV06yGQEC2cpQUXuKLpjzbh92jPKsifLWgUCTucDw+5vOvvdtGeTshohn6XWe9h
         7hQsysVADRS1OrScUZzYQiGLrW7uflSI+PHX3rSg5RoRL/bqVsdP48sbBanX46bmQ6qX
         jP+6at66JDsotQs00Hxhj3QseyKGmE+nyy4xnx7CgNnVp6Dh82lGM9YPptEW+eiSTAu4
         9ccQ==
X-Forwarded-Encrypted: i=1; AJvYcCUChrg9o4KJsuQ7MojR3KG4VJAi7lZicYF/XUELSz0/hKjOg+UVvyfmd67Jbqvbxdca8eTEelP8KLzgmXGLkmUEsZ09T86n7RMh3jQOI/0=
X-Gm-Message-State: AOJu0YxNoowLO4zBEf2Iv9Mn1gMu2zgh9JE4cVLySECvR5N4XNUkqEA3
	RaWTGxUf5W51Sz8uo9RB6bXG+IhLuV8W9OtiDGvuerCr22wW/MB69mZbXaORxREo2eqPaGpqEHI
	DPxnhG+DSoeSB2op+idhFGZepoqOKAeuZTxKxgx4gxswFHZr60pHWBTCicbZ0yExgRH4IE5k60M
	G1vcbB5gSYm9R/z+WeKXhDuqB0RsTrD/D6EbqAFjo=
X-Received: by 2002:a17:90b:97:b0:2c4:aa3d:f1e8 with SMTP id 98e67ed59e1d1-2c7b5b06d60mr4701795a91.14.1718872668039;
        Thu, 20 Jun 2024 01:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvcQbwZkBFWFg/wUVEago0naLsiGLej0AP5gvBK9V6HQqUy/HV6RVsNb52ScnI/bw0YjoaVa4aCEvkfIZRIC4=
X-Received: by 2002:a17:90b:97:b0:2c4:aa3d:f1e8 with SMTP id
 98e67ed59e1d1-2c7b5b06d60mr4701774a91.14.1718872667609; Thu, 20 Jun 2024
 01:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com> <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com> <20240620034602-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620034602-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:37:35 +0800
Message-ID: <CACGkMEsCQOKyzR9tjkN=iTiqmcHeOOmuFKKcL2rLA1ENYYN02g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 20, 2024 at 03:29:15PM +0800, Heng Qi wrote:
> > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_in=
fo *vi)
> > > >
> > > >   /* Parameters for control virtqueue, if any */
> > > >   if (vi->has_cvq) {
> > > > -         callbacks[total_vqs - 1] =3D NULL;
> > > > +         callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > >           names[total_vqs - 1] =3D "control";
> > > >   }
> > > >
> > >
> > > If the # of MSIX vectors is exactly for data path VQs,
> > > this will cause irq sharing between VQs which will degrade
> > > performance significantly.
> > >
> > > So no, you can not just do it unconditionally.
> > >
> > > The correct fix probably requires virtio core/API extensions.
> >
> > If the introduction of cvq irq causes interrupts to become shared, then
> > ctrlq need to fall back to polling mode and keep the status quo.
> >
> > Thanks.
>
> I don't see that in the code.
>
> I guess we'll need more info in find vqs about what can and what can't sh=
are irqs?
> Sharing between ctrl vq and config irq can also be an option.

One way is to allow the driver to specify the group of virtqueues. So
the core can request irq per group instead of pre vq. I used to post a
series like this about 10 years ago (but fail to find it).

It might also help for the case for NAPI.

Thanks

>
>
>
>
> > >
> > > --
> > > MST
> > >
>

