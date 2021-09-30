Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3159EC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 11:03:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC44B6187A
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 11:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC44B6187A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A132C606D3;
	Thu, 30 Sep 2021 11:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q3N0PYmpho6M; Thu, 30 Sep 2021 11:03:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3CB2C60641;
	Thu, 30 Sep 2021 11:03:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 135A3C0011;
	Thu, 30 Sep 2021 11:03:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8EB8C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 921E260715
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id axyp-hFKWrQb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:03:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FDA9606D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632999825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=keN+btlYVBJGWOu91I+oCLYZrcd1MoxAA4HpYxaefz4=;
 b=e5OQUoFF3Gewm8xnWcmIBTnP0b42ewR0GpgKsoedMKsC5l1SJAHZPOkg1xvH2lu7yukuxg
 sxNfDPKbYx/IpCu8I9j+3QoHp+N2Z8R5VyWhYr7hJUTnyTVWNekqYZPya8t7TM6HmvYp96
 0Whzcp/pW5ddItPbPtNxPAYh4vQ9t0k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-YgAvjX6BNsuUrF70IcWOfw-1; Thu, 30 Sep 2021 07:03:43 -0400
X-MC-Unique: YgAvjX6BNsuUrF70IcWOfw-1
Received: by mail-ed1-f70.google.com with SMTP id
 w6-20020a50d786000000b003dabc563406so1498306edi.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=keN+btlYVBJGWOu91I+oCLYZrcd1MoxAA4HpYxaefz4=;
 b=vHqStRJLGrR1vfDyejHAA4GI8NTFORtdXMEEg69vC2W5Oaqo5glCrWfNctQAGVJOyE
 XcZVDvofExEgHX8w2EMhXSBwyKE9xZyeRDDN2Pg1f06rh/tIMW2tC7mX1j8B15wwfj8i
 NX6/vh3+yJsSvUCv7aGoUPejqtkZQj87LwbDK2K9pppm3PkrjF8YaEoecHHl5nugeeTP
 2AQwkXCpirOH9VmFZNPcs+D9ZYhKIrYfiDJV9tkLx2rRpgthEUpZgAFFjs45UTd9YoVv
 hp7uqwXhAmACcXbjH0frehO8DfaBQFY9SC/ZAVzBEkYotbt62VJkRSbFr36QC8Yxz1qW
 Z6zQ==
X-Gm-Message-State: AOAM532yhc6mXpfzP5bvCTjCBj6l/P55JNH1W+q+vC1JE2SLNv0d3MIa
 LNlnmN9f5sraTW6+VE2WUNy5d9LNEbmQ/fz6EMT0iKR4PJFJY9G6Tdqy/CvmvhJJVbvwxbcpRR5
 wuAoa+fwBzEve5G3zSnztg6gRYGzI5FCYFIdK1TZwgA==
X-Received: by 2002:a17:906:2e8d:: with SMTP id
 o13mr5757132eji.513.1632999822752; 
 Thu, 30 Sep 2021 04:03:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8LNAIxQqSSpjIHptID8EWuyzXRl8baUIAwt3FwCua7Hi/w5dhATxEGvg5mbk5gBCu14U0Ww==
X-Received: by 2002:a17:906:2e8d:: with SMTP id
 o13mr5757108eji.513.1632999822544; 
 Thu, 30 Sep 2021 04:03:42 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id v8sm1291353ejy.79.2021.09.30.04.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 04:03:42 -0700 (PDT)
Date: Thu, 30 Sep 2021 07:03:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <20210930065953-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Corbet <corbet@lwn.net>, Andi Kleen <ak@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, linux-kernel@vger.kernel.org,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-usb@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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

On Wed, Sep 29, 2021 at 06:05:09PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Confidential guest platforms like TDX have a requirement to allow
> only trusted devices. By default the confidential-guest core will
> arrange for all devices to default to unauthorized (via
> dev_default_authorization) in device_initialize(). Since virtio
> driver is already hardened against the attack from the un-trusted host,
> override the confidential computing default unauthorized state
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Architecturally this all looks backwards. IIUC nothing about virtio
makes it authorized or trusted. The driver is hardened,
true, but this should be set at the driver not the device level.
And in particular, not all virtio drivers are hardened -
I think at this point blk and scsi drivers have been hardened - so
treating them all the same looks wrong.

> ---
>  drivers/virtio/virtio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 588e02fb91d3..377b0ccdc503 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -5,6 +5,8 @@
>  #include <linux/module.h>
>  #include <linux/idr.h>
>  #include <linux/of.h>
> +#include <linux/cc_platform.h>
> +#include <linux/device.h>
>  #include <uapi/linux/virtio_ids.h>
>  
>  /* Unique numbering for virtio devices. */
> @@ -390,6 +392,13 @@ int register_virtio_device(struct virtio_device *dev)
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
>  
> +	/*
> +	 * For Confidential guest (like TDX), virtio devices are
> +	 * trusted. So set authorized status as true.
> +	 */
> +	if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
> +		dev->dev.authorized = true;
> +
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
>  	dev->config->reset(dev);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
