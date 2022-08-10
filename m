Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55770C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 16:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5E8761162;
	Wed, 10 Aug 2022 16:59:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5E8761162
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TMpvE4El
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3tMfnpDPOfg; Wed, 10 Aug 2022 16:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C43A610EC;
	Wed, 10 Aug 2022 16:59:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C43A610EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D45AC0032;
	Wed, 10 Aug 2022 16:59:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BC0EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDAE640C5A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDAE640C5A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TMpvE4El
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWBSfD8TnqIV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:59:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE18640C81
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE18640C81
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660150740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWLIOo6N2m7kusuNkuJuS38uTn2r5CpY5dfnwm5jexY=;
 b=TMpvE4ElFzGUpfviaHFys6XTLMFoAwgiBx4LS+ybSFthX5Rn8oawJqp6CtE+EMfLvU2rlj
 KPbETljTfKRaxVV1i+xh4uBFMqY8ZOFn86gPTSZbm7krLacUgbLPpbJ9w6E0nViS8lDEXE
 pIs+vYaN0N5vUEjVyqS7Av5Uxp8ZS2k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-IL1wKzMtO3C6byUuCrEGAQ-1; Wed, 10 Aug 2022 12:58:59 -0400
X-MC-Unique: IL1wKzMtO3C6byUuCrEGAQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 gn23-20020a1709070d1700b0073094d0e02cso4542186ejc.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=qWLIOo6N2m7kusuNkuJuS38uTn2r5CpY5dfnwm5jexY=;
 b=XZDRpw9cBTNLvxM+dV38H/NITQw7OSke6z2WDLip73G4HzAAZL3WjTROtPYbE3L3cS
 NFjmg75I7shDPs4Y03v38gw1WjyrzPyCVe0Z32kw/6ZqpII1QMNivuTs8KE67LS/lBrj
 79omVwOZ2QXlyJhfe4iy8Y58UvUHniiHgOTLpjnKl/yYShlHInNdAkmTFVi8pbWEZC0+
 4WiW6qZTtci2qeP3ED/OMz0zJ6SBhYfYp71SZ2i+oHeZol1U+4N8fvVNT8/Lk1W4H0p5
 e5BaR0fb9652FPlkZmY3Qv2DL58m9ClKcEQZKFpCD8wK6fNgCwPyKBA2pCe1RVtqkxtw
 WWqQ==
X-Gm-Message-State: ACgBeo3T0LGVBGKgFinfJuh8uoP6BlIk0mMT5wa1/YTUznDbRCZrsfqY
 WcPYpc15zfXkA7SVkgYWu8pF6hi9kE7fJKGVNnx3Ch55wEe+4TJ9zW2v9Y6cAJ0GwGuZAQ0cFLx
 NXia5FP6EkLTJgYT4lPohJX/XvJFbk+HDInVkTAJBzQ==
X-Received: by 2002:a17:906:8a6d:b0:730:9cd5:6688 with SMTP id
 hy13-20020a1709068a6d00b007309cd56688mr20290551ejc.158.1660150738459; 
 Wed, 10 Aug 2022 09:58:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4IhcvwgY4YSAoZg5kjOgKf5bNdAlKjiSOA8FE46smqoMZIcgsKHQqBwcdCsXzbUrto23jT/w==
X-Received: by 2002:a17:906:8a6d:b0:730:9cd5:6688 with SMTP id
 hy13-20020a1709068a6d00b007309cd56688mr20290543ejc.158.1660150738254; 
 Wed, 10 Aug 2022 09:58:58 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 i6-20020aa7c9c6000000b0043d06d80d27sm7858753edt.86.2022.08.10.09.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 09:58:57 -0700 (PDT)
Date: Wed, 10 Aug 2022 12:58:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220810125749-mutt-send-email-mst@kernel.org>
References: <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
 <20220810050219-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810120440-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548173DD936EF45B07C157D7DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548173DD936EF45B07C157D7DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Wed, Aug 10, 2022 at 04:22:41PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, August 10, 2022 12:05 PM
> > 
> > On Wed, Aug 10, 2022 at 04:00:08PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, August 10, 2022 5:03 AM
> > > > > >
> > > > > > Should we make this depend on the vq reset ability maybe?
> > > > >
> > > > > The advantage of this is to keep TX working. Or we can use device
> > > > > reset as a fallback if there's no vq reset.
> > > > >
> > > > > Thanks
> > > >
> > > > Device reset is really annoying in that it loses all the state:
> > > > rx filters etc etc.
> > >
> > > The elegant solution is let driver tell the new mtu to the device.
> > > One way to do so is by using existing ctrl vq.
> > 
> > That will need a new feature bit.
> > 
> Yes. ctrl vq can tell what all configuration does it allow. :)
> Or you prefer feature bit?

We did feature bits for this in the past.

> > > If merged buffer is done, and new mtu is > minimum posting size, no need
> > to undergo vq reset.
> > > If merged buffer is not done, and buffer posted are smaller than new mtu,
> > undergo vq reset optionally.
> > 
> > This can be done with or without sending mtu to device.
> Yes, telling mtu to device helps device to optimize and adhere to the spec line " The device MUST NOT pass received packets that exceed mtu" in section 5.1.4.1.

Again, that line refers to \field{mtu} which is the max mtu supported,
irrespective to anything driver does.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
