Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65210E7D0A0
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 17:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A71F81E89;
	Thu, 21 Sep 2023 17:21:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A71F81E89
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iR0+V7iu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nzf27YSkAOxC; Thu, 21 Sep 2023 17:21:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 943D681E28;
	Thu, 21 Sep 2023 17:21:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 943D681E28
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB12C0039;
	Thu, 21 Sep 2023 17:21:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F32FEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C75B781E28
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:21:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C75B781E28
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WEDQ1wEOyLS8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:21:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC3A481E12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:21:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC3A481E12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695316894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yfvcp/sQqGTMiLfnwncZE40pvpmDeNT1ERGwo6bROTE=;
 b=iR0+V7iuoHPJ/VxbXaU/141OZpLvDJ6+GxJuYdlCac9/5IhWOZtGMkPHyM9H/JbuB3n0MK
 1XTi5FiiOH/Rav70lUlmUd765jDqmL6jVaC8mQGIE3eEWTAbKUCeKVKYoYqVG5tx1kp7zE
 Es2SStUIlVzZ1fV8dJNSzYlYSlWes9Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-e0uXUN8aNwa6T9wj9jsgoQ-1; Thu, 21 Sep 2023 13:21:32 -0400
X-MC-Unique: e0uXUN8aNwa6T9wj9jsgoQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5310e629933so862306a12.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 10:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695316891; x=1695921691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yfvcp/sQqGTMiLfnwncZE40pvpmDeNT1ERGwo6bROTE=;
 b=mZ2twm5Hjd6wMw4bhRUUMIOpjhLC6jzPAdnBZ1wIFz4aMRv1ZlrgAtEM+8ayKUSKZE
 hspQGNMqgc1wLUbyWQfBfBaFkmjiMPliluA6JpmH556Uvj746QreozPMC3lAzHUYBqxd
 JQ8+8std3uitd3NFtnv4CcXgr+aMuZvm45Rp5RUNLCJV8ridZDfIbsmDcf41omur3pAV
 nnrtoChVq1OyIunPyluuQ+G6HxGaXklPdVBeFaMjwoJfL4jKx8hSGNdDqqTyMBJyknkp
 WBUaJec4ket1Ni/pQSOjLWquHonoblb07LbhspsKgVycueMP7SMoocxQ/SSZCaDQxEfG
 iMuA==
X-Gm-Message-State: AOJu0YzyLLvjxn01dpvDEttsUjS0HFFsYK8mZKA3ivysR1oW8D6R6fHG
 L7aqZW4ueqt7RJHRr91xrcNm0QVzQGKc9v1CoCXm34LjEg4QV4KY8bytdAbf8qTxvsQIk6npVfN
 6J6OsZo+wI7ibU48p17h2Hhjq2vgq9OQoTAG30jDXsg==
X-Received: by 2002:a17:906:2216:b0:9ae:6bef:4a6a with SMTP id
 s22-20020a170906221600b009ae6bef4a6amr1282162ejs.16.1695316891620; 
 Thu, 21 Sep 2023 10:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8DbU18CgGE/rzYdUfBFCWTzbAvRH225iJnMR97jIiNIWNmMT4Vftg9I2DLNAh448yV8cgCA==
X-Received: by 2002:a17:906:2216:b0:9ae:6bef:4a6a with SMTP id
 s22-20020a170906221600b009ae6bef4a6amr1282136ejs.16.1695316891261; 
 Thu, 21 Sep 2023 10:21:31 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 dx26-20020a170906a85a00b0099bcd1fa5b0sm1314460ejb.192.2023.09.21.10.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:21:30 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:21:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921131035-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
 <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921170709.GS13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 02:07:09PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 01:01:12PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 21, 2023 at 01:52:24PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 21, 2023 at 10:43:50AM -0600, Alex Williamson wrote:
> > > 
> > > > > With that code in place a legacy driver in the guest has the look and
> > > > > feel as if having a transitional device with legacy support for both its
> > > > > control and data path flows.
> > > > 
> > > > Why do we need to enable a "legacy" driver in the guest?  The very name
> > > > suggests there's an alternative driver that perhaps doesn't require
> > > > this I/O BAR.  Why don't we just require the non-legacy driver in the
> > > > guest rather than increase our maintenance burden?  Thanks,
> > > 
> > > It was my reaction also.
> > > 
> > > Apparently there is a big deployed base of people using old guest VMs
> > > with old drivers and they do not want to update their VMs. It is the
> > > same basic reason why qemu supports all those weird old machine types
> > > and HW emulations. The desire is to support these old devices so that
> > > old VMs can work unchanged.
> > > 
> > > Jason
> > 
> > And you are saying all these very old VMs use such a large number of
> > legacy devices that over-counting of locked memory due to vdpa not
> > correctly using iommufd is a problem that urgently needs to be solved
> > otherwise the solution has no value?
> 
> No one has said that.
> 
> iommufd is gaining alot more functions than just pinned memory
> accounting.

Yea it's very useful - it's also useful for vdpa whether this patchset
goes in or not.  At some level, if vdpa can't keep up then maybe going
the vfio route is justified. I'm not sure why didn't anyone fix iommufd
yet - looks like a small amount of work. I'll see if I can address it
quickly because we already have virtio accelerators under vdpa and it
seems confusing to people to use vdpa for some and vfio for others, with
overlapping but slightly incompatible functionality.  I'll get back next
week, in either case. I am however genuinely curious whether all the new
functionality is actually useful for these legacy guests.

> > Another question I'm interested in is whether there's actually a
> > performance benefit to using this as compared to just software
> > vhost. I note there's a VM exit on each IO access, so ... perhaps?
> > Would be nice to see some numbers.
> 
> At least a single trap compared with an entire per-packet SW flow
> undoubtably uses alot less CPU power in the hypervisor.
> 
> Jason

Something like the shadow vq thing will be more or less equivalent then?
That's upstream in qemu and needs no hardware support. Worth comparing
against.  Anyway, there's presumably actual hardware this was tested
with, so why guess? Just test and post numbers.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
