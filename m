Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A223B610
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967776; cv=none; b=cy1RSzDiUBZIxpzsETsnqaZq/CaaGCQgruDHZq9gIHg7RAJjqx865A26Mu40LbvxblnIp1emuJC88ByuaRWH5Qx5htprhG+KqBC2wcQGL8dOlAQFeo+53Xj3oKiHA5EE6tzuwKQVTnZS9+ojAXum9I3zhddSJxwrefIuFnX+cTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967776; c=relaxed/simple;
	bh=i4nIiHs46YfjUauzTykgl3BvodxjLB+KF6h3xbjgklI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yq0ED2SO3dbmhyk4hM9l/CT/JknzC8lWCk9joghXariSMOowiD9XEHAVq3dnbatQvJFwWEXEvCKexzLWRsrFWR0e7YD5oq6tokhr8UUogBS0Y8WOVoAtQlZYH9v+k6p9YDYKMdIWCYfcblDmu4aOKVLU9jal6+0Twgf+edVBqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwERydMI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwERydMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754967773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6pqbS3wrVGrxLndM70/poYm/QoyzIpWpUcgU17t6W0=;
	b=IwERydMIt1hoAtdbR2r7IqforSPwfCUs+sjxwWr6NdTTEOI3SRL7wzI8RyXWYr8KoFbqcf
	uBAktaAay1HoIlu6/vCo/qN+3wYj3nRnJji0dkgxflaxsXVGK54xrZBlorlJ+wvMaNwaSV
	fnzb//u7kb/zQ8+jzpqyuu0rx0bpuSc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-WLLtJYNfNDCTRBfySP88IA-1; Mon, 11 Aug 2025 22:55:17 -0400
X-MC-Unique: WLLtJYNfNDCTRBfySP88IA-1
X-Mimecast-MFC-AGG-ID: WLLtJYNfNDCTRBfySP88IA_1754967316
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31f5f70a07bso7904874a91.3
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 19:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754967316; x=1755572116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6pqbS3wrVGrxLndM70/poYm/QoyzIpWpUcgU17t6W0=;
        b=J5jOmf1MHYn4iv+cPo1c6E8LDf0vMD+C92hEDixOS/cwSE51ZqdZGBShUHFzr4nneW
         gtF9qj10d/RE9FjCJOeG3g41a5rHLTx1bQjUdA8o9icrldFQq+4p14LicbUZq2Ocnjtt
         bTVu0HMQ6kDLJFL2xuVI2lTFG1eLO94AR1wZTKnAX+vg0BmG2OZRx18wK3l0mII11xh0
         Be+Zv7p41VFZcnmdXg8gm82aM90AjDQWQc1SbF/XDevxpSI1S55ToPGUNeah4YDexITN
         PCv6TS1hbu/YbUBwiEuvPFCHWl6TXSqBtRajZkHD5YxNC1k8yYPtuxaMtvBay4LUJgGP
         tEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWOY6EEIclZg0dfJyiiMpYwmXfda3gJ3LZd6LXx9o5SNDnH/UwVQgkMUqaUvVmExepYMvJg6JVmkw9Z1D2qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIb5pxVxJX68zEHPRBpyfx/sQE3PARptqP19VnMf9Zw8BJbSJm
	enh0hCFsbU27H24npUClj7eCRau72vHeen4Peju7y+y5rpVyOFL5t9c1rIKQ9pQkdB+vZzwa+0G
	FETm6RAuN2MNXWnXpaVRckoh8Ivq6O9u932wsSMz0wCXy2vkNadyyyE4ct/X/2OUikwi+q0ur0S
	Zh4mxVVkFikH1U4t1/sGosrRl09x6HUSsFPFv/Hw6ZYGE=
X-Gm-Gg: ASbGncvrcY3ZdzuHeHoP6AYzoCoh6YGS9Q/zuoxYHnRTme0wKOfVEWG71OfLUaZn0qY
	XmN09ivwR1MQwweWMEJyFMNPUIycIO5g+uE6hFhPwpE0vvLU8aNK9NokFFyfDb7hh+UKpoeRn80
	/GLF+HeV/HgHIQ/7ANzjpZOuk=
X-Received: by 2002:a17:90b:540d:b0:311:ea13:2e70 with SMTP id 98e67ed59e1d1-321839f1159mr20937878a91.14.1754967315875;
        Mon, 11 Aug 2025 19:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGPgaSgVlGVEhY4jiEd1h3ZWnC2p/B/LDs7/sYmqUIjR+WgITtBGZFWyV4hwaraPn0MmaKBu/RsYEWRNtC42k=
X-Received: by 2002:a17:90b:540d:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-321839f1159mr20937831a91.14.1754967315137; Mon, 11 Aug 2025
 19:55:15 -0700 (PDT)
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
 <CACGkMEvsvFzKUF6w0T4juUFcDbm67YoFFwNDw82K6kogB-1yRA@mail.gmail.com>
 <CAJaqyWeteUcvzTbcf2ShatX8QLCVCEgs-dgy19ir=W3LJE3y1A@mail.gmail.com>
 <CACGkMEtir49z9P=82SO9a4JML9D71UAaGSm38R2Ubx3Sg6ZufQ@mail.gmail.com> <CAJaqyWfZn36gGbT=MjpdcXi3Sje1WRB6nycXJwP_BPugSzHRyQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfZn36gGbT=MjpdcXi3Sje1WRB6nycXJwP_BPugSzHRyQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Aug 2025 10:55:03 +0800
