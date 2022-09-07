Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CEDC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 18:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C547415DA;
	Wed,  7 Sep 2022 18:16:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C547415DA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=htYfHe9T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SAtFPE1XNULE; Wed,  7 Sep 2022 18:15:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74EFD410E5;
	Wed,  7 Sep 2022 18:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74EFD410E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49847C0033;
	Wed,  7 Sep 2022 18:15:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83DFBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 18:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 45CB960E38
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 18:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45CB960E38
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=htYfHe9T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FnMEACsHZyIl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 18:15:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E70EC60A70
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E70EC60A70
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662574552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwCc5OVCwETdEXk66j8frveKB6iuiO/N5iPy75mlvlU=;
 b=htYfHe9TqO3CA6LVht/vwRQY9hcjDRI3cC2v3EqsHE22ZJUhm+HimoCHNnnKOyW4ude/2H
 OxPM3IzB0IPOIIPejBCQ5COoGrgnvOJPVGeyZuX/SPOxolTRV6eUN2Ackcj5OIRZdDhXWT
 z567IPCTRlW+l8aCRG59EGefEcsupCg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-270-7z0yopeONeGVKXz_SDf2yQ-1; Wed, 07 Sep 2022 14:15:49 -0400
X-MC-Unique: 7z0yopeONeGVKXz_SDf2yQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 d11-20020adfc08b000000b002207555c1f6so3822745wrf.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 11:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=hwCc5OVCwETdEXk66j8frveKB6iuiO/N5iPy75mlvlU=;
 b=JTNhy5ZWYGchAo7sMuJ1VVdsLZPmyr5qVCJOX5r/Mq/Q/YYcWj4/yTlTl3+JrZIaMX
 s11MD9oseF6PjbdyIKbH6AYBLw2DGuwlcgaalMfXgleaN/08OAhMwv5PI9wOspq/ncBU
 1MRgR0yMRid4bA63Tj1cg9tl38a+Ll4z4xTnlSBH+IRKy7LwtTPOXAjczj6Qigvgt7/S
 1CJCyj+jOAhg9fOCqvFSYfpNJCuw6veCJZySTfgeLKk92ajsWHsEbiGlckuhnaP3qSV1
 Mv6FY/CtpQ8f+ywxrwgGVOT82xSscU2XoaRqLBTikZlTONVvT3s4HBx8S/miZJVqQZJN
 w/Fg==
X-Gm-Message-State: ACgBeo28XBKTJLHvm3UcPr5RnJ0ngq9OdmydvJrAkBPKuVKyDxnxuwAQ
 NjoBOi2Zg3fflta98+W6PXKTs3VSYF4V2NGzi837fMKO9DCvxuuUCiPMuZHna296ETSLvhIKKM4
 tq7PjL1JUIpXwiy9+LusFgik5p7h8R2j1EURMxpZy4g==
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr16669878wme.188.1662574548021; 
 Wed, 07 Sep 2022 11:15:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR60X15NZZusBD9CpMjdLM/YZyIbX5InDgusEWqWVRMHukuNbGQvE1G3ZdYkDEZA9weO2xn3Jg==
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr16669873wme.188.1662574547840; 
 Wed, 07 Sep 2022 11:15:47 -0700 (PDT)
Received: from redhat.com ([2.52.30.234]) by smtp.gmail.com with ESMTPSA id
 f25-20020a1c6a19000000b003a840690609sm29938661wmc.36.2022.09.07.11.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 11:15:47 -0700 (PDT)
Date: Wed, 7 Sep 2022 14:15:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220907141447-mutt-send-email-mst@kernel.org>
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
 <20220907052317-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

On Wed, Sep 07, 2022 at 04:12:47PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 10:40 AM
> > 
> > On Wed, Sep 07, 2022 at 02:33:02PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, September 7, 2022 10:30 AM
> > >
> > > [..]
> > > > > > actually how does this waste space? Is this because your device
> > > > > > does not have INDIRECT?
> > > > > VQ is 256 entries deep.
> > > > > Driver posted total of 256 descriptors.
> > > > > Each descriptor points to a page of 4K.
> > > > > These descriptors are chained as 4K * 16.
> > > >
> > > > So without indirect then? with indirect each descriptor can point to
> > > > 16 entries.
> > > >
> > > With indirect, can it post 256 * 16 size buffers even though vq depth is 256
> > entries?
> > > I recall that total number of descriptors with direct/indirect descriptors is
> > limited to vq depth.
> > 
> > 
> > > Was there some recent clarification occurred in the spec to clarify this?
> > 
> > 
> > This would make INDIRECT completely pointless.  So I don't think we ever
> > had such a limitation.
> > The only thing that comes to mind is this:
> > 
> > 	A driver MUST NOT create a descriptor chain longer than the Queue
> > Size of
> > 	the device.
> > 
> > but this limits individual chain length not the total length of all chains.
> > 
> Right.
> I double checked in virtqueue_add_split() which doesn't count table entries towards desc count of VQ for indirect case.
> 
> With indirect descriptors without this patch the situation is even worse with memory usage.
> Driver will allocate 64K * 256 = 16MB buffer per VQ, while needed (and used) buffer is only 2.3 Mbytes.

Yes. So just so we understand the reason for the performance improvement
is this because of memory usage? Or is this because device does not
have INDIRECT?

Thanks,

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
