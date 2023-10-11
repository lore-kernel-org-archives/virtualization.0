Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710A4CDB482
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 20:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC4AE417CF;
	Wed, 11 Oct 2023 20:20:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC4AE417CF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V1KE0G5v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5jTWC6xz3tD; Wed, 11 Oct 2023 20:20:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DDFA24089B;
	Wed, 11 Oct 2023 20:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDFA24089B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC31BC0071;
	Wed, 11 Oct 2023 20:20:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD5B8C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 20:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A15E860BA1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 20:20:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A15E860BA1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V1KE0G5v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ms99Nbj7gx9V
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 20:20:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FA1960B6C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 20:20:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FA1960B6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697055625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0YsRsJouzUJ/dnrS+pndtkgSFm0ftdvhFuS9Oam6h7o=;
 b=V1KE0G5vIvqfJlDskHzxe1to+C7QxXNEfrpvRUNgY3qvTJUiLqdRftbeDs7l935HEXVhyb
 mZ1jMLb8tc8P0GIWsuwz9zXxnb4N0eZbPyaY7J35Otl1W7DPtl+RisQ4ejIzh0ORSDTzvH
 Vd5zFTo3KLowFmHNM3SMwNG+OJiyeAA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-QDoVDC9EPRSmrrbUAcpDbg-1; Wed, 11 Oct 2023 16:20:23 -0400
X-MC-Unique: QDoVDC9EPRSmrrbUAcpDbg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3296bd73d91so108529f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 13:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697055622; x=1697660422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YsRsJouzUJ/dnrS+pndtkgSFm0ftdvhFuS9Oam6h7o=;
 b=JSpQhM/ue/9dPf7i8KWSQYyQrGZpLW+Bvw1kFNw/SQkdRb/sH7oN/mWQ4YyDjk5swg
 HBEjTl3z5FeArpLk+AZfog7Qz0Nh0w+nkXDVwHVjjHJEk0SnQsqWFwfG5zDRLi3yROEp
 kDS/+hMnBY0FW1Cm5RDJ4/Iusa5AxxKgybamY6LqN+SpHK5j3PmY57VPHwZBD24waHNT
 gAJvJ7VSNyJBLEMWJaExSmITQ/jyEGYlTA2XsVWysfVcVmT15OUhw7hzpKpjbQiRwD8F
 S598LJ73ZrvyU3kpO5UNIy/60OTA0cLTAJIawUgmzuoOcv2Zn9vDC91L0WJjaoe0gE56
 Vutw==
X-Gm-Message-State: AOJu0YxdB49faWx/fA7l6cc4Rw6xayDPrfzRqOBPIVNhSqGNkDMsfXoW
 Y8gD3OENsnFDxw6ipoxJKQaBh6LJ7iRFUqynN11kEGGx0aaxM2qdCyzVnVpD+GGjLwffYG7qXH8
 Z4U+6G+8VsKTP20QcxvlOSjA+CIBGuJech+8DLA1N2w==
X-Received: by 2002:a5d:69d0:0:b0:31f:fa61:961d with SMTP id
 s16-20020a5d69d0000000b0031ffa61961dmr21085700wrw.63.1697055622334; 
 Wed, 11 Oct 2023 13:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiTyuUP7E7CnT9V2Z71OJD0K9u5DZp2nC+aSD/NLEJ54Qtnm9hP+lqS4NcSc0EFQFG8Kpf1w==
X-Received: by 2002:a5d:69d0:0:b0:31f:fa61:961d with SMTP id
 s16-20020a5d69d0000000b0031ffa61961dmr21085675wrw.63.1697055622048; 
 Wed, 11 Oct 2023 13:20:22 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a5d5407000000b00327df8fcbd9sm16437706wrv.9.2023.10.11.13.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 13:20:21 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:20:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011161935-mutt-send-email-mst@kernel.org>
References: <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <ZSZAIl06akEvdExM@infradead.org> <20231011135709.GW3952@nvidia.com>
 <ZSaudclSEHDEsyDP@infradead.org> <20231011145810.GZ3952@nvidia.com>
 <20231011125426-mutt-send-email-mst@kernel.org>
 <20231011171944.GA3952@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231011171944.GA3952@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, jiri@nvidia.com, leonro@nvidia.com
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

On Wed, Oct 11, 2023 at 02:19:44PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 11, 2023 at 12:59:30PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Oct 11, 2023 at 11:58:10AM -0300, Jason Gunthorpe wrote:
> > > Trying to put VFIO-only code in virtio is what causes all the
> > > issues. If you mis-design the API boundary everything will be painful,
> > > no matter where you put the code.
> > 
> > Are you implying the whole idea of adding these legacy virtio admin
> > commands to virtio spec was a design mistake?
> 
> No, I'm saying again that trying to relocate all the vfio code into
> drivers/virtio is a mistake
> 
> Jason

Yea please don't. And by the same token, please do not put
implementations of virtio spec under drivers/vfio.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
