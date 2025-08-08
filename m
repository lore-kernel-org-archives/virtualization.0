Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5832260C
	for <virtualization@lists.linux.dev>; Fri,  8 Aug 2025 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754614252; cv=none; b=ritwYR0LCQQdwlRQX6KoiKqBXY6rrqhPpAeLrFP7LtGlvXx0DndanSqLe7h1DMFUGSFbVZDjmE0vfasXKTDf0zzVC+397nm7adPs1pMzwqJVOkhqyzdsqcDmhfmzp9UczcUGJ++NmGzPk+lH5tOplXurOrRRqzMqN+js3BGwxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754614252; c=relaxed/simple;
	bh=k85IiXCWAS/CvmseNXmQBHOZ+NfmWA4sVVk9GIrPsTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKvEVZipvdn8jrorPqr5JlxDy94ADEaKvJnpg5385Bh87GezixnSOGdEFcDWh9sU1ueJgP/d5q+mICHd2iu2JB92YJYIiWpmCutyrBDv6jeITHVwgEXJBBvhK5EIg4Om+zddCj5nyBS6O38zP7B58nn96ZhRUGTSk+RmdjO+KLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoTQXNWQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoTQXNWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754614249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k85IiXCWAS/CvmseNXmQBHOZ+NfmWA4sVVk9GIrPsTY=;
	b=UoTQXNWQ2a5spOlJ18SWl4727w8eKvFJ1TxeULqBfqNqpUcL3GMBUOadc5y+D56qrd7daa
	eo19JBb8BTOuM+XseprdZ3eGzVrGjfuPqj8boW1WJAX20K9oZJP5uBrkXbJnvuu6OSebkx
	eRz6cOlEli9avXP6simiOk/CBd8frcY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-ekcrNzZcOTm_PqHyntD7sA-1; Thu, 07 Aug 2025 20:50:46 -0400
X-MC-Unique: ekcrNzZcOTm_PqHyntD7sA-1
X-Mimecast-MFC-AGG-ID: ekcrNzZcOTm_PqHyntD7sA_1754614246
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3217ba6843cso1030371a91.2
        for <virtualization@lists.linux.dev>; Thu, 07 Aug 2025 17:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754614246; x=1755219046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k85IiXCWAS/CvmseNXmQBHOZ+NfmWA4sVVk9GIrPsTY=;
        b=xFpEPHraIUQ8xdIatiRTYWH/nN1oQ2SWFtue5YbTWpWeNohhyWsY3lJiI/0Kyhswji
         PF3uwkcXyjJnm/nsNeJg+9bCapw5p1y6bb6WOCZFyybzOHC9V8WQ8nNsrp/VJXhi0WkT
         RWFQndjrEi6JaKTsoXO/XWovs7SCkkdaWln2o88irAFQ5nQhitYb+0SgIQX5rBFpvI2J
         OpEqatImNXr8vXAaxYuC4bvC/CcMB2D4MqxB+I8h2ciu3BpzVUDWwzQj550CdXY5yGzo
         0OiGwR3YALXbUfUU/ncEDOcT5prc2leKkHLonN+CbVY8NBKvBEaoO4DS6LO9p3qyiqo0
         weNw==
X-Forwarded-Encrypted: i=1; AJvYcCVATOLUecB1dNuQYSlCIcMTn5oEiLa68uWghYQgsXECrx4il1bPFer7PUIIeJA1d1T49vYvdTdoLPxTW63sKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmfY3c19Tl/GJfics8cDd4m8TO4BITNkqQE/eBIL2+OI4V5fqA
	PHc8kDaipVPw5g/tSZ7YzapwblUCr1aJO73we/d86rlhPuM27VtvENoLvcnwajcBBWg74uVCLPJ
	WQo73pW7Ou0T+5bScegV/2MVs1kh4/X5tgRS78KEOh0IzgaH+z9b5vqv1rzkULGzARkG7xOGZmE
	rFv9slVB1fG/oh7pJAYs/o1sjXdSxsUhcubC3mCXIpwxI=
X-Gm-Gg: ASbGncvtOPmy4gMIQa2XTZcpIpSOdfQWeRPKzU/4C3Jm5ZowZa3xHbJa2udMJSbGH+3
	cT45DmXRSLKL1GnfMe8WRqzGxRIpN8R4mJTAsOg5HjwT0BftXu3XbDMvVpQQYnYrJ+W0wTqDY+Z
	A/KK0ON95wAsNIinnR+5uD0g==
X-Received: by 2002:a17:90a:e70e:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-32183c47c5dmr1335421a91.26.1754614245623;
        Thu, 07 Aug 2025 17:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSQMIMaGld2j9Lm2m2M4p9H0kvKzugos7AveU9jYYJBzyjMA9OcQ8bD8bCIEmakTVtC2XZbkaXX/iXo3IbBcU=
