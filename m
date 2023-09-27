Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43096CE7A84
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 21:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A96F340123;
	Wed, 27 Sep 2023 21:25:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A96F340123
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EYUSoADq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wcMqHA5Ckge5; Wed, 27 Sep 2023 21:25:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ECA3F40488;
	Wed, 27 Sep 2023 21:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ECA3F40488
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B81A6C0071;
	Wed, 27 Sep 2023 21:25:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB26C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E983683412
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:25:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E983683412
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EYUSoADq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PiXVKi5GNZXl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:25:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4590833CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:25:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4590833CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695849905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmntjQFEBP4zxkSKza823gqYagc7cqE2Mw3qK1poHGA=;
 b=EYUSoADqjfs6Do1kcNdeuMa/cUjWYKYc6hPJXMxJIJi1GN++iIBNTQ4go/b+AoXTNGsQZs
 xHuq33UgmXVWkUErlyT+iHZOzFXEchZtFO8f22WmoUF/RY4V0J2LUlXv7QKcwIV+bTsLb2
 QGoEbYqOaaCGZdDKZxnHXvF20YND2+M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-KCMfeNimMHaui4bIVJX1UA-1; Wed, 27 Sep 2023 17:25:03 -0400
X-MC-Unique: KCMfeNimMHaui4bIVJX1UA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-402cd372b8bso116058265e9.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 14:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695849902; x=1696454702;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VmntjQFEBP4zxkSKza823gqYagc7cqE2Mw3qK1poHGA=;
 b=Vs6ixnrEtYsqjSqQteTWT1Vf/F5ntinlxwr5HTredCmrD4EZX3aJmbJuhxDOJOGRlv
 LzqC/JxZyZmFCPPz1Wq7DpRltoM5/DLbTaLEQDpRGv1JzV1uuJUVMl1Ci5eFnvfD3nWL
 l/vwJzOUg5IYSD6Eg1qKbI6Q+8QQt5Saqu7VcdMS8SUPisvPkbtRECE2vUQEYYnvGwiU
 vpG2zANhkTHQQqA4RjJ5AS8LmFu+azRRJ+A/I6XsgB16hTAaKts9hykJ5ESQECoSMY67
 /+wTP/Q/y0NSrZBRT7lE5gFTp3JBKkc2tiZWFVWzSBE7PYoSiRug0qKgqm9K8Xc4keim
 upFA==
X-Gm-Message-State: AOJu0YzaAAqqbBc706FyBRs/PEC5a2Tw/05kRRa1wRAg6Uwh0SMPHwwf
 72DDjR+tJzU3jAaB506XlV1pyH5NVqSYTkbFUOe7PXCIK6UckgqCkwfIMpHWOfxdiEdmaAqFUNm
 aSyOzO+1xUaDoUt2TJ8mFB8P4595WkOD5fltks+x2HQ==
X-Received: by 2002:a7b:c4cb:0:b0:405:40c6:2b96 with SMTP id
 g11-20020a7bc4cb000000b0040540c62b96mr3252751wmk.3.1695849902522; 
 Wed, 27 Sep 2023 14:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoSKe8qGtIAhaENH1IBp/4qm/cttWihUV2n1Xw4IXG2ADxskYunHMDBRVoizr7wIOq+D70bQ==
X-Received: by 2002:a7b:c4cb:0:b0:405:40c6:2b96 with SMTP id
 g11-20020a7bc4cb000000b0040540c62b96mr3252738wmk.3.1695849902136; 
 Wed, 27 Sep 2023 14:25:02 -0700 (PDT)
Received: from redhat.com ([2.52.19.249]) by smtp.gmail.com with ESMTPSA id
 f2-20020a7bc8c2000000b003fefaf299b6sm7026620wml.38.2023.09.27.14.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 14:25:01 -0700 (PDT)
Date: Wed, 27 Sep 2023 17:24:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH vfio 01/11] virtio-pci: Use virtio pci device layer vq
 info instead of generic one
Message-ID: <20230927171859-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-2-yishaih@nvidia.com>
 <20230921093540-mutt-send-email-mst@kernel.org>
 <6eb92b47-cefe-8b00-d3d2-f15ce4aa9959@nvidia.com>
 <39d8a0a5-4365-4ced-cac1-bef2bc8d6367@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <39d8a0a5-4365-4ced-cac1-bef2bc8d6367@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, leonro@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 maorg@nvidia.com
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

On Wed, Sep 27, 2023 at 02:09:43PM -0400, Feng Liu wrote:
> =

> =

> On 2023-09-26 p.m.3:13, Feng Liu via Virtualization wrote:
> > External email: Use caution opening links or attachments
> > =

