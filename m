Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EAC433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:05:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944EA610FC
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 944EA610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CD7A42701;
	Mon,  4 Oct 2021 15:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uTchU2vvY6Ae; Mon,  4 Oct 2021 15:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 07C5A42714;
	Mon,  4 Oct 2021 15:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4F61C0011;
	Mon,  4 Oct 2021 15:05:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 783D3C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ABD961B66
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2rLeStASi7h
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:05:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96B8360BF5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633359925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BKqfFNCEMivwB08FbXWvEqkCe6mHCvfbmubuJ0I97xQ=;
 b=PA5NJefekyfUmlATpzBM6lh9B9YY6GEpuBaxgEeQJOap2dYBJuGm3lpY7PkCgpcsZGiEoP
 22C/AYTGHrpfO+6VKXQlf6bWO4Xk9l5MaKibZigJ+drU7I2l8X0Q+EK+uBXaGEPXZsh4nd
 a+bqyWjq0BpFZ7nxH5eEPlQWPp/cyUM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-9apTo0hlP1OQrhQCFQJ-9Q-1; Mon, 04 Oct 2021 11:05:24 -0400
X-MC-Unique: 9apTo0hlP1OQrhQCFQJ-9Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 k2-20020a50ce42000000b003dadf140b15so5801368edj.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 08:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BKqfFNCEMivwB08FbXWvEqkCe6mHCvfbmubuJ0I97xQ=;
 b=I8zddD/BayV0JzGfGSQp2Rm8jjhBHp/GaTxXz7Dzy9dgnAlrb8aLTqca8jbRNnyZjN
 3JTIByD0zZB4H6UuFcNjZ7mQ8jlIXIl9Ef7gohC+nvL3ProuPdx8B1/5JIaca8AHn5es
 UdCzulCWX4JdzBB5NQBM1CwySaWbPWsxlkSUPlA5CFLhMtzr499L3kpGuRzkQzv7FHPz
 /Jj8QfW8s7cjL/5C2AA1RtU6LKLLgy10l5RIAx0rnk+liZ/X24ewco48vgT4i5Na5kWS
 XIyqL3EDXGTTzsam6lKGifDrJjbQOCqzB1Fm8BuA4I5p1T0lLwQlMAqrN/cz8Ua47bHO
 wEFw==
X-Gm-Message-State: AOAM53047GZdwS4ei8fT0cDtfu8QD+ejvUIQpim80ZxPNs6bhNukRJGo
 LpX9xeLMAIq2qZsy1u2SH8Ei0x6ynpVN3l1506f0rEdSChl1o4kNjuMX3Xp48IMdNt/rk40ryuH
 LzQW2+3P05n/gB9zG3eaegdLf+QB7HP8uLn/Qle851Q==
X-Received: by 2002:aa7:c418:: with SMTP id j24mr2864608edq.227.1633359923328; 
 Mon, 04 Oct 2021 08:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU9JadIuhF6Ys560lNNF+Op6UHEczKovjv7KBzOJz0VaWG0AO+P6FEUJqR3gX5bD8rYhffhA==
X-Received: by 2002:aa7:c418:: with SMTP id j24mr2864584edq.227.1633359923175; 
 Mon, 04 Oct 2021 08:05:23 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
 by smtp.gmail.com with ESMTPSA id
 x13sm6473465ejv.64.2021.10.04.08.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 08:05:22 -0700 (PDT)
Date: Mon, 4 Oct 2021 11:05:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004110152-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <878rz83lx0.fsf@redhat.com>
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

On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
> >> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
> >> >  Specification text within these sections generally does not apply
> >> >  to non-transitional devices.
> >> >  
> >> > +\begin{note}
> >> > +The device offers different features when used through
> >> > +the legacy interface and when operated in accordance with this
> >> > +specification.
> >> > +\end{note}
> >> > +
> >> > +Transitional drivers MUST use Devices only through the legacy interface
> >> 
> >> s/Devices only through the legacy interface/devices through the legacy
> >> interface only/
> >> 
> >> ?
> >
> > Both versions are actually confused, since how do you
> > find out that device does not offer VIRTIO_F_VERSION_1?
> >
> > I think what this should really say is
> >
> > Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
> > the legacy interface.
> 
> Ok, that makes sense.
> 
> Would it make sense that transitional drivers MUST accept VERSION_1
> through the non-legacy interface? Or is that redundant?

We already have:

A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.


> >
> >
> > Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
> > through the legacy interface if offered?
> 
> I think that the Linux drivers will not operate on feature bit 32+ if
> they are in legacy mode?


Well ... with PCI there's no *way* for host to set bit 32 through
legacy. But it might be possible with MMIO/CCW. Can you tell me
what happens then?


> >> 
> >> Generally, looks good to me.
> >
> > Do we want to also add explanation that features can be
> > changed until FEATURES_OK?
> 
> I always considered that to be implict, as feature negotiation is not
> over until we have FEATURES_OK. Not sure whether we need an extra note.

Well Halil here says once you set a feature bit you can't clear it.
So maybe not ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
