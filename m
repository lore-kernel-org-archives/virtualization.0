Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C24EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 15:58:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC65461166
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 15:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC65461166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E04C834E1;
	Tue, 21 Sep 2021 15:58:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQEbeBe9xSGx; Tue, 21 Sep 2021 15:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16CA282F99;
	Tue, 21 Sep 2021 15:58:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F04F5C000F;
	Tue, 21 Sep 2021 15:58:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B69FC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D44A607C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YHEpFQhKtuEo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:58:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE89A6065A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:58:44 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id d6so40486247wrc.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rNZaBRo6KuYpkYQWXBblrhd42cpP2Z/LzyFVP0pduSg=;
 b=owdSaQODCfjwam9yCa/45kwOkRitWJz6P7xw58GNzOuAi9z3vUcDQ6zYY+hKxCkGBg
 HziiVMWTPnEW3Rpn6kaulnon9zQlShOzupU71xnPlabFe6r2C7IFFIN9svHtz5+8OEve
 w99a5xLpWckDqllV6ACAFLVupF5vJI1b9Xo8cEUvMD33L05IvqXWGUEer++XtNdJb8VZ
 et0s9UzBjuv5ETPcV7VjpIqkBfDi4PSvkRfuEONCULtAA0rjLPLwJLA3f/QsMdx2zHyQ
 qxtRsdQLRxWoF3UsfCC6xTrkkJsR0y7nRjXfJr5LXGz/bON5L4+UX42F0CqRGSTgPsDU
 yukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rNZaBRo6KuYpkYQWXBblrhd42cpP2Z/LzyFVP0pduSg=;
 b=tlF/tMlp1GnxjC+ngkrrQG3ijR2Sd7/4HWV9wOPT8IcDLQifMT80/DNYOvJhQLWz9Q
 yhuUW3Ki8k8Pa8aJmMX4Z2xzmCw1ZsSKnyk8+t9IXsgfEvtJHjnHJRchv42lr3VsRu76
 QcBB8M0PqoD1iy8vW8/mb1ORfUrtbs7IVaIvB/9mQFcUdm6BX7+x5NfJb53vxOHhGTws
 HqzvRIbJ6/P6qgGupXU0+ZYGQ97XbEW2LmNRLfay6scd0tqBhtM9YCgqYwYvAPngdjOS
 NvqlaC0UYghvJYZGuGART29+OgFResJs5n4Tw7Ke1D2/Wvxp2Be5TU/jzUHRZnwaALgv
 8JYw==
X-Gm-Message-State: AOAM5327fuyVPeXnQU1sIuLo29J0MUOprzuJ7Wqe6T8UUP+XxR7RETJt
 v7Ya39dCyPNYX9YWElAMsQi9sw==
X-Google-Smtp-Source: ABdhPJzCu4pXqY9304sJsjOUOKqLOE9NZBXLU1E16vU0ec0UFC0QKS3WsIUo6q+DMz8jdf+Bi/MtVQ==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr35092715wri.391.1632239922976; 
 Tue, 21 Sep 2021 08:58:42 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id q10sm3272495wmq.12.2021.09.21.08.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 08:58:42 -0700 (PDT)
Date: Tue, 21 Sep 2021 16:58:20 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id
 and flags information
Message-ID: <YUoBHA6NZaz8wlkA@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-2-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-2-vivek.gautam@arm.com>
X-TUID: Sphz2dU6TdZ7
Cc: jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com,
 Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

Hi Vivek,

Thanks a lot for your work on this

