Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B111C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 02:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CCBB607B5;
	Tue, 23 Nov 2021 02:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GaZVdj5h-cp8; Tue, 23 Nov 2021 02:10:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 47731607A3;
	Tue, 23 Nov 2021 02:10:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A037C002E;
	Tue, 23 Nov 2021 02:10:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCC39C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD7936078A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CtyoFQvf5tbi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:10:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBFE460600
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637633431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1sOzKcfc1mb/QfFCcqk6Ete8PuEFAKr8bz+8/GvBKxk=;
 b=EC1coBgr2dFAPetxPu0EloOYJP0FPTYm3uMoLG2sbmN91vdOjm/w1jlheE632i4xHr9d5Y
 r7m08wUtwAXPejqJVq7/Uh4mQkIuxcMXLOyMTCkZXcjIyXJgx0xg9yWxvww1eVmyIEIxjl
 MKiLkLCw28AD8FYvKxAEg0hmr2s39/g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-vSvySpbzPzm79HCBJnaiHw-1; Mon, 22 Nov 2021 21:10:30 -0500
X-MC-Unique: vSvySpbzPzm79HCBJnaiHw-1
Received: by mail-lf1-f71.google.com with SMTP id
 u20-20020a056512129400b0040373ffc60bso13325912lfs.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 18:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1sOzKcfc1mb/QfFCcqk6Ete8PuEFAKr8bz+8/GvBKxk=;
 b=oCq3TvVO3UXzuo+Kc7/yXB9ONh+WMwiBE6CYq8szSGE7B+KlHZsvgnTRC3Q9STKwcF
 1w5VF9V0HwjPbac0C+06xVqoTGQHGJss8tPmYx8KkW0S/epK0/F9DQIN8YW9R9n4NuLe
 YN8XqP+bJQkd9qrfC0s1zQHRyF3TTPJQgGuLEa66Kl2MJnd0dnKgw9itWr+D9NBF+zVV
 j8QL0IxDlvtZtqOZSfSOQO9K8emI+3x7UaxHRtBuSbHvrCwVRXwAgRvzZbWv4C+FYHDH
 GiQLUVcnDK5SciaWvSJZPOgHTiyhcWPsM6IKtUo8febfb4WKXeQfc0o1NHWaMhJjNDKU
 9hUg==
X-Gm-Message-State: AOAM532ImGAZ6Jh+yvIE3oz0jzGq8R03lorjekTj7T2DJf1Ns0bVkua/
 yVgKhtR/FesNOiFDhbIPbGzFdcaY0Lia6Xp3mnwpYxzMDUOLV7oYULScdhhGsyrexIPanFe2hJS
 xffnwOx4+eoxMzh3BkI8nU5Q7nP4ViXm/VEhmYg+NoTJi5BwkBk4/BfVtFA==
X-Received: by 2002:a2e:915a:: with SMTP id q26mr1082233ljg.277.1637633428632; 
 Mon, 22 Nov 2021 18:10:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIxxkaUjeVw+D8UMGoyZ19ATnr7cJFS0YGB7JG9SltIKNzY6nQ7dCY65IYPG0XZgJFRYEMQQdmQj4SV8bnDbY=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr1082206ljg.277.1637633428448; 
 Mon, 22 Nov 2021 18:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20211122122221.56-1-longpeng2@huawei.com>
In-Reply-To: <20211122122221.56-1-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Nov 2021 10:10:17 +0800
Message-ID: <CACGkMEsYEg06vaLJnYeCzcUXneTxWM7kR1Y-DqXicc4WG3z7ew@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Mon, Nov 22, 2021 at 8:22 PM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> The system will crash if we put an uninitialized iova_domain, this
> could happen when an error occurs before initializing the iova_domain
> in vdpasim_create().
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> RIP: 0010:__cpuhp_state_remove_instance+0x96/0x1c0
> ...
> Call Trace:
>  <TASK>
>  put_iova_domain+0x29/0x220
>  vdpasim_free+0xd1/0x120 [vdpa_sim]
>  vdpa_release_dev+0x21/0x40 [vdpa]
>  device_release+0x33/0x90
>  kobject_release+0x63/0x160
>  vdpasim_create+0x127/0x2a0 [vdpa_sim]
>  vdpasim_net_dev_add+0x7d/0xfe [vdpa_sim_net]
>  vdpa_nl_cmd_dev_add_set_doit+0xe1/0x1a0 [vdpa]
>  genl_family_rcv_msg_doit+0x112/0x140
>  genl_rcv_msg+0xdf/0x1d0
>  ...
>
> So we must make sure the iova_domain is already initialized before
> put it.
>
> In addition, we may get the following warning in this case:
> WARNING: ... drivers/iommu/iova.c:344 iova_cache_put+0x58/0x70
>
> So we must make sure the iova_cache_put() is invoked only if the
> iova_cache_get() is already invoked. Let's fix it together.
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 5f484fff8dbe..41b0cd17fcba 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -591,8 +591,11 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>                 vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
>         }
>
> -       put_iova_domain(&vdpasim->iova);
> -       iova_cache_put();
> +       if (vdpa_get_dma_dev(vdpa)) {
> +               put_iova_domain(&vdpasim->iova);
> +               iova_cache_put();
> +       }
> +
>         kvfree(vdpasim->buffer);
>         if (vdpasim->iommu)
>                 vhost_iotlb_free(vdpasim->iommu);
> --
> 2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
