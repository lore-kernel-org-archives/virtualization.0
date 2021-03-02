Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F6BC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 11:22:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10C164F0B
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 11:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10C164F0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FDF683C46;
	Tue,  2 Mar 2021 11:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vUUKDhz-k4VQ; Tue,  2 Mar 2021 11:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C3CB83C6C;
	Tue,  2 Mar 2021 11:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6620C000B;
	Tue,  2 Mar 2021 11:22:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CEFCC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AD426F5FC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5WxAaooJRnZD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:22:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A44CC6F59F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:22:12 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id l22so1910171wme.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Mar 2021 03:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SDwUqaAsHA5FRvDlUqZl4ka6pBS2IXvTGOlaocG7Rho=;
 b=sv10Czd4L0vQ6micnkcf19rI0mCcFPFn8Y5QoydoJV8dI0WA24Lgwd6mfhvJQG1aEW
 CqHeCpsyLBiibSmcTKBh7b8s8nyZ3c/bhewvv5g1NXjO24BzzBHIVmXbBXGHTiOejGCk
 IzobSu0BOQWBPkD7aJB+O2Zc5GJow+9RAhfuCwXgRwZg0Du1Rel4f+lMfs0RX6elCAfG
 cwHJZWgkhReMQMyBOfvbBFVAL4c0M2p8icEqcSi8q6NQQYLZKXDIDZW9aguuGxB+sE+i
 Vgb/Hn3/2B8rSG5IqfwLDg0E+smTwKD/9Q9ch6VPj6xlPdk1WLZ8sBmAM6rKrcgRu23o
 jQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SDwUqaAsHA5FRvDlUqZl4ka6pBS2IXvTGOlaocG7Rho=;
 b=MqaqG1KlMfxSccdcAcCbD9neQHGesXSxRo8EJfwAMnDc6a40swKu7KnNAZx6f9DDTl
 DeUWl8IQMSdax6AKVhDeXwfqwtJI7INzFEUvE8H+KmpgeSIKw5L/ZskPbHbe1X6BR+4e
 GAUkU2AIwXAVPLpUHrHeRdAiyg40fw5EbuA7BTZId943LFhM+OqU6u2Si8oLJTIjClpF
 gfM01gm4uaeUBMchBikbg4iIFZWeFn14Lx/J76Op9Pi8nOvq/HWB1vGc92LudpV0DUAI
 cJprv7QOxK0XAOeiB+GKUWg9yJ6dHzuxJCDDRjz1AdmyTHUd3T5Xd7oH2K5v08mY8ama
 kclg==
X-Gm-Message-State: AOAM530Zf3wgUhsGflqatcsMVzdIQ01CmNXw/j+Hr6eFrsH3Gyf2swHC
 KNjC5D9fUZdxgsb3jZForb0=
X-Google-Smtp-Source: ABdhPJxBoa8cJ2IbS0S/eZriz7LjlVKByHkg9Xx/3eCothcBrCsfPOlCpZylm8aleY2O68wgjFVEng==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr3546817wmi.186.1614684130734; 
 Tue, 02 Mar 2021 03:22:10 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o3sm2051119wmq.46.2021.03.02.03.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 03:22:09 -0800 (PST)
Date: Tue, 2 Mar 2021 11:22:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH 06/27] virtio: Add virtio_queue_get_used_notify_split
Message-ID: <YD4f4KEIYRlTUP4/@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-7-eperezma@redhat.com>
 <20201207165848.GM203660@stefanha-x1.localdomain>
 <CAJaqyWc4oLzL02GKpPSwEGRxK+UxjOGBAPLzrgrgKRZd9C81GA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWc4oLzL02GKpPSwEGRxK+UxjOGBAPLzrgrgKRZd9C81GA@mail.gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2051370254808663820=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2051370254808663820==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AuODnRtc/rPJimRT"
Content-Disposition: inline


--AuODnRtc/rPJimRT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 07:21:27PM +0100, Eugenio Perez Martin wrote:
> On Mon, Dec 7, 2020 at 5:58 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Fri, Nov 20, 2020 at 07:50:44PM +0100, Eugenio P=E9rez wrote:
> > > This function is just used for a few commits, so SW LM is developed
> > > incrementally, and it is deleted after it is useful.
> > >
> > > For a few commits, only the events (irqfd, eventfd) are forwarded.
> >
> > s/eventfd/ioeventfd/ (irqfd is also an eventfd)
> >
>=20
> Oops, will fix, thanks!
>=20
> > > +bool virtio_queue_get_used_notify_split(VirtQueue *vq)
> > > +{
> > > +    VRingMemoryRegionCaches *caches;
> > > +    hwaddr pa =3D offsetof(VRingUsed, flags);
> > > +    uint16_t flags;
> > > +
> > > +    RCU_READ_LOCK_GUARD();
> > > +
> > > +    caches =3D vring_get_region_caches(vq);
> > > +    assert(caches);
> > > +    flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
> > > +    return !(VRING_USED_F_NO_NOTIFY & flags);
> > > +}
> >
> > QEMU stores the notification status:
> >
> > void virtio_queue_set_notification(VirtQueue *vq, int enable)
> > {
> >     vq->notification =3D enable; <---- here
> >
> >     if (!vq->vring.desc) {
> >         return;
> >     }
> >
> >     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> >         virtio_queue_packed_set_notification(vq, enable);
> >     } else {
> >         virtio_queue_split_set_notification(vq, enable);
> >
> > I'm wondering why it's necessary to fetch from guest RAM instead of
> > using vq->notification? It also works for both split and packed
> > queues so the code would be simpler.
>=20
> To use vq->notification makes sense at the end of the series.
>=20
> However, at this stage (just routing notifications, not descriptors),
> vhost device is the one updating that flag, not qemu. Since we cannot
> just migrate used ring memory to qemu without migrating descriptors
> ring too, qemu needs to check guest's memory looking for vhost device
> updates on that flag.
>=20
> I can see how that deserves better documentation or even a better
> name. Also, this function should be in the shadow vq file, not
> virtio.c.

I can't think of a reason why QEMU needs to know the flag value that the
vhost device has set. This flag is a hint to the guest driver indicating
whether the device wants to receive notifications.

Can you explain why QEMU needs to look at the value of the flag?

Stefan

--AuODnRtc/rPJimRT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA+H+AACgkQnKSrs4Gr
c8gsbQf+JXl+yqTOrys6EIAZbWGHPCn6AVKZFnl2apaGoJ99aVfZDz6Sv4YyZLdy
iHkI0sm2SF1Rayw+zwIFz1+90/AljnxphtCNcbJNoaZlc/9LtT/RVHtm/jmlfc9L
jjhhDnKd1t5npLKuDXLD5ZWftIyYbjNzPfESx1KH/DszkP0/e6mqB6sjFXpIdcgq
6lfV8Ms0Ml5Uq+SeSvh/ainTIjtnuZC9qqOkmDvy9SPhBjaWWGwZccWsFwoNGQwX
fIzs1RV+BJUynOmhyGfj3NTsHn/paqnidefPifMGnXEt+nqXvFL1G42lur/jfkoc
E0hyTf78g2P48flKMInd7AW3G84DLg==
=IHvW
-----END PGP SIGNATURE-----

--AuODnRtc/rPJimRT--

--===============2051370254808663820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2051370254808663820==--
