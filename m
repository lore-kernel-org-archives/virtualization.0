Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C2CC4332F
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 07:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A158282C1E;
	Tue, 31 Oct 2023 07:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A158282C1E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B1qjl7D/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TmBetmlD0b3w; Tue, 31 Oct 2023 07:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E42B78289B;
	Tue, 31 Oct 2023 07:59:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E42B78289B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4614C0039;
	Tue, 31 Oct 2023 07:59:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8669C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 07:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 955DF4215A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 07:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 955DF4215A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B1qjl7D/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZvVXXBfI7alQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 07:59:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AA384203E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 07:59:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AA384203E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698739153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hektqJYfBndJTIRB26QhmhfhD5dNFm+lfqbRs0QDUyk=;
 b=B1qjl7D/QNp6NGHOPSCZAS/p4Yxjv5kS/hxF1rM1jSaHa9axyexfk4t3u1hy1Z3S65UItr
 QnINIkDK0vOdT32ITIZRRHuMbRbgbWlY1fM9eaflZhsCTurFhHHkLdkbcuho6kDeoo+rIp
 p2SPDNw4mXbMM08e//tu8M24ycbI7mQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-VLSwEJNLO0mTs8TcfnG8QA-1; Tue, 31 Oct 2023 03:59:10 -0400
X-MC-Unique: VLSwEJNLO0mTs8TcfnG8QA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d9cd6eb0bso2889454f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 00:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698739149; x=1699343949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hektqJYfBndJTIRB26QhmhfhD5dNFm+lfqbRs0QDUyk=;
 b=n4Xz1TV2jjBvUB2zOrt6x65bcKpmwKSepy9AklToShe7i8+QyeOjINYwYHH4Y+EVho
 7K7ouufVdclWegMTJ91xuXpeajZrJbtElpzlALTBOA+XxiWN5kTpUPBOdeZS7iBX4e2P
 tspDFKFKbaMUjs4Df9oH39HufwDYndDe4wkGoWy1tx4gwnt/Qq+rm2l9E8HrWrFRecvf
 Yojz+RNp3zLZTuun0j+t1nJIm+7Ahiloqu9ttqd5Wow2JmzoRy0BQsVvNMyeuV7iA/JD
 QsRD43PjrlxselJb4XI2SHLATg8DYrBVtzSEiY7799cGJyk68c7bTp6QJgVH3oFCZcZr
 eKnA==
X-Gm-Message-State: AOJu0YxUNAy8iX+7Ab7dJfX2iw9kmwuuDLJQYGpg8tqjZ2oDX5okmo0P
 Qfoa4xl7aFNgbI7KRwcjNeErgje2NrH0FsfhPN8S7+e3BAIoor302rGTp1eW653CptGEBuTVXqo
 XgHZJ0b9KDfEmLVfjPnKd0Agq7lUjFe2dPrR6DMTgXQ==
X-Received: by 2002:a05:6000:178e:b0:32f:8d4a:efa8 with SMTP id
 e14-20020a056000178e00b0032f8d4aefa8mr3007244wrg.23.1698739148851; 
 Tue, 31 Oct 2023 00:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElvP//AsawVxFiLZYbzjtueiSw9evjqF6N1p48fpjYeLUE2NWHwk7hrkP+j+8sU1dzNErG2g==
X-Received: by 2002:a05:6000:178e:b0:32f:8d4a:efa8 with SMTP id
 e14-20020a056000178e00b0032f8d4aefa8mr3007225wrg.23.1698739148545; 
 Tue, 31 Oct 2023 00:59:08 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 i4-20020a5d4384000000b00326f0ca3566sm855421wrq.50.2023.10.31.00.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 00:59:08 -0700 (PDT)
Date: Tue, 31 Oct 2023 03:59:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V2 vfio 2/9] virtio-pci: Introduce admin virtqueue
Message-ID: <20231031034833-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-3-yishaih@nvidia.com>
 <20231029161909-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E45C628DE3A5829D438DCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231030115759-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548197CD7A10D5A89B7213CDDCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231030193110-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F2851BF40C5BBD59909CDCA0A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481F2851BF40C5BBD59909CDCA0A@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Tue, Oct 31, 2023 at 03:11:57AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, October 31, 2023 5:02 AM
