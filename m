Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858E1C61DA4
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 02:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8168981D72;
	Mon, 20 Feb 2023 02:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8168981D72
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hsGpX697
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Phpo1YFQ0g7Z; Mon, 20 Feb 2023 02:36:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 705C381D0C;
	Mon, 20 Feb 2023 02:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 705C381D0C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39CCAC0033;
	Mon, 20 Feb 2023 02:36:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDFBFC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E0F981D46
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:36:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E0F981D46
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RyvCB0k0c4rI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:36:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A02F381D0C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A02F381D0C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 02:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676860600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+QRTKe9fslXsmMjbWLGC+1jCq193n05lX0twVp21S3I=;
 b=hsGpX6976hdhAd1NgH70VDZh0rG01tRZWoHcrTr3H/+aWtrTKiD15S/nkUTGEVJ3N6+cvo
 oqbg77tBv5eMvPLwey23tOajo+slchKYyv6Dm1KxJkIAiSfjMcQ65hw0h+iKPGfXg24KXO
 Nph51+kvI6djeAp4kWlnHXexl91LPfs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-tYn_XELgNzSZyG5KKoFcjw-1; Sun, 19 Feb 2023 21:36:39 -0500
X-MC-Unique: tYn_XELgNzSZyG5KKoFcjw-1
Received: by mail-oi1-f198.google.com with SMTP id
 w18-20020a0568080d5200b0037806f41283so905oik.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 18:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+QRTKe9fslXsmMjbWLGC+1jCq193n05lX0twVp21S3I=;
 b=1/UicdJe6gHzIZMKVUBFPN5SBZjV/rtnAerjBld2gJp5F+hPSPlWgTDjjyOxUAYRBq
 16C9oqSEFWIeNOWYrbklCoE2SNsWsQbws/IDSKaYvJn4IseLN0MoB1Cd8OkLhqiKwjLK
 tA/tlDQPO48ajmcbbkKipVWdYLOco1/peBb11At2TcpJni7P4nW3tQGJZq8JjEsZvtmF
 /hBkv1H5PnIDS7GwF+x/Od+3H+XmKainONRpL2qAfE3v4c8QiZs5DoCsIIv1M1gc40yn
 mQfjA1VAtbi5KcFCGTHSmDqnybbaiU5I5t7bKxznt9Yg8nTm/mb2tTjVizG1/s7zNoFv
 eZSg==
X-Gm-Message-State: AO0yUKXuMzmjpPJr6cpKzXcsSiOJnRCLIS70p+emx/0vW/hn3RFPtHbl
 dxAGpvjVNRMYrZcPOr1IItFRx6GRzZ7K0yU6kqPVyYH92yItIti1jrL0CJhQnbEDJEI17yZFfq1
 UjM1THzad3mWvoaRnxYBLTs/iow1OduCOZzqWHH2Bw8aJXj+NITymIFNYgw==
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr212606oae.217.1676860598370; 
 Sun, 19 Feb 2023 18:36:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+o/PIyYCf/r6enEsMKw/BDh3XyDsV2IO5FKzRCPBc/l0Kkzql2S6nZ1RAhn3rjmZd7RJyHVxQxAPtJc0uZzgY=
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr212592oae.217.1676860598109; Sun, 19
 Feb 2023 18:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
 <20230217051038-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230217051038-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 10:36:27 +0800
Message-ID: <CACGkMEuDG1NUs0=ry1=Mphfd+TrqAvVS0yeu9hcni2VrPkB8tQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Fri, Feb 17, 2023 at 6:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 17, 2023 at 01:35:59PM +0800, Jason Wang wrote:
> > On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
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
> > Yes, but we probably need a patch for -stable.
>
> Hmm do we? this looks like it's enabling new platforms is not a bugfix...

I think we haven't limited vDPA to any specific arch in the past?

Thanks

>
> > >
> > > Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> > > path, and it is missing the iommu ownership mechanism.
> >
> > Ok.
> >
> > >
> > > Also which in-tree VDPA driver that uses the iommu runs on ARM? Please
> >
> > ifcvf and vp_vpda are two drivers that use platform IOMMU.
> >
> > Thanks
> >
> > > don't propose core changes for unmerged drivers. :(
> > >
> > > Jason
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
