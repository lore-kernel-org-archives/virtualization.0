Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413E1C433EF
	for <virtualization@archiver.kernel.org>; Sat, 18 Dec 2021 22:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA0A560B21;
	Sat, 18 Dec 2021 22:07:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0H9g6K9TFs1O; Sat, 18 Dec 2021 22:07:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FA1E60B2B;
	Sat, 18 Dec 2021 22:07:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B27EC002F;
	Sat, 18 Dec 2021 22:07:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B268AC0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 22:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9870E40190
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 22:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F-MVOXL8xSKG
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 22:07:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42EE3400AF
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639865243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VCDl2Qks9geyT3GytmA7fcu+PaD1/o6QVHzA5DhKnjI=;
 b=T7q1jFmvfEf6SfWRMEHdSmu33vviuTtXyDPg41o7u/79uMs/1qFkjQ9olzOimHCisXpT/a
 prPXk5T5EvQB6Y1rpDsAv2ezVATiImC2OEQrnIeIfz7b3AbgHonwf5ddF75BSRpc2pqCcf
 wnve/kilpAocI0F2Z+Vof+Pl2jbChJM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-D5H78_IvOxmQLHXO7iG61Q-1; Sat, 18 Dec 2021 17:07:22 -0500
X-MC-Unique: D5H78_IvOxmQLHXO7iG61Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 h7-20020a05640250c700b003f800db4193so4673458edb.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 14:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VCDl2Qks9geyT3GytmA7fcu+PaD1/o6QVHzA5DhKnjI=;
 b=7ou6cYlNFuWpApsqULvrwJe4xQYcNpXCQwCrN886y5M8NCSONQJ+68kOYjdqmsOSzL
 iWQYY8WFVy/rMkpqcsz0BFWB4JuHP7qs9EyfwQsZ1AoT7a1kWfcMq8SGrCz0hGEnF0/a
 SFE1qwJIODWR8lYLY84Qfc3TIrtmxMvaqv7XjER20MhJQ1S9RIPGY1o5KJtrTeEMZIq8
 gpKjDc1QM0hy1RYUSHL1o8OJKyiVtOK7gaBdyiJzudmTu3Jb07PO+vWAWD9YZ+mjrRFN
 LN7L/+dxkNFbndCMNjuo3fizhi5SyYWh2nOGHKJP55JDXVUeL5dyIj+7V7XKOZLC9wXI
 SdRg==
X-Gm-Message-State: AOAM531KClcBuRWhoGHIX5Q/weKL+kxM6cEu35DUPVDqhuHWr5ppWIVu
 PKF2c+3ZCDuWfSbxETFTxOQlCjzAee33Mp90WyQhc5BsE0BETY5GdK/G6cWLY1edFMxy1EHbOAC
 odbG2YwC548oGm9ueB9NzAjRIhtYsw5nlCaU7MSNCbA==
X-Received: by 2002:a05:6402:40d3:: with SMTP id
 z19mr9074812edb.185.1639865240807; 
 Sat, 18 Dec 2021 14:07:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJIrmRZ37IeMwKI8zajuO3r+oGkf4SiQ5vVw40enLelqNdOhKqls4BUJqXLFYvzR36B1w9Ng==
X-Received: by 2002:a05:6402:40d3:: with SMTP id
 z19mr9074800edb.185.1639865240582; 
 Sat, 18 Dec 2021 14:07:20 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:85fe:33f4:b53f:99ab:57c7])
 by smtp.gmail.com with ESMTPSA id c12sm5225163edx.80.2021.12.18.14.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Dec 2021 14:07:19 -0800 (PST)
Date: Sat, 18 Dec 2021 17:07:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Ahern <dsahern@gmail.com>
Subject: Re: [iproute2-next v2 4/4] vdpa: Enable user to set mtu of the vdpa
 device
Message-ID: <20211218170602-mutt-send-email-mst@kernel.org>
References: <20211217080827.266799-1-parav@nvidia.com>
 <20211217080827.266799-5-parav@nvidia.com>
 <a38a9877-4b01-22b3-ac62-768265db0d5a@gmail.com>
MIME-Version: 1.0
In-Reply-To: <a38a9877-4b01-22b3-ac62-768265db0d5a@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: stephen@networkplumber.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Sat, Dec 18, 2021 at 01:53:01PM -0700, David Ahern wrote:
> On 12/17/21 1:08 AM, Parav Pandit wrote:
> > @@ -204,6 +217,8 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
> >  	if (opts->present & VDPA_OPT_VDEV_MAC)
> >  		mnl_attr_put(nlh, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> >  			     sizeof(opts->mac), opts->mac);
> > +	if (opts->present & VDPA_OPT_VDEV_MTU)
> > +		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MTU, opts->mtu);
> 
> Why limit the MTU to a u16? Eric for example is working on "Big TCP"
> where IPv6 can work with Jumbograms where mtu can be > 64k.
> 
> https://datatracker.ietf.org/doc/html/rfc2675

Well it's 16 bit at the virtio level, though we can extend that of
course. Making it match for now removes need for validation.
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
