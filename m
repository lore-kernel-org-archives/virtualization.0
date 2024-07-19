Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB02746B
	for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412691; cv=none; b=o06xC4hlVpUiILeYEsYbOksBH1oFAmG9Xzl/MW6/M/hcJzKnuPQK1W3qBbp0v0l5N8w39s+sBW2Cge9d5ktoP9hN7fhP6ZHcVOGOxG3HC0SY9D9b6UZTieTFRFzlwn+1MWon0lUn+8gtsOJKlT+Mvig8XBVRU1wQ+/wiXco8as8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412691; c=relaxed/simple;
	bh=YWs5YXGw8CfJs9KjlieDFcDKzMwqlse3Gx+fePrI9pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RDqzSYauuDFCvxO667jZG5UO4PlR4HUJsanYG5WQ0P19C4VRhpc8LJBLXZELhPmSuqL8Mw4hS2/ZmoixO482qKcl4urxPIGU4ZoYRTKwqOpuCsvhgvyKBKwtaywmGLjNVGhjKzppoutfWvhLQ6rvpvXAxtlJlK3ERs1vuwGjlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOl2Qkko; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOl2Qkko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721412688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaH9ZO0pUqKQD1jYulGk41tYKF4SDsyN+e0N6o/D3XU=;
	b=BOl2Qkko8f4UBD6gU7TgK58tUqcjwvPKrEoy2P49N6S20uw/2ObmbofcCtXQUOBzHMxt2l
	r7flzX6OSlyl6SQgGFOeO5q1wemowYYx7bmlbV1lJQdM0O60AHdeBNQjzWN4KF6EzktMxY
	CWTlzyOjYOd967Tp5BIdX9bVs7YLmaw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-fuIQ2rFHN5u7Aww_nkbFfw-1; Fri, 19 Jul 2024 14:11:27 -0400
X-MC-Unique: fuIQ2rFHN5u7Aww_nkbFfw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a30be1c5cfso834089a12.0
        for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 11:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721412686; x=1722017486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaH9ZO0pUqKQD1jYulGk41tYKF4SDsyN+e0N6o/D3XU=;
        b=BgjLou8D/CLlqOg7l6ARICEqSNtFzo/vagCUCNsYMGqyPVwlZ7TrOW3URg4yX418eL
         4LoQYIORZWGHQqIjfVgmyvNqOR0KfZ1RRNdwFqTcJXYuHrO4lF1gTPZhs43iBuHxOUJQ
         YtT6Nbvz9WK1SV5i4BKBkdXB+B7lnsiaHa/l+MCVeED6w0VTOWnNXUalXBHAYzPUle10
         rB7uVHToYU1Fx3cUIBw1biEq/dgEdF892dP9rCc5jRSIBLRzyEFowOBPuLEfXeBhZPs3
         9Vpv3aNhLBfZTnWapIteEA/nuHwU7q3rJ1zSSVgpgbkvDUXEVvh7rmFA+aOCA3v/Z1yw
         l6nw==
X-Forwarded-Encrypted: i=1; AJvYcCWLyhtSLFniwhCONwdqxTny8x1YSW5UsXUOUgn3SBRy7ODYYXxlZpMr0HEpS9TAlOZnE1oPcgH49P3SutEwHQ0SHiiIh4ayv80yByCKBlo=
X-Gm-Message-State: AOJu0Yy9QsIRvMI0i11CJqp8yAPViSpGMxQD1TQErxcKABsEt3hiroUq
	6Ks5ydTAqvvW4v3PXPQUsmRrTFNv0uiHOQki1Ap5DbLAetcTc51YRC10Rxol9c/SFQLXSJKN5id
	Srgru/ZGa5rzeGs7bIbfaJyozAArfcXt8WXNLStW7D1tbq72yufvmZcQlOnNq6pYG
X-Received: by 2002:a05:6402:3587:b0:5a4:2c8:abda with SMTP id 4fb4d7f45d1cf-5a402c8aea8mr384849a12.3.1721412685892;
        Fri, 19 Jul 2024 11:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOsFY6cIOQ9o/APZZNRiQINhrzyGrU4/Zuy+NGcwKooD8wHGQ5rv168IlYmF9fX0818MXoJw==
X-Received: by 2002:a05:6402:3587:b0:5a4:2c8:abda with SMTP id 4fb4d7f45d1cf-5a402c8aea8mr384824a12.3.1721412685225;
        Fri, 19 Jul 2024 11:11:25 -0700 (PDT)
