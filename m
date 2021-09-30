Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDF8C433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 10:59:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4833560F57
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 10:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4833560F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18C196058C;
	Thu, 30 Sep 2021 10:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJIcvSu9c8_o; Thu, 30 Sep 2021 10:59:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 881C06058B;
	Thu, 30 Sep 2021 10:59:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B352C0011;
	Thu, 30 Sep 2021 10:59:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD2CC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 10:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F072A4020D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 10:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejNU65ozqgCM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 10:59:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84FDF400DE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632999585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7LaHsUMLVR6EA21h5UrbLpMuCN6Sr+ds/6TKiPoY6M=;
 b=FoWmsJvsC6XSdx6XXPn2rHxwNNmAatuEGh6Xut40OEt8SWUGRM6sfGwBWtm5C+unLQjRoQ
 4hLa6zv7XxJNnPBgG1wPL/yCC8RjfrPfrP24+iBC2R9vgzElX5xZNZFDZfSpvKU6Fnjne3
 7qePn6hsf+Hz3pm6Hocw1zGti90ygLg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-9ojhI5KQPbyEk7cntMtQIA-1; Thu, 30 Sep 2021 06:59:43 -0400
X-MC-Unique: 9ojhI5KQPbyEk7cntMtQIA-1
Received: by mail-ed1-f72.google.com with SMTP id
 e7-20020a50d4c7000000b003d871ecccd8so5814509edj.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 03:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b7LaHsUMLVR6EA21h5UrbLpMuCN6Sr+ds/6TKiPoY6M=;
 b=mbec8HcJznYUKrOyXqi0pHT3QRqVs1QGkmAAW99+MRopjoFYaE5PwuVwZtu96cGnF+
 OCQVHegOxo5HUsIERRvczaMgttRWuMJ70xjNIdwMPoNzF7MnCG0z9SuUdgUSrlcqA+Kx
 vhbYathXhvURqrdFicMnKmPZG/skEX4mCsCzN0zxRMJVrLfD+eLLJGZJ3vgeMAmshR0E
 wGzKTunlF7LpsoE5fATXqbUBS0/Frhs7S2ILWejDNx4TIriT/RC6C4KrID79fZUNb/7N
 8LDQgdQ4PPHIIun7V73vFAKc9nadDgEkpBfL228t9Ixw9y3QJm+RwnoN3/ugUcdNR7vQ
 sZfA==
X-Gm-Message-State: AOAM530KABqLqGz731ELCiAi8oh59XPPqVBrjn6kTShcOygdmQLlMLhR
 SJDN6do7C1nzSMAci6D6P2XwVyuz0ahDZwuAkA7d5qkzfU95gFTid9giGmi5WRDeKd6UCm5t4tv
 BhVCI6GLLJsWKCaj3fzvWtJsAt6qwAtLpyfB1S11UaQ==
X-Received: by 2002:a17:906:3f95:: with SMTP id
 b21mr5678173ejj.368.1632999582387; 
 Thu, 30 Sep 2021 03:59:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2i5HxRxp9m+CxrlD+fPbT58I6Y4N17yAXQUmiEQobb4UJZApVX/orNJjFHXXlnrsZIHnlVQ==
X-Received: by 2002:a17:906:3f95:: with SMTP id
 b21mr5678143ejj.368.1632999582132; 
 Thu, 30 Sep 2021 03:59:42 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id w26sm1254203edu.59.2021.09.30.03.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 03:59:40 -0700 (PDT)
Date: Thu, 30 Sep 2021 06:59:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930065807-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
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

On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> While the common case for device-authorization is to skip probe of
> unauthorized devices, some buses may still want to emit a message on
> probe failure (Thunderbolt), or base probe failures on the
> authorization status of a related device like a parent (USB). So add
> an option (has_probe_authorization) in struct bus_type for the bus
> driver to own probe authorization policy.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>



So what e.g. the PCI patch
https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
actually proposes is a list of
allowed drivers, not devices. Doing it at the device level
has disadvantages, for example some devices might have a legacy
unsafe driver, or an out of tree driver. It also does not
address drivers that poke at hardware during init.

Accordingly, I think the right thing to do is to skip
driver init for disallowed drivers, not skip probe
for specific devices.


> ---
>  drivers/base/dd.c            | 5 +++++
>  drivers/thunderbolt/domain.c | 1 +
>  drivers/usb/core/driver.c    | 1 +
>  include/linux/device/bus.h   | 4 ++++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 68ea1f949daa..0cd03ac7d3b1 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -544,6 +544,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  			   !drv->suppress_bind_attrs;
>  	int ret;
>  
> +	if (!dev->authorized && !dev->bus->has_probe_authorization) {
> +		dev_dbg(dev, "Device is not authorized\n");
> +		return -ENODEV;
> +	}
> +
>  	if (defer_all_probes) {
>  		/*
>  		 * Value of defer_all_probes can be set only by
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 3e39686eff14..6de8a366b796 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -321,6 +321,7 @@ struct bus_type tb_bus_type = {
>  	.probe = tb_service_probe,
>  	.remove = tb_service_remove,
>  	.shutdown = tb_service_shutdown,
> +	.has_probe_authorization = true,
>  };
>  
>  static void tb_domain_release(struct device *dev)
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index fb476665f52d..f57b5a7a90ca 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -2028,4 +2028,5 @@ struct bus_type usb_bus_type = {
>  	.match =	usb_device_match,
>  	.uevent =	usb_uevent,
>  	.need_parent_lock =	true,
> +	.has_probe_authorization = true,
>  };
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 062777a45a74..571a2f6e7c1d 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -69,6 +69,9 @@ struct fwnode_handle;
>   * @lock_key:	Lock class key for use by the lock validator
>   * @need_parent_lock:	When probing or removing a device on this bus, the
>   *			device core should lock the device's parent.
> + * @has_probe_authorization: Set true to indicate to the driver-core to skip
> + *			     the authorization checks and let bus drivers
> + *			     handle it locally.
>   *
>   * A bus is a channel between the processor and one or more devices. For the
>   * purposes of the device model, all devices are connected via a bus, even if
> @@ -112,6 +115,7 @@ struct bus_type {
>  	struct lock_class_key lock_key;
>  
>  	bool need_parent_lock;
> +	bool has_probe_authorization;
>  };
>  
>  extern int __must_check bus_register(struct bus_type *bus);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
