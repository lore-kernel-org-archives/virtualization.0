Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815812EBEA
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267945; cv=none; b=NwrlZXmXxk+mLo2dske5hxc2QyDKjkHDb9t2ep1GmSMKGieykZiJoT2dIhZsT5+0KlPXK+CYxe0gG6eGKDeBSMAugfePbN79r61C4NcYLJVRnejQ8iBiffaDL5ZFbBmeb6D7sZIZYk/r6Jnkw86B16MMkml+3Ser04WE1IYQ8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267945; c=relaxed/simple;
	bh=jLsXe+caJI4qfPC9maQ8yJiJHKBFxjWKjboGtLFZ44Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1TPJAQQqXVdfzjArmexgTno2shq31lPBDhaIpQj4snGbJ6GtAejp5yl8cicpgZiaK+yKs+fqlOaHe5qlcnK+8zCvswBMThSXBSfp0KMGoBl+Lk37KaRt7CtLXaDh/HpqlDZheF1zsHaWlRAZqECEloez0Qm29b+Z5qk1+kQig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn7il10f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn7il10f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725267942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yl/+7diA2SKHvAxd7Br7OGqXTfXuQ8DMdZAp+CxC8VE=;
	b=Nn7il10fMk3oLuQD6mPe/b0FFN2MVQp2iCRQUvlib31wtT6pNQqnmg4qBuyA6LGhLoN4AL
	xAAB5V5Xntigl4mHINhLv89hEKaOlPWfB5gAhOrbQ5CP5oQnDJEEr8i64eLzSvYiM2uVZh
	eBy6BXRGoY+x2ZuDY6b3wIGNuoQ0N/s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-LxJXdj_UNwuPFkqsD4vVIw-1; Mon, 02 Sep 2024 05:05:41 -0400
X-MC-Unique: LxJXdj_UNwuPFkqsD4vVIw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c251bcb728so881681a12.2
        for <virtualization@lists.linux.dev>; Mon, 02 Sep 2024 02:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267940; x=1725872740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl/+7diA2SKHvAxd7Br7OGqXTfXuQ8DMdZAp+CxC8VE=;
        b=p5n4T74pfsQdoyFlbIKOYBg8nrTQmRtk9RBForlcTQ3MStjlx6FSglmfWAUemn7sYX
         ZSW7svTknwdy9DNUxys3yIlAZGpwSvXmsXc3xSzE5U6PFG/ARKjwu3tNVpIg3Sau9iag
         w725ozOdbKCNDouhyfQHpsXQveyJG3t2ky++ZnIPE+MlObHPkCi4mL/PoRrY/QQXQj5X
         61v/GpK0cepyWqMKCu8oNO8IifEIEpu1eJzzy2TpkGSRnc+6IeS2X/XirPVB6Iam2hgJ
         KmZJtRqSSGC/JNuq9bmS0JNVjJ4AJk+Rx4UjkRh7Ydw99lzPPPvTLCXDxnZS52RExYX8
         jJLw==
X-Forwarded-Encrypted: i=1; AJvYcCWDUvsGfoQQwrja9Z1cs7qFzSFI4ntlwdFJeAkhS27A9i5DSR8SoSPsAAiYYPoF4UsNzv323jWHnvNCLE6epA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhK9P19GYdFJvJ4BVX/mjdMvxEveSBaqDW9Z0e1CvUVlAgxotk
	yC2V2cZnYmsByucSz23Uqjvv5m60XTBoTMGgbclitjSrdcbE6rd9GmFh8brFzlje4zw6MzHnu38
	qIzjNVjFI6sbgV756dZa0+YSSXsvhMzYBFB3ZlgAo7HIt5ylVaGSA33kt8lH0IsbvQuBva9frvC
	H2w7y8+QK0keCJ5b1zDEWYU6TaGOPgWMMwNZ1xcpo=
