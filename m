Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18435271454
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834105; cv=none; b=TFsrqjmIUmZp7MysPxN0MHF7xnsqaAbiFKY2Mj/B8lPsACPK2FkWHmPYDg79bCiIEvnWFMjWo0KPkHYeoelRQJzQRz4dKfqJe9wp6iNIJiuKuas1fLzAtMOWv43r6lvGue1nDNihzMnrqHiPYotwi96vKxdFmAV37Gpf15mC+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834105; c=relaxed/simple;
	bh=2XVa97jVFVvj+iRpv6rfZBglNYqeugbj+mJ0Wvdwtxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C0s+9dAuz6arZvn8gcHPDtw9tizqRn1Y4v9QBvVtcJM9TXsVmGy0Q3vbIsuEZyWBGVj3hWEQwYYS58zGAyEoK5Kjl+Nz/o4H+Y3XxKUOEV5r9Ye6c9dDOqxaev5NdGHDHfAMUaDF4zrBebX26ekkGUjETnGQlK+hSjIY75MESUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q70SwOJ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q70SwOJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758834101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4I8r0Gebt3TnGqT4W+cQp1XgsPQPS85bS8o2gm+B2c=;
	b=Q70SwOJ7lKnyKGpHjfBk/AVZR0elOvtOZnMotOL0WlaOUJDz+XpbUuRoSl5oVCtYSIs5+3
	lEG1gE2hrdnspw2d3xO4hMjf8wrpdRc8f5Ajq+ilF2nkD+b1NqvLlYcqx4gv7hSO9EvM9W
	vKU8zFlBTm0CN3+nscXxAnSN7eEkHcw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-zXlc54XoNoWoUpxUEwM4vQ-1; Thu, 25 Sep 2025 17:01:34 -0400
X-MC-Unique: zXlc54XoNoWoUpxUEwM4vQ-1
X-Mimecast-MFC-AGG-ID: zXlc54XoNoWoUpxUEwM4vQ_1758834093
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so1166981f8f.2
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 14:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758834093; x=1759438893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4I8r0Gebt3TnGqT4W+cQp1XgsPQPS85bS8o2gm+B2c=;
        b=CW+hkdDF7ANyS3yXLC77xSaRfjZlVeFOixITh5lgukLKeR+OXTg/kkaZ2eUfSo2J48
         MjUgw37MjypVlBg83C1N1OBXh6HpAUm+fg/D0TjfK1K+hc4ZBr8uaVQzo5vOq1jb1iuM
         QJI49foV8ws+xq83oq5+fHDoN+NCmZMth1keTCHKHJGx+MWS9kIlPp78ROdlrQRfxFwM
         s8l8JEacF9szQriRrIDi2ttqU16JeRaMFxUzgIaag5gqwLOAIyvmvNyzOHIdu72AdOK6
         Z03UuIdHGkop2Qf9CFPiQia1qjhq542keNbQ6o8jdyQ24BXPy28HojYQ24UFt0/NDwDF
         bqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1nVq1B5IlCQ4MISUmwojWB0GCxd7sb2zy8sTjWti1L5BLMJT7KR0DvCuK2LIeo+M5ZL8fiET3Y9LjxAsufw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8bhhDLzDFpyFSgJvw+qPT5YFb4hXOTII/r2b3PcDBymIqI5Ss
	7sV8OBLnPZHzuNcCTk9hS79kt66ljEfXjBB75IfSATKxvC6E2a9vecZUQA9yw+cWTyfhJ9zWEZi
	Sgz1ypMSTT8GGG+HcDTKiOYJm1ywzCuguA4w16sEhedWm8muc1lVakj7rcTk4Q663zGTn
X-Gm-Gg: ASbGncvVkZdRQXdEroQL9Wqwg7vjik0ZxkeABiJTZ6/Qp2F4s5nYa2LBrcMiHMZ6OA9
	Z1nZTXlLgXal5l94EWNNknx9Xj+dPc6ugAlixcLIcStpNsTl3WsrRdfMvvxv8gO+WScpcHkc97Y
	KsEhFr+esXCGOt/qaMWnTZYtwzYXl0nvcecYrDg8SsRha7GWbk1ka9Q0b2xNcW3CAseyzoEsBoa
	Jsi+cXUp+4ZyMvr+zQqjQrvfF+5HY9jbzlVXOeLDv6qlEqsXty7za6FBPD3YU3qWA8yydOQhswR
	00ToK+k22a0ztkthpS19laOpScoghJsZtA==
