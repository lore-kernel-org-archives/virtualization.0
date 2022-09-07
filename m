Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83ABC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 14:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 630034156A;
	Wed,  7 Sep 2022 14:40:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 630034156A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gutEx6zY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qB4ryK_06gzi; Wed,  7 Sep 2022 14:40:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A39B1410E0;
	Wed,  7 Sep 2022 14:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A39B1410E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EA7DC0033;
	Wed,  7 Sep 2022 14:40:31 +0000 (UTC)
Received: from smtp1.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe97:d076])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBF49C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A55FC81415
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:40:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A55FC81415
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gutEx6zY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwHzuadWDbS2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:40:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78EBD81414
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78EBD81414
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662561626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1I+mmxEc4W8pgNyOHb25c63UJY3eA7dquqzLpsq3wXo=;
 b=gutEx6zYs12HFQfLAO/MViO1GakbJwHoovOnK71WttsPKPMy2TgnjJYkdgQk/sD9HJw76p
 gXhdm32z0DssdaZTvygTgZ+YRXT5iCvQRPw/3ZTcY7r/TV5f6NehvwEsG8Cu0I1RbJY/+2
 fJWEb1Lwz9pfrxiePn+U/8UU5xz1H+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-314-5-az-9fBPKKWmgZynldqbg-1; Wed, 07 Sep 2022 10:40:20 -0400
X-MC-Unique: 5-az-9fBPKKWmgZynldqbg-1
Received: by mail-wr1-f70.google.com with SMTP id
 j12-20020adfff8c000000b002265dcdfad7so3635213wrr.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 07:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=1I+mmxEc4W8pgNyOHb25c63UJY3eA7dquqzLpsq3wXo=;
 b=JKKJb0I7YCgowfUV2PMP+vYvKXd4I3XQZQw9nJ9wTUGVlvEGYWUG3YTLZt+FBVVZlH
 n3M7f+WlaBuntZSgjLtzeiI+YQW8cXCZruqopFlokSbHzYQxmnkIlg9+Zqvg26GTVqhe
 NQJzY/Gl55w6f4gAg6F9JTxVGU22JkgDw7sidPtNPjQO39l7pIO6vQP9GvbQ+34GUBfg
 8eMcnUqThl1BJR9wLcBZI9gRkDp9oWjLK5sFnzEYxilzedBeppZ6IE956fqV0XCOvLTj
 wrkVmL3/8bAOMenqRcAJlG0/udMW96jEVqlg5MSQWZMVc+XRyHPWVDL6J/VgEudH4Ndh
 CxUA==
X-Gm-Message-State: ACgBeo0ISouR6ZNREKRf29vFNz8dvTb9KZaLGctN1CRBEFzjIQ8OL6Jn
 Ed4DL7KIH4jWlxAcs09nP6a+jfXbsTaxe9vIJ+7oMo8DhRY4OKydA0ekTPx0ym0tZAxdvWQPqxz
 ag6RGsu1s4Qq9h4vJcBdg9avAWatnS2XduDWYMtO4Ig==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id
 10-20020a5d47aa000000b00226dbf6680cmr2325761wrb.581.1662561618396; 
 Wed, 07 Sep 2022 07:40:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ar7DT/A/B1M/OnVG85xAlKMimAFPyKe5R4Ua4FXozjUSRQVqhm4XYKvyRiC8+NGb64xiXtQ==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id
 10-20020a5d47aa000000b00226dbf6680cmr2325743wrb.581.1662561618193; 
 Wed, 07 Sep 2022 07:40:18 -0700 (PDT)
Received: from redhat.com ([2.52.135.118]) by smtp.gmail.com with ESMTPSA id
 i4-20020a05600c354400b003a2f6367049sm21410320wmq.48.2022.09.07.07.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 07:40:17 -0700 (PDT)
Date: Wed, 7 Sep 2022 10:40:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220907103420-mutt-send-email-mst@kernel.org>
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
 <20220907052317-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Wed, Sep 07, 2022 at 02:33:02PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 10:30 AM
> 
> [..]
> > > > actually how does this waste space? Is this because your device does
> > > > not have INDIRECT?
> > > VQ is 256 entries deep.
> > > Driver posted total of 256 descriptors.
> > > Each descriptor points to a page of 4K.
> > > These descriptors are chained as 4K * 16.
> > 
> > So without indirect then? with indirect each descriptor can point to 16
> > entries.
> > 
> With indirect, can it post 256 * 16 size buffers even though vq depth is 256 entries?
> I recall that total number of descriptors with direct/indirect descriptors is limited to vq depth.


> Was there some recent clarification occurred in the spec to clarify this?


This would make INDIRECT completely pointless.  So I don't think we ever
had such a limitation.
The only thing that comes to mind is this:

	A driver MUST NOT create a descriptor chain longer than the Queue Size of
	the device.

but this limits individual chain length not the total length
of all chains.

We have an open bug that we forgot to include this requirement
in the packed ring documentation.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
