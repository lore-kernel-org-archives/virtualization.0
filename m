Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AA4C6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E12E4194E;
	Fri, 10 Mar 2023 08:41:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E12E4194E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZzMJuKv2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id guGTmOy9MoIo; Fri, 10 Mar 2023 08:41:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C13AC415EA;
	Fri, 10 Mar 2023 08:41:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C13AC415EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89F62C0071;
	Fri, 10 Mar 2023 08:41:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65A1BC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C06940195
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C06940195
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZzMJuKv2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1v4yPkLzKhmq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:41:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AD6640157
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AD6640157
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678437704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgZ9DWKppXLbZXIYqFbF8nghQRnE3BR/P3wfdlRGiz4=;
 b=ZzMJuKv2FY7OCL/FsJvyy99Q6zcXZTVhVr2VJDsp3NfyciYZHUTVcZHi6z5Cf9BtbkAjos
 U3y9nROGNl5q92BxUQTNWvFHhxuQeqb/kM72rp5hcHGZ1bfkEcZRaki8Nu+MD6tTI0dKyg
 wPLwSvUlOn5AuEkV63wu3/UOnrJpC5w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-POcGk-FRNV-kkXiwrh6yGg-1; Fri, 10 Mar 2023 03:41:42 -0500
X-MC-Unique: POcGk-FRNV-kkXiwrh6yGg-1
Received: by mail-wr1-f70.google.com with SMTP id
 m10-20020adfe94a000000b002cdc5eac0d0so903265wrn.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678437701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgZ9DWKppXLbZXIYqFbF8nghQRnE3BR/P3wfdlRGiz4=;
 b=U8VRqDbFo2g2L96wFhT1OjySvm2U9zY66/0vhNAio7SeBgXdLQd+PufDHIMZFmlZLe
 NV3YWdKY/ulxIfKDIiIC8j/9xHVTAbdIrrAc1eBDf5Uqs3raDNjlUO2PIWBwcaaHOH7+
 KVxS3WE1ZpxiF8SRNz0Eh4z1LQe0lZjKNx83BwnqBRoVech089wUpCrWnTR27U0LownF
 KAJS06kUebd4GGoMxbW2EyVv1kD5ArOk95onXBYXkASEaLgNqSsIm/0cLGRAxznu2wfZ
 i1l9oq7dX1LJ9eQ6DXNMMVSJ2G1xgaCc4Nkxn+dtLrxS3pUNEh63MdWV3EefSCSDBywk
 aAgQ==
X-Gm-Message-State: AO0yUKWjWoTIcPXZ+Pol9IHgPbQ42erjFJ2suWo3+uaqsY2gTfQ0A1HC
 4/aLAMp5nTSfu7v1C66xpdsM7LzLKDeXHYj00veMDb547z+STYYPB85k2bOazTm8BvT01G1WgIc
 +jjPQAlYjjL46o/XS/NTAlSg01JJjUGSMy3znNTX0aw==
X-Received: by 2002:adf:f006:0:b0:2c7:1a96:63f2 with SMTP id
 j6-20020adff006000000b002c71a9663f2mr15408169wro.3.1678437701510; 
 Fri, 10 Mar 2023 00:41:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/0zNz/ZZRX8XUCR+0UQZYSDN/cLZcU6NuWf8z1hU8kWNXs0SEm1rd0WtH4SBmkrKRw2UpQgw==
X-Received: by 2002:adf:f006:0:b0:2c7:1a96:63f2 with SMTP id
 j6-20020adff006000000b002c71a9663f2mr15408153wro.3.1678437701194; 
 Fri, 10 Mar 2023 00:41:41 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 q6-20020a05600c46c600b003eb0d6f48f3sm2337036wmo.27.2023.03.10.00.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:41:40 -0800 (PST)
Date: Fri, 10 Mar 2023 03:41:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230310034101-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <20230217051158-mutt-send-email-mst@kernel.org>
 <Y+92c9us3HVjO2Zq@nvidia.com>
 <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org,
 Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, joro@8bytes.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
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

On Mon, Feb 20, 2023 at 10:37:18AM +0800, Jason Wang wrote:
> On Fri, Feb 17, 2023 at 8:43 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 05:12:29AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
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
> > > Absolutely but when is that happening?
> >
> > Don't know, I think it has to come from the VDPA maintainers, Nicolin
> > made some drafts but wasn't able to get it beyond that.
> 
> Cindy (cced) will carry on the work.
> 
> Thanks

Hmm didn't see anything yet. Nanyong Sun maybe you can take a look?

> >
> > Please have people who need more iommu platform enablement to pick it
> > up instead of merging hacks like this..
> >
> > We are very close to having nested translation on ARM so anyone who is
> > serious about VDPA on ARM is going to need iommufd anyhow.
> >
> > Jason
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
