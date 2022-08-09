Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A65BC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 22:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C62640370;
	Tue,  9 Aug 2022 22:26:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C62640370
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U9/BwQEL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jnpfa4iEL5nP; Tue,  9 Aug 2022 22:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E9483400E4;
	Tue,  9 Aug 2022 22:26:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9483400E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B526AC0033;
	Tue,  9 Aug 2022 22:26:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97645C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6880040364
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:26:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6880040364
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9b8iHyutqob
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:26:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7DE1400E4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7DE1400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660083958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mWRQW+6+3gn4zWwrItnvtI4BtzqWUljucoes/Rqi0ig=;
 b=U9/BwQEL/sSLtJ0CGYrdiU9bRDqCUJDA2I2E9vKwMmZEbx7rjc+VjQCpEyjqbVaUcNtBdP
 JXB0w487BZYYU2Gyo2TezBPeD13vuh9/VdgmHbg3eyyQg5y0U/CfdfCa4a9yDC5trRpImB
 3IVa53U3rNwg6AL2wlw8Qg2NTBhZ++E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-8bpf8E92OMKbEzVRvchOMQ-1; Tue, 09 Aug 2022 18:25:57 -0400
X-MC-Unique: 8bpf8E92OMKbEzVRvchOMQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 131-20020a1c0289000000b003a52a0c70b0so4833762wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 15:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=mWRQW+6+3gn4zWwrItnvtI4BtzqWUljucoes/Rqi0ig=;
 b=ax8hXvcnUnRJPUoq52hAbgY/rkgTRJ4zA0NWaO2CO9IxosouX3+7IdvQk5oWAQ7Otk
 HSZt58semoTFsJe3o+CHkZ0FU+LVOOcMlP0J14+ozbFoQxrMwXAg58NzysrZxmnu7ckS
 mDjG0jT9pvLCq1kycC36KBquB7KXAoPbQdN9k3KDrGRv9l9j+B2Uyv6fLIssWAREqDeH
 DWRQ6la0lIFS5+hUhawiJu8P3Sp88/Hk3qhUiRAOdlvA5AG5eR2tsu7hryLAiLEVATo+
 0Xl7JaEzLukTxgVCAN6nCsLjGmGzpI0CAb2/HssKxzR/ksnC9iAANkcySq4lwHj/ZTqY
 joFw==
X-Gm-Message-State: ACgBeo2+y4lh59kA5Tj9qYEsSQJRBCCz3/Cwdnjy1i5JCnIFWmma0ktU
 ffHD9ObXe+peyZZ4u7s6qusAV9c8tMNL97qxdtXckaP8i9HXXyplFAy4T6fCJUdZa78Zx5FI6wF
 AT3ZhQMa1Cn8oTgRaDhUq55bDdM+8TDsBnODN4ztwKQ==
X-Received: by 2002:a1c:7503:0:b0:3a3:2db1:d37e with SMTP id
 o3-20020a1c7503000000b003a32db1d37emr295114wmc.47.1660083956077; 
 Tue, 09 Aug 2022 15:25:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6DxywwcxuoqQcFLuHjz4O8URQKYaVVLoucQ2D3SAOyLppG1PLCfCIZ8KyVTf+YgHiSNj4g6Q==
X-Received: by 2002:a1c:7503:0:b0:3a3:2db1:d37e with SMTP id
 o3-20020a1c7503000000b003a32db1d37emr295096wmc.47.1660083955802; 
 Tue, 09 Aug 2022 15:25:55 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 i17-20020a05600011d100b0021e9d98bec4sm14425286wrx.88.2022.08.09.15.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 15:25:55 -0700 (PDT)
Date: Tue, 9 Aug 2022 18:25:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809182306-mutt-send-email-mst@kernel.org>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, August 9, 2022 5:38 PM
> 
> [..]
> > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > which case the receive buffer will be reduced to fit the 1500B
> > > > payload size when mtu is lowered down to 1500 from 9000.
> > > How? Driver reduced the mXu to 1500, say it is improved to post buffers of
> > 1500 bytes.
> > >
> > > Device doesn't know about it because mtu in config space is RO field.
> > > Device keep dropping 9K packets because buffers posted are 1500 bytes.
> > > This is because device follows the spec " The device MUST NOT pass
> > received packets that exceed mtu".
> > 
> > 
> > The "mtu" here is the device config field, which is
> > 
> >         /* Default maximum transmit unit advice */
> > 
> 
> It is the field from struct virtio_net_config.mtu. right?
> This is RO field for driver.
> 
> > there is no guarantee device will not get a bigger packet.
> Right. That is what I also hinted.
> Hence, allocating buffers worth upto mtu is safer.

yes

> When user overrides it, driver can be further optimized to honor such new value on rx buffer posting.

no, not without a feature bit promising device won't get wedged.

> > And there is no guarantee such a packet will be dropped as opposed to
> > wedging the device if userspace insists on adding smaller buffers.
> >
> If user space insists on small buffers, so be it.

If previously things worked, the "so be it" is a regression and blaming
users won't help us. 

> It only works when user exactly know what user is doing in the whole network.

If you want to claim this you need a new feature bit.

> When user prefers to override the device RO field, device is in the dark and things work on best effort basis.

Dropping packets is best effort. Getting stuck forever isn't, that's
a quality of implementation issue.

> This must be a reasonably advance user who has good knowledge of its network topology etc.
> 
> For such case, may be yes, driver should be further optimized.
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
