Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196627;
	b=165EqtENlYBhDkB9GT+Fa6JOLcRPblYutTxaBfd3C+Utnp6o9fB9dBTIrHWhDGaZqP5+
	 H5DgJ+Ml6p7m04KngVWnTVB7dhyLHRQ4OrWTFQz/OpehzW7zzZhLIQ/Q/a8AIPZIhyqDG
	 wQ/NndpxVvzFSJGp1698vj2JO/oP77gu/Ok6g7LCIzy4cet7eDB6fPqtbeZn1AA0HE/B6
	 wIVZZaydB+7wmXX+vLFgfZn8AeF23pMHaAi7Dq9+HOeGxIm24jHyD2v21CqOsvHTNdmJX
	 i1iSIzPBBXSSZXNMPjVWol9v5I1IX5Bkzynxgj77vQJRZz9jmmYy821KSt5gnwp/7Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196627;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=pQ3fmyjnI7iaYkxdHU1FocI1IG6sGSuP8ezfFh3hoxo=;
	b=Q9cK9obmzT2aUur1/NiiCYvyIWCPWFfseQ5ONiSJOBoPAWo4j6gTfhJeCu7IWYhJW4lN
	 9G+mhCqruNipBKmGWGynO4DWkpOL7rnxSAjGLunkBJaXDUPXySmRDBPErSfPnQspeFAe4
	 yRSuZS7r45ufkYSsC9oI/NOxnSIDR7kHK5BLrsW3Euuhv8E24RiN1n0Xn+sQubRNZ3h3s
	 CLNiP3IFH7Y0ZQs0kvfNFWmvYvZthHIXeCBOE4GHld1e150c7brJgnjhHkeSCxwHQzOJx
	 Fp/Lwyf0j/pwUjpw467Q03BNUwHhaKlFaS17HmocyYPZMz6cYObljSF79kZC4xDEwuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="W/YbbJT1";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918E606A7DF
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 17:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8918E606A7DF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W/YbbJT1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795196625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ3fmyjnI7iaYkxdHU1FocI1IG6sGSuP8ezfFh3hoxo=;
	b=W/YbbJT1T6SPfyhgdV+k/AJsU52R5OTRWdc3fkr3VhM5KnxXlwD/MOnF8gpENvlc+5ccOH
	MNrQRpSMjABb0TSp415Wva8bGXLsqbR1xyVz7OBMwJ4nzet6sz04HbZZjqrpKlM19Zacs5
	6WtITXSrwfh5fBt4HoUA23R6U3J1Cbs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-84hqrNUaNrWBzxRvr4wv8A-1; Fri, 20 Nov 2026 17:43:43 +0000
X-MC-Unique: 84hqrNUaNrWBzxRvr4wv8A-1
X-Mimecast-MFC-AGG-ID: 84hqrNUaNrWBzxRvr4wv8A_1795196622
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a204f135ffso5771195e9.1
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 09:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196622; x=1795801422;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQ3fmyjnI7iaYkxdHU1FocI1IG6sGSuP8ezfFh3hoxo=;
        b=fp4M2tCdleLOCnXtmxlC4X6tAviwa326Mt09lVkZQZp7U6BRA76QQErmWmiyz4+1ZG
         L+kq6U6TTneoC4taJHV6bpBp63DK1gf4egwQudMiwBH1LkHhnxdY6nERRiHNXejgg3AO
         +fgYzGRj9l30nxotDMzHVUuoBJsZRJVpOCA2TPwMqKmb/tXQ2dVouplizszktKoCJrF7
         cPuT2NCPyHC/4qoj4vle0TtCPZz0CGqwjh1pypSHgQF8mi4AePMcYfngHR0u5p+Vkp2R
         OUjiIb6JdFRcs/A8aFMIQD9DDkV7ywe82cF6SH5txtXDYZz916kXRXEzMLMwziN895jk
         jPsQ==
