Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6552D8372
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507036; cv=none; b=RX84cnxKvhbCuy+bswPYg5a0nSpV+Tm/S88lO3/oyVk2kRo1STBJcqymlyDL66douznU+p93ql4uIZr6xsyJwR9ckhfpP7BlqOSHgASR8lHHiz/1/hNOrlmKUX8xyes/zEL72J7sBlnNHaz95plsH29Kre/vPelMDU+LoCcctUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507036; c=relaxed/simple;
	bh=npYF6+AoUb8b1KIGpdUB0fhvvN8s8pNeq8v6fSg+u80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lZjSttd85PG071m4n3euXHvoMqrVJI2QG3aUaL3SDbLQm38iMq/jrNGQp0flXb6RD6gWeNIo/9OYBH/bydWK8VI0G3TiKrcfDTT7B925crjgtw6jCVzWIXR9ovB2k1vb9HA1USpURQduX0yaXngFqTO/fERdyCHD1FhunMX7Sdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNDOOHCk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNDOOHCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763507033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8udVISHoFxlp3Sg2p6zdhaYur6w2cog8DmQ4evuWtRM=;
	b=PNDOOHCki3c4Wcy6HOBCNrIxlEcHzcgRboGU1B4gJex7JcDgwlVeDs+8edMa5zeq+Rq0dk
	1YZSaJgc6/qi6bmlVEleLS4nFVwC/BuQjfDR27XF0ybu6WIJzV0ARxVFFlScjBjJ3PQZzF
	lnxnT/qT7RBOBq6A4Bf+2pjQQgDLy0c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-lt7P292PMTiRNgmUJCRKuQ-1; Tue, 18 Nov 2025 18:03:50 -0500
X-MC-Unique: lt7P292PMTiRNgmUJCRKuQ-1
X-Mimecast-MFC-AGG-ID: lt7P292PMTiRNgmUJCRKuQ_1763507029
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477212937eeso39280755e9.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 15:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763507029; x=1764111829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8udVISHoFxlp3Sg2p6zdhaYur6w2cog8DmQ4evuWtRM=;
        b=GDD7ywQvdFLqTCeG6wLjemVUsBRyisbdxrqhkjbu/gRv3xBz0hf1HeUlYImPpA85sU
         1vH2VJEYflB9TG7y/Bt00bK6paub2UU+eNeolsd1PCZSOQn5yyWEjKkBKmM+6GuIt/jY
         w1mirbQ2TXlsyub+rgnIAaZH12jF5yLckB/uGVkXHGUCyusCvG+ZvFaquj+bfKMyFsX4
         Xr+68CSgeyzmeF5KAvym7ZEVxIkxh8B/KD5GN+tSKSS8J1DWndjL5IsxJC1ESTQaQ0qV
         YXCxoxrZHkFogkopJR7AD0f8fet9a153YqxIN5HV1+Wtq9ScFHWm9N4JsOi7M62znaGU
         eCeA==
X-Forwarded-Encrypted: i=1; AJvYcCUHjZb9/rZhCkLbMWcn/Kjf9sx26g7avhqSGFo/t1edWphYId1GC4YFFM9YK8bTB/5UgKxttLpRrYBP0yQw9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrGBowGpKKzOQ7/a/eEyNo41Qy0b7yI7Z0VcdKglSlU2KtHpkv
	8bErQu3Ld3+b1zoJnHhNLkpNnxgfuMDRIs5S+ZcyuYkUkG84ydaHv4f41KVbRAFBhBXXDBZZI81
	NETnVrThj5eiebIkDperKrjozZsO+JSH1yiqStoSdmR3SK60UFtLl0nuSevPeVHjAPtTT
X-Gm-Gg: ASbGncts6zRsSqFm6jiuiOfqqDXUaLvWNVMhcuqAuPfTsFcR3VLs72U3qv0sU8HVcFz
	oakdkxfCLp7SILHULtmuGT1+2gfFRq9TgvBwfpu2xslS/n+Cs5DOSMsPfCMRCrnl5zu0hPt5+DG
	ea9TW+aEO2hD9AfimcMu9hMTZuaFmn6XSKqOna43kee2N2S3j0N5JFiQYg3u1dFcjXbsupD/kvR
	KSAJFp13Ryn7T5Jx6LIdm0o6wLWpNgFBSW1GsvzrBaCQqvZtoLZqi7qdyt20rePPE2G9N8SaG33
	NJeesVVKOnRDd9/u+ifW/F6DBFqDOdNVfagLRwSxEFvd/HOqE9V8haHbmAjZzXpHSDGmd/F3ZpS
	pExEs3ub/WnAWWlhKaDVB8b3uQLoVgg==
X-Received: by 2002:a05:600c:1f12:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4778fe9b250mr160601955e9.20.1763507029267;
        Tue, 18 Nov 2025 15:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZld3jZdWSXwYkOZHWyxTAJsgVq11Sy2lh9ynZa5otsTbFN0s4UdFWsFrFpbfzJjkwOGFgwQ==
X-Received: by 2002:a05:600c:1f12:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4778fe9b250mr160601765e9.20.1763507028810;
        Tue, 18 Nov 2025 15:03:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1013edcsm14301225e9.4.2025.11.18.15.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 15:03:47 -0800 (PST)
Date: Tue, 18 Nov 2025 18:03:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251118180127-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ram1sI_76iXRGLU_fH9NZwXUwvBWlzMbFkCwN2YbD_w_1763507029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> new file mode 100644
> index 000000000000..bd7a194a9959
> --- /dev/null
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> + *
> + * Header file for virtio_net flow filters
> + */
> +#ifndef _LINUX_VIRTIO_NET_FF_H
> +#define _LINUX_VIRTIO_NET_FF_H
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>


I do not get why you are pulling linux/kernel.h here.

include/uapi/linux/virtio_pci.h does it too,
and I think it's also a bug.

No other uapi header does this, it happens not to break userspace
because userspace puts a completely unrelated header at
the same path - uapi/linux/kernel.h .



> +
> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
> +
> +/**
> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> + * @groups_limit: maximum number of flow filter groups supported by the device
> + * @classifiers_limit: maximum number of classifiers supported by the device
> + * @rules_limit: maximum number of rules supported device-wide across all groups
> + * @rules_per_group_limit: maximum number of rules allowed in a single group
> + * @last_rule_priority: priority value associated with the lowest-priority rule
> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
> + *
> + * The limits are reported by the device and describe resource capacities for
> + * flow filters. Multi-byte fields are little-endian.
> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
> +};
> +
> +/**
> + * struct virtio_net_ff_selector - Selector mask descriptor
> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @length: size in bytes of @mask
> + * @reserved1: must be set to 0 by the driver and ignored by the device
> + * @mask: variable-length mask payload for @type, length given by @length
> + *
> + * A selector describes a header mask that a classifier can apply. The format
> + * of @mask depends on @type.
> + */
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
> +/**
> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
> + * @count: number of entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: array of supported selector descriptors
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];
> +};
> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
> +
> +#define VIRTIO_NET_FF_ACTION_DROP 1
> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
> +/**
> + * struct virtio_net_ff_actions - Supported flow actions
> + * @count: number of supported actions in @actions
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
> + */
> +struct virtio_net_ff_actions {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 actions[];
> +};
> +#endif
> -- 
> 2.50.1

