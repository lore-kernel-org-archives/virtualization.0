Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C413C43460
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 23:39:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D0B61354
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 23:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D0B61354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9AE69400AC;
	Mon, 17 May 2021 23:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVEmxlhIpIbM; Mon, 17 May 2021 23:39:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 274BC40109;
	Mon, 17 May 2021 23:39:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08FFFC000E;
	Mon, 17 May 2021 23:39:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55501C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 23:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CAC7606A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 23:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4GKMFHbseIn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 23:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11AC860682
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 23:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621294749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GHKgU9Q5A+PSIQuhrOTutaLyelYrLl2q/I1h4tUs/Q4=;
 b=PH8Vd19sxUNJNfMIKZzso46KLSbqeG0dAchD5ZOgIxKAeGmbwmL9nNwHPLwRdthg0yy18t
 yckNEhQX2k+8pG0iR/WbklK8CcTGgrsHKdPoY5g+aGacmtoGDkvDQATJL62hMd63NxsnLn
 ILBYdE+R3B2IShLmXA0lXMng/oBch7M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-g2KuUwVkPCO-KM4-h69eig-1; Mon, 17 May 2021 19:39:08 -0400
X-MC-Unique: g2KuUwVkPCO-KM4-h69eig-1
Received: by mail-wr1-f69.google.com with SMTP id
 36-20020adf91a70000b029010ec34b3f27so4603095wri.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 16:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GHKgU9Q5A+PSIQuhrOTutaLyelYrLl2q/I1h4tUs/Q4=;
 b=ncfjVbmnP7rZGTjN4X9cTKAR4IPdf7QwhDzRn3iJOdOwUfOEyjV4DlVekh1SHIV/uR
 RlCyEWSZRCxk2t2Seonvn64/NCGRl/dUh/FJNnVQ5lamDRSvTLbeEHuWDyhyzyrQQIV5
 TpvRurw40u9vbzA+tHxdTrEMfn0XtTj27aEozR0Dib/SgODmlOeVM4rYjglIL0sL5Adl
 VRThF3EouMVkSZLmB6UOE0Mihj+mSUviF5XdhvUBCsBa4um7qktHp0eHwHTJ30biRub0
 Onro/2ZEWp8Ik5KFVu2JmSHuHDWXM/z/nFweqTcmwTs14xe7iz1I+1HsfLLUXyAr4jPt
 8Nrw==
X-Gm-Message-State: AOAM533DSF7pp28uHHTBlNOB4O3gUi05ezsbhJKn/suAsDVoa1cc3xip
 zz72WAyvyhZwyck3H/X1KcwXJ6G98trCnEjBTDbZWEB658jX1whsTiSdrX4JgRRG6iwwwVbcQJ/
 2HCwCsxLoq5EkPJIuEC8bysEmUB9O8Xk5gcpvcKgQfQ==
X-Received: by 2002:a05:600c:acc:: with SMTP id
 c12mr2121682wmr.30.1621294747069; 
 Mon, 17 May 2021 16:39:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgDKs89vnThJz4S6eo3XqRnZkkbH1B+nt2G0KOsFeeW+b/QXmSD89/63LPN9wqFkr5x/upYQ==
X-Received: by 2002:a05:600c:acc:: with SMTP id
 c12mr2121648wmr.30.1621294746783; 
 Mon, 17 May 2021 16:39:06 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id v12sm17497490wru.73.2021.05.17.16.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 16:39:06 -0700 (PDT)
Date: Mon, 17 May 2021 19:39:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC PATCH 17/17] virtio_ring: Add validation for used length
Message-ID: <20210517193641-mutt-send-email-mst@kernel.org>
References: <20210517090836.533-1-xieyongji@bytedance.com>
 <20210517090836.533-18-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210517090836.533-18-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ohad@wizery.com, amit@kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, miklos@szeredi.hu,
 stefanha@redhat.com, dan.j.williams@intel.com,
 virtualization@lists.linux-foundation.org, johannes@sipsolutions.net,
 vgoyal@redhat.com
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

On Mon, May 17, 2021 at 05:08:36PM +0800, Xie Yongji wrote:
> This adds validation for used length (might come
> from an untrusted device) when it will be used by
> virtio device driver.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d999a1d6d271..7d4845d06f21 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -68,11 +68,13 @@
>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> +	u32 in_len;			/* Total length of writable buffer */
>  };
>  
>  struct vring_desc_state_packed {
>  	void *data;			/* Data for callback. */
>  	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +	u32 in_len;			/* Total length of writable buffer */
>  	u16 num;			/* Descriptor list length. */
>  	u16 last;			/* The last desc state in a list. */
>  };


Hmm for packed it's aligned to 64 bit anyway, so we are not making it
any worse. But for split this pushes struct size up by 1/3 increasing
cache pressure.


> @@ -486,7 +488,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, avail, descs_used, prev, err_idx, in_len = 0;
>  	int head;
>  	bool indirect;
>  
> @@ -570,6 +572,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			in_len += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -604,6 +607,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  
>  	/* Store token and indirect buffer state. */
>  	vq->split.desc_state[head].data = data;
> +	vq->split.desc_state[head].in_len = in_len;
>  	if (indirect)
>  		vq->split.desc_state[head].indir_desc = desc;
>  	else
> @@ -784,6 +788,10 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (unlikely(len && vq->split.desc_state[i].in_len < *len)) {
> +		BAD_RING(vq, "id %u has invalid length: %u!\n", i, *len);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1059,7 +1067,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  {
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> -	unsigned int i, n, err_idx;
> +	unsigned int i, n, err_idx, in_len = 0;
>  	u16 head, id;
>  	dma_addr_t addr;
>  
> @@ -1084,6 +1092,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			if (vring_mapping_error(vq, addr))
>  				goto unmap_release;
>  
> +			in_len += (n < out_sgs) ? 0 : sg->length;
>  			desc[i].flags = cpu_to_le16(n < out_sgs ?
>  						0 : VRING_DESC_F_WRITE);
>  			desc[i].addr = cpu_to_le64(addr);
> @@ -1141,6 +1150,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
> +	vq->packed.desc_state[id].in_len = in_len;
>  
>  	vq->num_added += 1;
>  
> @@ -1173,7 +1183,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> -	unsigned int i, n, c, descs_used, err_idx;
> +	unsigned int i, n, c, descs_used, err_idx, in_len = 0;
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
>  
> @@ -1223,6 +1233,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  			if (vring_mapping_error(vq, addr))
>  				goto unmap_release;
>  
> +			in_len += (n < out_sgs) ? 0 : sg->length;
>  			flags = cpu_to_le16(vq->packed.avail_used_flags |
>  				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>  				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> @@ -1268,6 +1279,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = ctx;
>  	vq->packed.desc_state[id].last = prev;
> +	vq->packed.desc_state[id].in_len = in_len;
>  
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
> @@ -1456,6 +1468,10 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (unlikely(len && vq->packed.desc_state[id].in_len < *len)) {
> +		BAD_RING(vq, "id %u has invalid length: %u!\n", id, *len);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