X-Forwarded-Encrypted: i=1; AL+hErE/75cOY0rvW5picr2kQGyLzsAkQbFwpgg5jpmR7OoYooSdC0n6VFYUGt4Y3O3Iwj6HIyE+2sQb+WCmBdDsvw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/mIjFMX73XOXL22379lhGz3kegVluxiBHM12ovWbPEl6xn9eDT
	joaJvuaPK1ah7PFnMP0Dd88xJTKHQWuszUy5lI6d9xAcVHyavFPhby2IV2D0lIAGYMRxCfY5EtB
	8oTJowq+yWOKt0r/XNVKLYRFFFRWF+dF2bsVIt3wbM7z9MAs7YbnFhMGE2SZ7RnixKW6M
X-Gm-Gg: AYBFou2Cxh2Ob+mzeWjrlxz+NnNlFEuHC4CLRkWXm42hz/1wDgwQs0VJnDR0UTbYpvt
	h5WEwpJZi4+G7zLNNSJ56MYKo4Syq332WFWpsqfXIXu5t0OgIgVjHj47CoFOFZiT3T0lCe1Dqkr
	AoiGuIFQVq0CTtD9boQY84f4eENX+x5WR9XDvb9/mR+LrxIV+boWTLQYNGsl8dm+WrY/7Iq8cjV
	MZf9+aeT7ytE/7sTwAck9KCvvb20EC9sSCykADPZJ+L5wT3aqLUNS+HM7Mioi29JnN61v8CFMUS
	HKyVENKNE7pvnHH4fgcxkAo6AKp1mI4/By6ueTh8eNLNNSsFQ/FDBncro5zesajket3wwVhj4YW
	pCTBgRuHI+uTqQ+u1B3zGCEXPEQOUdIL8SRZ2e+tqmWy1
X-Received: by 2002:a05:600c:a086:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4bb887c34bcmr93398535e9.2.1795196621639;
        Fri, 20 Nov 2026 09:43:41 -0800 (PST)
X-Received: by 2002:a05:600c:a086:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4bb887c34bcmr93397795e9.2.1795196620944;
        Fri, 20 Nov 2026 09:43:40 -0800 (PST)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm158225955e9.14.2026.11.20.09.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:43:40 -0800 (PST)
Date: Fri, 20 Nov 2026 12:43:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, eperezma@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH v2 1/3] virtio: add virtqueue_get_last_used_idx() helper
Message-ID: <20261120124307-mutt-send-email-mst@kernel.org>
References: <20261120071826.198604-1-lange_tang@163.com>
 <20261120071826.198604-2-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261120071826.198604-2-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CnBTLXA111klP1XOnTZfP3Fe7npBRbimOw_iOdmSoSM_1795196622
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2026 at 03:18:24PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> Expose last_used_idx through a new helper, which is used by both the split
> and the packed ring and denotes the position the driver has last consumed.
> It is useful for drivers that need to detect whether the device has
> produced buffers that have not been consumed yet, by passing the returned
> value to virtqueue_poll().
> 
> The split ring now writes the field with WRITE_ONCE() (the packed ring
> already did) to document that the new reader can run concurrently with
> the poll path.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>



This kind of low level API is not reasonable in virtio.h



> ---
>  drivers/virtio/virtio_ring.c | 18 ++++++++++++++++--
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a200..e8af6d5c6432 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1005,7 +1005,7 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
>  	detach_buf_split(vq, i, ctx);
> -	vq->last_used_idx++;
> +	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> @@ -1072,7 +1072,7 @@ static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
>  	ret = vq->split.desc_state[last_used].data;
>  	detach_buf_split_in_order(vq, last_used, ctx);
>  
> -	vq->last_used_idx++;
> +	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
>  	vq->last_used += (vq->vq.num_free - num_free);
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
> @@ -3236,6 +3236,20 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> +/**
> + * virtqueue_get_last_used_idx - get the ring's last consumed position
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns: the vring_virtqueue's last_used_idx.
> + */
> +unsigned int virtqueue_get_last_used_idx(const struct virtqueue *_vq)
> +{
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return READ_ONCE(vq->last_used_idx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_last_used_idx);
> +
>  /**
>   * virtqueue_enable_cb - restart callbacks after disable_cb.
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index f923e42cfd01..1aed4d9235c8 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -112,6 +112,8 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
>  
>  bool virtqueue_poll(struct virtqueue *vq, unsigned);
>  
> +unsigned int virtqueue_get_last_used_idx(const struct virtqueue *vq);
> +
>  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>  
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> -- 
> 2.25.1

