Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1931282A
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126412; cv=none; b=YRoSRQfofIbPkNEHzXLELsfLs6+Fo/oRYdLo6JB0XJrpDpdPzpkuroq7CkYY4oE14dtzrX2S+pvpM34zjjw3gOg2BfPHt5fjnwum+N4KgCGDzEyXRJxKa0soep9cm9TGVsvBfmSk22p5Al9SSYuC8rdNzNhdoGxI2ELaHqsK48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126412; c=relaxed/simple;
	bh=88E2EGzq2n20YrkFy9dxISpv1QvuEY8V4SnO7qKbctg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U04qKX7AJqagfekr34sz4CV5sv+Uf3BQ+MtpHMIqfIwC+9GUFPY2ISL41dF5LXNw+erc18+LCNzoji5NauS2OlCtqtAv+g3m2CnU7K82hQi3mkrT0TzKTrYv5/SdqtQDsw1yPns9kj6K/BDlXg8hOmB24lNhP2oivEtxPHRtYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVGtk68J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVGtk68J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761126408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipyfXFOy/lX9dgJ8MKg8vYqWY4/Yh7BKK6Ctsb29TBQ=;
	b=bVGtk68JDHU2xmA/Yj5vZGm3Hlud/qd3E/t2+Glm4BxWznolLMD17PIsv0yUJ1N6Yysqsn
	P3qeGVRKAiJ1G+LaACvcuNvhMH5Ui7+nh19Z8bmOanaj51J+OPHrtkAdejJBNBkjPRQNMe
	aulXJ6AsV1FbDNr1WGJAmx4sVzYoHX8=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-NAUVDEiPOw2NUEwWP3WNNQ-1; Wed, 22 Oct 2025 05:46:47 -0400
X-MC-Unique: NAUVDEiPOw2NUEwWP3WNNQ-1
X-Mimecast-MFC-AGG-ID: NAUVDEiPOw2NUEwWP3WNNQ_1761126407
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-636d73ba36bso8511662d50.3
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 02:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126407; x=1761731207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipyfXFOy/lX9dgJ8MKg8vYqWY4/Yh7BKK6Ctsb29TBQ=;
        b=vjCkiowxP6aLE8z3iTdpKzTPXiO64SwhqvjON16tVBadGhhYqfGU5gv/6DX9fKrTpm
         3SUgCMxDyFC2jWUMYrKKaUU4dEG9KWdGJix/iGfqEFk2/5z5zgvh0fQebZILTjLPosp2
         4FQ6m1sBqnlCinyhRthgT+OxO7IPkA1Py7p2OeiSloK9MFLXGjveHhTD7rc6Q0uDCpVm
         Od5yADqlmRaEuh9nOGmeYywcsqH2meQCzc9eezNkoDcSxbvv6tFMxxPJqTIoEGPGDIzk
         ZuexpQgGeNKfZNAOHEOK9rKsLpS39eekDBPSx2uxEYC1VNWkWyRUdgDSvfxPjCJkwAud
         NcMg==
X-Forwarded-Encrypted: i=1; AJvYcCUtpfSjPs0tEWBM/Xw0IS30K/C+KzQwOA+sjNKJjyO8ME0yZxfiQtfqVsqimWAK1Rapt8iwqr+6IbD062zLFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfpRfG/i+yiswW2PnvEd6EXU9p/Af1aeJIYl3f1IHNQWxf4XV6
	+eV2sNpN20YGhEYB4ieWoAWN+6ZBRxPfWcyQz7KJfsao/YRSC8cDyIqesFaNvbk0TtP/Qv3OKCP
	T3oWiCYVcTIKymJ8K6zh7tI1YVJx38WjIJfVD6oiLH1flORgc45FAZ+BtH6lH8fBPDVADWpqe+W
	INfBW7P77Tmo8bd7o4BUYJLWBhAOmjsjkh6cQFgkuZJA8=
X-Gm-Gg: ASbGncvZr9Q4Y5Ni8cn2ZqpNEnPCw4+6PA1Bi9L9ZPPt4Izr35kMO/s7Wq8KZW38ykv
	FJvq/WN/NvBJlCRdolRYhM/u34ClLhq71Aor1cxiJNEVvcI+6lmZRvg7neUkYurzdVk2Ahrb9KE
	pWlaDmqouh1ygkNNZzeWR4lIFISeIbUAhF3EwKBoSzJ09ahDaBZXep2N0d9KbBZ6tz3NqTonVP9
	P5m+TCQkQlJORcva290LbFUITeF0E0Cut3WCknF+EIf5Tf/M/LynZ65EOfeaF74gxdeNJEvji2K
	Rk0=
