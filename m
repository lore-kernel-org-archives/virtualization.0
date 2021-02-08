Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9844EC433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:39:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DFB64E6B
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DFB64E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A313F85DCA;
	Mon,  8 Feb 2021 18:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3vag8PUmoOj; Mon,  8 Feb 2021 18:39:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3AAB685C05;
	Mon,  8 Feb 2021 18:39:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20C75C0891;
	Mon,  8 Feb 2021 18:39:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF0CAC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C53F62107D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7P4u4KVAkMz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:38:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 59C362046A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612809534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MNdmFMG6UucVF40jTovWfbzmsjnpVcviTwo15N8yzyY=;
 b=jLwvx8aKlPvFxLxAd/rhhJnQAZVn8Gl0+Hza4qYGfW2dKvFDRjwaAD2Gmi242Whd2/EKCX
 87DKAankz/SFbnvag/5YMuBoG+dpgY7eakjvsX+VHxjdG6e4Hd58fcG8naHnCD6uHXfue3
 un9fyRS26RhCm1LXgbviQhtXPmToBOo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281--Zms4PldPFSYcYi0xTHB4Q-1; Mon, 08 Feb 2021 13:38:53 -0500
X-MC-Unique: -Zms4PldPFSYcYi0xTHB4Q-1
Received: by mail-ed1-f69.google.com with SMTP id f21so11889691edx.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 10:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MNdmFMG6UucVF40jTovWfbzmsjnpVcviTwo15N8yzyY=;
 b=cmi+RV5E0IG/UWiIgLFR73p5tuNR+YKpeXqK8wTLwpdE68Y8++MUvKlWNIoKXssuEZ
 3bHS8Zlf+t5PIneV/dVgUM6lte+RTJM2nxq0pvX1JThyOmHehgmuB8DLYIGFAjQhUXvJ
 IzFpIAJUxwLi3f0b6VMePNn7wM4c4njMJmbtzi3ke/uHGTpT3FeZqMqFXhn7+cYnn+el
 w1Lm6NVJFXH70iJW9V3wU9xEXxSSB94vqQTyVhEk0OUCoQsxYiK00S/Wx0XPVmjkbb0A
 Obvcog2Q0igL0V8etZ/PafUoSheoeuN+H5UfJLgWdbKdVI5KMS1WCmL/r40N4fHyw3NN
 qSog==
X-Gm-Message-State: AOAM533RrEbcqcUJB5Sj/I1WI6mS3+47VYEJZ73lWL2iM+mQa5Sh5ZwY
 QeQ6qQQzhCvk3XtVvzGaIdA/6uyFE8jPEhTcCbo4djPd213/R5R/SHwZHX324DVarvZ3NDa5Bmb
 vmnmMLQEbvamY4h7fGKWNoxMWnEnNI6caaVSwNw+T2A==
X-Received: by 2002:a17:906:f156:: with SMTP id
 gw22mr11877510ejb.406.1612809531880; 
 Mon, 08 Feb 2021 10:38:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIJQXCgypIzsIrWdQRGjav+Gb4F5azrzmqGTldM/lo7PPYFTlalRzDBMMcvQnTQfoKq+bGaA==
X-Received: by 2002:a17:906:f156:: with SMTP id
 gw22mr11877498ejb.406.1612809531730; 
 Mon, 08 Feb 2021 10:38:51 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id n5sm10076219edw.7.2021.02.08.10.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 10:38:50 -0800 (PST)
Date: Mon, 8 Feb 2021 13:38:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210208133312-mutt-send-email-mst@kernel.org>
References: <20210208161741.104939-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210208161741.104939-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
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

On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
> It's legal to have 'offset + len' equal to
> sizeof(struct virtio_net_config), since 'ndev->config' is a
> 'struct virtio_net_config', so we can safely copy its content under
> this condition.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index dc88559a8d49..10e9b09932eb 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  
> -	if (offset + len < sizeof(struct virtio_net_config))
> +	if (offset + len <= sizeof(struct virtio_net_config))
>  		memcpy(buf, (u8 *)&ndev->config + offset, len);
>  }

Actually first I am not sure we need these checks at all.
vhost_vdpa_config_validate already validates the values, right?

Second, what will happen when we extend the struct and then
run new userspace on an old kernel? Looks like it will just
fail right? So what is the plan? I think we should
allow a bigger size, and return the copied config size to userspace.


> -- 
> 2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
