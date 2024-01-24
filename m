Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADF1AAD1
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095382; cv=none; b=rPA9PP0Yp6OK+faQdOLIsB5cwfx0ArfS5spNVhe5tjyfTnugWwfHyqDxX2f9n/GaZ6ZXGjlSxFAT3QJPnjDRtRuQkYB760TqVQOQtUWseZ9hVhwq7rSvs1K8m8HH05b83lMsxb4Xcnaq6XRd38CgvVbK20WAOYhomO/9ZH0+VpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095382; c=relaxed/simple;
	bh=ZzIGwtAn2QzZ+2GpJ7X6yrHuHp8dp5kYFExvtnM8l2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8N4/nM5Odnbi1rZbP8kmEFBS6ngtlsQeavdmUKramz/VJBmEegI4MOb0y549sl0RuvMvmPAGSojube9kL4m0PJkQRtS0WOoXgE3kgCznHyDE3kUh7qfZn7gELhLUif21jH1sejijBY+3JyIKTD9L44Ba1NiS1MXDM1ItDSobzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBa2Jk4t; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBa2Jk4t"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd2f472665so55487301fa.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 03:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706095379; x=1706700179; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlGnsP1Guq+73aimmzzt0YePXReMuB30joC9rhAKutI=;
        b=HBa2Jk4tuW35mwBe9d1mnKnBo3YABQsZjXx1DAkgiBleQUtG9zJPfSEtQFoVzvTNZv
         oVJNgIssMEdEpiV6Mm9r92s8fv6aOfQOM9h/MhjSOZZkfHDOWF4mFbY2Fou3VwdxqUqR
         zYcd9Wa787Tnzoc3aJ1ycoeUtBkbh2pjTS2VnWI3D3EoMjo9dApHuBSsJcZ5FESo772q
         hITfV/sP6PrXDrA27LXgO2qCdi/6tUmkbaepGXiov2LcDYPNFKFRID6vsKzf0XMv6c8F
         vXzTOMY/9zecwewUwJI5vJp6EwnRrxg1Vp4DCG3UMVG8Q+x50yhQyHETZr0Chm/lDfzp
         pNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095379; x=1706700179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlGnsP1Guq+73aimmzzt0YePXReMuB30joC9rhAKutI=;
        b=V+xPcvYI12xyJjHLZ75h6fHgh7YB4D6jiAPhkJhc3yf4FRthXhe+h8l3oC85WE64pd
         +eYIQYCqZf1M6k91Ne5VT0eJ1LPHKxSKb+NMCjFEM4XWmNsKxxpXHSfbLaNW1ZtZkwi8
         v6oLonh9TNTzLHaVCTqS/ZMOdbj1tjHxJjWHk61JQ3UiqQ9p9IIuXSJOIQdjaIDNVMYs
         hmfOgDG3frPLu8gfwbW0uJJvVRPDMXTCA5L3EOI6geAU+JpkpPsQ/blh3puSeimPFodp
         oxTQWG8jLe3z6qnzfRGg2BCo2lPDyR3Q3nEaErEnfyWx4RJdGhj7w26GcfUHULK1ZXfU
         ydGA==
X-Gm-Message-State: AOJu0YwGE+kYvaqxCyT8/Iuq+pQQbbXbQ2regokXhPamqE1CzFEDMj4f
	G6uR/+nryJC9D3+1x1umloI7NVNRPvvwEh30PJLjqfd3fOi12bU+pRc6umt6In+KAGLJq0WerMK
	lrdsssq2YjOuL76lkDjCZ6IuvaRM=
X-Google-Smtp-Source: AGHT+IEkb3Xpt+58vOiWxG6JhAbfK2iGy3KLOjaay+O2w7JwGWLv/HZUJ/QgwApQxLQVRQ6d1ibzMMIw8aMxLzlr/rQ=
X-Received: by 2002:a2e:bc25:0:b0:2cc:e51c:4d0c with SMTP id
 b37-20020a2ebc25000000b002cce51c4d0cmr974155ljf.66.1706095378493; Wed, 24 Jan
 2024 03:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122110722.690223-1-yi.sun@unisoc.com> <20240122110722.690223-2-yi.sun@unisoc.com>
 <ZbAQLRLNSx-IRRwM@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZbAQLRLNSx-IRRwM@kbusch-mbp.dhcp.thefacebook.com>
From: yi sun <sunyibuaa@gmail.com>
Date: Wed, 24 Jan 2024 19:22:21 +0800
Message-ID: <CALpufv1XRYX7bv-NAUMmRjWr0jhDC1xrd+d48XejJZPjZZLEYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_tagset_wait_request_completed()
To: Keith Busch <kbusch@kernel.org>
Cc: Yi Sun <yi.sun@unisoc.com>, axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In my case, I want all hw queues owned by this device to be clean.
Because in the virtio device, each hw queue corresponds to a virtqueue,
and all virtqueues will be deleted when vdev suspends.

The blk_mq_tagset_wait_request_completed() function can ensure that
the device has processed all in_flight requests , and these requests have
become the complete state. I don=E2=80=99t understand the blk_mq_freeze_que=
ue()
function very well. Can the function ensure that all requests have become
complete status? How should I use the function to achieve the same effect?

ps: requests become in_flight status in virtio_queue_rq() and become comple=
te
status in virtblk_done().

Yi

On Wed, Jan 24, 2024 at 3:14=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Jan 22, 2024 at 07:07:21PM +0800, Yi Sun wrote:
> > In some cases, it is necessary to wait for all requests to become compl=
ete
> > status before performing other operations. Otherwise, these requests wi=
ll never
> > be processed successfully.
> >
> > For example, when the virtio device is in hibernation, the virtqueues
> > will be deleted. It must be ensured that virtqueue is not in use before=
 being deleted.
> > Otherwise the requests in the virtqueue will be lost. This function can=
 ensure
> > that all requests have been taken out of the virtqueues.
> >
> > Prepare for fixing this kind of issue by introducing
> > blk_mq_tagset_wait_request_completed().
>
> Does blk_mq_freeze_queue() not work for your use case? I think that
> should work unless you have some driver specific requests entered that
> don't ever get released.
>
> > +static bool blk_mq_tagset_count_inflight_rqs(struct request *rq, void =
*data)
> > +{
> > +     unsigned int *count =3D data;
> > +
> > +     if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > +             (*count)++;
> > +     return true;
> > +}
> > +
> > +/**
> > + * blk_mq_tagset_wait_request_completed - Wait for all inflight reques=
ts
> > + * to become completed.
> > + *
> > + * Note: This function has to be run after all IO queues are shutdown.
> > + */
> > +void blk_mq_tagset_wait_request_completed(struct blk_mq_tag_set *tagse=
t)
> > +{
> > +     while (true) {
> > +             unsigned int count =3D 0;
> > +
> > +             blk_mq_tagset_busy_iter(tagset,
> > +                             blk_mq_tagset_count_inflight_rqs, &count)=
;
>
> If the tagset is shared, then one active user can prevent this from ever
> completing. It sounds like your use case cares about just one specific
> request_queue, not all of them.
>
> > +             if (!count)
> > +                     break;
> > +             msleep(20);
> > +     }
> > +}
> > +EXPORT_SYMBOL(blk_mq_tagset_wait_request_completed);
