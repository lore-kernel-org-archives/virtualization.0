Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF61BD035
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978651; cv=none; b=KgiGVgzv0zdVFVoq56lbsxRx59/mtzKtxgMNcOqX3vOGcdb+CZLZ9FtvzbZYxTpRwgpxxUEXyU14jnVIHMMuRt5mvpUDztKSzY6nUy4Qj1ec9LD517DDoJeYosDSBtDiYJeFYxhKTk5zQENmR9hZ0phliXs128hjPzdNlOlZrSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978651; c=relaxed/simple;
	bh=0MGr25W73MzQVxLJ+yptcKKN6s8TSWhomvLsuueWA2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFYhwKUjO5yHK56bblv6iMjmSSzIiHXkffrjzyy/5blrDUWxF0TiCqYmAQ0j3ZPBB2U1aQFT9iH9GZ2W//Byd3PPCnwOf8QGtxsATZwqaSKjG2JYwx8Bu81+LfKDklhk1Rby8+8Et5oe0M3CsnYOj83MsPUGhsJSpkAbQPOctlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aycaySSx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aycaySSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754978648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GbJAGTGX+Pn846IPOGuR02+e3qo8B7q3qgt3TnQIEI=;
	b=aycaySSxOMm2/qg9EYe8plIfLbbmcntMxaUYH/Rj9OdGbCA+n245UD5Y/y7qmR2S7GsMUQ
	rVBzOa1KZIuRyLIyZ8gdEh1efG3zFeigpn7KawtVhdwpiFNk41oDleZl0AOc1u7WBDmY1r
	xu6OCk5ETLK+dye65HIBhIoDWitSGlw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-DIvv50uaMO63xQtO-M9QdQ-1; Tue, 12 Aug 2025 02:04:06 -0400
X-MC-Unique: DIvv50uaMO63xQtO-M9QdQ-1
X-Mimecast-MFC-AGG-ID: DIvv50uaMO63xQtO-M9QdQ_1754978646
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b44fdfe7b8dso1664051a12.2
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 23:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978645; x=1755583445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GbJAGTGX+Pn846IPOGuR02+e3qo8B7q3qgt3TnQIEI=;
        b=qE2UYARo6SsLNgD58VtTfOIadFCrKrpg71XFu+TOKddVfYhe3X7tMqapd7WrQiJh2a
         U5BgSnmj8CNY9Pcod09uiGC+fEWyU6hWFecWfYnOenfSQBK4aFOlYeYCCGO4HNnYbRDV
         whxrHjRsyPnQY9+NMumoI0cZqRM2s6nMICz1ajEUh9DYxra59sTRVE+cE4Jm2qKuIBee
         T4hI9L/DePpBHXyRUXnAyww2iy0djyI7YdRzbvOCE8hG69sGdu+NUEKoUarqa7gEp+fE
         xNxpx5P7QBM7vGB8NyRlx+Al+M+nG1ZvJujTQzO2nomU4J5thWX/X5jZc0NBZ5p4HDbi
         fWEg==
X-Forwarded-Encrypted: i=1; AJvYcCXjAtbG8lUwX4oz9TeF4fldR/vRUsKRtstkT+orgOaBxyNG69TYfl8ToeTWedVfNoqVPuDdAcVQJE0iBKz8iA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq3VpFSOCev57jtIBWMjN8U8fJ9wCUo3vj8jZnQ0VCwi8iQlOs
	QcwDhn2Ywn5Mijru0kFpt+4KghT6iw9LKwLq+X38tXndDmwyNu/JarpfRr7ex13mTSRCsJVyEDf
	hp0D0+gI9Dlmpms7gX7SXiDPi4b0LyYkxoQ0eLoyndA1FlQ+hSodFtcykYBa6mGN01Wb6aOXHfT
	Cevua5g+3EyrsgHyyWqsTH8dNWVEEQ0ehakPDiWxpq/YNOWLODWaarHA==
