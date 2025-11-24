Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98621231836
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023284; cv=none; b=QmBTnT0vq4WB2f1AEvMmcVlmzm0e8ocbjmeVSg4KZ5RWlJ7ryr4HDjbLjIgfqYs4xad9H1iQnNShQqM7DLwU5DryRC51sZeOXkS80YF9RyXqsOL9LzT1r9yBhCrgEY6biVSJQP2btDb3xH36ZQXXljWqt9xE/byKYjl/wVCN+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023284; c=relaxed/simple;
	bh=O9s1c+Soea+oLRUDpv8yyvhGXWT6wRd+L4jrFY5ezLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iGd9eFVSPykEhn5bf/LN/8pHsc0K/oO5dotyhi00pfinkYOQtmiMeErIvkeng6ZtKcDl2yptkfp3s/W50ihBD5PUOCvZSzvB0bag1nUp3E88KEsUZvS4m4Tvd0asC6b4DJqS8LNCAwl7GSujCElq2v70igQ7K3qPTd79iB/6qT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jh7rApwF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jh7rApwF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764023281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXYvmDv4kppfCO9Fqm1r8b7arvwMaa5NeNnEMmc451k=;
	b=Jh7rApwFCX/R/TF2MxnNLbGuuAV0OdH1KN1JGVT/6Si2+Tt4Lvmg74M0skYgHA6/FCh5zg
	rLb6w0XBAQJVXr5cj0suzRMowJPA6FEgBOQiL3fUMGGN91hsrLAqB5O+yMRCpd2Vt8/e4b
	P11m/huhW/Lxxs4cl6OgCzXoxMLML44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-3Z0Ra3Y-MT2gqChob9CiUQ-1; Mon, 24 Nov 2025 17:27:59 -0500
X-MC-Unique: 3Z0Ra3Y-MT2gqChob9CiUQ-1
X-Mimecast-MFC-AGG-ID: 3Z0Ra3Y-MT2gqChob9CiUQ_1764023278
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so41675175e9.1
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 14:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764023278; x=1764628078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXYvmDv4kppfCO9Fqm1r8b7arvwMaa5NeNnEMmc451k=;
        b=KpchNhEI6Fp+X3vATXB82tbYBwWCypaI+gLUBIwdSctqHx1uPZ5ALJVl2cXPM0t11D
         1MstN5qrAG/zF3KFRB3wgLUSIqeefKEYnFJk1ccAsW5yuG3sK+3PzIrbTssD6tmNlqsq
         ajotppAd4rHqUgdTDGafTgq1rUit/OkY6okeUppvpS84fj+UQSooI0Pm04i7zZZPOhxK
         t0QzsHtBSocIzwHNDRt+c+3vTSPC1k5eGzCSAzSLkIjEUWjzsoeckkPVraXAjlW4+rGH
         LbufNy4hwdWty1fPJy8jvrUgQZiCAHaPOgNBdJWz8wP55Dq15RUS+NsN6ZHPIBpKBiVl
         UsSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlvK+F2/uFQi5oouw9/NsnWOOiZWsAIWPgA/Tw6WttmXPazaWnZ4Qaddihv03F0crM/gQkTsPkIwzNoSHJPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdV0xxWYWjMNQqR0rDRifIZ4GQXMmptlqHm4YL1eyARoM9wl4f
	fgqWXG1Cxu+tGjArFI7RJX7qulYz+WlsjSLVdrU3syFFqj0r89jLr1CCKBbXPKwhyw4tnjfyemF
	Eql9bhImWhLeSQtQZi7lrVirfNXYA0v5p5XxXTiIyUwf6ppFicV/UyCGwA7xU/teg0Xnecpyxb3
	nf
X-Gm-Gg: ASbGncsCACfRrgjMy0hJ5Ca5MOFe5dcZbVdB1AqvYqT6dl10d+29cOj6kpcBBmw3KIg
	oH39rXHRHkNdFSemLQ79G1wd4kBXTpDDApe48Vm2wmEmF+BSRWgt+SYidCsHUsWS7hfdj3fAR5V
	a6ILGDECAaQiPOm8TlHsU0lKHnYuCoKcsvMVH60HP92kV9W9sJGNG8Xr9Fl8tM6wynLMlhj5lAs
	m7Hjqpr63PFJiik/YL/BH5vmLk6qTlHkp3agE98wWW3g6t+r20WBSGuGaqXn7rBb101NV5DssB+
	r3H7ravob3BshvW+m/rcmj0pC2IymWvEwQeXKwuhASK/JXJwOrObsvRGnaCGNBSydNEUiTTXsPS
	z42M1crwHue2RKioI/aOVUCGVng/5SQ==
X-Received: by 2002:a05:600c:4ed2:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-477c0162dd6mr120031885e9.5.1764023277678;
        Mon, 24 Nov 2025 14:27:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpTgqYDwaYD+BIeuP2f0AMJc9Y14bFXs/8liPK6xpoY32LV1hSFbbSC8y4H3DaRF62vzWtrw==
