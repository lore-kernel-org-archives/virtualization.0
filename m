Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB5AC61DA4
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 02:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 285764070F;
	Mon, 20 Feb 2023 02:37:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 285764070F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fPygkbLA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w5OhTthEViqs; Mon, 20 Feb 2023 02:37:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB41540025;
	Mon, 20 Feb 2023 02:37:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB41540025
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80554C0033;
	Mon, 20 Feb 2023 02:37:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6132CC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C6A5401CA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:37:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C6A5401CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GwO9klshIXoQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:37:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02B4B40025
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02B4B40025
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676860651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z4mF9eRLWUighxaWu/WlNqJCc0pM0J+zyyIk2SE2gxU=;
 b=fPygkbLALlk+6ukzBEvSJLsPhuqYnNPH0N7bl7BG0m0F3E6y+Pfob4gWdaTJz9lCvJobxG
 fLG5thQGVgd5lqzmTEaK+4VJqNjDNVV5AqTmIVNbM6TxWm8X8UXf6x9VIgJMcbcNqKkxoW
 PWh5hg2L2e56X4rdY32ZSAVN2Bs/ppo=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-214-tFKYkXmmMy6K-cjEI4C4Ug-1; Sun, 19 Feb 2023 21:37:30 -0500
X-MC-Unique: tFKYkXmmMy6K-cjEI4C4Ug-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-171dfb4cc05so364565fac.21
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 18:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z4mF9eRLWUighxaWu/WlNqJCc0pM0J+zyyIk2SE2gxU=;
 b=DRChiyEdR6Bkanm/eiaDiXUk1LWcFb2VDxISbUIiLM8GLyusYM/u+rzmn14/1Pr5w9
 a9dnteBn/heMMYFlk6t5vBvYK/8fPTkmVUzmjM0Ak+wUPgskF1zqsbC1XwJ34qig4fD+
 IHt64nG2Z7gN6bp6tzFC+s3o7lDNA5zmczXc6ncz06B+flSlg5AzjmViY+sg7Fwexq5e
 Khfqj3CFKoxQvdBMr84e3M2YIvNRFALu56OltXWaTWKgEs/MaTfmw0EU4wh2t3WxyAyd
 1tkq2dTBl1YlmaVmSBCSlI/SXkb8Bb4v6Q4lp2t0ztJx4h67SMC+6Cl0atnPWW2j9Xz9
 n8HQ==
X-Gm-Message-State: AO0yUKWcxy5NA88SbBIx41ibv+rvoing6EHVVJO3lCgglDlfRP7jTMzG
 TEe1FMDZsBzIzIe0JEuRz3iqmVoiypYJ8rvnalDpuPlKy89gCEIgEhTO+f4Qg05MPD0EtxtFP6N
 hISFjAJ/gnq74ovHg5BdRnD0/OBCsHw9tpFbJkDQgA1tDKIRhQHJR0xbTCw==
X-Received: by 2002:a05:6870:e309:b0:16a:cfba:d187 with SMTP id
 z9-20020a056870e30900b0016acfbad187mr57939oad.2.1676860649425; 
 Sun, 19 Feb 2023 18:37:29 -0800 (PST)
X-Google-Smtp-Source: AK7set8SJitLQ9LUE3u1syC+o7Uv38TErayt/RAfp5Ui0lrmlYgjeBjytjXtpn+4L/G0i6tLLMj766NjBhCbz614fY0=
X-Received: by 2002:a05:6870:e309:b0:16a:cfba:d187 with SMTP id
 z9-20020a056870e30900b0016acfbad187mr57932oad.2.1676860649055; Sun, 19 Feb
 2023 18:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com> <20230217051158-mutt-send-email-mst@kernel.org>
 <Y+92c9us3HVjO2Zq@nvidia.com>
In-Reply-To: <Y+92c9us3HVjO2Zq@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 10:37:18 +0800
Message-ID: <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org,
 Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, joro@8bytes.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, robin.murphy@arm.com, wangrong68@huawei.com
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

On Fri, Feb 17, 2023 at 8:43 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Feb 17, 2023 at 05:12:29AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > > From: Rong Wang <wangrong68@huawei.com>
> > > >
> > > > Once enable iommu domain for one device, the MSI
> > > > translation tables have to be there for software-managed MSI.
> > > > Otherwise, platform with software-managed MSI without an
> > > > irq bypass function, can not get a correct memory write event
> > > > from pcie, will not get irqs.
> > > > The solution is to obtain the MSI phy base address from
> > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > then translation tables will be created while request irq.
> > >
> > > Probably not what anyone wants to hear, but I would prefer we not add
> > > more uses of this stuff. It looks like we have to get rid of
> > > iommu_get_msi_cookie() :\
> > >
> > > I'd like it if vdpa could move to iommufd not keep copying stuff from
> > > it..
> >
> > Absolutely but when is that happening?
>
> Don't know, I think it has to come from the VDPA maintainers, Nicolin
> made some drafts but wasn't able to get it beyond that.

Cindy (cced) will carry on the work.

Thanks

>
> Please have people who need more iommu platform enablement to pick it
> up instead of merging hacks like this..
>
> We are very close to having nested translation on ARM so anyone who is
> serious about VDPA on ARM is going to need iommufd anyhow.
>
> Jason
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
