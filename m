Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4130C43460
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 08:19:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B71961262
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 08:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B71961262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 036CB83155;
	Mon, 12 Apr 2021 08:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rlAGN9tvvMqQ; Mon, 12 Apr 2021 08:19:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A20182983;
	Mon, 12 Apr 2021 08:19:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 564FDC000C;
	Mon, 12 Apr 2021 08:19:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BEBCC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 08:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 431FF6061F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 08:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gf9XkPXTz7Hb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 08:19:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AE50605CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618215546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xJgn3g7ogKt5V6b/6xvZZCO2WGaaJCBspvi1WlJo2ZE=;
 b=BmqIkCzEGFtaHoL42wQWb9VnwL6oXSo7DLTQoEcECLMqWdLyZ6NY0l0Iaue6dmMm2duDjr
 AVLdHJKq8I/O2M6ZRzha5ZHs8/tSspk5yCdkp1DU9wtbkbbVvpwuYgUMpCoumY7PgUSM63
 Vyv7WGgVh3Hs/vXfQbNLaLqIxt/L/ow=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304--BjrQaJZPqOVoH-uxpmRDA-1; Mon, 12 Apr 2021 04:19:03 -0400
X-MC-Unique: -BjrQaJZPqOVoH-uxpmRDA-1
Received: by mail-ej1-f72.google.com with SMTP id bg7so3563673ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 01:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xJgn3g7ogKt5V6b/6xvZZCO2WGaaJCBspvi1WlJo2ZE=;
 b=QTeoCp/9jjAigYsZ+nFhReG99hyde9EpVeFNtpSUzImK8UOIOSjwNkRgy5GsvFGNOx
 JineNbXVN+s0GHdUJNKx/unNq7pIbdMLBzYskKI/+eYdRT/0+mZUDLWAqgiMy1l4yatc
 7TZXGtXEkhpfSknA9WDxniSO62l1QnE3W263ieLASwJYLoP5IKOOF+gGQi7myFNZkxi7
 rK/S+/KTwTcKzM4vnJKCyE90PSv+Kh15lRi+xdP/XYsts7Q4LGlbgzx46+NXsdFkSuHs
 RFXEStlRyrSMW56KeSNTpTT/MlWId4kAXrUEQnugg607iFYlD7X6mIl/PIV2wyP+Z05w
 +gSA==
X-Gm-Message-State: AOAM530347xvNkXRuD25U6yfPyciZjx5p+gOZ1dVB70JgU0DkQyFX4/l
 aYwUyb+N8DZ6i6RHCGxZPBqNEbnxA/dCqUZVkCuGP6MzcPn14FGUVhTSdkhb4dct3WmY63SprQu
 BjU03xoLq+DJu3mhLLrvMnEBVqP2NoK03oqgl1MTyig==
X-Received: by 2002:a17:906:2808:: with SMTP id
 r8mr17703897ejc.140.1618215542210; 
 Mon, 12 Apr 2021 01:19:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBU/GPnTLafg+51MT/N1zJPs8q0egQivnnyULLF6QWNsMSlyND5OuEZ/l/Y8KbZi9Vck2WWQ==
X-Received: by 2002:a17:906:2808:: with SMTP id
 r8mr17703884ejc.140.1618215541979; 
 Mon, 12 Apr 2021 01:19:01 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id a12sm5932454edx.91.2021.04.12.01.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 01:19:01 -0700 (PDT)
Date: Mon, 12 Apr 2021 10:18:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 00/14] vdpa: add vdpa simulator for block device
Message-ID: <20210412081858.wpoitvzyj474yp7s@steredhat>
References: <20210315163450.254396-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210315163450.254396-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael,
do you think this series is in an acceptable state to be queued for the 
next merge window?

All patches should be already acked by Jason, let me know if I need to 
change anything.

Thanks,
Stefano