X-Received: by 2002:a05:6000:2dc5:b0:3ec:db0a:464c with SMTP id ffacd0b85a97d-40e4ca79f10mr5371705f8f.44.1758834093449;
        Thu, 25 Sep 2025 14:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhXE7HJ7jksdIDK+D2hsUmI5ws0FD9W+W3p36wqBSTGH7zRcVZMfqA72tt2nqQDP4mOYET2A==
X-Received: by 2002:a05:6000:2dc5:b0:3ec:db0a:464c with SMTP id ffacd0b85a97d-40e4ca79f10mr5371681f8f.44.1758834093013;
        Thu, 25 Sep 2025 14:01:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996d7dsm96141185e9.4.2025.09.25.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:01:32 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:01:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter
 caps
Message-ID: <20250925170004-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-5-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250923141920.283862-5-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fWkksqWuHKDh7_jZhg9bWEMVlIP1pMoLEHIysYf6Gc4_1758834093
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 09:19:13AM -0500, Daniel Jurgens wrote:
> When probing a virtnet device, attempt to read the flow filter
> capabilities. In order to use the feature the caps must also
> be set. For now setting what was read is sufficient.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net/Makefile          |   2 +-
>  drivers/net/virtio_net/virtio_net_ff.c   | 145 +++++++++++++++++++++++
>  drivers/net/virtio_net/virtio_net_ff.h   |  22 ++++
>  drivers/net/virtio_net/virtio_net_main.c |   7 ++
>  include/linux/virtio_admin.h             |   1 +
>  include/uapi/linux/virtio_net_ff.h       |  55 +++++++++
>  6 files changed, 231 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/virtio_net/virtio_net_ff.c
>  create mode 100644 drivers/net/virtio_net/virtio_net_ff.h
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
> index c0a4725ddd69..c41a587ffb5b 100644
> --- a/drivers/net/virtio_net/Makefile
> +++ b/drivers/net/virtio_net/Makefile
> @@ -5,4 +5,4 @@
>  
>  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>  
> -virtio_net-objs := virtio_net_main.o
> +virtio_net-objs := virtio_net_main.o virtio_net_ff.o
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> new file mode 100644
> index 000000000000..61cb45331c97
> --- /dev/null
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/virtio_admin.h>
> +#include <linux/virtio.h>
> +#include <net/ipv6.h>
> +#include <net/ip.h>
> +#include "virtio_net_ff.h"
> +
> +static size_t get_mask_size(u16 type)
> +{
> +	switch (type) {
> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +		return sizeof(struct ethhdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +		return sizeof(struct iphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return sizeof(struct ipv6hdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +		return sizeof(struct tcphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +		return sizeof(struct udphdr);
> +	}
> +
> +	return 0;
> +}
> +
> +void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
> +{
> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list __free(kfree) = NULL;
> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
> +			      sizeof(struct virtio_net_ff_selector) *
> +			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_ff_selector *sel;
> +	int err;
> +	int i;
> +
> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
> +	if (!cap_id_list)
> +		return;
> +
> +	err = virtio_device_cap_id_list_query(vdev, cap_id_list);
> +	if (err)
> +		return;
> +
> +	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_RESOURCE_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_SELECTOR_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_ACTION_CAP)))
> +		return;
> +
> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
> +	if (!ff->ff_caps)
> +		return;
> +
> +	err = virtio_device_cap_get(vdev,
> +				    VIRTIO_NET_FF_RESOURCE_CAP,
> +				    ff->ff_caps,
> +				    sizeof(*ff->ff_caps));
> +
> +	if (err)
> +		goto err_ff;
> +
> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +		ff_mask_size += get_mask_size(i);
> +
> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
> +	if (!ff->ff_mask)
> +		goto err_ff;
> +
> +	err = virtio_device_cap_get(vdev,
> +				    VIRTIO_NET_FF_SELECTOR_CAP,
> +				    ff->ff_mask,
> +				    ff_mask_size);
> +
> +	if (err)
> +		goto err_ff_mask;
> +
> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
> +					VIRTIO_NET_FF_ACTION_MAX,
> +					GFP_KERNEL);
> +	if (!ff->ff_actions)
> +		goto err_ff_mask;
> +
> +	err = virtio_device_cap_get(vdev,
> +				    VIRTIO_NET_FF_ACTION_CAP,
> +				    ff->ff_actions,
> +				    sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> +
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_device_cap_set(vdev,
> +				    VIRTIO_NET_FF_RESOURCE_CAP,
> +				    ff->ff_caps,
> +				    sizeof(*ff->ff_caps));
> +	if (err)
> +		goto err_ff_action;
> +
> +	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> +	sel = &ff->ff_mask->selectors[0];
> +
> +	for (int i = 0; i < ff->ff_mask->count; i++) {


I do not think kernel style allows this int inside loop.
I think you need to declare it at the beginning of the block.

> +		ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		sel = (struct virtio_net_ff_selector *)((u8 *)sel + sizeof(*sel) + sel->length);
> +	}
> +
> +	err = virtio_device_cap_set(vdev,
> +				    VIRTIO_NET_FF_SELECTOR_CAP,
> +				    ff->ff_mask,
> +				    ff_mask_size);
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_device_cap_set(vdev,
> +				    VIRTIO_NET_FF_ACTION_CAP,
> +				    ff->ff_actions,
> +				    sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> +	if (err)
> +		goto err_ff_action;
> +
> +	ff->vdev = vdev;
> +	ff->ff_supported = true;
> +
> +	return;
> +
> +err_ff_action:
> +	kfree(ff->ff_actions);
> +err_ff_mask:
> +	kfree(ff->ff_mask);
> +err_ff:
> +	kfree(ff->ff_caps);
> +}
> +
> +void virtnet_ff_cleanup(struct virtnet_ff *ff)
> +{
> +	if (!ff->ff_supported)
> +		return;
> +
> +	kfree(ff->ff_actions);
> +	kfree(ff->ff_mask);
> +	kfree(ff->ff_caps);
> +}
> diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
> new file mode 100644
> index 000000000000..4aac0bd08b63
> --- /dev/null
> +++ b/drivers/net/virtio_net/virtio_net_ff.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Header file for virtio_net flow filters
> + */
> +#include <linux/virtio_admin.h>
> +
> +#ifndef _VIRTIO_NET_FF_H
> +#define _VIRTIO_NET_FF_H
> +
> +struct virtnet_ff {
> +	struct virtio_device *vdev;
> +	bool ff_supported;
> +	struct virtio_net_ff_cap_data *ff_caps;
> +	struct virtio_net_ff_cap_mask_data *ff_mask;
> +	struct virtio_net_ff_actions *ff_actions;
> +};
> +
> +void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
> +
> +void virtnet_ff_cleanup(struct virtnet_ff *ff);
> +
> +#endif /* _VIRTIO_NET_FF_H */
> diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
> index 7da5a37917e9..ebf3e5db0d64 100644
> --- a/drivers/net/virtio_net/virtio_net_main.c
> +++ b/drivers/net/virtio_net/virtio_net_main.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include "virtio_net_ff.h"
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -493,6 +494,8 @@ struct virtnet_info {
>  	struct failover *failover;
>  
>  	u64 device_stats_cap;
> +
> +	struct virtnet_ff ff;
>  };
>  
>  struct padded_vnet_hdr {
> @@ -7116,6 +7119,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	virtnet_ff_init(&vi->ff, vi->vdev);
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -7131,6 +7136,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  free_unregister_netdev:
>  	unregister_netdev(dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_vqs:
> @@ -7180,6 +7186,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>  	virtnet_free_irq_moder(vi);
>  
>  	unregister_netdev(vi->dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  
>  	net_failover_destroy(vi->failover);
>  
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index cc6b82461c9f..f8f1369d1175 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -3,6 +3,7 @@
>   * Header file for virtio admin operations
>   */
>  #include <uapi/linux/virtio_pci.h>
> +#include <uapi/linux/virtio_net_ff.h>
>  
>  #ifndef _LINUX_VIRTIO_ADMIN_H
>  #define _LINUX_VIRTIO_ADMIN_H
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> new file mode 100644
> index 000000000000..a35533bf8377
> --- /dev/null
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> + *
> + * Header file for virtio_net flow filters
> + */
> +#ifndef _LINUX_VIRTIO_NET_FF_H
> +#define _LINUX_VIRTIO_NET_FF_H
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +
> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
> +
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
> +};
> +
> +struct virtio_net_ff_selector {
> +	__u8 type;
> +	__u8 flags;
> +	__u8 reserved[2];
> +	__u8 length;
> +	__u8 reserved1[3];
> +	__u8 mask[];
> +};
> +
> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
> +
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	struct virtio_net_ff_selector selectors[];
> +};
> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
> +
> +#define VIRTIO_NET_FF_ACTION_DROP 1
> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
> +struct virtio_net_ff_actions {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 actions[];
> +};
> +#endif
> -- 
> 2.45.0

