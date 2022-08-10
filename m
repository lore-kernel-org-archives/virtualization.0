Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5BFC00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 16:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9310F4093B;
	Wed, 10 Aug 2022 16:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9310F4093B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bAdy/6TT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WWqTYKERHhlB; Wed, 10 Aug 2022 16:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 24F4140150;
	Wed, 10 Aug 2022 16:05:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24F4140150
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3E78C0032;
	Wed, 10 Aug 2022 16:05:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A933C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E734D41713
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E734D41713
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bAdy/6TT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iw8GBuPXrOsF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D98041601
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D98041601
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660147526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QtE6vGp28+RYGOkWwNpRFixCfKx0Nidpjc/QDGLCFvM=;
 b=bAdy/6TTyMIL8UbLPMg6U+6EvRgiHh7hzJrLdo4tx9Ue5yLjD+ZoKLdonuw1MH6seJYYoM
 HQfvxfyuMZvvAe8yMpOxOR+2/BPgNXCU8S6MyNHAqfYOBuXTt9K3MEQg6DCIR4KoGNlZ7d
 GHIq7Mi9hOYWoBjj3wMTRbeh2lSlg2Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-P7G-FXpDPZGRXAY9ZNiuTA-1; Wed, 10 Aug 2022 12:05:24 -0400
X-MC-Unique: P7G-FXpDPZGRXAY9ZNiuTA-1
Received: by mail-wr1-f70.google.com with SMTP id
 t12-20020adfba4c000000b0021e7440666bso2362249wrg.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=QtE6vGp28+RYGOkWwNpRFixCfKx0Nidpjc/QDGLCFvM=;
 b=RiLM6CbJ3o/784zqHZT8tzdeWmbAvQFh1tja4+dDqY8I7OX42AxyPfQu20wPShySiQ
 uKaef7mHTpd5QvH0qoTpcIdMz5UmSu3NMQHwqWtxiORHged6TwOCE8ttjuffyCi6wBl5
 YhH+TEC9h1GtgWQ9D1Y/Oeg0Kzb3V2MnhNUfAuMk2lUsZAsHHHoZiO7wERSjMrRaj+LU
 wkm/BBj511LfXqY54CwMr6cYsa5KLOWJZgtCgU/IioqUpmSG4SlzIEXKo+Z2CUPM7blP
 jkzw2Nx0RE6uzB5jHVyZ3MkjV6DzAY6yKG3JT+gQvEKUU62J5tJmA5haJrI2U4ulT0k+
 TC4g==
X-Gm-Message-State: ACgBeo0ZKf1tOJCwhn1m+yScgYyuGrQKlhmPcXl2/bIEGncViad+YxZn
 KQb9RcFrdR/xD9uxdtFmpcgYlP8+7x4Ex/axs3xwgU5WdefguvOSQHWvMovETdU31M/9dziVnfM
 rmjbYYPVcWsBs9lgQNBwG76oLw969tPp9xTUBwntrAg==
X-Received: by 2002:a05:600c:3ac3:b0:3a4:f1ff:b31a with SMTP id
 d3-20020a05600c3ac300b003a4f1ffb31amr2958152wms.13.1660147523474; 
 Wed, 10 Aug 2022 09:05:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5nXHDi0T9tDU+W3Mir0bBMFktlJkjJxz/5RrMr0WDCXC/qFvr1XPDBkuXQgk896Nh1C8o3Wg==
X-Received: by 2002:a05:600c:3ac3:b0:3a4:f1ff:b31a with SMTP id
 d3-20020a05600c3ac300b003a4f1ffb31amr2958129wms.13.1660147523250; 
 Wed, 10 Aug 2022 09:05:23 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 e12-20020adfa44c000000b0021e5cc26dd0sm16395226wra.62.2022.08.10.09.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 09:05:22 -0700 (PDT)
Date: Wed, 10 Aug 2022 12:05:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220810120440-mutt-send-email-mst@kernel.org>
References: <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
 <20220810050219-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Wed, Aug 10, 2022 at 04:00:08PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, August 10, 2022 5:03 AM
> > > >
> > > > Should we make this depend on the vq reset ability maybe?
> > >
> > > The advantage of this is to keep TX working. Or we can use device
> > > reset as a fallback if there's no vq reset.
> > >
> > > Thanks
> > 
> > Device reset is really annoying in that it loses all the state:
> > rx filters etc etc.
> 
> The elegant solution is let driver tell the new mtu to the device.
> One way to do so is by using existing ctrl vq.

That will need a new feature bit.

> If merged buffer is done, and new mtu is > minimum posting size, no need to undergo vq reset.
> If merged buffer is not done, and buffer posted are smaller than new mtu, undergo vq reset optionally.

This can be done with or without sending mtu to device.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
