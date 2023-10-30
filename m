Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB5FC4332F
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 23:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EF8E405CA;
	Mon, 30 Oct 2023 23:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EF8E405CA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KhJs7jiE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cq2qUJ4SiEbO; Mon, 30 Oct 2023 23:31:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23565402D0;
	Mon, 30 Oct 2023 23:31:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23565402D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDAB3C0071;
	Mon, 30 Oct 2023 23:31:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CC13C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 23:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 780C941D6F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 23:31:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 780C941D6F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KhJs7jiE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KJeh-FOpH0WS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 23:31:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0EBA41C51
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 23:31:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0EBA41C51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698708705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hr5b+/tamFpp9Nju6BJVO0BdbMTX3Xt5jeifbWo4b6E=;
 b=KhJs7jiEXX8QmRb1lx4Chews4bxihleCgOth+ni+s0letAgaybMezFb0adgzc+hQIkHr4V
 LaKPKvDIxar6fcCkiysKUCiN55z1mr1fJYu/VneAfKtMhal64gcQakAECPMOK1Ly8/5iP8
 vVXn0JJSzvEG8ZwyYRMlQM+3NvHJ1k0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-iUHkspKcPqCN-HRuVhtMFw-1; Mon, 30 Oct 2023 19:31:44 -0400
X-MC-Unique: iUHkspKcPqCN-HRuVhtMFw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40837aa4a58so33523085e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 16:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698708703; x=1699313503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hr5b+/tamFpp9Nju6BJVO0BdbMTX3Xt5jeifbWo4b6E=;
 b=XcvGVjEMkPQVjTl+ME+Z1PgreYReSbq/h3ls6XfQ4XXfDjf1utKAsraUVR8LKHis8G
 +4LC4K2W1eTV0rhn0Dz5d2aXd2pYNAw1r5MTCi0ItwmLptYb2sZS6echsB6NKB57/XOH
 Lr2T5khm9+WXwkLLtARJgRtjQiODVSJlPQY9VG+EAT7L9zaD+LmkutJmX+nP5rhvB8Yq
 kSM0RTkGn1t2HgufdLvoHsVkVMy1nGxxQ2P5JguOAH7syacxcjl504j+b2AuPCkjBHWP
 SNuBZy5DKz2UxsdEreh2the2XmoHNSHGEFr4WMWcIe/JpRIBmjUnzGxaAfmdTgR+HcvB
 9yCw==
X-Gm-Message-State: AOJu0YwZ7Iqt/Rc93Sdx3ixbDlN+eb4pDpH6nMitx+omAsuqwbvO9ons
 0kyhwgyxyxRTOnDcGHG2+vWpLVjvRl4NYTVO4SMvU3WLhPYj6pKi+FmiXS6KOKxDX7fHu2Ozoje
 LY9sWWkelXdcVhSjMjRRjuABfT428C/ae1ovYMzrMjg==
X-Received: by 2002:a05:600c:5408:b0:405:358c:ba74 with SMTP id
 he8-20020a05600c540800b00405358cba74mr1087261wmb.0.1698708703269; 
 Mon, 30 Oct 2023 16:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEB5LIBlkQ+jVd4pnrhNDIucdhp/bRgd7Y4NOKOvq4dvjKk9iXv7t9mM2QJArjIcoshhuYjQ==
X-Received: by 2002:a05:600c:5408:b0:405:358c:ba74 with SMTP id
 he8-20020a05600c540800b00405358cba74mr1087239wmb.0.1698708702926; 
 Mon, 30 Oct 2023 16:31:42 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b0040775fd5bf9sm156640wmd.0.2023.10.30.16.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 16:31:42 -0700 (PDT)
Date: Mon, 30 Oct 2023 19:31:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V2 vfio 2/9] virtio-pci: Introduce admin virtqueue
Message-ID: <20231030193110-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-3-yishaih@nvidia.com>
 <20231029161909-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E45C628DE3A5829D438DCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231030115759-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548197CD7A10D5A89B7213CDDCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548197CD7A10D5A89B7213CDDCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

On Mon, Oct 30, 2023 at 06:10:06PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, October 30, 2023 9:29 PM
> > On Mon, Oct 30, 2023 at 03:51:40PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, October 30, 2023 1:53 AM
> > > >
> > > > On Sun, Oct 29, 2023 at 05:59:45PM +0200, Yishai Hadas wrote:
> > > > > From: Feng Liu <feliu@nvidia.com>
> > > > >
> > > > > Introduce support for the admin virtqueue. By negotiating
> > > > > VIRTIO_F_ADMIN_VQ feature, driver detects capability and creates
> > > > > one administration virtqueue. Administration virtqueue
> > > > > implementation in virtio pci generic layer, enables multiple types
> > > > > of upper layer drivers such as vfio, net, blk to utilize it.
> > > > >
> > > > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > > > ---
> > > > >  drivers/virtio/virtio.c                | 37 ++++++++++++++--
> > > > >  drivers/virtio/virtio_pci_common.c     |  3 ++
> > > > >  drivers/virtio/virtio_pci_common.h     | 15 ++++++-
> > > > >  drivers/virtio/virtio_pci_modern.c     | 61 +++++++++++++++++++++++++-
> > > > >  drivers/virtio/virtio_pci_modern_dev.c | 18 ++++++++
> > > > >  include/linux/virtio_config.h          |  4 ++
> > > > >  include/linux/virtio_pci_modern.h      |  5 +++
> > > > >  7 files changed, 137 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > index
> > > > > 3893dc29eb26..f4080692b351 100644
> > > > > --- a/drivers/virtio/virtio.c
> > > > > +++ b/drivers/virtio/virtio.c
> > > > > @@ -302,9 +302,15 @@ static int virtio_dev_probe(struct device *_d)
> > > > >  	if (err)
> > > > >  		goto err;
> > > > >
> > > > > +	if (dev->config->create_avq) {
> > > > > +		err = dev->config->create_avq(dev);
> > > > > +		if (err)
> > > > > +			goto err;
> > > > > +	}
> > > > > +
> > > > >  	err = drv->probe(dev);
> > > > >  	if (err)
> > > > > -		goto err;
> > > > > +		goto err_probe;
> > > > >
> > > > >  	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
> > > > >  	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > > >
> > > > Hmm I am not all that happy that we are just creating avq unconditionally.
> > > > Can't we do it on demand to avoid wasting resources if no one uses it?
> > > >
> > > Virtio queues must be enabled before driver_ok as we discussed in
> > F_DYNAMIC bit exercise.
> > > So creating AQ when first legacy command is invoked, would be too late.
> > 
> > Well we didn't release the spec with AQ so I am pretty sure there are no devices
> > using the feature. Do we want to already make an exception for AQ and allow
> > creating AQs after DRIVER_OK even without F_DYNAMIC?
> > 
> No. it would abuse the init time config registers for the dynamic things like this.
> For flow filters and others there is need for dynamic q creation with multiple physical address anyway.

That seems like a completely unrelated issue.

> So creating virtqueues dynamically using a generic scheme is desired with new feature bit.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
