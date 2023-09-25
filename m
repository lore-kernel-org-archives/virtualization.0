Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C512CE7AAF
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 17:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B22D818E6;
	Mon, 25 Sep 2023 17:36:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B22D818E6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gKlkiFaF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1W-djSDxoVwS; Mon, 25 Sep 2023 17:36:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 69C3981F61;
	Mon, 25 Sep 2023 17:36:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69C3981F61
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35835C0039;
	Mon, 25 Sep 2023 17:36:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E419C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72B4A611F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72B4A611F2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gKlkiFaF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZo9nSQqAOz6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:36:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 858A16118F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 858A16118F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695663376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zjs4lEvHaDiAhNxtP1F5A4HCNq/ZOZBqE/yPfKd9nJ0=;
 b=gKlkiFaFzw5X0O+/iuY3B3ET7iV6ujjj/wOyQoiHpxhgkTJwI1jW8PkzFgPopnNA5pzUew
 gjPkFswyFPHF/Ov058UHDKsFbLO/LeKy4nF7XU+FeQWgqCVRtLU8o3gGXr4DcMNZC1Km/T
 WTrEgMsYLDZIo6bU6budkxwnYgiN9h8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-VwOhugUzPGW24LdBFJTHog-1; Mon, 25 Sep 2023 13:36:15 -0400
X-MC-Unique: VwOhugUzPGW24LdBFJTHog-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7740517a478so1263300385a.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 10:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695663374; x=1696268174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjs4lEvHaDiAhNxtP1F5A4HCNq/ZOZBqE/yPfKd9nJ0=;
 b=IoHhJELMkEOI2Xy7KtoFeGvpFoVjRq+8j+C0O1Ufnvs+eS59xPasxK60D5lsOp+64b
 Gl70cs94b8pTge5M05vEMOLoOYeHTq8LIKTPdRWjR4pNUWyDrExJmO3MANDb2faz6/1f
 LhAQE8qYT8NkLOiil5apSaDB0ut5x37KiQ59zP7iE/7c6GNQK7yxdtBcSsqm1tEEu73I
 +VbNJMF141jSj7BeY6uc4FRmuRwYQTyY+HRSd8hPfmFF6DvFu/S/ikkswjfiuLtbT7PA
 vz4u519Ct0Jue4wWn7gacuH+4O++pqesHelP8t8TowZhghNuiiFIrk+u0Q3FBij6M9xX
 6Kfw==
X-Gm-Message-State: AOJu0YxYBc/iVqOlSo4h9qoDEv49NmwWdAbvaHMfb4oHHb2fy2SUEPGU
 y6M2hC2ZG/zlmNwufXuhOacmjBIrZe/eN1pEv/+WtwSmGMlNX79Ct+DtQ/Mb4sDHsavWR7PWa2I
 8xpDEbvh7vPDgw0TbeyDtMAAGwSUyIyWFJUaJioTp5w==
X-Received: by 2002:a05:620a:4105:b0:774:244c:8b2c with SMTP id
 j5-20020a05620a410500b00774244c8b2cmr7602754qko.14.1695663374566; 
 Mon, 25 Sep 2023 10:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmpiRCu+wzFPOCrZC1PqOEIb9d+Hn3KxIh66IaQJaLnetrbMNgTOFvL9gDfrNhGFU6c7tCrA==
X-Received: by 2002:a05:620a:4105:b0:774:244c:8b2c with SMTP id
 j5-20020a05620a410500b00774244c8b2cmr7602741qko.14.1695663374271; 
 Mon, 25 Sep 2023 10:36:14 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 i15-20020a05620a144f00b00772662b77fesm1268315qkl.99.2023.09.25.10.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:36:13 -0700 (PDT)
Date: Mon, 25 Sep 2023 13:36:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230925060510-mutt-send-email-mst@kernel.org>
References: <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230922111132-mutt-send-email-mst@kernel.org>
 <20230922151534.GR13733@nvidia.com>
 <20230922113941-mutt-send-email-mst@kernel.org>
 <20230922162233.GT13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230922162233.GT13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jiri Pirko <jiri@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
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

On Fri, Sep 22, 2023 at 01:22:33PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 11:40:58AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 22, 2023 at 12:15:34PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Sep 22, 2023 at 11:13:18AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Sep 22, 2023 at 12:25:06PM +0000, Parav Pandit wrote:
> > > > > 
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Friday, September 22, 2023 5:53 PM
> > > > > 
> > > > > 
> > > > > > > And what's more, using MMIO BAR0 then it can work for legacy.
> > > > > > 
> > > > > > Oh? How? Our team didn't think so.
> > > > > 
> > > > > It does not. It was already discussed.
> > > > > The device reset in legacy is not synchronous.
> > > > > The drivers do not wait for reset to complete; it was written for the sw backend.
> > > > > Hence MMIO BAR0 is not the best option in real implementations.
> > > > 
> > > > Or maybe they made it synchronous in hardware, that's all.
> > > > After all same is true for the IO BAR0 e.g. for the PF: IO writes
> > > > are posted anyway.
> > > 
> > > IO writes are not posted in PCI.
> > 
> > Aha, I was confused. Thanks for the correction. I guess you just buffer
> > subsequent transactions while reset is going on and reset quickly enough
> > for it to be seemless then?
> 
> >From a hardware perspective the CPU issues an non-posted IO write and
> then it stops processing until the far side returns an IO completion.
> 
> Using that you can emulate what the SW virtio model did and delay the
> CPU from restarting until the reset is completed.
> 
> Since MMIO is always posted, this is not possible to emulate directly
> using MMIO.
> 
> Converting IO into non-posted admin commands is a fairly close
> recreation to what actual HW would do.
> 
> Jason

I thought you asked how it is possible for hardware to support reset if
all it does is replace IO BAR with memory BAR. The answer is that since
2011 the reset is followed by read of the status field (which isn't much
older than MSIX support from 2009 - which this code assumes).  If one
uses a Linux driver from 2011 and on then all you need to do is defer
response to this read until after the reset is complete.

If you are using older drivers or other OSes then reset using a posted
write after device has operated for a while might not be safe, so e.g.
you might trigger races if you remove drivers from system or
trigger hot unplug.  For example: 

	static void virtio_pci_remove(struct pci_dev *pci_dev)
	{

	....

		unregister_virtio_device(&vp_dev->vdev);

	^^^^ triggers reset, then releases memory

	....

		pci_disable_device(pci_dev);

	^^^ blocks DMA by clearing bus master

	}

here you could see some DMA into memory that has just been released.


As Jason mentions hardware exists that is used under one of these two
restrictions on the guest (Linux since 2011 or no resets while DMA is
going on), and it works fine with these existing guests.

Given the restrictions, virtio TC didn't elect to standardize this
approach and instead opted for the heavier approach of
converting IO into non-posted admin commands in software.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
