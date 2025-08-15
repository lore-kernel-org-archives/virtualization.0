Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9383D984
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219749; cv=none; b=s4ipfeCUVVr9gZoyldblCKyz1aCQw13xBXgfwTjNDuvnfOWeH9Oeki/v9LR/HCfgDV/o5PzAU+KT8t/gFZIcfUPYijoaBmnm9y+4SXZw7+UpRSvkXvm5OCzT3840bZI+F5/m8FnUMjxUW3EgWWlyIDd669on32wT0W0pd/hzt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219749; c=relaxed/simple;
	bh=KNK3zkzlYeQURhbykPL7rMXuHpVvC/2reo8CVxG8SEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeHTpFE/fK2BiIoqm/HiAr1esQtUQYVe+6ioKmEjJGa1kH2EHiGq/0zj9E7xXvbKus/sJsLmSfPrL9+M4YZOyX/3n5aNxwK8JnGURN8YV+ZvBk2/okE4QkAsXM5Nt7A1ee0ppqSaVMI0kIuIJu3JcH5Tpcii2nlUy6BBU66G8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afzarKP8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afzarKP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755219745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REs1hd81lcpd2RRYo/GLQMvx3INCy7uWiXpRXUWQwtA=;
	b=afzarKP8kSGHcQjfkZA1gkCaiT0RKd5a2eKMHqq221ZR0U5rye2Ym0iJH8jLO4qHxb3Moi
	gR6OibCCZYoMUnjrR6wcnNZ5F48yCklzomu3RzFAaxIIqfzrQ/M4cERM99ZfCwshJdA1ZU
	ETYDrTKyIhwUtwo3at7KiWNzMqvQT6o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Lwp5LaioOtOo6MwFCXitYg-1; Thu, 14 Aug 2025 21:02:22 -0400
X-MC-Unique: Lwp5LaioOtOo6MwFCXitYg-1
X-Mimecast-MFC-AGG-ID: Lwp5LaioOtOo6MwFCXitYg_1755219742
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-323266b41f5so3080732a91.0
        for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 18:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219741; x=1755824541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REs1hd81lcpd2RRYo/GLQMvx3INCy7uWiXpRXUWQwtA=;
        b=bdCUKjc8aea5KoB5UVejhFUNeV6nmXO8X9qEUXoFvU62z2QxGazRLceq5iZD8BQzQ4
         JAodMupbGg5n1PmctzoIqUY0JW/4MgYGUCk7MCVGbUZd7+yQcUreHV6YBdd2KwNH7ILj
         +bphnRIE3Ef+W14/upjYO4f/9nJcWDHcAGgbCm9YHPv9zk+I6dzQIb7iF34dHw+GdHHN
         bmtZHbMrLtx2LQGLw5u9JNWnLQJ5ZUUaHjysMHVN8EZNFpjJGopTRU71bO9EEpBJ7pXn
         fe0owt+RoFU6FzQSM7dDkf3syKCQHwB7x0l/7jkRD4YBsaqNK9DVi/uIhloAeNVKgMS2
         Yxig==
X-Forwarded-Encrypted: i=1; AJvYcCU71PzRlBLIKYlfij7GkyravnCRxnBLCBArNzxYQW4lDB639+PlzKiAnSgGEFIOrXmEstyzf+UgTW7vVlQikA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi7CsAWKSwsC9dQpX1ObjhgkjcbYIr7DohMnI52lHIcpa4GcBd
	H9OcRtPG3iSnNGEwCbH1i063GB6o37+M77T1xA/br4YKUiED37xczsdIFK/jvyeTO1HmuF7gwao
	i+/hliKTA8vLUbfF/lQz/cDIJcG6PVI4qpz9JQpxeMOca26X1wTbb6TD3BiJ0sEktgUqr0OeAz9
	B4931+U90bVUeIy7svtEwhQ1W/t3XsGzxHS4VTZTxcsOw=
X-Gm-Gg: ASbGnct8JhbRpkm8QC6a+z99XGeXlsSTGkAqNf728ZQUjXqINnRe1g1nQsR3gHv9kN2
	Akxv0acFoWt9HmYdWmwW6RutyrJTwyZj9KOLeHDf59/G2xrWEIm7njqZzRSskbfeD25j1k6ouJp
	UBJLHmLiXnRvBnjsMNK15QvQ==
X-Received: by 2002:a17:90b:50cc:b0:311:da03:3437 with SMTP id 98e67ed59e1d1-323421557f4mr421455a91.27.1755219741466;
        Thu, 14 Aug 2025 18:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnmvdLeEbq4CYattZMZKLRfd79cqwxtEizDRLbN8w9zteHxjjUj9ZgT3lfmEOMLCb2WfO3WZLlN5vBjVVGYc8=
X-Received: by 2002:a17:90b:50cc:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-323421557f4mr421403a91.27.1755219740995; Thu, 14 Aug 2025
 18:02:20 -0700 (PDT)
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
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Aug 2025 09:02:09 +0800
X-Gm-Features: Ac12FXxg3jkxZdNEzAcMz4isY4tTKK8O9XaTLPy8ZJOqQd7gBqWZn3-5oI92tcA
Message-ID: <CACGkMEuOnDavQNw2113TWY-cziSpHWxLnL1isNTf9HcW+kmFBQ@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6n0-gOcbpG5TIX5BLEMJ-8TCPHCIPdaXb0etn8nHo_Q_1755219742
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
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
> So I think for now we can just make it vduse_iova_domain *.

It requires exporting VDUSE's internal data structure to the virtio
layer which is a kind of layer violation. And the iova domain will be
soon replaced by virtqueue group in Eungeio's series that support
multiple address spaces

> If we see
> it's getting out of hand with too many types, we can think of solutions.

Considering we've already at it, I think it's better to have a
solution now if it's not complicated:

I can think of two kind of solutions:

1) Stick to the current void * pointer which is simple and straightforward
2) Eugenio's suggestion of having a virtio_map_head and let the
transport/device get the container struct which is the real token.

E.g

struct vduse_iova_domain {
      struct virtio_map_head map;
      ......
};

If you don't like void *, can we go fo 2)?

Thanks


>
> --
> MST
>