X-Received: by 2002:a05:6402:26d2:b0:5c2:1298:35ee with SMTP id 4fb4d7f45d1cf-5c243724727mr4288536a12.2.1725267939794;
        Mon, 02 Sep 2024 02:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPJNx7l/OE5XOyhaGq5fVqlPbzCCg0Nm7WCBI69Iyu75oP5ZB/jcx4ZvNGdTQOPhcLxJnyLBPqTnG/xY3ey+4=
X-Received: by 2002:a05:6402:26d2:b0:5c2:1298:35ee with SMTP id
 4fb4d7f45d1cf-5c243724727mr4288513a12.2.1725267939247; Mon, 02 Sep 2024
 02:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com> <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com> <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com> <CACLfguUZVDGaY4MD+_tDqM9DQC-C6cuPfCf34X59e2RkMztEkA@mail.gmail.com>
 <cfece74e-a979-4f74-8a6a-fc8869e354f7@nvidia.com> <750da215-adea-422c-8130-7524671a8779@nvidia.com>
 <CACLfguWu=1aZ=mhtzMGXGG2s3iG-SVAFB8QkObWfg+npdV0X9g@mail.gmail.com> <4936c228-a3e6-4dc3-a8b4-0f9706e7541f@nvidia.com>
In-Reply-To: <4936c228-a3e6-4dc3-a8b4-0f9706e7541f@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 2 Sep 2024 17:05:01 +0800
Message-ID: <CACLfguVibPU_WzvRKJ7oVN+SaFy1YYysPbmBWEfdYgFjYc-h0Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sept 2024 at 16:54, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
>
>
> On 02.09.24 10:40, Cindy Lu wrote:
> > On Fri, 30 Aug 2024 at 22:46, Dragos Tatulea <dtatulea@nvidia.com> wrot=
e:
> >>
> >> Hi Cindy,
> >>
> >> On 30.08.24 15:52, Dragos Tatulea wrote:
> >>>
> >>>
> >>> On 30.08.24 11:12, Cindy Lu wrote:
> >>>> On Thu, 29 Aug 2024 at 18:00, Dragos Tatulea <dtatulea@nvidia.com> w=
rote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 29.08.24 11:05, Cindy Lu wrote:
> >>>>>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 28.08.24 11:00, Cindy Lu wrote:
> >>>>>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> w=
rote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatul=
ea@nvidia.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> When the vdpa device is configured without a specific MAC
> >>>>>>>>>> address, the vport MAC address is used. However, this
> >>>>>>>>>> address can be 0 which prevents the driver from properly
> >>>>>>>>>> configuring the MPFS and breaks steering.
> >>>>>>>>>>
> >>>>>>>>>> The solution is to simply generate a random MAC address
> >>>>>>>>>> when no MAC is set on the nic vport.
> >>>>>>>>>>
> >>>>>>>>>> Now it's possible to create a vdpa device without a
> >>>>>>>>>> MAC address and run qemu with this device without needing
> >>>>>>>>>> to configure an explicit MAC address.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>>>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>>>>>>>>
> >>>>>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
> >>>>>>>>>
> >>>>>>>>> (Adding Cindy for double checking if it has any side effect on =
Qemu side)
> >>>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>>
> >>>>>>>> But Now there is a bug in QEMU: if the hardware MAC address does=
 not
> >>>>>>>> match the one in the QEMU command line, it will cause traffic lo=
ss.
> >>>>>>>>
> >>>>>>> Why is this a new issue in qemu? qemu in it's current state won't=
 work
> >>>>>>> with a different mac address that the one that is set in HW anywa=
y.
> >>>>>>>
> >>>>>> this is not a new bug. We are trying to fix it because it will cau=
se
> >>>>>> traffic lose without any warning.
> >>>>>> in my fix , this setting (different mac in device and Qemu) will f=
ail
> >>>>>> to load the VM.
> >>>>> Which is a good thing, right? Some feedback to the user that there =
is
> >>>>> a misconfig. I got bitten by this so many times... Thank you for ad=
ding it.
> >>>>>
> >>>>>>
> >>>>>>>> So, Just an FYI here: if your patch merged, it may cause traffic=
 loss.
