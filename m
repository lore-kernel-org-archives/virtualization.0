Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71357C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:18:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A40A60F0F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A40A60F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C664780E20;
	Mon, 25 Oct 2021 02:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kui5lXMbKlrj; Mon, 25 Oct 2021 02:18:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8024580DB1;
	Mon, 25 Oct 2021 02:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57448C0012;
	Mon, 25 Oct 2021 02:18:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 703D7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 518A54017A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HjDK4lcge9hk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:18:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79C1D4010C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635128320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Cqrji7oGYrLYL61haWXsFYkDV8/eEVTUDZfTjuclJ0=;
 b=EPXDkL/WqEjLIE24GV3gwj9z5/MMs88Vjrcs+x4BxBOK7oYtbsnAAKhI5s34yYRZ3M03xf
 11uK57HY4ziZHDy3/0mrgGnfWjsIaEQn7UVX2Z3Ax3PzluDYWYbGbjgS76J3vF4mvG4QJX
 2gAnUQBKPLPbmo/45XY4goPlESCAXsU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-qqFvONwvMgu_ZwJb1q_cDg-1; Sun, 24 Oct 2021 22:18:38 -0400
X-MC-Unique: qqFvONwvMgu_ZwJb1q_cDg-1
Received: by mail-lj1-f199.google.com with SMTP id
 j8-20020a2e3c08000000b00210e2890d61so2242260lja.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 19:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Cqrji7oGYrLYL61haWXsFYkDV8/eEVTUDZfTjuclJ0=;
 b=RktTJBiwnTYHgr793vJ/JJTVi6fR9KuRDGP5ezqAfrZWdum2B0SJE39OjyKUmK4Hw/
 kiRl2FuaV7nCWrAsho80QuVmbeM9kLJ13kragwy81bBKxAFwzFHltASkWxGervewF62J
 lnnUN3Fa2c5Byf6fnl+AtvvJl4VtaehH0mFrvIiacblLM07qiPmMjqL725oI4oLQhv22
 BVZKdrNBDyC2H3hJONrAWw5PoqC1xAMx6MV9CE5y5V+oDmT2XpLaQuyZ65ty+bPKqqHY
 k94sKQSZvRJBFapueWPMKf6dRop7f8VXBWhbAgEIcBMB5wqbNlv8QRVYPOo20R2bDbzS
 WBxg==
X-Gm-Message-State: AOAM530oI29VUD+eHC51pdrYqKCDAePhpjIyHKa7msvIKeporv79MiQG
 aFW3kofPhh2i1Ol+kTmRUn1PNZsqdg5Kmv0rEiyYRvLsiljwXl1osltvs121jVsoYpcLyHQI6L/
 c5ZeW7ndEIQYbwCGWQgnfZPYN7pXOKaxn7poUA/ZVda+l3LCWRg+8RUoN1g==
X-Received: by 2002:a05:6512:282:: with SMTP id
 j2mr874809lfp.580.1635128317442; 
 Sun, 24 Oct 2021 19:18:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxeLXknnatPi0arOTANcnkg1mesXoxF5l5lOqNcw3muSYscCMQdhHCR9Ku9HT6U181ywrUyMwbjPi//3Ykhhk=
X-Received: by 2002:a05:6512:282:: with SMTP id
 j2mr874793lfp.580.1635128317245; 
 Sun, 24 Oct 2021 19:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <41e5d4e7d9e6f46429ce45a80f81f40fdb8e11cb.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <41e5d4e7d9e6f46429ce45a80f81f40fdb8e11cb.1634870456.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Oct 2021 10:18:26 +0800
Message-ID: <CACGkMEsXwYhwaThy=KB3NKa1zU+a5DQuWFLuTkREHMmO0TFpGw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] vdpa: min vq num of vdpa device cannot be greater
 than max vq num
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
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

On Fri, Oct 22, 2021 at 10:44 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Just failed to probe the vdpa device if the min virtqueue num returned
> by get_vq_num_min is greater than the max virtqueue num returned by
> get_vq_num_max.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1dc121a07a93..fd014ecec711 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -26,8 +26,16 @@ static int vdpa_dev_probe(struct device *d)
>  {
>         struct vdpa_device *vdev = dev_to_vdpa(d);
>         struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
> +       const struct vdpa_config_ops *ops = vdev->config;
> +       u32 max_num, min_num = 0;
>         int ret = 0;
>
> +       max_num = ops->get_vq_num_max(vdev);
> +       if (ops->get_vq_num_min)
> +               min_num = ops->get_vq_num_min(vdev);
> +       if (max_num < min_num)
> +               return -EINVAL;
> +
>         if (drv && drv->probe)
>                 ret = drv->probe(vdev);
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
