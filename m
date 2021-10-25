Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D71C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:17:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EED60F11
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9EED60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ED704032E;
	Mon, 25 Oct 2021 02:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wfjMtSx_FpLc; Mon, 25 Oct 2021 02:17:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FB7A40312;
	Mon, 25 Oct 2021 02:17:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 031C8C0012;
	Mon, 25 Oct 2021 02:17:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3A25C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 803D680E0C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:17:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5cmCq8RNB4sU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD58A80DB1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635128248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AYNZwC/fZIiCDsDJV++nVrgkwMv82Wn8FjvaRuBUZEE=;
 b=EPpdudTB5aC5bDJUeVeUiDu5FMnbR5x+cXFKdJNlLTCZkta7lEWcg6OjTjHWFo+XETsx1g
 xP+EJcQj3/UWZEz4gwiEo7X1VNupCdV70hc1YfG+AEuUd48NCueHvWnC7mTm6JpRPKkc3h
 RwUFW6YQX0bIlTKYpYerL1U2EorlLmk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-f-9FR4gaM8yImkJXlIOjyg-1; Sun, 24 Oct 2021 22:17:27 -0400
X-MC-Unique: f-9FR4gaM8yImkJXlIOjyg-1
Received: by mail-lf1-f72.google.com with SMTP id
 g10-20020a05651222ca00b003fda3f05c17so4559331lfu.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 19:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AYNZwC/fZIiCDsDJV++nVrgkwMv82Wn8FjvaRuBUZEE=;
 b=QheNd/q1XVSU3S0fKAv/glR4/NcPnM7c3yogkLVVyqB+rv28wdwNSgsBnttWkMqqJH
 rrYvbn4FL3+h/W3a25H3AN1DolxW7fonDJPeojGBQG4k+V7/1qdrRR8G3E/kdzAyQ1lc
 KSIhXNyjl6J7SehZthVtrXaX/p9eXQEkcYoYWyoAaIRCTmanq9C2n8G8l/Qnmq5Pj0zj
 JI4jCsdGHqvrHm0yZCqRvEkWOCkgiOGggUqvJMnBiChdSh/viBb+LUunH8tq0A2Xx0R6
 DRKMa+ev5K3OGIL6zXnByQU91WpreExk8E1W7UxqJTSpCl24Vll7+twJGva1Y5/C14UN
 gz4g==
X-Gm-Message-State: AOAM531JWtiaTqa8s5jDxx4eDm97IgZDO3C93c5x6B3ShwBCE8VNaLMZ
 V0OLekgBdpULUHlCdLpu1R07lEGLT5mU7FwpQrGmZ4nSYY+9SOWtxcwhZ6B8fRCTzQsZaa+3OHj
 374O31Q/6ITpgWBlKMqUacMC92KrVsbCr/URoK+Tv11vzmJVl4Fz/sgIN5Q==
X-Received: by 2002:a2e:7212:: with SMTP id n18mr15985530ljc.369.1635128245585; 
 Sun, 24 Oct 2021 19:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFukfsVribLNvTMwxoWwh/QVqaKbDCRMQhMmgOcWV1PaxOsT5eTeUPQu0mgIIqEqBlIWmq4kTr9AmMRYYklcA=
X-Received: by 2002:a2e:7212:: with SMTP id n18mr15985502ljc.369.1635128245356; 
 Sun, 24 Oct 2021 19:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <7e4d859949fa37fce2289a4b287843cdeffcaf8a.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <7e4d859949fa37fce2289a4b287843cdeffcaf8a.1634870456.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Oct 2021 10:17:14 +0800
Message-ID: <CACGkMEsHNStd_rF3s7h+mD9zQBAiLpvMGAhQmGyV+o3KryTpww@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] vdpa: add new callback get_vq_num_min in
 vdpa_config_ops
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
> This callback is optional. For vdpa devices that not support to change
> virtqueue size, get_vq_num_min and get_vq_num_max will return the same
> value, so that users can choose a correct value for that device.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/linux/vdpa.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index a896ee021e5f..30864848950b 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -171,6 +171,9 @@ struct vdpa_map_file {
>   * @get_vq_num_max:            Get the max size of virtqueue
>   *                             @vdev: vdpa device
>   *                             Returns u16: max size of virtqueue
> + * @get_vq_num_min:            Get the min size of virtqueue (optional)
> + *                             @vdev: vdpa device
> + *                             Returns u16: min size of virtqueue
>   * @get_device_id:             Get virtio device id
>   *                             @vdev: vdpa device
>   *                             Returns u32: virtio device id
> @@ -266,6 +269,7 @@ struct vdpa_config_ops {
>         void (*set_config_cb)(struct vdpa_device *vdev,
>                               struct vdpa_callback *cb);
>         u16 (*get_vq_num_max)(struct vdpa_device *vdev);
> +       u16 (*get_vq_num_min)(struct vdpa_device *vdev);
>         u32 (*get_device_id)(struct vdpa_device *vdev);
>         u32 (*get_vendor_id)(struct vdpa_device *vdev);
>         u8 (*get_status)(struct vdpa_device *vdev);
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
