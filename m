Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40A9C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 12:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33B47600D1;
	Mon, 13 Feb 2023 12:03:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33B47600D1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddLVoNF/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kxrQPmTy2QJ; Mon, 13 Feb 2023 12:03:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6508E600B6;
	Mon, 13 Feb 2023 12:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6508E600B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43259C0033;
	Mon, 13 Feb 2023 12:03:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A6ECC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74F5C40272
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74F5C40272
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddLVoNF/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zH-xyEmIgkXt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:03:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 123884024A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 123884024A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676289806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SXgBGYisUQ8diSE+v/6E4yyjWduJqYTQoW4hjh59pU=;
 b=ddLVoNF/2kGtQp6iEVq4FyMYN1yAFybPPDZhkDJg8glXFLhLd1mdydzGviSkeBs/9Ncek4
 BNdg91yVc9CSGaEuM7mYC4R/DKN1LG+eHvZ6Nmmb5LrbdyE3J5ZflGRQhl9jnGjj1Zj/9D
 cLqEOUOU26Cc3xB8qGpewbQ6/td32fc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-uvgqhJcgM-aGLbjrpbhbJQ-1; Mon, 13 Feb 2023 07:03:21 -0500
X-MC-Unique: uvgqhJcgM-aGLbjrpbhbJQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 ev18-20020a056402541200b004a621e993a8so7469509edb.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 04:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1SXgBGYisUQ8diSE+v/6E4yyjWduJqYTQoW4hjh59pU=;
 b=CWuWNrfZs9f5R3HWFH67wc5lx5xkq4t1Xu/KkDooqFKS2SJlfjH8zkpqo4VhdDsm/i
 m7zJB1EuWkBX4sFYSy4NoMgO7jfCjZhMZmqGm6lksKBS6GSCB3WM/dA+NrJ5hYRKl6vD
 5dDA4CSmjE2YD0rv2YeDwKTPHcWU+HC9iEttPmazAtHNcsZ/N8EqwsdaWkNduqO5+ksX
 pgvp+FuANYghuh6+nNmMfSbEweVIGUT5rMRE/stMV0jQNH4HpOVYyAkKySQujAnwdDxb
 xpv4ZOpyQd6UAHQsV3YznWEeHLFW0v/i2YA43cmfZQlrW9pSj+3ke8bYSv0+mzreXZo9
 fmBw==
X-Gm-Message-State: AO0yUKW4IEJ4SktFPNm4LBzxoEbICKlNyjdmGI3pJMCUZeOkww6hq3+x
 sUeieCjMEoVXURX/NELsj89qMMflhYkHkQ2JFL+OIr/B32EG3A8DJP3srPVjJ/jnrBqYTqz/26b
 W5ilNi+ldqeBa1ohKUSeyA9F06kKx5RH2Xk+WmdZvUQ==
X-Received: by 2002:a17:907:3e0d:b0:8b1:d5c:986e with SMTP id
 hp13-20020a1709073e0d00b008b10d5c986emr4690545ejc.15.1676289800745; 
 Mon, 13 Feb 2023 04:03:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+tbCjGUeRdIebjg4KH94Xlrud5ePfcZiOsxW4hZEztVQmMNrBwQoh/ft2VBRBfQc7AvNql7A==
X-Received: by 2002:a17:907:3e0d:b0:8b1:d5c:986e with SMTP id
 hp13-20020a1709073e0d00b008b10d5c986emr4690522ejc.15.1676289800518; 
 Mon, 13 Feb 2023 04:03:20 -0800 (PST)
Received: from redhat.com ([2.52.132.212]) by smtp.gmail.com with ESMTPSA id
 19-20020a170906059300b0088f8803661asm6660033ejn.8.2023.02.13.04.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Feb 2023 04:03:19 -0800 (PST)
