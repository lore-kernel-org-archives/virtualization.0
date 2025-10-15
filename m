Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03402749D7
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514344; cv=none; b=WsT5ZO6HFbH9rCs3IBpHpVRiKDmWqWfYdGfyzyxsT8FRlNBWzz61NS0FdMkZod6hgC4S9whY6Gi9MqSnbMexBqhSlyRaALeE1HKZG/ChHcxWXiRSjUBamhmuAdCYjcYNqQSVlFeRgLh4OMTsM94GrX5JH3t83KRnMjnf3eZwG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514344; c=relaxed/simple;
	bh=td875+Fh9lw5w16PBTZzPAomZtSgmujnirC7oXVn1I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ+QKhqpzqkCHoZlIKVgO4pglkxACsfJ5ojEmHgVIUQVNtowzN+9Ox6qQkSAJ2YFIOtHhn+s1Eedqp+pm/eaR+L6hqd5O68ioI/7tJotD6G4qpn7Ayc4NF+kCQ0nnmdNeGeWd47MPfw0TEzQujYB47diR4guOQGmQCkybJR5aPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdfH9Gbg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdfH9Gbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760514341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rbWOVwpa2m4wtu2whE72TL+I902wYR9W02WjI14MQE=;
	b=BdfH9Gbg79ip90IHRQNfNmtDCw3jk5CNMI6gAMdvD67SFIP2YKTfz/UsHzJ1qhTR4QzzHp
	y31jfjcxRprGLI67OYTNA13qyvCYYn23I+uKZR5d2y+zL+Tj27rkDDP7GHn3q3qL3fBxLC
	YEJM1V45rT+6n/SPfaRgy1FbgrgvThQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-0wNOjc8fOQez1XxJNqLBmw-1; Wed, 15 Oct 2025 03:45:38 -0400
X-MC-Unique: 0wNOjc8fOQez1XxJNqLBmw-1
X-Mimecast-MFC-AGG-ID: 0wNOjc8fOQez1XxJNqLBmw_1760514338
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-74983d5be0bso15905547b3.0
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 00:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760514338; x=1761119138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rbWOVwpa2m4wtu2whE72TL+I902wYR9W02WjI14MQE=;
        b=p+M9tjw/jyBuBQizgZGB7gqRu6JbbQLhtV0uqUzO1j1t2Ki9vt2CRorr8eU/g7rg8z
         sbRjBkkeFqziMBUZFeE0UPz3On17J1nSGUrdk8MSN7KHMEX8JzsD4k+BJlSJu75EocZG
         ik37+hqIajkrDgBaCq8vkjuHYI0NJv8/Jc+DZntIFGHZL9fCv6jEi/eo2IwkDuyZg8up
         p0ELNzeMARBlPtnnaiI6pp4Sq/NJsmDjvidzyj025uTlxCVkcG+fnfZrqO13SOyplGcC
         8qsc3Z58Mn8x+gRSKlce/w8fvB2cwrhGzTeWyA57ka7G0jUBqQ9XCpUu76WjfvhTCu+5
         ga/g==
X-Forwarded-Encrypted: i=1; AJvYcCV+AkjzVI9F6UGSwdLAfUxgc+4vtryCEKPKHXaLDXkxEdGDmZIZE71J975ExCcP1dbsDOFRoXvQYsIQsxkZwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqYAw5nofBaB5obmW0XpO4U1nagLg5Qt3gYJtCJdKRgiDLMKAQ
	ZqOBgSiEiHK1+YoHRy9jjKPEE56mSuhp5+bWfgzXopj7S3SOf1bXynW+59KlezbVzdamFl+b1jE
	nRzIhe8T7EsMDpSTzXFd2UwDEi8NGPvCObM1P48GTq05bgRWoUzisABbh6CG+LGocW1QFlF7ZfI
	yQQigpLFXW+Z7eA4JJrhGkN3aQq2kUWjAeF59Cvot8kzY=
