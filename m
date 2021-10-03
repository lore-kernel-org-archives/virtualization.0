Return-Path: <SRS0=b/cG=OX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA80C433F5
	for <virtualization@archiver.kernel.org>; Sun,  3 Oct 2021 07:26:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE55461B1F
	for <virtualization@archiver.kernel.org>; Sun,  3 Oct 2021 07:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE55461B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60ACD401C9;
	Sun,  3 Oct 2021 07:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3ouDVLlm_z5; Sun,  3 Oct 2021 07:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 650FB4019B;
	Sun,  3 Oct 2021 07:26:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39556C000F;
	Sun,  3 Oct 2021 07:26:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5BD0C000D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 07:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C0EC848C8
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 07:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13U_FkUw5dAy
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 07:26:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8055B84889
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 07:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633245977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hDTlj8yauGXn36BnLPk7YQFUogtZGxp6fGoAswuoG/g=;
 b=QidvNu62E4bNDHYqHM5YlrewFq6OervBRK7H4H9jrCcUUC04OtGnCPqLrryF7TjLfCQWS0
 F33Zl51FWOeF4j3FDxn/SMVVC+hsf2FptD0c5/5oPf2/dFT2rdlyoA9cYRDMuNmgCeaaag
 TXifiOjo3k5vgRXdkxbHANGpNILphSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-s8JM7tpdPiazf8aWnTgZxw-1; Sun, 03 Oct 2021 03:26:14 -0400
X-MC-Unique: s8JM7tpdPiazf8aWnTgZxw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5-20020a1c00050000b02902e67111d9f0so6876163wma.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Oct 2021 00:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hDTlj8yauGXn36BnLPk7YQFUogtZGxp6fGoAswuoG/g=;
 b=HtXEBuY+7RB4m+ZLpVsrKY7a/4gltjFBXZ9nqGhRSngG4OWB8Ro3LE9Pli98LXX+Wo
 GI0Rab3wejzQR800w6pn2lONxKtKf+d6BQgbEtjPghxAxHbUVtvo2pDYgf5/cLpSWPzp
 ZBGmRxIVqHrBruw957FvI/lBCl4IWwFdE5NsT+VizJwmRlxzLnFvU23LE1hIW354c7GI
 D7RCg3zrFWHl4Oz8VxcDXFM6SWJZqBC5F/K0UfrXDLpt+0PtkOvjxTBn3LEQSItqp2PU
 gH1M0T5u1W2SQ0ZzLd8Eb2TCfXTzBFM+IyVy1Dn2o+kV69vGE+jiaGBpO055MHOmZtnx
 MPLw==
X-Gm-Message-State: AOAM531lWqrEPnX8YswkOsqMoi7box4IvU8GR9KjJ9KQU96RD5ZUoICn
 bhcENGaBcSc1xTv7fYNlSJklmxIyPKNU+uet98VbzSDExUe8/e6FevP4lQpuwqJab3dwYl9TpBm
 0uVoN9i1oog1qhvnpVFnW2cN8VGyf+O1ctpchcBmhzA==
X-Received: by 2002:a5d:56cc:: with SMTP id m12mr7015396wrw.22.1633245973399; 
 Sun, 03 Oct 2021 00:26:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNAQtpj1eV275e1gGoSR2AJUhmX2Av/LkhXFA8TjxRNFl9fJFjPs+0pBxxeePuOYAE3C5EmA==
X-Received: by 2002:a5d:56cc:: with SMTP id m12mr7015373wrw.22.1633245973096; 
 Sun, 03 Oct 2021 00:26:13 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
 by smtp.gmail.com with ESMTPSA id b15sm4804079wrr.90.2021.10.03.00.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Oct 2021 00:26:11 -0700 (PDT)
Date: Sun, 3 Oct 2021 03:26:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211003032253-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211003021027-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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

