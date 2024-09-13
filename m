Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AAB1B12F5
	for <virtualization@lists.linux.dev>; Fri, 13 Sep 2024 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198213; cv=none; b=WrydwXZoPN/1W4n7WT/IAZa1Y4Qy90G7DQ37iZfFUR2xpB6Af8uaurQ3geZ6DFx41/B1VdUcMq6K6YnTQSV6A6ybEcq2h+av6bQLe1v+pl2CS8CXnFrCcqz2irkrgExwH7bJ+rqp/5DQZNG7VZQB6bLQnQP+BlJo+FTGbn5t/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198213; c=relaxed/simple;
	bh=OL4txjngX0hT+S/KBLWICruauN0kZ8rNOinNr4Tp62c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVdmvikYvbOTqqJuEmRTG/6BfkaktXKxiJHsxYC5PSpFWoiae5g+Gph0CxvLp1bg77PRDEMPJGCHTZ7iYBV47uytlG8Jgflg5535PurxySmxf34XF9oQ5v4fzL2HFX6FQ8hA3x/1tZ0ajuOy6C51/v9+J6S+gF7KHcaV5Wekj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cp+qyhRc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp+qyhRc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726198210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XraFOFlvfYSvbfoE38xm/7jtb+aNLJtE6pDAodi5bkw=;
	b=Cp+qyhRc01FUZymtx1yxNS66GfG4Tx+CnjK5H0C510p7U1Y3Zx9C6ngeleKfXA5n+8rUaa
	7oov0KNgpTzb3kyYAlIgPxkVVhzk5F1unn/e5RF3Dig4MagkBateD4hdZAr4o77+PUA841
	B99QThCIWsgg5fcs6/rVdo0DBkbB840=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-TvoLr34kPLG2WkEMWadpyQ-1; Thu, 12 Sep 2024 23:30:08 -0400
X-MC-Unique: TvoLr34kPLG2WkEMWadpyQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d88641e9a8so1939382a91.0
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 20:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726198207; x=1726803007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XraFOFlvfYSvbfoE38xm/7jtb+aNLJtE6pDAodi5bkw=;
        b=lnWz8P/YPd37N7/BA5butY6vZkaOL0ClUGpfDIbEPvM681bi00cjg8wln/3/g1ol3D
         cDnqk0VD1oUCNaa8tlYfBpmqGpWpIVD1ZjSNZ7SazlRyYRvr7SboFpgOM2Wb8S/I9xAT
         3iVXh3j9Y+WKAu0boWKb3XyIMthzCCIt9R1phv5Xm6hXqn58wqKbJx7D4jzM5U925R4/
         uFFVh47/W2orCKQx/aZW1TaOb8COxKrCjZtWB6/+ECI5seo0m7YK/p2O92EVYogm9dBw
         PddEe0AnRULOs+Zm7AmCRFRa3Rn9ACoAnJDjWzWXRZqEVBJkoMGBla1A/ew4KyOKqvOD
         7UjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSHhc5lVxw0Q5WHkjisw3fUMF/wITtcJcjHDd31LS4evQVhrqj2XetXRttiS6nYA20qvAM7XBaIsTaTKQjLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQhvgG5P5eRazykcrSwP+ElcnIoqUwTY8eCy+yieCr68iTBorA
	86jUOn3QowCZ0IHZiX1FeH7esah/PnLnzJ94xzfpcWtKa/1daBZrfYFIyBJg1PTCbHG5MT2Hcem
	fwjAuQ+10yusRHHOl6iR5DUOpqJm4SAD1FC/nxmWJdWZP+6MdXKDRnYuVBrSO1AjSVgQmmzX+Za
	S3a4SvAkp03Eqk7l1ubN6gT7/pUjj30GBYjc99PE4=
X-Received: by 2002:a17:90b:4a4a:b0:2d3:d398:3c1e with SMTP id 98e67ed59e1d1-2dba0082fb8mr5578479a91.36.1726198207282;
        Thu, 12 Sep 2024 20:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRZzFvOmQNd8g2fspnJxJ33CmSRTluvH8Y3uUA+IrHrqGqU1UmVozYb4PHruoASxZty+uXKxg2ellHQ112yfo=
X-Received: by 2002:a17:90b:4a4a:b0:2d3:d398:3c1e with SMTP id
 98e67ed59e1d1-2dba0082fb8mr5578447a91.36.1726198206776; Thu, 12 Sep 2024
 20:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
In-Reply-To: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Sep 2024 11:29:53 +0800
Message-ID: <CACGkMEt1VOBTQiWaupqbGPH6WM+KytdwPf0AzHRcOAkZG9DH+w@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_ring: tag event_triggered as racy for KCSAN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, 
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> Setting event_triggered from the interrupt handler
> is fundamentally racy. There are races of 2 types:
> 1. vq processing can read false value while interrupt
>    triggered and set it to true.
>    result will be a bit of extra work when disabling cbs, no big deal.
>
> 1. vq processing can set false value then interrupt
>    immediately sets true value
>    since interrupt then triggers a callback which will
>    process buffers, this is also not an issue.
>
> However, looks like KCSAN can not figure all this out, and warns about
> the race between the write and the read.  Tag the access data_racy for
> now.  We should probably look at ways to make this more
> straight-forwardly correct.
>
> Cc: Marco Elver <elver@google.com>
> Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..98374ed7c577 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2588,7 +2588,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>
>         /* Just a hint for performance: so it's ok that this can be racy!=
 */
>         if (vq->event)
> -               vq->event_triggered =3D true;
> +               data_race(vq->event_triggered =3D true);
>
>         pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback)=
;
>         if (vq->vq.callback)
> --
> MST
>

Acked-by: Jason Wang <jasowang@redhat.com>

It might be worth testing if event_triggered can really help for
performance or not.

Thanks

