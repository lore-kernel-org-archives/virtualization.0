Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5BBC433F5
	for <virtualization@archiver.kernel.org>; Mon, 20 Dec 2021 12:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C777340922;
	Mon, 20 Dec 2021 12:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uF0SaHoA-sUm; Mon, 20 Dec 2021 12:03:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 319E140892;
	Mon, 20 Dec 2021 12:03:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E12C1C002F;
	Mon, 20 Dec 2021 12:03:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6070C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 12:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1B5240892
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 12:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4bqeC63QCYQq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 12:03:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BCCD408A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640001786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KVbqaqKX4D74IoU7gZGZhJb64pFjSvVeEMSn+p05yzk=;
 b=AkdVhqeaAZUodOgTxGWOHzdTWw45cZNHjCtrpzz4nN4Zc1HWoyHE4WTOnQdN7FJiA4MH71
 4cxlqr2GuuM57PytahrakK3ybF3T2cUrxztqhKTm7Y8AkJF8zuBdsMNC602rP3qA1VR0A5
 aJnlrb2p9Yz0trh0CWlSKHou8y7aM4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-ii28H2fhPZeAORsXUPY1oA-1; Mon, 20 Dec 2021 07:03:03 -0500
X-MC-Unique: ii28H2fhPZeAORsXUPY1oA-1
Received: by mail-wm1-f70.google.com with SMTP id
 p22-20020a05600c1d9600b00345a25ea8cfso409428wms.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 04:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KVbqaqKX4D74IoU7gZGZhJb64pFjSvVeEMSn+p05yzk=;
 b=Ho55BjMUMwLIt0+/Ag9xTQXUQ0TZbKpL2CuQjGsT9UetOZLaZTWWvNq7BL6khibXcQ
 PuFloD8XOOeL3X2GMXquWnm0AguF+KRTNkMdoe/LeeWoPUqeU3bWm1Z710z4ulBpFO2k
 CJJKHtqBmiWt+TNwPR3PS1gkNfpOiJG318fcfPJ/Mavs0/Lk5IBpoD2TYqYw2KrW7quX
 sppZF6UKstuxnhJuolfPF825RMb3NDBpIjeR/tEfjKPSeUA/wlhchMjTH9ex2xKVt4MQ
 VfVdZQW0ipUke0B4mQR6Ena4Xmx/2gxV1ky8dv1+DucfRepIZh6ygO8WXVQTJF7/7KHt
 qoRQ==
X-Gm-Message-State: AOAM533n3YwQlySYsBo58Jjo8OuFoEo0kyUhR0rIrxAYjHDPuBMl1GOC
 9ML1DMjR2Ao/x85bzCcKIKCLyWKNte8p1s15RKGN1Ur1gUdBNkjNV9VnBfWas1odKb9tDD9m53o
 Uit3rcf0jK0j2w5RNCvJ1NYe9YODRhLdO887ORv0ugA==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id
 g7mr6690900wmq.152.1640001782469; 
 Mon, 20 Dec 2021 04:03:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGNokA5dsQSDTergDRmkdfHGMbynaCcZpoaZd2fEWra/4z7gJowICfiJWDmDY7zWfIv5pj3A==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id
 g7mr6690874wmq.152.1640001782226; 
 Mon, 20 Dec 2021 04:03:02 -0800 (PST)
Received: from redhat.com ([2.55.19.224])
 by smtp.gmail.com with ESMTPSA id r7sm10224532wrt.77.2021.12.20.04.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Dec 2021 04:03:01 -0800 (PST)
Date: Mon, 20 Dec 2021 07:02:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [iproute2-next v2 4/4] vdpa: Enable user to set mtu of the vdpa
 device
Message-ID: <20211220070136-mutt-send-email-mst@kernel.org>
References: <20211217080827.266799-1-parav@nvidia.com>
 <20211217080827.266799-5-parav@nvidia.com>
 <a38a9877-4b01-22b3-ac62-768265db0d5a@gmail.com>
 <20211218170602-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548189EBA8346A960A0A409FDC7B9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548189EBA8346A960A0A409FDC7B9@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, David Ahern <dsahern@gmail.com>
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

On Mon, Dec 20, 2021 at 03:49:21AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, December 19, 2021 3:37 AM
> > 
> > On Sat, Dec 18, 2021 at 01:53:01PM -0700, David Ahern wrote:
> > > On 12/17/21 1:08 AM, Parav Pandit wrote:
> > > > @@ -204,6 +217,8 @@ static void vdpa_opts_put(struct nlmsghdr *nlh,
> > struct vdpa *vdpa)
> > > >  	if (opts->present & VDPA_OPT_VDEV_MAC)
> > > >  		mnl_attr_put(nlh, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> > > >  			     sizeof(opts->mac), opts->mac);
> > > > +	if (opts->present & VDPA_OPT_VDEV_MTU)
> > > > +		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MTU,
> > opts->mtu);
> > >
> > > Why limit the MTU to a u16? Eric for example is working on "Big TCP"
> > > where IPv6 can work with Jumbograms where mtu can be > 64k.
> > >
> > > https://datatracker.ietf.org/doc/html/rfc2675
> > 
> > Well it's 16 bit at the virtio level, though we can extend that of course. Making
> > it match for now removes need for validation.
> > --
> As Michael mentioned virtio specification limits the mtu to 64k-1. Hence 16-bit.
> First we need to update the virtio spec to support > 64K mtu.
> However, when/if (I don't know when) that happens, we need to make this also u32.
> So may be we can make it u32 now, but still restrict the mtu value to 64k-1 in kernel, until the spec is updated.
> 
> Let me know, if you think that's future proofing is better, I first need to update the kernel to take nla u32.
> 
> > MST

After consideration, this future proofing seems like a good thing to have.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
