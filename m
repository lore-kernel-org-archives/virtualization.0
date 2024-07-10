Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780ED1411ED
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652115; cv=none; b=flgNC5SLEpZCvK6dTzTX3xlyeeZllqRjROV2sU8wijvnTI1fmsZR5q5J1ExW5inFK+c2lGOoqqFkjo+UniBcVGvjbr59uUY11rt2kDM31cf/e+eHqzHvUHBxA9pLHHfeMVi8+o58cHXMVGLPKa13fwtdKvpPoY34vzJGNp0Sj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652115; c=relaxed/simple;
	bh=cDOzi+ZXwS5C7Idx4dnKQ0UYYVdAQXQ23kbJX7qsTSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3J7zsNP++YHPuhQZ9XdzFOhYswWZr+xAobPFJ+mU7SlYHKlQxE4DZ/p2Y7/QzNMBjrswaifHTkPbe/VLnfM8jXycXFnUhwrwLFNQp5MP5G/116ki2oJRDlsBnSoXCTeexpOn27mygjVsVkvdA4RrL1j5RBUrXOg4JBSOdJ1OYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JwCr0Yr/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JwCr0Yr/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so362763a12.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720652111; x=1721256911; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=;
        b=JwCr0Yr/mG25EnHEp5bCXbpv3eLVOF1IS69IOpF4yHw9mGRZ0zZnsFh09GUtcUPA1J
         4r/2c4Rck8Q3DLnemYf6dH+y9xDUzUsdPv4LFsvwvX1NEhU62UzMpyQc1G3rMRp+jp+Q
         IjPzbDFdYF6m7Tv91dxCqbyDE+iwrOoz4QyR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652111; x=1721256911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=;
        b=omnRpfbZ18rRxP/aG0TVp1soW3AbKGDGWINtEcc1OwwPFtAdGxAhWfGLgUI9W18866
         PYY/KhDvjDJ2cu5xF+9q00wMJok6cSPapBEyXiU+5fZ+QTF0jM5SLI2nprmpEwDuyldh
         z7uby2DE4gukZgM41dXFKUCWGEy7EUhjSpM8dSMJlmPzy/NpB0SRMhLd8m1wQiJejUhk
         7fhadvImuqj4XNCNm+dFueGa8Dg+nExQj6JdywToLzyLQGovP3VuXHUgODj+4osff2OJ
         r1VZGCUDJB+Ddb8zwDjqeFBmmK5rEdiI66f89WK88tRdX+buIyiy9In+Z/l8eWB/seHD
         v7GA==
X-Forwarded-Encrypted: i=1; AJvYcCUZdXm9PnwtmHM9FuQFW/zvGBaQP7eluKYicp5cm4Zk2b6GEDhQ9LZecSpq9nzIapuebSK28wpmWk2PHYrZUryDNHed0pMrQUWwXQc6y5s=
X-Gm-Message-State: AOJu0YyRb9w4uds0fkwsQJynJ0BqMoAGZbmBacKCY5GTKBMaWsBCpJzv
	2N4tr3tbLQE6dCOh4UZR1M2QneWCIXKE2akYQaWFC3IodP+baKfT0UyEaWa2YHl03uzej12oH2s
	4edONjPg=
X-Google-Smtp-Source: AGHT+IHbRSaLPJYouovWBTYR+l+4EO7nFxCaIN9iKAxobgIMpfBvXuY53VNe8wIXfkgYz3EDMFY1Lg==
X-Received: by 2002:a05:6402:2707:b0:57c:6234:e95b with SMTP id 4fb4d7f45d1cf-594ba98fafdmr5325806a12.5.1720652111567;
        Wed, 10 Jul 2024 15:55:11 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e81a6sm2710540a12.49.2024.07.10.15.55.09
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 15:55:10 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso42366166b.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 15:55:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbFhtObdrRC9iOU5jJtXYLIPmRmvMJNWuNzKXmdBDoUXXy5qFD9QegP5Sel/sMRk/pDXBrEFGhzVbyLgZgYXGnYlb8vSHZL0NuFsma494=
X-Received: by 2002:a17:907:7f12:b0:a77:db34:42ca with SMTP id
 a640c23a62f3a-a780b88347amr588125666b.49.1720652088624; Wed, 10 Jul 2024
 15:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
 <20240710142239-mutt-send-email-mst@kernel.org> <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
 <20240710162640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710162640-mutt-send-email-mst@kernel.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 15:54:22 -0700
