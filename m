Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AF311C36
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524651; cv=none; b=cvXtx/ivFBAopPPrEYdZK2lNR7sgGLotP+idIvu/IVSABTBsk2Hoif5VnqiCyGYlNuzJBdgLQszVBeSrA9kB4gHzDldvv557xkxDTIhwmRkFdY4E4JFjejN06tuNLG/Z4j0ULz7O8PfCUjS/cvFXQ0l1cDHI2V9fgScNxoa/EqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524651; c=relaxed/simple;
	bh=s2JXUbp0DYNFUksSB7dqNSV0t8IjpdOa3Cgcl2SjNIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fh9PRYqwExAj2qtlXT0Oi0Zl+vH1ireMY31961yT4I0AWBg5Ow2Udn9zGXe2dFulDvAeJyWxfVoyJ+WElQJlDdJaiAtLkwkHymmWwQzlJ3W4wje4my7iwue2m1f8IATwBFqdzbvU/WGsvHKTkw7hwR6P+o2nZ0bp9bwEeCFjvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHzy3yIa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHzy3yIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760524647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ5OI8qXcU6LeUOVXf33r3M+T7rLK5h6AAwB4S0iIqA=;
	b=FHzy3yIalCXTl7nJJyN9bV/ssagSS7bwJGF5mIMr8g1db8cwMS3c8P+Zkb9I6N0g4uQgyR
	gzqSiMKmCqiU1vhTKt294pgceZgaPYPt0YfnL3DM7RG5wczHJhY3miCMG03f0rBQt/wuy5
	aeHfc+Zrehkyw/EUGThq5NgZdF2Gmr8=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-qEZBD0Z_OuO87qPYC7k4lg-1; Wed, 15 Oct 2025 06:37:26 -0400
X-MC-Unique: qEZBD0Z_OuO87qPYC7k4lg-1
X-Mimecast-MFC-AGG-ID: qEZBD0Z_OuO87qPYC7k4lg_1760524646
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63d34257de6so289443d50.1
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 03:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524645; x=1761129445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ5OI8qXcU6LeUOVXf33r3M+T7rLK5h6AAwB4S0iIqA=;
        b=JB3REvLeI9iTpvXS1zOYglFpEATheCUv75VtroqR8sdp+AJMOyrr1h39QP30+Ko5a/
         1v1On4htiMc4L0UIlfUC1q3Rre9IzvWIcWUpRm2diWoz3fFGGrlE/JBSfCG2esLaR5ti
         H11fCQ5H1YaQoQMKUdp+6rmvL+xObtavBpgZSwfCyXpdbzg7NVqV9zd/KkHCSW5BTOhq
         co52SaNTRqyIg3DLYju+vmwav1T6+xfyS0j27fKUBYvV1Qb1+jq4c0LtJdBQnYejTDK6
         n1BZZgOraeaNVV2u4u+jZfJSXCAN2IHFJwstyOlXvjJdJUseV5zOLtf5GD9ndRuoffaz
         UBMg==
X-Forwarded-Encrypted: i=1; AJvYcCVXN2Rty0q5/7hevBFGwr/C97B4vp+OpaMWM09Tg7xhXzu4QdX+SqB7nQ5RTiVdZgb+8IzAjrU1p/8/Mp4WhA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxy+JwFKcLDBzzXL/k6xTwcQc/QWwBvewmuPo+R067uM73B1QTu
	bu+Qu/I1DuMBh3c3nsQC+i1V3wW45QlXFSTcm1vdc4W+LkqEdbQa27zG+k1gDJFW+5mePbmeBp1
	ISiSo5eGFHu1uAvEp/wtljBLv6Sv7BknD+kdEkr+sybpppUzLiNRD3i5BHx9VRRt4o3oiYCvMXs
	H1sve5Az8WC3qRubO2Q++O/js0MqOhmkMeSH+m+XbLjvlET0U96uc=
X-Gm-Gg: ASbGncuDWLDddHrGq3Ai/BxeHjj2Bt2z0cw4kbaSkrLywjwdtEygEvahRh/jFW8KdDj
	pECtEpgPRZbou+hF9Dqhc7H9KvGZ4W2Tx6iXUY5jagxgOjq6V+AszRWYhrhfsoxMulzno/RQNvT
	de5j/Efevn2y6Mw1bz1sa841jmI8UUAHZ6kmoMA04j78MfY5mDh2MhVdeFCTTn1L+uiN3CbLNy5
	8uBE2OK
X-Received: by 2002:a05:690e:2c7:b0:633:abda:fce3 with SMTP id 956f58d0204a3-63ccb903b26mr19292017d50.36.1760524644912;
        Wed, 15 Oct 2025 03:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHloSoTDh8INEPlDtU9jlkdkPn/64A75meFhRp+1C+3McE09pWuT2JMM/iqj80sCG6XNefZ+7vtFqlJL08FI4s=
X-Received: by 2002:a05:690e:2c7:b0:633:abda:fce3 with SMTP id
 956f58d0204a3-63ccb903b26mr19292009d50.36.1760524644411; Wed, 15 Oct 2025
 03:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-2-eperezma@redhat.com> <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com> <20251015040722-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251015040722-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 12:36:47 +0200
