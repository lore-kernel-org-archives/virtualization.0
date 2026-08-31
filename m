Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27692450410
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194259; cv=none; b=bRdaetCc3p+Wuba4igj3Aekqt+sd2+EVcyhZDZV+CjqResdX9EoojofadqW2hc83/TjM/elRhok6mbKgdTVBUMAwQWF+97Elewl+jZr/WHuYQ46Q2hPfq8frPaVKiqoR1SVFC0KCFUSiWeLKzvso1OHoIA+B5BS0rDFmOOLxt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194259; c=relaxed/simple;
	bh=w2R6KTQFjtv7zRGBf40WcF2lHvIbeldwGOxVJEF1T3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Woc5Jcnu+clshFkLU5k43ZQsv2eJWh63Q2Crf8U5AUriIi2/+TCagbM2QEbUc51/+nfWlq6q9wlpTebyz/pGar+FMiWPcfNybklx7BpxWeqrWmL4KlJEk4x0Y7AZAQgFKJP3ZAaIx8Y4yMaSqE1OxZBY5OGizjTZAjot1RqPS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaNsFRG2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaNsFRG2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788194256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaRD6eFYA+1FbBZLf/ZGcYMlKZSbShp5mZntG2wtj3s=;
	b=ZaNsFRG2ucQuPy4CAxKKtotVUiNcdlutkKsn9FGDXtxXLNHf65gih1T9OBLaTNRHKKrx0s
	MfoSy42w0L7MKRyO6YiwyUajDhTLIsjWUuoDASRxeAcs0fTSv1tk2U1npAOn2lTRfl/F8m
	Zm6igH+WZs/uQCCILcRSf38rwdBNnTE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-oulDQxKnMoea4_Zjhrsw_A-1; Mon, 31 Aug 2026 12:37:34 -0400
X-MC-Unique: oulDQxKnMoea4_Zjhrsw_A-1
X-Mimecast-MFC-AGG-ID: oulDQxKnMoea4_Zjhrsw_A_1788194253
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b64e98e94so280325e9.1
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 09:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194253; x=1788799053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaRD6eFYA+1FbBZLf/ZGcYMlKZSbShp5mZntG2wtj3s=;
        b=mJj05UUiTtiJntJXOi+OSY1t9pJdO4ldg9IVygdXTWe2KFdGT7hw0d1HaKC3cqgsd0
         5j00gtB8B2qKkg+1SQQCchidjbw895+wGiCHo4VqpKROCyqnZQ8ZWi4HlE6JsBnmkUq2
         y1yzqx4UrO4qZ90Y89QnoxQfnVaOFM1EMjUfqi1vOFDNhGziaIYfSNlaWgnD2MFEmI6f
         8Q9355voOujrM97/Hwtcl/0A9c/YkjEXRZBp1nNzC4xt6je8F+6AGiitoR+n4klh8aNe
         8tHR8p2PtJLyF4DyQFXFDsKh3gJyGiikXqgrPiei5lCGFgv0y4WXfjtlPnlF2UsZSCZY
         RMWA==
X-Forwarded-Encrypted: i=1; AHgh+RrtWAYCfVymX3ErZgW54qvXOQ3yrIpRC0idMOTrrxIceBGHDFnDD2prDkhjD9fIrRKLHCwvQo7u6rtSSPhJLw==@lists.linux.dev
X-Gm-Message-State: AFuF++mDDs1vXXv5pDXilPVIjEASV5aX3Gp8odLgnSXQhiVg4N7t08Jc
	1l672YSncVqB32NNfd87dnoAXjsyfBXE85pN+UIHM3zNYTlI+SueT0TEUjp0BDsLe3s3JvBzmw6
	Z46QkpjMniPs625c+C7xuUvGh0mYPtyc7l50jwy2CpOeMpuI8aahKJ6bWW5QzjU480Ffe
X-Gm-Gg: AR+sD12m6XCufkt3vi/3jSKFJEfkPF1Sr+2ySvqCNo4r2PiVduGFLH6RXvjUZ3udlno
	bPlEeiUpvgDJxISFZUeqGWV/vTrIC89DRwbaTrBOiT37s+wjwH5p0l/2wFswEIN0GNjNd31Ds2s
	oacfYskU8USVgOpgOcnAvtKDO0FqCy2hpwUFMKn18WSWYF9inp5vPUILYoT6Pd7tl9m4mRvzDCY
	uUcFhy38CCq8CMwldcOxVtHt59s1iHhpcf8wEQADMNi4E3bcR7D/govmIf/KxVPqnQ0+ohHuPTD
	khBX1CjZThtdsXtt8T6m0m2IsKOdmfY9eSLMv8quk1uRS3+PsltuWTvw5EDVDj0cDzmjkYst64l
	2lIi2KoIr728VbmtBESeBFnY=
