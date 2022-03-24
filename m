Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F16C433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 10:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A941408A7;
	Thu, 24 Mar 2022 10:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7A3GbpJ_UN3N; Thu, 24 Mar 2022 10:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 875CF40201;
	Thu, 24 Mar 2022 10:48:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66AAEC001A;
	Thu, 24 Mar 2022 10:48:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37AAAC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DBDD60E4A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z_wikwYTMo3B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:48:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D3E660E11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648118894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uWRMRQIguPn0xVAvBXNbH51X5fGoB4gdHQSpKWVAiFE=;
 b=VOjidShX2oiW5ZrE/FhXK7+PFsgLwtaL8PQ/tnPjuntqLUBJHleCMr90YhoNp4ghEAt260
 PWVplJu0Cdi9CNzSRCkWaC5YkyUkP01lRbDO2eQTQdQw8q/O+2EPor8BQYN9JwzKVOYYvZ
 wauHas8Y2jca2CVmM9ikHwaj0G/YGPY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-s3AwAMb5PXqNmuWAyjaC6A-1; Thu, 24 Mar 2022 06:48:13 -0400
X-MC-Unique: s3AwAMb5PXqNmuWAyjaC6A-1
Received: by mail-wr1-f72.google.com with SMTP id
 o9-20020adfca09000000b001ea79f7edf8so1539723wrh.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 03:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uWRMRQIguPn0xVAvBXNbH51X5fGoB4gdHQSpKWVAiFE=;
 b=p4GjyFVlpiJ3dGRV10A2WGMNK88MzCdcA99j7X1MCZv2Ed+2qJStrDCDXcboMC3MFu
 0zJPH1pgINkJVnZKq//ztHxSRfkuPiCjytkMHiY+KXLZ2fuOjsrDeHGsAmSEt6ll542J
 sDcRWZJ04Rr6t69C/WVx2SG/8Vh5oLRUtlguLDhDFHhj1tXDH5AGbm/SWC6gxPhGnUC1
 MbdhO+DChemK4D0oC2EaWtUlaiv1kdQuqSCNVhDuLvD07BH0GXZcsen/bIbmS8owWLfI
 rfzD56vaHNy4A0JgLqtnchn817jO1aLP5thqsFmFt+A8T0e2sfjWsLoMqeiwHDitJ+b/
 K6ug==
X-Gm-Message-State: AOAM533m1rBAbPWE3ntkoXcP6If6XdfOsUxVMNS9RoltvBxACBFQR3t5
 J0gHfSDWpbMjEUjb+vqjYYh+HhvQWc5bCr4Sm+A2rPbAdfcNeVU0IWhGdALCGhQoNO2vvdaQ1Oh
 5FkujIAIHKe9CDWT+JIlb2/rmfgUrxrgriQj4F8rE4Q==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id
 c129-20020a1c3587000000b0038150ff0cbdmr13551080wma.140.1648118891812; 
 Thu, 24 Mar 2022 03:48:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRxMJ+YXVZLvhuM9RI7+rgiWVlvl4AwKWXbx5vjGyiTWNJAssKyhMaSULkwjGGH8UgEVT4XA==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id
 c129-20020a1c3587000000b0038150ff0cbdmr13551062wma.140.1648118891582; 
 Thu, 24 Mar 2022 03:48:11 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 e10-20020a056000178a00b0020414f27a58sm2419815wrg.35.2022.03.24.03.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 03:48:10 -0700 (PDT)
Date: Thu, 24 Mar 2022 06:48:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220324064205-mutt-send-email-mst@kernel.org>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220324084004.14349-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peterz@infradead.org, maz@kernel.org, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de
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

On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This avoids setting DRIVER_OK twice for those drivers that call
> virtio_device_ready() in the .restore

Is this trying to say it's faster?
If yes this one looks like a red herring. Yes we skip a write but we
replace it with a read which is not better performance-wise.
If we want to optimize this, it is better to just do that inside
virtio_add_status:



diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75c8d560bbd3..cd943c31bdbb 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -161,8 +161,14 @@ static void virtio_config_enable(struct virtio_device *dev)
 
 void virtio_add_status(struct virtio_device *dev, unsigned int status)
 {
+	unsigned int device_status;
+
 	might_sleep();
-	dev->config->set_status(dev, dev->config->get_status(dev) | status);
+
+	device_status = dev->config->get_status(dev);
+
+	if (status & ~device_status)
+		dev->config->set_status(dev, device_status | status);
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 

> and it will allows us to do
> extension on virtio_device_ready() without duplicating codes.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 22f15f444f75..75c8d560bbd3 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
>  			goto err;
>  	}
>  
> -	/* Finally, tell the device we're all set */
> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */

I preferred the original comment, it said why we are doing this,
new one repeats what code is doing.

> +	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		virtio_device_ready(dev);
>  
>  	virtio_config_enable(dev);
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
