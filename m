Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A514EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Jul 2022 11:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19CA5400CE;
	Tue, 19 Jul 2022 11:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19CA5400CE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E6ozbs9v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 938909QGfhlD; Tue, 19 Jul 2022 11:56:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F9FD40B57;
	Tue, 19 Jul 2022 11:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F9FD40B57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60FEBC0035;
	Tue, 19 Jul 2022 11:56:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3649C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 11:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7D6B830C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 11:56:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7D6B830C0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E6ozbs9v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50gNQ9ByOuXS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 11:56:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 025868308B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 025868308B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 11:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658231775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I1KTsZFixJ+o97iKP2ncjBSYXhYH2jprWjMoHsMt0Ik=;
 b=E6ozbs9vsxs1qQGOY67qGRVFB6lMmgAyjPvWX5JWV+SqWMUS2jP3snEVXPgI2woPU0mCEQ
 72dbn9vRVkd/AU6yocq+94UeKCs9sNSztc/8oTqqhmkAMdi57VZoWc/YTFJDrUVI/A3fuh
 IxHekYPoTFVFOOqTKoP2xKnGLpizVd8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-3yYxw3HKPT2MtIDRkbU81Q-1; Tue, 19 Jul 2022 07:56:14 -0400
X-MC-Unique: 3yYxw3HKPT2MtIDRkbU81Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 f9-20020a056402354900b0043a902b7452so9703609edd.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 04:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I1KTsZFixJ+o97iKP2ncjBSYXhYH2jprWjMoHsMt0Ik=;
 b=lcH5Z/Zs0I0uuY6xtcKhJndTwPrAi+uDBLmPoHHTG1/Z5PCNwiVMkRNm8CW3G60VQH
 2esbAcQZjpk3h4aO0YJyicCKKtNjro/3gyOKeTDShxUQrjKqMXIKmaTDMHQJd2at3rN2
 YfFfrEkq3PA2i9HU3yR0vtMIaIKjpqlQsvacLXn8vcvILAA/e04kCECQWLku6iIdk4xK
 RpILsks6C+4wEWXzW1BsaYCpyN+bt/371V1MBpAz6rFREnDZCXa29vf90GTznKf+dyPl
 8ZxK00fpisz3apOJqXcEqS13nDxYjEIBmG0a5dpycap/2GIM8LeYD9fFCcRuQd6RmR6J
 FG+A==
X-Gm-Message-State: AJIora9fZsh+pvwp7CNoEFW1UGjJ3VXMWln6prcOUaete6pexgUHirut
 hjqllbWNAyoUji4dwDzTUZuratH/DF5tIQdQJ/VxwMISvzdVA+uJ01gneDqL2faTveL7e/QA2i3
 LNNi46ZU5WVdSopOKeuF4QSWhtajQSKZ+edxCvtcPeQ==
X-Received: by 2002:aa7:c0c4:0:b0:43a:20cf:3c68 with SMTP id
 j4-20020aa7c0c4000000b0043a20cf3c68mr43811834edp.172.1658231773259; 
 Tue, 19 Jul 2022 04:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIlp8Z82V49PuiO1hwXvHoZ//n+lr0dXOdhOppU3nk5LuUcwp4ZCXhdr7YYQkvNbC+bnR/zw==
X-Received: by 2002:aa7:c0c4:0:b0:43a:20cf:3c68 with SMTP id
 j4-20020aa7c0c4000000b0043a20cf3c68mr43811817edp.172.1658231773057; 
 Tue, 19 Jul 2022 04:56:13 -0700 (PDT)
Received: from redhat.com ([2.55.46.60]) by smtp.gmail.com with ESMTPSA id
 x7-20020a05640225c700b0043ac761db43sm10242169edb.55.2022.07.19.04.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 04:56:12 -0700 (PDT)
Date: Tue, 19 Jul 2022 07:56:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keir Fraser <keirf@google.com>
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <20220719074941-mutt-send-email-mst@kernel.org>
References: <20220719100256.419780-1-keirf@google.com>
MIME-Version: 1.0
In-Reply-To: <20220719100256.419780-1-keirf@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
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

On Tue, Jul 19, 2022 at 10:02:56AM +0000, Keir Fraser wrote:
> If virtio devices are tagged for "restricted-dma-pool", then that
> pool should be used for virtio ring setup, via the DMA API.
> 
> In particular, this fixes virtio_balloon for ARM PKVM, where the usual
> workaround of setting VIRTIO_F_ACCESS_PLATFORM in the virtio device
> doesn't work because the virtio_balloon driver clears the flag. This
> seems a more robust fix than fiddling the flag again.
> 
> Signed-off-by: Keir Fraser <keirf@google.com>


So the reason balloon disables ACCESS_PLATFORM is simply
because it passes physical addresses to device and
expects device to be able to poke at them.

I worry about modifying DMA semantics yet again - it has as much of a
chance to break some legacy configs as it has to fix some.


And I don't really know much about restricted-dma-pool but
I'd like to understand why does it make sense to set it for
the balloon since it pokes at all and any system memory.


> ---
>  drivers/virtio/virtio_ring.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a5ec724c01d8..12be2607c648 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -12,6 +12,7 @@
>  #include <linux/hrtimer.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/spinlock.h>
> +#include <linux/swiotlb.h>
>  #include <xen/xen.h>
>  
>  #ifdef DEBUG
> @@ -248,6 +249,13 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	if (!virtio_has_dma_quirk(vdev))
>  		return true;
>  
> +	/* If the device is configured to use a DMA restricted pool,
> +	 * we had better use it.
> +	 */
> +	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
> +	    is_swiotlb_for_alloc(vdev->dev.parent))
> +		return true;
> +
>  	/* Otherwise, we are left to guess. */
>  	/*
>  	 * In theory, it's possible to have a buggy QEMU-supposed
> -- 
> 2.37.0.170.g444d1eabd0-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
