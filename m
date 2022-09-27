Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F9EC6FA86
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 04:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C803C60F97;
	Tue, 27 Sep 2022 04:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C803C60F97
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T2kq8cnG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CizfKW8RNxJi; Tue, 27 Sep 2022 04:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 60F5060F95;
	Tue, 27 Sep 2022 04:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60F5060F95
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A9CDC0032;
	Tue, 27 Sep 2022 04:38:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B658C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC2D1408A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:38:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC2D1408A9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T2kq8cnG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPf3xO1yaKR3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC14E4089D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC14E4089D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664253497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvoMQQlEryHzODM1sEcbq2UTTJwK38dUW+JesBnUtoI=;
 b=T2kq8cnGJCfK7RyuE4xfAG50U9HtpGtT9pN2o/22kNSWQPO7ByPDkQ6KDaZjJG79UVr0Rc
 CARn5V60f3y+DV5T/zx1cxYZDycaXbzeIdT8CpEts0K/3EsMak7QY0NvCxPk1BjgzJeEY6
 Iz8IXOL8i2HWH9no/xMBiJF9Sq0mPtI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-W-dn0h5-MAeqk1W-yJSPig-1; Tue, 27 Sep 2022 00:38:15 -0400
X-MC-Unique: W-dn0h5-MAeqk1W-yJSPig-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-130ee3fa853so2204065fac.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 21:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=YvoMQQlEryHzODM1sEcbq2UTTJwK38dUW+JesBnUtoI=;
 b=BP9DTj0L+X0nlpHQW0H0K+az+N19BS+Q8388nVhkt8TQdcktED2aBMgcki0Vi6bM9O
 OIwth/HsEZj3VtQ//oGOKMNN7RRdnwQzLgu787wsQYSJqVCQWLVyPbPlXGaIounwqNEQ
 OLgldQkIjDJuHksI3qKrq2ew9vxvOVQ+v4KbyxNAgb5S4hOnyXL8zqETCpEG9qUA8o2q
 3Hs1Max7i14g3YlmSMHAFjsZcyjv3VL9msjj60tIFGzMibCoVsRdZTN1wkvj8eOxlTmH
 niFZ14ZCpavpY/oIQlVmp3yX7i1+cVnmVoEw1rLHZSXa8lgrGuQ1JEDzy3qoeaPuYsMl
 BFNQ==
X-Gm-Message-State: ACrzQf2bMnd7GlUFEVQLF3FfkI1wykbbphSGuP2ClisVpexF1EHm9l1N
 w+5ULoNClQLgdlx5AOHRnFvCJUFpkJScPMljAzfMi6GHn4QIxdkBiWZn9PhIQUzaPyezywbJZGV
 41j3omflDe2c6N/4d1IWWygqPeZXRdo5cMR+EWjmoDHWH1uvBrqyxenDFQg==
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr947693oib.35.1664253494787; 
 Mon, 26 Sep 2022 21:38:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Y2cfb+vwgFJjFYaenS5cjGkB+F68aaugASVk8P/h+ix7i0pb9U9SgX0ojSutoniNgQV3lWGR/xhFLwDhdg2E=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr947690oib.35.1664253494632; Mon, 26
 Sep 2022 21:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220927030117.5635-1-lingshan.zhu@intel.com>
 <20220927030117.5635-4-lingshan.zhu@intel.com>
In-Reply-To: <20220927030117.5635-4-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Sep 2022 12:38:03 +0800
Message-ID: <CACGkMEs3C==_sJBC94enpj=4a9KxDbFKcwMsCsECbPn2QYBv4w@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 3/6] vDPA: check VIRTIO_NET_F_RSS for
 max_virtqueue_paris's presence
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, mst@redhat.com
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

On Tue, Sep 27, 2022 at 11:09 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> virtio 1.2 spec says:
> max_virtqueue_pairs only exists if VIRTIO_NET_F_MQ or
> VIRTIO_NET_F_RSS is set.
>
> So when reporint MQ to userspace, it should check both
> VIRTIO_NET_F_MQ and VIRTIO_NET_F_RSS.
>
> unused parameter struct vdpa_device *vdev is removed
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index e7765953307f..829fd4cfc038 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -800,13 +800,13 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>         return msg->len;
>  }
>
> -static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> -                                      struct sk_buff *msg, u64 features,
> +static int vdpa_dev_net_mq_config_fill(struct sk_buff *msg, u64 features,
>                                        const struct virtio_net_config *config)
>  {
>         u16 val_u16;
>
> -       if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
> +       if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0 &&
> +           (features & BIT_ULL(VIRTIO_NET_F_RSS)) == 0)
>                 return 0;
>
>         val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
