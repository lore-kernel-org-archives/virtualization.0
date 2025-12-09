Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FC32E73A
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298102; cv=none; b=TbgwfP7fBqVF/cVw0zcaJQQu9x6LrS3kVpnHTJHjDTEH7JZldEwDY70x7tjItekFV70D0xn9OtOsl8Re8VCKqHTk6kuXbJTgXj38wdhRbcwWVlurtloKud4dsChGARW8ETuFJRVWOwfdnI5baXVD68qxNetccMxHt076Twz079g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298102; c=relaxed/simple;
	bh=lnyXcCQY8wxYUiz9C+WbQVRN8NAJ6h19E/JrUdRefVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tmIEb1cxS0frLsRYAPxwNBVcXycwBfcUE5glptXW8z5Hz9ObrL/XOlj+LGt2tc86yBRapEK3kfceCMtmayEjqq4MGcH4Eq7TEhVTKdB5SuCYI/BqympKz7dosU8+lMc5MsBVt5w/1PSoG/VAroOAEGnINNYq12hyqtawdxcJ6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SV9/uEgW; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV9/uEgW"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC8EF4019E
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 16:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rC9ENnKo-8Y5 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Dec 2025 16:34:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9395B4015F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9395B4015F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SV9/uEgW
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9395B4015F
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765298096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9JfjndmoaJNvNI6sbMSfg1Y02u1WJwsC5WsyytU640=;
	b=SV9/uEgWPZnRitH47bVY2JJJfCPUaxXZ3v5rZ9uhTtdO4YpS3YASDKw1ARQYoCYzGA5uH2
	oaVE79/3dMQvf8QJkCeSOC309AuoWFrYQE+mcplQvURAEWrxRPveBEmXqGXcD5MSoUZ453
	oIpeGWghjPf2KCxvSwYJOBnMJcTYe2I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-C0kh_JhrPX2u3QKmnjBx5w-1; Tue, 09 Dec 2025 11:34:55 -0500
X-MC-Unique: C0kh_JhrPX2u3QKmnjBx5w-1
X-Mimecast-MFC-AGG-ID: C0kh_JhrPX2u3QKmnjBx5w_1765298094
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso26426695e9.1
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Dec 2025 08:34:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765298094; x=1765902894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9JfjndmoaJNvNI6sbMSfg1Y02u1WJwsC5WsyytU640=;
        b=fD9svS3vvM4OFyAVsHOQW9X2zXh6mfYmYlgGC+a6RE4HaQTEro7pYBI+dXBskRyjQU
         sV1UUxbSyH8CWm322PUtYMB4aEiS9+TYxIsJkqg9Y1BYOOaNvvKmH0onQHWkS6pcFlTZ
         UmZrDWz8oTujE6loozu2daNkPOVrp8c9sDEzFueinOsTaIQMu8MOnSskS67kezqPbAw9
         DWpnM7Jqtw5W3DTx2afTxNgSLfHsJndmev+8Xgr+Gg6aD6CBxLlU2k1etE+klm2pybYd
         4TS0hmfym2oewicYyUqhSGsZV7oR2gWU/rq1z1nw9SGNCiHH73cZI6I8aVKbyRu4zYsL
         gk4g==
X-Forwarded-Encrypted: i=1; AJvYcCU6aKLX3C8ZKjIvh0lVEYXThebRCE0Fp+kW1lYKRPvLDe5kv2UU0i9TAPv793Orvq3yNPYNBM6B4vi9NVeQIA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyDltsfZQHEv17qGxuTl0+G50VtoXLT+tmJf12HKNCBcAw2M7tj
	oXcfIW7K7dTTpRLIIoywA/lmzwpntxhtjlPrlvdQOxBbNGjWNe8MvSrrMHBeYO5xtNcbLoywNXK
	4h+SUx0rOIxDlD5ntXqTjQeOqqmhlsqYQbnoiiBsc79tcLJcytnn51fYTjGhf63xP+ucgp2DyuP
	cCGIijW7k=
X-Gm-Gg: ASbGnctF+4Vi46kUxbB8f83HsD1h3DXtRO9n8Y0CtBAmJtrPKy1v8ohtRfNiH8+YmXw
	GcT2+M/BHd0IyjqFOc/z6BR/MrKKoWV25IlDEfd53EPIrnn3jkA/jmOM7jrh6AfoA4qr6+J1FHX
	tErr/aUkCm+2r3w0YNTASES6l3BQ947qNd1KRiowGslT8ccXReh90QNqo4AGWrE01YxO+O3FkIq
	U6ESclIH9ZP6No1NxTrk1vI25BWLqLZAYv8/cjdNbZodeIG8vOwNlwxt+QtVXp0lSCjYKgdP7Qw
	JXZHHxpFhZ7nR38n5C2+kTyHpOYyVRCQHmnnTLwzWkLL1Hpo/8b+1WP9L1e9/XVGgQzZvGSyo22
	c
