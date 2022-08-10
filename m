Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6812CC00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 17:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E506540A06;
	Wed, 10 Aug 2022 17:12:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E506540A06
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZLkrW5b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Psy9Mv6uyUqW; Wed, 10 Aug 2022 17:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C90BB408F8;
	Wed, 10 Aug 2022 17:12:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C90BB408F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83C10C0033;
	Wed, 10 Aug 2022 17:12:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BFFFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35A4E8174C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:12:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35A4E8174C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZLkrW5b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id damMVEceyev6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:12:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D08CC80BA6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D08CC80BA6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660151548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=776twr5Jg1KyTMZYT0YxuTw54U7R0P5lUZ7vp5Zq9rw=;
 b=NZLkrW5bS1Mz210clQH5nbYOyKVzGwc8cuuYNnN8jVdv6IuEHgn18sP7frTpSv8osoeCMf
 5svbHw/9dutLLtTE7vJkOXDZpfKGa+sriiMfaCq5wl8ek6KMOc5RpUCf7vw8CVg9T9JUvL
 a49yC7tcZh6LIlNumkWJLZyjw3WfObc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-r0hATAL2POqy48So4ZTw7g-1; Wed, 10 Aug 2022 13:12:27 -0400
X-MC-Unique: r0hATAL2POqy48So4ZTw7g-1
Received: by mail-ed1-f71.google.com with SMTP id
 t13-20020a056402524d00b0043db1fbefdeso9550498edd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 10:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=776twr5Jg1KyTMZYT0YxuTw54U7R0P5lUZ7vp5Zq9rw=;
 b=iBqY/pA7YtokdJvwB5VWVZGyQoiPqqVqRI+2TVEacXnj85mNZYjNOgmjBPeTu1y7c+
 OJ63o9kYkCwOa0qmgIy3K/gG4b4QHvNy/xVUEblz/1vsxYW43vxw16Hl3Wp1LhopGV1h
 AJIEhwPtTFp7dK9TlfyDKHWwKKtBBRvgxrInpz/9tpI7pdMUaQ6FjyKCRMrKtnLfCWEH
 /E43U3mvZow7bGjDrOmYjkzlxKWF//D/Yv8BVp7Awdr7uYcRT6YzfIhe5zK4JvlknbkI
 yarQB36kN0bHMWHktxhjhyWgw6eGLHoAIRTmq3IuUhx/RLeohbl6w54pOoswcLKmP1+M
 xZIQ==
X-Gm-Message-State: ACgBeo2eSf7eECH+4sKoidTkQ8AgZO+A5IfClgAXFgdSJH31OPGmcNhv
 nPbOmt0gjEWjF3odpk6y+a17GIn0Bu5rzb8TD4GoQcWycd8JfuoAvRytYkG886jipAc7Eyi0a+9
 F+6NE+hnNI1rIGurbO+qS0OX6JMXz0N53nyuY+YpCmw==
X-Received: by 2002:a05:6402:1d54:b0:43d:280c:f25b with SMTP id
 dz20-20020a0564021d5400b0043d280cf25bmr27857012edb.379.1660151546259; 
 Wed, 10 Aug 2022 10:12:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5d0CkKoajC2mXlJEoK2GfTagzlzm5X0hYWieMFHlQX3qqaTldrBCYKIYekWfg+1a6p49x0Lg==
X-Received: by 2002:a05:6402:1d54:b0:43d:280c:f25b with SMTP id
 dz20-20020a0564021d5400b0043d280cf25bmr27856996edb.379.1660151546088; 
 Wed, 10 Aug 2022 10:12:26 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 20-20020a170906309400b00730fd9ccf84sm2514268ejv.90.2022.08.10.10.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 10:12:25 -0700 (PDT)
Date: Wed, 10 Aug 2022 13:12:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220810131209-mutt-send-email-mst@kernel.org>
References: <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
 <20220810050219-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810120440-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548173DD936EF45B07C157D7DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810125749-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811BD79FAFFAFF38231D38DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811BD79FAFFAFF38231D38DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Wed, Aug 10, 2022 at 05:06:33PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, August 10, 2022 12:59 PM
> > 
> > On Wed, Aug 10, 2022 at 04:22:41PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, August 10, 2022 12:05 PM
> > > >
> > > > On Wed, Aug 10, 2022 at 04:00:08PM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Wednesday, August 10, 2022 5:03 AM
> > > > > > > >
> > > > > > > > Should we make this depend on the vq reset ability maybe?
> > > > > > >
> > > > > > > The advantage of this is to keep TX working. Or we can use
> > > > > > > device reset as a fallback if there's no vq reset.
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Device reset is really annoying in that it loses all the state:
> > > > > > rx filters etc etc.
> > > > >
> > > > > The elegant solution is let driver tell the new mtu to the device.
> > > > > One way to do so is by using existing ctrl vq.
> > > >
> > > > That will need a new feature bit.
> > > >
> > > Yes. ctrl vq can tell what all configuration does it allow. :) Or you
> > > prefer feature bit?
> > 
> > We did feature bits for this in the past.
> > 
> Ok. Will try to draft the update for future.
> 
> Gavin should repost the patch to address comments unrelated to this future bit anyway.
> Right?

Right.

> > > > > If merged buffer is done, and new mtu is > minimum posting size,
> > > > > no need
> > > > to undergo vq reset.
> > > > > If merged buffer is not done, and buffer posted are smaller than
> > > > > new mtu,
> > > > undergo vq reset optionally.
> > > >
> > > > This can be done with or without sending mtu to device.
> > > Yes, telling mtu to device helps device to optimize and adhere to the spec
> > line " The device MUST NOT pass received packets that exceed mtu" in
> > section 5.1.4.1.
> > 
> > Again, that line refers to \field{mtu} which is the max mtu supported,
> > irrespective to anything driver does.
> > 
> > --
> > MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
