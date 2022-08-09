Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAFDC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 23:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC7D94091F;
	Tue,  9 Aug 2022 23:00:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC7D94091F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WmstzEuU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OIwTx-ItEW4m; Tue,  9 Aug 2022 23:00:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0D0C404F7;
	Tue,  9 Aug 2022 23:00:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0D0C404F7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CC81C0033;
	Tue,  9 Aug 2022 23:00:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60EF1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31B2960F47
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:00:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31B2960F47
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WmstzEuU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PsaaZUDiMopO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:00:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1496060E2A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1496060E2A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660085999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WdN1PCCmzFmqOUUGd3iFnY3Ss4PEp01M/IinHaruQzA=;
 b=WmstzEuUUkSw948978Z9dpuU41Er2zFBZszpAjdivTEXva3UrRtyJ8Z6t9KJ3Ib0/D4PQZ
 WBsOmxSE7uVmBMtxFoT1KExsJXhkdeHaqHMFRGHeONlHIyU2O2izdJlHgTyMQkzrF8oW2V
 dKLVOv9DB/5KPY/iMyxWR8LpsN2ki1s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-_h3V84-DO5CYU5i0iRXS2g-1; Tue, 09 Aug 2022 18:59:56 -0400
X-MC-Unique: _h3V84-DO5CYU5i0iRXS2g-1
Received: by mail-ed1-f69.google.com with SMTP id
 o2-20020a056402438200b0043d552deb2aso8047924edc.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 15:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=WdN1PCCmzFmqOUUGd3iFnY3Ss4PEp01M/IinHaruQzA=;
 b=iD+arZMqPlAe4BvOpaBzqCHG47fdfXdaUKM5CcKvfRDVJhrBY0YEOfgdEsPQj29hHW
 exO7OA+QELvpwC7xsbqzV6KCjSoD+A7LdGpz9HOeBni0b66NlhQcco5ueRKFWq1el1Tg
 NO/PDTj68RuyL1cG9gwHO2qXnPZ8CPVKb44o+FXrvVEo3SPEeFOapRbM3TeANDR8Rbw4
 DCa7Ee4H9M2TPUJn7MpAdyFGbwIij7YPpS+hT37QhC2XqgbHjBiFEdtiqp6xZaAb+fbL
 SvUPmecS8h/wct0YmqYJudntosT6FWOiAWn8gPUBa8379np90l14fftHAQMNWNy0GzBG
 w76A==
X-Gm-Message-State: ACgBeo3vAD05VXeAH0DwwHSDQ+Ez7+ub84qYwt81WYxWe1nXNdhZL0Nf
 MQP/7tBhwupaEv0Nj/uoL1aPgAlCroyDIVTWNclQ4LSk5XbhOfkG5VN3+S4/J1J3Tg1adNNAag9
 WC0WbGk4sUDjT8dcYrt6i/cGrKR8FWA7pcepF/pPAYg==
X-Received: by 2002:a17:907:1dee:b0:730:b7d9:626 with SMTP id
 og46-20020a1709071dee00b00730b7d90626mr17762934ejc.135.1660085995648; 
 Tue, 09 Aug 2022 15:59:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5r1pz21iGyGZPF2WvyCM+v84pgqDj6vNv+NfsSdsv/GR1SmfTUWMtU/C8IDY2sKhc18c/K0A==
X-Received: by 2002:a17:907:1dee:b0:730:b7d9:626 with SMTP id
 og46-20020a1709071dee00b00730b7d90626mr17762919ejc.135.1660085995404; 
 Tue, 09 Aug 2022 15:59:55 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 c6-20020a1709060fc600b0072b592ee073sm1628193ejk.147.2022.08.09.15.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 15:59:54 -0700 (PDT)
Date: Tue, 9 Aug 2022 18:59:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809185747-mutt-send-email-mst@kernel.org>
References: <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Tue, Aug 09, 2022 at 10:49:48PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, August 9, 2022 6:26 PM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
> > <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
> > Stephen <stephen@networkplumber.org>; davem
> > <davem@davemloft.net>; virtualization <virtualization@lists.linux-
> > foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
> > jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
> > kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gavi
> > Teitz <gavi@nvidia.com>
> > Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length for
> > big packets
> > 
> > On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, August 9, 2022 5:38 PM
> > >
> > > [..]
> > > > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > > > which case the receive buffer will be reduced to fit the 1500B
> > > > > > payload size when mtu is lowered down to 1500 from 9000.
> > > > > How? Driver reduced the mXu to 1500, say it is improved to post
> > > > > buffers of
> > > > 1500 bytes.
> > > > >
> > > > > Device doesn't know about it because mtu in config space is RO field.
> > > > > Device keep dropping 9K packets because buffers posted are 1500
> > bytes.
> > > > > This is because device follows the spec " The device MUST NOT pass
> > > > received packets that exceed mtu".
> > > >
> > > >
> > > > The "mtu" here is the device config field, which is
> > > >
> > > >         /* Default maximum transmit unit advice */
> > > >
> > >
> > > It is the field from struct virtio_net_config.mtu. right?
> > > This is RO field for driver.
> > >
> > > > there is no guarantee device will not get a bigger packet.
> > > Right. That is what I also hinted.
> > > Hence, allocating buffers worth upto mtu is safer.
> > 
> > yes
> > 
> > > When user overrides it, driver can be further optimized to honor such new
> > value on rx buffer posting.
> > 
> > no, not without a feature bit promising device won't get wedged.
> > 
> I mean to say as_it_stands today, driver can decide to post smaller buffers with larger mtu.
> Why device should be affected with it?
> ( I am not proposing such weird configuration but asking for sake of correctness).

They just are because drivers did not do this.

> > > > And there is no guarantee such a packet will be dropped as opposed
> > > > to wedging the device if userspace insists on adding smaller buffers.
> > > >
> > > If user space insists on small buffers, so be it.
> > 
> > If previously things worked, the "so be it" is a regression and blaming users
> > won't help us.
> > 
> I am not suggesting above.
> This was Si-Wei's suggestion that somehow driver wants to post smaller buffers than the mtu because user knows what peer is doing.
> So may be driver can be extended to give more weight on user config.
> 
> > > It only works when user exactly know what user is doing in the whole
> > network.
> > 
> > If you want to claim this you need a new feature bit.
> > 
> Why is a new bit needed to tell device?
> User is doing something its own config mismatching the buffers and mtu.
> A solid use case hasn't emerged for this yet.
> 
> If user wants to modify the mtu, we should just make virtio_net_config.mtu as RW field using new feature bit.
> Is that what you mean?
> If so, yes, it makes things very neat where driver and device are aligned to each other, the way they are today.
> Only limitation is that its one-way. = device tells to driver.
> 
> > > When user prefers to override the device RO field, device is in the dark and
> > things work on best effort basis.
> > 
> > Dropping packets is best effort. Getting stuck forever isn't, that's a quality of
> > implementation issue.
> >
> Not sure, why things get stuck for ever. Maybe you have example to explain.
> I am mostly missing something.

I sent an explanation a bit earlier. It's more or less a bug.

> > > This must be a reasonably advance user who has good knowledge of its
> > network topology etc.
> > >
> > > For such case, may be yes, driver should be further optimized.
> > >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
