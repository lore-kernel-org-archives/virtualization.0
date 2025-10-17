Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389BF23EA94
	for <virtualization@lists.linux.dev>; Fri, 17 Oct 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685718; cv=none; b=ewCph94G28ppoXI7CgftGFxv9gOhH30ujyfepjRiDGCi2Dn+kAzF5gx0Wan94uaxsf72c9IbfdSr29jMGNNBnnSweI8XIFPpoGDw7EYOt2r0vmcctIsawWKnS1hQMDSQc+HR7v4/RuzPG9XMvfdT7sYfmY0HqTW5PbQTFQOvxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685718; c=relaxed/simple;
	bh=klMwGirUZdc/9en6gVNRoYBq4q9YFhZSrvAPxBrsxO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mckW4VxO0UNLfFRoKnCu0X7MgcaTS8ufYq+DljgXeuCyLp+InCX6cR48pnl7PRGDfymXK+Hie0hGZUVhH4Fz1O3ARsO4hkb/PmR09Y7Fqb42xw6m4CDaFpwVYqmP1mE/jSnte9eJDhhnM6jad625rZ98aUKZLuM3xEgJ6ZFrPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW2Rpdfh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW2Rpdfh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760685716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v28vvTjtPo8MKw10asWnJl+FMQDqDxLQM+r4bXZie6U=;
	b=EW2RpdfhFJRQAIiog38GQTEpjzlyeYUf3ayceJq/ZpzAJZK1US1q5JsJhatee48BQHv2rs
	DmE8j3laM+qJF9t6JX3vdhZnsGq0DfIX1hr0My51Ojg8IQjoWMD4yF1+KkBw8KOaqIUyMJ
	OToGldTnnVMSsYtfNRA8wQttP1nVK2Q=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-pZuEpBa0NVGQKrSgiy0YXQ-1; Fri, 17 Oct 2025 03:21:54 -0400
X-MC-Unique: pZuEpBa0NVGQKrSgiy0YXQ-1
X-Mimecast-MFC-AGG-ID: pZuEpBa0NVGQKrSgiy0YXQ_1760685714
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63d34257de6so2378985d50.1
        for <virtualization@lists.linux.dev>; Fri, 17 Oct 2025 00:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685714; x=1761290514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v28vvTjtPo8MKw10asWnJl+FMQDqDxLQM+r4bXZie6U=;
        b=JstlDwHcpLMfC09qJhOYygpP5C33XyaJ5TQUBxlzbHkzG7RfoRA5r8x6N+65XRfaWY
         1NEdytPUJpBGWTiJHSnFQuybZADXAideNDfQj0QQecZRKBXpCO005eJnlnDOCe9xT/6E
         OXsPSpajyF7bm3Si486+SEIlqUGS8m/3j6ZWFWrVbGJWJudvc2dHU3L37xea9rFhRrkY
         6z97OvBz4Dbh7gMIGjWIIkDb7JT1FI3W3odd3MIXF7kOdnLllgBX8eY6xzHcsS3+LsTX
         NwXgDY7+U5qaxmZJOZ/CzjZP4OFUXA0S264+lUzZBnIUxaegNC9iScTZWnrr/4qu51p/
         3EyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdKHKJdUlrMQz/HaZZnw6UM5J4PxHkhl52ISVjLeZTEhsXjtXIEys7KRqwqwhNIp34Af5nCdXBFad20zCjIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUUW9AEIJ2pKy3+wY+mWmgR2McGAT4yQwU+3T9u3WHjqJphvyU
	9fgJPMkaB6AXj6Dp42DbkA6XFnC8rvQLIm6kEMLypugJF6WNJmrxxdIhm3xBVIjle3H20F+m/uJ
	lQ3maSb/y8AZlG57G/PXk9RJz+3UGiiRzV4qD/9v9VNucqT7rGwJfq3LScu/9qOLhnWRVdhenrT
	GDPAHfnQMBU1PKuWdg5Dd6iD7uopSKnBdlVIfpdBfHwM4=
