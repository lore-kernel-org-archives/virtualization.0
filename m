Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57370C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 06:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C64DB405E7;
	Wed, 10 Aug 2022 06:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C64DB405E7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N3lkdhKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pHt1KvumKI6q; Wed, 10 Aug 2022 06:14:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C332740866;
	Wed, 10 Aug 2022 06:14:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C332740866
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86923C0032;
	Wed, 10 Aug 2022 06:14:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF8EEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9820A60BCA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:14:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9820A60BCA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N3lkdhKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dQd-PFhgyppK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:14:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C233360A97
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C233360A97
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660112051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yyGqrTeUjbEq5oVAvrqcno6VTtO7DE94/y8HFO9BbOQ=;
 b=N3lkdhKzIFDInR4wLBeJbkYKigBbmi83srXNUYX9tnvNq5vM+mV2uzChDA7lS7uZk3lwbL
 WqElIDa6KmnIGCk/T2rb3+eE4hhSnOjRWGudOJ3rAXZgYgQH2wqRCcVuRjS8wbM8IxlykI
 hh2OxMZkNpaU8EU3aicucvgAN0BrXk4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-D0LTIzDqMAirVyr7iUgGJg-1; Wed, 10 Aug 2022 02:14:08 -0400
X-MC-Unique: D0LTIzDqMAirVyr7iUgGJg-1
Received: by mail-ed1-f72.google.com with SMTP id
 w5-20020a05640234c500b0043dda025648so8589295edc.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 23:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=yyGqrTeUjbEq5oVAvrqcno6VTtO7DE94/y8HFO9BbOQ=;
 b=h3xYlVfHxSwd9BRN92VCh4LUwLbj6d2Hujate85BEPIqGHMzl9+5eLRloEkV3MQWYh
 Rb4wW+xR9gtIXC2C897nQiFUTwIJ53bmbaBJH9Ud+RLYg6qXN2aCzrzpQWBfZMmMrgrF
 FU2xkxHTUXMeHdDeYgxeUsKgflDNh4RY7Pf2NqDzMG2HdQuUFVRKbs/XNK5vFFCN9mQQ
 hgH9id/aVOREQMYy7OIVkS7pQTDHRrry/HiiV/eRRj77oaD8BiMulU/B9TU/LdGU/8bT
 KEwdeXdBAR7MuQ8LipVaYYg+Gvtx51GAiL7O/NHOt6EmqEVRMJHLUwW6VHY8MaGxN9xX
 fGqQ==
X-Gm-Message-State: ACgBeo1/OHoSr+Z0d5HNLvhoxXetDgcFZkY11qft/BLr9cFfOYYdFRoh
 Ky+SyKrQs+Pw7LhNxlIpHxlTCG7+zvGp8xuyIIZf3cWAh5o/vAirwmk0olhQqKZ9/YLzd9W4VPq
 fj8fcvH70XY/3vMf+8akdi0CIklnwkbgliTZMmLU2BQ==
X-Received: by 2002:a17:907:2894:b0:730:df55:b65f with SMTP id
 em20-20020a170907289400b00730df55b65fmr17388908ejc.138.1660112047194; 
 Tue, 09 Aug 2022 23:14:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7brru2WUtzdwctVjTD77n2rOrgnLCtsyCoiicE06HEfip4uvP6OqV5zFcsl+78Nguf820Xog==
X-Received: by 2002:a17:907:2894:b0:730:df55:b65f with SMTP id
 em20-20020a170907289400b00730df55b65fmr17388886ejc.138.1660112046984; 
 Tue, 09 Aug 2022 23:14:06 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 dm13-20020a05640222cd00b0043cb1a83c9fsm7226612edb.71.2022.08.09.23.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 23:14:05 -0700 (PDT)
Date: Wed, 10 Aug 2022 02:14:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220810021320-mutt-send-email-mst@kernel.org>
References: <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
MIME-Version: 1.0
In-Reply-To: <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
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

On Tue, Aug 09, 2022 at 04:24:23PM -0700, Si-Wei Liu wrote:
> 
> 
> On 8/9/2022 3:49 PM, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, August 9, 2022 6:26 PM
> > > To: Parav Pandit <parav@nvidia.com>
> > > Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
> > > <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
> > > Stephen <stephen@networkplumber.org>; davem
> > > <davem@davemloft.net>; virtualization <virtualization@lists.linux-
> > > foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
> > > jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
> > > kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gavi
> > > Teitz <gavi@nvidia.com>
> > > Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length for
> > > big packets
> > > 
> > > On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Tuesday, August 9, 2022 5:38 PM
> > > > [..]
> > > > > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > > > > which case the receive buffer will be reduced to fit the 1500B
> > > > > > > payload size when mtu is lowered down to 1500 from 9000.
> > > > > > How? Driver reduced the mXu to 1500, say it is improved to post
> > > > > > buffers of
> > > > > 1500 bytes.
> > > > > > Device doesn't know about it because mtu in config space is RO field.
> > > > > > Device keep dropping 9K packets because buffers posted are 1500
> > > bytes.
> > > > > > This is because device follows the spec " The device MUST NOT pass
> > > > > received packets that exceed mtu".
> > > > > 
> > > > > 
> > > > > The "mtu" here is the device config field, which is
> > > > > 
> > > > >          /* Default maximum transmit unit advice */
> > > > > 
> > > > It is the field from struct virtio_net_config.mtu. right?
> > > > This is RO field for driver.
> > > > 
> > > > > there is no guarantee device will not get a bigger packet.
> > > > Right. That is what I also hinted.
> > > > Hence, allocating buffers worth upto mtu is safer.
> > > yes
> > > 
> > > > When user overrides it, driver can be further optimized to honor such new
> > > value on rx buffer posting.
> > > 
> > > no, not without a feature bit promising device won't get wedged.
> > > 
> > I mean to say as_it_stands today, driver can decide to post smaller buffers with larger mtu.
> > Why device should be affected with it?
> > ( I am not proposing such weird configuration but asking for sake of correctness).
> I am also confused how the device can be wedged in this case.

Yea sorry. I misunderstood the code. It can't be.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
