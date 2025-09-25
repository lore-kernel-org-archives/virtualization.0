Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD662E8B96
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780972; cv=none; b=FFYBO1iVxnFzrDi7wUh8P6vRtKXqUXubQ2tLsw6f9VKNhplzLkfnPYRTKO9RrI24kiJpqa3y9Mtdp/MmNOzwiYtiENgOLAbs8poWsjA7fwQVq3QHztaraQLFk/bI3Id6qUI6EzcrH5UBcKDrHpIi2hYDqMLH4iKLl/IPD6bK/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780972; c=relaxed/simple;
	bh=ym7Tpix1UpJDS1eczYUlio7mh2VZslazbbBaQQynEKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c22Ip+W++OUcMXhKYLkcte3TQzBt17O6HUmXpREkYikyFd/6kvccm5a3TldGoWp9bYc5LBRA9jXKntx++3gEiYQbBSLNGTIIdLaU3xbkTnA931C37JzhIeCH37nubXNQPgj4TCjRf4V9sMOPgYqJ75PpNz60oKUiE8wEhH7zIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axFino1S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axFino1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758780968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDuj6YD2Nx2N9l6bvv4bKsQHNR4fQToj5F1XqAc3+QM=;
	b=axFino1ScEXaL7y5e0IfHTCesqzez+cd6PNwKwCECmAkFGBGE5PeZ42rTx2OhWeZN4b0UC
	6IvsfJMghlhzjYactNGwbz+b6sjPRNusojBsuv7PzOv+tILHdYKh6umYHkm7zSq7ugqukL
	gHdGO0Ys2fZAxvZjGurx+nI4WiEDG44=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-W2tIOP9RP5a5mTTCRPEeoA-1; Thu, 25 Sep 2025 02:16:07 -0400
X-MC-Unique: W2tIOP9RP5a5mTTCRPEeoA-1
X-Mimecast-MFC-AGG-ID: W2tIOP9RP5a5mTTCRPEeoA_1758780966
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f384f10762so280741f8f.3
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 23:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780966; x=1759385766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDuj6YD2Nx2N9l6bvv4bKsQHNR4fQToj5F1XqAc3+QM=;
        b=RQxkXMTdSBICOGqXcjWRM+ThgL2EYmCSvJ29njQQKHY+ZJHesRrg5E4yD8woDUrGpV
         UiMXnWnWLYjQ8w3KqMGqgLiwIK+1E5GIDX0JBDy08+PqmcnzmDqWYNRDG+eyxg0iD0r3
         qBd5QfDv/WXZWhR7Mtev66lrtDGLYiaxft1vh5tQHFRGUhrjYu7mjIGFjtnmhVWYSipM
         MmskZOpD5vgX0WUU98oYPugFaMGvOBqh+X3z/YXx5zS94PiFMDl9zxk/9b8J/q3vn3kb
         BBYlwvPhdfjVEzskSVL5CR10j9ZWxwNSvEF31r8PDgzM8RIgTNVE88FHaK0/1ZwbgTQV
         6YjA==
X-Forwarded-Encrypted: i=1; AJvYcCWmmi5V/lXLEL7PqgjpXN7L7UtFXh1ZLlQSDZFxmr85/vbEfE+6qaeNgG2FFdhviGKp7ZD4sI4hLJDxWUg3Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhFEtu27ub/v15RTFmRNvx8LgXvxtp6PRdp3jdRzSnpooqUcTe
	1X+FMSz0NXJHK1rNg5VIRg0Esv+N2TbaleS7FrCIrwLNt2bMoBLznl5JXYSfkMof7ngSmnpNA53
	NljOwPSPKtFm2G0s3TuXJisgwn6jOjNrFViSAy/RDzm7BE8wvAKiZ/thubDzEid0qH3js
X-Gm-Gg: ASbGnctD/0/yomjq3ZlYteLde7nM/Fnqw4sIEn+jIRnzfDj+wRc3MYub1mAST4B14eL
	IHEkwG5EH/aP3swJG4AxVJ+c4P7FXBQv1uZt+/Yj/vtFyTH7/XOe+Y6W8b0zFKrcIJ5/Lk3ipqg
	RtlXV3ETM4VIpIn2EZxcRsHbKxcpH+SugkRX8igIvRwURdZro6TBY+tUfxsXa/4aokvWdl2pxX2
	JQnzvlio10/LFeQDE36avWrnTqWDFWqhK7GZ+avKkcIo7hSTIz4hOmfmYNj8c9ZfX11aeasOt3W
	UiKVAgbsAGbLYTIQqrtdo2XeWQ3SQ66RDA==
X-Received: by 2002:a05:6000:22c2:b0:3ea:3b7b:80bb with SMTP id ffacd0b85a97d-40e4ce4c5f2mr1725830f8f.58.1758780965696;
        Wed, 24 Sep 2025 23:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7q5ckEjz8pOyeyqH1mIDx5fiKG27h6MzFg90NkhrZnyiihuwgGWe2ToiQYA4mHhDuOXqtWQ==
X-Received: by 2002:a05:6000:22c2:b0:3ea:3b7b:80bb with SMTP id ffacd0b85a97d-40e4ce4c5f2mr1725790f8f.58.1758780965206;
        Wed, 24 Sep 2025 23:16:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb1a3sm1535900f8f.10.2025.09.24.23.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:16:04 -0700 (PDT)