On Mon, Mar 15, 2021 at 05:34:36PM +0100, Stefano Garzarella wrote:
>v4:
>- added support for iproute2 vdpa management tool in vdpa_sim_blk
>- removed get/set_config patches
>  - 'vdpa: add return value to get_config/set_config callbacks'
>  - 'vhost/vdpa: remove vhost_vdpa_config_validate()'
>- added get_config_size() patches
>  - 'vdpa: add get_config_size callback in vdpa_config_ops'
>  - 'vhost/vdpa: use get_config_size callback in vhost_vdpa_config_validate()'
>
>v3: https://lore.kernel.org/lkml/20210204172230.85853-1-sgarzare@redhat.com/
>v2: https://lore.kernel.org/lkml/20210128144127.113245-1-sgarzare@redhat.com/
>v1: https://lore.kernel.org/lkml/93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com/
>
>This series is the second part of the v1 linked above. The first part with
>refactoring of vdpa_sim has already been merged.
>
>The patches are based on Max Gurtovoy's work and extend the block simulator to
>have a ramdisk behaviour.
>
>As mentioned in the v1 there was 2 issues and I fixed them in this series:
>1. The identical mapping in the IOMMU used until now in vdpa_sim created issues
>   when mapping different virtual pages with the same physical address.
>   Fixed by patch "vdpa_sim: use iova module to allocate IOVA addresses"
>
>2. There was a race accessing the IOMMU between the vdpasim_blk_work() and the
>   device driver that map/unmap DMA regions. Fixed by patch "vringh: add
>   'iotlb_lock' to synchronize iotlb accesses"
>
>I used the Xie's patch coming from VDUSE series to allow vhost-vdpa to use
>block devices, and I added get_config_size() callback to allow any device
>in vhost-vdpa.
>
>The series also includes small fixes for vringh, vdpa, and vdpa_sim that I
>discovered while implementing and testing the block simulator.
>
>Thanks for your feedback,
>Stefano
>
>Max Gurtovoy (1):
>  vdpa: add vdpa simulator for block device
>
>Stefano Garzarella (12):
>  vdpa_sim: use iova module to allocate IOVA addresses
>  vringh: add 'iotlb_lock' to synchronize iotlb accesses
>  vringh: reset kiov 'consumed' field in __vringh_iov()
>  vringh: explain more about cleaning riov and wiov
>  vringh: implement vringh_kiov_advance()
>  vringh: add vringh_kiov_length() helper
>  vdpa_sim: cleanup kiovs in vdpasim_free()
>  vdpa: add get_config_size callback in vdpa_config_ops
>  vhost/vdpa: use get_config_size callback in
>    vhost_vdpa_config_validate()
>  vdpa_sim_blk: implement ramdisk behaviour
>  vdpa_sim_blk: handle VIRTIO_BLK_T_GET_ID
>  vdpa_sim_blk: add support for vdpa management tool
>
>Xie Yongji (1):
>  vhost/vdpa: Remove the restriction that only supports virtio-net
>    devices
>
> drivers/vdpa/vdpa_sim/vdpa_sim.h     |   2 +
> include/linux/vdpa.h                 |   4 +
> include/linux/vringh.h               |  19 +-
> drivers/vdpa/ifcvf/ifcvf_main.c      |   6 +
> drivers/vdpa/mlx5/net/mlx5_vnet.c    |   6 +
> drivers/vdpa/vdpa_sim/vdpa_sim.c     | 127 ++++++----
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 338 +++++++++++++++++++++++++++
> drivers/vdpa/virtio_pci/vp_vdpa.c    |   8 +
> drivers/vhost/vdpa.c                 |  15 +-
> drivers/vhost/vringh.c               |  69 ++++--
> drivers/vdpa/Kconfig                 |   8 +
> drivers/vdpa/vdpa_sim/Makefile       |   1 +
> 12 files changed, 529 insertions(+), 74 deletions(-)
> create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>
>-- 
>2.30.2
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
