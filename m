Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BFC433F5
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 10:41:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D649611F2
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 10:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D649611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C8A8407F5;
	Fri, 22 Oct 2021 10:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dGqdhxSg1Sen; Fri, 22 Oct 2021 10:41:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA4BE407C3;
	Fri, 22 Oct 2021 10:41:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E69CC0020;
	Fri, 22 Oct 2021 10:41:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 815A0C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 697CB60854
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cJihl3PD9w20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:41:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 809C5607DB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634899274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nDlm6lC0Vx5Pp8T19bpKR43J+Z0pXJSQ0Q//swqOz94=;
 b=XuDjVO+/KaA35t++72ul5VYlAHYR3MXiR2AqmBgKo+4oTn1g6dEuz8BS1cotZcKEolKUjp
 cbDoQRVQClvuh/UEvWTlzq7v/UWl53nFfFyfjfCtp6c04fEz8rs1b4vjA1GVzCOPhBT6NX
 5FIQPoJ+wbuP2LcXaqjudd+qBwU3yeQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-D9ul1EKwPtCtq7MToT2W-g-1; Fri, 22 Oct 2021 06:41:13 -0400
X-MC-Unique: D9ul1EKwPtCtq7MToT2W-g-1
Received: by mail-wm1-f71.google.com with SMTP id
 n189-20020a1c27c6000000b00322f2e380f2so993182wmn.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 03:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nDlm6lC0Vx5Pp8T19bpKR43J+Z0pXJSQ0Q//swqOz94=;
 b=JB4slvU7B9Fehuc8xUa1jVhX3xCDpp5XRPZOGY97AtL49kBGUDV+vLQ5a3jUsMXyVe
 bVaRxbDQXkMBE4E4mChZRlaAdetr91iYS/5aPfgJNAaWLLa/JY2ucjPehvj7uUBVMjeK
 rQa2OFkMzbU65TZPUXAgKd2UMetRiqI/zui4WHtZGfsISJEy6Yvc0FldOydlwLUdPAn9
 ZExyH8InUvYlQUP1C1zqlPlTpWzQory24zZFFqRSG/MsL8vCdEMWYZN+SqV6JGnqbaQI
 sY/c29higBlYyWsrpLtUF93KCxFot3odczTyV8xLY3jYisw4Fvue4rCCvgha1le1Tbf6
 0tTg==
X-Gm-Message-State: AOAM533z38Ays7LONydoGa4SvxxwaAGF+0K4izwRuYBTyaiQLtT7qf9M
 ECUwCt0NAVWgIgu52iULchlfCYB8l8KqTCkbX0rqOsToUOXAcXGPbdB6RjuLXjkiOE6tzZxzIhB
 JKpeOWQFG+WeJgDxeiaSW5EGfpHvYqOmYPGRNJjydJg==
X-Received: by 2002:adf:ef8f:: with SMTP id d15mr5778775wro.72.1634899271829; 
 Fri, 22 Oct 2021 03:41:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUfjwctAI7VSUDx3gaDwN5ucHfUQ1qWR4ymuF4ouBJYq0OVhWC4AsjYt0BgzQ01WGVRxJk+A==
X-Received: by 2002:adf:ef8f:: with SMTP id d15mr5778761wro.72.1634899271653; 
 Fri, 22 Oct 2021 03:41:11 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id k17sm7415576wrc.93.2021.10.22.03.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 03:41:11 -0700 (PDT)
Date: Fri, 22 Oct 2021 06:41:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v4 0/8] vdpa: enable user to set mac, mtu
Message-ID: <20211022064007-mutt-send-email-mst@kernel.org>
References: <20211021163509.6978-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211021163509.6978-1-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, virtualization@lists.linux-foundation.org
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

On Thu, Oct 21, 2021 at 07:35:01PM +0300, Parav Pandit wrote:
> Currently user cannot view the vdpa device config space. Also user
> cannot set the mac address and mtu of the vdpa device.
> This patchset enables users to set the mac address and mtu of the vdpa
> device once the device is created.
> If a vendor driver supports such configuration user can set it otherwise
> user gets unsupported error.
> 
> vdpa mac address and mtu are device configuration layout fields.
> To keep interface generic enough for multiple types of vdpa devices, mac
> address and mtu setting is implemented as configuration layout fields.