X-Received: by 2002:a17:90a:e70e:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-32183c47c5dmr1335391a91.26.1754614245220; Thu, 07 Aug 2025
 17:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-2-eperezma@redhat.com>
 <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com>
 <CACGkMEvinV7Zd+xddnxcerFbw_c+RZypkeD5HaN8=g6+peZvMQ@mail.gmail.com>
 <CAJaqyWeetDsdoDzVrN-n0+jr97MBPeHdTxeM3ttmNUeLK702VA@mail.gmail.com>
 <CACGkMEvbxZsmPPHgfst89FCbZamBPLt8V=K-eepa4s3muFuM4A@mail.gmail.com> <CAJaqyWerLAL44w-mnwaohZh+duzHqPS3BO-sJDoEHZDN5RLY1g@mail.gmail.com>
In-Reply-To: <CAJaqyWerLAL44w-mnwaohZh+duzHqPS3BO-sJDoEHZDN5RLY1g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Aug 2025 08:50:34 +0800
X-Gm-Features: Ac12FXy8zkKGbNYGGTDXgnr8OHp0_OsYxaYJ2CwxU2LIzJaj3-nvqhMQWLeE0l0
Message-ID: <CACGkMEvsvFzKUF6w0T4juUFcDbm67YoFFwNDw82K6kogB-1yRA@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S5wDuWq9hjhD_OqkGfcbCO6PxeiYxcLRvRtqsdRmEho_1754614246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 6:56=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperez=
ma@redhat.com> wrote:
> > > > > >
> > > > > > This allows to define all functions checking the API version se=
t by the
> > > > > > userland device.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > >
> > > > > It might be worth clarifying how it works.
> > > > >
> > > > > For example,
> > > > >
> > > > > 1) would VDUSE behave differently or if it's just some new ioctls
> > >
> > > I'd like to test more in-depth, but a device can just bump the versio=
n
> > > ID and then implement the replies to the vduse messages. No need to
> > > implement new ioctls. If the VDUSE device sets 0 in either number of
> > > ASID or vq groups, the kernel assumes 1.
> >
> > Right, this is the way we use now and I think maybe we can document
> > this somewhere.
> >
> > >
> > > But you have a very good point here, I think it is wise to evaluate
> > > the shortcut of these messages in the VDUSE kernel module. If a VDUSE
> > > device only has one vq group and one ASID, it can always return group
> > > 0 and asid 0 for everything, and fail every try to ser asid !=3D 0.
> >
> > Yes, and vhost-vDPA needs to guard against the misconfiguration.
> >
> > > This
> > > way, the update is transparent for the VDUSE device, and future
> > > devices do not need to implement the reply of these. What do you
> > > think?
> >
> > This should work.
> >
> > >
> > > > > 2) If VDUSE behave differently, do we need a ioctl to set the API
> > > > > version for backward compatibility?
> > > >
> > > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > > >
> > > > I think we need to think if it complicates the migration compatibil=
ity or not.
> > > >
> > >
> > > Do you mean migration as "increase the VDUSE version number", not "VM
> > > live migration from vduse version 0 to vduse version 1", isn't it? Th=
e
> > > second should not have any problem but I haven't tested it.
> >
> > I mean if we bump the version, we can't migrate from version 1 to
> > version 0. Or we can offload this to the management (do we need to
> > extend the vdpa tool for this)?
> >
>
> I just noticed I left this unreplied. But I still do not get what
> migrate means here :).
>
> If migrate means to run current VDUSE devices on kernel with this
> series applied these devices don't set V1 API so they have one vq
> group, and one asid. I'm actually testing this with my libfuse+VDUSE
> modifications that don't use V1 at all. Adding this explanation to the
> patch as it is a very good point indeed.

Right.

>
> If it means to migrate a guest from using a V1 VDUSE device to a V0
> device "it should work", as it is just a backend implementation
> detail.

For example src is the VDUSE with multiqueue support (v1) but dest
doesn't have this support (v0). I think the qemu should fail to launch
in dest.

> If we migrate from or to a vdpa device backed by hardware, for
> example, one of the devices does not even have the concept of VDUSE
> API version.
>
> In the case of net, it does not work at the moment because the only
> way to set features like mq are through the shadow CVQ.

I think you mean qemu should fail, I'm not sure this is friendly to libvirt=
.

> If a VDUSE net
> device implements, let's say, admin vq, something similar to PF and
> VF, and dirty bitmap, I guess it should be possible. Maybe it is
> easier to play with this wuth block devices.
>

It looks like another topics:

1) harden CVQ for VDUSE
2) support hardware dirty page tracking

Thanks

