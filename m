Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A406DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 11:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FE5D60E54;
	Thu, 24 Mar 2022 11:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GzjWItWlO_F4; Thu, 24 Mar 2022 11:04:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1ACD60E0B;
	Thu, 24 Mar 2022 11:04:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6CEAC001A;
	Thu, 24 Mar 2022 11:04:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 843FCC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71CD660E11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07GCzilDQePj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:04:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9AC360E0B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648119856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QzKBoZ1rRX3VzCL9ZTZ74cnxlXwhmkLuajM8brTFu9o=;
 b=KmL8LA74Uw/zjHnESVtbz9+1R4gkUbFIqB9I1c0RDsutEoBid3SaOF2squFtxyc1838f25
 DJRalW6gk7C4ohlwdrg6bAu1vCtZ4Z2NSp00EwgF3oD9mACMwcvZPtRCcHW2Nm9YEm8Wxa
 QjCADS3bm3KNCg4kO0Z2Edj99iv00nY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-FFaQINQROqe1xKzV8ZGT-A-1; Thu, 24 Mar 2022 07:04:15 -0400
X-MC-Unique: FFaQINQROqe1xKzV8ZGT-A-1
Received: by mail-qk1-f198.google.com with SMTP id
 i2-20020a05620a248200b0067b51fa1269so2785091qkn.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 04:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QzKBoZ1rRX3VzCL9ZTZ74cnxlXwhmkLuajM8brTFu9o=;
 b=pnLHjCcd/qtevZ091Aw0mJSE5AXXmPTEEy24KLQdmoQy1W2jMQYYnQqHw6Ko73IgF4
 iS8ZA0GFKzJKTtYL456EtTzbI9aHcgqs0k9T5teI+hUsc75UJNGSA2E3tpmR7ZYdb3k6
 +EH0dMW6DQFqgnRE4g6fHRg/R0Or5f4hPF9xKw3LWfpdw1zBBRcFInSPaAevMyujclxu
 g5+k9hRMhGFEj6D2Ef557bXIFLTlOeK5Sc4jSA6x3Y6m7xSJxXwRWy84GgqJ2kNDDdIR
 o18N8StJBY872nm5YkBgZjdGqwNH5sYHeHUoMlX8GMXxdZvyU+c7Y5X+Y1+lps4IsDAE
 rFSA==
X-Gm-Message-State: AOAM533OW1WIPMuW15YUr1Ib1e6NWoKF2a9+2JOBw0klBwlvgHy1HeC/
 HbhYFXhanNFIRx+gOZSKZaYpWnIwG0oNiU/iA5AASbgWJhgv8hd+9MN8Bl1p/hUud4lOr6UPrD9
 8JuppCelT+een8EvX1786jIzRGBFuo+TBor0XIwlQbg==
X-Received: by 2002:a05:622a:1491:b0:2e2:2faa:dd47 with SMTP id
 t17-20020a05622a149100b002e22faadd47mr3827495qtx.142.1648119855065; 
 Thu, 24 Mar 2022 04:04:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp/wQU8MsdSrsLRUuClD5GYcuKTmcmliL/h8xBYtLUnGZZtN/JCvCQVu4EX161cOJ6FTBdng==
X-Received: by 2002:a05:622a:1491:b0:2e2:2faa:dd47 with SMTP id
 t17-20020a05622a149100b002e22faadd47mr3827473qtx.142.1648119854871; 
 Thu, 24 Mar 2022 04:04:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 f14-20020ac8068e000000b002dd1bc00eadsm2010781qth.93.2022.03.24.04.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 04:04:14 -0700 (PDT)
Date: Thu, 24 Mar 2022 12:04:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/3] virtio: use virtio_reset_device() when possible
Message-ID: <20220324110409.d3s4cgbomuaezv6h@sgarzare-redhat>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220324084004.14349-3-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, peterz@infradead.org, maz@kernel.org, keirf@google.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 24, 2022 at 04:40:03PM +0800, Jason Wang wrote:
>This allows us to do common extension without duplicating codes.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/virtio/virtio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index 75c8d560bbd3..8dde44ea044a 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -430,7 +430,7 @@ int register_virtio_device(struct virtio_device *dev)
>
> 	/* We always start by resetting the device, in case a previous
> 	 * driver messed it up.  This also tests that code path a little. */
>-	dev->config->reset(dev);
>+	virtio_reset_device(dev);
>
> 	/* Acknowledge that we've seen the device. */
> 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>@@ -496,7 +496,7 @@ int virtio_device_restore(struct virtio_device *dev)
>
> 	/* We always start by resetting the device, in case a previous
> 	 * driver messed it up. */
>-	dev->config->reset(dev);
>+	virtio_reset_device(dev);
>
> 	/* Acknowledge that we've seen the device. */
> 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