So I got lots of "sha1 is lacking or useless" warnings with this.
I did my best to merge but please check out the result in
linux-next.

> An example of query & set of config layout fields for vdpa_sim_net
> driver:
> 
> Configuration layout fields are set when a vdpa device is created.
> 
> $ vdpa mgmtdev show
> vdpasim_net:
>   supported_classes net
> pci/0000:08:00.2:
>   supported_classes net
> 
> Add the device with MAC and MTU:
> $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:66 mtu 1500
> 
> In above command only mac address or only mtu can also be set.
> 
> View the config after setting:
> $ vdpa dev config show
> bar: mac 00:11:22:33:44:66 link up link_announce false mtu 1500
> 
> Patch summary:
> Patch-1 introduced and use helpers for get/set config area
> Patch-2 implement query device config layout
> Patch-3 use kernel coding style for structure comment
> Patch-4 enanble user to set mac and mtu in config space
> Patch-5 vdpa_sim_net implements get and set of config layout
> Patch-6 mlx vdpa driver fix to avoid clearing VIRTIO_NET_F_MAC during
>         reset callback
> Patch-7 mlx5 vdpa driver supports user provided mac config
> Patch-8 mlx5 vdpa driver uses user provided mac during rx flow steering
> 
> changelog:
> v3->v4:
>  - enable setting mac and mtu of the vdpa device using creation time
>  - introduced a patch to fix mlx5 driver to avoid clearing
>    VIRTIO_NET_F_MAC
>  - introduced a patch to use kernel coding style for structure comment
>  - removed config attributes not used by sim and mlx5 net drivers
> v2->v3:
>  - dropped patches which are merged
>  - simplified code to handle non transitional devices
> 
> v1->v2:
>  - new patches to fix kdoc comment to add new kdoc section
>  - new patch to have synchronized access to features and config space
>  - read whole net config layout instead of individual fields
>  - added error extack for unmanaged vdpa device
>  - fixed several endianness issues
>  - introduced vdpa device ops for get config which is synchronized
>    with other get/set features ops and config ops
>  - fixed mtu range checking for max
>  - using NLA_POLICY_ETH_ADDR
>  - set config moved to device ops instead of mgmtdev ops
>  - merged build and set to single routine
>  - ensuring that user has NET_ADMIN capability for configuring network
>    attributes
>  - using updated interface and callbacks for get/set config
>  - following new api for config get/set for mgmt tool in mlx5 vdpa
>    driver
>  - fixes for accessing right SF dma device and bar address
>  - fix for mtu calculation
>  - fix for bit access in features
>  - fix for index restore with suspend/resume operation
> 
> 
> Eli Cohen (2):
>   vdpa/mlx5: Support configuration of MAC
>   vdpa/mlx5: Forward only packets with allowed MAC address
> 
> Parav Pandit (6):
>   vdpa: Introduce and use vdpa device get, set config helpers
>   vdpa: Introduce query of device config layout
>   vdpa: Use kernel coding style for structure comments
>   vdpa: Enable user to set mac and mtu of vdpa device
>   vdpa_sim_net: Enable user to set mac address and mtu
>   vdpa/mlx5: Fix clearing of VIRTIO_NET_F_MAC feature bit
> 
>  drivers/vdpa/ifcvf/ifcvf_main.c      |   3 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  92 +++++++---
>  drivers/vdpa/vdpa.c                  | 243 ++++++++++++++++++++++++++-
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   3 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  38 +++--
>  drivers/vdpa/vdpa_user/vduse_dev.c   |   3 +-
>  drivers/vhost/vdpa.c                 |   3 +-
>  include/linux/vdpa.h                 |  47 ++++--
>  include/uapi/linux/vdpa.h            |   6 +
>  9 files changed, 375 insertions(+), 63 deletions(-)
> 
> -- 
> 2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
