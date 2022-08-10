Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E65AC00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 07:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA2E440131;
	Wed, 10 Aug 2022 07:00:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA2E440131
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S/YoPTxQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDZXMeCjYXQU; Wed, 10 Aug 2022 07:00:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 52BE140114;
	Wed, 10 Aug 2022 07:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52BE140114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 143FAC0032;
	Wed, 10 Aug 2022 07:00:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42A60C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 07:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07A4D81570
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 07:00:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07A4D81570
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=S/YoPTxQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AMIoT9k_Vy0d
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 07:00:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 134DC814BA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 134DC814BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660114810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OXjUuQ9m8c9HJ323cmyTo7NXW9w0KcJ99meBtD3+WqI=;
 b=S/YoPTxQTSpDapnsKY/FMOudBM0xWEpa+neqNjSeRQPJM9t1FY7OMY2llGnDcWQvwbWPI4
 uNqslaUgsK6HRMuEtFMDta1UwFBjcm2/qwQ7m2NMSTzEBw0IKnxBs2k30Vcnwr2cKkxiwl
 u4xZHlaXjMixmj2JD21woFbAK9fd9qs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-ddpr_FkoM3KhJ7QRBcTQpw-1; Wed, 10 Aug 2022 03:00:09 -0400
X-MC-Unique: ddpr_FkoM3KhJ7QRBcTQpw-1
Received: by mail-lj1-f199.google.com with SMTP id
 d4-20020a2e9284000000b0025e0f56d216so4074476ljh.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 00:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=OXjUuQ9m8c9HJ323cmyTo7NXW9w0KcJ99meBtD3+WqI=;
 b=wYOQw2NEbeoQrrMRiSFE/7k++N60ejPiPiA0OJ/e7IkRz7TcuvFh/6x2d5hxV3BuC4
 xhpDzEjCnmJmDTRKLYdY1qgmff4ncRgqWcz9N0B0V0mRcl0XNWoxmBGj+DQUj27F4PMD
 b8/TPXLOk00X1ugBQcsf1mWqQ6dBFDRh4SkU+DrGf6YZp7pRuKVRPAVcJk3v3SaZ+uwb
 EghBjiUN2GaZjl8HmLLCdXo9h81ZJlF6TMCjsDwlEXGgjzSLecF7kYmMTmDezwv7XpfM
 0wWxQ94U9yTH1MXPI0lLAUROT0LTPEDaSEj4BrP1onw5w7KfGIKOnE02sdkKy7EGoDqy
 pBzQ==
X-Gm-Message-State: ACgBeo2PDgtRtBeS9/3x9wrRC7YFUKu3AMJB9nYD/RITXb4Y0nLfx5yS
 Wd36iClb4OuNTfFrdpTalZPvdIXDXl8zXsf8KqtwYEe+zh5YEB5E8dQWbEL2CsQG5y87xq//lzh
 JX33PegEAhQC+LhBnOmTRrggZ0EIQEA/oFZKiDABVyw+G31r7h3nQXtuZsA==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr8651871lfa.124.1660114808089; 
 Wed, 10 Aug 2022 00:00:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6SIugLw4g9xgMbTLAMe9zWn2heMWf5FM376RdX9270HXX6WfXFJOgs3NFj5QiY0X1Jm6fksqAsI4xe6N8WIHc=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr8651846lfa.124.1660114806803; Wed, 10
 Aug 2022 00:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220810021427-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Aug 2022 14:59:55 +0800
Message-ID: <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, Aug 10, 2022 at 2:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 10, 2022 at 02:14:07AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 09, 2022 at 04:24:23PM -0700, Si-Wei Liu wrote:
> > >
> > >
> > > On 8/9/2022 3:49 PM, Parav Pandit wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Tuesday, August 9, 2022 6:26 PM
> > > > > To: Parav Pandit <parav@nvidia.com>
> > > > > Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
> > > > > <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
> > > > > Stephen <stephen@networkplumber.org>; davem
> > > > > <davem@davemloft.net>; virtualization <virtualization@lists.linux-
> > > > > foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
> > > > > jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
> > > > > kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gavi
> > > > > Teitz <gavi@nvidia.com>
> > > > > Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length for
> > > > > big packets
> > > > >
> > > > > On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Sent: Tuesday, August 9, 2022 5:38 PM
> > > > > > [..]
> > > > > > > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > > > > > > which case the receive buffer will be reduced to fit the 1500B
> > > > > > > > > payload size when mtu is lowered down to 1500 from 9000.
> > > > > > > > How? Driver reduced the mXu to 1500, say it is improved to post
> > > > > > > > buffers of
> > > > > > > 1500 bytes.
> > > > > > > > Device doesn't know about it because mtu in config space is RO field.
> > > > > > > > Device keep dropping 9K packets because buffers posted are 1500
> > > > > bytes.
> > > > > > > > This is because device follows the spec " The device MUST NOT pass
> > > > > > > received packets that exceed mtu".
> > > > > > >
> > > > > > >
> > > > > > > The "mtu" here is the device config field, which is
> > > > > > >
> > > > > > >          /* Default maximum transmit unit advice */
> > > > > > >
> > > > > > It is the field from struct virtio_net_config.mtu. right?
> > > > > > This is RO field for driver.
> > > > > >
> > > > > > > there is no guarantee device will not get a bigger packet.
> > > > > > Right. That is what I also hinted.
> > > > > > Hence, allocating buffers worth upto mtu is safer.
> > > > > yes
> > > > >
> > > > > > When user overrides it, driver can be further optimized to honor such new
> > > > > value on rx buffer posting.
> > > > >
> > > > > no, not without a feature bit promising device won't get wedged.
> > > > >
> > > > I mean to say as_it_stands today, driver can decide to post smaller buffers with larger mtu.
> > > > Why device should be affected with it?
> > > > ( I am not proposing such weird configuration but asking for sake of correctness).
> > > I am also confused how the device can be wedged in this case.
> >
> > Yea sorry. I misunderstood the code. It can't be.
>
> Here's a problem as I see it. Let's say we reduce mtu.
> Small buffers are added. Now we increase mtu.
> Device will drop all packets until small buffers are consumed.
>
> Should we make this depend on the vq reset ability maybe?

The advantage of this is to keep TX working. Or we can use device
reset as a fallback if there's no vq reset.

Thanks


>
> > --
> > MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
