Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2FAC43217
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 05:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF81760BEA;
	Wed, 12 Oct 2022 05:02:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF81760BEA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MC3zChDN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MlSxl6beY1wg; Wed, 12 Oct 2022 05:02:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BE3160BE2;
	Wed, 12 Oct 2022 05:02:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BE3160BE2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25D19C0033;
	Wed, 12 Oct 2022 05:02:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9183BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 05:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63C1E417A5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 05:02:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63C1E417A5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MC3zChDN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CRx-tAZj2T5X
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 05:02:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AC2241772
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AC2241772
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 05:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665550953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUdzXlZRbmm8fLOWLU5kjEhw2Wcvma+a+WOCKqncy0w=;
 b=MC3zChDNbwaw5NtA9tq2JdRwCqiMhk69RnPvEBA1V5P6MlgkZoQJruosZRh00v6sx+WfGf
 bK7Gz+YBGqV6ZgoWyAwJdv/ER64AJt8yOoslJNRxWyboSkLS2y6nJVhXHwVk/lM1SJ8nwC
 RBOBGVimmxEtmn950YOV8lCW935Qou4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-OxTUxnZtN82fW2aqVHj-Cw-1; Wed, 12 Oct 2022 01:02:32 -0400
X-MC-Unique: OxTUxnZtN82fW2aqVHj-Cw-1
Received: by mail-wr1-f69.google.com with SMTP id
 n8-20020adf8b08000000b0022e4d3dc8d2so4476496wra.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 22:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUdzXlZRbmm8fLOWLU5kjEhw2Wcvma+a+WOCKqncy0w=;
 b=udX/xjCtm3JNL2HuAfQQiRLbkclGhGkyG5y5Dq+V6hTMYPMpz0iHI/9UcB2beLN85m
 2wXgkmDW8l+IfTAkkWwfq9/l+mqvLgttvkKHxSyHQeDBAx5B3XHoO9I4R2xyCsLHzaT/
 SXKVAp+1zKo8Wa36gg+x2CrN8ipVK9YeH0eXjJfCZGgNl/UwYiRpyWnbItOEqgrhyo2l
 SnNoPKkkn1koZOypNtbaar1Pbm5bngA8aKW5prGbLHT1awnHUonKrl5b0LlpSKeQZPbd
 /HsPUUgy+GJy+widZnW1akQcFWvYr6H1ewP9uyJKu81C1p0yi0+MmgrEqQLigaRETpJh
 YW8w==
X-Gm-Message-State: ACrzQf1H2R2bDr2aZljWx0bDENenyDKi9L8DaE4ojoc1LIn42m0IuGSC
 srOIEx01pWSnoc22S/kMcT3ESVAGLSVKBzWP3r4lFfeoHN276tW59QFq7d1ygBhEvC4kCt8iRtL
 HCoIz0n/kHdF4zjmtFvSymlKjz/NaIxDFBq/OudeAjw==
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id
 hg24-20020a05600c539800b003c3dccf2362mr1446657wmb.89.1665550951590; 
 Tue, 11 Oct 2022 22:02:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43nJw2V0KYBPwQaTZ96tpYNyEooqrzualAwt0QthTQBlgIdKki5aOgTWjuEDbQb+l61Dez7g==
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id
 hg24-20020a05600c539800b003c3dccf2362mr1446644wmb.89.1665550951350; 
 Tue, 11 Oct 2022 22:02:31 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 m6-20020a1c2606000000b003c452678025sm764640wmm.4.2022.10.11.22.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Oct 2022 22:02:30 -0700 (PDT)
Date: Wed, 12 Oct 2022 01:02:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Message-ID: <20221012010143-mutt-send-email-mst@kernel.org>
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220928234008.30302-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
> This is instead of re-writing the same logic in virtio driver.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Dropped this as it caused build failures:

https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com

> ---
>  drivers/virtio/virtio_pci_common.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index ad258a9d3b9f..67d3970e57f2 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -607,7 +607,6 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>  {
>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>  	struct virtio_device *vdev = &vp_dev->vdev;
> -	int ret;
>  
>  	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>  		return -EBUSY;
> @@ -615,19 +614,7 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>  	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>  		return -EINVAL;
>  
> -	if (pci_vfs_assigned(pci_dev))
> -		return -EPERM;
> -
> -	if (num_vfs == 0) {
> -		pci_disable_sriov(pci_dev);
> -		return 0;
> -	}
> -
> -	ret = pci_enable_sriov(pci_dev, num_vfs);
> -	if (ret < 0)
> -		return ret;
> -
> -	return num_vfs;
> +	return pci_sriov_configure_simple(pci_dev, num_vfs);
>  }
>  
>  static struct pci_driver virtio_pci_driver = {
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
