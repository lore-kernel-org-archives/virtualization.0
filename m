Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216A2C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 04:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA47341815;
	Wed,  6 Jul 2022 04:05:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA47341815
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MVXrEcQM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4-DdjAYgKv37; Wed,  6 Jul 2022 04:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A74DB40887;
	Wed,  6 Jul 2022 04:05:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A74DB40887
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86B7FC0077;
	Wed,  6 Jul 2022 04:05:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE615C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C894A60C2D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:05:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C894A60C2D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MVXrEcQM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kM5BSE1h6Zqo
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:04:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B1DD60B14
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B1DD60B14
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657080297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k07HRFbOFiUBUdfl6xSh6EEBnHPKszbgl4EpE1PM/GE=;
 b=MVXrEcQM77TH3lKvfn2NFkuKwa7PkpKCnJq96fzYbcsiYk58qpf+uvwuu8jyUT4bOR14JG
 HQveHxEIMoluZ8u6BSw6xNJ+qqCxPjhKXj8hYGjygt8Ng35keZ54QfYt0AE3RoMva5X6RW
 kOxwgFFuO+A4IV33cZjypvH5i9zPr5c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-bH58_ZP0Nqag2yFHLlfOJw-1; Wed, 06 Jul 2022 00:04:56 -0400
X-MC-Unique: bH58_ZP0Nqag2yFHLlfOJw-1
Received: by mail-lf1-f70.google.com with SMTP id
 y8-20020ac24208000000b0047f9fc8f632so4671490lfh.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jul 2022 21:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k07HRFbOFiUBUdfl6xSh6EEBnHPKszbgl4EpE1PM/GE=;
 b=MmmXIfoWIPzHo1mV251Ou9ovqEbkEiRCc/GnwZ6LhVnwVK0fc0YgkfhQY9BZFae3th
 FCxCZDxovzUdcazclp5IBHiVJ5B3vxUK31nZYk7+MOBzV4r16KdEjnAicCLdPYyyvGoI
 TYaQLx5iWeX3GmEE10pHayS5ze/i55bxEfGX5h7QLBS91Psz5nHvJf/wyR1gJxc6v71Z
 ltC7kOp+S4fWUgsoTBt5SWsMPOaPM9UPK0eh0IPVfIgPi6Yue2dyORuKfJLseNk9mlLH
 OCPMLAytddN1zuSQATc8eHa2ErB3Gv4SeJ1iUvgzxXue1EgFdHmr1u9kO9itc5X7v5aD
 9AFA==
X-Gm-Message-State: AJIora/mZWfaocZiBSy6ItqEvBsrJq+EoZDLTbuEJcGfZcv8vE036ofW
 i6mCdtUdE93HDdu6BA2vUty0nJoxSXREfP+/rAMZvbBYKFrqSImiSnp2NMmsa79mQGJEgIPeFoh
 IrLqmLlIm2blgNePbxZ4eZYzHgp2EMkYTVCotbkfhQasNN0XcFQ24b203UA==
X-Received: by 2002:a2e:9043:0:b0:25d:1ba8:5b59 with SMTP id
 n3-20020a2e9043000000b0025d1ba85b59mr9509168ljg.496.1657080294314; 
 Tue, 05 Jul 2022 21:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vIYFZhrA46WES5xcvLJavARz+fvVIjuPHJ6w8X3S/rWD6vBSkXFusl9QD1gav74vumzK33/Sw+eUpd8qdpHeI=
X-Received: by 2002:a2e:9043:0:b0:25d:1ba8:5b59 with SMTP id
 n3-20020a2e9043000000b0025d1ba85b59mr9509155ljg.496.1657080294118; Tue, 05
 Jul 2022 21:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220704024104.15535-1-jiaming@nfschina.com>
In-Reply-To: <20220704024104.15535-1-jiaming@nfschina.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Jul 2022 12:04:43 +0800
Message-ID: <CACGkMEvGQ6v6-Td+cK0ew2znqrEcUK6RtT9GUg2S7_-r=HY1Gg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: ifcvf: Fix spelling mistake in comments
To: Zhang Jiaming <jiaming@nfschina.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, renyu@nfschina.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 liqiong@nfschina.com, Yongji Xie <xieyongji@bytedance.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Gautam Dawar <gautam.dawar@xilinx.com>
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

On Mon, Jul 4, 2022 at 10:41 AM Zhang Jiaming <jiaming@nfschina.com> wrote:
>
> There is a typo(does't) in comments.
> It maybe 'doesn't' instead of 'does't'.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 0a5670729412..e2e201885713 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -685,7 +685,7 @@ static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_devic
>  }
>
>  /*
> - * IFCVF currently does't have on-chip IOMMU, so not
> + * IFCVF currently doesn't have on-chip IOMMU, so not
>   * implemented set_map()/dma_map()/dma_unmap()
>   */
>  static const struct vdpa_config_ops ifc_vdpa_ops = {
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
