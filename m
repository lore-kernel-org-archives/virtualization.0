Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF812DCF7C
	for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902913; cv=none; b=nl9XCzWOsV3x0wJWwnKu6VdYEDLspEOFMXKgI+k3WNuLR87ljVLsD7LZJB3Gjizq+Tf8jhSkKYnp2cj/KD7L6mCGPQPOQ0l3gbM31tmM4c2LUmp22TOKzmrMrCfaGnSBKbaYqU9nJPnPFN9I4fvoqR+IUqMRGYPJUhgx49qeY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902913; c=relaxed/simple;
	bh=9hlEPV/IfDDtQtAOKScDD2ZMyM5monkE73IXEFC6zd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwAzNgMFL07Fn/1PQG2rpk2CnGg5dVCD5GCqg3TNtjgSJAeX8lZ3hOlY2ma9IFgQnjXxvcUb8dSJzw/jaTrI4Oq21p0kAvIxiVGlF7epwLYP0TmVX7CqxY+qDHRU3vPzUvRDBwH0kDrnksiuDQRGG4FWuheI1M30PiIYpEWLllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpgdFKlH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpgdFKlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754902910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hlEPV/IfDDtQtAOKScDD2ZMyM5monkE73IXEFC6zd0=;
	b=FpgdFKlHJVS0K9hyqxJPI00C+qLdQraBERFJdS0DQz82kbqdUc3SiO5uG9ZBOQdGVVwd2I
	wkDrl9/PRII9jP3hPNoB3RGIKLtQagKBfagJv2bITuLIqY4b0b7cdZuU2pnt/znXDjLXzE
	Gr8n6aJ7VymxePL8GDcQjt9D38FInTs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-J4GgbWHKPvS66jepFhTWpA-1; Mon, 11 Aug 2025 05:01:48 -0400
X-MC-Unique: J4GgbWHKPvS66jepFhTWpA-1
X-Mimecast-MFC-AGG-ID: J4GgbWHKPvS66jepFhTWpA_1754902906
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f4d0f60caso4093290a91.1
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 02:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902906; x=1755507706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hlEPV/IfDDtQtAOKScDD2ZMyM5monkE73IXEFC6zd0=;
        b=lxEH1vZ5ipxoFmL/Q7oXb71S1Ovs/A94nK1N3jpaCKWfxQ0lPRCXiiyKibSvYBUo9E
         MGMgNUmhgEeHxREKR3a/YHUhEbPYcDFo/P8SI9H7wrkhZcEvAwwq88bT4q9hf/zVjc9o
         lu8OgElhNrY9+DP3p3PFlwvjbvfeYnRyxxflSkAsaUOonqe2llHdMt6zip6LMvW9x8Ga
         lh12trGwo0zCR1ACT8IxG91Lp72KPt+TTNnksG1Ruq4ouhAif/RvboYUsgnywNlbiHH3
         u8Qaq+xCMChFYX3a+4luDxdcOUMcgGraJmfPfOQskSpmCiJw/At0Ds8ztTzYi5E5yB8N
         2f2w==
X-Forwarded-Encrypted: i=1; AJvYcCX5mq6CKugi6KuM/UDEzGY0TlTfmprLFV8PIG2I+s0m9TbbvOojWjRRX23FBd04G8FWxvt5dUkUDYexFTS7BA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg10Tqc043gRuSB0ZjYn/HhOW9P15hvFUjQY+M7pUoZfAG6m9/
	WmJL9Ib5b13G5CfKgZRGwJrIXTAVLtlG9ljd2hGqdBR2UqYgNHzYPmMbBW5lyZjUjVSdEPo8nlo
	gj1AQ5KnIy6G8Qx0ng7cp2xvQRs8GjmohmyBwOGL21MrKZNZi/5SahQHUo/46airyp4xi4yPTOY
	1maj+iNOQZON3BxL9nepiVgD3CbR39kA3wWhMTA53+Msg=
X-Gm-Gg: ASbGncuafO0q8fF5CjuVdTChXwQjjTcES/Ba7MS/GXKeiAVr5AVfGu+xiGOgCp5o7hM
	Yk8f73g67AKe2ENUtS9fieaUvhDSu5+9vzTpYSM1e/IgRzEFnlUDh0+NR7mAggbHwh8oi4r+bec
	HIEF12KKKnAzEzhIqnlhfO
X-Received: by 2002:a17:90b:52:b0:321:59e7:c5c2 with SMTP id 98e67ed59e1d1-321839f14a1mr17447501a91.9.1754902906028;
        Mon, 11 Aug 2025 02:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDuECMN77vMhYusYpt4WAkjMkw1WRpYN/6auGgR1Mm8CVoxiVNx6ETAxfGe0AVp7SZTkrxI+PiVXP/b49cjfg=
X-Received: by 2002:a17:90b:52:b0:321:59e7:c5c2 with SMTP id
 98e67ed59e1d1-321839f14a1mr17447453a91.9.1754902905548; Mon, 11 Aug 2025
 02:01:45 -0700 (PDT)
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
 <CAJaqyWeteUcvzTbcf2ShatX8QLCVCEgs-dgy19ir=W3LJE3y1A@mail.gmail.com> <CACGkMEtir49z9P=82SO9a4JML9D71UAaGSm38R2Ubx3Sg6ZufQ@mail.gmail.com>
