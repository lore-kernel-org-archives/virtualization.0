Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CE1C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 12:54:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CF46137D
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 12:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0CF46137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D1374273C;
	Mon,  4 Oct 2021 12:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBTXawwm2b9n; Mon,  4 Oct 2021 12:54:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E767841601;
	Mon,  4 Oct 2021 12:54:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE7DAC000F;
	Mon,  4 Oct 2021 12:54:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F40D6C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1CA260B3F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5F4fOtxIJmhx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:54:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CA2B60634
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633352070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6lrk0fk6ms6xnGimLrtDXbPUtIp40gvE+EO71fUNGKg=;
 b=hb5GdveyKs2w/K2jtaoTW7xmD4zXRp5lxlGM6mc5toK8QeBAa7/Nr+qLArti1PdkIJVh/Q
 Y+IuwQWcYksVvD78XeM+vYXacwLzyE2e8fX7qJEQoGmN0le4aTdPf09niUbmikgbBA0a59
 DaqTYzSBFDrI6QWgnhwG37zO4PoY6d8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-I4Q-wRzbNRmKrcq5rdVByw-1; Mon, 04 Oct 2021 08:54:30 -0400
X-MC-Unique: I4Q-wRzbNRmKrcq5rdVByw-1
Received: by mail-wm1-f69.google.com with SMTP id
 u14-20020a7bcb0e0000b0290248831d46e4so4731004wmj.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 05:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6lrk0fk6ms6xnGimLrtDXbPUtIp40gvE+EO71fUNGKg=;
 b=0Z90cTc8voQd5gPh6CLasEvE0H1jk9kFJQvrS0qi6oJpf8M/G8S8tvabXtCImOzUAs
 1Wi3ylzQbO9Yc6ew4BEHOCi3HBa9fGxIcfRRGFDJt+hW3op+uzeQTK3/RmasVbS5jvBn
 bzKSbVnsxD56b7Ega/daLO1fpB4shNM806fSwjDkFX1KjyIlGEBmFRj+DRTGpommKl+N
 sA/0dPymi+FZ0H111G1qTth+AzM6IjKUO2jW+SVW38P+S5DOvqbB3QNX1Aeq4t+YlwHU
 vZUYr6jy5kg09Xdv5LRj9nvdykucVazMi/Izx6io+Kgghw5yK3CkzH9zqqnCS3EEXMfv
 OyIQ==
X-Gm-Message-State: AOAM531SZDHr1OEZry62K97GKxeVjbFlZdd3c4dAZUzafbDT92POCDzO
 S3d4fTG9/vdn/NbdslAb0GwizUfOhXsxLYEcl0/RER0YYTIMBoVyjnk4h1UStEofVnNQc9q47iF
 FT8z+Icfj/Fx9EmVJ71PaiNE5/38YtC8hsHfw2zNpeg==
X-Received: by 2002:adf:a184:: with SMTP id u4mr14267967wru.69.1633352068873; 
 Mon, 04 Oct 2021 05:54:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR1n//yx6CzqTXWie2TmG1rUg1iRciMi3PoAWZVD+S5CXIb1364eMHGMi2sKgXCOykMJU3KQ==
X-Received: by 2002:adf:a184:: with SMTP id u4mr14267947wru.69.1633352068680; 
 Mon, 04 Oct 2021 05:54:28 -0700 (PDT)
Received: from redhat.com ([2.55.134.94])
 by smtp.gmail.com with ESMTPSA id p3sm7707340wmp.43.2021.10.04.05.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 05:54:28 -0700 (PDT)
Date: Mon, 4 Oct 2021 08:54:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004083455-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87ee912e45.fsf@redhat.com>
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

