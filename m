Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFECC4332F
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 06:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0680860FFC;
	Wed,  4 Jan 2023 06:50:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0680860FFC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SUBG+Jnz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yoDZnN8tc_HL; Wed,  4 Jan 2023 06:50:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A215060FF3;
	Wed,  4 Jan 2023 06:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A215060FF3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76647C0032;
	Wed,  4 Jan 2023 06:50:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F940C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 06:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22AAE819B8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 06:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22AAE819B8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SUBG+Jnz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8VtvwssP51hT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 06:50:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D82C48187F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D82C48187F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672815013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vea5lJTy+gjY/3+KcsOMv2NJYNGUHXdzcZ168NbAmUY=;
 b=SUBG+JnzjDRIUMurnoTwFwjkNljIurf34u70lhHvl+ViyKXyLpu1OI3EYsXiU3Pd5mdZRI
 NSfaiqoqTxXuCeS7jQY0UQgVrSZckPRe1+55mZ+zaWRpA1zmQFVIztXC+iUvQI5nVoLeHj
 Hb6tVQ3t0ZAQf9fdD5v1ll3BySYJkbo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-365-Js5Gkt_DOQmBwWHEC9xavw-1; Wed, 04 Jan 2023 01:50:11 -0500
X-MC-Unique: Js5Gkt_DOQmBwWHEC9xavw-1
Received: by mail-wm1-f72.google.com with SMTP id
 f20-20020a7bc8d4000000b003d1cda5bd6fso7163907wml.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Jan 2023 22:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vea5lJTy+gjY/3+KcsOMv2NJYNGUHXdzcZ168NbAmUY=;
 b=nzIrDv2evRaKe6UEpdLTAXOConHoeqCu3pO2pZ/DoBiHwQSuQ3IIyS7QNvR9ygXdZ3
 2vMPHrzeMsvkzVMIBF6HsPWhKYy1W1geWmI4S0nkB2giizL3YiMY6/dd3C8SDppJ+Ut9
 4S3FJcLZJA7ss0OmRT33unqWWc++1qdwx9Nphdj6bUOX4LqqtsXndy3MVp48bIlJ5n2M
 vgN8D3zkSCuTiWlHf/ghhnoYmdEjPozqbeUAwdONeIMX/TlzAe9jOICof/yIiBTU4JAt
 a1Zza9g09b6zq3E4kXrOn//Y1/vC6hxqQ27zYb9dLCoMkiAoPbYeA0tpWzesXzynaWGM
 czNA==
X-Gm-Message-State: AFqh2kpURtO6xSnZYIzQYs2KfgWvWZaG6X2h5AJksAWaLO3eyUVdpItt
 MNzvpeaHS6KODv+yfkbRud0AyXMt5a9uVpxMf85tomPoAmQwFgyW6x4qkO0kUEwAaZ8AwxYCu7V
 b2azxuIdMmkM//QqFK/58yVriYbZ5nrif4paVkcfmdw==
X-Received: by 2002:adf:c648:0:b0:275:618c:83ea with SMTP id
 u8-20020adfc648000000b00275618c83eamr28049810wrg.29.1672815007869; 
 Tue, 03 Jan 2023 22:50:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7g0bFTzdYAfQahFXgYRuRC8zuN09it3a2IlDnQW6kW1CpENpFCTTXq5lgReA9X3HF3QEWlg==
X-Received: by 2002:adf:c648:0:b0:275:618c:83ea with SMTP id
 u8-20020adfc648000000b00275618c83eamr28049798wrg.29.1672815007650; 
 Tue, 03 Jan 2023 22:50:07 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 f8-20020adff8c8000000b00282194eaf7bsm22977814wrq.71.2023.01.03.22.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jan 2023 22:50:07 -0800 (PST)
Date: Wed, 4 Jan 2023 01:50:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH v3] vp_vdpa: harden the logic of set status
Message-ID: <20230104014642-mutt-send-email-mst@kernel.org>
References: <20230104042519.170-1-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230104042519.170-1-longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, yechuan@huawei.com, huangzhichao@huawei.com,
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

On Wed, Jan 04, 2023 at 12:25:19PM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> 1. We should not set status to 0 when invoking vp_vdpa_set_status(),
>    trigger a warning in that case.
> 
> 2. The driver MUST wait for a read of device_status to return 0 before
>    reinitializing the device. But we also don't want to keep us in an
>    infinite loop forever, so wait for 5s if we try to reset the device.
> 
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
> Changes v3->v2:
>  - move VP_VDPA_RESET_TIMEOUT_US near the other macros. [Stefano]
>  - refer v1.2 in comments. [Stefano]
>  - s/keep/keeping/  [Jason]
>  - use readx_poll_timeout. [Jason]
> 
> Changes v1->v2:
>  - use WARN_ON instead of BUG_ON. [Stefano]
>  - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
>  - use usleep_range instead of msleep (checkpatch). [Longpeng]
> 
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index d448db0c4de3..3fc496aea456 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/iopoll.h>
>  #include <linux/pci.h>
>  #include <linux/vdpa.h>
>  #include <linux/virtio.h>
> @@ -22,6 +23,7 @@
>  #define VP_VDPA_QUEUE_MAX 256
>  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
>  #define VP_VDPA_NAME_SIZE 256
> +#define VP_VDPA_RESET_TIMEOUT_US 5000000 /* 5s */
>  
>  struct vp_vring {
>  	void __iomem *notify;
> @@ -214,6 +216,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>  	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>  	u8 s = vp_vdpa_get_status(vdpa);
>  
> +	/* We should never be setting status to 0. */
> +	WARN_ON(status == 0);
> +
>  	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>  	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>  		vp_vdpa_request_irq(vp_vdpa);

Isn't this user-triggerable? What prevents that?

> @@ -226,10 +231,25 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
>  {
>  	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>  	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> -	u8 s = vp_vdpa_get_status(vdpa);
> +	u8 tmp, s = vp_vdpa_get_status(vdpa);
> +	int ret;
>  
>  	vp_modern_set_status(mdev, 0);
>  
> +	/*
> +	 * As the virtio v1.1/v1.2 spec (4.1.4.3.2) says: After writing 0 to
> +	 * device_status, the driver MUST wait for a read of device_status
> +	 * to return 0 before reinitializing the device.
> +	 * To avoid keeping us here forever, we only wait for 5 seconds.
> +	 */
> +	ret = readx_poll_timeout(vp_ioread8, &mdev->common->device_status, tmp,
> +				 tmp == 0, 1000, VP_VDPA_RESET_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(&mdev->pci_dev->dev,
> +			"vp_vdpa: fail to reset device, %d\n", ret);
> +		return ret;
> +	}
> +
>  	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
>  		vp_vdpa_free_irq(vp_vdpa);

Do all callers actually check return status of reset?
If not they will happily reinitialize the device and violate the spec.



> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
