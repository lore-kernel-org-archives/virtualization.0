Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E394C25B07
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 17:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B1F4417D3;
	Wed, 10 Aug 2022 17:02:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B1F4417D3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EdHh9Omq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4p5cOIMF9HIX; Wed, 10 Aug 2022 17:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 12E9D41606;
	Wed, 10 Aug 2022 17:02:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12E9D41606
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4A4EC0032;
	Wed, 10 Aug 2022 17:02:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B434C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11E6A41781
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11E6A41781
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3M80iFv41z72
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:02:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E9A641606
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E9A641606
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660150949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bN8A2NeCZed0hwaZ6gn4lFwnCa8kSDGl71Ro5h6HX3k=;
 b=EdHh9Omq0nsNBYVB9LiPntDtntnh4Fb5ni0p1uYwhKaccLEkko6itGcSIfnDnbfz5gEwO4
 SlNKtFFAUN8HHJ6gK0Vi1ZRW/+ox3LG6AAK2uFWKejas/+k9gpB8LoVzxEcdvM173pqqIp
 Jtia8vM5rbmC5tHCmvplM9JbZNXGneg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-TecrJIY1PyusruQpHVFTwQ-1; Wed, 10 Aug 2022 13:02:26 -0400
X-MC-Unique: TecrJIY1PyusruQpHVFTwQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 r5-20020a1c4405000000b003a534ec2570so1341000wma.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 10:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=bN8A2NeCZed0hwaZ6gn4lFwnCa8kSDGl71Ro5h6HX3k=;
 b=ySWkBJmKK1KqokiYQc/I/zJ0bWHZzJ3qiHwp0jBlj74eds6WlFsFH5HLOGHm3SS9eB
 xdvePktohcjY+aA3zX6K0Op6T5WIKJC7z8GpeWesI5mMjmzRnkfdjjbdBzN6l5I0UzpG
 X1FDwBF7iUN9E42NdljM/Xo8GRAbp5d/GX8NAdLMx8z0A1v3b7X6SAVITZ6iX5qy1txa
 exmZkumYdXRMiysijAy5xFO+R8iNr9y6plasxABVUL16gzOnsYtJIlIX4b8qXlGl0Z9Z
 MyuWuT24OX9lgtiPCKZCUmU9CavWWmCcjlExXsNyj4t6//t8ceSJ69mQph/I9ASPCUnz
 8Jyg==
X-Gm-Message-State: ACgBeo0kFxDumKg4wPfrZYp3FKeWIYJ3R1UqirDc+VlzINcHlk9e1So9
 KoprPxUDXM8bpt/Lgbf5FVuDOzqD9eBHt+Q7iYzOXs2sK/7MW2g/h/n1OCcMXa7UgQfIOkQD8I/
 AVPAxfVFrpiu2UBF9X0jlt7KLdOJ3shLcg6mPOxOugw==
X-Received: by 2002:a05:6000:1a4e:b0:220:5e43:9843 with SMTP id
 t14-20020a0560001a4e00b002205e439843mr17225257wry.566.1660150945680; 
 Wed, 10 Aug 2022 10:02:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6kvOgJYxt78Opm8Q10sRwKyZqT+yN5hiNMIX2fFqSQBw837+gtJwPPPjw/nOBPLM69UdFSvA==
X-Received: by 2002:a05:6000:1a4e:b0:220:5e43:9843 with SMTP id
 t14-20020a0560001a4e00b002205e439843mr17225242wry.566.1660150945460; 
 Wed, 10 Aug 2022 10:02:25 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 n2-20020a5d6b82000000b0021e43b4edf0sm16252845wrx.20.2022.08.10.10.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 10:02:25 -0700 (PDT)
Date: Wed, 10 Aug 2022 13:02:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220810125935-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
 <20220810050219-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810120440-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548173DD936EF45B07C157D7DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810125749-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220810125749-mutt-send-email-mst@kernel.org>
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

On Wed, Aug 10, 2022 at 12:58:58PM -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 10, 2022 at 04:22:41PM +0000, Parav Pandit wrote:
> > 
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, August 10, 2022 12:05 PM
> > > 
> > > On Wed, Aug 10, 2022 at 04:00:08PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Wednesday, August 10, 2022 5:03 AM
> > > > > > >
> > > > > > > Should we make this depend on the vq reset ability maybe?
> > > > > >
> > > > > > The advantage of this is to keep TX working. Or we can use device
> > > > > > reset as a fallback if there's no vq reset.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Device reset is really annoying in that it loses all the state:
> > > > > rx filters etc etc.
> > > >
> > > > The elegant solution is let driver tell the new mtu to the device.
> > > > One way to do so is by using existing ctrl vq.
> > > 
> > > That will need a new feature bit.
> > > 
> > Yes. ctrl vq can tell what all configuration does it allow. :)
> > Or you prefer feature bit?
> 
> We did feature bits for this in the past.
> 
> > > > If merged buffer is done, and new mtu is > minimum posting size, no need
> > > to undergo vq reset.
> > > > If merged buffer is not done, and buffer posted are smaller than new mtu,
> > > undergo vq reset optionally.
> > > 
> > > This can be done with or without sending mtu to device.
> > Yes, telling mtu to device helps device to optimize and adhere to the spec line " The device MUST NOT pass received packets that exceed mtu" in section 5.1.4.1.
> 
> Again, that line refers to \field{mtu} which is the max mtu supported,
> irrespective to anything driver does.

BTW with any such ctrl vq interface we need to think how cases such as
increasing and decreasing MTU work.  The normal behaviour for linux
drivers is to limit this to when the link is down.  Which reminds me, we
do not have a command to bring link down, either.

> -- 
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
