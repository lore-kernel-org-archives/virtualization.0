Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710111EF0D
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710734799; cv=none; b=a+Weviofe8EsVteSOE6TJ9hIUO75AV1whu/tOY2jrhjfzLX+XekcqBwtqiiTh9n/4ktsRFvIO4o0PJkhYBcVXuGBiDzgkNCuhTHEf1vLWhk+tTU/0FX5Dm0G2BbkZ9rvKbSVugOHr519O9spqaBjfKMQYpQRuPJLPMmgxFlHVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710734799; c=relaxed/simple;
	bh=Q6bQMCAz3D+8839rxdaY/X8g7IJM0JChm5Xn7hhtj+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zk2D2uM4aQg/0aoyFJv5teGag6pCY0L0ApumwpYfz+26hoxFyGi4EIQ62NXagMesLEQmGpYOeTJIzsmzWyZwstzkP/6gdV7han+ppia3sNNy6M0a6COF3VVjxUjSnhGkNgtT7LtcNNheFgiaItHNdpCuUNAvxHtYLkYs9eL+fso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzUGnWMi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzUGnWMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710734796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8EK8peOWXRDiqjhcyGcF10KbckkSNcbVTNFgWjb/dI=;
	b=PzUGnWMiH/9Sd1YdobOCceGWxs0+gFPpuKUlKvE3UN3j/bhGhCTp3InIf+lvlh9UIjfwZu
	sw0hgDztLCXcLuF580Pckc7bXSMa7HKkpz9Sr4UYaZnbo4yTkun2wyN+cWYuBNOMK9CRCz
	lg4UhJIfX0v4AAC5Rl9pkXY6WoeuS6c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-8tEwevnhNYi6NAZdCjImmw-1; Mon, 18 Mar 2024 00:06:33 -0400
X-MC-Unique: 8tEwevnhNYi6NAZdCjImmw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29fbe1089b8so94402a91.2
        for <virtualization@lists.linux.dev>; Sun, 17 Mar 2024 21:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710734793; x=1711339593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8EK8peOWXRDiqjhcyGcF10KbckkSNcbVTNFgWjb/dI=;
        b=crvyCS7WHhaEI/WroZYXSAVQy65D4AJNN9i1EqHPgA8VAIzIIauq7jvgaA4g2mp1gj
         udMxwmDcGIPlItmwwY/wu0M/euhbpg7Up2BB/DqHQh7ZPoaHvaHpvV9p+X9I3XAP7Wbo
         9yaBXzRpE1smPdWrMfOol0nv7Nkm/P72C/lx+H7qUymaWflXghHf24hQuY3nKzVTTJPc
         t41QAkNqRfdXyhdDW7rfEGuPHh5gdKUhDOLNnpfCt3NHMXG8Ancb56ALYvoHFwag78H6
         TNfjXqfZNiBzFJdJepO/uWEK7dChfCdvHpfe1FSyWLuKWdnV8PSdniPBDKtMWNLY89tl
         KvJA==
X-Forwarded-Encrypted: i=1; AJvYcCVemcWym7NVYkJM4XeW76ui+7FecXMEzrMfBxrkIe1sEqlJvXr/qiMs2fDDqC7Zka46OcFCMJChJTY0icBqHZxhlBaLwbfis/xp/e+ccxQ=
X-Gm-Message-State: AOJu0Yw7NIbzmj/L75Cc/Np2/ncQ1EslUTpjSrseafAbVu4IzS/z1Evz
	jO6cWIz518BU3Xdm79zOzvdPIMAA7QfDWQx7oh3AIY/8wZyyUYxh7zXfidb4oGrrFIJAjn0iJZ7
	Tg0O5w/DgW6k6/FQqOue+WBacqj3r6BQV5BzRqsz+7y7hsZrNmY0BqC3OxKjEvOdcTVv5o5/DQu
	LH+s+xxA7ELikhJT+jvQv6SL0nVMIubgb+Qq9UeW8=
X-Received: by 2002:a17:90a:f2d3:b0:29d:fb96:e809 with SMTP id gt19-20020a17090af2d300b0029dfb96e809mr5390040pjb.31.1710734792857;
        Sun, 17 Mar 2024 21:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQdC+q3NnZjT9MHrobYbux1seMtS9A7ZslrlYCYsBWHWhqS184XNPXfNvenD4/hzYFPLgIUCKCN7GNYq6JV8A=
X-Received: by 2002:a17:90a:f2d3:b0:29d:fb96:e809 with SMTP id
 gt19-20020a17090af2d300b0029dfb96e809mr5390028pjb.31.1710734792511; Sun, 17
 Mar 2024 21:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240318030121.1873-1-gavin.liu@jaguarmicro.com>
In-Reply-To: <20240318030121.1873-1-gavin.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Mar 2024 12:06:20 +0800
Message-ID: <CACGkMEsuHYVe7KBxRMO=S555HviKGoRz9Y6EDsC5AzweU9b+Fg@mail.gmail.com>
Subject: Re: [PATCH] vp_vdpa: fix the method of calculating vectors
To: "gavin.liu" <gavin.liu@jaguarmicro.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	angus.chen@jaguarmicro.com, yuxue.liu@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:01=E2=80=AFAM gavin.liu <gavin.liu@jaguarmicro.c=
om> wrote:
>
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
>
> When there is a ctlq and it doesn't require interrupt
> callbacks,the original method of calculating vectors
> wastes hardware MSI or MSI-X resources as well as system
> IRQ resources. Referencing the per_vq_vectors mode in the
> vp_find_vqs_msix function, calculate the required number
> of vectors based on whether the callback is set.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 281287fae89f..5066970b2570 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,7 +160,13 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vd=
pa)
>         struct pci_dev *pdev =3D mdev->pci_dev;
>         int i, ret, irq;
>         int queues =3D vp_vdpa->queues;
> -       int vectors =3D queues + 1;
> +       int vectors =3D 0;
> +
> +       for (i =3D 0; i < queues; i++) {
> +               if (vp_vdpa->vring[i].cb.callback !=3D NULL)
> +                       vectors++;
> +       }
> +       vectors =3D vectors + 1;
>
>         ret =3D pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSI=
X);
>         if (ret !=3D vectors) {
> @@ -172,7 +178,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdp=
a)
>
>         vp_vdpa->vectors =3D vectors;
>
> -       for (i =3D 0; i < queues; i++) {
> +       for (i =3D 0; i < vectors - 1; i++) {

This seems to be buggy. You didn't scan all queues so you will miss
the IRQ for the last queue.

Thanks

>                 snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>                         "vp-vdpa[%s]-%d\n", pci_name(pdev), i);
>                 irq =3D pci_irq_vector(pdev, i);
> @@ -191,7 +197,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdp=
a)
>
>         snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-conf=
ig\n",
>                  pci_name(pdev));
> -       irq =3D pci_irq_vector(pdev, queues);
> +       irq =3D pci_irq_vector(pdev, vectors - 1);
>         ret =3D devm_request_irq(&pdev->dev, irq, vp_vdpa_config_handler,=
 0,
>                                vp_vdpa->msix_name, vp_vdpa);
>         if (ret) {
> @@ -199,7 +205,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdp=
a)
>                         "vp_vdpa: fail to request irq for vq %d\n", i);
>                         goto err;
>         }
> -       vp_modern_config_vector(mdev, queues);
> +       vp_modern_config_vector(mdev, vectors - 1);
>         vp_vdpa->config_irq =3D irq;
>
>         return 0;
> --
> 2.43.0
>

