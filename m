Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A61C07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 07:26:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AC56145D
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 07:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AC56145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DBFE40409;
	Mon,  5 Jul 2021 07:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4dJFLWMoVfNG; Mon,  5 Jul 2021 07:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6A1140408;
	Mon,  5 Jul 2021 07:26:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 933A8C001A;
	Mon,  5 Jul 2021 07:26:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08CF0C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAA28401A4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hI4m0mJQgrRb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:26:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 297E6400B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625469987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9vs1YPIv2blq9FC78Zp91jCknQ/u9T8kZKZmeKaZRA=;
 b=f6pNER3XwifOx80jTy0AW5kYV74j3FWMxz6H5TDsfdxA51ekw0Pj1IiRVyuTsPxSGKoxH8
 SiaPitmTui5UIAhb2e9fKG7IEeDaYzONzHgmcx4CgVzRFULgKGTm5n2XM4BxWgU1x0juzW
 r2pOUbtOYP/5lur7zpTogevEz0hSwYg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-CYH9pMhKMFWvM9XFkCrgjg-1; Mon, 05 Jul 2021 03:26:26 -0400
X-MC-Unique: CYH9pMhKMFWvM9XFkCrgjg-1
Received: by mail-wm1-f71.google.com with SMTP id
 k8-20020a05600c1c88b02901b7134fb829so2810562wms.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l9vs1YPIv2blq9FC78Zp91jCknQ/u9T8kZKZmeKaZRA=;
 b=UwZcThPrH7qRz+JPBgBMsPykjv9wn5CEtHXoOg8zY4j+SnXHZrTR34nSubglC5lPvC
 F7pGBI1Q/Nqge/C56FtCEOvs115BE2SDu+xJ1BCfe5opTbNHYqqHbevHc58rZrrkKTsA
 H8x4LXv5M1cORXtwvUGhl5gMfbXU5IF3oivKsvKClM+4rgi80eXuwWyML5uBcX9kTRz/
 aGdeO4Dp6TpkHedHGAonxrvZ41LsEhy7RSEjQX10XI/+851lX+AGkV8kvj4FWpfAdboy
 Ga1gHJDFfI4vnxrMVzjgJZqw6lz8LM4blfS3B5kJvPgf1JENOtizyOlYR2Uj33UK9ti8
 WOkQ==
X-Gm-Message-State: AOAM53315w20BgUCh1rfezhlgsAz4/J+SrIU2oobMJEhG9y6vxqe2YZ2
 +NfTQt7LuVJnFd4GKA6q88SpsLmRWcxeamtoZs0yPTKSL7HW6HG4vAGD0BOfoyit5OZEbshubyS
 yFUYI9X/uTNRyga+zTi05HxrE8JXdXM0bVtVdf1tYpw==
X-Received: by 2002:a05:6000:1b90:: with SMTP id
 r16mr6213098wru.316.1625469985642; 
 Mon, 05 Jul 2021 00:26:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX5s9gwqr/+i2PIcE3RNqcoNcbUIAVBtfFh7ejuMNIPfYUynbufqlpSdfdzmg6iRoFqGsfdA==
X-Received: by 2002:a05:6000:1b90:: with SMTP id
 r16mr6213084wru.316.1625469985468; 
 Mon, 05 Jul 2021 00:26:25 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id n7sm19896668wmq.37.2021.07.05.00.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 00:26:25 -0700 (PDT)
Date: Mon, 5 Jul 2021 03:26:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vdpa: vp_vdpa: don't use hard-coded maximum
 virtqueue size
Message-ID: <20210705032602-mutt-send-email-mst@kernel.org>
References: <20210705071910.31965-1-jasowang@redhat.com>
 <20210705071910.31965-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210705071910.31965-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 stefanha@redhat.com
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

On Mon, Jul 05, 2021 at 03:19:10PM +0800, Jason Wang wrote:
> This patch switch to read virtqueue size from the capability instead
> of depending on the hardcoded value. This allows the per virtqueue
> size could be advertised.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

So let's add an ioctl for this? It's really a bug we don't..

> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 2926641fb586..198f7076e4d9 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -18,7 +18,6 @@
>  #include <linux/virtio_pci.h>
>  #include <linux/virtio_pci_modern.h>
>  
> -#define VP_VDPA_QUEUE_MAX 256
>  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
>  #define VP_VDPA_NAME_SIZE 256
>  
> @@ -197,7 +196,10 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>  
>  static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa, u16 qid)
>  {
> -	return VP_VDPA_QUEUE_MAX;
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +
> +	return vp_modern_get_queue_size(mdev, qid);
>  }
>  
>  static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
