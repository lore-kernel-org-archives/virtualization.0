Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C06FC25B67
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 15:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8C2841AC6;
	Thu, 26 Oct 2023 15:46:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8C2841AC6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pj0DwzVU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bTtAwd1cTLn; Thu, 26 Oct 2023 15:46:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0F2E541A81;
	Thu, 26 Oct 2023 15:46:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F2E541A81
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8EBEC0071;
	Thu, 26 Oct 2023 15:46:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38F2FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 15:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1422583C5B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 15:46:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1422583C5B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pj0DwzVU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QaVX5cUvlwAR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 15:46:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09F9683C34
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 15:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09F9683C34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698335182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7Ca1EAZL+2Z1bfHSI962eRHVYOz5lUhj6+DjkPXJCM=;
 b=Pj0DwzVU3Hd2t+FCrOswxpjXgPAR78xmdNP/5VkTnWpUfsTUL6QGZpZfV2Yv/wayeYwGYH
 ytjegUJG0WeZNdS3znYyowNljX6KNusRPCYDw+sVgMieVyVIzcbN/SwIb2E/vEEGz8uZ3q
 o5yU4pDikqIAEwgPOKJmj0w2diL0yzU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Us6f9AZpNo-sJc2FCMuu4Q-1; Thu, 26 Oct 2023 11:46:21 -0400
X-MC-Unique: Us6f9AZpNo-sJc2FCMuu4Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9c75886c044so72027366b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 08:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698335180; x=1698939980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7Ca1EAZL+2Z1bfHSI962eRHVYOz5lUhj6+DjkPXJCM=;
 b=FGx8zduVc8Ub4iJC2I5gq8Oqqxx7Zvx8ovn32YhNutmLxdCXpSkhcGRU1Vd25faPHS
 0sxRC6X0KBemTMr8lgX4073lqybbcgBnNJdWi1e7vqaqm+RfRq9mVGWQIopCjeDZAqhX
 e3X1xGf5+6BSSiT0CiAaI5yH7pNlYi3J1VAG5Y+K+ofciDGb3lG7TJYhpycicprAkUbu
 9R9KDYtu/MYW3oebY+ssM2aDkmxBjZxUoN3xcf7pbAqQatSakOG7erO+aAx3fF9Y96kA
 w6e4Nku1GPx3V9br1HzdEem+qdz7HXSJhMVE+uJj4YC66al+vjbAHPTkU/7Hu4GUaMlD
 SHfA==
X-Gm-Message-State: AOJu0Yxu2MkfFWXqR7TKgerr8KVSp/QQRuGXK3piQDBGz10fZa65F35Y
 2O4UNy2Xe6SJ/avzdUvGsM1iefdaYQjt8NynxiW0TyCC/o1p6TjKEXkZAiPV7QChDmm9VRKkeJj
 x1ek4n48H/SyVge8/3gvFWvcCvgD6tabntm4q2PY3/A==
X-Received: by 2002:a17:906:fe06:b0:9c5:b535:ecb2 with SMTP id
 wy6-20020a170906fe0600b009c5b535ecb2mr75828ejb.40.1698335180298; 
 Thu, 26 Oct 2023 08:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVQkSXrrdczESMqkWdiPrB10Y3ArwHAIVLW1OGeFIR3ZM33q6KKWKskiUbWxVPk206cohaHQ==
X-Received: by 2002:a17:906:fe06:b0:9c5:b535:ecb2 with SMTP id
 wy6-20020a170906fe0600b009c5b535ecb2mr75798ejb.40.1698335179911; 
 Thu, 26 Oct 2023 08:46:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:37eb:8e1f:4b3b:22c7:7722])
 by smtp.gmail.com with ESMTPSA id
 li18-20020a170906f99200b0099297782aa9sm11654841ejb.49.2023.10.26.08.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:46:19 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:46:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231026112804-mutt-send-email-mst@kernel.org>
References: <20231024135713.360c2980.alex.williamson@redhat.com>
 <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
 <20231025131328.407a60a3.alex.williamson@redhat.com>
 <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
 <20231026081033-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E1AF869C1296B987A34BDCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231026091459-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548167D2A92F3D10E4F02E93DCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231026110426-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819C408A120436010F608FDCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819C408A120436010F608FDCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Thu, Oct 26, 2023 at 03:09:13PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, October 26, 2023 8:36 PM
> > 
> > On Thu, Oct 26, 2023 at 01:28:18PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, October 26, 2023 6:45 PM
> > >
> > > > > Followed by an open coded driver check for 0x1000 to 0x103f range.
> > > > > Do you mean windows driver expects specific subsystem vendor id of
> > 0x1af4?
> > > >
> > > > Look it up, it's open source.
> > >
> > > Those are not OS inbox drivers anyway.
> > > :)
> > 
> > Does not matter at all if guest has drivers installed.
> > Either you worry about legacy guests or not.
> > 
> So, Linux guests have inbox drivers, that we care about and they seems to be covered, right?
> 
> > 
> > > The current vfio driver is following the virtio spec based on legacy spec, 1.x
> > spec following the transitional device sections.
> > > There is no need to do something out of spec at this point.
> > 
> > legacy spec wasn't maintained properly, drivers diverged sometimes
> > significantly. what matters is installed base.
> 
> So if you know the subsystem vendor id that Windows expects, please share, so we can avoid playing puzzle game. :)
> It anyway can be reported by the device itself.

I don't know myself offhand. I just know it's not so simple. Looking at the source
for network drivers I see:

%kvmnet6.DeviceDesc%    = kvmnet6.ndi, PCI\VEN_1AF4&DEV_1000&SUBSYS_0001_INX_SUBSYS_VENDOR_ID&REV_00, PCI\VEN_1AF4&DEV_1000


So the drivers will:
A. bind with high priority to subsystem vendor ID used when drivers where built.
   popular drivers built and distributed for free by Red Hat have 1AF4
B. bind with low priority to any subsystem device/vendor id as long as
   vendor is 1af4 and device is 1000


My conclusions:
- you probably need a way to tweak subsystem vendor id in software
- default should probably be 1AF4 not whatever actual device uses


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
