Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84768272803
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869206; cv=none; b=PES6p3r/7KE7KeaYRme75sSNM2nSMXfbd/onc4g+62xg6PuPKJIp9/VyIAhN9oegbNy6BkDiEx2tkyJQJ5Hz4uONTTVZBPnWdxwAOFeTbpHzSFk1QntkGmF8kvedGV/bC5Yuq0M1X1u/84at6W1Bnoif9fJfyqHFxJFVo3LtTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869206; c=relaxed/simple;
	bh=XMHugQRV8upAY2qAFOtTHC5h06Ia39RID/0cXKLd44M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8yGZrSO35/ef6cT8Tu7vD7a2MUqoQsnnDkb3KS4d6qIM/vtwhBDfYMmvlncGJmoklbR/QRk4vkvv0mIC++h8ytDZmzS7U1BpvnDzlU6YkN6jbMLCJjemNEydkA70xNWU2Vmvg8Ktmr0+EOR23ZhiTyZMle+rtmASV6tvwWRUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqcRht0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqcRht0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756869203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xol+alIBvLCv0kDjUEFNYzYfWJLZoeFZJYHsWzrrfsI=;
	b=VqcRht0uShy+KAdFJropD2bhO1EIMTIPiVRCsZ2QUgANksYIoY5uw95Z3/4tTB7iwLako7
	HTStvgt+OGv+5vloQh4dsIJLu4v+UZQAoNdwui0p1LJYISr+7joSLVR38sJS5LIMrjnorA
	syzXoI1U5N7BYwZscLq2J3tOKLbe88I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-LyCXTYpnNoSB8S35Z-my3A-1; Tue, 02 Sep 2025 23:13:21 -0400
X-MC-Unique: LyCXTYpnNoSB8S35Z-my3A-1
X-Mimecast-MFC-AGG-ID: LyCXTYpnNoSB8S35Z-my3A_1756869200
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3276575ae5bso6313754a91.2
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 20:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756869200; x=1757474000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xol+alIBvLCv0kDjUEFNYzYfWJLZoeFZJYHsWzrrfsI=;
        b=UUPXKa7Q9QvJJt0lp6yxDRlXM0c9R/uC5/4akLUuurw4+B/PtHOBz84hlLxX1O3ILl
         kcFkoiOAlrJhW7cezGP+9Qjwdmul7YX5S2OJ2R9FQB1+WC/TdcLTT84jBWheyH5M1qLM
         PFC5V/W8GwPXR6nZc9u5mLOIdI1BEY+lUQDWppNkTNIR7HRshS0qJCVR8DYpNyBCs/Hl
         HX+3UQh3iwJeLNhS9bVS2zt92VMn6TFbM3bLeM+uGuC+LxEyWNY2Z9H9/M4LRPAivctG
         ge8+4+Rqp1U/XVQ2UvF1JmikB9e5XHGs182HJzPFThnHsNTpVU9vftKQHlOkIKEGvodd
         HQHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY9eULZk+H6z96m8DkKfS2P7HOF5q1m4Qgd0L2arr6IZMQvtzJzptE4IKtOc3QCRZNnvKzOIA0QXIhY/niEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyV+C+CgHYk8xLMNaDuMVmF7phomtsYJKUL9LBy+nW/XTLuYy4d
	F7zsWPL1H0p51hN95ie5zRxq5evg14676/KZjLyvYgmjDGVs1Pa7QqcxlTHC24IJ+D8tL35RcJ4
	NAfh6hkXKYYJNmtKfsL+iTmL0f0wUoR3YmBrF1MEsidg3QYVc9fbvL+24hlNww2/QaFYBpbjGS0
	XK4/FkCSKGr17AZeSY/IjSyB9ymQOffbkx/VhVffairlo=
X-Gm-Gg: ASbGncuy9+0I2Y7JrGBQviDCwTLe/Q5AcuzXfa8GnQmgQLMuH6LOny0W2LL0rEbpx2L
	nVc38gM/C/BXesNHBI+zN9sen9pBVDWEu979r+3tcXkX0GRvCyQjD/R38aQXD+I3vMk4tb55ni3
	THQ94EXBHCTx8ZuRRwzx4LAg==
X-Received: by 2002:a17:90b:5867:b0:327:fd85:6cd2 with SMTP id 98e67ed59e1d1-328156c623emr18214876a91.24.1756869200498;
        Tue, 02 Sep 2025 20:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTcvOJVfQMP9AtXeCfqc3GqOtFGl+2YHKFjgvAyMuI4oaGeseIgP7UAQtunJbi2+5RUMMF8o50W85VET7Ldak=
X-Received: by 2002:a17:90b:5867:b0:327:fd85:6cd2 with SMTP id
 98e67ed59e1d1-328156c623emr18214850a91.24.1756869200081; Tue, 02 Sep 2025
 20:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-2-simon.schippers@tu-dortmund.de> <willemdebruijn.kernel.6b96c721c235@gmail.com>
In-Reply-To: <willemdebruijn.kernel.6b96c721c235@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 11:13:07 +0800
X-Gm-Features: Ac12FXyivnmUX4HGcNjFfQl5uUVCs0KxooT46aj1-W0YWPU72YBI_ajqRuEAnwE
Message-ID: <CACGkMEuE-j0mwHUvDg9uocGCG78HAX4oCXVbt-YS7t5G1LTPfQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ptr_ring_spare: Helper to check if spare capacity of
 size cnt is available
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, mst@redhat.com, eperezma@redhat.com, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, Tim Gebauer <tim.gebauer@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -JEkKueqYh9ov0LXZvly7zWIAfXPtb694yl3XaMgAjc_1756869200
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:13=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Simon Schippers wrote:
> > The implementation is inspired by ptr_ring_empty.
> >
> > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > ---
> >  include/linux/ptr_ring.h | 71 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > index 551329220e4f..6b8cfaecf478 100644
> > --- a/include/linux/ptr_ring.h
> > +++ b/include/linux/ptr_ring.h
> > @@ -243,6 +243,77 @@ static inline bool ptr_ring_empty_bh(struct ptr_ri=
ng *r)
> >       return ret;
> >  }
> >
> > +/*
> > + * Check if a spare capacity of cnt is available without taking any lo=
cks.
> > + *
> > + * If cnt=3D=3D0 or cnt > r->size it acts the same as __ptr_ring_empty=
.
>
> cnt >=3D r->size?
>
> > + *
> > + * The same requirements apply as described for __ptr_ring_empty.
> > + */
> > +static inline bool __ptr_ring_spare(struct ptr_ring *r, int cnt)
> > +{
> > +     int size =3D r->size;
> > +     int to_check;
> > +
> > +     if (unlikely(!size || cnt < 0))
> > +             return true;
>
> Does !size ever happen.

Yes, see 982fb490c298 ("ptr_ring: support zero length ring"). The
reason is tun reuse dev->tx_queue_len for ptr_ring size.

> Also no need for preconditions for trivial
> errors that never happen, like passing negative values. Or prefer
> an unsigned type.

+1.

Thanks

