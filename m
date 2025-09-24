Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5331EE019
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694936; cv=none; b=bqy/u+71Y44x0Goqo0+c8FwwL0ba3KtutordkBFAJbtggowr42jRISnkMkcTWESufunSoUoJXbOvB/0aFWe7KoGLJQWRwScsmzOmnXrZx44/GRwWTmfSqBPNNgisXakkNUfYNbB14ySrfInpMzgCcWVvy7W8CJ1aSjQQD2EUnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694936; c=relaxed/simple;
	bh=KobvBwKpwlasQmO06dps3c9fBIk1snJFTlVWMf2AOuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Qhs5m1P0ExtoDaJHQOetInkopyBZFdZpaGh7kL9ALd0asL6k0k5hD5wed3yNrOUE8yWLKIrTVOek42Im941hy2V9RV4Mgq2QDJ3fHDdiJXJKLoxXmhDc8RyOG4p4eIOQyQRxDhTwgK8l7dDDtUz4UIN+9XQWNHA644y2JuoDQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBnuxeuH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBnuxeuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758694933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk0+GMIf3cxkQMH5R3gUej1/otxyElKG3UC5gT8XNy8=;
	b=UBnuxeuHOUbL2xCTMQyPgLC8nhl8UBEtrloxh/I5eDyBmkcyWc8FOhhxG6SzmlLoqsLCNY
	+Iq+9A5YoleD+nx8g7ByQ63f8xTHcoDkC1sNO2yAM87iRKa/7TTSl9lybwFxejKih/zjK7
	6xpKGBNBnp2Du2RcI674ma2smxLkZJE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-aT6mVfYAMqSnnl_daPH-JQ-1; Wed, 24 Sep 2025 02:22:10 -0400
X-MC-Unique: aT6mVfYAMqSnnl_daPH-JQ-1
X-Mimecast-MFC-AGG-ID: aT6mVfYAMqSnnl_daPH-JQ_1758694929
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46d88f7d691so12606805e9.3
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 23:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758694929; x=1759299729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk0+GMIf3cxkQMH5R3gUej1/otxyElKG3UC5gT8XNy8=;
        b=HJaUVn7TWm+cGF4OZA4DbhIEOu3BduH+S0akyWr/cbRygZeFf2CGqUXNIK2iv5av1l
         TIU8ClhrpPfJ8tzubooD6fcDPP2MNJkPqf1toJqYy0v230L85xDC9Lr37v8WtV+GQuGU
         xQuThzFsDTbgwWX93nwCJQxvRKEXFztNYDprohAFD31BtNkSjC8R2Dq1E+M2lw2TV+Eb
         NnEb/B90s+/RXG/mVyy9DsblRx1YW7casMyJsykZFgmt/rfqWO3XLahse4u5+Lw9vzS6
         fOjoQUGloI5cF71Hmg8g8bJ7w6X3AXuZ1QSYyGuKUNY5o7qg96pNO/uWa+t3ds/PDj4P
         cDZw==
X-Forwarded-Encrypted: i=1; AJvYcCV6p7L5kLl2wtL1ay6ylUz7SaDvFYry+Ag8Hm9VzRW1FhA37OTD8ncBpgp88dxm17yWlOfe+KTdvMCsxqzmvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9SczhyfqFuBbS1kQE/+5Z7wPjKTzC0krdFinlktZeODGMxj58
	P1LXLkYIJDM85hynY0qHpEiPGZXFVTAQWxBA2NFLemGjJifVZiRTNBOTIKOYmYrJaqqng4tXvDu
	EA4bx7/H5ySWilujkxPhcx9WqdLHHGp9Sbs3DD0lc24oMx3MxHY8PAlfnzyg+omnEjhx4RqaOJc
	ML
X-Gm-Gg: ASbGnctK3V3HukJ7fkCGV2R0fgo0xtslqgex6D3ga7zdz4BzZ2S8xAkJTooApNUb/kw
	DXi0zBtl3kMV4iiC82DbYfInhrzgUIQ74shaBYiI0OpVf7XlUV6a5Dk0robZ0j/CbY/0U6cwJHM
	mmgOZNWkInyiNb2QgAXcOdClAQtyNfF/cMovDgQElbNQomL7DRMKYwP0aIjxalyCeWVBNLwY7f2
	rL0gxBl22Ro9Aqz5ZR3VV9dSktJ6gviPVTd2iKmyKqgpeW06/Jgn6FQlOJ3aHadWFSZ0b7TL9UC
	jntBcVrpM9AtTqYiaJtXhLQgIfDy9njNqTo=
