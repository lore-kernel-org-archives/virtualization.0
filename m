Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5F47A0C7
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260694; cv=none; b=CUP0zzuqVJcwjm80QJ89UAYEXH+2h3LjClBS2CfzQHNYCaQSh7ziFyv619NCPfiosvJJKm0/mRjEJSM4HunErJGX+ZfcgCn7ePQn/umowBNrQ2bveGr6ySEHZCdc2RfM+uhmgorDfrseWOMNNtozPiKMJ1ypP1wL7bhmiSSniu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260694; c=relaxed/simple;
	bh=I8M6O40zF2FqQBTEIIg1qxA/Ns7PDdWoqhU12y9YI0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZH/lwkSG8c1PSoA5dls+wtLvXe2+TA8fvPvLmTQW9bNd8YVSTD7dP5LRTVTouCIbI54aXZHu53QSoZhZe/sHASz9bfFAfKbYjPYlPdfcRSFQB7wLZAomvXGqn5R/OjK3F7R3VIbVQNv6p9ULeTJwaqAkYcmUZorMqNi8Nmw8e1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiaHI6Hd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiaHI6Hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788260691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpalFsc50tyK4pf8E+Xa5el9aZ7WXkhDyVSpKjl/dAo=;
	b=KiaHI6Hd46jKPJ/CZhRI4ftsbe839NkshEbLpxFcZ/bAGEQuxf688WbU0nLKVvthPEwb2C
	FXGDPYEWg393tilDJKO7Zf6qgVrx0fnIf9HlivZnqhAIB6XDK1B1vDuEYrA67K0Odn2sZe
	YKhhDYYGBzXeONXrdVUmuxL/18ylnUk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-s-MlPppbPTa3sSOJbF0HLg-1; Tue, 01 Sept 2026 07:04:47 -0400
X-MC-Unique: s-MlPppbPTa3sSOJbF0HLg-1
X-Mimecast-MFC-AGG-ID: s-MlPppbPTa3sSOJbF0HLg_1788260686
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49ccf17d3b0so17031495e9.3
        for <virtualization@lists.linux.dev>; Tue, 01 Sep 2026 04:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788260686; x=1788865486;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpalFsc50tyK4pf8E+Xa5el9aZ7WXkhDyVSpKjl/dAo=;
        b=bqBFr9DWnziWUzzVgV5L+1MvbIpfMfIKrL66toDooFX34ZV7e1Gx77prBYI14OHj96
         oMSvM3zwcxDtjKBXAhQe7cwwl6KUIXZzuZXatX7XQPavkheztEVOQRSOb5nIs5TA2+iI
         qN7X2LnPYFuXP5izOK4DRM05UFLvHPGCq8EDc/r1JQT39TadIXQusUV+7GZhyc/HQOGS
         tTiHO/BxMFLnrBePo1fc2LEwFjpRo8aKa4uveY3TJES8jyr7z1H6gZSP+H+UHEfQNFQY
         ozZYre7kfhzccHIcVsVDxtZoI/VgdmPb2v3Ei8quxyH85pgBjN9ibOX2wof03LrLAXDs
         2oUw==
X-Forwarded-Encrypted: i=1; AHgh+RqHGwSl4v+wos3MQJNSNBN57JFWbbBJFUtrQodaCHMcXwfk+doMKd90IDVpqcGkZ6MrZutYqHh4tqcfmAGz8Q==@lists.linux.dev
X-Gm-Message-State: AFuF++ll3MszpRudtL9WxYjzxd7GxvuYgz1KfteIdntcWFAOttPUet3r
	tm43aXYbYAoVN6y7U44mr/xeJTUxot16n0UPa8WxBkX7Zl9ypXpQTPLVcXNTYPn75HLxkDMZaGG
	pkIezDjfC8CNdWAoaTjNXbWKRv3Gzc0sSzKTigy4C7y1EVh/ToUzx1pTnO0lXGN4asp3I
