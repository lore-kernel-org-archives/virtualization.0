Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC44315A
	for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754881139; cv=none; b=eh8tNMg6JAqo9Fdjm037tdXzAjnBH8m75cU2JeLT0E+/50woimJMJRBh8qWr+N3J6b+OHceuk7hFF/SgIAE73G1ajfXVvNgLyvjGgHPBhCht88fyjODJBOlLcwh9KaIIjhnjh/pnvILYMds9nhnvsyjFjLntczaHNb7L1hRRNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754881139; c=relaxed/simple;
	bh=q6Hu5EXgp1My3SfX82LOBVeKEsjib+rPWEXVFZEwbx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peaoq7We1voyz5nzAAzJCPMWvwBGl3dJqUb6xV9fPRtoEqtsLD9675iRwiHzqvHFOwYQyi3XWuB7vrLSAlf3mqvXxDsWoJZGeQi5f8AFNgI4Gly9WN/pe4/PyQlpsTK8WqxO8fhvt62dZ3R4PVQArwIG5kKiE6sDyRLg892c9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPvn8FGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPvn8FGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754881136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6Hu5EXgp1My3SfX82LOBVeKEsjib+rPWEXVFZEwbx8=;
	b=CPvn8FGDkdFP0ev0LaAoxVoLtVs/du0wf+6iuwYhceU1SGEC+5qiq96fUEaLM03eL3lUeT
	SuQOgKBDrW9hyigFIk0TdZSDZgSHZinl/zH2tdlikO+5NDMD+lSMsAFYxbBNBfiXpzaH8M
	SByRVpzhqf1T89Tl8fjqfp3IGGZvS58=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-wtcZnJW9NfKQqvqBJK0YMw-1; Sun, 10 Aug 2025 22:58:54 -0400
X-MC-Unique: wtcZnJW9NfKQqvqBJK0YMw-1
X-Mimecast-MFC-AGG-ID: wtcZnJW9NfKQqvqBJK0YMw_1754881133
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3211b736a11so8679696a91.0
        for <virtualization@lists.linux.dev>; Sun, 10 Aug 2025 19:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754881133; x=1755485933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6Hu5EXgp1My3SfX82LOBVeKEsjib+rPWEXVFZEwbx8=;
        b=nQTWogZC9CL3llmXYYvQ1aIWZNEw/MUR8lXPxex/nWeBFpUk1UfMznJxs0q67PT8m3
         QsQJ+/w8a1js6A36TRrcDOC0ItJDLt3/C36K2aCV1X59dn1uljQUBQ/7LkGVJ2NSPgEh
         yo7T2/PsJbgZ8VDWjoV9XPyLa9nBi6vyqY5LXxlqUX2+XhnHk6au3B5w9YkO6b8izJF4
         fuMHbCq1ZeShsx7akovA5cG2e46+tCaS6b8C/NqgBgqpY0/QK0KGPDXTiVrjh9qDOf9h
         rBVpFnN3Yu92Rr8k6znZct4uDydvBo6Pc1kh71ULLnF4iFkia/d31WqvLWqAKOGu3VjN
         mmBg==
X-Forwarded-Encrypted: i=1; AJvYcCXYecynfGrwhhyWOhf5bD3KMZ1ncFYAR2Nd3noshmqR0A9gID41s/etFkochMEw9pWjeZB7/0YVn98XSPabEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXqIjsiqTb5nQIlltvVhYBcHL/ld3cGhfw3mE/Oix3i3JJQzj2
	7z0baEV+HCcNPIc6akQnmdNaqdODHtg5C7Du1DKs591ymrbpHtH/UPlQgYGOhffMiE7v4GUafjM
	e3zi++UiLlgyLGcK/usqHnH++5xFa9NDF/Iudvxfv5pV8g9u+pERPkHY/Czt9VLH2mKDMh50MJ3
	d1fP+7bVWzxSv7KwEdycVUIPByXQ+pSopHl0ttQ4w/09g=
X-Gm-Gg: ASbGnctSvHnQsTOXQmvg7QX290KJ1id4EWJne9//EkZez08kLQTEVIjRAflcU5Biqah
	9N/VeZCvTY7lXeH5YIeo07KSGGEugt13hx4boY4f1KLTNOfY9EKKTOA+V8xjPzjIEP1mQBkHeBG
	XySkj40TPde0HzC6NdjrM=
X-Received: by 2002:a17:90b:3951:b0:321:2f06:d3ab with SMTP id 98e67ed59e1d1-32183b4573emr17938488a91.21.1754881133359;
        Sun, 10 Aug 2025 19:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG28yVH9yNcT1SayN1+TxixGDCCbolSNgBOa5s90uQYplFkc7pA6iWREpleNXpewZOV3PboIupfDDi34j98mn8=
X-Received: by 2002:a17:90b:3951:b0:321:2f06:d3ab with SMTP id
 98e67ed59e1d1-32183b4573emr17938454a91.21.1754881132887; Sun, 10 Aug 2025
 19:58:52 -0700 (PDT)
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
 <CACGkMEvbxZsmPPHgfst89FCbZamBPLt8V=K-eepa4s3muFuM4A@mail.gmail.com>
 <CAJaqyWerLAL44w-mnwaohZh+duzHqPS3BO-sJDoEHZDN5RLY1g@mail.gmail.com>
 <CACGkMEvsvFzKUF6w0T4juUFcDbm67YoFFwNDw82K6kogB-1yRA@mail.gmail.com> <CAJaqyWeteUcvzTbcf2ShatX8QLCVCEgs-dgy19ir=W3LJE3y1A@mail.gmail.com>
