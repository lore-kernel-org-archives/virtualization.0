Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E954F95
	for <virtualization@lists.linux.dev>; Tue,  9 Apr 2024 03:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634799; cv=none; b=iln4AE2zmDWN7PG6y7hkVzUbRSCM/pNNOFUDBkLBOgkmxsZsFaN86MCkAcIRHM1qGvWh573lTCU9vDv+Hib0jUcUSS/dg0Mroyf+T+U6HB3D3mxh7fWOjGj5ykNaOp6k+aylHIRew95K0Aj9aqXMAC+diE6ZmE48lYvs5zhbQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634799; c=relaxed/simple;
	bh=lxzSNvzrD+krJO3vw/t/cixNwL8tYRktEc4XuvGlHUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6MS6LEcBVTYYN+lTmjjCwV45xooZK1LbkqugsI73Yn1oBDfa5mkWKIxryUwzk+Wg5yuHfpD2bbybKTVjv+uIhxxiGojxT9UtduNW+mEzE+YcgB2cM4crzQAki5Sr7l/d0eXU8itn49c8opOSy+5DazgkTFe+7iVYMhbPumhni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AH+5yATC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AH+5yATC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712634796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KD7aI3KUIy6s54+Dn2xAAh6YXCvrhcr6E3iGFb/IXk=;
	b=AH+5yATCcYazmWRZfvgwEeo099Iv0vT+NMFbCVcYliCC+8gMl6bkmsmG3bQur2ALJnt4Xy
	FhNpOnkblkREruI+ZovxVZujII6+9rv61FGC2wy9sTIlRv4S9XgH6WOLpw7dmmRbkdv0Ag
	8OhvcD/SjuN84zqG5UkDvNTf4JPs3zA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-DnhlFjv6P5mtCHvk8xu2oQ-1; Mon, 08 Apr 2024 23:53:13 -0400
X-MC-Unique: DnhlFjv6P5mtCHvk8xu2oQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ecbb44ddc7so4635840b3a.2
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 20:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712634792; x=1713239592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KD7aI3KUIy6s54+Dn2xAAh6YXCvrhcr6E3iGFb/IXk=;
        b=NLDjYNKII2GrICFPJEWh2QMwCTqK2ySU20dDZTNOYtrvuzTdh8Ok3FmAgzE/XRAStG
         MN4rEGBxdSCK3xkwRA266dFRN+cIQP/IlpI8OilZEEXIhm4UQ4vAtHj+NBC4B89iHaHa
         lT6Wx8cUCSm8/2Qrz+TIb7maKQ4664+N+NThKBCmlPrGwAw/6K6WR6tzmYRfNAQqpAU2
         ydnV9deh89fgJrqwdpTY2jRVETYpn1I53eOOWFjiABXGX1WqfHubl5U7t+DzCvFcmzbH
         Ie7WXF6sI/mBD7GI3MOqQIKRgmfBQSZ+T6g8upZKsu0jPM0nWYdtg7g1UJBsfVEuMFZ8
         WrJg==
X-Forwarded-Encrypted: i=1; AJvYcCXLOHaplOy5t1z/HGFYg6E97EHLe8vMb1M80RrD5mpls2Wnfe79Ow4mAyF8NyW8iZ7O/Pk10lS857qrLMdh//KwA5tgoKHhzXdGIaRyees=
X-Gm-Message-State: AOJu0YxiIq6Mrs8p45948/C9gkeToTsZ10F95EemRvBTsVXC1HhOvAig
	733fUUgCmNK3X2ubi3MoZYisjlhA3l6IVErKRcXSYuqeZTrTLF//79MZWQwpRS3lR3MzUVoXhZ+
	z8kJt3Wsq2/yMPXMASHiL4xn3owcxufIIHvefJxn+bQ3sZAegBV+F/dJxNMXxE4SNthkNn/u0dJ
	XDnLH8jumfKMi+cMPulC/CefVfouuMDjc8oNFx/us=
X-Received: by 2002:a05:6a21:3391:b0:1a7:9812:3680 with SMTP id yy17-20020a056a21339100b001a798123680mr2441709pzb.40.1712634791942;
        Mon, 08 Apr 2024 20:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvsmXztrk7ncCJXSQ+W7uLtHwec4zNCzG/3012Rb3DaDvqvhgpT4f0P6PGoY4v5efkwwjDwdn/8sAvc4Tg7dM=
X-Received: by 2002:a05:6a21:3391:b0:1a7:9812:3680 with SMTP id
 yy17-20020a056a21339100b001a798123680mr2441690pzb.40.1712634791606; Mon, 08
 Apr 2024 20:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240408035346-mutt-send-email-mst@kernel.org> <20240409014935.944-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20240409014935.944-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Apr 2024 11:53:00 +0800
