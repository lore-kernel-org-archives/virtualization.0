Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9960C433EF
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 17:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 442BD41DFD;
	Thu,  2 Dec 2021 17:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UhDfc0UYRLoN; Thu,  2 Dec 2021 17:46:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03A9041DF0;
	Thu,  2 Dec 2021 17:46:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9426C001C;
	Thu,  2 Dec 2021 17:46:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11A8BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06B686065C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JelvA-wMWUrX
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:46:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAC5760641
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638467167;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKmzT1/YmP73qs650iyNoUcPQkfF4oMfX1WHEk8C8P8=;
 b=TAhxwDYRRG84aYvU5+SYq6SE8E522of5INxKzKZsx7VqzGKQn29xH+awSPrUcvaUxp/Hg5
 O9er0tCrRocR1f0hLL8uIazOCVUOP0+5CL4AGDMKLDyUNptQy1BCRkxicVmUSjKdCLEeVm
 IeOjDKgkZhQRuEf6mDGNTh6Ew1J3pU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-lRqiH4lvNm6ge0apU0FlrQ-1; Thu, 02 Dec 2021 12:46:04 -0500
X-MC-Unique: lRqiH4lvNm6ge0apU0FlrQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 69-20020a1c0148000000b0033214e5b021so223683wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Dec 2021 09:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=uKmzT1/YmP73qs650iyNoUcPQkfF4oMfX1WHEk8C8P8=;
 b=GM/UuEazZH47i47uPsdcHeTdHWGob408awEiazjjMrBYCk085klnLohs5QNHQyzAxd
 NPmXixt0834hyH/Aayy4vvZjIw34mrViDGC0aHpxbuyCo/RL7uC6ro07/VNvIcKT3B3v
 RAsb7410FHW35w7dk7Pep48HB0ArELaDXTAeLP2gkkSP+moCoGgf2d0u+X0kZ+8XehsH
 yt3ZX1xY/ysEMY1evdKA5m55UPH5ZYI/ClbcMXRkwcR8wSlxvtHZ3AIGpSQ8fMGHJesO
 gGE0WSSZgbc0LK+I2uOZv1mJ8B0tah9PJuW366nz2V6MJV3XcjhGii2wgGlYXhiEJZsu
 GAsA==
X-Gm-Message-State: AOAM531hbbc2uWpTitaPIC7RR46GyG3Zj5ws9RxSIdCZM8LSEXU/c5zp
 kjwluwDib0iCy7q0vPYBBrIeYMzj2uGeNNgcKfoq9qU2tSK0ICEcVxvX7qVy926G5Y+XHKBUqOG
 F4W1rvHpR+gcP4f3IuSSxZp092AzkOLnge6gCHAyoUQ==
X-Received: by 2002:a05:6000:1105:: with SMTP id
 z5mr15886508wrw.615.1638467163553; 
 Thu, 02 Dec 2021 09:46:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLS7UY12kzWqPG9e4Bk9dvNbOkB949nYgl+o103/sy+tey7EMqUaRB+LHPfb7joZx4HomMXg==
X-Received: by 2002:a05:6000:1105:: with SMTP id
 z5mr15886484wrw.615.1638467163332; 
 Thu, 02 Dec 2021 09:46:03 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id n4sm518368wri.41.2021.12.02.09.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Dec 2021 09:46:02 -0800 (PST)
Subject: Re: [PATCH v3 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org, mst@redhat.com, jasowang@redhat.com
References: <20211201173323.1045819-1-jean-philippe@linaro.org>
 <20211201173323.1045819-2-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <886fa0bd-bb43-32d3-52f1-c1cd2024be92@redhat.com>
Date: Thu, 2 Dec 2021 18:46:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211201173323.1045819-2-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: pasic@linux.ibm.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, virtualization@lists.linux-foundation.org
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jean,

On 12/1/21 6:33 PM, Jean-Philippe Brucker wrote:
> Add definitions for the VIRTIO_IOMMU_F_BYPASS_CONFIG, which supersedes
> VIRTIO_IOMMU_F_BYPASS.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/uapi/linux/virtio_iommu.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..1ff357f0d72e 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -16,6 +16,7 @@
>  #define VIRTIO_IOMMU_F_BYPASS			3
>  #define VIRTIO_IOMMU_F_PROBE			4
>  #define VIRTIO_IOMMU_F_MMIO			5
> +#define VIRTIO_IOMMU_F_BYPASS_CONFIG		6
>  
>  struct virtio_iommu_range_64 {
>  	__le64					start;
> @@ -36,6 +37,8 @@ struct virtio_iommu_config {
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
>  	__le32					probe_size;
> +	__u8					bypass;
> +	__u8					reserved[3];
>  };
>  
>  /* Request types */
> @@ -66,11 +69,14 @@ struct virtio_iommu_req_tail {
>  	__u8					reserved[3];
>  };
>  
> +#define VIRTIO_IOMMU_ATTACH_F_BYPASS		(1 << 0)
> +
>  struct virtio_iommu_req_attach {
>  	struct virtio_iommu_req_head		head;
>  	__le32					domain;
>  	__le32					endpoint;
> -	__u8					reserved[8];
> +	__le32					flags;
> +	__u8					reserved[4];
>  	struct virtio_iommu_req_tail		tail;
>  };
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