X-Gm-Features: AS18NWDZxVi03ZJg7QLo3y_kPBWfnIylCoy1tVOlO9_rzeDHCgU5F_37TTxyJKc
Message-ID: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oTBmZ5nwThX-HRaSY5K-F7KwNS3N7DcLqGHbv2__C4w_1760524646
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:09=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> > On Wed, Oct 15, 2025 at 9:45=E2=80=AFAM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <=
mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin w=
rote:
> > > > > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirk=
in <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=
=A9rez wrote:
> > > > > > > > > > > An userland device implemented through VDUSE could ta=
ke rtnl forever if
> > > > > > > > > > > the virtio-net driver is running on top of virtio_vdp=
a.  Let's break the
> > > > > > > > > > > device if it does not return the buffer in a longer-t=
han-assumible
> > > > > > > > > > > timeout.
> > > > > > > > > >
> > > > > > > > > > So now I can't debug qemu with gdb because guest dies :=
(
> > > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Instead, solve it in vduse, probably by handling cvq wi=
thin
> > > > > > > > > > kernel.
> > > > > > > > >
> > > > > > > > > Would a shadow control virtqueue implementation in the VD=
USE driver work?
> > > > > > > > > It would ack systematically messages sent by the Virtio-n=
et driver,
> > > > > > > > > and so assume the userspace application will Ack them.
> > > > > > > > >
> > > > > > > > > When the userspace application handles the message, if th=
e handling fails,
> > > > > > > > > it somehow marks the device as broken?
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Maxime
> > > > > > > >
> > > > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > > > Once you use the buffer you can get another one and so on
> > > > > > > > with no limit.
> > > > > > > > One fix is to actually maintain device state in the
> > > > > > > > kernel, update it, and then notify userspace.
> > > > > > > >
> > > > > > >
> > > > > > > I thought of implementing this approach at first, but it has =
two drawbacks.
> > > > > > >
> > > > > > > The first one: it's racy. Let's say the driver updates the MA=
C filter,
> > > > > > > VDUSE timeout occurs, the guest receives the fail, and then t=
he device
> > > > > > > replies with an OK. There is no way for the device or VDUSE t=
o update
> > > > > > > the driver.
> > > > > >
> > > > > > There's no timeout. Kernel can guarantee executing all requests=
.
> > > > > >
> > > > >
> > > > > I don't follow this. How should the VDUSE kernel module act if th=
e
> > > > > VDUSE userland device does not use the CVQ buffer then?
> > > >
> > > > First I am not sure a VQ is the best interface for talking to users=
pace.
> > > > But assuming yes - just avoid sending more data, send it later afte=
r
> > > > userspace used the buffer.
> > > >
> > >
> > > Let me take a step back, I think I didn't describe the scenario well =
enough.
> > >
> > > We have a VDUSE device, and then the same host is interacting with th=
e
> > > device through the virtio_net driver over virtio_vdpa.
> > >
> > > Then, the virtio_net driver sends a control command though its CVQ, s=
o
> > > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> > >
> > > It does not matter if the VDUSE device in the userland processes the
> > > commands through a CVQ, reading the vduse character device, or anothe=
r
> > > system. The question is: what to do if the VDUSE device does not
> > > process that command in a timely manner? Should we just let the RTNL
> > > be taken forever?
> > >
> >
> > My understanding is that:
> > 1. Virtio-net sends a control messages, waits for reply
> > 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
> > 3. Userspace application dequeues the message from the SCVQ
> >  a. If handling is successful it replies OK
> >  b. If handling fails, replies ERROR

If that's the case, everything would be ok now. In both cases, the
RTNL is held only by that time. The problem is when the VDUSE device
userland does not reply.

> > 4. VDUSE driver reads the reply
> >  a. if OK, do nothing
> >  b. if ERROR, mark the device as broken?
> >
> > This is simplified as it does not take into account SCVQ overflow if
> > the application is stuck.
> > If IIUC, Michael suggests to only enqueue a single message at the time
> > in the SVQ,
> > and bufferize the pending messages in the VDUSE driver.

But the RTNL keeps being held in all that process, isn't it?

>
> Not exactly bufferize, record.  E.g. we do not need to send
> 100 messages to enable/disable promisc mode - together they
> have no effect.
>

I still don't follow how that unlocks the RTNL. Let me put some workflows:

1) MAC_TABLE_SET, what can we do if:
The driver sets a set of MAC addresses, (A, B, C). VDUSE device does
send this set to the VDUSE userland device, as we don't have more
information. Now, the driver sends a new table with addresses (A, B,
D), but the device still didn't reply to the VDUSE driver.

VDUSE should track that the new state is (A, B, D), and then wait for
the previous request to be replied by the device? What should we
report to the driver? If we wait for the device to reply, we're in the
same situation regarding the RTNL.

Now we receive a new state (A, B, E). We haven't sent the (A, B, D),
so it is good to just replace the (A, B, D) with that. and send it
when (A, B, C) is completed with either success or failure.

2) VQ_PAIRS_SET

The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, and
the VDUSE CVQ forwards the command. The driver still thinks that it is
using 1 vq pair. I can store that the driver request was 3, and it is
still in-flight. Now the timeout occurs, so the VDUSE device returns
fail to the driver, and the driver frees the vq regions etc. After
that, the device now replies OK. The memory that was sent as the new
vqs avail ring and descriptor ring now contains garbage, and it could
happen that the device start overriding unrelated memory.

Not even VQ_RESET protects against it as there is still a window
between the CMD set and the VQ reset.