X-Received: by 2002:a05:600c:b8d:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-46e1d989005mr44960115e9.13.1758694928766;
        Tue, 23 Sep 2025 23:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHli0MPmSJHEHAtFFVAt/x+EZyqa+2JYMMUF1JFPFhBXHjcg6KBY7OZBD4HKYiN1xNl0pGnxw==
X-Received: by 2002:a05:600c:b8d:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-46e1d989005mr44959855e9.13.1758694928319;
        Tue, 23 Sep 2025 23:22:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1dc48378sm23591255e9.8.2025.09.23.23.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:22:06 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:22:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	alex.williamson@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250924021637-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bbLRG_NpfuonuiizxpSbcfFXnNoREX2ShUBtNmGbMFI_1758694929
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 24, 2025 at 09:16:32AM +0800, Jason Wang wrote:
> On Tue, Sep 23, 2025 at 10:20 PM Daniel Jurgens <danielj@nvidia.com> wrote:
> >
> > Currently querying and setting capabilities is restricted to a single
> > capability and contained within the virtio PCI driver. However, each
> > device type has generic and device specific capabilities, that may be
> > queried and set. In subsequent patches virtio_net will query and set
> > flow filter capabilities.
> >
> > Move the admin related definitions to a new header file. It needs to be
> > abstracted away from the PCI specifics to be used by upper layer
> > drivers.
> >
> > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > ---
> 
> [...]
> 
> >
> >  size_t virtio_max_dma_size(const struct virtio_device *vdev);
> >
> > diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> > new file mode 100644
> > index 000000000000..bbf543d20be4
> > --- /dev/null
> > +++ b/include/linux/virtio_admin.h
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + *
> > + * Header file for virtio admin operations
> > + */
> > +#include <uapi/linux/virtio_pci.h>
> > +
> > +#ifndef _LINUX_VIRTIO_ADMIN_H
> > +#define _LINUX_VIRTIO_ADMIN_H
> > +
> > +struct virtio_device;
> > +
> > +/**
> > + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
> > + * @cap_list: Pointer to capability list structure containing supported_caps array
> > + * @cap: Capability ID to check
> > + *
> > + * The cap_list contains a supported_caps array of little-endian 64-bit integers
> > + * where each bit represents a capability. Bit 0 of the first element represents
> > + * capability ID 0, bit 1 represents capability ID 1, and so on.
> > + *
> > + * Return: 1 if capability is supported, 0 otherwise
> > + */
> > +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> > +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap % 64)))
> > +
> > +/**
> > + * struct virtio_admin_ops - Operations for virtio admin functionality
> > + *
> > + * This structure contains function pointers for performing administrative
> > + * operations on virtio devices. All data and caps pointers must be allocated
> > + * on the heap by the caller.
> > + */
> > +struct virtio_admin_ops {
> > +       /**
> > +        * @cap_id_list_query: Query the list of supported capability IDs
> > +        * @vdev: The virtio device to query
> > +        * @data: Pointer to result structure (must be heap allocated)
> > +        * Return: 0 on success, negative error code on failure
> > +        */
> > +       int (*cap_id_list_query)(struct virtio_device *vdev,
> > +                                struct virtio_admin_cmd_query_cap_id_result *data);
> > +       /**
> > +        * @cap_get: Get capability data for a specific capability ID
> > +        * @vdev: The virtio device
> > +        * @id: Capability ID to retrieve
> > +        * @caps: Pointer to capability data structure (must be heap allocated)
> > +        * @cap_size: Size of the capability data structure
> > +        * Return: 0 on success, negative error code on failure
> > +        */
> > +       int (*cap_get)(struct virtio_device *vdev,
> > +                      u16 id,
> > +                      void *caps,
> > +                      size_t cap_size);
> > +       /**
> > +        * @cap_set: Set capability data for a specific capability ID
> > +        * @vdev: The virtio device
> > +        * @id: Capability ID to set
> > +        * @caps: Pointer to capability data structure (must be heap allocated)
> > +        * @cap_size: Size of the capability data structure
> > +        * Return: 0 on success, negative error code on failure
> > +        */
> > +       int (*cap_set)(struct virtio_device *vdev,
> > +                      u16 id,
> > +                      const void *caps,
> > +                      size_t cap_size);
> > +};
> 
> Looking at this, it's nothing admin virtqueue specific, I wonder why
> it is not part of virtio_config_ops.
> 
> Thanks

cap things are admin commands. But what I do not get is why they
need to be callbacks.

The only thing about admin commands that is pci specific is finding
the admin vq.

I'd expect an API for that in config then, and the rest of code can
be completely transport independent.


-- 
MST