Message-ID: <CACGkMEsvva4xWJpBLOzxmst=BzE7HRWuTpERVEt78oSGG_=5RQ@mail.gmail.com>
Subject: Re: [PATCH v3] vp_vdpa: fix the method of calculating vectors
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: mst@redhat.com, angus.chen@jaguarmicro.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:49=E2=80=AFAM lyx634449800 <yuxue.liu@jaguarmicro.=
com> wrote:
>
> When there is a ctlq and it doesn't require interrupt
> callbacks,the original method of calculating vectors
> wastes hardware msi or msix resources as well as system
> IRQ resources.
>
> When conducting performance testing using testpmd in the
> guest os, it was found that the performance was lower compared
> to directly using vfio-pci to passthrough the device
>
> In scenarios where the virtio device in the guest os does
> not utilize interrupts, the vdpa driver still configures
> the hardware's msix vector. Therefore, the hardware still
> sends interrupts to the host os. Because of this unnecessary
> action by the hardware, hardware performance decreases, and
> it also affects the performance of the host os.
>
> Before modification:(interrupt mode)
>  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
>
> After modification:(interrupt mode)
>  32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
>  33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
>  34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config
>
> Before modification:(virtio pmd mode for guest os)
>  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
>
> After modification:(virtio pmd mode for guest os)
>  32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config
>
> To verify the use of the virtio PMD mode in the guest operating
> system, the following patch needs to be applied to QEMU:
> https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicro.c=
om
>
> Signed-off-by: lyx634449800 <yuxue.liu@jaguarmicro.com>
> ---
>
> V3: delete unused variables and add validation records
> V2: fix when allocating IRQs, scan all queues
>
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 +++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index df5f4a3bccb5..cd3aeb3b8f21 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,22 +160,31 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_v=
dpa)
>         struct pci_dev *pdev =3D mdev->pci_dev;
>         int i, ret, irq;
>         int queues =3D vp_vdpa->queues;
> -       int vectors =3D queues + 1;
> +       int msix_vec, allocated_vectors =3D 0;
>
> -       ret =3D pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSI=
X);
> -       if (ret !=3D vectors) {
> +       for (i =3D 0; i < queues; i++) {
> +               if (vp_vdpa->vring[i].cb.callback)
> +                       allocated_vectors++;
> +       }
> +       allocated_vectors =3D allocated_vectors + 1;
> +
> +       ret =3D pci_alloc_irq_vectors(pdev, allocated_vectors, allocated_=
vectors,
> +                                                               PCI_IRQ_M=
SIX);
> +       if (ret !=3D allocated_vectors) {
>                 dev_err(&pdev->dev,
>                         "vp_vdpa: fail to allocate irq vectors want %d bu=
t %d\n",
> -                       vectors, ret);
> +                       allocated_vectors, ret);
>                 return ret;
>         }
> -
> -       vp_vdpa->vectors =3D vectors;
> +       vp_vdpa->vectors =3D allocated_vectors;
>
>         for (i =3D 0; i < queues; i++) {
> +               if (!vp_vdpa->vring[i].cb.callback)
> +                       continue;
> +
>                 snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>                         "vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> -               irq =3D pci_irq_vector(pdev, i);
> +               irq =3D pci_irq_vector(pdev, msix_vec);
>                 ret =3D devm_request_irq(&pdev->dev, irq,
>                                        vp_vdpa_vq_handler,
>                                        0, vp_vdpa->vring[i].msix_name,
> @@ -185,23 +194,23 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_v=
dpa)
>                                 "vp_vdpa: fail to request irq for vq %d\n=
", i);
>                         goto err;
>                 }
> -               vp_modern_queue_vector(mdev, i, i);
> +               vp_modern_queue_vector(mdev, i, msix_vec);
>                 vp_vdpa->vring[i].irq =3D irq;
> +               msix_vec++;
>         }
>
>         snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-conf=
ig\n",
> -                pci_name(pdev));
> -       irq =3D pci_irq_vector(pdev, queues);
> +                       pci_name(pdev));
> +       irq =3D pci_irq_vector(pdev, msix_vec);
>         ret =3D devm_request_irq(&pdev->dev, irq, vp_vdpa_config_handler,=
 0,
>                                vp_vdpa->msix_name, vp_vdpa);
>         if (ret) {
>                 dev_err(&pdev->dev,
> -                       "vp_vdpa: fail to request irq for vq %d\n", i);
> +                       "vp_vdpa: fail to request irq for config\n");
>                         goto err;
>         }
> -       vp_modern_config_vector(mdev, queues);
> +       vp_modern_config_vector(mdev, msix_vec);
>         vp_vdpa->config_irq =3D irq;
> -

Unnecessary changes.

Others look good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>         return 0;
>  err:
>         vp_vdpa_free_irq(vp_vdpa);
> --
> 2.43.0
>

