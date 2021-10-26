Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986C4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:09:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CE361029
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42CE361029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2DB8404AB;
	Tue, 26 Oct 2021 04:09:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gNencxq21DMP; Tue, 26 Oct 2021 04:09:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39CDB4048E;
	Tue, 26 Oct 2021 04:09:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECAFAC0012;
	Tue, 26 Oct 2021 04:09:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00D00C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8B5C40493
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8UvE-sijdLBx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:09:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B116A4048E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635221354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4azhNWM6vdvijsFlMgZAXCNILaK+VVYEsuB7Gh3Bs/k=;
 b=YxdQkSydYlKFQxRDpTrgXZFtQZc3GtF0ELmvZ4iRUGJFAcJpZnSkiFfU0Y0xmPq1ROggba
 lPvkl4xIepZrDQYy8s+yp+DtN/ZZiTmaMs/3PnCeNCsdfT3cskdZN6JrnILUiu2zGyc+Gh
 i0cfNrSQvz3UN641Etu+GahgI18BU/c=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-eSqrpglHPV629oSuBhmNdg-1; Tue, 26 Oct 2021 00:09:12 -0400
X-MC-Unique: eSqrpglHPV629oSuBhmNdg-1
Received: by mail-lj1-f200.google.com with SMTP id
 k13-20020a05651c10ad00b00210d682c600so3771987ljn.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4azhNWM6vdvijsFlMgZAXCNILaK+VVYEsuB7Gh3Bs/k=;
 b=aY2PXoGB4fWqr//irUY2/62c0WAJG/HvNBw2KwECPvRXQSpj17OKbdp8Br5GwtsFBx
 LlAopR2LXG9bZhhmFkOkLSu69MylpVg6jRZSd41lSTVns4KbFN5u1DKrBRQvXDa2j3j3
 3z9zGVOz21xR3uDVSbRbghypUFcKpw/2EDb7cm2EVh348rS6udJm1hrJIPGLfKS9Lh+z
 UqkT6zXb7aqXH0WdJi61Fp0bwHluK2RseFyT/O+ohUlKff9YruC6zl1LrUrtdPXgl9Fu
 ff2rCYid+zpkVnXVPyP+buYec1S00Go3dRJEX3OU04ZcTuLjtJvr4Xi07KAYMJmnNeTz
 pvSw==
X-Gm-Message-State: AOAM531EhgtgMVrVlW0Q0JJWsR0Bxk+B4D1DD/1PaWGrLvoekantAMe+
 OPxtZEzA6Ha8zDW3OWV+rbjWESgJ9wEHGKF/y7LB3elLpuvEOagwZ7BkWA9bIWS7HwP1uagzMK+
 zLc64bc9hrdyb8Erl6z7fNWSnUwM7BY0C8NfMaLYPbwUwL+JVY+dqaced8g==
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr15942766lfv.481.1635221351169; 
 Mon, 25 Oct 2021 21:09:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz25tAn3moc85gqgFO1tA68vtxV4dpwTdeboNrf8bycXzh7RdfoRk5ZNrDF+5xiW9z+8rgCzQhOGaceg/cLo+Y=
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr15942741lfv.481.1635221350953; 
 Mon, 25 Oct 2021 21:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211026040243.79005-1-parav@nvidia.com>
 <20211026040243.79005-6-parav@nvidia.com>
In-Reply-To: <20211026040243.79005-6-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 12:09:00 +0800
Message-ID: <CACGkMEvbyoxmi2YGJKo-7vNzgE3m5ohi1-brTXzzOQkyGb3Uww@mail.gmail.com>
Subject: Re: [PATCH linux-next v6 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Oct 26, 2021 at 12:03 PM Parav Pandit <parav@nvidia.com> wrote:
>
> Enable user to set the mac address and mtu so that each vdpa device
> can have its own user specified mac address and mtu.
>
> Now that user is enabled to set the mac address, remove the module
> parameter for same.
>
> And example of setting mac addr and mtu and view the configuration:
> $ vdpa mgmtdev show
> vdpasim_net:
>   supported_classes net
>
> $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
>
> $ vdpa dev config show
> bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> changelog:
> v4->v5:
>  - updated commit log example for add command
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 35 +++++++++++++++-------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index d681e423e64f..76dd24abc791 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -16,6 +16,7 @@
>  #include <linux/vringh.h>
>  #include <linux/vdpa.h>
>  #include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/vdpa.h>
>
>  #include "vdpa_sim.h"
>
> @@ -29,12 +30,6 @@
>
>  #define VDPASIM_NET_VQ_NUM     2
>
> -static char *macaddr;
> -module_param(macaddr, charp, 0);
> -MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
> -
> -static u8 macaddr_buf[ETH_ALEN];
> -
>  static void vdpasim_net_work(struct work_struct *work)
>  {
>         struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> @@ -112,9 +107,21 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
>  {
>         struct virtio_net_config *net_config = config;
>
> -       net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>         net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
> -       memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
> +}
> +
> +static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> +                                    const struct vdpa_dev_set_config *config)
> +{
> +       struct virtio_net_config *vio_config = vdpasim->config;
> +
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR))
> +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +               vio_config->mtu = cpu_to_vdpasim16(vdpasim, config->net.mtu);
> +       else
> +               /* Setup default MTU to be 1500 */
> +               vio_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>  }
>
>  static void vdpasim_net_mgmtdev_release(struct device *dev)
> @@ -147,6 +154,8 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         if (IS_ERR(simdev))
>                 return PTR_ERR(simdev);
>
> +       vdpasim_net_setup_config(simdev, config);
> +
>         ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
>         if (ret)
>                 goto reg_err;
> @@ -180,20 +189,14 @@ static struct vdpa_mgmt_dev mgmt_dev = {
>         .device = &vdpasim_net_mgmtdev,
>         .id_table = id_table,
>         .ops = &vdpasim_net_mgmtdev_ops,
> +       .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> +                            1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>  };
>
>  static int __init vdpasim_net_init(void)
>  {
>         int ret;
>
> -       if (macaddr) {
> -               mac_pton(macaddr, macaddr_buf);
> -               if (!is_valid_ether_addr(macaddr_buf))
> -                       return -EADDRNOTAVAIL;
> -       } else {
> -               eth_random_addr(macaddr_buf);
> -       }
> -
>         ret = device_register(&vdpasim_net_mgmtdev);
>         if (ret)
>                 return ret;
> --
> 2.25.4
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