Date: Mon, 13 Feb 2023 07:03:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
Message-ID: <20230213070248-mutt-send-email-mst@kernel.org>
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
 <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
 <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com>
 <CAJaqyWeWaddX9KjZWs8n9eqx8u-Lk4Nj+VVH_jDh38URuZWJdA@mail.gmail.com>
 <CACGkMEubK3jRyKy5_TsRvKtcUQ2dYnr_hEnWwds4ZtewVsxz_Q@mail.gmail.com>
 <CAJaqyWcqnHAkUv9UZF=dOukg0C5u2g+eB-G5g8p+adcGZwRB_Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcqnHAkUv9UZF=dOukg0C5u2g+eB-G5g8p+adcGZwRB_Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com,
 "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jan 31, 2023 at 08:58:37AM +0100, Eugenio Perez Martin wrote:
> On Tue, Jan 31, 2023 at 4:16 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Jan 31, 2023 at 12:39 AM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Sun, Jan 29, 2023 at 7:01 AM Jason Wang <jasowang@redhat.com> wrot=
e:
> > > >
> > > > On Thu, Jan 19, 2023 at 4:11 PM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jan 19, 2023 at 4:20 AM Jason Wang <jasowang@redhat.com> =
wrote:
> > > > > >
> > > > > > On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=E9rez <eperezma@redh=
at.com> wrote:
> > > > > > >
> > > > > > > Starting from an used_idx different than 0 is needed in use c=
ases like
> > > > > > > virtual machine migration.  Not doing so and letting the call=
er set an
> > > > > > > avail idx different than 0 causes destination device to try t=
o use old
> > > > > > > buffers that source driver already recover and are not availa=
ble
> > > > > > > anymore.
> > > > > > >
> > > > > > > While callers like vdpa_sim set avail_idx directly it does no=
t set
> > > > > > > used_idx.  Instead of let the caller do the assignment, fetch=
 it from