> > 
> > On Mon, Oct 30, 2023 at 06:10:06PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, October 30, 2023 9:29 PM On Mon, Oct 30, 2023 at
> > > > 03:51:40PM +0000, Parav Pandit wrote:
> > > > >
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Monday, October 30, 2023 1:53 AM
> > > > > >
> > > > > > On Sun, Oct 29, 2023 at 05:59:45PM +0200, Yishai Hadas wrote:
> > > > > > > From: Feng Liu <feliu@nvidia.com>
> > > > > > >
> > > > > > > Introduce support for the admin virtqueue. By negotiating
> > > > > > > VIRTIO_F_ADMIN_VQ feature, driver detects capability and
> > > > > > > creates one administration virtqueue. Administration virtqueue
> > > > > > > implementation in virtio pci generic layer, enables multiple
> > > > > > > types of upper layer drivers such as vfio, net, blk to utilize it.
> > > > > > >
> > > > > > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > > > > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > > > > > ---
> > > > > > >  drivers/virtio/virtio.c                | 37 ++++++++++++++--
> > > > > > >  drivers/virtio/virtio_pci_common.c     |  3 ++
> > > > > > >  drivers/virtio/virtio_pci_common.h     | 15 ++++++-
> > > > > > >  drivers/virtio/virtio_pci_modern.c     | 61
> > +++++++++++++++++++++++++-
> > > > > > >  drivers/virtio/virtio_pci_modern_dev.c | 18 ++++++++
> > > > > > >  include/linux/virtio_config.h          |  4 ++
> > > > > > >  include/linux/virtio_pci_modern.h      |  5 +++
> > > > > > >  7 files changed, 137 insertions(+), 6 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > index
> > > > > > > 3893dc29eb26..f4080692b351 100644
> > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > @@ -302,9 +302,15 @@ static int virtio_dev_probe(struct device *_d)
> > > > > > >  	if (err)
> > > > > > >  		goto err;
> > > > > > >
> > > > > > > +	if (dev->config->create_avq) {
> > > > > > > +		err = dev->config->create_avq(dev);
> > > > > > > +		if (err)
> > > > > > > +			goto err;
> > > > > > > +	}
> > > > > > > +
> > > > > > >  	err = drv->probe(dev);
> > > > > > >  	if (err)
> > > > > > > -		goto err;
> > > > > > > +		goto err_probe;
> > > > > > >
> > > > > > >  	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
> > > > > > >  	if (!(dev->config->get_status(dev) &
> > > > > > > VIRTIO_CONFIG_S_DRIVER_OK))
> > > > > >
> > > > > > Hmm I am not all that happy that we are just creating avq
> > unconditionally.
> > > > > > Can't we do it on demand to avoid wasting resources if no one uses it?
> > > > > >
> > > > > Virtio queues must be enabled before driver_ok as we discussed in
> > > > F_DYNAMIC bit exercise.
> > > > > So creating AQ when first legacy command is invoked, would be too late.
> > > >
> > > > Well we didn't release the spec with AQ so I am pretty sure there
> > > > are no devices using the feature. Do we want to already make an
> > > > exception for AQ and allow creating AQs after DRIVER_OK even without
> > F_DYNAMIC?
> > > >
> > > No. it would abuse the init time config registers for the dynamic things like
> > this.
> > > For flow filters and others there is need for dynamic q creation with multiple
> > physical address anyway.
> > 
> > That seems like a completely unrelated issue.
> > 
> It isn't.
> Driver requirements are:
> 1. Driver needs to dynamically create vqs
> 2. Sometimes this VQ needs to have multiple physical addresses
> 3. Driver needs to create them after driver is fully running, past the bootstrap stage using tiny config registers
> 
> Device requirements are:
> 1. Not to keep growing 64K VQs *(8+8+8) bytes of address registers + enable bit
> 2. Ability to return appropriate error code when fail to create queue
> 3. Above #2
> 
> Users of this new infrastructure are eth tx,rx queues, flow filter queues, aq, blk rq per cpu.
> AQs are just one of those.
> When a generic infrastructure for this will be built in the spec as we started that, all above use cases will be handled.
> 
> > > So creating virtqueues dynamically using a generic scheme is desired with
> > new feature bit.

Reducing config registers and returning errors should be handled by
a new transport.
VQ with multiple addresses - I can see how you would maybe only
support that with that new transport?


I think I can guess why you are tying multiple addresses to dynamic VQs -
you suspect that allocating huge half-megabyte VQs dynamically will fail if
triggered on a busy system. Is that the point?


In that case I feel it's a good argument to special-case
admin VQs because there's no real need to make them
huge at the moment - for example this driver just adds one at a time.
No?



-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