In-Reply-To: <CAJaqyWeteUcvzTbcf2ShatX8QLCVCEgs-dgy19ir=W3LJE3y1A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Aug 2025 10:58:40 +0800
X-Gm-Features: Ac12FXySCTONtYkmuO8NMluRp3D5fVCBLdUFipBjPxdE0S7dXWOTZ8aEEBqmpNw
Message-ID: <CACGkMEtir49z9P=82SO9a4JML9D71UAaGSm38R2Ubx3Sg6ZufQ@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jyxYEstahZhYlILaPcKd4NPH-uQqxHOLIib2NRSZtuI_1754881133
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 6:18=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Aug 8, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Aug 7, 2025 at 6:56=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <ep=
erezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > This allows to define all functions checking the API versio=
n set by the
> > > > > > > > userland device.
> > > > > > > >
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > >
> > > > > > > It might be worth clarifying how it works.
> > > > > > >
> > > > > > > For example,
> > > > > > >
> > > > > > > 1) would VDUSE behave differently or if it's just some new io=
ctls
> > > > >
> > > > > I'd like to test more in-depth, but a device can just bump the ve=
rsion
> > > > > ID and then implement the replies to the vduse messages. No need =
to
> > > > > implement new ioctls. If the VDUSE device sets 0 in either number=
 of
> > > > > ASID or vq groups, the kernel assumes 1.
> > > >
> > > > Right, this is the way we use now and I think maybe we can document
> > > > this somewhere.
> > > >
> > > > >
> > > > > But you have a very good point here, I think it is wise to evalua=
te
> > > > > the shortcut of these messages in the VDUSE kernel module. If a V=
DUSE
> > > > > device only has one vq group and one ASID, it can always return g=
roup
> > > > > 0 and asid 0 for everything, and fail every try to ser asid !=3D =
0.
> > > >
> > > > Yes, and vhost-vDPA needs to guard against the misconfiguration.
> > > >
> > > > > This
> > > > > way, the update is transparent for the VDUSE device, and future
> > > > > devices do not need to implement the reply of these. What do you
> > > > > think?
> > > >
> > > > This should work.
> > > >
> > > > >
> > > > > > > 2) If VDUSE behave differently, do we need a ioctl to set the=
 API
> > > > > > > version for backward compatibility?
> > > > > >
> > > > > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > > > > >
> > > > > > I think we need to think if it complicates the migration compat=
ibility or not.
> > > > > >
> > > > >
> > > > > Do you mean migration as "increase the VDUSE version number", not=
 "VM
> > > > > live migration from vduse version 0 to vduse version 1", isn't it=
? The
> > > > > second should not have any problem but I haven't tested it.
> > > >
> > > > I mean if we bump the version, we can't migrate from version 1 to
> > > > version 0. Or we can offload this to the management (do we need to
> > > > extend the vdpa tool for this)?
> > > >
> > >
> > > I just noticed I left this unreplied. But I still do not get what
> > > migrate means here :).
> > >
> > > If migrate means to run current VDUSE devices on kernel with this
> > > series applied these devices don't set V1 API so they have one vq
> > > group, and one asid. I'm actually testing this with my libfuse+VDUSE
> > > modifications that don't use V1 at all. Adding this explanation to th=
e
> > > patch as it is a very good point indeed.
> >
> > Right.
> >
> > >
> > > If it means to migrate a guest from using a V1 VDUSE device to a V0
> > > device "it should work", as it is just a backend implementation
> > > detail.
> >
> > For example src is the VDUSE with multiqueue support (v1) but dest
> > doesn't have this support (v0). I think the qemu should fail to launch
> > in dest.
> >
> > > If we migrate from or to a vdpa device backed by hardware, for
> > > example, one of the devices does not even have the concept of VDUSE
> > > API version.
> > >
> > > In the case of net, it does not work at the moment because the only
> > > way to set features like mq are through the shadow CVQ.
> >
> > I think you mean qemu should fail, I'm not sure this is friendly to lib=
virt.
> >
>
> No, I think QEMU should not transmit vdpa backend properties not
> visible to the guest, so we don't get an explosion of properties that
> are hard to get. Expanding on this, QEMU is not even able to know if
> it is talking with VDUSE, vdpa_sim, or a vdpa device backed by
> hardware. And I think we don't want QEMU to have this information. So
> sending the VDUSE version implies removing a lot of useful
> abstractions.
>
> In the case of net, the destination QEMU should fail if it is not able
> to restore the device state. At this moment this implies to have at
> least two ASID if the net device has CVQ, and that CVQ is in its own
> ASID, but that may not be true in the future.
>
> But QEMU does not check if that is the case migrating between two
> vdpa_net_sim if one supports ASID but the other doesn't.

Ok I think I must miss something. I need some context here. For
example, Is the shadow cvq option used by libvirt or not? (Or it has
been enabled by default if Qemu detect cvq has its own group?)

If shadow cvq is neither used by libvirt nor automatically enabled, we
need to make it work for libvirt first.

If it relies on libvirt to enable it explicitly, is libvirt expected
to detect the vDPA ability (I guess it is not what libvirt wants)?
If shadow cvq is enabled automatically, migrating from V2 to V1 is
fine but not the reverse.

> And this is
> only a requirement for net, not for other vdpa devices.
>
> So if we want to develop it, I think it is independent of this series.

Thanks

>
> [...]
>