X-Gm-Gg: ASbGncuEnC/1shjSx7GDTL/xPDM+h0HaC5q8ctA58Wpt/96Kz/3Mac0R7m7vEsDjHZz
	ScD7g+EjbxuBKJiv3rW0X/kzL+4nHFO3rDlXdSf+WzI/Vtp16/TTVRV3njdk7jWLCYmwVd+qR5b
	9LkNu5VcENeO+4iAZ6xska
X-Received: by 2002:a17:90b:4c86:b0:31e:ccfb:22fc with SMTP id 98e67ed59e1d1-321c0b8c1e3mr3115971a91.35.1754978645300;
        Mon, 11 Aug 2025 23:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5r3xMOoc2+ckyY0tIA3SjtXWOoeKKaBtAZLMli/968b/Nb1ALOR8gdeYFvv5jF7vFEy7P0fr/8MCXWLcOdRI=
X-Received: by 2002:a17:90b:4c86:b0:31e:ccfb:22fc with SMTP id
 98e67ed59e1d1-321c0b8c1e3mr3115934a91.35.1754978644837; Mon, 11 Aug 2025
 23:04:04 -0700 (PDT)
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
 <CACGkMEtir49z9P=82SO9a4JML9D71UAaGSm38R2Ubx3Sg6ZufQ@mail.gmail.com>
 <CAJaqyWfZn36gGbT=MjpdcXi3Sje1WRB6nycXJwP_BPugSzHRyQ@mail.gmail.com> <CACGkMEs+ZytUO8bEqYEG+Y6s85dqTZciWdU1NpxpEiMvRPC+ww@mail.gmail.com>
In-Reply-To: <CACGkMEs+ZytUO8bEqYEG+Y6s85dqTZciWdU1NpxpEiMvRPC+ww@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 12 Aug 2025 08:03:28 +0200
X-Gm-Features: Ac12FXwTdZgCrYs-TVFEHUQqO9qoI_jJFh9b51aC4ui85plPbJ-rXOsSZjGgjLg
Message-ID: <CAJaqyWc-vGUF_T6_okai40SK_xMYzUe7WHR60W2q6jW0BAjMVw@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -cpk12NGpT3sv0OWmTrXKqNMet6UkcZARZxGLnLpJa4_1754978646
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Aug 11, 2025 at 5:02=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Sun, Aug 10, 2025 at 6:18=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 8, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Thu, Aug 7, 2025 at 6:56=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <=
eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9r=
ez <eperezma@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > This allows to define all functions checking the API =
version set by the
> > > > > > > > > > > userland device.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.co=
m>
> > > > > > > > > >
> > > > > > > > > > It might be worth clarifying how it works.
> > > > > > > > > >
> > > > > > > > > > For example,
> > > > > > > > > >
> > > > > > > > > > 1) would VDUSE behave differently or if it's just some =
new ioctls
> > > > > > > >
> > > > > > > > I'd like to test more in-depth, but a device can just bump =
the version
> > > > > > > > ID and then implement the replies to the vduse messages. No=
 need to
> > > > > > > > implement new ioctls. If the VDUSE device sets 0 in either =
number of
> > > > > > > > ASID or vq groups, the kernel assumes 1.
> > > > > > >
> > > > > > > Right, this is the way we use now and I think maybe we can do=
cument
> > > > > > > this somewhere.
> > > > > > >
> > > > > > > >
> > > > > > > > But you have a very good point here, I think it is wise to =
evaluate
> > > > > > > > the shortcut of these messages in the VDUSE kernel module. =
If a VDUSE
> > > > > > > > device only has one vq group and one ASID, it can always re=
turn group
> > > > > > > > 0 and asid 0 for everything, and fail every try to ser asid=
 !=3D 0.
