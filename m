Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEA3BBFC4
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442943; cv=none; b=Quc6Pcl/v4rE5nh62kKTzCI/Ky89PPkBddrFN6LSglwCnZdsmOQl+H0dh1/pwt3h1b2n5i8988eIYcxUlorU2Tx5o908MkcyA3N6XqXlGFAYBEGjWEc1azZD9kzNi+up4aPoHz+7Poglx4UJaAa9aQ00Z+DDH+bS0pfp6TKuAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442943; c=relaxed/simple;
	bh=vbGxEzb0OBnrAIYtEDVt4ESNM5CWIM9+WXbJxiNwpDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f9kF+vanzO4DWswAFgK/swEBvo5KyvgifT0/ksze28pnHzQmbk3oCB1Ff82gvVEjHCWEmMoAUQ/xUytDW64cJKk550aepOju1r9+9ub+iVeggNy10htdBWf4J3xrt8tYAZdazWdpKhO1G5W7FYESORbc06QxgZ9S4M0Is/WwXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsL/rfKR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsL/rfKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791442939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKiLb275LvuktYdurVkjV+jC6dOmDBFZ93qIuvoMcPk=;
	b=bsL/rfKRqouwmHddMnnXXsI9hziA1uhz9QQh33UQFXn7zuoYt89kQoFQClzlobcZIL9HpQ
	ElZ4xtKYyD9qiHH+Zy8Td39aWRiKSc83/GqEd06+egURoBy87h36v/sSxQuiKO681naA+3
	tlCKpJVAJC3dmC+fXpM9ckkz51QUxK8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-PXOQVsxyMI2mIfk4hayL3Q-1; Thu, 8 Oct 2026 07:02:18 +0000
X-MC-Unique: PXOQVsxyMI2mIfk4hayL3Q-1
X-Mimecast-MFC-AGG-ID: PXOQVsxyMI2mIfk4hayL3Q_1791442937
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b027578a4so4216428f8f.3
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 00:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442937; x=1792047737;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKiLb275LvuktYdurVkjV+jC6dOmDBFZ93qIuvoMcPk=;
        b=DrHSyeABFNMbRabtjETnwOawBKG3PAaOd3fgYdnD+ObR7m8GdyerASCUo9RdoLnWFl
         86YQgcAP3Iuf5ZXZfDSeldEMExCdrKKZhMKLsxTSCdc/Gqnj3HT23yINdIlVji6GOQRn
         p/Hp9umTsuVluloX2MoqzNfvsu4qDG7IOW4CKhQggBh2pTosuxn9/Ou1JINDNpgRZeGW
         jUjOW5+Gg0mz1EpdjX1wR51iMf0lLrlo0navCyd/lNSYK5JIdcs9YSHOVD8ul9MMR6nv
         4rTHjfFaegCzQH5p+tMpU4lkx8b3hg2Z18MpscfGcTJ9LNUGotxvEJhjnTAPztcNTRC4
         e71g==
X-Forwarded-Encrypted: i=1; AKwUvByyo8k6YmzUGn4AlbR83oofMiniupS3fh4d7tOLVIRtyRsgMFNzSqfmYcWxhWBtIVwby2RjUs7BL7heCEjw7Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJvHpexIl3No2oUVxOyRmxM7pZeQ/zf5fCGam47JCl5jMK2++Ct
	qxPANn46wbrcgFStcyCljxtqZ3O52D1IKadv5iYWmFB9VbF2IBnwLwS+HxgRR81fyT8XpaL5NfR
	vlYH1r3cKODiVr2/ipAvQE8ihgblqvJXdwB9WJmeVJT4/LC6VU5LO3FhaInft5p1SbVUU
X-Gm-Gg: AYBFou3GRjIUM0jXlGLfjnA+eTia+//dTdvj/9XR7TTMVvxIDn4cfP1ZaRKVb9jjqOE
	0Oj/Gy/Lp2Fnlm20Dg+WNwcmunU9qWQHQCKhUxLRqMbO00QWRwy6WOizriH3x9caMOHlTowYxeC
	Xfwf8q3EA+XBRMAQfYTb0OM3T/lCrWOiO20UmDOwmfbCnsesoLazuL4vC6PKCu4I/zrxumD4TqU
	VmxS7fM2apZzh2Zbetq2Supp0xFvWb43meVxvYwHXt5QM0ZUwsP6rKlQ7up7haUjB3oke3H7CxL
	r1VeGGxfD9UbrhxIzNX3ZF/HaBkAA/NR15W7JgknJ7KhxT9XzRFOMIz7qYew9prxLMpbzbY=
X-Received: by 2002:a05:6000:40ce:b0:48c:466e:9d08 with SMTP id ffacd0b85a97d-48c7289e920mr8666474f8f.43.1791442936182;
        Thu, 08 Oct 2026 00:02:16 -0700 (PDT)
X-Received: by 2002:a05:6000:40ce:b0:48c:466e:9d08 with SMTP id ffacd0b85a97d-48c7289e920mr8666360f8f.43.1791442935084;
        Thu, 08 Oct 2026 00:02:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1144csm9098478f8f.23.2026.10.08.00.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:02:14 -0700 (PDT)
Date: Thu, 8 Oct 2026 03:02:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sung byeongchan <tjdqudcks0424@naver.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio_ring: use shadow flags when detaching split
 descriptors
Message-ID: <20261008030121-mutt-send-email-mst@kernel.org>
References: <20261006102112.847280-1-tjdqudcks0424@naver.com>
 <20261008050423.32221-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261008050423.32221-1-tjdqudcks0424@naver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Cj53sVgtWUtGQ-ip3KiTLuhQ5XIBw28sdjUtTHul_I_1791442937
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2026 at 02:04:23PM +0900, sung byeongchan wrote:
> From: sungbyeongchan <tjdqudcks0424@naver.com>
> 
> Split virtqueues save descriptor flags and next indexes in desc_extra
> before publishing descriptors to the device. The detach path uses the
> shadow next index, but decides whether to continue by rereading the NEXT
> flag from the shared descriptor.
> 
> Use the shadow flags for the continuation decision as well. This keeps
> all detach metadata in the same driver-owned snapshot and avoids an
> unnecessary shared-ring read.
> 
> Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
> ---

Thanks, will apply! Can you pls confirm sungbyeongchan without space is your
preferred form to be called, and not a mistake? 


> Changes in v3:
> - Restore a concise commit message explaining the mixed shared/shadow
>   metadata problem. The v2 response had removed the whole description.
> - Keep Michael's Acked-by.
> - No code changes.
> 
> Changes in v2:
> - Drop the two paragraphs Michael identified as unnecessary.
> - Add Michael's Acked-by.
> 
>  drivers/virtio/virtio_ring.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5a80e03..b4cb433df1dec 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -905,7 +905,6 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
>  {
>  	struct vring_desc_extra *extra;
>  	unsigned int i;
> -	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>  
>  	/* Clear data ptr. */
>  	vq->split.desc_state[head].data = NULL;
> @@ -915,7 +914,7 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
>  	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
>  
> -	while (vq->split.vring.desc[i].flags & nextflag) {
> +	while (extra[i].flags & VRING_DESC_F_NEXT) {
>  		i = vring_unmap_one_split(vq, &extra[i]);
>  		vq->vq.num_free++;
>  	}
> base-commit: 0c2669a9f4a1d607e7591ae50ccf3c432a0aff08
> -- 
> 2.43.0

