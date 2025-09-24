Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986B1DA60F
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676609; cv=none; b=f4CXhn6XWHcyNQ9nbr+B6/1T1uabPxSw/PmdZzSB+QmJVEuNj7tYz+F4isJY1jU03frfHPmslsPZbsIiuZa2J+59DFoWLEtVXBDD+Q8qQDK23t0jvxTLAfrIOmLoomU6GNw0yIFg6PSXKlaXFlcGjR8/nTd3ToBOQc9KrJYBDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676609; c=relaxed/simple;
	bh=A37mvEVaESR9ERs99IPcDOLra8qkZubx6sUnWAZs6gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKxYl4e9Ens1vYiGYgQYt5jLFL8Vjq5l7DzBM0J6ZDA8lHbyjqM8JWtQpRhaNuPH0Rw6y8P5H1NNV0Gt7MStXQI7dGvtXZKOk8JvahMHLFFS0VO6sYIHOvDeSCJH8IQsE44E4OKEMaIX1svTsjuew7dt+2Gb3/kga2sK/8kumU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3Couzl1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3Couzl1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758676606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyDZ+fFvNiHT1HqmIdQBeq5LnfgvaLlQ7Rr3LfU20CE=;
	b=W3Couzl1GDWT8tgcZdrIdzl8cgYuroIrIq5cmlwssExx6V4j+mFBb0Tugyf9azYaOvxiVJ
	BXf7USkz4Ov1YkbcJR+YVkb0VGtm/tB4D1juK08UtfR1+O7tHFt1GzazSuoxRs2PXSFe+y
	X5cAuv1TM+g0f92IhVWwsLQWMgVJvX8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-8DTyE8h0NzKbyoXcRt2_sg-1; Tue, 23 Sep 2025 21:16:45 -0400
X-MC-Unique: 8DTyE8h0NzKbyoXcRt2_sg-1
X-Mimecast-MFC-AGG-ID: 8DTyE8h0NzKbyoXcRt2_sg_1758676605
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32edda89a37so5976379a91.1
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 18:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676605; x=1759281405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyDZ+fFvNiHT1HqmIdQBeq5LnfgvaLlQ7Rr3LfU20CE=;
        b=YLXPOliXGbWz0vDU58SvcH7SbGnGvW8I8HftXlAmOn46jyptl3AR4ky9T/H2Sk3wlP
         iEtY956Mj/HNEXfIefquxIzKPhHwgjDOpD/0hQmQA8KXrPqfvw6baim5gq7d5y5Kbilg
         B8glU4A+vlIyi9TqypCwtUpNBGXqH29umm6twu5BvXH9B2YPymCi7/+njXMAkhAOXF0X
         Jh/3Mk5dwq1WbmRwNZ2fl3V5xOa8JpvLZ4Us+4ffln0ud43TeSBnhJx1XDUNLTvLKm8s
         BTcV0vMnqjEu+FR/Z74MPPQlLjE8dfK6kI3z9Hzt7inWJziZ1IMwG3NNPEM5Agwvg94R
         +cMg==
X-Forwarded-Encrypted: i=1; AJvYcCU2Oi199F0mGQVc4H+oveM1rX3s0J2pOqt46R5vxgXlJeCmmvdQKx7GX452XkAF6eiehp6WMg3z1Avj8G2akw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpkt3oMT9hb2LC/tavIyAMQlnlsdaSEemUe8Pze74zoORXHwn2
	5GFq2ufL/tC9KKoJQoW5n2QKow5MqBJ6XTvVBTzimPk71eWCLhNZJdIKHppO27duQEEBxxg+YPX
	nydrlyGyGtgXgkzllZHrAyLr2x2DFvim6tY+p+UT2KwkKyd4u3htcWwFuxLBcgjGUiUrboyokgG
	6cvLrVSXtB083GdT+FDc7tI8BVdV3Oz3cUUXlhFGwKy4I=
X-Gm-Gg: ASbGncvgLsH7yl83bwAS7CnL70mJt4mhcZR3l6vXyvkl7aX9x395sx1MgVrugvcWtX+
	0VyELm52ZWpNLEDOzYvP1h9GF0+suhHDrOUxVRR/ySRHi1+w4DkQwLFrvCndqNytzbR79foetdn
	KXiS1CRwYVv7v0FglZjA==
