Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BD2C07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 04:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59EE3418A8;
	Tue, 27 Sep 2022 04:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59EE3418A8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHo3g7hq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hR6cjrLdemVj; Tue, 27 Sep 2022 04:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9849341895;
	Tue, 27 Sep 2022 04:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9849341895
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 803F4C0032;
	Tue, 27 Sep 2022 04:38:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D53AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37B6081BA8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:38:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37B6081BA8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHo3g7hq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ebQdc82OSrgM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:38:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78E2A81B71
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78E2A81B71
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664253519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZzmX/LZpNg3sCgzTfVweFFRT/JxjvUTK3cLB50DJXY=;
 b=UHo3g7hqJ62+/NJHdZ/3j9yEO43SwLrKGqJGHbe+rv0//IYlo39Xq66yzv4g1orH9em+Aq
 wAMY1Kfgc060iAVMC1Tmvnxg6Z6YR3jxN1KcvGTP3ZcCVMDlFXGee4t5InB6joVIMHoJEl
 WLW/OtvP4xA2GnuBbeXOhqs7F5dT91s=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-d2WgJz1YNBq77CduvSfvkA-1; Tue, 27 Sep 2022 00:38:38 -0400
X-MC-Unique: d2WgJz1YNBq77CduvSfvkA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-126994ebbaeso3092346fac.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 21:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=LZzmX/LZpNg3sCgzTfVweFFRT/JxjvUTK3cLB50DJXY=;
 b=Q9JPNwqm//Jw2CcUb6d11ReotTufX4p4O+gKKTihBkQwLkrNDEadacEDWHYT9Cjjht
 +uHHKeZctt6mIewIVyWYj1Vf8Jq9mzkiKrv5gIHquUx9iL2zotOASvL9nRxRC6reRviU
 HUO6PmN9HfOTl25SS+fFWaCyld5uffcDaabuBtwHzy0kq6FtKWwuoszWmi8AWRorFO6x
 8ngQmUwQj5g6Y6B5saTUnoWfgteJBJ97Ses3f4I4l592EtFQeHG+3CHE+ma4Idjxah/W
 xXhh9oEABrTTdcAZLzCmHL/i88hLwWOcqdmXJ40F+gSPyhOvwXiHCTHz+B8Z+RntiRDC
 YT8A==
X-Gm-Message-State: ACrzQf353fKct1iMOgOX6ZGJPwhacGKJ/Zpnh5kBZcmiB/r3Kk89MLC9
 Hr/KI6FxJJZOa241N3DPEtjAWnkBggV9Xef2xA4Ios7SRXUbt9T/g32ACpzL55MeCki++Ys2qhJ
 WDYsrwHKQt7T3/eKn9Jl8eFi+P0i+qntdV/xThdvFbTL20iXLENwSEHzSmQ==
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr1098030oag.280.1664253517664; 
 Mon, 26 Sep 2022 21:38:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6KWLqfJGIYu2DMf98dx7P5bJF0eOmO5aC9XWtZcg5CfjpovBHj6fifEe189yrHy4f3HtwIm3fQ26DaUdD8y+0=
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr1098021oag.280.1664253517451; Mon, 26
 Sep 2022 21:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220927030117.5635-1-lingshan.zhu@intel.com>
 <20220927030117.5635-5-lingshan.zhu@intel.com>
In-Reply-To: <20220927030117.5635-5-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Sep 2022 12:38:26 +0800
Message-ID: <CACGkMEuzee5cuEhkPVduvesFEo7FfXWOmxHf70bN4JWp7Zi0GQ@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 4/6] vDPA: check virtio device features to
 detect MQ
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
> vdpa_dev_net_mq_config_fill() should checks device features
> for MQ than driver features.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 829fd4cfc038..84a0c3877d7c 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -839,7 +839,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>                               VDPA_ATTR_PAD))
>                 return -EMSGSIZE;
>
> -       return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver, &config);
> +       return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>  }
>
>  static int
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
