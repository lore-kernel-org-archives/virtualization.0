Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52250286408
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765228357; cv=none; b=b4QsjFN9iJM+HdMn210cttbJZ81mouX9EPZWA60ppED+u1cKYTiXk7cl5wZffM4QJogntjbNlifSl9dkLfgkQf8tywjZfDzht3wD8nKD+5RYD24YwfrVigKanLHSs4D0PjcdgG1JnROzjJ57473ZDJuafmTJJ2zZZPhS/Te/c+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765228357; c=relaxed/simple;
	bh=gjq/URGr/ahtVXYZQ//ga8hy4+632WUNiLAv7LOdQ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qXahBexdTMWhUT27TNJfS7fLh+7+BeUUKXA6tvuRI76HZLdmUufa8pmexlK/VVALwaccVDO5dTnjcSo58ys28D55A2MOgJchG2SIEFoYjvtvEBuLK2JdtMW7gKgGLLpjiUnexSbP4NCsrXLnGezK8TK5tgb2lNJFzE1+iKaETcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XurLvq6L; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XurLvq6L"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC46283C99
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 21:12:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Agy5T7a7EQd0 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Dec 2025 21:12:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B523383C98
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B523383C98
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XurLvq6L
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B523383C98
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765228353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8rUJdCBNcVgpxSP9K0u/+NbS+EulKverjR2Hn3h5kgg=;
	b=XurLvq6LCdAzSqa4Vwc/Sjb2NILEsi/+NKrQf9dnC0rtDdwwCX83rNBaz5XwXGdV9t6hj3
	WlcLKYmVXEnfiJbZcV0gDGG7s/H/+pxqe/U1KiDN9jRAV2Xid+/eFdFqAyWb+DhuqZ+5lF
	WSVLCJG8P/7TC0CET+l+hEGzJ2IAmBQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-zRUpIV8DOIyOwX6aaSPNSw-1; Mon, 08 Dec 2025 16:12:31 -0500
X-MC-Unique: zRUpIV8DOIyOwX6aaSPNSw-1
X-Mimecast-MFC-AGG-ID: zRUpIV8DOIyOwX6aaSPNSw_1765228351
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47918084ac1so41559265e9.2
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Dec 2025 13:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765228351; x=1765833151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rUJdCBNcVgpxSP9K0u/+NbS+EulKverjR2Hn3h5kgg=;
        b=On4FOpniCfy+KhPuiNxAckfZ80+vtjFaPsaIFDbRPx+/aFExJ2KDDYA1leEgdOh+dW
         H+00ogW7poF1V5OnWNew8ld6/yXGTc0E+WCNueqWUj17ADSVj9uwB3DPa089LMCdrBaD
         ZxSDGi7Wi46ndNZ0RvbPRvouQpaEZTx3d/ibwx+O6BZuclZSEUnlpgKagVbOwcObzBWj
         fuL+FrL/wOrdO4bCeirK/nev89UcX1WzTOlrkE8Ou2NDyrQPAlJUssctVCpvR4ddqZYC
         o98kN1sqJPMGZhgkbguK+K4Sw7EjTzJE6dpJvjwn8GhkhkzJPhZvwMIY1KgMnfNqKBuS
         1F5g==
X-Forwarded-Encrypted: i=1; AJvYcCXeKfgZkO8D+gobgW9vlqPSdh9Q03LrmrvsPBnELVmZWiil3Vcn5Ucp5g+dM5qDa6Y8vayKNoLpMf9dqPOkwQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwzLn6OdOUbMIMSnT/QH4RJCkhPeEUrAh8CgEu6P8X6I5fj5PE5
	x+d1j2gAhzp61ULDDnXrDJOlPveRo/VqE1kgo0GBG+VMCYcG5nrAQ8ZO3Eo6KyU64PQSyYAWOzB
	lS6cWWP1sBNodoNwaJK4Xzr4irhQLoyYS0PoaMtDU11YHegpx0gypNMrwlY1udVC8bfjjo0Ksny
	WZe1Vidwg=
X-Gm-Gg: ASbGncuoI8wGh6dtBQEGc0mEx0luSzXPHx1tjQ03hSyy2l5Qbkrl1Jj3tRLNL3uj+p4
	sZ4tymEk/jiqoFJ1x22hA9TLG5+3mdtnqxh+U8ZN2pc/DGsGWZqZqLa/UN+v30sxWfvPhFxk186
	4KlQPF8CIYldHCiC2jv3nemB/rgScNOEPQKBVX5VEpMDrLkW4exaSFqyvxhCuczLFkfUgckoG0T
	cT5sTDX0/K2Qkp1wB4oLcCHyUUrCQnGvo5T77db7et8XorH5IDzOKUqLyq8rILxGYWq78EQGqtH
	zjXuEUXfGdG6sQ1ydtZ1gb6biqDqyQLbI5v8CZky62+2fLz8B9qJXpOVMBQRlvW75zCLvZLSiTg
	ra3TYpzbza4M/7JK7koRxsSNr3CYf0nfOEw==
X-Received: by 2002:a05:600c:4ecb:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-47939e4d6c2mr100298275e9.31.1765228350617;
        Mon, 08 Dec 2025 13:12:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCR9Yn8BZyqDYbSKjCnQkA9uZfWo9ECmqM4fcZI0UeMfbbXM2zqm69zAcp/CKgcSb87Sphdg==
X-Received: by 2002:a05:600c:4ecb:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-47939e4d6c2mr100298105e9.31.1765228350237;
        Mon, 08 Dec 2025 13:12:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7da22878sm831925e9.16.2025.12.08.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 13:12:29 -0800 (PST)
Date: Mon, 8 Dec 2025 16:12:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com,
	virtualization@lists.linux-foundation.org, oren@nvidia.com,
	aevdaev@nvidia.com, aaptel@nvidia.com
Subject: Re: [PATCH 1/1] virtio: add driver_override support
Message-ID: <20251208160242-mutt-send-email-mst@kernel.org>
References: <20251208143925.32246-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251208143925.32246-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2eWnMwYQcXTyB40vo84ACCFK5MEGoPJgmSvheTrBcmA_1765228351
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2025 at 04:39:25PM +0200, Max Gurtovoy wrote:
> Add support for the 'driver_override' attribute to Virtio devices. This
> allows users to control which Virtio bus driver binds to a given Virtio
> device.
> 
> If 'driver_override' is not set, the existing behavior is preserved and
> devices will continue to auto-bind to the first matching Virtio bus
> driver.
> 
> Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>


Please include, in the commit log, some examples on how this is intended
to be used.

> ---
>  drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h  |  4 ++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a09eb4d62f82..f3ce12ee1fb5 100644
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
> +		return strcmp(dev->driver_override, _dr->name) == 0;
> +

!strcmp is more concise and so is preferred

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

