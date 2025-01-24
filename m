Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337C1D54E2
	for <virtualization@lists.linux.dev>; Fri, 24 Jan 2025 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737681311; cv=none; b=Me4afAe+FB+jBA64hkVbgR5+vDWgAOPr2fZ/9qGkSkpG61Miaw3mSRALHJkL0DZp96jMt0fm3lzAbLybntUVyiYuYUeRaaMSS5Ce1ikj0yUOKZfh+VD5RxGIHVJ1GERktYrO35gcKD2Y/a6+5hC00ezy5cXRoIB4iXPGEjJCNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737681311; c=relaxed/simple;
	bh=wVROqD729UaIhKFsEUWh98t7SuHQX1Dmhx5pBp/PPu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Qb63QMar8i8e2v0rWFMMm6YFcgb83YBH6WCxKp3C5RIjlp546jBl27GzY5So91A45ocLkdtrWfGLxbtA8dsX1DBgoGQLSMp3zJvVpHlhir9uVJP9tZ7L8KoEgy1yKL56/baESQ+q8vhzD6jPXqckME8+/tG7e1qA201VYChjDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h333yGq6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h333yGq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737681308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILIsXvqrol1mCP2F1LpFSlYC1lZdeh26s+qA/ldD0XQ=;
	b=h333yGq6ZAgSdJoa1ZIPLSQmFHwBMW29ViN1QnE1gf955uiTGPpf8aduH8saELAB/3pT8O
	ta5mHbMd1QZlTvTSm7qYD8BppgM/vKEfrXKMChfL9lYJygGo7/EbXj+3Yfz+w3fOpi0Dgy
	dGYWuH+Hx6yv6k07WhylOUBXrjETxG0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-AgX6De-rPB2j5B8aHgne-w-1; Thu, 23 Jan 2025 20:15:07 -0500
X-MC-Unique: AgX6De-rPB2j5B8aHgne-w-1
X-Mimecast-MFC-AGG-ID: AgX6De-rPB2j5B8aHgne-w
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-8621eb99b63so355310241.0
        for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 17:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737681306; x=1738286106;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILIsXvqrol1mCP2F1LpFSlYC1lZdeh26s+qA/ldD0XQ=;
        b=VMtr8f4N8+raZTirfywoC/uS3zF81EtwiGWB2Wc4Ui/CoG25FNHpwvzbKTJj07RbOC
         +fP28qbR6xcO2GY8E3mwASkfnMtSuCyJNwkogIy+mcncVL0W9Hd/4HfCui8e/yYPdyA4
         AmsjcycctvkjvkN2+nZ2l8C0bWm8WE0TUw83gX3K/FLth+HCJkAXEZKcgo0ArBzfk5tY
         u4gbLRvvJaUshyTTHh019lRDoOH5WFML9VaodACgJGHkJTUBWllBJlE4OxAVEcc3IhRX
         Mom+U7oG8toKMjbgieFMj2jqfTexbXdFjNJJlZBelzQLAM5sYm+g2KsBAfwXvJ6JmjdD
         4L0g==
X-Forwarded-Encrypted: i=1; AJvYcCWUxb3Ci9gK7XFV8/OJBYxZABoL2UpU6UBb9kWYVJmJsM7IX2Hjed2wpZN+LKm29tKGcsaTifcGjBhqlNn6dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfcdsyjsVoilXJnc672Sou0OJFUdBhjvMcDLZxoc4Z2HOtuD9W
	9UnL4IhpG7nMXLRam/BGboe9wLZe90AT0DYnJW48pv5LqSJ8FUb67YG4SneA0Pn4XONISxd3Wq6
	rrtZAf02DOt4lU4M//qW7sRdb2gIfqTvYwDGh8vv70HH8nvkm5h7u+eghbUhM9eatoNsRTrbsxX
	0LDo/+wrLWtAzW18JfHqfbWwTlSzifc+e1ojCduSE=
X-Gm-Gg: ASbGncs5CcuiZV+p/WHioVPuq9GdoCkI50RJNT+qaHeIhnU8ejau2ZxgPqesAc6IbjT
	UvP/AcrdnC5MyWaUncpYagTuBmwfElDCVIwZmeIbgy0K6UgfVpQ==
X-Received: by 2002:a05:6102:2acc:b0:4b6:20a5:776 with SMTP id ada2fe7eead31-4b690c85364mr24491190137.17.1737681306439;
        Thu, 23 Jan 2025 17:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmj2b1Q22f7IVZGtn7j/OIq3ocr2h3rVfbq4tFeu7iIXYoOR4qRTK92z0FMdl7Wq1NkyApn1WAx57UKSWxzGo=
X-Received: by 2002:a05:6102:2acc:b0:4b6:20a5:776 with SMTP id
 ada2fe7eead31-4b690c85364mr24491185137.17.1737681306109; Thu, 23 Jan 2025
 17:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2> <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
In-Reply-To: <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Jan 2025 09:14:54 +0800
X-Gm-Features: AWEUYZkiA2ikm4-7dgBdOU4NH0-wOsctvcu4K-HiEMYrTZ53Ng13lMg9gKspi20
Message-ID: <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue mapping
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, 
	gerhard@engleder-embedded.com, leiyang@redhat.com, xuanzhuo@linux.alibaba.com, 
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9esP7CuiYlAexyZWUTydC-SiFnaXYX9pJwdrGAiLqIo_1737681306
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 10:47=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> > On Thu, Jan 23, 2025 at 1:41=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > > On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fastly.=
com> wrote:
> > > > >
> > > > > Slight refactor to prepare the code for NAPI to queue mapping. No
> > > > > functional changes.
> > > > >
> > > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > > > ---
> > > > >  v2:
> > > > >    - Previously patch 1 in the v1.
> > > > >    - Added Reviewed-by and Tested-by tags to commit message. No
> > > > >      functional changes.
> > > > >
> > > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 7646ddd9bef7..cff18c66b54a 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue =
*rvq)
> > > > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > > > >  }
> > > > >
> > > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct nap=
i_struct *napi)
> > > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > > +                                  struct napi_struct *napi)
> > > > >  {
> > > > >         napi_enable(napi);
> > > >
> > > > Nit: it might be better to not have this helper to avoid a misuse o=
f
> > > > this function directly.
> > >
> > > Sorry, I'm probably missing something here.
> > >
> > > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> > > in virtnet_napi_do_enable.
> > >
> > > Are you suggesting that I remove virtnet_napi_do_enable and repeat
> > > the block of code in there twice (in virtnet_napi_enable and
> > > virtnet_napi_tx_enable)?
> >
> > I think I miss something here, it looks like virtnet_napi_tx_enable()
> > calls virtnet_napi_do_enable() directly.
> >
> > I would like to know why we don't call netif_queue_set_napi() for TX NA=
PI here?
>
> Please see both the cover letter and the commit message of the next
> commit which addresses this question.
>
> TX-only NAPIs do not have NAPI IDs so there is nothing to map.

Interesting, but I have more questions

1) why need a driver to know the NAPI implementation like this?

2) does NAPI know (or why it needs to know) whether or not it's a TX
or not? I only see the following code in napi_hash_add():

static void napi_hash_add(struct napi_struct *napi)
{
        unsigned long flags;

        if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
                return;

...

        __napi_hash_add_with_id(napi, napi_gen_id);

        spin_unlock_irqrestore(&napi_hash_lock, flags);
}

It seems it only matters with NAPI_STATE_NO_BUSY_POLL.

And if NAPI knows everything, should it be better to just do the
linking in napi_enable/disable() instead of letting each driver do it
by itself?

Thanks

>