Received: from redhat.com ([109.253.183.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d7127sm1524181a12.3.2024.07.19.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 11:11:24 -0700 (PDT)
Date: Fri, 19 Jul 2024 14:11:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, trivial@kernel.org
Subject: Re: [PATCH] virtio: Fix various coding style issues
Message-ID: <20240719140906-mutt-send-email-mst@kernel.org>
References: <Zpn9t5xJCPMhvpZO@fedora>
 <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 19, 2024 at 07:48:29PM +0200, Eugenio Perez Martin wrote:
> On Fri, Jul 19, 2024 at 7:49 AM Juan José Arboleda
> <soyjuanarbol@gmail.com> wrote:
> >
> > Address various coding style warnings in the virtio_mmio driver:

warnings from which tool?

> >
> > - Move trailing `*/` to a new line in block comments.

don't unless you fix the comment completely.

> > - Use parentheses with sizeof for consistency.

for consistency with what? don't see the point.

> > - Add missing blank line after declarations.
> > - Replace 'S_IRUSR' with '0400' for permissions.
> >
> > Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>


> > ---
> >  drivers/virtio/virtio_mmio.c | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 173596589c71..7e6e41b2fb5a 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -74,7 +74,8 @@
> >
> >
> >  /* The alignment to use between consumer and producer parts of vring.
> > - * Currently hardcoded to the page size. */
> > + * Currently hardcoded to the page size.
> > + */
> >  #define VIRTIO_MMIO_VRING_ALIGN                PAGE_SIZE
> >
> >
> > @@ -167,21 +168,21 @@ static void vm_get(struct virtio_device *vdev, unsigned int offset,
> >         switch (len) {
> >         case 1:
> >                 b = readb(base + offset);
> > -               memcpy(buf, &b, sizeof b);
> > +               memcpy(buf, &b, sizeof(b));
> >                 break;
> >         case 2:
> >                 w = cpu_to_le16(readw(base + offset));
> > -               memcpy(buf, &w, sizeof w);
> > +               memcpy(buf, &w, sizeof(w));
> >                 break;
> >         case 4:
> >                 l = cpu_to_le32(readl(base + offset));
> > -               memcpy(buf, &l, sizeof l);
> > +               memcpy(buf, &l, sizeof(l));
> >                 break;
> >         case 8:
> >                 l = cpu_to_le32(readl(base + offset));
> > -               memcpy(buf, &l, sizeof l);
> > -               l = cpu_to_le32(ioread32(base + offset + sizeof l));
> > -               memcpy(buf + sizeof l, &l, sizeof l);
> > +               memcpy(buf, &l, sizeof(l));
> > +               l = cpu_to_le32(ioread32(base + offset + sizeof(l)));
> > +               memcpy(buf + sizeof(l), &l, sizeof(l));
> >                 break;
> >         default:
> >                 BUG();
> > @@ -209,22 +210,22 @@ static void vm_set(struct virtio_device *vdev, unsigned int offset,
> >
> >         switch (len) {
> >         case 1:
> > -               memcpy(&b, buf, sizeof b);
> > +               memcpy(&b, buf, sizeof(b));
> >                 writeb(b, base + offset);
> >                 break;
> >         case 2:
> > -               memcpy(&w, buf, sizeof w);
> > +               memcpy(&w, buf, sizeof(w));
> >                 writew(le16_to_cpu(w), base + offset);
> >                 break;
> >         case 4:
> > -               memcpy(&l, buf, sizeof l);
> > +               memcpy(&l, buf, sizeof(l));
> >                 writel(le32_to_cpu(l), base + offset);
> >                 break;
> >         case 8:
> > -               memcpy(&l, buf, sizeof l);
> > +               memcpy(&l, buf, sizeof(l));
> >                 writel(le32_to_cpu(l), base + offset);
> > -               memcpy(&l, buf + sizeof l, sizeof l);
> > -               writel(le32_to_cpu(l), base + offset + sizeof l);
> > +               memcpy(&l, buf + sizeof(l), sizeof(l));
> > +               writel(le32_to_cpu(l), base + offset + sizeof(l));
> >                 break;
> >         default:
> >                 BUG();
> > @@ -281,7 +282,8 @@ static bool vm_notify(struct virtqueue *vq)
> >         struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> >
> >         /* We write the queue's selector into the notification register to
> > -        * signal the other end */
> > +        * signal the other end
> > +        */
> >         writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> >         return true;
> >  }
> > @@ -699,6 +701,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
> >  static void virtio_mmio_remove(struct platform_device *pdev)
> >  {
> >         struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> > +
> >         unregister_virtio_device(&vm_dev->vdev);
> >  }
> >
> > @@ -799,7 +802,7 @@ static const struct kernel_param_ops vm_cmdline_param_ops = {
> >         .get = vm_cmdline_get,
> >  };
> >
> > -device_param_cb(device, &vm_cmdline_param_ops, NULL, S_IRUSR);
> > +device_param_cb(device, &vm_cmdline_param_ops, NULL, 0400);
> 
> Hi Juan José,
> 
> What is this warning? It sounds more reasonable to me to go from
> hardcoded value to macro, am I missing something?
> 
> The rest looks good to me.
> 
> Thanks!
> 
> >
> >  static int vm_unregister_cmdline_device(struct device *dev,
> >                 void *data)
> > --
> > 2.45.2
> >

