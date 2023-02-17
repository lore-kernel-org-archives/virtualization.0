Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEEDC636D4
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 10:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78994404F9;
	Fri, 17 Feb 2023 10:11:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78994404F9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a162mr4q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hCP6jLB-UKBT; Fri, 17 Feb 2023 10:11:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0521F40491;
	Fri, 17 Feb 2023 10:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0521F40491
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6E24C0033;
	Fri, 17 Feb 2023 10:11:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46275C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 10:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26AD4417AD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 10:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26AD4417AD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a162mr4q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_vZBoNW0g8Y
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 10:11:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8C76417A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8C76417A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 10:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676628706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dvpK31b66LZjOlbG0RKceUyJP6Xe2y/6MQclDivAbW8=;
 b=a162mr4qXZaVlzcIKbKIwdArdg9ZR32w3iHdjSPwfZDn5WRO2s4I3ANQEQHfncjmTX6rSR
 I1WJviZxOYssxqU1zGAE91d0rdPxwnQm6FKap1pUM/cCaNV+3xVK5A/JbDXae5HrRA4Li7
 Kg4lcWA77wlBotkB9hXxBpWQnV+lvI0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-HEBjH3_yOc-BB2Jlwh8sIQ-1; Fri, 17 Feb 2023 05:11:44 -0500
X-MC-Unique: HEBjH3_yOc-BB2Jlwh8sIQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 bn14-20020a056000060e00b002c5c4d8ced0so199882wrb.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 02:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvpK31b66LZjOlbG0RKceUyJP6Xe2y/6MQclDivAbW8=;
 b=DRQhSF1ta6zgopSGtn8Oh4dBOsmm4ZZQcWNmtQYPfT7/LTQoJoVCNcsaVSYCQ/7fiq
 aj58AEoQqz1qQrnqCrka/5YsZ1m/dF85ppUET1gPNGSkkRO+r0gy31muyGAh9hvPm/Zu
 q3xSC9K19kAqkEYzo7mP99/Ta77LksL+Hw0ym8w7e7NYrgZHRDaUJmdyt5Ps333JnjMQ
 PXAua5fWcm8l64ncDX0ikYehCx1ikduNFlPtQamhhm5q+bizDX4eh/CoGcBjeUgyIV7/
 5WEC9nwoYYtFGUzb23NtG8mZhSE6G7SalfAiAzwdd3wleGqbbvcTn+4UhLPNGG/TOFvA
 dbZg==
X-Gm-Message-State: AO0yUKXRhQ5c3Fr3+36S0Cbat7m5LgS2Kbxf94bFqZPfIxiWykrPNH/f
 OAzITFQxCxRDfcun4bH42DKbUY3XHUAPNQ5lozeWFaI7KIvFwlIToqH17eaPpBjOwXdTwgURDoT
 TzbxFfhCCwAp9H9jYus47TP4PWHHIDMWgL3nGXRocjg==
X-Received: by 2002:a05:600c:4d21:b0:3d9:f769:2115 with SMTP id
 u33-20020a05600c4d2100b003d9f7692115mr188611wmp.26.1676628703387; 
 Fri, 17 Feb 2023 02:11:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+Kcg4izxtCX4bYTTRixMiAEVt9Z6ixnz/KbWXmJ3fdzzSg3LAlSGK6fov0vMkMCzQhoGEOjA==
X-Received: by 2002:a05:600c:4d21:b0:3d9:f769:2115 with SMTP id
 u33-20020a05600c4d2100b003d9f7692115mr188590wmp.26.1676628703126; 
 Fri, 17 Feb 2023 02:11:43 -0800 (PST)
Received: from redhat.com ([2.52.5.34]) by smtp.gmail.com with ESMTPSA id
 az5-20020a05600c600500b003e20a6fd604sm4644634wmb.4.2023.02.17.02.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Feb 2023 02:11:42 -0800 (PST)
Date: Fri, 17 Feb 2023 05:11:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230217051038-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
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

On Fri, Feb 17, 2023 at 01:35:59PM +0800, Jason Wang wrote:
> On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > From: Rong Wang <wangrong68@huawei.com>
> > >
> > > Once enable iommu domain for one device, the MSI
> > > translation tables have to be there for software-managed MSI.
> > > Otherwise, platform with software-managed MSI without an
> > > irq bypass function, can not get a correct memory write event
> > > from pcie, will not get irqs.
> > > The solution is to obtain the MSI phy base address from
> > > iommu reserved region, and set it to iommu MSI cookie,
> > > then translation tables will be created while request irq.
> >
> > Probably not what anyone wants to hear, but I would prefer we not add
> > more uses of this stuff. It looks like we have to get rid of
> > iommu_get_msi_cookie() :\
> >
> > I'd like it if vdpa could move to iommufd not keep copying stuff from
> > it..
> 
> Yes, but we probably need a patch for -stable.

Hmm do we? this looks like it's enabling new platforms is not a bugfix...

> >
> > Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> > path, and it is missing the iommu ownership mechanism.
> 
> Ok.
> 
> >
> > Also which in-tree VDPA driver that uses the iommu runs on ARM? Please
> 
> ifcvf and vp_vpda are two drivers that use platform IOMMU.
> 
> Thanks
> 
> > don't propose core changes for unmerged drivers. :(
> >
> > Jason
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
