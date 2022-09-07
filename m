Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D1CC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 19:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6077E60E8A;
	Wed,  7 Sep 2022 19:11:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6077E60E8A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NC0YFNXs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dfge2YaSlE7f; Wed,  7 Sep 2022 19:11:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B884E60E57;
	Wed,  7 Sep 2022 19:11:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B884E60E57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 311ACC0032;
	Wed,  7 Sep 2022 19:11:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 042C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2D7F60E57
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:11:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2D7F60E57
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iz8QOlxltNQG
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:11:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54ED460C1E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54ED460C1E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662577901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/qj69XUPOcyLsjSAg4SPjsbFHmd3BOzkbohuB8c9bU=;
 b=NC0YFNXsT6B9DWbV3e9XIflHDXuv9K5lTfankKDI+9/v1OAH+G5r1L5zXfbPVlL9PNE/fZ
 y+4DdxuEJiJyQiDJja4LADarI9JsM3/1/aSzkLiTjG0Iqp//jzdQ14QpIlTSp/jh+1RhLi
 KSt7a3LVaEWVrz7G8eQrGGX+s1XxUxA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-145-TshjehDrOZe2x4Jv9D5Tcw-1; Wed, 07 Sep 2022 15:11:38 -0400
X-MC-Unique: TshjehDrOZe2x4Jv9D5Tcw-1
Received: by mail-wr1-f72.google.com with SMTP id
 s1-20020adf9781000000b002286cd81376so3312835wrb.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 12:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=u/qj69XUPOcyLsjSAg4SPjsbFHmd3BOzkbohuB8c9bU=;
 b=rfBgCPPnForAfphGI2qvi0ppDqGQLky80ft9CqEskYnMrw0ba6aJMTlHHm6bypmUyu
 0czZlOU7hwsEPErc4YSG4eIHbVrBFxXaOEW+qHPpDPfvVilmjxrlA6xSNOME5equc7ii
 4rDSx1fdu1vWeUnUq/DBIGs87ennGBadsbEfkBJjwSBmCjgq1ZDnBm8WffyWVhNRjE+D
 GZznNwZalS+8/HoyhrKH//eU9MKIjXgyjVy6beJ9NHft9lqikR3YZkX/hYc3agD3o02/
 q77SbcZzI57m4m5y/8KsCXNXoB7mp2E+fqh6uV1BQOevTNkr4IM+yDnXvY5webfrAl7p
 FxgQ==
X-Gm-Message-State: ACgBeo1l+Pw6vVefJ2+Zj70dDiiRL8Lxdkf3GjC0YVRUlA+Hxm40ch4q
 MBE++aaTcbeyr6NvnACTjvV0qYtKS9Hbe6mt/JISwPiYdRrSHSrNCH07bURiy2JI9lqgnCco3Yu
 5ZiKblQIzpiXMrx12A/4KMtKtorFh0JahKa2XIKOgUw==
X-Received: by 2002:adf:f543:0:b0:228:c692:127a with SMTP id
 j3-20020adff543000000b00228c692127amr3085534wrp.246.1662577897045; 
 Wed, 07 Sep 2022 12:11:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6d9AJ489TdJCGUgeCRPYhs8c3hJvWj8cdJQJMkw+jujrFv9ylSFbo6hqbQ/lpwXDQ/pngAVw==
X-Received: by 2002:adf:f543:0:b0:228:c692:127a with SMTP id
 j3-20020adff543000000b00228c692127amr3085517wrp.246.1662577896801; 
 Wed, 07 Sep 2022 12:11:36 -0700 (PDT)
Received: from redhat.com ([2.52.30.234]) by smtp.gmail.com with ESMTPSA id
 w3-20020a05600018c300b002206203ed3dsm19512739wrq.29.2022.09.07.12.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 12:11:36 -0700 (PDT)
Date: Wed, 7 Sep 2022 15:11:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220907151026-mutt-send-email-mst@kernel.org>
References: <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
 <20220907052317-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Wed, Sep 07, 2022 at 07:06:09PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 2:16 PM
> > 
> > On Wed, Sep 07, 2022 at 04:12:47PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, September 7, 2022 10:40 AM
> > > >
> > > > On Wed, Sep 07, 2022 at 02:33:02PM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Wednesday, September 7, 2022 10:30 AM
> > > > >
> > > > > [..]
> > > > > > > > actually how does this waste space? Is this because your
> > > > > > > > device does not have INDIRECT?
> > > > > > > VQ is 256 entries deep.
> > > > > > > Driver posted total of 256 descriptors.
> > > > > > > Each descriptor points to a page of 4K.
> > > > > > > These descriptors are chained as 4K * 16.
> > > > > >
> > > > > > So without indirect then? with indirect each descriptor can
> > > > > > point to
> > > > > > 16 entries.
> > > > > >
> > > > > With indirect, can it post 256 * 16 size buffers even though vq
> > > > > depth is 256
> > > > entries?
> > > > > I recall that total number of descriptors with direct/indirect
> > > > > descriptors is
> > > > limited to vq depth.
> > > >
> > > >
> > > > > Was there some recent clarification occurred in the spec to clarify this?
> > > >
> > > >
> > > > This would make INDIRECT completely pointless.  So I don't think we
> > > > ever had such a limitation.
> > > > The only thing that comes to mind is this:
> > > >
> > > > 	A driver MUST NOT create a descriptor chain longer than the Queue
> > > > Size of
> > > > 	the device.
> > > >
> > > > but this limits individual chain length not the total length of all chains.
> > > >
> > > Right.
> > > I double checked in virtqueue_add_split() which doesn't count table
> > entries towards desc count of VQ for indirect case.
> > >
> > > With indirect descriptors without this patch the situation is even worse
> > with memory usage.
> > > Driver will allocate 64K * 256 = 16MB buffer per VQ, while needed (and
> > used) buffer is only 2.3 Mbytes.
> > 
> > Yes. So just so we understand the reason for the performance improvement
> > is this because of memory usage? Or is this because device does not have
> > INDIRECT?
> 
> Because of shallow queue of 16 entries deep.

but why is the queue just 16 entries?
does the device not support indirect?

because with indirect you get 256 entries, with 16 s/g each.


> With driver turn around time to repost buffers, device is idle without any RQ buffers.
> With this improvement, device has 85 buffers instead of 16 to receive packets.
> 
> Enabling indirect in device can help at cost of 7x higher memory per VQ in the guest VM.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
