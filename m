Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2BC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:51:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F5964D99
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F5964D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C66A583BF0;
	Wed, 24 Feb 2021 06:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MdmEEovKAcu; Wed, 24 Feb 2021 06:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 649A383BAC;
	Wed, 24 Feb 2021 06:51:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DBD2C000A;
	Wed, 24 Feb 2021 06:51:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E62FAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDE1743077
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xx6bWIXrqWPP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:51:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F09D414ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614149467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tzp1elXCXRaaXmsbJeOL4dL3HZO5L0e6c8ozj9xkHH0=;
 b=Pv65HYFx2kM/7WXvSJmuViIldBdAprRxrgSN4N6qDEWQJ4QxyQHx82nS1d5PSrP2jsX/4L
 4mKFKCPRxQXxpITB8FgLcdpq7Wj9X12yhY/5urxDKLj0qzSfy86d+YUUgQg3PPqFDUCZGZ
 VyiF36vXMZ3XjFr2KneVfp1j3q0PczQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-NpUUuGsvP76zGViNM8fJVg-1; Wed, 24 Feb 2021 01:51:05 -0500
X-MC-Unique: NpUUuGsvP76zGViNM8fJVg-1
Received: by mail-wm1-f70.google.com with SMTP id b62so155366wmc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 22:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tzp1elXCXRaaXmsbJeOL4dL3HZO5L0e6c8ozj9xkHH0=;
 b=YV0ZDJiVVBEXKCTQ9Yln1CeQ6JC/FVmirtue06aVMLxQYJca9497qYfu4W9dXK7AmE
 r3tPW7Xdbn17whCmGFnFvwnffC5ywlH4KIMN3oUYKdF72tPcKPkhggQjGBMz+W8eCkDc
 0YdsVlhgjWHqiaFXh3N8J1y28bcYZd9pf3rmJt83OqZlnCe5Cwu3xJ9AuqeJ0qoANVCY
 yzz+mikAPpUIF1cY3YXyZnKsrPCqTFjRYJ646QbxB/mQxLzelvQSeOQPA/GFLgaCuCMg
 yJTnhQPd79+4hrhfqSDh25P8P+xrzYVibYXLWqLjd+rbhVPzASOCaBp3ju1+6xZs+mgJ
 Vl+g==
X-Gm-Message-State: AOAM531JC+gSi2sX8UzKloWlMdmmOlSymnbiXeEHv7a+8KHYm0HEtBJT
 rjWEnBhbcuKHKjMW8x7ftj85SCT6u1T3TyTOWYGZguyrcEg04XmWdhe4LiSch5nGq5xxL+LQR/1
 kti7io+SlwBl7x5wD9YCc4zzm5i+B0TOnFqB06Za2pg==
X-Received: by 2002:adf:b345:: with SMTP id k5mr5774304wrd.14.1614149464221;
 Tue, 23 Feb 2021 22:51:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztfUFcx2YWUdXHzIQvTl6mG5ekDbHYGYRUEyFQN5Oueitg79O4g+PHkxO65IB5Sb3ILzmG1w==
X-Received: by 2002:adf:b345:: with SMTP id k5mr5774287wrd.14.1614149464064;
 Tue, 23 Feb 2021 22:51:04 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id c11sm1708500wrs.28.2021.02.23.22.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 22:51:03 -0800 (PST)
Date: Wed, 24 Feb 2021 01:51:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next 0/9] vdpa: Enable user to set mac address,
Message-ID: <20210224015027-mutt-send-email-mst@kernel.org>
References: <20210224061844.137776-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210224061844.137776-1-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Wed, Feb 24, 2021 at 08:18:35AM +0200, Parav Pandit wrote:
> Currently user cannot set the mac address and mtu of the vdpa device.
> This patchset enables users to set the mac address and mtu of the vdpa
> device once the device is created.
> If a vendor driver supports such configuration user can set it otherwise
> user gets unsupported error.
> 
> vdpa mac address and mtu are device configuration layout fields.
> To keep interface generic enough for multiple types of vdpa devices, mac
> address and mtu setting is implemented as configuration layout config
> knobs.
> This enables to use similar config layout for other virtio devices.
> 
> An example of query & set of config layout fields for vdpa_sim_net
> driver:
> 
> Configuration layout fields are set after device is created.
> This enables user to change such fields at later point without destroying and
> recreating the device for new config.
> 
> $ vdpa mgmtdev show
> vdpasim_net:
>   supported_classes net
> 
> Add the device:
> $ vdpa dev add name bar mgmtdev vdpasim_net
> 
> Configure mac address and mtu:
> $ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000
> 
> In above command only mac address or only mtu can also be set.
> 
> View the config after setting:
> $ vdpa dev config show
> bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed 0 duplex 0
> 
> Patch summary:
> Patch-1 uses read only features bit to detect endianness
> Patch-2 implements new config layout query command
> Patch-3 implements callback for setting vdpa net config fields
> Patch-4 extends vdpa_sim_net driver to implement mac, mtu setting
> Patch-5 removed redundant get_config callback
> Patch-6 mlx5 vdpa driver migrates to user created vdpa device
> Patch-7 mlx5 vdpa driver uses random mac address when not configured
> Patch-8 mlx5 vdpa driver supports user provided mac config
> Patch-9 mlx5 vdpa driver uses user provided mac during rx flow steering

which tree is this for? does not seem to apply to linux-next branch of
vhost ...

> Eli Cohen (4):
>   vdpa/mlx5: Enable user to add/delete vdpa device
>   vdpa/mlx5: Provide device generated random MAC address
>   vdpa/mlx5: Support configuration of MAC
>   vdpa/mlx5: Forward only packets with allowed MAC address
> 
> Parav Pandit (5):
>   vdpa_sim: Consider read only supported features instead of current
>   vdpa: Introduce query of device config layout
>   vdpa: Enable user to set mac and mtu of vdpa device
>   vdpa_sim_net: Enable user to set mac address and mtu
>   vdpa_sim_net: Remove redundant get_config callback
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    | 185 ++++++++++++++----
>  drivers/vdpa/vdpa.c                  | 270 +++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |   4 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  49 +++--
>  include/linux/vdpa.h                 |  16 ++
>  include/uapi/linux/vdpa.h            |  12 ++
>  6 files changed, 476 insertions(+), 60 deletions(-)
> 
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