> > > > > > > the guest at initialization like vhost-kernel do.
> > > > > > >
> > > > > > > To perform the same at vring_kernel_init and vring_user_init =
is left for
> > > > > > > the future.
> > > > > > >
> > > > > > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
> > > > > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > > > > > index 33eb941fcf15..0eed825197f2 100644
> > > > > > > --- a/drivers/vhost/vringh.c
> > > > > > > +++ b/drivers/vhost/vringh.c
> > > > > > > @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const =
struct vringh *vrh,
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +/**
> > > > > > > + * vringh_update_used_idx - fetch used idx from driver's use=
d split vring
> > > > > > > + * @vrh: The vring.
> > > > > > > + *
> > > > > > > + * Returns -errno or 0.
> > > > > > > + */
> > > > > > > +static inline int vringh_update_used_idx(struct vringh *vrh)
> > > > > > > +{
> > > > > > > +       return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->v=
ring.used->idx);
> > > > > > > +}
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * vringh_init_iotlb - initialize a vringh for a ring with I=
OTLB.
> > > > > > >   * @vrh: the vringh to initialize.
> > > > > > > @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *v=
rh, u64 features,
> > > > > > >                       struct vring_avail *avail,
> > > > > > >                       struct vring_used *used)
> > > > > > >  {
> > > > > >
> > > > > > While at this, I wonder if it's better to have a dedicated para=
meter
> > > > > > for last_avail_idx?
> > > > > >
> > > > >
> > > > > I also had that thought. To directly assign last_avail_idx is not=
 a
> > > > > specially elegant API IMO.
> > > > >
> > > > > Maybe expose a way to fetch used_idx from device vring and pass
> > > > > used_idx as parameter too?
> > > >
> > > > If I was not wrong, we can start from last_avail_idx, for used_idx =
it
> > > > is only needed for inflight descriptors which might require other
> > > > APIs?
> > > >
> > > > (All the current vDPA user of vringh is doing in order processing)
> > > >
> > >
> > > That was actually my first attempt and it works equally well for the
> > > moment, but it diverges from vhost-kernel behavior for little benefit.
> > >
> > > To assign both values at set_vring_base mean that if vDPA introduces
> > > an (hypothetical) VHOST_VDPA_F_INFLIGHT backend feature in the future,
> > > the initialization process would vary a lot:
> > > * Without that feature, the used_idx starts with 0, and the avail one
> > > is 0 or whatever value the user set with vring_set_base.
> > > * With that feature, the device will read guest's used_idx as
> > > vhost-kernel? We would enable a new ioctl to set it, or expand
> > > set_base to include used_idx, effectively diverting from vhost-kernel?
> >
> > Adding Longpeng who is looking at this.
> >
> =

> Sorry, I'll CC longpeng2@huawei.com in future series like this one.
> =

> > We can leave this to the caller to decide.
> >
> > Btw, a question, at which case the device used index does not equal to
> > the used index in the vring when the device is suspended? I think the
> > correct way is to flush the pending used indexes before suspending.
> > Otherwise we need an API to get pending used indices?
> >
> > >
> > > To me the wisest option is to move this with vhost-kernel. Maybe we
> > > need to add a feature bit to know that the hypervisor can trust the
> > > device will do "the right thing" (VHOST_VDPA_F_FETCH_USED_AT_ENABLE?),
> > > but we should keep it orthogonal to inflight descriptor migration in
> > > my opinion.
> >
> > I think we need to understand if there are any other possible use
> > cases for setting used idx other than inflight stuff.
> >
> =

> Answering this and the previous comment, I cannot think in any case
> outside of inflight migration. I'm just trying to avoid different
> behavior between vhost-kernel and vhost-vdpa, and to make features as
> orthogonal as possible.
> =

> > >
> > > Having said that, I'm totally ok to do it otherwise (or to expand the
> > > patch message if needed).
> >
> > I tend to do that in another series (not mix with the fixes).
> >
> > >
> > > > >
> > > > > > > -       return vringh_init_kern(vrh, features, num, weak_barr=
iers,
> > > > > > > -                               desc, avail, used);
> > > > > > > +       int r =3D vringh_init_kern(vrh, features, num, weak_b=
arriers, desc,
> > > > > > > +                                avail, used);
> > > > > > > +
> > > > > > > +       if (r !=3D 0)
> > > > > > > +               return r;
> > > > > > > +
> > > > > > > +       /* Consider the ring not initialized */
> > > > > > > +       if ((void *)desc =3D=3D used)
> > > > > > > +               return 0;
> > > > > >
> > > > > > I don't understand when we can get this (actually it should be =
a bug
> > > > > > of the caller).
> > > > > >
> > > > >
> > > > > You can see it in vdpasim_vq_reset.
> > > > >
> > > > > Note that to consider desc =3D=3D 0 to be an uninitialized ring i=
s a bug
> > > > > IMO. QEMU considers it that way also, but the standard does not f=
orbid
> > > > > any ring to be at address 0. Especially if we use vIOMMU.
> > > > >
> > > > > So I think the best way to know if we can use the vringh is either
> > > > > this way, or provide an explicit "initialized" boolean attribute.
> > > > > Maybe a new "bool is_initialized(vrh)" is enough, if we don't wan=
t to
> > > > > add new attributes.
> > > >
> > > > I wonder if we can avoid this in the simulator level instead of the
> > > > vringh (anyhow it only exposes a vringh_init_xxx() helper now).
> > > >
> > >
> > > In my opinion that is a mistake if other drivers will use it to
> > > implement the emulated control virtqueue. And it requires more
> > > changes. But it is doable for sure.
> >
> > The problem is, there's no reset API in vringh, that's why you need to
> > do if ((void *)desc =3D=3D used) which depends on behaviour of the vrin=
gh
> > user.
> >
> =

> That's a very good point indeed.
> =

> > So I think we should either:
> >
> > 1) move that check in vdpa_sim (since it's not guaranteed that all the
> > vringh users will make desc equal to used during reset)
> >
> > or
> >
> > 2) introduce a vringh_reset_xxx()
> >
> > 1) seems a good step for -stable.
> >
> =

> We can go to 1 for sure. So let's set last_used_idx at
> vdpasim_set_vq_state, same value as last_avail_idx, and stash it at
> vdpasim_queue_ready.
> =

> Do I need to resend the previous patch in this series?
> =

> Do we need to offer a new feature flag indicating we will set used_idx
> with avail_idx?
> =

> Thanks!

Jason did you forget to answer or did I miss it?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
