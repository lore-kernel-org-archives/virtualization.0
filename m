Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE09AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:36:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C61260F92
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C61260F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 314E381842;
	Mon, 13 Sep 2021 06:36:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTl55wp2lUsQ; Mon, 13 Sep 2021 06:36:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6D0681831;
	Mon, 13 Sep 2021 06:36:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72422C0011;
	Mon, 13 Sep 2021 06:36:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16A16C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5CB3607AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Og_Hb94glK9x
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:36:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25EDA607A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631514979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uxbSEm+jnbY3ATMV8W8lKCp8/asiFQKlsS1M8LUh7F8=;
 b=ggUTp3tYO67HN8OShU0gq1+OeuyqMHpiilq8HMrdxCmeod1sgQWbQPaVPF51pUtFF+r9Zr
 /2sED1WGAvGLj1N4nE3U15K1L3MjFB49/2F/fSLnr637fvW6sEIM3l0RRyfO13VeGxfEgB
 +BS5rfLCCXuqTwrlefkAUgVdvTGmdYg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-Dq5s6scLMxmi3yfgZ5OBWA-1; Mon, 13 Sep 2021 02:36:18 -0400
X-MC-Unique: Dq5s6scLMxmi3yfgZ5OBWA-1
Received: by mail-ed1-f70.google.com with SMTP id
 a23-20020aa7cf17000000b003caffcef4beso4411831edy.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uxbSEm+jnbY3ATMV8W8lKCp8/asiFQKlsS1M8LUh7F8=;
 b=hhjiZdmpktM6bP7EsvL81ihBaNzo3T9btnXHupEpqNGlxEIo+uE0F9AJ/zFqdEfuTX
 VYqzYpT0HVIfLtL02DJqI0s9oJtxcdqC5WSnmBGT6pcqDJFnwd0CfVAmElK6GiSW5ecv
 Pub+o0REAYkA/v1463la/tAUAKFmDHnWO0MQ/5h85eI6DpfF9FqhlzrRFRyTh+2YQH7w
 TI/yGlpJjrESnMYUBaGcMGTwQDaErlkY8paGAeRL14MO9Mm5YR3idAJ2nlkPXagPUXIv
 QIKgi6NQ1SgsS4AzoJPZlWlfU9eOFXE/INIw8XOFjcBqe52u/pt/l4UzJBv2Nw5PRYoB
 /ruQ==
X-Gm-Message-State: AOAM530wb2VfompwuzK3o3y8nPWMZr04Q3zj3NzdyZ/v8SZqS8twz9n2
 GY1twWnO5N1agRAhqcy+ExJo+nzYKMxsWk/D/rU8wYlpS8HXpE5zr0ff/EtB7M6gOKV0ZCVc1id
 0xzT9ZgstMooQN+VldbGROCM2ovSfV1bkTSYwNx73qQ==
X-Received: by 2002:a17:906:7848:: with SMTP id
 p8mr11096468ejm.212.1631514976749; 
 Sun, 12 Sep 2021 23:36:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykxKexMV48t4flDiOiBz8OweE9Le6nVdW4dPwS+jLsJYOAtzwPKxAZttQtPsVXfJCUG4BX1w==
X-Received: by 2002:a17:906:7848:: with SMTP id
 p8mr11096455ejm.212.1631514976503; 
 Sun, 12 Sep 2021 23:36:16 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id q18sm2960988ejc.84.2021.09.12.23.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 23:36:16 -0700 (PDT)
Date: Mon, 13 Sep 2021 02:36:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 9/9] virtio_ring: validate used buffer length
Message-ID: <20210913023428-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-10-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210913055353.35219-10-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
 virtualization@lists.linux-foundation.org
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

On Mon, Sep 13, 2021 at 01:53:53PM +0800, Jason Wang wrote:
> This patch validate the used buffer length provided by the device
> before trying to use it. This is done by record the in buffer length
> in a new field in desc_state structure during virtqueue_add(), then we
> can fail the virtqueue_get_buf() when we find the device is trying to
> give us a used buffer length which is greater than the in buffer
> length.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hmm this was proposed in the past. The overhead here is
not negligeable, so I'd like to know more -
when is it a problem if the used len is too big?
Don't the affected drivers already track the length somewhere
and so can validated it without the extra cost in
virtio core?

> ---
>  drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d2ca0a7365f8..b8374a6144f3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -69,6 +69,7 @@
>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> +	u64 buflen;			/* In buffer length */
>  };
>  
>  struct vring_desc_state_packed {
> @@ -76,6 +77,7 @@ struct vring_desc_state_packed {
>  	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
>  	u16 num;			/* Descriptor list length. */
>  	u16 last;			/* The last desc state in a list. */
> +	u64 buflen;			/* In buffer length */
>  };
>  
>  struct vring_desc_extra {
> @@ -490,6 +492,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	unsigned int i, n, avail, descs_used, prev, err_idx;
>  	int head;
>  	bool indirect;
> +	u64 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -571,6 +574,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			buflen += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -605,6 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  
>  	/* Store token and indirect buffer state. */
>  	vq->split.desc_state[head].data = data;
> +	vq->split.desc_state[head].buflen = buflen;
>  	if (indirect)
>  		vq->split.desc_state[head].indir_desc = desc;
>  	else
> @@ -784,6 +789,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (unlikely(*len > vq->split.desc_state[i].buflen)) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> +			*len, vq->split.desc_state[i].buflen);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1062,6 +1072,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
> +	u64 buflen = 0;
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1089,6 +1100,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			i++;
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1141,6 +1154,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
> +	vq->packed.desc_state[id].buflen = buflen;
>  
>  	vq->num_added += 1;
>  
> @@ -1176,6 +1190,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	unsigned int i, n, c, descs_used, err_idx;
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
> +	u64 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -1250,6 +1265,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  					1 << VRING_PACKED_DESC_F_AVAIL |
>  					1 << VRING_PACKED_DESC_F_USED;
>  			}
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1268,6 +1285,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = ctx;
>  	vq->packed.desc_state[id].last = prev;
> +	vq->packed.desc_state[id].buflen = buflen;
>  
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
> @@ -1455,6 +1473,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (unlikely(*len > vq->packed.desc_state[id].buflen)) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> +			*len, vq->packed.desc_state[id].buflen);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