X-Gm-Gg: ASbGncvCDjJSllua8vLsFToeV94s7E9hA1dC/DhZA2NXgFTJv/1GkZutO+nw6zQ3HI0
	kM0nTPWZIqcIIo6JugxnvlJe3KviXoXaVHoqeOMBJqwtxPHp4eYuwTrtwq2lbMkAjO6w6xiUCFH
	r1ESfx29oMdcRjKN9Gs9sl6llFZXtZ9SrSO9KwS62h+Okhj+IDLY+B/kAoL57GCWygT6xd14TVQ
	aod4cpiY0PRbxPVfX+StEafzaASba2tBC0mv+gpopU=
X-Received: by 2002:a05:690e:dcf:b0:5f3:319c:ff0a with SMTP id 956f58d0204a3-63e16157b37mr3030394d50.28.1760685714178;
        Fri, 17 Oct 2025 00:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZwyPhDZHU7dOLNaIR4lfmJjGqqnoPu3JOnms4GhUSITGKnhrHsbO/qlmNv1p1/X6EDYY+QAN377bA156xF9M=
X-Received: by 2002:a05:690e:dcf:b0:5f3:319c:ff0a with SMTP id
 956f58d0204a3-63e16157b37mr3030377d50.28.1760685713838; Fri, 17 Oct 2025
 00:21:53 -0700 (PDT)
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
 <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com> <20251017023902-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251017023902-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 17 Oct 2025 09:21:17 +0200
X-Gm-Features: AS18NWAqq13vIx4wyqpvwIq_0fwtZxgXGnFG57EyRZguYWfSvJx_PPst438uNPs
Message-ID: <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YnNW_SI0NubXgY7XRDWHguMFDp3FRzMo_dKB3pYVfnc_1760685714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 8:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Oct 17, 2025 at 08:36:41AM +0200, Eugenio Perez Martin wrote:
> > On Thu, Oct 16, 2025 at 8:25=E2=80=AFAM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > > > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > > > >
> > > > > > > > > Not exactly bufferize, record.  E.g. we do not need to se=
nd
> > > > > > > > > 100 messages to enable/disable promisc mode - together th=
ey
> > > > > > > > > have no effect.
> > > > > > >
> > > > > > > Note that there's a case that multiple commands need to be se=
nt, e.g
> > > > > > > set rx mode. And assuming not all the commands are the best e=
ffort,
> > > > > > > kernel VDUSE still needs to wait for the usersapce at least f=
or a
> > > > > > > while.
> > > > > >
> > > > > > Not wait, record. Generate 1st command, after userspace consume=
d it -
> > > > > > generate and send second command and so on.
> > > > >
> > > > > Right, that's what I asked in another thread, we still need a tim=
eout
> > > > > here.
> > > >
> > > > we do not need a timeout.
> > > >
> > > > > Then I think it would not be too much difference whether it is
> > > > > VDUSE or CVQ that will fail or break the device. Conceptually, VD=
USE
> > > > > can only advertise NEEDS_RESET since it's a device implementation=
.
> > > > > VDUSE can not simply break the device as it requires synchronizat=
ion
> > > > > which is not easy.
> > > > >
> > > > > > But for each bit of data, at most one command has to be sent,
> > > > > > we do not care if guest tweaked rx mode 3 times, we only care a=
bout
> > > > > > the latest state.
> > > > >
> > > > > Yes, but I want to know what's best when VDUSE meets userspace ti=
meout.
> > > > >
> > > > > Thanks
> > > >
> > > >
> > > > userspace should manage its own timeouts.
> > > >
> > >
> > > Can we just apply the patch 2/2 of this RFC directly and apply the
> > > VDUSE CVQ on top then? What are we missing to do it?
> > >
> >
> > Even better, can we just revert commit 56e71885b0349 ("vduse:
> > Temporarily fail if control queue feature requested") ?
>
> No because both would let userspace hang kernels merely by
> not consuming buffers.
>

My understanding was that you want to be able to debug qemu with gdb
from that hang [1].

Could you put an example of the whole chain of events you expect? From
the moment the driver sends a VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command,
the VDUSE CVQ Forwards the command to the VDUSE device in the
userspace, and then the vduse userland device does not reply.

How does the VDUSE CVQ detect that the VDUSE device implemented in
userland does not reply? What are the next steps from that point of
the kernel VDUSE module?

Thanks!

[1] https://lore.kernel.org/lkml/20251014042459-mutt-send-email-mst@kernel.=
org/