X-Gm-Gg: AR+sD11n/1nZItWyx7Dmrs+wLM2immhhEddRPUNjwHYD3MuVNe6EWvjflyRlRVjNbqQ
	AZmv3JDJqmb5xYQtWPVx/ZHnXF04lY3otgJ0VQ3FZ8Yb7FJUoqXKNS6Yb+5hqI5BBZlgHNw1EE7
	2l05gKVgt4SK0vOAD7r8jXq4cI/PRheC8xO07E49HnjBer2jqOAtI9Q40MX/H/Fi6LAik0fKDgp
	3xLwMI/eJ1vMPxljutpfvzieDhlhH4PSYxjfuV2BfsocUAfRfko+kCRfpZ+nvUflwzmMG1Yaf3q
	7V76zb+jPJfP2X+q7axkEppPQqCS2DE02vzIHz3qfJTwNtC66oF5fzVAkhPTaV+4BuuIBaJ8f/p
	yFUqBoE4w
X-Received: by 2002:a05:600c:c11c:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cdc422c5bmr130324545e9.2.1788260686167;
        Tue, 01 Sep 2026 04:04:46 -0700 (PDT)
X-Received: by 2002:a05:600c:c11c:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cdc422c5bmr130323085e9.2.1788260685595;
        Tue, 01 Sep 2026 04:04:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm298330355e9.0.2026.09.01.04.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:04:45 -0700 (PDT)
Date: Tue, 1 Sep 2026 07:04:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: alistair23@gmail.com
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, jasowangio@gmail.com,
	linux-scsi@vger.kernel.org, mkp@kernel.org,
	virtualization@lists.linux.dev,
	James.Bottomley@hansenpartnership.com, alistair@alistair23.me,
	Alistair Francis <alistair.francis@wdc.com>, graf@amazon.com
Subject: Re: [PATCH 2/2] scsi: Initial commit of VirtIO PCIe Endpoint Driver
Message-ID: <20260901044553-mutt-send-email-mst@kernel.org>
References: <20260901014650.2728658-1-alistair.francis@wdc.com>
 <20260901014650.2728658-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260901014650.2728658-3-alistair.francis@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TQkJWHnqqg-W6oPsT1GbzjNBBu6JU3IcYLvC5YNsHYY_1788260686
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2026 at 11:46:50AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> This patch adds a VirtIO SCSI endpoint build on top of the VirtIO PCIe
> endpoint. This is a similar approach to the NVMe PCIe Endpoint
> (drivers/nvme/target/pci-epf.c) but for SCSI.
> 
> This does end up being somewhat similar to the pci-epf.c code, but
> re-written for SCSI.
> 
> This approach allows a PCIe Endpoint device (tested on a
> radxa-rock5b) to setup what appears to be a SCSI device, using an
> existing SCSI backend (tested using scsi_debug).
> 
> At this point a host can connect over PCIe, ensure virtio_pci and
> virtio_scsi is loaded and on PCIe rescan will see a scsi device.
> 
> There are two main pain points with this approach though:
>  1. We have to use the Legacy SCSI VirtIO driver. This is because the
>     Raxda Rock5b (and AFAIK all PCIe Endpoint hardware) can't add
>     capabilities. So we can't advertise the VirtIO Common configuration
>     capability, which means we can't be a modern VirtIO SCSI device.
> 
>     This is unfortunate, but there doesn't seem to be any way around
>     this, at least with the current hardware.

This was discussed on the virtio list. The way around this is
to change virtio spec to allow common configuration
in memory. I don't think a patch like this was ever posted -
want to try?


....



