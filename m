Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804F0C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 10:47:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235FD60F70
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 10:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 235FD60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDBF1606CF;
	Tue,  5 Oct 2021 10:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 552Dtx9_cQPj; Tue,  5 Oct 2021 10:47:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9824860901;
	Tue,  5 Oct 2021 10:47:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75147C0011;
	Tue,  5 Oct 2021 10:47:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62DDFC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EBF8608F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gox53VV4NzFI
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:47:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E67F606CF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633430846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSezvwv3jMKfiJeQ28bxl4IfTF/WIcZedFXvE46Dhao=;
 b=hxIcg8zoodw9CfCLex42uCLqXye3N7roJ+CMdIkyCa1klZ0DpB6URnE8cSXXFqW2DFEZOH
 YfYPETsMW/OtSzCnM74AwkTL7niCBa9HiLNWAHLzMM7B2p9iBNckQu/a2/ByrIFM+9qCHR
 hff9MENAFBnTyD/lLMV+3uh52X67D/g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-ps3volXAP-63r_u1oOsgzQ-1; Tue, 05 Oct 2021 06:47:23 -0400
X-MC-Unique: ps3volXAP-63r_u1oOsgzQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 i7-20020a50d747000000b003db0225d219so3052758edj.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 03:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GSezvwv3jMKfiJeQ28bxl4IfTF/WIcZedFXvE46Dhao=;
 b=QH7HXzFDXvVAmhYundI/FM288Oj2qv6N/FidgCdUKmmZ8E26rykZDCC2/gKGF/0AC7
 74HZujUa1w42JvRgNx0/fqbJBTNAplcJ0CcyOLZXEpnh5Gq5PsYrmWYP2yAt9xfgzWXS
 Gd0lAUAQUN29HPTI69LWp2wBIuy18VZTxtO/+1iNUv55NkVbrMNGOfLwanY6KdjGLsqh
 Jt8svQGCk3JzlOqSQvPDo3IBgNDkMJ1LjcnvgvqqydesKR6mj1xUyTEsUxU+O6Z7Ocpd
 ZCrkvpsndj4XrR3QByOj3Z6n+lZQhceIojaxSXJJu9b4PbnV7iuPQkAP610054UrJeHA
 ImNg==
X-Gm-Message-State: AOAM530Z8rJUKr90BZ9dE+i4ZHO4qzSo+iTM2IHbKdqmbQfa5O137Hy3
 SJuSuEpmNvTUvbetkMCVmt1t2wYfiS+2tbowTQcsOwMIlVuC9Mg0WVVjXSngQDth7uA85xGItVb
 KMS7IWKxYSUu/UkJgqpKzUFBT63Zf2HR1cbC3m5M1gw==
X-Received: by 2002:a17:906:3913:: with SMTP id
 f19mr23783071eje.357.1633430842130; 
 Tue, 05 Oct 2021 03:47:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkHxn46mMyBsHV8Kl5BW5My9PyoVeLFBejtw4h3r5E9unv1gW1akbMUdS120l5EcwJ5CL4Wg==
X-Received: by 2002:a17:906:3913:: with SMTP id
 f19mr23783042eje.357.1633430841821; 
 Tue, 05 Oct 2021 03:47:21 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id x5sm4367335edr.78.2021.10.05.03.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 03:47:21 -0700 (PDT)
Date: Tue, 5 Oct 2021 06:47:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 2/3] vdpa: Add vhost_vdpa_section_end
Message-ID: <20211005064646-mutt-send-email-mst@kernel.org>
References: <20211005080131.408506-1-eperezma@redhat.com>
 <20211005080131.408506-3-eperezma@redhat.com>
 <20211005041429-mutt-send-email-mst@kernel.org>
 <CAJaqyWfa8DLkLjmcOYd-av1ZsTDFyr++_+1omomtS=-Qq=Y9zw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfa8DLkLjmcOYd-av1ZsTDFyr++_+1omomtS=-Qq=Y9zw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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

On Tue, Oct 05, 2021 at 11:52:37AM +0200, Eugenio Perez Martin wrote:
> On Tue, Oct 5, 2021 at 10:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 05, 2021 at 10:01:30AM +0200, Eugenio P=E9rez wrote:
> > > Abstract this operation, that will be reused when validating the regi=
on
> > > against the iova range that the device supports.
> > >
> > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> >
> > Note that as defined end is actually 1 byte beyond end of section.
> > As such it can e.g. overflow if cast to u64.
> > So be careful to use int128 ops with it.
> =

> You are right, but this is only the result of extracting "llend"
> calculation in its own function, since it is going to be used a third
> time in the next commit. This next commit contains a mistake because
> of this, as you pointed out.
> =

> Since "last" would be a very misleading name, do you think we could
> give a better name / type to it?
> =

> > Also - document?
> =

> It will be documented with that ("It returns one byte beyond end of
> section" or similar) too.
> =

> Thanks!

that's how c++ containers work so maybe it's not too bad as long
as we document this carefully.

> >
> > > ---
> > >  hw/virtio/vhost-vdpa.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > index ea1aa71ad8..a1de6c7c9c 100644
> > > --- a/hw/virtio/vhost-vdpa.c
> > > +++ b/hw/virtio/vhost-vdpa.c
> > > @@ -24,6 +24,15 @@
> > >  #include "trace.h"
> > >  #include "qemu-common.h"
> > >
> > > +static Int128 vhost_vdpa_section_end(const MemoryRegionSection *sect=
ion)
> > > +{
> > > +    Int128 llend =3D int128_make64(section->offset_within_address_sp=
ace);
> > > +    llend =3D int128_add(llend, section->size);
> > > +    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> > > +
> > > +    return llend;
> > > +}
> > > +
> > >  static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection =
*section)
> > >  {
> > >      return (!memory_region_is_ram(section->mr) &&
> > > @@ -160,10 +169,7 @@ static void vhost_vdpa_listener_region_add(Memor=
yListener *listener,
> > >      }
> > >
> > >      iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> > > -    llend =3D int128_make64(section->offset_within_address_space);
> > > -    llend =3D int128_add(llend, section->size);
> > > -    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> > > -
> > > +    llend =3D vhost_vdpa_section_end(section);
> > >      if (int128_ge(int128_make64(iova), llend)) {
> > >          return;
> > >      }
> > > @@ -221,9 +227,7 @@ static void vhost_vdpa_listener_region_del(Memory=
Listener *listener,
> > >      }
> > >
> > >      iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> > > -    llend =3D int128_make64(section->offset_within_address_space);
> > > -    llend =3D int128_add(llend, section->size);
> > > -    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> > > +    llend =3D vhost_vdpa_section_end(section);
> > >
> > >      trace_vhost_vdpa_listener_region_del(v, iova, int128_get64(llend=
));
> > >
> > > --
> > > 2.27.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
