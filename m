Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D90CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 11:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00697841A0;
	Thu, 24 Mar 2022 11:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cF5Oa1u6XADe; Thu, 24 Mar 2022 11:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F18384190;
	Thu, 24 Mar 2022 11:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67020C001A;
	Thu, 24 Mar 2022 11:03:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE835C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE1F340868
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E0gVSvht1gxC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAE2440884
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648119800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hd0/imsrp/OLykBqV1xDV+Kanold+Mdqd1VE+I5W0w=;
 b=LknhCa4UNN3XnBwSLOrKHTt2rx1AZLIHEQmy3GvBY0sYEcNe0p9ohsCVJwDGb2zUmgB/5I
 6DCOx/4s926l+/tp081haJalprxmrx5EumNL3MckCQOXxRIdW3p7WiPypARwxxWZjW2G45
 FjpEzWNWpz+FA2wLjPopkGgl7E9Gt+U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-6I1woiHqPIGn_tCv-k56cg-1; Thu, 24 Mar 2022 07:03:17 -0400
X-MC-Unique: 6I1woiHqPIGn_tCv-k56cg-1
Received: by mail-qk1-f199.google.com with SMTP id
 q5-20020a05620a0d8500b004738c1b48beso2798523qkl.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 04:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5hd0/imsrp/OLykBqV1xDV+Kanold+Mdqd1VE+I5W0w=;
 b=wiqViYfoKXrdoNMUsT6SoGcws6HnSUhFgp3itW/YT0dQY7ky0E66EGOBNqoQlCkOY3
 MIHI223nRzXlP2cWeG+bJfherWSk/9EL90/Q+eHGV8VJMzK6qj0n5jSAlRUjwM3/ZsTh
 UantSm8oKo9dDQZf7NTS0liWZpddXI4eMHKYn2gtgke96r6f/WH6F5VwUuK7CRXgUn+8
 orvz2iCmrTnKeu3KJYpeBBCUgtmsaEZ8ZTDQL3+DvN+zFub05DW5vXtSIbOMrFkITJgW
 BL4mH8yLVK2+lQqgQhY/XN5aE+hd2XmK356kmKKMcMEynMqHPJYxkx199WfIs9evtiK+
 URxg==
X-Gm-Message-State: AOAM532jquFij9hM2jX73rexKtTD2ZEYveCd+AFg7LEOY1f0wYc9VZom
 LUZma6JXeOKkybbHUvobrTzRSETE+HSo3r52ChUdAMMGG41B5+VD2rg894T26uo++5uSIZCNkMU
 QUXgI5UBIgZ9bdQHvscRjZVhgC2lBdNbuSlKx5HezYg==
X-Received: by 2002:ac8:5907:0:b0:2e1:ef6f:9535 with SMTP id
 7-20020ac85907000000b002e1ef6f9535mr3711226qty.49.1648119797160; 
 Thu, 24 Mar 2022 04:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/AHWToiCj1Oz2oO7rka3RLZGj7wUXUyJp/oVEeeh9Y8fWRq4s7ozRbuOhdDM8JD0/x98EEA==
X-Received: by 2002:ac8:5907:0:b0:2e1:ef6f:9535 with SMTP id
 7-20020ac85907000000b002e1ef6f9535mr3711190qty.49.1648119796829; 
 Thu, 24 Mar 2022 04:03:16 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 d12-20020a05620a158c00b00648ec3fcbdfsm1323328qkk.72.2022.03.24.04.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 04:03:15 -0700 (PDT)
Date: Thu, 24 Mar 2022 12:03:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220324064205-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 24, 2022 at 06:48:05AM -0400, Michael S. Tsirkin wrote:
>On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> This avoids setting DRIVER_OK twice for those drivers that call
>> virtio_device_ready() in the .restore
>
>Is this trying to say it's faster?

Nope, I mean, when I wrote the original version, I meant to do the same 
things that we do in virtio_dev_probe() where we called 
virtio_device_ready() which not only set the state, but also called 
.enable_cbs callback.

Was this a side effect and maybe more compliant with the spec?

>If yes this one looks like a red herring. Yes we skip a write but we
>replace it with a read which is not better performance-wise.
>If we want to optimize this, it is better to just do that inside
>virtio_add_status:
>
>
>
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index 75c8d560bbd3..cd943c31bdbb 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -161,8 +161,14 @@ static void virtio_config_enable(struct virtio_device *dev)
>
> void virtio_add_status(struct virtio_device *dev, unsigned int status)
> {
>+	unsigned int device_status;
>+
> 	might_sleep();
>-	dev->config->set_status(dev, dev->config->get_status(dev) | status);
>+
>+	device_status = dev->config->get_status(dev);
>+
>+	if (status & ~device_status)
>+		dev->config->set_status(dev, device_status | status);
> }
> EXPORT_SYMBOL_GPL(virtio_add_status);

Could there be a case where we want to set the status again even though 
the device tells us it's already set?

I think not, so I guess it's okay.

>
>
>> and it will allows us to do
>> extension on virtio_device_ready() without duplicating codes.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>  drivers/virtio/virtio.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 22f15f444f75..75c8d560bbd3 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
>>  			goto err;
>>  	}
>>
>> -	/* Finally, tell the device we're all set */
>> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>> +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
>
>I preferred the original comment, it said why we are doing this,
>new one repeats what code is doing.

I agree, copy & paste from virtio_dev_probe().

Jason can you fix this patch or should I resend?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