> +
> +static int scsit_pci_epf_read_desc(struct scsit_pci_epf_vq *vq,
> +				   u16 idx, struct vring_desc *desc)
> +{
> +	void __iomem *p;
> +
> +	if (idx >= vq->depth)
> +		return -EINVAL;
> +
> +	p = vq->desc_map.virt_addr + (size_t)idx * sizeof(struct vring_desc);
> +	desc->addr = cpu_to_le64(readq(p + offsetof(struct vring_desc, addr)));
> +	desc->len = cpu_to_le32(readl(p + offsetof(struct vring_desc, len)));
> +	desc->flags = cpu_to_le16(readw(p + offsetof(struct vring_desc, flags)));
> +	desc->next = cpu_to_le16(readw(p + offsetof(struct vring_desc, next)));
> +
> +	return 0;
> +}
> +
> +static int scsit_pci_epf_read_indirect(struct scsit_pci_epf_ctrl *ctrl,
> +				       const struct vring_desc *parent,
> +				       struct vring_desc **out_descs,
> +				       unsigned int *out_n)
> +{
> +	struct vring_desc *descs;
> +	u32 len = le32_to_cpu(parent->len);
> +	unsigned int n;
> +	int ret;
> +
> +	if (len % sizeof(struct vring_desc) || !len)
> +		return -EINVAL;
> +
> +	n = len / sizeof(struct vring_desc);
> +	descs = kmalloc_array(n, sizeof(*descs), GFP_KERNEL);
> +	if (!descs)
> +		return -ENOMEM;
> +
> +	ret = scsit_pci_epf_transfer(ctrl, descs, le64_to_cpu(parent->addr),
> +				     len, DMA_FROM_DEVICE);
> +	if (ret) {
> +		kfree(descs);
> +		return ret;
> +	}
> +
> +	*out_descs = descs;
> +	*out_n = n;
> +	return 0;
> +}
> +
> +struct scsit_pci_epf_chain {
> +	struct vring_desc	*ro;
> +	unsigned int		nr_ro;
> +	u32			ro_len;
> +	struct vring_desc	*wo;
> +	unsigned int		nr_wo;
> +	u32			wo_len;
> +
> +	struct vring_desc	*indirect;
> +};
> +
> +static void scsit_pci_epf_chain_free(struct scsit_pci_epf_chain *c)
> +{
> +	kfree(c->ro);
> +	c->ro = NULL;
> +	kfree(c->wo);
> +	c->wo = NULL;
> +	kfree(c->indirect);
> +	c->indirect = NULL;
> +}
> +
> +static int scsit_pci_epf_walk_chain(struct scsit_pci_epf_ctrl *ctrl,
> +				    struct scsit_pci_epf_vq *vq,
> +				    u16 head_idx,
> +				    struct scsit_pci_epf_chain *out)
> +{
> +	struct vring_desc desc, *descs = NULL;
> +	unsigned int n = 0, i = 0, cap_ro = 8, cap_wo = 8;
> +	bool in_indirect = false;
> +	int ret;
> +
> +	memset(out, 0, sizeof(*out));
> +
> +	out->ro = kmalloc_array(cap_ro, sizeof(*out->ro), GFP_KERNEL);
> +	out->wo = kmalloc_array(cap_wo, sizeof(*out->wo), GFP_KERNEL);
> +	if (!out->ro || !out->wo) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = scsit_pci_epf_read_desc(vq, head_idx, &desc);
> +	if (ret)
> +		goto err;
> +
> +	/* Reject obviously-invalid head descriptors */
> +	if (!le64_to_cpu(desc.addr) && !le32_to_cpu(desc.len) &&
> +	    !le16_to_cpu(desc.flags)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	for (;;) {
> +		u16 flags = le16_to_cpu(desc.flags);
> +
> +		if (!in_indirect && (flags & VRING_DESC_F_INDIRECT)) {
> +			ret = scsit_pci_epf_read_indirect(ctrl, &desc,
> +							  &descs, &n);
> +			if (ret)
> +				goto err;
> +			out->indirect = descs;
> +			in_indirect = true;
> +			i = 0;
> +			desc = descs[0];
> +			continue;
> +		}
> +
> +		if (flags & VRING_DESC_F_WRITE) {
> +			if (out->nr_wo == cap_wo) {
> +				cap_wo *= 2;
> +				out->wo = krealloc_array(out->wo, cap_wo,
> +						sizeof(*out->wo), GFP_KERNEL);
> +				if (!out->wo) {
> +					ret = -ENOMEM;
> +					goto err;
> +				}
> +			}
> +			out->wo[out->nr_wo++] = desc;
> +			out->wo_len += le32_to_cpu(desc.len);
> +		} else {
> +			/* Read-only descriptors must precede write-only. */
> +			if (out->nr_wo) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +			if (out->nr_ro == cap_ro) {
> +				cap_ro *= 2;
> +				out->ro = krealloc_array(out->ro, cap_ro,
> +						sizeof(*out->ro), GFP_KERNEL);
> +				if (!out->ro) {
> +					ret = -ENOMEM;
> +					goto err;
> +				}
> +			}
> +			out->ro[out->nr_ro++] = desc;
> +			out->ro_len += le32_to_cpu(desc.len);
> +		}
> +
> +		if (!(flags & VRING_DESC_F_NEXT))
> +			break;
> +
> +		if (in_indirect) {
> +			i = le16_to_cpu(desc.next);
> +			if (i >= n) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +			desc = descs[i];
> +		} else {
> +			u16 next = le16_to_cpu(desc.next);
> +
> +			ret = scsit_pci_epf_read_desc(vq, next, &desc);
> +			if (ret)
> +				goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	scsit_pci_epf_chain_free(out);
> +	return ret;
> +}
> +





> +static int scsit_pci_epf_chain_to_segs(struct scsit_pci_epf_cmd *cmd,
> +				       const struct vring_desc *descs,
> +				       unsigned int n)
> +{
> +	struct scsit_pci_epf_segment *seg;
> +	unsigned int i;
> +	int ret;
> +
> +	if (n == 0)
> +		return 0;
> +
> +	if (n == 1) {
> +		cmd->nr_data_segs = 1;
> +		cmd->data_segs = &cmd->data_seg;
> +		seg = &cmd->data_segs[0];
> +		seg->pci_addr = le64_to_cpu(descs[0].addr);
> +		seg->length = le32_to_cpu(descs[0].len);
> +		return 0;
> +	}
> +
> +	ret = scsit_pci_epf_alloc_cmd_data_segs(cmd, n);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < n; i++) {
> +		seg = &cmd->data_segs[i];
> +		seg->pci_addr = le64_to_cpu(descs[i].addr);
> +		seg->length = le32_to_cpu(descs[i].len);
> +	}
> +
> +	return 0;
> +}
> +
> +static int scsit_pci_epf_alloc_cmd_data_buf(struct scsit_pci_epf_cmd *cmd)
> +{
> +	struct scsit_pci_epf_ctrl *ctrl = cmd->ctrl;
> +	struct scsit_pci_epf_segment *seg;
> +	struct scatterlist *sg;
> +	int ret, i;
> +
> +	if (cmd->se_cmd.data_length > ctrl->mdts)
> +		return -EINVAL;
> +
> +	if (cmd->nr_data_segs == 1) {
> +		sg_init_table(&cmd->data_sgl, 1);
> +		cmd->data_sgt.sgl = &cmd->data_sgl;
> +		cmd->data_sgt.nents = 1;
> +		cmd->data_sgt.orig_nents = 1;
> +	} else {
> +		ret = sg_alloc_table(&cmd->data_sgt, cmd->nr_data_segs,
> +				     GFP_KERNEL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for_each_sgtable_sg(&cmd->data_sgt, sg, i) {
> +		seg = &cmd->data_segs[i];
> +		seg->buf = kmalloc(seg->length, GFP_KERNEL);
> +		if (!seg->buf)
> +			return -ENOMEM;
> +		sg_set_buf(sg, seg->buf, seg->length);
> +	}
> +
> +	return 0;
> +}
> +
> +static void scsit_pci_epf_post_used(struct scsit_pci_epf_vq *vq,
> +				    u16 head_idx, u32 len)
> +{
> +	void __iomem *ring = vq->used_map.virt_addr +
> +			     offsetof(struct vring_used, ring) +
> +			     (size_t)(vq->next_used_idx & (vq->depth - 1)) *
> +			     sizeof(struct vring_used_elem);
> +
> +	writel(head_idx, ring + offsetof(struct vring_used_elem, id));
> +	writel(len, ring + offsetof(struct vring_used_elem, len));
> +
> +	vq->next_used_idx++;
> +	writew(vq->next_used_idx,
> +	       vq->used_map.virt_addr + offsetof(struct vring_used, idx));
> +}



So this is a reimplementation of virtio, and a weird one, for example
features are legacy but format is LE like modern. Packed ring is
not implemented.  Uses strongly ordered ops for everything.

I don't have specific advice but there is some similarity here
to what Alex Graf is doing.


And I want to see a spec decumenting how all this is supposed
to work, please, and not just an ad hoc implementation.



-- 
MST

