Return-Path: <SRS0=b/cG=OX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A576C433EF
	for <virtualization@archiver.kernel.org>; Sun,  3 Oct 2021 06:42:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA3161A78
	for <virtualization@archiver.kernel.org>; Sun,  3 Oct 2021 06:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAA3161A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6469B848C6;
	Sun,  3 Oct 2021 06:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pO8fabzc4YGj; Sun,  3 Oct 2021 06:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB32E84811;
	Sun,  3 Oct 2021 06:42:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BADC7C0011;
	Sun,  3 Oct 2021 06:42:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6656C000D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 06:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C18FD40554
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 06:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id alUQVgNNKi1z
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 06:42:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 295A0401C9
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633243355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r+Bl1u326f9yQhaXb6udjEGQWjjecevglQG5IV4fpCo=;
 b=OuOsRsHLL7bZ0bsmEzWFShcuQgp6KPWwuY6yV6r7pp3mmzdoS+p9ExJWDDwX1cseHyIZSc
 xXgzz0wVYUxjduV9MMlR81n6agX5g9+eLqevQn5d5mTIcCfcKN6mSvuc5zWb2t4PEGUY6R
 AyQtV2tQJzN3xncyjaUJ+QM/RJPySOU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-qRq-gGQsOz-G3vkYAY10ww-1; Sun, 03 Oct 2021 02:42:31 -0400
X-MC-Unique: qRq-gGQsOz-G3vkYAY10ww-1
Received: by mail-ed1-f69.google.com with SMTP id
 n19-20020a509353000000b003dad185759bso6213225eda.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 02 Oct 2021 23:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r+Bl1u326f9yQhaXb6udjEGQWjjecevglQG5IV4fpCo=;
 b=Lr8GKW1TecKPHrzfLoTlY3vr7wG138yOXf7FJBWcSz7M03ocZTUNlRKHik/iMOYgy+
 YGgdIencBMjbqEVA1r2sTsyUYz5ds06/EmslcDYuIdQtOH+OZYUtYbjbKGZvieCo+Kg6
 sgkkfJ83DTTQWiPn/yoSLrWNjtRIXowd9mFemWMYGbomSfj8CfgAuge+x7/nFb35u/IW
 gkBL8cjZLSlZTqceyE8HC6pLOS0AvIJIMLQ9rrZDaXAMQ3p56io7uEoZi0ZIlyVZ70ZL
 jQ97gDWoN6qisCm1CP5YMX9QIF7ykspBFnSLmYnpQjcJsxtFkqEWL+9LyaxWrYScsyuW
 YqkA==
X-Gm-Message-State: AOAM533yylUokliO+aH8xr39G9rD82isAwoqRRDrEmUvpSfmGUgMgeJT
 yhV6U9RwTj6ua57/x0xyN0sFSHpSTzTo3C0cAPxnWYrrMHy3M/ZVGtvPowuFTiI/LyBpnRZotYO
 WE7viuAXNrLlYnnORxEPjoWVZT5PPNFU3f4IF8w0DRw==
X-Received: by 2002:a17:907:2d0d:: with SMTP id
 gs13mr8578182ejc.94.1633243350453; 
 Sat, 02 Oct 2021 23:42:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtHT8Cegow6Zx3CCdmEJQH1USoUtFEpuumSAmNgt5hz1mJRyfrkZWULFFV8XgcH+xyZ4AWZQ==
X-Received: by 2002:a17:907:2d0d:: with SMTP id
 gs13mr8578148ejc.94.1633243350156; 
 Sat, 02 Oct 2021 23:42:30 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
 by smtp.gmail.com with ESMTPSA id h10sm5564701edf.85.2021.10.02.23.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 23:42:29 -0700 (PDT)
Date: Sun, 3 Oct 2021 02:42:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211003021027-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211003070030.658fc94e.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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

On Sun, Oct 03, 2021 at 07:00:30AM +0200, Halil Pasic wrote:
> On Sat, 2 Oct 2021 14:20:47 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > >From my perspective the problem is that the version of the device  
> > > remains in limbo as long as the features have not yet been finalized,
> > > which means that the endianness of the config space remains in limbo as
> > > well. Both device and driver might come to different conclusions.  
> > 
> > Version === legacy versus modern?
> > It is true that feature negotiation can not be used by device to decide that
> > question simply because it happens too late.
> > So let's not use it for that then ;)
> > 
> > Yes we have VERSION_1 which looks like it should allow this, but
> > unfortunately it only helps with that for the driver, not the device.
> > 
> > In practice legacy versus modern has to be determined by
> > transport specific versioning, luckily we have that for all
> > specified transports (can't say what happens with rproc).
> 
> So if we look at ccw, you say that the revision negotiation already
> determines whether VERSION_1 is negotiated or not, and the
> feature bit VERSION_1 is superfluous?
> 
> That would also imply, that 
> 1) if revision > 0 was negotiated then the device must offer VERSION_1
> 2) if revision > 0 was negotiated and the driver cleared VERSION_1
>    the device must refuse to operate.
> 3) if revision > 0 was negotiated then the driver should reject 
>    to drive a device if it does not offer VERSION_1
> 4) if revision > 0 was negotiated the driver must accept VERSION_1
> 5) if revision > 0 was *not* negotiated then the device should not offer
>    VERSION_1 because at this point it is already certain that the device
>    can not act in accordance to the virtio 1.0 or higher interface.
> 
> Does that sound about right?

To me, it does.

> IMHO we should also change 
> https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-160003
> and the definition of VERSION_1 because both sides have to know what is
> going on before features are fully negotiated. Or?
> 
> Regards,
> Halil
> 

I guess so. And I guess we need transport-specific sections
describing this behaviour for each transport.

So something like this, for starters?

diff --git a/content.tex b/content.tex
index 1398390..c526dd3 100644
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
 
@@ -160,6 +163,25 @@ \subsection{Legacy Interface: A Note on Feature
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
 \section{Notifications}\label{sec:Basic Facilities of a Virtio Device
 / Notifications}
 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