In-Reply-To: <CACGkMEtir49z9P=82SO9a4JML9D71UAaGSm38R2Ubx3Sg6ZufQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Aug 2025 11:01:08 +0200
X-Gm-Features: Ac12FXyzukIYhcamNRSmGi93ksor1rxeDb1YWIzRqL5BOnr9nU4K34fcomJB3m4
Message-ID: <CAJaqyWfZn36gGbT=MjpdcXi3Sje1WRB6nycXJwP_BPugSzHRyQ@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Og_CJ-3PTIANTybin3_kXv3lH6qXX_rVmQNz7ICkWAk_1754902906
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Aug 10, 2025 at 6:18=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Aug 8, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Thu, Aug 7, 2025 at 6:56=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <=
eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > This allows to define all functions checking the API vers=
ion set by the
> > > > > > > > > userland device.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > >
> > > > > > > > It might be worth clarifying how it works.
> > > > > > > >
> > > > > > > > For example,
> > > > > > > >
> > > > > > > > 1) would VDUSE behave differently or if it's just some new =
ioctls
> > > > > >
> > > > > > I'd like to test more in-depth, but a device can just bump the =
version
> > > > > > ID and then implement the replies to the vduse messages. No nee=
d to
> > > > > > implement new ioctls. If the VDUSE device sets 0 in either numb=
er of
> > > > > > ASID or vq groups, the kernel assumes 1.
> > > > >
> > > > > Right, this is the way we use now and I think maybe we can docume=
nt
> > > > > this somewhere.
> > > > >
> > > > > >
> > > > > > But you have a very good point here, I think it is wise to eval=
uate
> > > > > > the shortcut of these messages in the VDUSE kernel module. If a=
 VDUSE
> > > > > > device only has one vq group and one ASID, it can always return=
 group
> > > > > > 0 and asid 0 for everything, and fail every try to ser asid !=
=3D 0.
> > > > >
> > > > > Yes, and vhost-vDPA needs to guard against the misconfiguration.
> > > > >
> > > > > > This
> > > > > > way, the update is transparent for the VDUSE device, and future
> > > > > > devices do not need to implement the reply of these. What do yo=
u
> > > > > > think?
> > > > >
> > > > > This should work.
> > > > >
> > > > > >
> > > > > > > > 2) If VDUSE behave differently, do we need a ioctl to set t=
he API
> > > > > > > > version for backward compatibility?
> > > > > > >
> > > > > > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > > > > > >
> > > > > > > I think we need to think if it complicates the migration comp=
atibility or not.
> > > > > > >
> > > > > >
> > > > > > Do you mean migration as "increase the VDUSE version number", n=
ot "VM
> > > > > > live migration from vduse version 0 to vduse version 1", isn't =
it? The
> > > > > > second should not have any problem but I haven't tested it.
> > > > >
> > > > > I mean if we bump the version, we can't migrate from version 1 to
> > > > > version 0. Or we can offload this to the management (do we need t=
o
> > > > > extend the vdpa tool for this)?
> > > > >
> > > >
> > > > I just noticed I left this unreplied. But I still do not get what
> > > > migrate means here :).
> > > >
> > > > If migrate means to run current VDUSE devices on kernel with this
> > > > series applied these devices don't set V1 API so they have one vq
> > > > group, and one asid. I'm actually testing this with my libfuse+VDUS=
E
> > > > modifications that don't use V1 at all. Adding this explanation to =
the
> > > > patch as it is a very good point indeed.
> > >
> > > Right.
> > >
> > > >
> > > > If it means to migrate a guest from using a V1 VDUSE device to a V0
> > > > device "it should work", as it is just a backend implementation
> > > > detail.
> > >
> > > For example src is the VDUSE with multiqueue support (v1) but dest
> > > doesn't have this support (v0). I think the qemu should fail to launc=
h
> > > in dest.
> > >
> > > > If we migrate from or to a vdpa device backed by hardware, for
> > > > example, one of the devices does not even have the concept of VDUSE
> > > > API version.
> > > >
> > > > In the case of net, it does not work at the moment because the only
> > > > way to set features like mq are through the shadow CVQ.
> > >
> > > I think you mean qemu should fail, I'm not sure this is friendly to l=
ibvirt.
> > >
> >
> > No, I think QEMU should not transmit vdpa backend properties not
> > visible to the guest, so we don't get an explosion of properties that
> > are hard to get. Expanding on this, QEMU is not even able to know if
> > it is talking with VDUSE, vdpa_sim, or a vdpa device backed by
> > hardware. And I think we don't want QEMU to have this information. So
> > sending the VDUSE version implies removing a lot of useful
> > abstractions.
> >
> > In the case of net, the destination QEMU should fail if it is not able
> > to restore the device state. At this moment this implies to have at
> > least two ASID if the net device has CVQ, and that CVQ is in its own
> > ASID, but that may not be true in the future.
> >
> > But QEMU does not check if that is the case migrating between two
> > vdpa_net_sim if one supports ASID but the other doesn't.
>
> Ok I think I must miss something. I need some context here. For
> example, Is the shadow cvq option used by libvirt or not? (Or it has
> been enabled by default if Qemu detect cvq has its own group?)
>
> If shadow cvq is neither used by libvirt nor automatically enabled, we
> need to make it work for libvirt first.
>
> If it relies on libvirt to enable it explicitly, is libvirt expected
> to detect the vDPA ability (I guess it is not what libvirt wants)?
> If shadow cvq is enabled automatically, migrating from V2 to V1 is
> fine but not the reverse.
>

QEMU uses shadow CVQ automatically if all the conditions (ASID, proper
set of features, etc) are supported.

