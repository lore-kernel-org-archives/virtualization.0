Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F13C64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F045B40C84;
	Wed,  8 Mar 2023 14:23:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F045B40C84
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yw4aMdXv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fdrg6jO0Vj3k; Wed,  8 Mar 2023 14:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B90440297;
	Wed,  8 Mar 2023 14:23:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B90440297
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08C62C0071;
	Wed,  8 Mar 2023 14:23:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE1D8C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B83D6813CE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:23:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B83D6813CE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yw4aMdXv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8bdJyffIdFfE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:23:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2EC9813C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2EC9813C6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678285391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AoP9iL/L52lOUsApIPKDlMpUoAOPfrID9FujexdYkCM=;
 b=Yw4aMdXvnLzLUCyjU2huQa90bwueNKK3quCY27koTkPMV3evEgfh45S/+Il2csTzbkyn1i
 aQStiZ6YPQXj9iP6zGuKJ69KcbM4eA1OBLrzXvAYS411J8vICncem2uHJ5ltiNEdUbVfd1
 uXiG3HwMGeC7IRWw7WrWcMI9tgMJ3lI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-mYqlsMnEO2ahu6hSF7OQHA-1; Wed, 08 Mar 2023 09:23:10 -0500
X-MC-Unique: mYqlsMnEO2ahu6hSF7OQHA-1
Received: by mail-wm1-f72.google.com with SMTP id
 l16-20020a05600c1d1000b003e77552705cso863626wms.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 06:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678285389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoP9iL/L52lOUsApIPKDlMpUoAOPfrID9FujexdYkCM=;
 b=O0EV74Wjmt5PNZMnfFClwom1nwNpTIKSLbrcvAqdy5icyoug+oCwf8sxNkcqmKd9hT
 qxNEHoqnKVcHb+w5pb32tCXROXZGxWGENVGbpI6qJNL6q9rrz7BPcdyXmxWbvevXpC/q
 8U1FAWiOJz1zi9frpJpz/7bOyAdwJ2oSjqs3rbxBsPrmAYDIRIIoNRyr1bgMgwkKhh+L
 qEiMPUj41G5zTs/dhA/z7DzP77OFpqPjRXYx7bHxrnUYnXyfOY5CGeoRRRWNrUwMAILc
 CALN5dy0L3YcX2PMzGJ1HkGKAjxOKqKu+tWzVSEKczQIroBnukTyk+i2EsnEiQ5Uram/
 BWHw==
X-Gm-Message-State: AO0yUKUxIBXJmDUcno7gumhjBMuAcmtHkX+k71CjYM2kXUkrLwcUFqSY
 TUqXhmn7ho/ef1vDZo7aHMdeYRCRLfNCjdcOxf4PvjV+gTuhq44tKSm5jOdaLX5iUEWfyF2zlrm
 D6PtoPlFV+uBTQsO7hpDvKSoobfhegQKt+LTpUCf1ig==
X-Received: by 2002:adf:f612:0:b0:2bf:96ae:7cc8 with SMTP id
 t18-20020adff612000000b002bf96ae7cc8mr12102809wrp.4.1678285389478; 
 Wed, 08 Mar 2023 06:23:09 -0800 (PST)
X-Google-Smtp-Source: AK7set/RubMBnJ6A9K81HXfXy8++mtHEEF7r9FBSYwp/tjDOkXn9cYWyQYPuZWwqxzZttG9KyNl0Ow==
X-Received: by 2002:adf:f612:0:b0:2bf:96ae:7cc8 with SMTP id
 t18-20020adff612000000b002bf96ae7cc8mr12102794wrp.4.1678285389132; 
 Wed, 08 Mar 2023 06:23:09 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 s11-20020a5d510b000000b002c55b0e6ef1sm15765682wrt.4.2023.03.08.06.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:23:08 -0800 (PST)
Date: Wed, 8 Mar 2023 09:23:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH 1/3] virtio_pci_modern: Remove unnecessary num zero check
Message-ID: <20230308091704-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-2-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230307035705.4479-2-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

On Tue, Mar 07, 2023 at 05:57:03AM +0200, Feng Liu wrote:
> is_power_of_2() already performs the zero check. Hence avoid duplicate
> check. While at it, move the query of size check also adjacent to where
> its used for the disabled vq.
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Bodong Wang <bodong@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 9e496e288cfa..3d7144f8f959 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -306,10 +306,10 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  		return ERR_PTR(-EINVAL);
>  
>  	/* Check if queue is either not available or already active. */
> -	num = vp_modern_get_queue_size(mdev, index);
> -	if (!num || vp_modern_get_queue_enable(mdev, index))
> +	if (vp_modern_get_queue_enable(mdev, index))
>  		return ERR_PTR(-ENOENT);
>  
> +	num = vp_modern_get_queue_size(mdev, index);
>  	if (!is_power_of_2(num)) {
>  		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
>  		return ERR_PTR(-EINVAL);


As Jason said the right thing to do is to remove the power of 2
limitation. However please don't just hack it up and post,
test it with a variety of queue sizes and with at least
PAGE_POISONING and as many debugging options as you can
to make sure this is not triggering bugs anywhere.

> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