X-Received: by 2002:a05:600c:4ed2:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-477c0162dd6mr120031735e9.5.1764023277302;
        Mon, 24 Nov 2025 14:27:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm217203125e9.1.2025.11.24.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:27:56 -0800 (PST)
Date: Mon, 24 Nov 2025 17:27:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 03/12] virtio: Expose generic device
 capability operations
Message-ID: <20251124172646-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-4-danielj@nvidia.com>
 <20251124152548-mutt-send-email-mst@kernel.org>
 <29fa4996-38e3-4146-81d3-f8b188e047e9@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <29fa4996-38e3-4146-81d3-f8b188e047e9@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hUBp15OzT6iGhDgjSoHXG0k4lUzKMG3e4fIUc3qe0I0_1764023278
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2025 at 04:24:37PM -0600, Dan Jurgens wrote:
> On 11/24/25 2:30 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:15:14PM -0600, Daniel Jurgens wrote:
> >> Currently querying and setting capabilities is restricted to a single
> >> capability and contained within the virtio PCI driver. However, each
> >> device type has generic and device specific capabilities, that may be
> >> queried and set. In subsequent patches virtio_net will query and set
> >> flow filter capabilities.
> >>
> >> This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
> >> to do because this data is written by DMA, so a newer controller can't
> >> overrun the size on an older kernel.
> >>
> >> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>
> >> ---
> >> v4: Moved this logic from virtio_pci_modern to new file
> >>     virtio_admin_commands.
> >>
> >> v12:
> >>   - Removed uapi virtio_pci include in virtio_admin.h. MST
> >>   - Added virtio_pci uapi include to virtio_admin_commands.c
> >>   - Put () around cap in macro. MST
> >>   - Removed nonsense comment above VIRTIO_ADMIN_MAX_CAP. MST
> >>   - +1 VIRTIO_ADMIN_MAX_CAP when calculating array size. MST
> >>   - Updated commit message
> >> ---
> >>  drivers/virtio/Makefile                |  2 +-
> >>  drivers/virtio/virtio_admin_commands.c | 91 ++++++++++++++++++++++++++
> >>  include/linux/virtio_admin.h           | 80 ++++++++++++++++++++++
> >>  include/uapi/linux/virtio_pci.h        |  6 +-
> >>  4 files changed, 176 insertions(+), 3 deletions(-)
> >>  create mode 100644 drivers/virtio/virtio_admin_commands.c
> >>  create mode 100644 include/linux/virtio_admin.h
> >>
> >> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> >> index eefcfe90d6b8..2b4a204dde33 100644
> >> --- a/drivers/virtio/Makefile
> >> +++ b/drivers/virtio/Makefile
> >> @@ -1,5 +1,5 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >> -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> >> +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
> >>  obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
> >>  obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> >>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> >> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> >> new file mode 100644
> >> index 000000000000..a2254e71e8dc
> >> --- /dev/null
> >> +++ b/drivers/virtio/virtio_admin_commands.c
> >> @@ -0,0 +1,91 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +
> >> +#include <linux/virtio.h>
> >> +#include <linux/virtio_config.h>
> >> +#include <linux/virtio_admin.h>
> >> +#include <uapi/linux/virtio_pci.h>
> >> +
> >> +int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
> >> +				   struct virtio_admin_cmd_query_cap_id_result *data)
> >> +{
> >> +	struct virtio_admin_cmd cmd = {};
> >> +	struct scatterlist result_sg;
> >> +
> >> +	if (!vdev->config->admin_cmd_exec)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	sg_init_one(&result_sg, data, sizeof(*data));
> >> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
> >> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> >> +	cmd.result_sg = &result_sg;
> >> +
> >> +	return vdev->config->admin_cmd_exec(vdev, &cmd);
> >> +}
> >> +EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
> >> +
> >> +int virtio_admin_cap_get(struct virtio_device *vdev,
> >> +			 u16 id,
> >> +			 void *caps,
> >> +			 size_t cap_size)
> > 
> > 
> > I still don't get why cap_size needs to be as large as size_t.
> > 
> > if you don't care what's it size is, just say "unsigned".
> > or u8 as a hint to users it's a small value.
> 
> The size is small for net flow filters, but this is supposed to be a
> generic interface for future uses as well. Why limit it?

because your implementation
makes assumptions - if you want it to be truly generic then you need to handle
weird corner cases such as integer overflow when you add these things.


> 
> > 
> >> +{
> >> +	struct virtio_admin_cmd_cap_get_data *data;
> >> +	struct virtio_admin_cmd cmd = {};
> >> +	struct scatterlist result_sg;
> >> +	struct scatterlist data_sg;
> >> +	int err;
> >> +
> >> +	if (!vdev->config->admin_cmd_exec)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > 
> > uses kzalloc without including linux/slab.h
> > 
> > 
> > 
> >> +	if (!data)
> >> +		return -ENOMEM;
> >> +