On Fri, Apr 23, 2021 at 03:21:37PM +0530, Vivek Gautam wrote:
> Add fault information for group-id and necessary flags for page
> request faults that can be handled by page fault handler in
> virtio-iommu driver.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/uapi/linux/virtio_iommu.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index f8bf927a0689..accc3318ce46 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -307,14 +307,27 @@ struct virtio_iommu_req_invalidate {
>  #define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
>  #define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2
>  
> +#define VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID		(1 << 0)
> +#define VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE		(1 << 1)
> +#define VIRTIO_IOMMU_FAULT_PRQ_F_PRIV_DATA		(1 << 2)
> +#define VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID		(1 << 3)

I don't think this one is necessary here. The NEEDS_PASID flags added by
commit 970471914c67 ("iommu: Allow page responses without PASID") mainly
helps Linux keep track of things internally. It does tell the fault
handler whether to reply with PASID or not, but we don't need that here.
The virtio-iommu driver knows whether a PASID is required by looking at
the "PRG Response PASID Required" bit in the PCIe capability. For non-PCIe
faults (e.g. SMMU stall), I'm guessing we'll need a PROBE property to
declare that the endpoint supports recoverable faults anyway, so "PASID
required in response" can go through there as well.

> +
> +#define VIRTIO_IOMMU_FAULT_UNREC_F_PASID_VALID		(1 << 0)
> +#define VIRTIO_IOMMU_FAULT_UNREC_F_ADDR_VALID		(1 << 1)
> +#define VIRTIO_IOMMU_FAULT_UNREC_F_FETCH_ADDR_VALID	(1 << 2)
> +
>  struct virtio_iommu_fault {
>  	__u8					reason;
>  	__u8					reserved[3];
>  	__le16					flt_type;
>  	__u8					reserved2[2];
> +	/* flags is actually permission flags */

It's also used for declaring validity of fields.
VIRTIO_IOMMU_FAULT_F_ADDRESS already tells whether the address field is
valid, so all the other flags introduced by this patch can go in here.

>  	__le32					flags;
> +	/* flags for PASID and Page request handling info */
> +	__le32					pr_evt_flags;
>  	__le32					endpoint;
>  	__le32					pasid;
> +	__le32					grpid;

I'm not sure why we made it 32-bit in Linux UAPI, it's a little wasteful.
PCIe PRGI is 9-bits and SMMU STAG is 16-bits. Since the scope of the grpid
is the endpoint, 16-bit means 64k in-flight faults per endpoint, which
seems more than enough.

New fields must be appended at the end of the struct, because old drivers
will expect to find the 'endpoint' field at this offset. You could remove
'reserved3' while adding 'grpid', to keep the struct layout.

>  	__u8					reserved3[4];
>  	__le64					address;
>  	__u8					reserved4[8];


So the base structure, currently in the spec, looks like this:

	struct virtio_iommu_fault {
		u8   reason;
		u8   reserved[3];
		le32 flags;
		le32 endpoint;
		le32 reserved1;
		le64 address;
	};

	#define VIRTIO_IOMMU_FAULT_F_READ	(1 << 0)
	#define VIRTIO_IOMMU_FAULT_F_WRITE	(1 << 1)
	#define VIRTIO_IOMMU_FAULT_F_ADDRESS	(1 << 8)

The extended struct could be:

	struct virtio_iommu_fault {
		u8   reason;
		u8   reserved[3];
		le32 flags;
		le32 endpoint;
		le32 pasid;
		le64 address;
		/* Page request group ID */
		le16 group_id;
		u8   reserved1[6];
		/* For VT-d private data */
		le64 private_data[2];
	};

	#define VIRTIO_IOMMU_FAULT_F_READ	(1 << 0)
	#define VIRTIO_IOMMU_FAULT_F_WRITE	(1 << 1)
	#define VIRTIO_IOMMU_FAULT_F_EXEC	(1 << 2)
	#define VIRTIO_IOMMU_FAULT_F_PRIVILEGED	(1 << 3)
	/* Last fault in group */
	#define VIRTIO_IOMMU_FAULT_F_LAST	(1 << 4)
	/* Fault is a recoverable page request and requires a response */
	#define VIRTIO_IOMMU_FAULT_F_PAGE_REQ	(1 << 5)

	/* address field is valid */
	#define VIRTIO_IOMMU_FAULT_F_ADDRESS	(1 << 8)
	/* pasid field is valid */
	#define VIRTIO_IOMMU_FAULT_F_PASID	(1 << 9)
	/* group_id field is valid */
	#define VIRTIO_IOMMU_FAULT_F_GROUP_ID	(1 << 10)
	/* private data field is valid */
	#define VIRTIO_IOMMU_FAULT_F_PRIV_DATA	(1 << 11)

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