> > > > > > >
> > > > > > > Yes, and vhost-vDPA needs to guard against the misconfigurati=
on.
> > > > > > >
> > > > > > > > This
> > > > > > > > way, the update is transparent for the VDUSE device, and fu=
ture
> > > > > > > > devices do not need to implement the reply of these. What d=
o you
> > > > > > > > think?
> > > > > > >
> > > > > > > This should work.
> > > > > > >
> > > > > > > >
> > > > > > > > > > 2) If VDUSE behave differently, do we need a ioctl to s=
et the API
> > > > > > > > > > version for backward compatibility?
> > > > > > > > >
> > > > > > > > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > > > > > > > >
> > > > > > > > > I think we need to think if it complicates the migration =
compatibility or not.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Do you mean migration as "increase the VDUSE version number=
", not "VM
> > > > > > > > live migration from vduse version 0 to vduse version 1", is=
n't it? The
> > > > > > > > second should not have any problem but I haven't tested it.
> > > > > > >
> > > > > > > I mean if we bump the version, we can't migrate from version =
1 to
> > > > > > > version 0. Or we can offload this to the management (do we ne=
ed to
> > > > > > > extend the vdpa tool for this)?
> > > > > > >
> > > > > >
> > > > > > I just noticed I left this unreplied. But I still do not get wh=
at
> > > > > > migrate means here :).
> > > > > >
> > > > > > If migrate means to run current VDUSE devices on kernel with th=
is
> > > > > > series applied these devices don't set V1 API so they have one =
vq
> > > > > > group, and one asid. I'm actually testing this with my libfuse+=
VDUSE
> > > > > > modifications that don't use V1 at all. Adding this explanation=
 to the
> > > > > > patch as it is a very good point indeed.
> > > > >
> > > > > Right.
> > > > >
> > > > > >
> > > > > > If it means to migrate a guest from using a V1 VDUSE device to =
a V0
> > > > > > device "it should work", as it is just a backend implementation
> > > > > > detail.
> > > > >
> > > > > For example src is the VDUSE with multiqueue support (v1) but des=
t
> > > > > doesn't have this support (v0). I think the qemu should fail to l=
aunch
> > > > > in dest.
> > > > >
> > > > > > If we migrate from or to a vdpa device backed by hardware, for
> > > > > > example, one of the devices does not even have the concept of V=
DUSE
> > > > > > API version.
> > > > > >
> > > > > > In the case of net, it does not work at the moment because the =
only
> > > > > > way to set features like mq are through the shadow CVQ.
> > > > >
> > > > > I think you mean qemu should fail, I'm not sure this is friendly =
to libvirt.
> > > > >
> > > >
> > > > No, I think QEMU should not transmit vdpa backend properties not
> > > > visible to the guest, so we don't get an explosion of properties th=
at
> > > > are hard to get. Expanding on this, QEMU is not even able to know i=
f
> > > > it is talking with VDUSE, vdpa_sim, or a vdpa device backed by
> > > > hardware. And I think we don't want QEMU to have this information. =
So
> > > > sending the VDUSE version implies removing a lot of useful
> > > > abstractions.
> > > >
> > > > In the case of net, the destination QEMU should fail if it is not a=
ble
> > > > to restore the device state. At this moment this implies to have at
> > > > least two ASID if the net device has CVQ, and that CVQ is in its ow=
n
> > > > ASID, but that may not be true in the future.
> > > >
> > > > But QEMU does not check if that is the case migrating between two
> > > > vdpa_net_sim if one supports ASID but the other doesn't.
> > >
> > > Ok I think I must miss something. I need some context here. For
> > > example, Is the shadow cvq option used by libvirt or not? (Or it has
> > > been enabled by default if Qemu detect cvq has its own group?)
> > >
> > > If shadow cvq is neither used by libvirt nor automatically enabled, w=
e
> > > need to make it work for libvirt first.
> > >
> > > If it relies on libvirt to enable it explicitly, is libvirt expected
> > > to detect the vDPA ability (I guess it is not what libvirt wants)?
> > > If shadow cvq is enabled automatically, migrating from V2 to V1 is
> > > fine but not the reverse.
> > >
> >
> > QEMU uses shadow CVQ automatically if all the conditions (ASID, proper
> > set of features, etc) are supported.
> >
>
> Ok, so V1 implies non-migratable.  So I'm still confused about how to
> deal with migration compatibility.
>
> For example, ping-pong migration between V1 and V2.
>

If the device does not have CVQ, everything works.

If the device has CVQ, it is not possible at the moment. Everything
breaks the same way as if the destination vhost_vdpa does not have the
ASID capability. For example, if the destination device is an intel,
pensando, or solidrun vdpa.