X-Gmail-Original-Message-ID: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
Message-ID: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 10, 2024 at 12:58:11PM -0700, Daniel Verkamp wrote:
> > On Wed, Jul 10, 2024 at 11:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > > > On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > virtio balloon communicates to the core that in some
> > > > > configurations vq #s are non-contiguous by setting name
> > > > > pointer to NULL.
> > > > >
> > > > > Unfortunately, core then turned around and just made them
> > > > > contiguous again. Result is that driver is out of spec.
> > > >
> > > > Thanks for fixing this - I think the overall approach of the patch =
looks good.
> > > >
> > > > > Implement what the API was supposed to do
> > > > > in the 1st place. Compatibility with buggy hypervisors
> > > > > is handled inside virtio-balloon, which is the only driver
> > > > > making use of this facility, so far.
> > > >
> > > > In addition to virtio-balloon, I believe the same problem also affe=
cts
> > > > the virtio-fs device, since queue 1 is only supposed to be present =
if
> > > > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > > > meant to be queue indexes 2 and up. From a look at the Linux driver
> > > > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATI=
ON
> > > > and assumes that request queues start at index 1 rather than 2, whi=
ch
> > > > looks out of spec to me, but the current device implementations (th=
at
> > > > I am aware of, anyway) are also broken in the same way, so it ends =
up
> > > > working today. Queue numbering in a spec-compliant device and the
> > > > current Linux driver would mismatch; what the driver considers to b=
e
> > > > the first request queue (index 1) would be ignored by the device si=
nce
> > > > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> > >
> > >
> > > Oh, thanks a lot for pointing this out!
> > >
> > > I see so this patch is no good as is, we need to add a workaround for
> > > virtio-fs first.
> > >
> > > QEMU workaround is simple - just add an extra queue. But I did not
> > > reasearch how this would interact with vhost-user.
> > >
> > > From driver POV, I guess we could just ignore queue # 1 - would that =
be
> > > ok or does it have performance implications?
> >
> > As a driver workaround for non-compliant devices, I think ignoring the
> > first request queue would be a reasonable approach if the device's
> > config advertises num_request_queues > 1. Unfortunately, both
> > virtiofsd and crosvm's virtio-fs device have hard-coded
> > num_request_queues =3D1, so this won't help with those existing devices=
.
>
> Do they care what the vq # is though?
> We could do some magic to translate VQ #s in qemu.
>
>
> > Maybe there are other devices that we would need to consider as well;
> > commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
> > benchmarks that seem to be from a different virtio-fs implementation
> > that does support multiple request queues, so the workaround could
> > possibly be used there.
> >
> > > Or do what I did for balloon here: try with spec compliant #s first,
> > > if that fails then assume it's the spec issue and shift by 1.
> >
> > If there is a way to "guess and check" without breaking spec-compliant
> > devices, that sounds reasonable too; however, I'm not sure how this
> > would work out in practice: an existing non-compliant device may fail
> > to start if the driver tries to enable queue index 2 when it only
> > supports one request queue,
>
> You don't try to enable queue - driver starts by checking queue size.
> The way my patch works is that it assumes a non existing queue has
> size 0 if not available.
>
> This was actually a documented way to check for PCI and MMIO:
>         Read the virtqueue size from queue_size. This controls how big th=
e virtqueue is (see 2.6 Virtqueues).
>         If this field is 0, the virtqueue does not exist.
> MMIO:
>         If the returned value is zero (0x0) the queue is not available.
>
> unfortunately not for CCW, but I guess CCW implementations outside
> of QEMU are uncommon enough that we can assume it's the same?
>
>
> To me the above is also a big hint that drivers are allowed to
> query size for queues that do not exist.

Ah, that makes total sense - detecting queue presence by non-zero
queue size sounds good to me, and it should work in the normal virtio
device case.

I am not sure about vhost-user, since there is no way for the
front-end to ask the back-end for a queue's size; the confusingly
named VHOST_USER_SET_VRING_NUM allows the front-end to configure the
size of a queue, but there's no corresponding GET message.

> > and a spec-compliant device would probably
> > balk if the driver tries to enable queue 1 but does not negotiate
> > VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
> > whole virtio device initialization process if a device fails like
> > this, then maybe it's feasible. (Or can the driver tweak the virtqueue
> > configuration and try to set DRIVER_OK repeatedly until it works? It's
> > not clear to me if this is allowed by the spec, or what device
> > implementations actually do in practice in this scenario.)
> >
> > Thanks,
> > -- Daniel
>
> My patch starts with a spec compliant behaviour. If that fails,
> try non-compliant one as a fallback.

Got it, that sounds reasonable to me given the explanation above.

Thanks,
-- Daniel
