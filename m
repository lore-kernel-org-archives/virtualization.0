Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2331374CC
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715741342; cv=none; b=pzRxcQWGeFBnYKjsCxE9DGDCpoftklQKqBH1IneKz3hrcPgE73ZwSPBH4e1oo0de8PzgBdtjGVimo4RJ4pQqOuKi8mt7WQ85aJe1Uyhek0vRAcwQUeYqaXeB3w20oQrS1H8vqqxviJMvul2OHKg6DusttmFyLNeANhkCs7H0BXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715741342; c=relaxed/simple;
	bh=3p9V5oslK4x8aMOhrMUROLRNJj4lh4gSrktdUCFGPes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCVJeDz4RN5y36DUJhSwtLiidXIBnDEloql8p3tcTDjMqwV3EKf9wAl3LdDi9QL1T1Oh6pm+eKWUtkUFX/QkZ6c5ndIIKIkGMohLN2uuYRjzkL2SOCzXKEXYnNGUQdAAPRFVn8LktD52RdFAvhdVUTWWl6+hNuS+goyrYVqDeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gy4k4Dy6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy4k4Dy6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A275C6061E
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 02:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLDqCGQszjZz for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 02:49:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C9F41605FD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9F41605FD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gy4k4Dy6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C9F41605FD
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 02:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715741338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtHI1Bhd9NWtrp+GeDGa3Emd+Y2AqBnGkmYsic8ZRZk=;
	b=Gy4k4Dy6sOwqf5iOPXpkWu5vuIQ+6BqxwmIcDHFXld5kfi4Y+8i58+MkbE9dmOX16/nZ4F
	6fFxUhJKTqYv6cTztwzT+2HMyiP4fidyAcFhc/ScsVHFe9mORzPY0oPVfwQtAW5K6ELP0+
	l+Na1KLQaYZJ4yZAJhTUCwikZRrz5XI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-FUPatsY5OJ-bH-bUH7T24g-1; Tue, 14 May 2024 22:48:56 -0400
X-MC-Unique: FUPatsY5OJ-bH-bUH7T24g-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b4348fb84bso5186672a91.3
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 19:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715741335; x=1716346135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtHI1Bhd9NWtrp+GeDGa3Emd+Y2AqBnGkmYsic8ZRZk=;
        b=alkCL9jHdT3truEtWtMg3/+SHxvmo0ajybKJYQrVRvSFh/lNps86HDo9TRrjWqSOgo
         9Y1XAug6HPu2CMJ/Tsg16pvZm6MSOn56xa/LRG8/7IwDqDHAIls4tS/YVgDT0OL96Pk2
         yFPgrNcZn4n5FRBbhvjWHxHn5MC8SKHejlzqOjiGdbjRMkI/L5a+3dkJuD1g3tH1URd3
         2sCBoOSo0Zk9GJqBMylJq0Lpx7BgaD7vLK8mvBjCrVTKLS0KOn68Cg4a/QeAUDvtcRei
         HUXr8ly4X8TFV3Ew/lUeCk4RRLjkb4FIRhO6wZrchJbLVqFvfsGC4a8czgBOh9f7DLF1
         KXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKKWgSFrd57cBySGOszqeqeEuopZUo5Q5kDX0j7jNU/nbLF0olQz0uOKYQ2ahS/Gayl8corYUbjFoCPsPS/2eIyX3Kap1jZcvuwSG6tVXqGuUX1p01xQ0fng==
X-Gm-Message-State: AOJu0Yy02uC97ge/DIdt2MLon8PBHVDEMKAW70Tzit34DEJ5I2zPRjL/
	JhBCkmPJ1m08h8gBWo/wUYrB4hj14dB5anzgsW+Q39i0HEXGtOWOkn7KtloOc/9rcoS6S4yXXrf
	BYKHOKRI0VjDKUWZU1YQni38plpeqzBAMfngDF0kmp7T/MnATpQ3Ad4Lfh2mOzPKLiS7VSHvBjy
	bx9cIHG5jJ7GSsyKHKybiRxdTvavMmwUidboFDmuKQRZNLAiJ83Yd3AeWtpu5WXRIn
X-Received: by 2002:a17:90a:5918:b0:2b5:90f8:d590 with SMTP id 98e67ed59e1d1-2b6cc44fa48mr11618120a91.18.1715741335296;
        Tue, 14 May 2024 19:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Q9Ab5uuZ3wtyOBfo/FOaYePVZUxA0d5QS43POWx81aX4RbzZRg25sv2e9uxsCCKq9Ex0RiLo8UJbmdsTbLo=
X-Received: by 2002:a17:90a:5918:b0:2b5:90f8:d590 with SMTP id
 98e67ed59e1d1-2b6cc44fa48mr11618113a91.18.1715741334886; Tue, 14 May 2024
 19:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1710566754-3532-1-git-send-email-zhanglikernel@gmail.com>
 <CACGkMEs1t-ipP7TasHkKNKd=peVEES6Xdw1zSsJkb-bc9Etx9Q@mail.gmail.com> <CAAa-AGm1gYmeBG1QmZcdc0cPUeVGYU9UaFNdCdgu2+gG88A1Wg@mail.gmail.com>
In-Reply-To: <CAAa-AGm1gYmeBG1QmZcdc0cPUeVGYU9UaFNdCdgu2+gG88A1Wg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 May 2024 10:48:43 +0800
Message-ID: <CACGkMEth_9Baewekq862YgZwuozwG96Z3G6oYqHzyCj2JPUZ3g@mail.gmail.com>
Subject: Re: [PATCH]virtio-pci: Check if is_avq is NULL
To: li zhang <zhanglikernel@gmail.com>
Cc: kvm@vger.kernel.org, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	Michael Tsirkin <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:37=E2=80=AFPM li zhang <zhanglikernel@gmail.com>=
 wrote:
>
> Hi,
> Two months have passed and this bug seems to have not been fixed.
> Sincerely,
> Li Zhang

Adding Michael and virtualization-list.

Please use get_maintainer.pl to make sure the patch reaches the maintainer.

Thanks

>
> Jason Wang <jasowang@redhat.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=9B=9B 14:19=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, Mar 16, 2024 at 1:26=E2=80=AFPM Li Zhang <zhanglikernel@gmail.c=
om> wrote:
> > >
> > > [bug]
> > > In the virtio_pci_common.c function vp_del_vqs, vp_dev->is_avq is inv=
olved
> > > to determine whether it is admin virtqueue, but this function vp_dev-=
>is_avq
> > >  may be empty. For installations, virtio_pci_legacy does not assign a=
 value
> > >  to vp_dev->is_avq.
> > >
> > > [fix]
> > > Check whether it is vp_dev->is_avq before use.
> > >
> > > [test]
> > > Test with virsh Attach device
> > > Before this patch, the following command would crash the guest system
> > >
> > > After applying the patch, everything seems to be working fine.
> > >
> > > Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Thanks
> >
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virt=
io_pci_common.c
> > > index b655fcc..3c18fc1 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -236,7 +236,7 @@ void vp_del_vqs(struct virtio_device *vdev)
> > >         int i;
> > >
> > >         list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> > > -               if (vp_dev->is_avq(vdev, vq->index))
> > > +               if (vp_dev->is_avq && vp_dev->is_avq(vdev, vq->index)=
)
> > >                         continue;
> > >
> > >                 if (vp_dev->per_vq_vectors) {
> > > --
> > > 1.8.3.1
> > >
> > >
> >
> >
>

