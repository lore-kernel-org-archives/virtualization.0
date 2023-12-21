Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF606E594
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSlC2V45"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8798960AC9
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 12:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8798960AC9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FSlC2V45
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wSLvd8k-ykB0
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Dec 2023 12:09:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A76560A7F
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 12:09:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A76560A7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703160546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2zddOQ1qeYa0ve/5dlXq/cgaEaRPGUue1VUy/g3vDE=;
	b=FSlC2V45wHsApUV/R4OtDoTK2QSsXp3FxSOJDyDi9sX8EXewVemNBagcuSEW8yaf0CX2xZ
	MSCGxofPFW6lI1P8lSYtPu/L8HmOR2rEQGXdbSYqK6wF9Q1SvZaDxyoVFTir9ImDmWmKme
	wQIX5bH/tCIZhdg3UpaTiYAjIqepKtg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-DOHtsjrnNTGbUtilmEyJ5Q-1; Thu, 21 Dec 2023 07:09:05 -0500
X-MC-Unique: DOHtsjrnNTGbUtilmEyJ5Q-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5e76b663ef3so13227797b3.1
        for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 04:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703160545; x=1703765345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2zddOQ1qeYa0ve/5dlXq/cgaEaRPGUue1VUy/g3vDE=;
        b=GHHZTPPLGzEtV/h+Orj5O+6yNR8WaPoTGgHmC2v5mPqENx5R5znhG4xlobhII9fE79
         5kkITEKRDFDxWNfKFiQ3HUyqLQDRtP9aggdf7/iePi8o+mCysa2VFcD2217L4NN+IfQm
         66n7asKUbsG+RKiVe8BeK5JV+pX8vXtbgWuwG3qGJbUiySGc+V8urZ09vY6GtiPWN8LL
         ZQWJP9y5HMgw08LeKYwUHlGRuUbRd9P0fUBGVb8cfrunwHtFS7EUnls1ys8WgaAgoez1
         bgVuW5wprl9+a1nD/pt7OOHtJJN7xg96Oh5puGAQpAvHq/XioT5tawGAcqISjzs/30md
         zZVA==
X-Gm-Message-State: AOJu0YyOiJW/iq2IC6ykjaWwIjpMJ+XFUWj/QeCWw7d1VnEQ90AyR5NR
	I5OCZmVfsVY4/vQdL3yX53HfaRuB/qZ1jqdxmSLo9VC50KhSOb9cyZeo6aTbkTpq2DvlpiNAT8Q
	kDoA+xu0Noe0gYB+cJVv/hiuGGFFnatBPfnXai8CjVRCHmaGblJCkRQ4pIQ==
X-Received: by 2002:a0d:eacc:0:b0:5e8:d7b2:cdcd with SMTP id t195-20020a0deacc000000b005e8d7b2cdcdmr1029737ywe.48.1703160544743;
        Thu, 21 Dec 2023 04:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+wUNNsjF8vEWQGGMpBGoBAUApRdPfu53AYtmvTV2W30g5Q9Sc3RlTNwEHeRRatnR6DBa23ya1wKjB1B+7qt4=
X-Received: by 2002:a0d:eacc:0:b0:5e8:d7b2:cdcd with SMTP id
 t195-20020a0deacc000000b005e8d7b2cdcdmr1029718ywe.48.1703160543744; Thu, 21
 Dec 2023 04:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
 <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
 <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
 <CACGkMEuM7bXxsxHUs_SodiDQ2+akrLqqzWZBJSZEcnMASUkb+g@mail.gmail.com>
 <CAJaqyWeBVVcTZEzZK=63Ymk85wnRFd+_wK56UfEHNXBH-qy1Zg@mail.gmail.com> <70adc734331c1289dceb3bcdc991f3da7e4db2f0.camel@nvidia.com>
In-Reply-To: <70adc734331c1289dceb3bcdc991f3da7e4db2f0.camel@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 21 Dec 2023 13:08:27 +0100
Message-ID: <CAJaqyWeUHiZXMFkNBpinCsJAXojtPkGz+SjzUNDPx5W=qqON1w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Gal Pressman <gal@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"mst@redhat.com" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:52=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Thu, 2023-12-21 at 08:46 +0100, Eugenio Perez Martin wrote:
> > On Thu, Dec 21, 2023 at 3:03=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 9:32=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Wed, Dec 20, 2023 at 5:06=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatule=
a@nvidia.com> wrote:
> > > > > > >
> > > > > > > The virtio spec doesn't allow changing virtqueue addresses af=
ter
> > > > > > > DRIVER_OK. Some devices do support this operation when the de=
vice is
> > > > > > > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND =
flag
> > > > > > > advertises this support as a backend features.
> > > > > >
> > > > > > There's an ongoing effort in virtio spec to introduce the suspe=
nd state.
> > > > > >
> > > > > > So I wonder if it's better to just allow such behaviour?
> > > > >
> > > > > Actually I mean, allow drivers to modify the parameters during su=
spend
> > > > > without a new feature.
> > > > >
> > > >
> > > > That would be ideal, but how do userland checks if it can suspend +
> > > > change properties + resume?
> > >
> > > As discussed, it looks to me the only device that supports suspend is
> > > simulator and it supports change properties.
> > >
> > > E.g:
> > >
> > > static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
> > >                                   u64 desc_area, u64 driver_area,
> > >                                   u64 device_area)
> > > {
> > >         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > >         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> > >
> > >         vq->desc_addr =3D desc_area;
> > >         vq->driver_addr =3D driver_area;
> > >         vq->device_addr =3D device_area;
> > >
> > >         return 0;
> > > }
> > >
> >
> > So in the current kernel master it is valid to set a different vq
> > address while the device is suspended in vdpa_sim. But it is not valid
> > in mlx5, as the FW will not be updated in resume (Dragos, please
> > correct me if I'm wrong). Both of them return success.
> >
> In the current state, there is no resume. HW Virtqueues will just get re-=
created
> with the new address.
>

Oh, then all of this is effectively transparent to the userspace
except for the time it takes?

In that case you're right, we don't need feature flags. But I think it
would be great to also move the error return in case userspace tries
to modify vq parameters out of suspend state.

Thanks!


> > How can we know in the destination QEMU if it is valid to suspend &
> > set address? Should we handle this as a bugfix and backport the
> > change?
> >
> > > >
> > > > The only way that comes to my mind is to make sure all parents retu=
rn
> > > > error if userland tries to do it, and then fallback in userland.
> > >
> > > Yes.
> > >
> > > > I'm
> > > > ok with that, but I'm not sure if the current master & previous ker=
nel
> > > > has a coherent behavior. Do they return error? Or return success
> > > > without changing address / vq state?
> > >
> > > We probably don't need to worry too much here, as e.g set_vq_address
> > > could fail even without suspend (just at uAPI level).
> > >
> >
> > I don't get this, sorry. I rephrased my point with an example earlier
> > in the mail.
> >
>