On Sun, Oct 03, 2021 at 02:42:30AM -0400, Michael S. Tsirkin wrote:
> On Sun, Oct 03, 2021 at 07:00:30AM +0200, Halil Pasic wrote:
> > On Sat, 2 Oct 2021 14:20:47 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > > >From my perspective the problem is that the version of the device  
> > > > remains in limbo as long as the features have not yet been finalized,
> > > > which means that the endianness of the config space remains in limbo as
> > > > well. Both device and driver might come to different conclusions.  
> > > 
> > > Version === legacy versus modern?
> > > It is true that feature negotiation can not be used by device to decide that
> > > question simply because it happens too late.
> > > So let's not use it for that then ;)
> > > 
> > > Yes we have VERSION_1 which looks like it should allow this, but
> > > unfortunately it only helps with that for the driver, not the device.
> > > 
> > > In practice legacy versus modern has to be determined by
> > > transport specific versioning, luckily we have that for all
> > > specified transports (can't say what happens with rproc).
> > 
> > So if we look at ccw, you say that the revision negotiation already
> > determines whether VERSION_1 is negotiated or not, and the
> > feature bit VERSION_1 is superfluous?
> > 
> > That would also imply, that 
> > 1) if revision > 0 was negotiated then the device must offer VERSION_1
> > 2) if revision > 0 was negotiated and the driver cleared VERSION_1
> >    the device must refuse to operate.
> > 3) if revision > 0 was negotiated then the driver should reject 
> >    to drive a device if it does not offer VERSION_1
> > 4) if revision > 0 was negotiated the driver must accept VERSION_1
> > 5) if revision > 0 was *not* negotiated then the device should not offer
> >    VERSION_1 because at this point it is already certain that the device
> >    can not act in accordance to the virtio 1.0 or higher interface.
> > 
> > Does that sound about right?
> 
> To me, it does.
> 
> > IMHO we should also change 
> > https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-160003
> > and the definition of VERSION_1 because both sides have to know what is
> > going on before features are fully negotiated. Or?
> > 
> > Regards,
> > Halil
> > 
> 
> I guess so. And I guess we need transport-specific sections
> describing this behaviour for each transport.
> 
> So something like this, for starters?

Sent too early. So here's what I propose. Could you pls take a look
and if you like this, post a ccw section?
There's also an attempt to prevent fallback from modern to legacy
here since if driver does fallback then failing FEATURES_OK can't work
properly.
That's a separate issue, will be a separate patch when I post
this for consideration by the TC.


diff --git a/content.tex b/content.tex
index 1398390..06271f4 100644
--- a/content.tex
+++ b/content.tex
@@ -140,10 +140,13 @@ \subsection{Legacy Interface: A Note on Feature
 Bits}\label{sec:Basic Facilities of a Virtio Device / Feature
 Bits / Legacy Interface: A Note on Feature Bits}
 
-Transitional Drivers MUST detect Legacy Devices by detecting that
-the feature bit VIRTIO_F_VERSION_1 is not offered.
-Transitional devices MUST detect Legacy drivers by detecting that
-VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
+Transitional drivers MAY support operating legacy devices.
+Transitional devices MAY support operation by legacy drivers.
+
+Transitional drivers MUST detect legacy devices in a way that is
+transport specific.
+Transitional devices MUST detect legacy drivers in a way that
+is transport specific.
 
 In this case device is used through the legacy interface.
 
@@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
 Specification text within these sections generally does not apply
 to non-transitional devices.
 
+\begin{note}
+The device offers different features when used through
+the legacy interface and when operated in accordance with this
+specification.
+\end{note}
+
+Transitional drivers MUST use Devices only through the legacy interface
+if the feature bit VIRTIO_F_VERSION_1 is not offered.
+Transitional devices MUST NOT offer VIRTIO_F_VERSION_1 when used through
+the legacy interface.
+
+When the driver uses a device through the legacy interface, then it
+MUST only accept the features the device offered through the
+legacy interface.
+
+When used through the legacy interface, the device SHOULD
+validate that the driver only accepted the features it
+offered through the legacy interface.
+
+When operating a transitional device, a transitional driver
+SHOULD NOT use the device through the legacy interface if
+operation through the modern interface has failed.
+In particular, a transitional driver
+SHOULD NOT fall back to using the device through the
+legacy interface if feature negotiation failed
+(since that would defeat the purpose of the FEATURES_OK bit).
+
 \section{Notifications}\label{sec:Basic Facilities of a Virtio Device
 / Notifications}
 
@@ -1003,6 +1033,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 The driver MUST NOT write a 0 to \field{queue_enable}.
 
+\paragraph}{Legacy Interface: Common configuration structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interface: Common configuration structure layout}
+Transitional drivers SHOULD detect legacy devices by detecting
+that the device has the Transitional PCI Device ID in
+the range 0x1000 to 0x103f and lacks a VIRTIO_PCI_CAP_COMMON_CFG
+capability specifying the location of a common configuration structure.
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
@@ -1288,6 +1324,10 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 Transitional devices MUST present part of configuration
 registers in a legacy configuration structure in BAR0 in the first I/O
 region of the PCI device, as documented below.
+
+Transitional devices SHOULD detect legacy drivers by detecting
+access to the legacy configuration structure.
+
 When using the legacy interface, transitional drivers
 MUST use the legacy configuration structure in BAR0 in the first
 I/O region of the PCI device, as documented below.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
