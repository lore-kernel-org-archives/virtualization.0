Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0E26E16C
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939936; cv=none; b=bqogXqhiWx0tYZTHigSLwin/UN+0nXIb7wl+TOBe52ubBNAfj5s/2THmEViy2ewAC2i6OIh+St7Yq6KKuq/1nAWRnYp3eHuPISqF92YoKPFDcm+Xv7Rel1dB/JHCyoSxRbKXQFyQk2N3PDNsrNMbTGIk+uXclikNBtOrUMiAdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939936; c=relaxed/simple;
	bh=Q31ncL8Ha+T3oNRvNnT2Wuscln7Regla9Pur20xnDf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1400cqwKCO1YX7xaIuiSOQ3l2oS7Sm5c3ETVr7SyCkPYrMr0LDWB++fAHmWTkp6zklNLA1GPuMGFbCCZZATW3idZheScIlOHRxPM6P3OsOewBT0lOtyFjyk1hCFtDSvAvMF8Dx+Sp4Je7hr6CNFKNG/P6PK8cu8VrG2blrNpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdLUBjyG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdLUBjyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765939933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiUmMNIzFgAxQHtB8iOJv+NotZ/xRHvCl/afi/jdFIc=;
	b=AdLUBjyGgYTBgFhZ9p8uONauvDmEN2ywPaAK6I3fW65Ajf0Tuyz4tfYXdZ8M7qosUyBVnD
	gqNoBRucKDpweZoEBeDDgxyzFKfJmIsn/E6ypodQeJdv65POJ4+cmHjX4Dsr8JP6Q9fW8k
	ZJtLKmGOqtOxbQD++rkJTZppzZbw+1s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-D12q-jYAOA6D7KfwbPliUQ-1; Tue, 16 Dec 2025 21:52:03 -0500
X-MC-Unique: D12q-jYAOA6D7KfwbPliUQ-1
X-Mimecast-MFC-AGG-ID: D12q-jYAOA6D7KfwbPliUQ_1765939922
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso3327180a91.3
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 18:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939922; x=1766544722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UiUmMNIzFgAxQHtB8iOJv+NotZ/xRHvCl/afi/jdFIc=;
        b=LGqLbfZzKUb2OpoZ4LZaFmL/w+wycmGyVcQ86iG9/UgbZJGwCfLvTKFaJ5hMP3oeK4
         G0aiYGWXUX57QmBStgRZgvW4R1hO27udileWsZCnrpaye45gowmWXzYMUZbF5MhsgT9/
         Picz2j1XfdqznDAdh10mWlxNCFuKsZ/MNGrSXgqv7JBFuZ/HVZLGI3h93SCmR0/gogFA
         0BqMxIK41bzE6yQjRZ1egnJPBAECNZhqf64+r+JqJna4/dx4zly53/3uo2R7+dG62Gb1
         URbRPoZ0Ff453MHFql0qY0+aO3eBK9QKKqX3sEoYYwftsaXhi4q4xPQftTQgqPVgXFiO
         3heA==
X-Forwarded-Encrypted: i=1; AJvYcCXmMKYduKo+vndRAR8bWD8KDKccLI/x9kLvSHhB3kEdDiPA4l+KZE+cnVpsPTS4w61Q9IBDAracRYV74Lp96g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeEWFLn0og36rcr6kXIL79A7DTzz8ji1i7RH+I4RgTE2dMKZcQ
	KG/1HM/MDIWLFdsZbFa5uXqI7QHVsEsrYQy0DY8M+6xUmTxezu0oN6hY7uOWYbnFGDok9Swx5KK
	LFkKPF7oeVZKA+Qfp5HDAVQCox+EmRGrF3g06pkIS6l4fxRNkmhZIMvgLnhX+UK1JZANYQR5Akh
	4qeTjO5agIXK81wjvS5W/h1iDVGevN9wNTUvqe5OjCJgY=
X-Gm-Gg: AY/fxX7X9vw/B9zCAZuTJT/ARv1KBxq9m0Wk8suSBfhf6KD+cFcLrfvPWYqeqr7+fW7
	W7fcoY4MFs7ptJNKmwgAStFtHS9chW5yfVkpsmnPoHKrwgVZJCIbBwkmCj/ChVCLsWGaJg+A3WP
	ZS6FQRol4S9wsavf7wqeZwtOUyOGkSE9ntVJCNeKwY+mD4q4PuwvwtJkX0v36Cxgp/9A==