> > =

> > On 2023-09-21 a.m.9:46, Michael S. Tsirkin wrote:
> > > External email: Use caution opening links or attachments
> > > =

> > > =

> > > On Thu, Sep 21, 2023 at 03:40:30PM +0300, Yishai Hadas wrote:
> > > > From: Feng Liu <feliu@nvidia.com>
> > > > =

> =

> > > > pci_irq_vector(vp_dev->pci_dev, v);
> > > > @@ -294,6 +298,7 @@ static int vp_find_vqs_msix(struct
> > > > virtio_device *vdev, unsigned int nvqs,
> > > > =A0=A0=A0=A0=A0=A0 vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vq=
s), GFP_KERNEL);
> > > > =A0=A0=A0=A0=A0=A0 if (!vp_dev->vqs)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
> > > > +=A0=A0=A0=A0 vp_dev->nvqs =3D nvqs;
> > > > =

> > > > =A0=A0=A0=A0=A0=A0 if (per_vq_vectors) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Best option: one for =
change interrupt, one per vq. */
> > > > @@ -365,6 +370,7 @@ static int vp_find_vqs_intx(struct
> > > > virtio_device *vdev, unsigned int nvqs,
> > > > =A0=A0=A0=A0=A0=A0 vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vq=
s), GFP_KERNEL);
> > > > =A0=A0=A0=A0=A0=A0 if (!vp_dev->vqs)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
> > > > +=A0=A0=A0=A0 vp_dev->nvqs =3D nvqs;
> > > > =

> > > > =A0=A0=A0=A0=A0=A0 err =3D request_irq(vp_dev->pci_dev->irq, vp_int=
errupt,
> > > > IRQF_SHARED,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
dev_name(&vdev->dev), vp_dev);
> > > > diff --git a/drivers/virtio/virtio_pci_common.h
> > > > b/drivers/virtio/virtio_pci_common.h
> > > > index 4b773bd7c58c..602021967aaa 100644
> > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > @@ -60,6 +60,7 @@ struct virtio_pci_device {
> > > > =

> > > > =A0=A0=A0=A0=A0=A0 /* array of all queues for house-keeping */
> > > > =A0=A0=A0=A0=A0=A0 struct virtio_pci_vq_info **vqs;
> > > > +=A0=A0=A0=A0 u32 nvqs;
> > > =

> > > I don't much like it that we are adding more duplicated info here.
> > > In fact, we tried removing the vqs array in
> > > 5c34d002dcc7a6dd665a19d098b4f4cd5501ba1a - there was some bug in that
> > > patch and the author didn't have the time to debug
> > > so I reverted but I don't really think we need to add to that.
> > > =

> > =

> > Hi Michael
> > =

> > As explained in commit message, this patch is mainly to prepare for the
> > subsequent admin vq patches.
> > =

> > The admin vq is also established using the common mechanism of vring,
> > and is added to vdev->vqs in __vring_new_virtqueue(). So vdev->vqs
> > contains all virtqueues, including rxq, txq, ctrlvq and admin vq.
> > =

> > admin vq should be managed by the virito_pci layer and should not be
> > created or deleted by upper driver (net, blk);
> > When the upper driver was unloaded, it will call del_vqs() interface,
> > which wll call vp_del_vqs(), and vp_del_vqs() should not delete the
> > admin vq, but only delete the virtqueues created by the upper driver
> > such as rxq, txq, and ctrlq.
> > =

> > =

> > vp_dev->vqs[] array only contains virtqueues created by upper driver
> > such as rxq, txq, ctrlq. Traversing vp_dev->vqs array can only delete
> > the upper virtqueues, without the admin vq. Use the vdev->vqs linked
> > list cannot meet the needs.
> > =

> > =

> > Can such an explanation be explained clearly? Or do you have any other
> > alternative methods?
> > =

> =

> Hi, Michael
> 	Is the above explanations OK to you?
> =

> Thanks
> Feng

First, the patch only addresses pci. Second, yes driver unload calls
del_vqs but doesn't it also reset the device? If this happens while
vfio tries to send commands to it then you have other problems.
And, for the baroque need of admin vq which
most devices don't have you are duplicating logic and wasting memory for
everyone.

What is a sane solution? virtio core was never designed to
allow two drivers accessing the same device. So don't try, add the logic
of device access in virtio core.  I feel the problem won't even exist if
instead of just exposing the device pointer you expose a sane interface.


> > > > =

> > > > =A0=A0=A0=A0=A0=A0 /* MSI-X support */
> > > > =A0=A0=A0=A0=A0=A0 int msix_enabled;
> > > > -- =

> > > > 2.27.0
> > > =

> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