X-Received: by 2002:a05:600c:c297:b0:477:9cec:c83e with SMTP id 5b1f17b1804b1-47a7f90f366mr18557885e9.1.1765298094378;
        Tue, 09 Dec 2025 08:34:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMTQnY4WUopYEq62Lme08UXaCxVEXwK+s04m0yfRFAAPpJeSRLjIyzdawPMvHmUE0u+t16GA==
X-Received: by 2002:a05:600c:c297:b0:477:9cec:c83e with SMTP id 5b1f17b1804b1-47a7f90f366mr18557655e9.1.1765298093947;
        Tue, 09 Dec 2025 08:34:53 -0800 (PST)
Received: from redhat.com ([80.230.34.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d632cebsm48499025e9.7.2025.12.09.08.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 08:34:53 -0800 (PST)
Date: Tue, 9 Dec 2025 11:34:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
	oren@nvidia.com, aevdaev@nvidia.com, aaptel@nvidia.com
Subject: Re: [PATCH v2 1/1] virtio: add driver_override support
Message-ID: <20251209113306-mutt-send-email-mst@kernel.org>
References: <20251208220908.9250-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251208220908.9250-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dSfoSsSWoftE-Yle0Eh89L3Ztac6hStEMolOgzQ64ak_1765298094
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 09, 2025 at 12:09:08AM +0200, Max Gurtovoy wrote:
> Add support for the 'driver_override' attribute to Virtio devices. This
> allows users to control which Virtio bus driver binds to a given Virtio
> device.
> 
> If 'driver_override' is not set, the existing behavior is preserved and
> devices will continue to auto-bind to the first matching Virtio bus
> driver.

oh, it's a device driver not the bus driver, actually.

> Tested with virtio blk device (virtio core and pci drivers are loaded):
> 
>   $ modprobe my_virtio_blk
> 
>   # automatically unbind from virtio_blk driver and override + bind to
>   # my_virtio_blk driver.
>   $ driverctl -v -b virtio set-override virtio0 my_virtio_blk
> 
> In addition, driverctl saves the configuration persistently under
> /etc/driverctl.d/.

what is this "mydriver" though? what are valid examples that
we want to support? 

> 
> Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> changes from v1:
>  - use !strcmp() to compare strings (MST)
>  - extend commit msg with example (MST)
> 
> ---
>  drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h  |  4 ++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a09eb4d62f82..993dc928be49 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -61,12 +61,41 @@ static ssize_t features_show(struct device *_d,
>  }
>  static DEVICE_ATTR_RO(features);
>  
> +static ssize_t driver_override_store(struct device *_d,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +	int ret;
> +
> +	ret = driver_set_override(_d, &dev->driver_override, buf, count);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t driver_override_show(struct device *_d,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +	ssize_t len;
> +
> +	device_lock(_d);
> +	len = sysfs_emit(buf, "%s\n", dev->driver_override);
> +	device_unlock(_d);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(driver_override);
> +
>  static struct attribute *virtio_dev_attrs[] = {
>  	&dev_attr_device.attr,
>  	&dev_attr_vendor.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_modalias.attr,
>  	&dev_attr_features.attr,
> +	&dev_attr_driver_override.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(virtio_dev);
> @@ -88,6 +117,10 @@ static int virtio_dev_match(struct device *_dv, const struct device_driver *_dr)
>  	struct virtio_device *dev = dev_to_virtio(_dv);
>  	const struct virtio_device_id *ids;
>  
> +	/* Check override first, and if set, only use the named driver */
> +	if (dev->driver_override)
> +		return !strcmp(dev->driver_override, _dr->name);
> +
>  	ids = drv_to_virtio(_dr)->id_table;
>  	for (i = 0; ids[i].device; i++)
>  		if (virtio_id_match(dev, &ids[i]))
> @@ -582,6 +615,7 @@ void unregister_virtio_device(struct virtio_device *dev)
>  {
>  	int index = dev->index; /* save for after device release */
>  
> +	kfree(dev->driver_override);
>  	device_unregister(&dev->dev);
>  	virtio_debug_device_exit(dev);
>  	ida_free(&virtio_index_ida, index);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index db31fc6f4f1f..418bb490bdc6 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -138,6 +138,9 @@ struct virtio_admin_cmd {
>   * @config_lock: protects configuration change reporting
>   * @vqs_list_lock: protects @vqs.
>   * @dev: underlying device.
> + * @driver_override: driver name to force a match; do not set directly,
> + *                   because core frees it; use driver_set_override() to
> + *                   set or clear it.
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.
>   * @vringh_config: configuration ops for host vrings.
> @@ -158,6 +161,7 @@ struct virtio_device {
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock;
>  	struct device dev;
> +	const char *driver_override;
>  	struct virtio_device_id id;
>  	const struct virtio_config_ops *config;
>  	const struct vringh_config_ops *vringh_config;
> -- 
> 2.18.1

