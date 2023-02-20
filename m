Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287ADC636CC
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 15:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AF4660BC9;
	Mon, 20 Feb 2023 15:24:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AF4660BC9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vc8E9jyE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WMCi3cm2xNon; Mon, 20 Feb 2023 15:24:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D256E60BC5;
	Mon, 20 Feb 2023 15:24:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D256E60BC5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A05B6C0033;
	Mon, 20 Feb 2023 15:24:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFEA2C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 15:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B806481A34
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 15:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B806481A34
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vc8E9jyE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cLNSAsKRA2wv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 15:24:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD92C818EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD92C818EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676906669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XXbeg/8n4ojsPY6rFquIIVMt+7vRYFxzuQ9z7o+cgT8=;
 b=Vc8E9jyEHLj61nUOjktduqzw57TqpoBXWks/hxSvl9sa4JIlaKgQWq4o5DEvrqJetQxUBJ
 aBk2yFmKJZ6cYKsHobf5ZWk8gDMrU5TiUkjhZh7q/9coJmPX7kBnY6VDsF7PR57CBdCo4j
 YO5tey18tN5F9xDyWJxX8pbxq+YW93E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-278-c0okpVIkNtGHBf8HWM0www-1; Mon, 20 Feb 2023 10:24:28 -0500
X-MC-Unique: c0okpVIkNtGHBf8HWM0www-1
Received: by mail-wm1-f70.google.com with SMTP id
 h8-20020a05600c314800b003e10bfcd160so620807wmo.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXbeg/8n4ojsPY6rFquIIVMt+7vRYFxzuQ9z7o+cgT8=;
 b=N5NcqXmOBQkG7qp11fdoLvT8g6ehylp9B4btCZwzH4LBwG63gDjfRFDlhydvuhv/1P
 IPsGRGpaMQcp7byL/KE5QvmDLpR135m5YiUVw6asTiMEoVct3AfCaLI8OUc1KU5nO6FK
 g0PL7+1iJgQOTdhO+iUjXOpBN/7RCs8W5wCtUdMs19cYu525ynZZygm98neCSkif7uiI
 +8HpZAMkbgLZiaEOxAPyzBP3eL01zGV8EjT626bbZEZClJ100i+iqG2SapcP4R7FST2U
 rdnTDkVoKwSFeRC/yfKC4oEEuPwAg9bjBlieseSwuIxp4Gr8o+hifOZn+4r8JTzbXgRo
 +2kA==
X-Gm-Message-State: AO0yUKX9Nyq7iEDndadjbGTMB8qLGqsapx95SZZS2vBT/rKFCZy9dWnt
 4TxA9dRwFItCy3wAU1ZQCdwaFOooc94Ls7fo3vmDAv0zkeO2Ni7g2CynpAq2cmOLza1z49gzTik
 NBzgl6PNOovQRnvkHqoG3rxCDxk+kANy9jEHGMfLVZA==
X-Received: by 2002:a05:600c:4591:b0:3e0:481:c897 with SMTP id
 r17-20020a05600c459100b003e00481c897mr1269887wmo.37.1676906667353; 
 Mon, 20 Feb 2023 07:24:27 -0800 (PST)
X-Google-Smtp-Source: AK7set9tFwhAVYPdJYx0EhG2sVxAmzmAIlOl5vAvFJ3YD45gjzKLDP25kfvtfbMuXNPd38LD2ll++g==
X-Received: by 2002:a05:600c:4591:b0:3e0:481:c897 with SMTP id
 r17-20020a05600c459100b003e00481c897mr1269863wmo.37.1676906667016; 
 Mon, 20 Feb 2023 07:24:27 -0800 (PST)
Received: from redhat.com ([2.52.5.34]) by smtp.gmail.com with ESMTPSA id
 p8-20020a1c7408000000b003b47b80cec3sm541587wmc.42.2023.02.20.07.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Feb 2023 07:24:26 -0800 (PST)
Date: Mon, 20 Feb 2023 10:24:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230220102216-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
 <20230217051038-mutt-send-email-mst@kernel.org>
 <CACGkMEuDG1NUs0=ry1=Mphfd+TrqAvVS0yeu9hcni2VrPkB8tQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuDG1NUs0=ry1=Mphfd+TrqAvVS0yeu9hcni2VrPkB8tQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, netdev@vger.kernel.org, robin.murphy@arm.com,
 wangrong68@huawei.com
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

On Mon, Feb 20, 2023 at 10:36:27AM +0800, Jason Wang wrote:
> On Fri, Feb 17, 2023 at 6:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 01:35:59PM +0800, Jason Wang wrote:
> > > On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > > > From: Rong Wang <wangrong68@huawei.com>
> > > > >
> > > > > Once enable iommu domain for one device, the MSI
> > > > > translation tables have to be there for software-managed MSI.
> > > > > Otherwise, platform with software-managed MSI without an
> > > > > irq bypass function, can not get a correct memory write event
> > > > > from pcie, will not get irqs.
> > > > > The solution is to obtain the MSI phy base address from
> > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > then translation tables will be created while request irq.
> > > >
> > > > Probably not what anyone wants to hear, but I would prefer we not add
> > > > more uses of this stuff. It looks like we have to get rid of
> > > > iommu_get_msi_cookie() :\
> > > >
> > > > I'd like it if vdpa could move to iommufd not keep copying stuff from
> > > > it..
> > >
> > > Yes, but we probably need a patch for -stable.
> >
> > Hmm do we? this looks like it's enabling new platforms is not a bugfix...
> 
> I think we haven't limited vDPA to any specific arch in the past?
> 
> Thanks

No, but it still fails gracefully right?

Anyway, this will need iommu maintainer's ack.  We'll see.


> >
> > > >
> > > > Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> > > > path, and it is missing the iommu ownership mechanism.
> > >
> > > Ok.
> > >
> > > >
> > > > Also which in-tree VDPA driver that uses the iommu runs on ARM? Please
> > >
> > > ifcvf and vp_vpda are two drivers that use platform IOMMU.
> > >
> > > Thanks
> > >
> > > > don't propose core changes for unmerged drivers. :(
> > > >
> > > > Jason
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
