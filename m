Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F02630F933
	for <virtualization@lists.linux.dev>; Fri, 17 Oct 2025 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683044; cv=none; b=ayL6Rgp/yIiRE8lCkz1wn42Tdqigt8Y1+fR9J2rl9R7fMFBUKvOOWH9BoujvEmMK70ppe1Uogc9qCFa3VcMozMXBbWai9PKgHScD8xs26dno0RncVmH8S1J+kUEc/gjnn7D+jB8zWrXeaLCYw2LKla8APeQGXhAlSl4e4l2RtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683044; c=relaxed/simple;
	bh=Qcu0voj9hrdgpiqdCK/DfKpmv0s/dp2/CJDxI3jdNgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iye8u0j+wUvyIKZkkavfgl8v/wSqwF6dLUt80o2jd7s8452ZBJyJLVAHTRJvn7RJtnsDpCVcQX9w5EinfmvoVNjtsGKIWCh6dM1KGQwSbX8L2EVMiGEcZx8zZtHB4+wQ0UvCjOLcPK6BivAE01ir271g7J/xupQkprvhpF4qp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkIfJyIf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkIfJyIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760683041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVPEUhTlcmrU4AY2xyJSB7iLHlzuDEXvJ647Y8pZBhw=;
	b=RkIfJyIf0QIqMLgu98KxOXKUqGhtxUHR8+OcvMrf188xq6fy/ETES9AdAn8PJ7f8OKCl9N
	VWRX8fbeiwJRWjoX2JLAhRboN84U/W0sba1kH4Kb2hGc1VI+pyv7yrAmfX+CP7nbDoYGSv
	N/O69ptzNy/ykQKfeLmgZPItxTBwgdk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-guwA_13uOwK7xuu5cKCoww-1; Fri, 17 Oct 2025 02:37:20 -0400
X-MC-Unique: guwA_13uOwK7xuu5cKCoww-1
X-Mimecast-MFC-AGG-ID: guwA_13uOwK7xuu5cKCoww_1760683039
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7830e1f9cbcso21045437b3.3
        for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 23:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683039; x=1761287839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVPEUhTlcmrU4AY2xyJSB7iLHlzuDEXvJ647Y8pZBhw=;
        b=G7pQNV17NcVq2ACHOWBDROWyBq2u36Hh9gZywlZdmUBfb+WRirWEHc9sZ8P//eFJz1
         MXQCAS0IuH/xmho3jI5w8loMNJAxuXHhnJWuk2C8U6d+xetgPyOkgGeDceKtPLGC2dP6
         WsFAa4xWb93vG3ZuhLrq0S3UL/j249lLHPNLfPpGzO4TyXSdmHnuenDHO6nG0f5ANFnS
         V66RA0kYQmxG0/+L/cd1XEWKG7g4WOU1X461wP0CPFqSXTuv0BfsZPRmetG2aaVwC9Ts
         v6TaXPoKR85TalP+C6OX+krpnk5Xv6Pc/7pg5sT1Dqh1TVHBKpsMAQPzw+zc99sxCQHi
         0HlA==
X-Forwarded-Encrypted: i=1; AJvYcCU+WH/2CjvwyA2JH34CEqK3wzxHvYQpalxGRCb3ywMNzgNJ7ZLGlpn/1S7lQOlLbL4QnGFc4q7xUH/oELuSpw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9vnqs5cSFeylMa8YUU2sAplqfMb37PQ/tCdW748Azmbe9FFUi
	8gRAE8A99WU+feGs/ZYubsbuh9WNs9lMxr/le50VeTgoh3UAdnZrqx+S3ONVjJ5H5qMeaAPJeXN
	Uoe0C+MXTOk3t2Hd0NybXInXCvrn/MUeWUmmgK9tjCTqLMfDw9Fw0UIT1rUDHvEq14i9fGzoVEf
	bRP0m1i/+kPak/Yvi+7BLXLhoLgowUvTZLEwkjXiChAPw=
X-Gm-Gg: ASbGncud/8kVvI0gedg18cB+R7PbZOmDjV2ehdOt1nR8jV/uFO1lclejGuNkAokRGBY
	oWaFRaJgxwTV8F1qQKM9RTJLhwqLYKZBmNxEnk2E7P1tesYNOG+o9zOP0pXAt0bwvfBlWOCwkn4
	ieNhLabYDPVZUB6Fgog4ogT8PCplTrLW98LcG+D1cLIMiMYqlZEgcOxvsUzW01fgXYtCn7yrfJk
	Y2xkMD8Fxl8u5jJM6bbytJ8KXoweqF5CH5y7wvUMCM=
X-Received: by 2002:a05:690e:c4c:b0:63e:1031:9a28 with SMTP id 956f58d0204a3-63e161c5ff7mr2014939d50.54.1760683039536;
        Thu, 16 Oct 2025 23:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtSwoSEs4kt9mguC8Oet1mtmXNRNZhiqdqTsuW1zufshaYk2wOu+hAd6ufjfhx4GwL1lz6B7sR9Ovqj8JADE0=
X-Received: by 2002:a05:690e:c4c:b0:63e:1031:9a28 with SMTP id
 956f58d0204a3-63e161c5ff7mr2014934d50.54.1760683039161; Thu, 16 Oct 2025
 23:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org> <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org> <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
In-Reply-To: <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 17 Oct 2025 08:36:41 +0200
X-Gm-Features: AS18NWCFqqjar2lhKjBeI0da8CX2K34WY0phDemf1POFD9rfn-8zzoZgAK5KT4o
Message-ID: <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wP0GBgtdk1Qfw-ZSe9T2M03Hut4SyWoVAMePQQG_w6U_1760683039
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 8:25=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > >
> > > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > > have no effect.
> > > > >
> > > > > Note that there's a case that multiple commands need to be sent, =
e.g
> > > > > set rx mode. And assuming not all the commands are the best effor=
t,
> > > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > > while.
> > > >
> > > > Not wait, record. Generate 1st command, after userspace consumed it=
 -
> > > > generate and send second command and so on.
> > >
> > > Right, that's what I asked in another thread, we still need a timeout
> > > here.
> >
> > we do not need a timeout.
> >
> > > Then I think it would not be too much difference whether it is
> > > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > > can only advertise NEEDS_RESET since it's a device implementation.
> > > VDUSE can not simply break the device as it requires synchronization
> > > which is not easy.
> > >
> > > > But for each bit of data, at most one command has to be sent,
> > > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > > the latest state.
> > >
> > > Yes, but I want to know what's best when VDUSE meets userspace timeou=
t.
> > >
> > > Thanks
> >
> >
> > userspace should manage its own timeouts.
> >
>
> Can we just apply the patch 2/2 of this RFC directly and apply the
> VDUSE CVQ on top then? What are we missing to do it?
>

Even better, can we just revert commit 56e71885b0349 ("vduse:
Temporarily fail if control queue feature requested") ?

