Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEC0C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 09:32:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AC160F4B
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 09:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25AC160F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5C31605D0;
	Mon, 27 Sep 2021 09:32:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTGwT9uS-hxW; Mon, 27 Sep 2021 09:32:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 87FB060796;
	Mon, 27 Sep 2021 09:32:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FF7DC0011;
	Mon, 27 Sep 2021 09:32:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31711C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B6BC81815
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uQNGrr5k2n-I
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:32:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AB7B81501
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632735127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hha6vL8+kgRFRejoaAGUuH6/XDbDSBp6ZRA9Bz723U8=;
 b=M/hrVJ1vcIU/86RKfuzIanElXmW7zlk+xHPy+4oOYV5lAs83C1NkU8lJeylj8Bu//ZrodE
 aIi5oqvmmnc3icsLxWigeWk4XZIhzvjYIL6yXx8QpekfGNG8U+ZuhAZdBrI/rzmzekRAye
 8sjljUDsLMI5vsG1McEu89uw+Y1Ig64=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-z585gAmxNhGwY0oB6Iq4aw-1; Mon, 27 Sep 2021 05:32:05 -0400
X-MC-Unique: z585gAmxNhGwY0oB6Iq4aw-1
Received: by mail-wr1-f72.google.com with SMTP id
 j15-20020a5d564f000000b00160698bf7e9so500979wrw.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 02:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hha6vL8+kgRFRejoaAGUuH6/XDbDSBp6ZRA9Bz723U8=;
 b=hsB4GAczr32Vi9kwMkp0WXhjSvxvjKzNIaK1MJwEJBaC8C0al8zBcwcNKZR9C9C6Km
 t7R7xINiGWuxRs1k8HNFxnx3EBwZuxHkUkbULFGha74WE3Bun8wlUlnGkRltcAaomUUl
 cRnCo95fWsdQKfWKbGaxanCSY9qOAvIcjPF8hyRWhseyVxc4p68WVXJwPPXVstaqZrVw
 pApW6r8UcPF2m8qeG/Obx4GuYyEivwVS7SXPYixcR85S9k14cfcKKoo20jL1ZXZ4kzH1
 ty+rH8eO9ZCx7ZETYTfMIzFAR4Lw1cLtx1IM6+ig53Nbf3Ra40HQcH9uXKEgu6cKxGrI
 uRSA==
X-Gm-Message-State: AOAM533LDQednjKxEM+z6V2UFlj2cwXfL+Q2P2XI3kscaj9d3gjUG22r
 kmv2glqrZRhvKvqYqgo+Ymmkp4ExiFozmRN8UsX9l+QpXItVj5lWT3RyXOdq8qnWoO/F5cYGTto
 w4ljw2fhALT01mmwMQQSfhcP845V5b20EPnNusQzteg==
X-Received: by 2002:a1c:149:: with SMTP id 70mr14434836wmb.187.1632735124348; 
 Mon, 27 Sep 2021 02:32:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTU4NNTP2HGI7OzM+EzYF7opQVO5IGaLtp4UKJfZpY1HlzX9J5DT46xdOlGweUx96TXH9s/w==
X-Received: by 2002:a1c:149:: with SMTP id 70mr14434800wmb.187.1632735124041; 
 Mon, 27 Sep 2021 02:32:04 -0700 (PDT)
Received: from redhat.com ([2.55.16.138])
 by smtp.gmail.com with ESMTPSA id k17sm16160443wrq.7.2021.09.27.02.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 02:32:03 -0700 (PDT)
Date: Mon, 27 Sep 2021 05:31:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/2] virtio: introduce virtio_dev_to_node helper
Message-ID: <20210927053121-mutt-send-email-mst@kernel.org>
References: <20210926145518.64164-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210926145518.64164-1-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, stefanha@redhat.com, oren@nvidia.com
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

On Sun, Sep 26, 2021 at 05:55:17PM +0300, Max Gurtovoy wrote:
> Also expose numa_node field as a sysfs attribute. Now virtio device
> drivers will be able to allocate memory that is node-local to the
> device. This significantly helps performance and it's oftenly used in
> other drivers such as NVMe, for example.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

If you have to respin this, it is better to split this in
two patches, one with the helper one adding a sysfs attribute.


> ---
>  drivers/virtio/virtio.c | 10 ++++++++++
>  include/linux/virtio.h  | 13 +++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 588e02fb91d3..bdbd76c5c58c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -60,12 +60,22 @@ static ssize_t features_show(struct device *_d,
>  }
>  static DEVICE_ATTR_RO(features);
>  
> +static ssize_t numa_node_show(struct device *_d,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(_d);
> +
> +	return sysfs_emit(buf, "%d\n", virtio_dev_to_node(vdev));
> +}
> +static DEVICE_ATTR_RO(numa_node);
> +
>  static struct attribute *virtio_dev_attrs[] = {
>  	&dev_attr_device.attr,
>  	&dev_attr_vendor.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_modalias.attr,
>  	&dev_attr_features.attr,
> +	&dev_attr_numa_node.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(virtio_dev);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 41edbc01ffa4..05b586ac71d1 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -125,6 +125,19 @@ static inline struct virtio_device *dev_to_virtio(struct device *_dev)
>  	return container_of(_dev, struct virtio_device, dev);
>  }
>  
> +/**
> + * virtio_dev_to_node - return the NUMA node for a given virtio device
> + * @vdev:	device to get the NUMA node for.
> + */
> +static inline int virtio_dev_to_node(struct virtio_device *vdev)
> +{
> +	struct device *parent = vdev->dev.parent;
> +
> +	if (!parent)
> +		return NUMA_NO_NODE;
> +	return dev_to_node(parent);
> +}
> +
>  void virtio_add_status(struct virtio_device *dev, unsigned int status);
>  int register_virtio_device(struct virtio_device *dev);
>  void unregister_virtio_device(struct virtio_device *dev);
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