X-Received: by 2002:a53:b10a:0:b0:63f:2db0:997c with SMTP id 956f58d0204a3-63f2db09c49mr743765d50.68.1761126407110;
        Wed, 22 Oct 2025 02:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvur6oK5c8R3K/TCjDX5FSuFjRyp8F3CzZFjcaXGe/kEmJx7VQHl4dG08fr+fgIFPtV66OaqY0dHi5diadPNA=
X-Received: by 2002:a53:b10a:0:b0:63f:2db0:997c with SMTP id
 956f58d0204a3-63f2db09c49mr743754d50.68.1761126406818; Wed, 22 Oct 2025
 02:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org> <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org> <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
 <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com>
 <20251017023902-mutt-send-email-mst@kernel.org> <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
In-Reply-To: <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 Oct 2025 11:46:10 +0200
X-Gm-Features: AS18NWDw4vr0GcTnGRr8VlHsu1oogGDTd7bG2v29nWusnnH3ymm68p-CAB7l3Fo
Message-ID: <CAJaqyWcGbqRP+KfhtOMLtYA_dNB0d0SvTKLrsH7zYU4CrZb+3g@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XzIWYpaesRs_Ny6dQu0VJLcr0O2hbuqcxVzjYidqtWo_1761126407
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:21=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Oct 17, 2025 at 8:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Oct 17, 2025 at 08:36:41AM +0200, Eugenio Perez Martin wrote:
> > > On Thu, Oct 16, 2025 at 8:25=E2=80=AFAM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > > > > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > > > > >
> > > > > > > > > > Not exactly bufferize, record.  E.g. we do not need to =
send
> > > > > > > > > > 100 messages to enable/disable promisc mode - together =
they
> > > > > > > > > > have no effect.
> > > > > > > >
> > > > > > > > Note that there's a case that multiple commands need to be =
sent, e.g
> > > > > > > > set rx mode. And assuming not all the commands are the best=
 effort,
> > > > > > > > kernel VDUSE still needs to wait for the usersapce at least=
 for a
> > > > > > > > while.
> > > > > > >
> > > > > > > Not wait, record. Generate 1st command, after userspace consu=
med it -
> > > > > > > generate and send second command and so on.
> > > > > >
> > > > > > Right, that's what I asked in another thread, we still need a t=
imeout
> > > > > > here.
> > > > >
> > > > > we do not need a timeout.
> > > > >
> > > > > > Then I think it would not be too much difference whether it is
> > > > > > VDUSE or CVQ that will fail or break the device. Conceptually, =
VDUSE
> > > > > > can only advertise NEEDS_RESET since it's a device implementati=
on.
> > > > > > VDUSE can not simply break the device as it requires synchroniz=
ation
> > > > > > which is not easy.
> > > > > >
> > > > > > > But for each bit of data, at most one command has to be sent,
> > > > > > > we do not care if guest tweaked rx mode 3 times, we only care=
 about
> > > > > > > the latest state.
> > > > > >
> > > > > > Yes, but I want to know what's best when VDUSE meets userspace =
timeout.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > userspace should manage its own timeouts.
> > > > >
> > > >
> > > > Can we just apply the patch 2/2 of this RFC directly and apply the
> > > > VDUSE CVQ on top then? What are we missing to do it?
> > > >
> > >
> > > Even better, can we just revert commit 56e71885b0349 ("vduse:
> > > Temporarily fail if control queue feature requested") ?
> >
> > No because both would let userspace hang kernels merely by
> > not consuming buffers.
> >
>
> My understanding was that you want to be able to debug qemu with gdb
> from that hang [1].
>
> Could you put an example of the whole chain of events you expect? From
> the moment the driver sends a VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command,
> the VDUSE CVQ Forwards the command to the VDUSE device in the
> userspace, and then the vduse userland device does not reply.
>
> How does the VDUSE CVQ detect that the VDUSE device implemented in
> userland does not reply? What are the next steps from that point of
> the kernel VDUSE module?
>
> Thanks!
>

Friendly ping!