> >>>>>>>> and now I'm working in the fix it in qemu, the link is
> >>>>>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com=
/
> >>>>>>>> The idea of this fix is
> >>>>>>>> There are will only two acceptable situations for qemu:
> >>>>>>>> 1. The hardware MAC address is the same as the MAC address speci=
fied
> >>>>>>>> in the QEMU command line, and both MAC addresses are not 0.
> >>>>>>>> 2. The hardware MAC address is not 0, and the MAC address in the=
 QEMU
> >>>>>>>> command line is 0. In this situation, the hardware MAC address w=
ill
> >>>>>>>> overwrite the QEMU command line address.
> >>>>>>>>
> >>>>>>> Why would this not work with this patch? This patch simply sets a=
 MAC
> >>>>>>> if the vport doesn't have one set. Which allows for more scenario=
s to
> >>>>>>> work.
> >>>>>>>
> >>>>>> I do not mean your patch will not work, I just want to make some
> >>>>>> clarify here.Your patch + my fix may cause the VM to fail to load =
in
> >>>>>> some situations, and this is as expected.
> >>>>>> Your patch is good to merge.
> >>>>> Ack. Thank you for the clarification.
> >>>>>
> >>>>> Thanks,
> >>>>> Dragos
> >>>>>
> >>>> Hi Dragos=EF=BC=8C
> >>>>  I think we need to hold this patch. Because it may not be working
> >>>> with upstream qemu.
> >>>>
> >>>> MLX will create a random MAC address for your patch. Additionally, i=
f
> >>>> there is no specific MAC in the QEMU command line, QEMU will also
> >>>> generate a random MAC.
> >>>> these two MAC are not the same. and this will cause traffic loss.
> >>> Ahaa, it turns out that qemu 8.x and 9.x have different behaviour.
> >>>
> >>> Initially I was testing this scenario (vdpa device created with no ma=
c
> >>> and no mac set in qemu cli) with qemu 8.x. There, qemu was not being
> >>> able to set the qemu generated random mac addres because .set_config(=
)
> >>> is a nop in mlx5_vdpa.
> >>>
> >>> Then I moved to qemu 9.x and saw that this scenario was working becau=
se
> >>> now the CVQ was used instead to configure the mac on the device.
> >>>
> >>> So this patch should definitely not be applied.
> >>>
> >>> I was thinking if there are ways to fix this for 8.x. The only feasib=
le
> >>> way is to implement .set_config() in mlx5_vdpa for the mac
> >>> configuration. But as you previousy said, this is discouraged.
> >>>
> >> I just tested your referenced qemu fix from patchwork and I found that
> >> for the case when a vdpa device doesn't have a mac address (mac addres=
s
> >> 0 and VIRTIO_NET_F_MAC not set) qemu will return an error. So with thi=
s
> >> fix we'd be back to square one where the user always has to set a mac
> >> somewhere.
> >>
> >> Would it be possible to take this case into consideration with your
> >> fix?
> >>
> >> Thanks,
> >> Dragos
> >>
> > Hi Dragos
> >
> > Thanks for your test and help, I think I can add a check for
> > VIRTIO_NET_F_MAC in the qemu code. if the device's Mac is 0 and the
> > VIRTIO_NET_F_MAC is not set. The guest VM will fail to load. I will
> > double-check this
> My request was to use the random MAC from qemu in this case. qemu is
> able to configure the device via CVQ. At least this device...
>
Ok, I got it. Sorry for my misunderstanding. I understand what you
mean. Then the device needs to set the bit VIRTIO_NET_F_CTRL_MAC_ADDR
to use CVQ. I will verify this and change my patch.
Thanks
Cindy
> Thanks,
> Dragos
>