X-Received: by 2002:a17:90b:4c90:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-34abd75ba34mr16871952a91.18.1765939922476;
        Tue, 16 Dec 2025 18:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZApsOGsfdicfxdDalJ9XLGKQn4L6egqKrK1ACsRLDleINH15YHI9I9H1awEaTHv1V/LPZLbz1KNmKDrZz3yQ=
X-Received: by 2002:a17:90b:4c90:b0:341:8b2b:43c with SMTP id
 98e67ed59e1d1-34abd75ba34mr16871927a91.18.1765939922022; Tue, 16 Dec 2025
 18:52:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217022918.225-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20251217022918.225-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Dec 2025 10:51:50 +0800
X-Gm-Features: AQt7F2qhdY4lz5dQQjfQSxtvH4t7hXbEiZqeoNAJvQBgFUqc9skIlsmQawB4j18
Message-ID: <CACGkMEtc3KdQtyxUnVeBG6FrbULGanmJxBwNhmG4DB1pO7zn=g@mail.gmail.com>
Subject: Re: [PATCH] The vdpasim_net_work function handles both transmit TX
 completion and RX processing. A descriptor is taken from the TX VQ at the
 start of the loop, representing a buffer previously used for the TX path's
 initial read from the virtual network device. This TX descriptor must be
 completed back to the Rx queue at the end of the work loop.
To: Angus Chen <angus.chen@jaguarmicro.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g13Nr5O8bvyaEzGQE0_nq8BZxKeDz6qhUxlCWWDA8HA_1765939922
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 10:30=E2=80=AFAM Angus Chen <angus.chen@jaguarmicro=
.com> wrote:
>

It looks like the title is too long.

> However, the error handling logic was flawed:
>
> 1. Read Failure (err <=3D 0): The TX VQ completion
>    (vdpasim_net_complete(txq, 0)) was performed, but the unconditional
>    break that followed prevented theprocessing of subsequent pending work
>    items (other descriptors) in the queue in the same work function call.
>
> 2. Write Failure (write <=3D 0): If data could not be written to the RX V=
Q
>    descriptor (e.g., vringh_iov_push_iotlb failed), the flow would 'break=
'
>    before the TX VQ descriptor was completed. This led to a leak of TX VQ
>    descriptors, as the work was never notified that the TX buffer was
>    free to use again.
>
> This commit refactors the control flow to ensure:
> a) The TX VQ descriptor is completed back to the rx in all error and
>    success paths related to the current descriptor processing.
> b) The unconditional break on read failure is removed, allowing the
>    function to continue processing remaining work items
>    until the loop naturally exits.
>
> Fixes: 0899774cb360 ("vdpa_sim_net: vendor satistics")

This is suspicious, the logic was there since introduced? Or we can
split this patch

1) fix the stats
2) fix the error handling

> ---
>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index 6caf09a1907b..298bd6e8e0a0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -242,22 +242,22 @@ static void vdpasim_net_work(struct vdpasim *vdpasi=
m)
>                 if (err <=3D 0) {
>                         ++rx_overruns;
>                         vdpasim_net_complete(txq, 0);
> -                       break;
> -               }
> -
> -               write =3D vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov=
,
> -                                             net->buffer, read);
> -               if (write <=3D 0) {
> -                       ++rx_errors;
> -                       break;
> +               } else {

This else seem useless?

> +
> +                       write =3D vringh_iov_push_iotlb(&rxq->vring, &rxq=
->in_iov,
> +                                                     net->buffer, read);
> +                       if (write <=3D 0) {
> +                               ++rx_errors;
> +                               vdpasim_net_complete(txq, 0);

I'd move this after:

                read =3D vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
                                             net->buffer, PAGE_SIZE);

So we would have a single vdpasim_net_complete()

> +                               break;
> +                       }
> +
> +                       ++rx_pkts;
> +                       rx_bytes +=3D write;
> +                       vdpasim_net_complete(txq, 0);
> +                       vdpasim_net_complete(rxq, write);
>                 }
>
> -               ++rx_pkts;
> -               rx_bytes +=3D write;
> -
> -               vdpasim_net_complete(txq, 0);
> -               vdpasim_net_complete(rxq, write);
> -
>                 if (tx_pkts > 4) {
>                         vdpasim_schedule_work(vdpasim);
>                         goto out;
> --
> 2.34.1
>

Thanks

