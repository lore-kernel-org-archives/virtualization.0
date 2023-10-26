Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38997C25B48
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 15:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A891641A3B;
	Thu, 26 Oct 2023 15:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A891641A3B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EguAt6zT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSzmvXY4OneP; Thu, 26 Oct 2023 15:06:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E67B7400B9;
	Thu, 26 Oct 2023 15:06:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E67B7400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6209C0071;
	Thu, 26 Oct 2023 15:06:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6545AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 15:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3ECA4401D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 15:06:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3ECA4401D2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vVHITxWk1FEH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 15:06:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B491400B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 15:06:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B491400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698332777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0KZ7H5+hQgT1kPSrimPTzl67XPfDZ+0EP0kffhfYTM=;
 b=EguAt6zTmDn1Od0UPW9KQiFFRLZPNJMs4Tdt/1yhqz4xaFFzr7x8SalAZMrsmeL+bEY6zx
 fBNeMcUgLpDzWme7jGYxt3rAyPVZ2DVB5f/LpjvT8+47jXQ6xhsRtGni7IsHQvxVr5sKcq
 SpmoVrEU07VbVK+uMjtUzsnih9KAkPw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-kesTQkHlM2avl3hiCc2DlQ-1; Thu, 26 Oct 2023 11:06:15 -0400
X-MC-Unique: kesTQkHlM2avl3hiCc2DlQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9c749c28651so72170266b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 08:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698332774; x=1698937574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0KZ7H5+hQgT1kPSrimPTzl67XPfDZ+0EP0kffhfYTM=;
 b=XTaxa1w9UR3Kt0cYuxJla/7H9Rywxz3iU0+gJqqiCsnvpJuXEvWx2TnSeo46TXKZJ0
 3A3RUl4HXy16WlP+neEdRU+x8s7/DTHCULEe67RxdNMCoyBMT20mIkxdZDI7s0Ku90X1
 01ob3ziDhRnS9c0l4dvCuvw7EgP0kj+MwYAZMXevcgaoBDqDJMDj6LJjHKychXwIopPa
 e4eqoHvsDA7uMBjkIN25nAyTWucNqOl8Fjx3XG5DV58RRt5ETAU4dZmwbZSPgkKZ3Rpo
 D+sBbfuVAtXd3h+M1tZR2VtkWKO4JqCgQz12XNvBAuZSDM++r7REyyBCYgY7VIWVDGut
 doLQ==
X-Gm-Message-State: AOJu0YwZszk+DCwIvuh5WpmAojapEv4gkYEPlK5KoOvKSy0G3AxJ6aRa
 8t3RFJASA8CgLhFT9zq564yfWM58eeVVr4BfyOdWUt24EXqGLysSaE/XlIFrge66ATttJplqLUG
 rs8OopDh0/3YgeEUcSw+xtktH3nk5YGfBQc2rCI/Ywg==
X-Received: by 2002:a17:907:9451:b0:9be:cdca:dadb with SMTP id
 dl17-20020a170907945100b009becdcadadbmr13567066ejc.69.1698332774564; 
 Thu, 26 Oct 2023 08:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7eML0C7TXRz+am800g23BqKGYJs2pXWaQRh20fik802qzDy3vMIor47Fqn5lTnBAJjrL26g==
X-Received: by 2002:a17:907:9451:b0:9be:cdca:dadb with SMTP id
 dl17-20020a170907945100b009becdcadadbmr13567040ejc.69.1698332774255; 
 Thu, 26 Oct 2023 08:06:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:37eb:8e1f:4b3b:22c7:7722])
 by smtp.gmail.com with ESMTPSA id
 vl9-20020a170907b60900b00989828a42e8sm11676724ejc.154.2023.10.26.08.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:06:13 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:06:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231026110426-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
 <20231024135713.360c2980.alex.williamson@redhat.com>
 <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
 <20231025131328.407a60a3.alex.williamson@redhat.com>
 <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
 <20231026081033-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E1AF869C1296B987A34BDCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231026091459-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548167D2A92F3D10E4F02E93DCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548167D2A92F3D10E4F02E93DCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Thu, Oct 26, 2023 at 01:28:18PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, October 26, 2023 6:45 PM
> 
> > > Followed by an open coded driver check for 0x1000 to 0x103f range.
> > > Do you mean windows driver expects specific subsystem vendor id of 0x1af4?
> > 
> > Look it up, it's open source.
> 
> Those are not OS inbox drivers anyway.
> :)

Does not matter at all if guest has drivers installed.
Either you worry about legacy guests or not.


> The current vfio driver is following the virtio spec based on legacy spec, 1.x spec following the transitional device sections.
> There is no need to do something out of spec at this point.

legacy spec wasn't maintained properly, drivers diverged sometimes
significantly. what matters is installed base.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
