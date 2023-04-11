Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF6EC7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 06:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFC7981E12;
	Tue, 11 Apr 2023 06:29:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFC7981E12
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hra8B2eC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFwUL2bK6qcI; Tue, 11 Apr 2023 06:29:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 582BB81E10;
	Tue, 11 Apr 2023 06:29:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 582BB81E10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 307B1C0037;
	Tue, 11 Apr 2023 06:29:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D8A9C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 552A181E12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 552A181E12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JuGhvALkxTsO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:29:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86B5281E10
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86B5281E10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681194586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oSR/BoPrTP4dM6eEMbqNicTKlgGAh6IQScE+JTRaUCI=;
 b=Hra8B2eCWiJ6BdeclaIvYpWFdv1Yuk6cRegWMdaj6GhlrolKkaEfbYcFT10240nA2mnu6k
 5xaXtIZ5NpGUs/QxUDJ4tWuCxS/sef6kbGllsxWD1obVoyRpB4+K/bW68s9w8zpa0YWyZb
 T/57KP+tOdmd7EZKPkiohNP2TcN5+9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-pWBuj2_rPleJ5hzS3Ttqzg-1; Tue, 11 Apr 2023 02:29:43 -0400
X-MC-Unique: pWBuj2_rPleJ5hzS3Ttqzg-1
Received: by mail-wm1-f70.google.com with SMTP id
 m7-20020a05600c3b0700b003ee112e6df1so1315781wms.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 23:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681194582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSR/BoPrTP4dM6eEMbqNicTKlgGAh6IQScE+JTRaUCI=;
 b=BS1gz7HNVefgTLWq+H4Je9awN85VwEMmXOqxv+D0xI36pWtwCID4Uev0+HIEYH0tU+
 64/due3QI3v7BkRscHlEp/FbWo/0YMXJ8WKCT5yFO4gI8K0sirGke/JpOFLbAahtqoTs
 2jxky7W1QksDRgrEpCgk4ZYn4gTyF+GNT6PrEZw1jliKbO7NSm71jUt6HNQC1u8pqdvf
 kQ6b74bptnq1aUb0LyAAjvasmXhFKZFis7QHdcFGbVu9gooTZOvsipimF7xeMxHw/dr/
 TM2TuZqOz3oPFFsRUEqsve7plIDcwAc9/CSn6VvKEa+ONVxkOtcFxr4WjHoWrIsp7DQh
 NRIw==
X-Gm-Message-State: AAQBX9e6sudaoShsIL52prke8Hpu5EAi0bGs5QIGu8XYzWP7fVsiWpoB
 QfxldNAaAJ+B7gflZG+6Uwkoye5nJXSwo1CCsSl3ou+ARgftQUOnV4qToeenHNpRb+8TGznLgsk
 vUS4laXE3hkvvt4LZz5z4EkqieqqxaQiBGMrPDyawf+7ssHiz4Q==
X-Received: by 2002:a05:600c:3786:b0:3eb:3104:efec with SMTP id
 o6-20020a05600c378600b003eb3104efecmr6103019wmr.16.1681194581882; 
 Mon, 10 Apr 2023 23:29:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZMnDmXJKwVPTFLe5E+xPCjkP07zR84RGkXb1tNKi76IBa8wNnsmfGG09/OTcO4lFwDkKN4+Q==
X-Received: by 2002:a05:600c:3786:b0:3eb:3104:efec with SMTP id
 o6-20020a05600c378600b003eb3104efecmr6103012wmr.16.1681194581491; 
 Mon, 10 Apr 2023 23:29:41 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 m30-20020a05600c3b1e00b003ef5deb4188sm19722538wms.17.2023.04.10.23.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 23:29:40 -0700 (PDT)
Date: Tue, 11 Apr 2023 02:29:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411022329-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Apr 11, 2023 at 09:38:32AM +0800, Angus Chen wrote:
> We read the status of device after reset,
> It is not guaranteed that the device be reseted successfully.

Sorry not guaranteed by what? I am guessing you have a legacy device
that does not reset fully on write, and you need to wait?

> We can use a while loop to make sure that,like the modern device did.
> The spec is not request it ,but it work.
> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

Generally I don't much like touching legacy, no telling what
that will do. Case in point, is your device a pure
legacy device or a transitional device?

> ---
>  drivers/virtio/virtio_pci_legacy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2257f1b3d8ae..f2d241563e4f 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -14,6 +14,7 @@
>   *  Michael S. Tsirkin <mst@redhat.com>
>   */
>  
> +#include <linux/delay.h>
>  #include "linux/virtio_pci_legacy.h"
>  #include "virtio_pci_common.h"
>  
> @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	vp_legacy_set_status(&vp_dev->ldev, 0);
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
> -	vp_legacy_get_status(&vp_dev->ldev);
> +	while (vp_legacy_get_status(&vp_dev->ldev))
> +		msleep(1);

The problem with this is that it will break surprise
removal even worse than it's already broken.


>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
