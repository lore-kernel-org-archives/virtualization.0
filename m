Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74594C6FA91
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 02:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED23F4177A;
	Tue, 20 Sep 2022 02:17:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED23F4177A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gx2uTR2B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwXskDPoB8IC; Tue, 20 Sep 2022 02:17:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 184054175D;
	Tue, 20 Sep 2022 02:17:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 184054175D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB4F6C0032;
	Tue, 20 Sep 2022 02:16:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A65AAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E5A640469
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:16:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E5A640469
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gx2uTR2B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xQKTHic7p4tf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:16:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 675E94041C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 675E94041C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663640212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zo86NMsPHctYgO0mGry59i4eN15QEnWKnYhNdcDx8JY=;
 b=Gx2uTR2BT0OnH9Fq1xJfQ3ESaDaCCG9trn8mTUmHnMcdjVggV+4YTqnVVI4vrii0Je9EkQ
 lCXn67DOnlUhYJMfLMewA1XlIQBM7rW4f76PvzZvrgqhTJQ7f0p2OKDM2nnm3voTxwo0+0
 0g8ijastVtz3Ipu7/1k74z4x76h1yPw=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-aLarGN_EP_6SbO6NWNtgjQ-1; Mon, 19 Sep 2022 22:16:47 -0400
X-MC-Unique: aLarGN_EP_6SbO6NWNtgjQ-1
Received: by mail-vk1-f199.google.com with SMTP id
 t132-20020a1faa8a000000b003a23bef3680so341109vke.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 19:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Zo86NMsPHctYgO0mGry59i4eN15QEnWKnYhNdcDx8JY=;
 b=zK1yFa+Dd+aY56sw3HXyjhyYEhQloMlDNKflus6976VFaKlsBmy0GPf/KVB8O8u6kO
 oUjw8CoOkV+XSjxSe34vmsvXdUp94IbrvUdpdAj2UvbralcdRdYF9NmZllQRm9nJRyjb
 p0O27AXnStEcQE1VmctU6UPP85ohKXgw2fX9uhNQg05eBnLzGapoqeBR0YLqaoDVAQtM
 7itQkjHRBs9unSExOAs1tXAos98oxRUg4rVRrp2zIh9bBznsM3PIkq4nn+rf4/QzdHpn
 9egtswwbbvCSpOJtLxXb5IkQEWmATpuALbZ67dcNi75VDWLNovc7ss/NOpv+RI6KPLgX
 278g==
X-Gm-Message-State: ACrzQf0Qucme5NfqnVmL57O8OOSgZrYFAjeS+FjOrOoPgOQ78fa7x+8U
 5TeQBp7HkN0HJvfGmy80r21vxljqT35o782Ze0mr3E4WedHaiAqr8nYsm3ToTARwAEiCQB2VLYO
 kVq4aHvLBGN70R+M2K6fjEVFlNVRoIgTLDT3Cg19bx8WzG8gqkAPbR4IzbQ==
X-Received: by 2002:a67:e218:0:b0:398:4d8c:8037 with SMTP id
 g24-20020a67e218000000b003984d8c8037mr7419390vsa.4.1663640205513; 
 Mon, 19 Sep 2022 19:16:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7FViMHfT3HYQIWmkPbYd8yvNIQikjkhJmN/lsyJbFbvnrbHHcisI8cT5S05cjpkvJJbjMWFTxmicgwYqVdCPA=
X-Received: by 2002:a67:e218:0:b0:398:4d8c:8037 with SMTP id
 g24-20020a67e218000000b003984d8c8037mr7419382vsa.4.1663640205244; Mon, 19 Sep
 2022 19:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085712.46006-1-lingshan.zhu@intel.com>
 <20220909085712.46006-3-lingshan.zhu@intel.com>
In-Reply-To: <20220909085712.46006-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Sep 2022 10:16:33 +0800
Message-ID: <CACGkMEsYARr3toEBTxVcwFi86JxK0D-w4OpNtvVdhCEbAnc8ZA@mail.gmail.com>
Subject: Re: [PATCH 2/4] vDPA: only report driver features if FEATURES_OK is
 set
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>
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

On Fri, Sep 9, 2022 at 5:05 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> vdpa_dev_net_config_fill() should only report driver features
> to userspace after features negotiation is done.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 798a02c7aa94..29d7e8858e6f 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -819,6 +819,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         struct virtio_net_config config = {};
>         u64 features_device, features_driver;
>         u16 val_u16;
> +       u8 status;
>
>         vdev->config->get_config(vdev, 0, &config, sizeof(config));
>
> @@ -834,10 +835,14 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>                 return -EMSGSIZE;
>
> -       features_driver = vdev->config->get_driver_features(vdev);
> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> -                             VDPA_ATTR_PAD))
> -               return -EMSGSIZE;
> +       /* only read driver features after the feature negotiation is done */
> +       status = vdev->config->get_status(vdev);
> +       if (status & VIRTIO_CONFIG_S_FEATURES_OK) {

Any reason this is not checked in its caller as what it used to do before?

Thanks

> +               features_driver = vdev->config->get_driver_features(vdev);
> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> +                                     VDPA_ATTR_PAD))
> +                       return -EMSGSIZE;
> +       }
>
>         features_device = vdev->config->get_device_features(vdev);
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
