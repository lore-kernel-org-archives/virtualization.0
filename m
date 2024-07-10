Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F285D477
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592175; cv=none; b=AcpPG1Wx3yzBhEoMxsoSuMwoIqopUF41gnrOp163eF2INzOPjgFCj9OUw0NiB51tOOcWAvrGkaR0Ou0hhT1yR5qV1rTRZ7KRzmfRBdbijGFO6olL4wqY/2wsx8Wp1vmGwk9KtWB4tiVjUbAViZjgo6zLFlY9tPtGb33faQOc0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592175; c=relaxed/simple;
	bh=iHfMvlRCdeSCmCn+gosEI7hLv7yJDjDMkOnCUgrZe0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XBf3yrzuPOpRyNOk1Lckr+c2DlC0Q3uv+HhMXUbg0ajy8v5iQJs+jTacFySS8JtlGqiBLpc/uNsTnoGq+QvsWqwtfauj2TUSZXpnEujd74QitxNoLNGCXwnfzIwNHRUbn6zK6i+3VAhRWgyDMJL3a0VMORlPLOlJeaobCDJrjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKtbija2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKtbija2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720592171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nG64wpqZ5i6Hhdx10fctj8MX2Oe6BbD4hvrpu9U64kw=;
	b=JKtbija2p00mQvcPPSeIXrESA0su6wDdK4Wkar4/apcyCLSX8bX7676lLrRldaBvurQZX6
	3VLKw+7Y45tz9o08cCIpCcdVax9CXHtokQmEgSoDc9qaCiIc6u2dewvk3s5EFrT/BfJZkN
	UA6FEZ98jFEKFOHxyPEXJQi6tsp2oj4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-TAWB70lFNPCSAnNNW7p7aA-1; Wed, 10 Jul 2024 02:16:10 -0400
X-MC-Unique: TAWB70lFNPCSAnNNW7p7aA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42660bca669so21498815e9.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592169; x=1721196969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nG64wpqZ5i6Hhdx10fctj8MX2Oe6BbD4hvrpu9U64kw=;
        b=chAjNqC/U2ZMRxBAWA4A7cxQhRu8XGfxdKhTPs/WiglV1zYk/Gvq8XRxZz1Nx/oCcb
         Gyd+kRiuqw30kTU7iyg6ls2BNNsbSCW13UbTEL/cJFjHGfhorO4G9GEjkV0zoH9v9K6K
         nSa1ocNj2hcquqWZ/y/7eCU65MNA9y4vRCN0uxxeumxwlGok3TsmArsT4Gct7hW29a2A
         2Do+CAMODRlBdzc9T9WVVReG9q9wh2gNQKDKDQOypR2kkc9F+XmwPg18T+kwTgyi/f8E
         +9Ih1UA+dv7cFYZ3XMvEbqPjxpTUTcaCkrz0a3/XhR3BPgeKHZDu/MpOpNzl5kDJRPMl
         1RxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW738dDGMTsVPI9mXKt5aXYvCIZfNRwcVBwmUW6rt01ALCobCscHkI5vg4E9mU3PJnP2tkUcmqQIdRJKcK6tqS7Dxc13d2iAzSuBwP5e6k=
X-Gm-Message-State: AOJu0YzVE8qLOZt+VldNZfjE/WkEctXnbHNq3rsxWojKqMtkiCLVdHqW
	GsZ3pDDx0B8tV9RpEjvKvK+yUmQz0pGyoSE9fHs6cq/koV7JeFQO6ZGGiCKPFQScBxjFMLK9moT
	Syp7LUg2eQWqzlkFvWIHbJENjLYpyMHHaTIVFdSd2E31YEOIAvIS4fq+f29GDVQlD
X-Received: by 2002:a05:600c:230f:b0:426:5fcf:5e89 with SMTP id 5b1f17b1804b1-426708fa1d5mr31680615e9.33.1720592169242;
        Tue, 09 Jul 2024 23:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGogtW/P5GMJqkRp473befh8IMF5KbwpHPgee+YwSI975xbMbt5re21Dp6bt8On+t2r/Lcfnw==
X-Received: by 2002:a05:600c:230f:b0:426:5fcf:5e89 with SMTP id 5b1f17b1804b1-426708fa1d5mr31680405e9.33.1720592168524;
        Tue, 09 Jul 2024 23:16:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266a38f5a5sm104671615e9.43.2024.07.09.23.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:16:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 02:16:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
Message-ID: <20240710021441-mutt-send-email-mst@kernel.org>
References: <cover.1720173841.git.mst@redhat.com>
 <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
 <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 10, 2024 at 11:23:20AM +0800, Jason Wang wrote:
> On Fri, Jul 5, 2024 at 6:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > QEMU implemented the configuration
> >         VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
> > incorrectly: it then uses vq3 for reporting, spec says it is always 4.
> >
> > This is masked by a corresponding bug in driver:
> > add a work around as I'm going to try and fix the driver bug.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 9a61febbd2f7..7dc3fcd56238 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
> >
> >         err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> >                               callbacks, names, NULL);
> > -       if (err)
> > -               return err;
> > +       if (err) {
> > +               /*
> > +                * Try to work around QEMU bug which since 2020 confused vq numbers
> > +                * when VIRTIO_BALLOON_F_REPORTING but not
> > +                * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
> > +                */
> > +               if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
> > +                   !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> > +                       names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "reporting_vq";
> > +                       callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = balloon_ack;
> > +                       err = virtio_find_vqs(vb->vdev,
> > +                                             VIRTIO_BALLOON_VQ_REPORTING, vqs, callbacks, names, NULL);
> > +               }
> > +
> > +               if (err)
> > +                       return err;
> > +       }
> >
> >         vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> >         vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> > --
> > MST
> >
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Do we need a spec to say this is something that needs to be considered
> by the driver?
> 
> Thanks

I'd say it's a temporary situation that we won't need to bother
about in several years.

-- 
MST