X-Received: by 2002:a17:90b:2787:b0:32e:9daa:7347 with SMTP id 98e67ed59e1d1-332a92c9d80mr5114655a91.7.1758676604622;
        Tue, 23 Sep 2025 18:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs73M9j2BtC1//YXJzQkXNW+3YPImYGOnyy6pQKBAcyQFPHjntIsqG+Q8iHg4YeF4Q32lErt4BqBZ2IoYHWWs=
X-Received: by 2002:a17:90b:2787:b0:32e:9daa:7347 with SMTP id
 98e67ed59e1d1-332a92c9d80mr5114636a91.7.1758676604146; Tue, 23 Sep 2025
 18:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250923141920.283862-1-danielj@nvidia.com> <20250923141920.283862-2-danielj@nvidia.com>
In-Reply-To: <20250923141920.283862-2-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 09:16:32 +0800
X-Gm-Features: AS18NWDhGgiNINZrLH8_-LM_Y57n9a7onhAJNax7urmMViSZxqMJ6y0IOuE6oz8
Message-ID: <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, Yishai Hadas <yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rj7LjarKhW_g2tLRTX4TugfnhpnsypQ53W0CLgOzqLw_1758676605
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:20=E2=80=AFPM Daniel Jurgens <danielj@nvidia.com=
> wrote:
>
> Currently querying and setting capabilities is restricted to a single
> capability and contained within the virtio PCI driver. However, each
> device type has generic and device specific capabilities, that may be
> queried and set. In subsequent patches virtio_net will query and set
> flow filter capabilities.
>
> Move the admin related definitions to a new header file. It needs to be
> abstracted away from the PCI specifics to be used by upper layer
> drivers.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> ---

[...]

>
>  size_t virtio_max_dma_size(const struct virtio_device *vdev);
>
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> new file mode 100644
> index 000000000000..bbf543d20be4
> --- /dev/null
> +++ b/include/linux/virtio_admin.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Header file for virtio admin operations
> + */
> +#include <uapi/linux/virtio_pci.h>
> +
> +#ifndef _LINUX_VIRTIO_ADMIN_H
> +#define _LINUX_VIRTIO_ADMIN_H
> +
> +struct virtio_device;
> +
> +/**
> + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capabi=
lity list
> + * @cap_list: Pointer to capability list structure containing supported_=
caps array
> + * @cap: Capability ID to check
> + *
> + * The cap_list contains a supported_caps array of little-endian 64-bit =
integers
> + * where each bit represents a capability. Bit 0 of the first element re=
presents
> + * capability ID 0, bit 1 represents capability ID 1, and so on.
> + *
> + * Return: 1 if capability is supported, 0 otherwise
> + */
> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap %=
 64)))
> +
> +/**
> + * struct virtio_admin_ops - Operations for virtio admin functionality
> + *
> + * This structure contains function pointers for performing administrati=
ve
> + * operations on virtio devices. All data and caps pointers must be allo=
cated
> + * on the heap by the caller.
> + */
> +struct virtio_admin_ops {
> +       /**
> +        * @cap_id_list_query: Query the list of supported capability IDs
> +        * @vdev: The virtio device to query
> +        * @data: Pointer to result structure (must be heap allocated)
> +        * Return: 0 on success, negative error code on failure
> +        */
> +       int (*cap_id_list_query)(struct virtio_device *vdev,
> +                                struct virtio_admin_cmd_query_cap_id_res=
ult *data);
> +       /**
> +        * @cap_get: Get capability data for a specific capability ID
> +        * @vdev: The virtio device
> +        * @id: Capability ID to retrieve
> +        * @caps: Pointer to capability data structure (must be heap allo=
cated)
> +        * @cap_size: Size of the capability data structure
> +        * Return: 0 on success, negative error code on failure
> +        */
> +       int (*cap_get)(struct virtio_device *vdev,
> +                      u16 id,
> +                      void *caps,
> +                      size_t cap_size);
> +       /**
> +        * @cap_set: Set capability data for a specific capability ID
> +        * @vdev: The virtio device
> +        * @id: Capability ID to set
> +        * @caps: Pointer to capability data structure (must be heap allo=
cated)
> +        * @cap_size: Size of the capability data structure
> +        * Return: 0 on success, negative error code on failure
> +        */
> +       int (*cap_set)(struct virtio_device *vdev,
> +                      u16 id,
> +                      const void *caps,
> +                      size_t cap_size);
> +};

Looking at this, it's nothing admin virtqueue specific, I wonder why
it is not part of virtio_config_ops.

Thanks

