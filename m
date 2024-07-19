Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0F145FFB
	for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411351; cv=none; b=cAkJStZ+Q+M+NaS6ItReYtut1jeeqjX4T8owf4Lm5dFs9UujJ8Z5K11ZLO14eYw7dVh70PWaGbXKWkV6G6bZVx3uoMZy6hGD168/9KhbGrN4bChVMhjWgr46v8EBn0NPo4K07hVj4y+IbrXnkE2kY12raphNaUYYTx8NAvDBm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411351; c=relaxed/simple;
	bh=vXdQaWIw6M7hRsZ6dvMWdl8HadJBhwueEOfVq2MYG5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvQRHUky7L0KE+ILCvkP72CAfPcGfiU/UAhtv/9qEq9iuL8QJwcpNBqV6mspbhCApNAj5a/2Ch/Q6XimbjI+HKOUEbs5SREqgxQOjlTQT79XneNL5GsjTsV3JRFYydmaqMOt9v0UZvRYDDAK21ogcasSD5SMIjRIB9ErYRLszxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKHD9SE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKHD9SE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721411348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvG7W//VxOLquq3oYCFmqNaih+CiVz0BWbXI2oTCxUs=;
	b=KKHD9SE5EeKAaoRcev1Q7eb5mpw7uLjSR9UJxg1Ovjdh7qtiDrO+dK5/NRC+h8c3ODkkTH
	tFyyWhc2uYAUMIDPktjHebivgEF4yV+swI4Fkqrf1n8/S0YIx+QyXa/95JF+XZVoINWPMl
	/oWZmQ9uBA2r2pA+bcCN/Mx/Wtbf3Kk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-hMsZhznGOym1b1SLqFsyXA-1; Fri, 19 Jul 2024 13:49:07 -0400
X-MC-Unique: hMsZhznGOym1b1SLqFsyXA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-664b7a67ad4so56553467b3.2
        for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 10:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721411347; x=1722016147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvG7W//VxOLquq3oYCFmqNaih+CiVz0BWbXI2oTCxUs=;
        b=e+XrgSEwMuHLFhyUtsSYmFjGKaTwbg12FxvXDeDU3dGmpX8735kyuYomE1HBw0JOFQ
         KGEj2MqWJdshLYfumLvDj8EjGbkTJcZPtD0W96iQix33Y0Qp1MZBoqw+xrSXwNrqsmOz
         phBblonZk2n6v/QeyoSPkP9j5sPR6T357h2vmgV+JkTErddUHrQeDCGawftWW3iySRaE
         CWMmSelv53IKVZ1a/AppL3OEmsFSLemyZ4UJst0RglsAWs22a5pKVqwlN0JUF2s/7kbB
         ZozmQo0+ixk1nnhbKYkFiN+mSiHnCpOglaWLgbI4ghqtKHJMPFW/6/ngCQN562PI57Lq
         Jomg==
X-Forwarded-Encrypted: i=1; AJvYcCX0SyGbL+xOG1oCJZuDH9k9JpTfuvVzunz+z/2c5tzUj4vYrQCehRm6iIfx1ExXP128Z/6vOCbLDBUVJnb04c1q8ACwLWL+IiL8yKGKYfk=
X-Gm-Message-State: AOJu0YyATjbh+Pg4Ei7hm4Akil8ZmP1rvBpC5K3viKSEn1bth9KI+pq/
	Wjp+ZdCe7vNtn1dX6QpJLWo65fXWDwH24hVcihBl0ZUzibn7Sj3y8JZec9tnB5jRqqLxGfRlpQT
	4XX2Gvg5rqK1gziNHsMhlDjayaBZVpQYo1o/ZYL54IPaVMDHDUjGq89T6zw8hfNfNzvmuQyWJRn
	RBh49UskyoeferqJiWLaQgNMrZ9ZaGJBF6ZL5qCPc=
X-Received: by 2002:a05:690c:60c7:b0:63b:c16e:a457 with SMTP id 00721157ae682-66a66c1c58bmr4846387b3.13.1721411346801;
        Fri, 19 Jul 2024 10:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEirM1cedYvqXGDG7IHvorqtycE8ZsqjjxddsPZrww3yUXfYmy/bt5ilpHUXBvKSSmJC4XtdUu1iucRpoPXLHs=
X-Received: by 2002:a05:690c:60c7:b0:63b:c16e:a457 with SMTP id
 00721157ae682-66a66c1c58bmr4846227b3.13.1721411346492; Fri, 19 Jul 2024
 10:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Zpn9t5xJCPMhvpZO@fedora>
