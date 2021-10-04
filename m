Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47347C433FE
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 20:01:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94A761409
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 20:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D94A761409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D5CB83C04;
	Mon,  4 Oct 2021 20:01:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UwY_XORfJyzF; Mon,  4 Oct 2021 20:01:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EA5183C02;
	Mon,  4 Oct 2021 20:01:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9C78C0011;
	Mon,  4 Oct 2021 20:01:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F079EC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD4D940133
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R1VdvlrrCnnP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:01:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF01B400ED
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633377681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KsdJcxDdgTF/zmQf/6TyWls50jhunD8gsTgc9KR7gmk=;
 b=I5jPMqbV0kwAr7vgIY294MShGNApyLTO5OGdypc8T40AV3COJxjZpqsig53hGTreJ3Biw8
 uNbPln8GF7WZuE0YF2NvMKNXYmziy+R1xf5KbuLNvbdoWiGy0htushFMYz/YfjBRt8LSqV
 lPPT2kLYz10GUKjqrzE25VdQ6lOAzik=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-EbWVUY6nPMaNhXUvKAqvEA-1; Mon, 04 Oct 2021 16:01:19 -0400
X-MC-Unique: EbWVUY6nPMaNhXUvKAqvEA-1
Received: by mail-ed1-f72.google.com with SMTP id
 t28-20020a508d5c000000b003dad7fc5caeso8404464edt.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 13:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KsdJcxDdgTF/zmQf/6TyWls50jhunD8gsTgc9KR7gmk=;
 b=eFX7w9usUKv7uRha+CW6H2GOW+UWDGYi/NpkXFCSXcwRmOhQ9+LnnOzpnkfVZcTFpf
 aWlOMlxtmLafmBsbDR+q+X0XTDoAcN7Hj4U1RJe8atVIql8pkPNotTTDyTkLD1kKH7IJ
 gHaUCA67OY3M6J6aSZIHVX4aihZjaiXzT9XvDWeItZxBQ2dcpB3vnhd65hGQQBTZnZVR
 UMFgUPeTYzCtc1KSUXlM9Ihh4RM/QD4Y18y0h++KNMji9ZUStDKYaZnxcKa4YuTYZ1Gs
 dAq6ni1kBn/AJXNNHISUt/VRTgxJOofTzKJnNu9eb5SdqJxPQ9sEYKJD6o5Gl7nmNsMc
 gmYw==
X-Gm-Message-State: AOAM532O6z2xlk4eGIs+MhpW4ud900+Jsg5TPrJYF5U3LQlEV67FyRnF
 Z3W8daxkrp5EuCjVYTK9+p5ESk54WJo+yB70h0I3w4evfzRHTuAdsZIY4LdjcjBTwy0gsOA2Han
 Xzkjmh/cB3Oqsm/MT3gkl3aEFad7xG7SIN03WH1FmXw==
X-Received: by 2002:a05:6402:2906:: with SMTP id
 ee6mr17966511edb.170.1633377678169; 
 Mon, 04 Oct 2021 13:01:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuHj3hrys0X5jcvBEKc8g2+iuDhizhWCRoVmy0jn4kkURJJbD11p6ILeMeXQvLwtLsevqp+A==
X-Received: by 2002:a05:6402:2906:: with SMTP id
 ee6mr17966483edb.170.1633377677943; 
 Mon, 04 Oct 2021 13:01:17 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id z8sm6874865ejd.94.2021.10.04.13.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 13:01:17 -0700 (PDT)
Date: Mon, 4 Oct 2021 16:01:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
Message-ID: <20211004160005-mutt-send-email-mst@kernel.org>
References: <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
 <87zgro23r1.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87zgro23r1.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Xie Yongji <xieyongji@bytedance.com>, virtio-dev@lists.oasis-open.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Oct 04, 2021 at 05:45:06PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
> >> >> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
> >> >> >  Specification text within these sections generally does not apply
> >> >> >  to non-transitional devices.
> >> >> >  
> >> >> > +\begin{note}
> >> >> > +The device offers different features when used through
> >> >> > +the legacy interface and when operated in accordance with this
> >> >> > +specification.
> >> >> > +\end{note}
> >> >> > +
> >> >> > +Transitional drivers MUST use Devices only through the legacy interface
> >> >> 
> >> >> s/Devices only through the legacy interface/devices through the legacy
> >> >> interface only/
> >> >> 
> >> >> ?
> >> >
> >> > Both versions are actually confused, since how do you
> >> > find out that device does not offer VIRTIO_F_VERSION_1?
> >> >
> >> > I think what this should really say is
> >> >
> >> > Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
> >> > the legacy interface.
> >> 
> >> Ok, that makes sense.
> >> 
> >> Would it make sense that transitional drivers MUST accept VERSION_1
> >> through the non-legacy interface? Or is that redundant?
> >
> > We already have:
> >
> > A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.
> 
> Yep, so it is redundant.
> 
> >
> >
> >> >
> >> >
> >> > Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
> >> > through the legacy interface if offered?
> >> 
> >> I think that the Linux drivers will not operate on feature bit 32+ if
> >> they are in legacy mode?
> >
> >
> > Well ... with PCI there's no *way* for host to set bit 32 through
> > legacy. But it might be possible with MMIO/CCW. Can you tell me
> > what happens then?
> 
> ccw does not support accessing bit 32+, either. Not sure about mmio.
> 
> >
> >
> >> >> 
> >> >> Generally, looks good to me.
> >> >
> >> > Do we want to also add explanation that features can be
> >> > changed until FEATURES_OK?
> >> 
> >> I always considered that to be implict, as feature negotiation is not
> >> over until we have FEATURES_OK. Not sure whether we need an extra note.
> >
> > Well Halil here says once you set a feature bit you can't clear it.
> > So maybe not ...
> 
> Ok, so what about something like
> 
> "If FEATURES_OK is not set, the driver MAY change the set of features it
> accepts."
> 
> in the device initialization section?

Maybe "as long as". However Halil implied that some features are not
turned off properly if that happens. Halil could you pls provide
some examples?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