On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Sent too early. So here's what I propose. Could you pls take a look
> > and if you like this, post a ccw section?
> 
> We have not talked about the mmio transport so far, but I guess it
> should be fine as legacy and standard are separated.
> 
> > There's also an attempt to prevent fallback from modern to legacy
> > here since if driver does fallback then failing FEATURES_OK can't work
> > properly.
> > That's a separate issue, will be a separate patch when I post
> > this for consideration by the TC.
> >
> >
> > diff --git a/content.tex b/content.tex
> > index 1398390..06271f4 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -140,10 +140,13 @@ \subsection{Legacy Interface: A Note on Feature
> >  Bits}\label{sec:Basic Facilities of a Virtio Device / Feature
> >  Bits / Legacy Interface: A Note on Feature Bits}
> >  
> > -Transitional Drivers MUST detect Legacy Devices by detecting that
> > -the feature bit VIRTIO_F_VERSION_1 is not offered.
> > -Transitional devices MUST detect Legacy drivers by detecting that
> > -VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
> > +Transitional drivers MAY support operating legacy devices.
> > +Transitional devices MAY support operation by legacy drivers.
> 
> Why 'MAY'? Isn't the whole point of transitional that it can deal with
> both?

I guess. OK we can make it MUST.

> > +
> > +Transitional drivers MUST detect legacy devices in a way that is
> > +transport specific.
> > +Transitional devices MUST detect legacy drivers in a way that
> > +is transport specific.
> >  
> >  In this case device is used through the legacy interface.
> >  
> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
> >  Specification text within these sections generally does not apply
> >  to non-transitional devices.
> >  
> > +\begin{note}
> > +The device offers different features when used through
> > +the legacy interface and when operated in accordance with this
> > +specification.
> > +\end{note}
> > +
> > +Transitional drivers MUST use Devices only through the legacy interface
> 
> s/Devices only through the legacy interface/devices through the legacy
> interface only/
> 
> ?

Both versions are actually confused, since how do you
find out that device does not offer VIRTIO_F_VERSION_1?

I think what this should really say is

Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
the legacy interface.


Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
through the legacy interface if offered?

> > +if the feature bit VIRTIO_F_VERSION_1 is not offered.
> > +Transitional devices MUST NOT offer VIRTIO_F_VERSION_1 when used through
> > +the legacy interface.
> > +
> > +When the driver uses a device through the legacy interface, then it
> > +MUST only accept the features the device offered through the
> > +legacy interface.
> > +
> > +When used through the legacy interface, the device SHOULD
> > +validate that the driver only accepted the features it
> > +offered through the legacy interface.
> > +
> > +When operating a transitional device, a transitional driver
> > +SHOULD NOT use the device through the legacy interface if
> > +operation through the modern interface has failed.
> > +In particular, a transitional driver
> > +SHOULD NOT fall back to using the device through the
> > +legacy interface if feature negotiation failed
> > +(since that would defeat the purpose of the FEATURES_OK bit).
> > +
> >  \section{Notifications}\label{sec:Basic Facilities of a Virtio Device
> >  / Notifications}
> >  
> > @@ -1003,6 +1033,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >  
> >  The driver MUST NOT write a 0 to \field{queue_enable}.
> >  
> > +\paragraph}{Legacy Interface: Common configuration structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interface: Common configuration structure layout}
> > +Transitional drivers SHOULD detect legacy devices by detecting
> > +that the device has the Transitional PCI Device ID in
> > +the range 0x1000 to 0x103f and lacks a VIRTIO_PCI_CAP_COMMON_CFG
> > +capability specifying the location of a common configuration structure.
> > +
> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >  
> >  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > @@ -1288,6 +1324,10 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
> >  Transitional devices MUST present part of configuration
> >  registers in a legacy configuration structure in BAR0 in the first I/O
> >  region of the PCI device, as documented below.
> > +
> > +Transitional devices SHOULD detect legacy drivers by detecting
> > +access to the legacy configuration structure.
> > +
> >  When using the legacy interface, transitional drivers
> >  MUST use the legacy configuration structure in BAR0 in the first
> >  I/O region of the PCI device, as documented below.
> 
> Generally, looks good to me.

Do we want to also add explanation that features can be
changed until FEATURES_OK?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