In-Reply-To: <Zpn9t5xJCPMhvpZO@fedora>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Jul 2024 19:48:29 +0200
Message-ID: <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>
Subject: Re: [PATCH] virtio: Fix various coding style issues
To: =?UTF-8?Q?Juan_Jos=C3=A9_Arboleda?= <soyjuanarbol@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, trivial@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:49=E2=80=AFAM Juan Jos=C3=A9 Arboleda
<soyjuanarbol@gmail.com> wrote:
>
> Address various coding style warnings in the virtio_mmio driver:
>
> - Move trailing `*/` to a new line in block comments.
> - Use parentheses with sizeof for consistency.
> - Add missing blank line after declarations.
> - Replace 'S_IRUSR' with '0400' for permissions.
>
> Signed-off-by: Juan Jos=C3=A9 Arboleda <soyjuanarbol@gmail.com>
> ---
>  drivers/virtio/virtio_mmio.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 173596589c71..7e6e41b2fb5a 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -74,7 +74,8 @@
>
>
>  /* The alignment to use between consumer and producer parts of vring.
> - * Currently hardcoded to the page size. */
> + * Currently hardcoded to the page size.
> + */
>  #define VIRTIO_MMIO_VRING_ALIGN                PAGE_SIZE
>
>
> @@ -167,21 +168,21 @@ static void vm_get(struct virtio_device *vdev, unsi=
gned int offset,
>         switch (len) {
>         case 1:
>                 b =3D readb(base + offset);
> -               memcpy(buf, &b, sizeof b);
> +               memcpy(buf, &b, sizeof(b));
>                 break;
>         case 2:
>                 w =3D cpu_to_le16(readw(base + offset));
> -               memcpy(buf, &w, sizeof w);
> +               memcpy(buf, &w, sizeof(w));
>                 break;
>         case 4:
>                 l =3D cpu_to_le32(readl(base + offset));
> -               memcpy(buf, &l, sizeof l);
> +               memcpy(buf, &l, sizeof(l));
>                 break;
>         case 8:
>                 l =3D cpu_to_le32(readl(base + offset));
> -               memcpy(buf, &l, sizeof l);
> -               l =3D cpu_to_le32(ioread32(base + offset + sizeof l));
> -               memcpy(buf + sizeof l, &l, sizeof l);
> +               memcpy(buf, &l, sizeof(l));
> +               l =3D cpu_to_le32(ioread32(base + offset + sizeof(l)));
> +               memcpy(buf + sizeof(l), &l, sizeof(l));
>                 break;
>         default:
>                 BUG();
> @@ -209,22 +210,22 @@ static void vm_set(struct virtio_device *vdev, unsi=
gned int offset,
>
>         switch (len) {
>         case 1:
> -               memcpy(&b, buf, sizeof b);
> +               memcpy(&b, buf, sizeof(b));
>                 writeb(b, base + offset);
>                 break;
>         case 2:
> -               memcpy(&w, buf, sizeof w);
> +               memcpy(&w, buf, sizeof(w));
>                 writew(le16_to_cpu(w), base + offset);
>                 break;
>         case 4:
> -               memcpy(&l, buf, sizeof l);
> +               memcpy(&l, buf, sizeof(l));
>                 writel(le32_to_cpu(l), base + offset);
>                 break;
>         case 8:
> -               memcpy(&l, buf, sizeof l);
> +               memcpy(&l, buf, sizeof(l));
>                 writel(le32_to_cpu(l), base + offset);
> -               memcpy(&l, buf + sizeof l, sizeof l);
> -               writel(le32_to_cpu(l), base + offset + sizeof l);
> +               memcpy(&l, buf + sizeof(l), sizeof(l));
> +               writel(le32_to_cpu(l), base + offset + sizeof(l));
>                 break;
>         default:
>                 BUG();
> @@ -281,7 +282,8 @@ static bool vm_notify(struct virtqueue *vq)
>         struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->v=
dev);
>
>         /* We write the queue's selector into the notification register t=
o
> -        * signal the other end */
> +        * signal the other end
> +        */
>         writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
>         return true;
>  }
> @@ -699,6 +701,7 @@ static int virtio_mmio_probe(struct platform_device *=
pdev)
>  static void virtio_mmio_remove(struct platform_device *pdev)
>  {
>         struct virtio_mmio_device *vm_dev =3D platform_get_drvdata(pdev);
> +
>         unregister_virtio_device(&vm_dev->vdev);
>  }
>
> @@ -799,7 +802,7 @@ static const struct kernel_param_ops vm_cmdline_param=
_ops =3D {
>         .get =3D vm_cmdline_get,
>  };
>
> -device_param_cb(device, &vm_cmdline_param_ops, NULL, S_IRUSR);
> +device_param_cb(device, &vm_cmdline_param_ops, NULL, 0400);

Hi Juan Jos=C3=A9,

What is this warning? It sounds more reasonable to me to go from
hardcoded value to macro, am I missing something?

The rest looks good to me.

Thanks!

>
>  static int vm_unregister_cmdline_device(struct device *dev,
>                 void *data)
> --
> 2.45.2
>