X-Gm-Features: Ac12FXxnkg1JOTajc2pKVvf4Bn1SkcQME2RfHqdq88tLH7OdIhFXIG4Ypql1zUs
Message-ID: <CACGkMEs+ZytUO8bEqYEG+Y6s85dqTZciWdU1NpxpEiMvRPC+ww@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eKQgxYlpjHV4k_aUQXAVxmwlM06qd7MXPZkJ9LZZuLY_1754967316
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:02=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Aug 11, 2025 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Sun, Aug 10, 2025 at 6:18=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, Aug 8, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Thu, Aug 7, 2025 at 6:56=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <ep=
erezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez=
 <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This allows to define all functions checking the API ve=
rsion set by the
> > > > > > > > > > userland device.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > >
> > > > > > > > > It might be worth clarifying how it works.
> > > > > > > > >
> > > > > > > > > For example,
> > > > > > > > >
> > > > > > > > > 1) would VDUSE behave differently or if it's just some ne=
w ioctls
> > > > > > >
> > > > > > > I'd like to test more in-depth, but a device can just bump th=
e version
> > > > > > > ID and then implement the replies to the vduse messages. No n=
eed to
> > > > > > > implement new ioctls. If the VDUSE device sets 0 in either nu=
mber of
> > > > > > > ASID or vq groups, the kernel assumes 1.
> > > > > >
> > > > > > Right, this is the way we use now and I think maybe we can docu=
ment
> > > > > > this somewhere.
> > > > > >
> > > > > > >
> > > > > > > But you have a very good point here, I think it is wise to ev=
aluate
> > > > > > > the shortcut of these messages in the VDUSE kernel module. If=
 a VDUSE
> > > > > > > device only has one vq group and one ASID, it can always retu=
rn group
> > > > > > > 0 and asid 0 for everything, and fail every try to ser asid !=
=3D 0.
> > > > > >
> > > > > > Yes, and vhost-vDPA needs to guard against the misconfiguration=
.
> > > > > >
> > > > > > > This
> > > > > > > way, the update is transparent for the VDUSE device, and futu=
re
> > > > > > > devices do not need to implement the reply of these. What do =
you
> > > > > > > think?
> > > > > >
> > > > > > This should work.
> > > > > >
> > > > > > >
> > > > > > > > > 2) If VDUSE behave differently, do we need a ioctl to set=
 the API
> > > > > > > > > version for backward compatibility?
> > > > > > > >
> > > > > > > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > > > > > > >
> > > > > > > > I think we need to think if it complicates the migration co=
mpatibility or not.
> > > > > > > >
> > > > > > >
> > > > > > > Do you mean migration as "increase the VDUSE version number",=
 not "VM
> > > > > > > live migration from vduse version 0 to vduse version 1", isn'=
t it? The
> > > > > > > second should not have any problem but I haven't tested it.
> > > > > >
> > > > > > I mean if we bump the version, we can't migrate from version 1 =
to
> > > > > > version 0. Or we can offload this to the management (do we need=
 to
> > > > > > extend the vdpa tool for this)?
> > > > > >
> > > > >
> > > > > I just noticed I left this unreplied. But I still do not get what
> > > > > migrate means here :).
> > > > >
> > > > > If migrate means to run current VDUSE devices on kernel with this
> > > > > series applied these devices don't set V1 API so they have one vq
> > > > > group, and one asid. I'm actually testing this with my libfuse+VD=
USE
> > > > > modifications that don't use V1 at all. Adding this explanation t=
o the
> > > > > patch as it is a very good point indeed.
> > > >
> > > > Right.
> > > >
> > > > >
> > > > > If it means to migrate a guest from using a V1 VDUSE device to a =
V0
> > > > > device "it should work", as it is just a backend implementation
> > > > > detail.
> > > >
> > > > For example src is the VDUSE with multiqueue support (v1) but dest
> > > > doesn't have this support (v0). I think the qemu should fail to lau=
nch
> > > > in dest.
> > > >
> > > > > If we migrate from or to a vdpa device backed by hardware, for
> > > > > example, one of the devices does not even have the concept of VDU=
SE
> > > > > API version.
> > > > >
> > > > > In the case of net, it does not work at the moment because the on=
ly
> > > > > way to set features like mq are through the shadow CVQ.
> > > >
> > > > I think you mean qemu should fail, I'm not sure this is friendly to=
 libvirt.
> > > >
> > >
> > > No, I think QEMU should not transmit vdpa backend properties not
> > > visible to the guest, so we don't get an explosion of properties that
> > > are hard to get. Expanding on this, QEMU is not even able to know if
> > > it is talking with VDUSE, vdpa_sim, or a vdpa device backed by
> > > hardware. And I think we don't want QEMU to have this information. So
> > > sending the VDUSE version implies removing a lot of useful
> > > abstractions.
> > >
> > > In the case of net, the destination QEMU should fail if it is not abl=
e
> > > to restore the device state. At this moment this implies to have at
> > > least two ASID if the net device has CVQ, and that CVQ is in its own
> > > ASID, but that may not be true in the future.
> > >
> > > But QEMU does not check if that is the case migrating between two
> > > vdpa_net_sim if one supports ASID but the other doesn't.
> >
> > Ok I think I must miss something. I need some context here. For
> > example, Is the shadow cvq option used by libvirt or not? (Or it has
> > been enabled by default if Qemu detect cvq has its own group?)
> >
> > If shadow cvq is neither used by libvirt nor automatically enabled, we
> > need to make it work for libvirt first.
> >
> > If it relies on libvirt to enable it explicitly, is libvirt expected
> > to detect the vDPA ability (I guess it is not what libvirt wants)?
> > If shadow cvq is enabled automatically, migrating from V2 to V1 is
> > fine but not the reverse.
> >
>
> QEMU uses shadow CVQ automatically if all the conditions (ASID, proper
> set of features, etc) are supported.
>

Ok, so V1 implies non-migratable.  So I'm still confused about how to
deal with migration compatibility.

For example, ping-pong migration between V1 and V2.

Thanks

