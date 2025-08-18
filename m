Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DB30DD06
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508226; cv=none; b=ryWB+a46Qkx6iT+zmK1MenudS1PNRfCHPsmCIPzwBXLEuREgeLBrYgGZbhJoKwRBnfJn8dwYSn5Nldh7vVPBu8gIXD1Cy544JYPxXBoovEElSx2xJCe7NuXLO7KjJLunE7/VWH35XzK0om8oKX7ri2roh+pymn3ZmZC5Y27gwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508226; c=relaxed/simple;
	bh=OoxFyzWMN9IiJadvJ63P+IvmvwWMqWQXae/OyA1JJCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ij83chD9EXSINwlN2LPTmknRR+2P7X3nQWFW+FhlSrGd+E07X2X+58aw3QFbBhVhogWEEh+lcomdLQltKB0aggeI5q1wyohtvQpgNUXomNkF0OZhnHHGVnrWSIgGIhlV+hod6LVb8cx4XVqBBz9SJmqOKGWOY2FSODj47rWcmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqdUyRkz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqdUyRkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755508224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbqfCfcRPkiPSf4BnJf27P0ti29xxEnyI41pHA552G0=;
	b=eqdUyRkz/KthtScv4so5tn7FUaUaTJk751bdekuuNnN9ENxix0q9ldiSkttw2c5ttvoNSJ
	eaientCa3B2xwfVhUbDtBetfUCwCsXupYsqC8loc/3ldLRv9CRTUmP1WmVUZcUr4gMXah4
	Yw2awutzL89V9FBDVfldJ9Miqiz6Ylg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-V1mYaTUvMWuuISMw6vOcKg-1; Mon, 18 Aug 2025 05:10:22 -0400
X-MC-Unique: V1mYaTUvMWuuISMw6vOcKg-1
X-Mimecast-MFC-AGG-ID: V1mYaTUvMWuuISMw6vOcKg_1755508221
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-321cfa79cb3so5162921a91.1
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 02:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508221; x=1756113021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbqfCfcRPkiPSf4BnJf27P0ti29xxEnyI41pHA552G0=;
        b=vl33MrEKru24CXQnlroNdHZu0H2C1ZKpcV5/cSZciBjblbsA+p2vV5LCRM0EvOX0ZL
         vcPZDGEJK5RXCo0aXIqGnNwDa5O4fqAHU4SB5kIWGl1yp8vjvVzc5JqpvDcCV4ShWKoU
         sbCD3a2nPgxnNGaMtzBurvzkV/eITgFlfzrFVNrWcftrQHbyyJJNrCFLOCnOFQfehYI5
         Wu3ETq0LehNI7FF4dWhQVLeWNwWtdyR8J+oDvW0kCvfZYRPKMt7Dmc8RDR85221sz+56
         +VqeDfqkgbIU1JpSlZPKbZoi983EZ2ayYyHcjrTPaRnBupMdFAv8U0t/uE8FgL4Hnmin
         Mtsg==
X-Forwarded-Encrypted: i=1; AJvYcCXm09ipIOlAx7w4CEw0i57gugmLFkXYqTwgSYaAyBnYhU5USYgwqxbA82/vyZ2Ak+2r+S/KKM5bCfg8YUbqQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxBc5b91r4qv0IiY4E4mA3EOCB+ujluNkrHVa+ubclMydH44u8
	VtjqHU1rmF56OK9xGwm9JxRLYCOmCfiqbo/jT6igLXGMHsXHP+1zCWDK/ZpzoWD/WY6MxdIauIT
	qB7dKbk99cwRrqVNxQEXrqYMMXn7w4m3WAhm6jVfgopugqrrwPHagR545YX/ZnwqA33W+g6A933
	4K9hH1RpwBjIGPlRHNh6yiYzp5fg0zEa/iR2mHIGk3LD8=
X-Gm-Gg: ASbGncv3BU6drZGKBOmy6eeGTiQhqDGtrnQJ7bmPE4E8hP7TZ3eI9eCamv+NT6JoqRI
	yuOmxVDmblcJHmFjupuRsAGGDbnW0K2zYspSc4yPKxA15WP60yfejTXXrUJA4r3GOgH36RfxCTx
	Im17m3cMwJFiufgPD7Y1zG
X-Received: by 2002:a17:90b:3f85:b0:31f:35f:96a1 with SMTP id 98e67ed59e1d1-323407b888fmr17497491a91.15.1755508221452;
        Mon, 18 Aug 2025 02:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkbIi8hMym2IDFiQZsok2ZF14sb98uoPQT+I2UMlsCLp+g2zYDDJHRmmtJoXScx/v9hOzXO0IqsunBpLjVMGs=
X-Received: by 2002:a17:90b:3f85:b0:31f:35f:96a1 with SMTP id
 98e67ed59e1d1-323407b888fmr17497455a91.15.1755508220998; Mon, 18 Aug 2025
 02:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org> <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
 <20250814063927-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250814063927-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 18 Aug 2025 11:09:44 +0200
X-Gm-Features: Ac12FXwWauHktoes46vJLvSCJWNDiN_iFDjd86oNm9bmlCrp2KcPLKWq_c4Jgu4
Message-ID: <CAJaqyWcxV+f6dhKLscGGy0bw2YWJ8NaJ4QN+Qe3Ax7C+Lf4X-g@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LuAInxLZqcPRSa-gB5MVm9t1YLfXI9kmMuaKPxEWN7U_1755508221
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Aug 14, 2025 at 11:36:22AM +0800, Jason Wang wrote:
> > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > index addbc209275a..37029df94aaf 100644
> > > > --- a/include/linux/virtio.h
> > > > +++ b/include/linux/virtio.h
> > > > @@ -40,6 +40,13 @@ struct virtqueue {
> > > >       void *priv;
> > > >  };
> > > >
> > > > +union vring_mapping_token {
> > > > +     /* Device that performs DMA */
> > > > +     struct device *dma_dev;
> > > > +     /* Transport specific token used for doing map */
> > > > +     void *opaque;
> > >
> > > Please just declare whatever structure you want it to be.
> >
> > It's an opaque one and so
> >
> > 1) the virtio core knows nothing about that because it could be
> > transport or device specific
> > 2) no assumption of the type and usage, it just receive it from the
> > transport and pass it back when doing the mapping
> >
> > It should work like page->private etc.
> >
> > Does this make sense?
> >
> > Thanks
>
> I fully expect most devices simply to use DMA here and no weird
> tricks. vduse is the weird one, but I don't see us making it
> grow much beyond that.
>
> So I think for now we can just make it vduse_iova_domain *. If we see
> it's getting out of hand with too many types, we can think of solutions.
>

I've sent my series of adding ASID to VDUSE, which uses this series'
token on each vq group, on top of this version of the DMA rework.

This patch [1] and the next one are the one that reworks the token to
an empty struct, so virtio can handle it in an opaque way and VDUSE
can convert it back and forth in a type safe way, skipping the void *.
Please let me know if you prefer to import a VDUSE header into the
virtio config header or to make a VDUSE forward declaration instead of
going through the empty struct to preserve layer boundaries.

There is one usage I've not been able to convert though. Jason, could
you take a look? It is marked as TODO in my series. I'm not sure if
that's also an abuse of the void * in the DMA rework to be honest, but
it should be easy to correct.

[1] https://lore.kernel.org/all/20250818085711.3461758-4-eperezma@redhat.co=
m/T/#u