X-Received: by 2002:a05:600c:699a:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49cd5312c62mr186503465e9.2.1788194253059;
        Mon, 31 Aug 2026 09:37:33 -0700 (PDT)
X-Received: by 2002:a05:600c:699a:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49cd5312c62mr186501955e9.2.1788194252366;
        Mon, 31 Aug 2026 09:37:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b955e7906sm247630585e9.1.2026.08.31.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:37:31 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:37:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v23 00/14] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260831123721-mutt-send-email-mst@kernel.org>
References: <20260831161109.2999926-1-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260831161109.2999926-1-shshitrit@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EvlX9ulejy9MMctBIJxDEGjixj-lxAG55U26lHUwADk_1788194253
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2026 at 07:10:55PM +0300, Shahar Shitrit wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.
> 
> The series starts with infrastructure changes to expose virtio PCI admin
> capabilities and object management APIs. It then creates the virtio_net
> directory structure and implements the flow filter functionality with
> support for:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> - Layer 2 (Ethernet) flow rules
> - IPv4 and IPv6 flow rules
> - TCP and UDP flow rules (both IPv4 and IPv6)
> - Rule querying and management operations
> 
> Setting, deleting and viewing flow filters, -1 action is drop, positive
> integers steer to that RQ:
> 
> $ ethtool -u ens9
> 4 RX rings available
> Total 0 rules
> 
> $ ethtool -U ens9 flow-type ether src 1c:34:da:4a:33:dd action 0
> Added rule with ID 0
> $ ethtool -U ens9 flow-type udp4 dst-port 5001 action 3
> Added rule with ID 1
> $ ethtool -U ens9 flow-type tcp6 src-ip fc00::2 dst-port 5001 action 2
> Added rule with ID 2
> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action 1
> Added rule with ID 3
> $ ethtool -U ens9 flow-type ip6 dst-ip fc00::1 action -1
> Added rule with ID 4
> $ ethtool -U ens9 flow-type ip6 src-ip fc00::2 action -1
> Added rule with ID 5
> $ ethtool -U ens9 delete 4
> $ ethtool -u ens9
> 4 RX rings available
> Total 5 rules
> 
> Filter: 0
>         Flow Type: Raw Ethernet
>         Src MAC addr: 1C:34:DA:4A:33:DD mask: 00:00:00:00:00:00
>         Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Ethertype: 0x0 mask: 0xFFFF
>         Action: Direct to queue 0
> 
> Filter: 1
>         Rule Type: UDP over IPv4
>         Src IP addr: 0.0.0.0 mask: 255.255.255.255
>         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
>         TOS: 0x0 mask: 0xff
>         Src port: 0 mask: 0xffff
>         Dest port: 5001 mask: 0x0
>         Action: Direct to queue 3
> 
> Filter: 2
>         Rule Type: TCP over IPv6
>         Src IP addr: fc00::2 mask: ::
>         Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>         Traffic Class: 0x0 mask: 0xff
>         Src port: 0 mask: 0xffff
>         Dest port: 5001 mask: 0x0
>         Action: Direct to queue 2
> 
> Filter: 3
>         Rule Type: Raw IPv4
>         Src IP addr: 192.168.51.101 mask: 0.0.0.0
>         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
>         TOS: 0x0 mask: 0xff
>         Protocol: 0 mask: 0xff
>         L4 bytes: 0x0 mask: 0xffffffff
>         Action: Direct to queue 1
> 
> Filter: 5
>         Rule Type: Raw IPv6
>         Src IP addr: fc00::2 mask: ::
>         Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>         Traffic Class: 0x0 mask: 0xff
>         Protocol: 0 mask: 0xff
>         L4 bytes: 0x0 mask: 0xffffffff
>         Action: Drop
> 
> ---
> v2: https://lore.kernel.org/netdev/20250908164046.25051-1-danielj@nvidia.com/
>   - Fix sparse warnings
>   - Fix memory leak on subsequent failure to allocate
>   - Fix some Typos
> 
> v3: https://lore.kernel.org/netdev/20250923141920.283862-1-danielj@nvidia.com/
>   - Added admin_ops to virtio_device kdoc.
> 
> v4:
>   - Fixed double free bug inserting flows
>   - Fixed incorrect protocol field check parsing ip4 headers.
>   - (u8 *) changed to (void *)
>   - Added kdoc comments to UAPI changes.
>   - No longer split up virtio_net.c
>   - Added config op to execute admin commands.
>       - virtio_pci assigns vp_modern_admin_cmd_exec to this callback.
>   - Moved admin command API to new core file virtio_admin_commands.c
> 
> v5:
>   - Fixed compile error
>   - Fixed static analysis warning on () after macro
>   - Added missing fields to kdoc comments
>   - Aligned parameter name between prototype and kdoc
> 
> v6:
>   - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>   - Use new variable and validate ff_mask_size before set_cap. MST
> 
> v7:
>   - Change virtnet_ff_init to return a value. Allow -EOPNOTSUPP. Xuan
>   - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abini
>   - Move for (int i removal hung back a patch. Paolo Abini
> 
> v8
>   - Removed unused num_classifiers. Jason Wang
>   - Use real_ff_mask_size when setting the selector caps. Jason Wang
> 
> v9:
>   - Set err to -ENOMEM after alloc failures in virtnet_ff_init. Simon H
> 
> v10:
>   - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
>     Jason Wang/Paolo Abeni
> 
> v11:
>   - Return -EINVAL if any resource limit is 0. Simon Horman
>   - Ensure we don't overrun alloced space of ff->ff_mask by moving the
>     real_ff_mask_size > ff_mask_size check into the loop. Simon Horman
> 
> v12: Many comments by MST, thanks Michael. Only the most significant
>      listed here:
>   - Fixed leak of key in build_and_insert.
>   - Fixed setting ethhdr proto for IPv6.
>   - Added 2 byte pad to struct virtio_net_ff_cap_data.
>   - Use and set rule_cnt when querying all flows.
>   - Cleanup and reinit in freeze/restore path.
> 
> v13:
>   - Add private comment for reserved field in kdoc. Jakub
>   - Serveral comments from MST details in patches. Most significant:
> 	- Fixed bug in ip4, check l3_mask vs mask when setting addrs.
> 	- Changed ff_mask cap checking to not break on expanded
> 	  selector types
> 	- Changed virtio_admin_obj_destroy to return void.
> 	- Check tos field for ip4.
> 	- Don't accept tclass field for ip6.
> 	- If ip6 only flow check that l4_proto isn't set.
> 
> v14:
>   - Handle virtio_ff_init errors in freeze/restore. MST
>   - Don't set proto in parse_ip4/6. The casted struct may not have that
>     field, and the proto field was set explicitly anyway. Simon H/AI.
> 
> v15:
>   - In virtnet_restore_up only call virtnet_close in err path if
>     netif_running. AI
> 
> v16:
>   - Return 0 from virtnet_restore_up if virtnet_init_ff return not
>     supported. AI
>   - Rebased over removing series to remove delayed refill.
> 
> v17:
>   - Properly handle unaligned reads/writes. MST
>   - Fix use after free if init fails during virtnet_restor. AI
>   - Fix memory leak when validating the classifer vs caps fails. AI
>   - Added missing includes. MSTA
> 
> v18:
>   - Validate selector cap lengths, instead of just checking they don't
>     exceed a max. AI
>   - Add __count_by attribute to flexible arrays in UAPI definitions.
>     Paolo A.
> 
> v19:
>   - Style fixes. AI
> 
> v20:
>   - Added missing include
> 
> v21:
>   - Use le64_to_cpu() and BIT_ULL() instead of cpu_to_le64() for cap checking.
>   - Don't use __counted_by on flexible array of flexible structs.
>   - Replace UAPI header includes with kernel header includes.
>   - Add missing includes for linux/types.h and linux/byteorder/generic.h.
>   - Clamp the reported action count to the driver-supported maximum.
>   - Clamp the reported selector count to the driver-supported maximum.
>   - Validate sel->type is not 0.
>   - Reduce selectors' count in case selector's type is invalid.
>   - Move virtio_device_ready() before virtnet_ff_init() as the flow filter
>     initialization requires the device to be in ready state to issue admin
>     commands.
>   - Remove forward declarations.
>   - Validate action is supported before inserting rule.
>   - Convert ring_cookie to vq before assigning ff_rule->vq_index.
>   - reword a comment.
>   - Introduce a new patch that moves flow_type_mask() to include/linux/ethtool.h.
>   - Wrap __le32 limit fields in le32_to_cpu() to avoid sparse warnings.
>   - Use put_unaligned() in parse_ip4() to avoid misaligned 32-bit stores on
>     strict-alignment architectures.
> 
> v22:
>   - Reword/fix typo in commit messages.
>   - Remove include <uapi/linux/virtio_pci.h> from virtio_net.c.
>   - Verify also selectors_per_classifier_limit in virtnet_ff_init().
>   - Validate ff->ff_actions->count != 0.
>   - Remove WARN_ON_ONCE() and replace -EINVAL with -EPROTO for errors on
>     device side.
>   - Use ff->ff_mask->count after it was initialized.
>   - Add a patch to fix sleeping under spinlock in the admin command path.
>   - Document that callers must zero-initialize the capability structure.
>   - Convert macro VIRTIO_CAP_IN_LIST to be inline function.
>   - Add WARN_ON_ONCE if allocation fails in virtio_admin_obj_destroy().
>   - Change VIRTNET_FF_ETHTOOL_GROUP_PRIORITY to be 0.
>   - Reject flow rules that require more selectors than the device supports
>     (selectors_per_classifier_limit).
>   - Report min(rules_limit, rules_per_group_limit) as the effective rule limit,
>     since all rules reside in a single group.
> 
> v23:
>   - Make virtio_admin_obj_destroy() return int instead of void + internal
>     WARN_ON_ONCE, so callers can propagate the failure themselves.
> 
> Comments from internal Sashiko review:
> > +int virtio_admin_obj_create(struct virtio_device *vdev,
> > +			    u16 obj_type,
> > +			    u32 obj_id,
> > +			    u16 group_type,
> > +			    u64 group_member_id,
> > +			    const void *obj_specific_data,
> > +			    size_t obj_specific_data_size)
> > +{
> [ ... ]
> > +	obj_create_data->hdr.type = cpu_to_le16(obj_type);
> > +	obj_create_data->hdr.id = cpu_to_le32(obj_id);
> > +	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
> > +	       obj_specific_data_size);
> Can this memcpy trigger undefined behavior if callers pass NULL for
> obj_specific_data and 0 for obj_specific_data_size? In C, passing a NULL
> pointer to memcpy is undefined behavior even if the size is 0, which could
> cause UBSAN splats.
> 
> [SS] It's the caller responsibly not to pass NULL. Current callers don't pass NULL.
> 
> > +	sg_init_one(&data_sg, data, data_size);
> > +
> > +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
> > +	cmd.group_type = cpu_to_le16(group_type);
> > +	cmd.group_member_id = cpu_to_le64(group_member_id);
> > +	cmd.data_sg = &data_sg;
> > +
> > +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> This isn't a bug introduced by this patch, but does this execution path sleep
> while holding a spinlock with interrupts disabled?
> If this calls into virtqueue_exec_admin_cmd() (for example via
> vp_modern_admin_cmd_exec()), the call chain looks like:
> virtqueue_exec_admin_cmd()
>     spin_lock_irqsave(&admin_vq->lock, flags);
>     virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> Since GFP_KERNEL allows direct reclaim and sleeping, can this cause a deadlock
> or trigger a BUG if the virtqueue falls back to allocating indirect descriptors?
> 
> [SS] Right, but not related to this series. Can introduce a fix in a different patch.
> 
> > +void virtio_admin_obj_destroy(struct virtio_device *vdev,
> > +			      u16 obj_type,
> > +			      u32 obj_id,
> > +			      u16 group_type,
> > +			      u64 group_member_id)
> > +{
> > +	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> > +	struct virtio_admin_cmd cmd = {};
> > +	struct scatterlist data_sg;
> > +	int err;
> > +
> > +	if (!vdev->config->admin_cmd_exec)
> > +		return;
> > +
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return;
> If this kzalloc() fails, does this function return without sending the
> destroy command to the hardware?
> Since the return type is void, the caller has no way to detect this failure
> and will likely free its local software tracking objects. Will this leave
> the physical device and software tracking structures permanently
> desynchronized, leaking the object on the virtio device?
> 
> [SS] Not much to do here. There could be a firmware error also,
>      and then what we do? Destroy flow is best effort.
> 
> > +			break;
> > +
> > +		if (sel->length != get_mask_size(sel->type) ||
> > +		    test_and_set_bit(sel->type, &sel_types)) {
> > +			WARN_ON_ONCE(true);
> Is it safe to use WARN_ON_ONCE() for validating device input? A malicious
> or buggy virtio device could intentionally trigger this by providing an
> invalid length or duplicate selector types, potentially leading to a kernel
> panic if panic_on_warn is enabled. Would it be better to just return the
> error without the warning?
> > +			err = -EINVAL;
> > +			goto err_ff_action;
> > +		}
> > +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> > +		if (real_ff_mask_size > ff_mask_size) {
> > +			WARN_ON_ONCE(true);
> Similarly, could this WARN_ON_ONCE() be triggered by a malicious device
> providing a larger size than expected, leading to a panic if panic_on_warn
> is enabled?
> 
> [SS] These WARN_ON_ONCE() were requested by MST during review.
> 
> [ ... ]
> > +static const struct ethtool_ops virtnet_ethtool_ops = {
> [ ... ]
> > +	.get_rxfh_fields = virtnet_get_hashflow,
> > +	.set_rxfh_fields = virtnet_set_hashflow,
> > +	.get_rx_ring_count = virtnet_get_rx_ring_count,
> > +	.set_rxnfc = virtnet_set_rxnfc,
> > +};
> Does this also need an implementation of .get_rxnfc to prevent invalid
> channel configurations?
> When .get_rxnfc is missing, the ethtool core function
> ethtool_get_max_rxnfc_channel() returns -EOPNOTSUPP. This causes
> ethtool_check_max_channel() to silently skip validating the new channel
> count against active flow rules.
> If a user adds a flow rule targeting a specific RX queue, and then reduces
> the active RX queues via ethtool -L, virtnet_set_channels() will update
> the queue count without checking the active rules stored in
> vi->ff.ethtool.rules.
> Could this leave hardware rules pointing to disabled queues and cause
> silent packet drops?
> 
> [SS] .get_rxnfc exists (introduced in a later patch).
> 
> > @@ -1258,6 +1259,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
> >  	.get_shm_region  = vp_get_shm_region,
> >  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
> >  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> > +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
> >  };
> This isn't a bug introduced by this patch, but by exposing this function to
> general drivers, can a driver trigger a NULL pointer dereference or
> use-after-free?
> If a driver calls the newly exposed config->admin_cmd_exec() early in probe
> before find_vqs(), or late in remove after del_vqs(),
> virtqueue_exec_admin_cmd() unconditionally dereferences admin_vq->info:
>     vq = admin_vq->info->vq;
> In vp_del_vqs(), the info structure is freed via kfree(info), but
> vp_dev->admin_vq.info is never set to NULL, leaving a dangling pointer.
> 
> [SS] Current code is written in correct order. Future callers are responsible
>      to call this when VQs are initialized.
> 
> This isn't a bug introduced by this patch, but does this error path lead to
> stack corruption?
> In virtqueue_exec_admin_cmd(), if virtqueue_kick() fails, it returns -EIO
> without waiting for completion or detaching the exposed buffer:
>     if (!virtqueue_kick(vq))
>             goto unlock_err;
> If the hardware later processes the descriptor and triggers
> vp_modern_avq_done(), it will call complete(&cmd->completion). Since the cmd
> structure was likely allocated on the caller's stack, this can overwrite
> out-of-scope stack memory.
> 
> [SS] The vq->broken flag set by virtqueue_notify() causes virtqueue_get_buf()
>      to return NULL in vp_modern_avq_done(), so complete() is never called on
>      the freed cmd. No stack corruption.
> 
> This isn't a bug introduced by this patch, but can this function return an
> uninitialized variable?
> virtqueue_exec_admin_cmd() returns cmd->ret at the end of the function:
>     return cmd->ret;
> However, on a successful command execution, vp_modern_avq_done() never
> explicitly sets cmd->ret to 0. If a driver allocates struct virtio_admin_cmd
> on the stack without zero-initializing it, could this return stack garbage
> and erroneously indicate failure?
> 
> [SS] cmd is initialized in all callers struct with virtio_admin_cmd cmd = {};
> 
> If the device responds with fewer bytes than the driver's provided data
> buffer, does this leave the rest of the output buffer uninitialized?
> The wrapper discards cmd.result_sg_size without zero-initializing data and
> returns 0, which could expose uninitialized memory to callers.
> 
> [SS] Caller's responsibility to initialize the buffer.
> 
> Second, if virtqueue_add_sgs() returns -ENOSPC, the code loops infinitely
> with cpu_relax() without a timeout or sleep:
> drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
> ...
> 		if (ret == -ENOSPC) {
> 			spin_unlock_irqrestore(&admin_vq->lock, flags);
> 			cpu_relax();
> 			goto again;
> 		}
> ...
> }
> Can this soft-lockup the CPU if the virtqueue remains full and the device is
> unresponsive?
> 
> [SS] Pre-existing, not introduced by this series, and bounded in practice by
>      the virtqueue_is_broken() check. Not something to fix here.
> 
> Third, if virtqueue_kick() fails, the code jumps to unlock_err without
> detaching the buffer from the virtqueue:
> drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
> ...
> 	if (!virtqueue_kick(vq))
> 		goto unlock_err;
> 	spin_unlock_irqrestore(&admin_vq->lock, flags);
> 	wait_for_completion(&cmd->completion);
> 	return cmd->ret;
> unlock_err:
> 	spin_unlock_irqrestore(&admin_vq->lock, flags);
> 	return -EIO;
> ...
> }
> Does this leave a dangling pointer on the virtqueue?
> If the device later processes the command or the virtqueue is torn down,
> could it write to the freed heap memory and invoke complete() on a dangling
> stack pointer?
> 
> [SS] Not a bug. vq->broken prevents complete() from firing.
> 
> > +	sg_init_one(&data_sg, data, sizeof(*data));
> > +	sg_init_one(&result_sg, caps, cap_size);
> > +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
> > +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> > +	cmd.data_sg = &data_sg;
> > +	cmd.result_sg = &result_sg;
> > +
> > +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> Similar to virtio_admin_cap_id_list_query above, does this execution discard
> cmd.result_sg_size without zeroing the caps buffer, potentially returning
> uninitialized memory to the caller on a short response?
> 
> [SS] Standard kernel API contract, caller owns the buffer, current callers
>      handle it correctly.
> 
> > +	data->id = cpu_to_le16(id);
> > +	memcpy(data->cap_specific_data, caps, cap_size);
> If a caller invokes virtio_admin_cap_set() to enable a capability with no
> extra data (cap_size == 0 and caps == NULL), will this unconditionally pass a
> NULL pointer to memcpy(), invoking undefined behavior?
> 
> [SS] Caller's responsibility.
> 
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
> > +	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
> Could this macro trigger an out-of-bounds read on the supported_caps array if
> a caller passes a cap value greater than VIRTIO_ADMIN_MAX_CAP?
> Additionally, could evaluating cap multiple times cause unexpected side effects
> if passed an expression like cap++?
> 
> [SS] All callers use named cap constants defined in the uapi headers, which are all
>      within bounds by construction. Passing side-effecting expressions to macros is
>      standard caller responsibility. No fix needed.
> 
> >  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
> >  {
> > +	struct virtnet_ethtool_rule *eth_rule;
> > +	unsigned long i;
> > +
> >  	if (!ff->ff_supported)
> >  		return;
> >
> > +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
> > +		destroy_ethtool_rule(ff, eth_rule);
> > +
> Will this cause user-configured flow filter rules to be permanently lost
> across system suspend/resume or device migration?
> During suspend, device reset, or device freeze, virtnet_freeze_down() calls
> virtnet_ff_cleanup(). This loop iterates over all configured flow rules,
> sends the destroy commands to the hardware, and then calls kfree() via
> destroy_ethtool_rule(), permanently destroying the software representation of
> the rules.
> Upon resume, virtnet_restore_up() invokes virtnet_ff_init(), which
> initializes the flow filters as completely empty. The driver appears to make
> no attempt to retain the software state of the rules during suspend or
> replay them to the device during restore, meaning users must manually
> recreate all flow filter rules every time the system resumes or the device
> is migrated.
> 
> [SS] This is intentional for now. Could be a follow up feature.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> -- 
> 2.49.0

