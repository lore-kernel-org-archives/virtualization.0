Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAD1C77B7C
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 11:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CA1260AA0;
	Sun, 28 May 2023 11:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CA1260AA0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SuSNC3jp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TzT5ALLwGjbg; Sun, 28 May 2023 11:28:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19BCC60A88;
	Sun, 28 May 2023 11:28:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19BCC60A88
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E75E7C0035;
	Sun, 28 May 2023 11:28:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3810C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 11:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A97840111
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 11:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A97840111
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SuSNC3jp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DRVOJ1wxqT-9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 11:28:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10D73400D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10D73400D3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685273310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pH6KcqHfCBWuGTuVfMKCDSPJ3g9Xa501cWIRrEMo/I4=;
 b=SuSNC3jpTvwGT3Bc4hr2AZjw0P1K5TNP0BsDSIB672+8cLPHIE1HXu1W5jeOOxo905Q2Nt
 qAL0M2gSlWR4lNOJPYehroZlqIvVPdfxM+Pz6E8Vd/engeYvWma12ZUmXg2T5j9YMNlTI6
 P+0WSgIFRtyUvtb+eg9Ge2a1IRz3CHo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-Kji5CUBaPriFKViuyVHN7g-1; Sun, 28 May 2023 07:28:29 -0400
X-MC-Unique: Kji5CUBaPriFKViuyVHN7g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso15458675e9.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 04:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685273308; x=1687865308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pH6KcqHfCBWuGTuVfMKCDSPJ3g9Xa501cWIRrEMo/I4=;
 b=OgYNHc3wkebJ+X5pbI7UWpByWH/JEokZRMj9VBDPcOccSDVXHSzgw7msqmlb03qg91
 q+LPzlFHOBv0iQLnQq3MHf+BMJkbHn4pagNtuv18iU/pFXoafsP+KjljvruyZ0R8ZXHx
 lHTDVycAgzZ7Jl6Mf0RVcSpqk5z2AJ/qCSUOKfnyYxR74MPpjVUoC8ocuoVohsUZVIaU
 B4q60TsGckyF3NntB1V7nXnbF88DAgt5mPvzvr9go840zWI25qm8MwhqhqglvfZTHnQ/
 eftBGqXfoxmbMZ+I99ETm14Z97ki83OMkyNthBpc8YDPYPuOX1Xgcen9wryAHeD2fvPE
 EqSg==
X-Gm-Message-State: AC+VfDyrFTxf1kAspJpVuON4teuHHhsbiJipDQjQaY1gTpAGlMWVaAPx
 KDHycIZmSQw/M+7unUIUkldxO0hpBVL71OkdrkYflTfT8rWROeuIaq8Xo3SpDByw60JBoM6egb2
 Sxp9GzNOBe9xvWcJcN2vrokYAV6WdThMHBXHhX7xO+g==
X-Received: by 2002:a05:600c:2056:b0:3f6:906:1195 with SMTP id
 p22-20020a05600c205600b003f609061195mr5855736wmg.35.1685273308235; 
 Sun, 28 May 2023 04:28:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7M5zyoUzwa+zSGDpmPvYYOQVCJ72Fpu1o8WWS/XTZSiyeYpqkMXcm/5iERmLuk0Hv+mhDyEQ==
X-Received: by 2002:a05:600c:2056:b0:3f6:906:1195 with SMTP id
 p22-20020a05600c205600b003f609061195mr5855730wmg.35.1685273307956; 
 Sun, 28 May 2023 04:28:27 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c228a00b003f42461ac75sm14403001wmf.12.2023.05.28.04.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 04:28:27 -0700 (PDT)
Date: Sun, 28 May 2023 07:28:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [RFC] virtio-net: support modern-transtional devices
Message-ID: <20230528071851-mutt-send-email-mst@kernel.org>
References: <20230526181542.364412-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230526181542.364412-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
> Current virtio-net only probes a device with VIRITO_ID_NET == 1.
> 
> For a modern-transtional virtio-net device which has a transtional
> device id 0x1000 and acts as a modern device, current virtio-pci
> modern driver will assign the sub-device-id to its mdev->id.device,
> which may not be 0x1, this sub-device-id is up to the vendor.
> 
> That means virtio-net driver doesn't probe a modern-transitonal
> virtio-net with a sub-device-id other than 0x1, which is a bug.

No, the bug is in the device. Legacy linux drivers always looked at
sub device id (other OSes might differ). So it makes no sense
for a transitional device to have sub-device-id other than 0x1.
Don't have time to look at spec but I think you will find it there.


> Other types of devices also have similar issues, like virito-blk.
> 
> I propose to fix this problem of modern-transitonal device
> whith this solution, all in the modern code path:
> 1) assign the device id to mdev->id.device
> 2) add transitional device ids in the virtio-net(and others) probe table.
> 
> Comments are welcome!
> 
> Thanks!
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/net/virtio_net.c               | 1 +
>  drivers/virtio/virtio_pci_modern_dev.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56ca1d270304..6b45d8602a6b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
>  
>  static struct virtio_device_id id_table[] = {
>  	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> +	{ VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
>  	{ 0 },
>  };
>  
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 869cb46bef96..80846e1195ce 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  		/* Transitional devices: use the PCI subsystem device id as
>  		 * virtio device id, same as legacy driver always did.
>  		 */
> -		mdev->id.device = pci_dev->subsystem_device;
> +		mdev->id.device = pci_dev->device;
>  	} else {
>  		/* Modern devices: simply use PCI device id, but start from 0x1040. */
>  		mdev->id.device = pci_dev->device - 0x1040;
> -- 
> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