Date: Thu, 25 Sep 2025 02:16:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	alex.williamson@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250925021351-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X59J9KhUuc2EyWCxiDvndJ-chwNVuduWoJ4xtw1gsFg_1758780966
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 24, 2025 at 02:02:34PM -0500, Dan Jurgens wrote:
> On 9/24/25 1:22 AM, Michael S. Tsirkin wrote:
> > On Wed, Sep 24, 2025 at 09:16:32AM +0800, Jason Wang wrote:
> >> On Tue, Sep 23, 2025 at 10:20 PM Daniel Jurgens <danielj@nvidia.com> wrote:
> >>>
> >>> Currently querying and setting capabilities is restricted to a single
> >>> capability and contained within the virtio PCI driver. However, each
> >>> device type has generic and device specific capabilities, that may be
> >>> queried and set. In subsequent patches virtio_net will query and set
> >>> flow filter capabilities.
> >>>
> >>> Move the admin related definitions to a new header file. It needs to be
> >>> abstracted away from the PCI specifics to be used by upper layer
> >>> drivers.
> >>>
> >>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >>> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> >>> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> >>> ---
> >>
> >> [...]
> >>
> >>>
> >>>  size_t virtio_max_dma_size(const struct virtio_device *vdev);
> >>>
> >>> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> >>> new file mode 100644
> >>> index 000000000000..bbf543d20be4
> >>> --- /dev/null
> >>> +++ b/include/linux/virtio_admin.h
> >>> @@ -0,0 +1,68 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0-only
> >>> + *
> >>> + * Header file for virtio admin operations
> >>> + */
> >>> +#include <uapi/linux/virtio_pci.h>
> >>> +
> >>> +#ifndef _LINUX_VIRTIO_ADMIN_H
> >>> +#define _LINUX_VIRTIO_ADMIN_H
> >>> +
> >>> +struct virtio_device;
> >>> +
> >>> +/**
> >>> + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
> >>> + * @cap_list: Pointer to capability list structure containing supported_caps array
> >>> + * @cap: Capability ID to check
> >>> + *
> >>> + * The cap_list contains a supported_caps array of little-endian 64-bit integers
> >>> + * where each bit represents a capability. Bit 0 of the first element represents
> >>> + * capability ID 0, bit 1 represents capability ID 1, and so on.
> >>> + *
> >>> + * Return: 1 if capability is supported, 0 otherwise
> >>> + */
> >>> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> >>> +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap % 64)))
> >>> +
> >>> +/**
> >>> + * struct virtio_admin_ops - Operations for virtio admin functionality
> >>> + *
> >>> + * This structure contains function pointers for performing administrative
> >>> + * operations on virtio devices. All data and caps pointers must be allocated
> >>> + * on the heap by the caller.
> >>> + */
> >>> +struct virtio_admin_ops {
> >>> +       /**
> >>> +        * @cap_id_list_query: Query the list of supported capability IDs
> >>> +        * @vdev: The virtio device to query
> >>> +        * @data: Pointer to result structure (must be heap allocated)
> >>> +        * Return: 0 on success, negative error code on failure
> >>> +        */
> >>> +       int (*cap_id_list_query)(struct virtio_device *vdev,
> >>> +                                struct virtio_admin_cmd_query_cap_id_result *data);
> >>> +       /**
> >>> +        * @cap_get: Get capability data for a specific capability ID
> >>> +        * @vdev: The virtio device
> >>> +        * @id: Capability ID to retrieve
> >>> +        * @caps: Pointer to capability data structure (must be heap allocated)
> >>> +        * @cap_size: Size of the capability data structure
> >>> +        * Return: 0 on success, negative error code on failure
> >>> +        */
> >>> +       int (*cap_get)(struct virtio_device *vdev,
> >>> +                      u16 id,
> >>> +                      void *caps,
> >>> +                      size_t cap_size);
> >>> +       /**
> >>> +        * @cap_set: Set capability data for a specific capability ID
> >>> +        * @vdev: The virtio device
> >>> +        * @id: Capability ID to set
> >>> +        * @caps: Pointer to capability data structure (must be heap allocated)
> >>> +        * @cap_size: Size of the capability data structure
> >>> +        * Return: 0 on success, negative error code on failure
> >>> +        */
> >>> +       int (*cap_set)(struct virtio_device *vdev,
> >>> +                      u16 id,
> >>> +                      const void *caps,
> >>> +                      size_t cap_size);
> >>> +};
> >>
> >> Looking at this, it's nothing admin virtqueue specific, I wonder why
> >> it is not part of virtio_config_ops.
> >>
> >> Thanks
> > 
> > cap things are admin commands. But what I do not get is why they
> > need to be callbacks.
> > 
> > The only thing about admin commands that is pci specific is finding
> > the admin vq.
> > 
> > I'd expect an API for that in config then, and the rest of code can
> > be completely transport independent.
> > 
> > 
> 
> The idea was that each transport would implement the callbacks, and we
> have indirection at the virtio_device level. Similar to the config_ops.
> So the drivers stay transport agnostic. I know these are PCI specific
> now, but thought it should be implemented generically.
> 
> These could go in config ops. But I thought it was better to isolate
> them in a new _ops structure.
> 
> An earlier implementation had the net driver accessing the admin_ops
> directly. But Parav thought this was better.

Right, but most stuff is not transport specific. If you are going to
put in the work, what is transport specific is admin VQ access.
Commands themselves are transport agnostic, we just did not need
them in non-pci previously.


-- 
MST