X-Gm-Gg: ASbGnctrIdFlwF5IM+AbbsOaKRTk3Ev9tJnqeTIEXqUdFr3JEdjfxPxFuZvg39TSGRd
	WVRWCIWHAGS54064f7nYSnhSg1ZA+pi8AcY/OU3jyCqa2/thr5L6Su+BhYMJAGnuTDattF/veBn
	+3q0qKuVVv3G6c14fKBh8JY+SObh7WTXSTbZhOQxxBEH+4u/vocJcZssqVrhLj6UyziZboglmSp
	2qCK54yftHdAKb6gJbWrdQMAqnU0S1WSJ2ZgtRxlTs=
X-Received: by 2002:a05:690e:4250:b0:636:1f5d:b60a with SMTP id 956f58d0204a3-63cbe087551mr23174840d50.7.1760514337819;
        Wed, 15 Oct 2025 00:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs81mpQ4wkDOe+ttYnJ2/87b5bmhO5OaUosq2hzP6/6mssB8BNlxvF0XOiOkLqxlGgoL4FtAfM/lfxnt5v07w=
X-Received: by 2002:a05:690e:4250:b0:636:1f5d:b60a with SMTP id
 956f58d0204a3-63cbe087551mr23174829d50.7.1760514337436; Wed, 15 Oct 2025
 00:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251015030313-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 09:45:01 +0200
X-Gm-Features: AS18NWCiPyCG3C1pPFZJeZwWLCjgJaY3_QS3-tGJPLv7i0gOSXBx73ih53afnpY
Message-ID: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uKd6e7dQYmjSl5ZHKDit38QvMK7d7UVJs-cirue5o3s_1760514338
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <ms=
t@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez =
wrote:
> > > > > > > > An userland device implemented through VDUSE could take rtn=
l forever if
> > > > > > > > the virtio-net driver is running on top of virtio_vdpa.  Le=
t's break the
> > > > > > > > device if it does not return the buffer in a longer-than-as=
sumible
> > > > > > > > timeout.
> > > > > > >
> > > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > > Let's not break valid use-cases please.
> > > > > > >
> > > > > > >
> > > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > > kernel.
> > > > > >
> > > > > > Would a shadow control virtqueue implementation in the VDUSE dr=
iver work?
> > > > > > It would ack systematically messages sent by the Virtio-net dri=
ver,
> > > > > > and so assume the userspace application will Ack them.
> > > > > >
> > > > > > When the userspace application handles the message, if the hand=
ling fails,
> > > > > > it somehow marks the device as broken?
> > > > > >
> > > > > > Thanks,
> > > > > > Maxime
> > > > >
> > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > Once you use the buffer you can get another one and so on
> > > > > with no limit.
> > > > > One fix is to actually maintain device state in the
> > > > > kernel, update it, and then notify userspace.
> > > > >
> > > >
> > > > I thought of implementing this approach at first, but it has two dr=
awbacks.
> > > >
> > > > The first one: it's racy. Let's say the driver updates the MAC filt=
er,
> > > > VDUSE timeout occurs, the guest receives the fail, and then the dev=
ice
> > > > replies with an OK. There is no way for the device or VDUSE to upda=
te
> > > > the driver.
> > >
> > > There's no timeout. Kernel can guarantee executing all requests.
> > >
> >
> > I don't follow this. How should the VDUSE kernel module act if the
> > VDUSE userland device does not use the CVQ buffer then?
>
> First I am not sure a VQ is the best interface for talking to userspace.
> But assuming yes - just avoid sending more data, send it later after
> userspace used the buffer.
>

Let me take a step back, I think I didn't describe the scenario well enough=
.

We have a VDUSE device, and then the same host is interacting with the
device through the virtio_net driver over virtio_vdpa.

Then, the virtio_net driver sends a control command though its CVQ, so
it *takes the RTNL*. That command reaches the VDUSE CVQ.

It does not matter if the VDUSE device in the userland processes the
commands through a CVQ, reading the vduse character device, or another
system. The question is: what to do if the VDUSE device does not
process that command in a timely manner? Should we just let the RTNL
be taken forever?

