Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F148F66
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641543; cv=none; b=aW5pBfGZeeWFL8DvWEFIR1yH5IE3yiVJZ7nE4C59KsffctohKnQoGJ3lEd+vkQwZT+oWjoiwTqZzYiH7HgicGq65WhrjjVmJWkfWAwgi2TS8EnUW8tzGzauaADd7LrFeBFybcD+vMXsVcfASffb4A/SWGGpwvua5gQXpbrc5dQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641543; c=relaxed/simple;
	bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGui3tqGnsSVqSIBLaHvw/dOroFFqcXV96mBuEAiBTr8HaGe6uNpf5NrKjUl1s/JG1NkRoX2UU/7bqu2ehJObxHpxIbafbJY9/BJePx94ZyefqpEZOw/1IyXnH0Z6XI3ZNbEaqWdhB53RRXjHJ+oRizTwiKYv/F2XKD49+CMGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iubyoZxP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iubyoZxP"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so1456561fa.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720641540; x=1721246340; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=;
        b=iubyoZxP/HJffVv3gUL+HxF7zuMVMYvX6AnkN92u1VkitTx2IcW2/dyb/9qVoo65cF
         kPG2S84XYLqx2b9KfC71C3voPuzEFQFW8FvBSEf27Ga7qxoKjvYUj4ZqiEElwU/IBlGf
         EcL5Jx2+SqINH2ZkDyA/CC2u2JdzQXbrPZKiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720641540; x=1721246340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=;
        b=L8VnR99Pcel+oR1wJFBiddTL5beJszVYZCuwx2Th5mu76mJeRj8Co0hpynJNybrFQD
         Kl863H3zf8Ipx/dhWmZy8uMCGRkRVQj12lUX1X8SZLpbmP+uaIAYZiWQsPogxpTSjxYn
         DCFD6dfDiip6bVkbPzdU9uQT4LmEZZ2KXbjf2tfw+55eRzDk8ACDXKWqviKXQvO4VvWS
         tZe0IATUojzzOcKc1h3W7aczlTwTLfW7cG39V9+nAoIlnCN3P0D555WZdYjnWzZ9wyop
         GTpXFphQ+IPpzqYqcSeF+dJWKa5iJccaVviOxef1h60UkIF0Nnpb9M3eAfLazldbT72/
         1pUA==
X-Forwarded-Encrypted: i=1; AJvYcCUAAAC6NFmT5U6PLGqYJDB/HvRcOZG3ZPas+j74ixrSJauduWE83zQslaxlXE+wLBmlx3YZwIg6T0yJ2gFZIyFXRbJxHfx92p63WeXYKtI=
X-Gm-Message-State: AOJu0YyoMmzLzlTVpB8S6nf3dKRIyjC8L+CKhuVBcXQYc+2sEN3NJmJ+
	As3wVI52wx5UrbRibB2atbmw1gbkPrpYLNG3ldFzsVHiGn28ZjUan83WEJcNsDKRwFd+jJ4cIqP
	9g2Dn2iY=
X-Google-Smtp-Source: AGHT+IFdQbBak9wcyqhTnCRbVNYMfL5AHKQ+B3l5RgpnJ2t4/4qRRKY+ctdw4hYna6TrY7urxmiCYg==
X-Received: by 2002:a2e:9ed7:0:b0:2ee:8701:787d with SMTP id 38308e7fff4ca-2eeb30fefd8mr51285491fa.24.1720641539646;
        Wed, 10 Jul 2024 12:58:59 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a85457csm183857666b.158.2024.07.10.12.58.59
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:58:59 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so98899a12.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 12:58:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWucaMd0FrG65xg4NalRqHbi6kSh4bujLhbyir09CtbkXgh3gZ87OroZ980fBgOIhPvvm7B0aQm/+5D0kvI2KnkgoqOKJeqpAspl4Peq6w=
X-Received: by 2002:a05:6512:2111:b0:52e:73f5:b7c4 with SMTP id
 2adb3069b0e04-52eb99a3645mr4058074e87.37.1720641518212; Wed, 10 Jul 2024
 12:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com> <20240710142239-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710142239-mutt-send-email-mst@kernel.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 12:58:11 -0700
X-Gmail-Original-Message-ID: <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
Message-ID: <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
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

On Wed, Jul 10, 2024 at 11:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > virtio balloon communicates to the core that in some
> > > configurations vq #s are non-contiguous by setting name
> > > pointer to NULL.
> > >
> > > Unfortunately, core then turned around and just made them
> > > contiguous again. Result is that driver is out of spec.
> >
> > Thanks for fixing this - I think the overall approach of the patch look=
s good.
> >
> > > Implement what the API was supposed to do
> > > in the 1st place. Compatibility with buggy hypervisors
> > > is handled inside virtio-balloon, which is the only driver
> > > making use of this facility, so far.
> >
> > In addition to virtio-balloon, I believe the same problem also affects
> > the virtio-fs device, since queue 1 is only supposed to be present if
> > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > meant to be queue indexes 2 and up. From a look at the Linux driver
> > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> > and assumes that request queues start at index 1 rather than 2, which
> > looks out of spec to me, but the current device implementations (that
> > I am aware of, anyway) are also broken in the same way, so it ends up
> > working today. Queue numbering in a spec-compliant device and the
> > current Linux driver would mismatch; what the driver considers to be
> > the first request queue (index 1) would be ignored by the device since
> > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
>
>
> Oh, thanks a lot for pointing this out!
>
> I see so this patch is no good as is, we need to add a workaround for
> virtio-fs first.
>
> QEMU workaround is simple - just add an extra queue. But I did not
> reasearch how this would interact with vhost-user.
>
> From driver POV, I guess we could just ignore queue # 1 - would that be
> ok or does it have performance implications?

As a driver workaround for non-compliant devices, I think ignoring the
first request queue would be a reasonable approach if the device's
config advertises num_request_queues > 1. Unfortunately, both
virtiofsd and crosvm's virtio-fs device have hard-coded
num_request_queues =3D1, so this won't help with those existing devices.
Maybe there are other devices that we would need to consider as well;
commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
benchmarks that seem to be from a different virtio-fs implementation
that does support multiple request queues, so the workaround could
possibly be used there.

> Or do what I did for balloon here: try with spec compliant #s first,
> if that fails then assume it's the spec issue and shift by 1.

If there is a way to "guess and check" without breaking spec-compliant
devices, that sounds reasonable too; however, I'm not sure how this
would work out in practice: an existing non-compliant device may fail
to start if the driver tries to enable queue index 2 when it only
supports one request queue, and a spec-compliant device would probably
balk if the driver tries to enable queue 1 but does not negotiate
VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
whole virtio device initialization process if a device fails like
this, then maybe it's feasible. (Or can the driver tweak the virtqueue
configuration and try to set DRIVER_OK repeatedly until it works? It's
not clear to me if this is allowed by the spec, or what device
implementations actually do in practice in this scenario.)

Thanks,
-- Daniel
