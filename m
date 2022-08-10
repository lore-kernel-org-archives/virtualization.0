Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714D3C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 06:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA2FA81BF4;
	Wed, 10 Aug 2022 06:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA2FA81BF4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hoi6MN01
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YLQwsUuHzGMi; Wed, 10 Aug 2022 06:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6689B81BD6;
	Wed, 10 Aug 2022 06:16:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6689B81BD6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D6D9C0032;
	Wed, 10 Aug 2022 06:16:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D46BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08D09415F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:16:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08D09415F4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hoi6MN01
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4D0UFghprDL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:15:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D918E415EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D918E415EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660112157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMtYWxTo8BJltZnjuTSTfy3plnYb7WIOBggIAwQjyJg=;
 b=Hoi6MN01GxVb1jq30qTX4Mlc0tOhfIW96/zVmGVRA5FUNOnln9tGmroVlSc2+A4ovfypKS
 YSc2ychE5N5WfVqnNh/TDvLruSXrmg8uhIWoVy0wbcCqtg8pUsxb3am1ymzkhK6+3BXanJ
 NQhjzXMY+pkekX/3gTeZ3GEcjdnWp84=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-kQ7wmaadOy-74fB5J-gC_A-1; Wed, 10 Aug 2022 02:15:56 -0400
X-MC-Unique: kQ7wmaadOy-74fB5J-gC_A-1
Received: by mail-ej1-f70.google.com with SMTP id
 gn23-20020a1709070d1700b0073094d0e02cso3950003ejc.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 23:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=XMtYWxTo8BJltZnjuTSTfy3plnYb7WIOBggIAwQjyJg=;
 b=8RHc8YTxyJ3kjnLRkoK+UlUlp5Fwd2MMd3w0IViB6PXqK5H4PQuxSg9fZs2M3M1jLd
 Snr/nQgFuwzRinPMkxWWBVVOwVx46tPwI3X+rZPeAvkFo1NHPRwH/gdAZExpeuQmGXNa
 qdHz6T61cdJXKI8ZgCIIkhk7bpaRbkf/YJ3ejQPF0H09+X+NzgTWgWrZCfXvjoaG+vVk
 oIU1ajkHAsKNlFLiUFqjMBls657XOQkbh+pOlCS2OX8mZoOhoFKM1tLAQ/j1IhWD7bYU
 FtZkQciz2VDATodlNiShuJEhTiI+A1cWD1428oUnKuO2y7dABGtmYMYswAtZKYohqb1p
 j90w==
X-Gm-Message-State: ACgBeo1YEvdINHZ8yHVvcH/oo6r2nKsagiuwa4ScyRRdYxluEPlPBxmt
 /CQHE/MTnlnHxxpvxB+VFdkE7vnVuf5YGM7PD3m3+sGg6sdtMAueTImLX/RSuRocHzKgwZICqA+
 vXC+cJr4Did9Xkay1XTPvoY3BT96o4NhL2WvnXIh9cw==
X-Received: by 2002:a50:fb13:0:b0:43c:ef2b:d29 with SMTP id
 d19-20020a50fb13000000b0043cef2b0d29mr25198550edq.378.1660112155028; 
 Tue, 09 Aug 2022 23:15:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4GsOICgkZcb8IGOu0GlXbTnD5PpFYGeHFu+NrxvqJRrBA2OGLvPNQIJNZHpwUc9aRm+zAwaA==
X-Received: by 2002:a50:fb13:0:b0:43c:ef2b:d29 with SMTP id
 d19-20020a50fb13000000b0043cef2b0d29mr25198532edq.378.1660112154860; 
 Tue, 09 Aug 2022 23:15:54 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 10-20020a170906210a00b00715a02874acsm1921095ejt.35.2022.08.09.23.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 23:15:54 -0700 (PDT)
Date: Wed, 10 Aug 2022 02:15:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220810021427-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <20220810021320-mutt-send-email-mst@kernel.org>
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

On Wed, Aug 10, 2022 at 02:14:07AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 09, 2022 at 04:24:23PM -0700, Si-Wei Liu wrote:
> > 
> > 
> > On 8/9/2022 3:49 PM, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, August 9, 2022 6:26 PM
> > > > To: Parav Pandit <parav@nvidia.com>
> > > > Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
> > > > <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
> > > > Stephen <stephen@networkplumber.org>; davem
> > > > <davem@davemloft.net>; virtualization <virtualization@lists.linux-
> > > > foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
> > > > jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
> > > > kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gavi
> > > > Teitz <gavi@nvidia.com>
> > > > Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length for
> > > > big packets
> > > > 
> > > > On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Tuesday, August 9, 2022 5:38 PM
> > > > > [..]
> > > > > > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > > > > > which case the receive buffer will be reduced to fit the 1500B
> > > > > > > > payload size when mtu is lowered down to 1500 from 9000.
> > > > > > > How? Driver reduced the mXu to 1500, say it is improved to post
> > > > > > > buffers of
> > > > > > 1500 bytes.
> > > > > > > Device doesn't know about it because mtu in config space is RO field.
> > > > > > > Device keep dropping 9K packets because buffers posted are 1500
> > > > bytes.
> > > > > > > This is because device follows the spec " The device MUST NOT pass
> > > > > > received packets that exceed mtu".
> > > > > > 
> > > > > > 
> > > > > > The "mtu" here is the device config field, which is
> > > > > > 
> > > > > >          /* Default maximum transmit unit advice */
> > > > > > 
> > > > > It is the field from struct virtio_net_config.mtu. right?
> > > > > This is RO field for driver.
> > > > > 
> > > > > > there is no guarantee device will not get a bigger packet.
> > > > > Right. That is what I also hinted.
> > > > > Hence, allocating buffers worth upto mtu is safer.
> > > > yes
> > > > 
> > > > > When user overrides it, driver can be further optimized to honor such new
> > > > value on rx buffer posting.
> > > > 
> > > > no, not without a feature bit promising device won't get wedged.
> > > > 
> > > I mean to say as_it_stands today, driver can decide to post smaller buffers with larger mtu.
> > > Why device should be affected with it?
> > > ( I am not proposing such weird configuration but asking for sake of correctness).
> > I am also confused how the device can be wedged in this case.
> 
> Yea sorry. I misunderstood the code. It can't be.

Here's a problem as I see it. Let's say we reduce mtu.
Small buffers are added. Now we increase mtu.
Device will drop all packets until small buffers are consumed.

Should we make this depend on the vq reset ability maybe?

> -- 
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
