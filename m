Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128771;
	b=NE9g3mNB80kvZUT+Ot2nkqk3VSIXoe9EN/5nY7CIKyscaQhUwB4/QEYXmDgsh/U6AjK7
	 Xbfx58eQrkcCys4zqhtYNeNkGi+G3FTNdkxndMQ2D170mCy2tde6E8f0TrffBUFfl3xRx
	 4eaLghz0ufj6t3Qoz1FpMLlDktOZlbSLvntEBMxb43Bu/Al8KZvUQfuNafhFL8Cotr0F0
	 5xcBFueIvJ2Uej7GW0vK32BcEiD9+9Nim+mwE0G4nPGkiSFSAoEahHHd62Vkqob5lY4Pp
	 4t1Q659mI6e0QLepsBS+d7TjmrBY8RfOJOhmhtpZU7W3nwlg9eUTidW8q/9fCRqZYtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128771;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=NDq5khxQ+WqrT0Z/KGYDQfM27UlUOaUjQhhNJn0MrTg=;
	b=pYvcw3MrfDyQmE7gsxebWVunY3Coojfj3F29eCAoGI1TVZlinVwpIpzUCoPWSq8yPa8S
	 QdS5loHZ6EdsqqlfQm+eRfbW6RDoEgyy/H/ZAQkgWA0IBZtgvMQcgQKhIDeHa2xnsFtTK
	 5iimCs++muAYRWLfxOcQLl+xL0rQorlLhGteZLqn4QEQSOOho6Cs61Xm1GrBuF2rMkw8+
	 9HexJ0+M5aP4jcwxeXwo4NwlO5ZTxSzJ9GSASkp71chHQvylvSsO9s4tb8gRw/cJEbL6d
	 N3fS5VpuLicwJ62M4cPybem/tPFaFywnjOxrUgZZ0HPOG4QurXY+PjeAplSv3NUugmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="P/FltBI7";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6D606A31D
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02E6D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P/FltBI7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793128770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDq5khxQ+WqrT0Z/KGYDQfM27UlUOaUjQhhNJn0MrTg=;
	b=P/FltBI7f8gBoojc3PbAMem8+hKiY06yC+iBfvL0TyQ29n7vPixDd2rE8tLtu+AhLXIR9e
	zDpT6Dxk2AZ76fGGzJlNvay9iVKhJI2B3yg72NFI36b2IXHBgJkwNGnKzpKqZVVkUbT1rW
	ZmxZ22uDFWGJnry1tOJbVENoQpHX0JU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-JjQYPaoMP-W2HKZvxijF0A-1; Tue, 27 Oct 2026 15:19:28 -0400
X-MC-Unique: JjQYPaoMP-W2HKZvxijF0A-1
X-Mimecast-MFC-AGG-ID: JjQYPaoMP-W2HKZvxijF0A_1793128768
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso126187f8f.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 12:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793128767; x=1793733567;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDq5khxQ+WqrT0Z/KGYDQfM27UlUOaUjQhhNJn0MrTg=;
        b=RWCDYyOimR3RRvPTO6N+pUAa7/ELIkK9OiRHD4WaNEYbI4hq+m83RLRje3rOwKMHNN
         dm5kzHs4IXQKpPX9z7+VmQB7yAbOSDHd6nDjLXrwMT9EnF4z+u2UzMKhO1KLol5VfMls
         ZamT40IO1h9JXWz/n2My4/cH8MiWbV7vZ63ds6ixmeyYuKhnhGyjcXCXYL7Dp+ZDTUBU
         vfEJ4ucO96HNmvvCe9S3yDis8m1hLQmEcb/rcvycDQ0Hy55HoGFYZUjsdaPBKae9M3WX
         +CHG1MedR/rbSx33zUy6mjKLDhade7eEzhLvLn9LbfvHEhQFjYMr+CeV8+KBz8eN9GDS
         7inQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqEzkcmH0bwu1dn47rgMP3n7e/+KYscz4tgZBEnTPK959B/tjnCN0ThEkrspPxLzbRc/He3ZV7L2R1edWALw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIgJQW7lrkSjfqiYo/poglhqXPa+GbccggHYqLJF8E8kyOSYfNq
	pYF5oyEjYKtNe3ghdwOwa7A5rYyeQZVPbloGdwFrC3h/fgdItxaZt5PM6MfG7osH4qSRuz1mpOB
	CCWwYq9YhMx1qqEFS7QKKr46hmUoCLVIRuk6aensXyVjtnxKVabDl95+gpmXTD9QHtF3R
X-Gm-Gg: AYBFou0lnJYDZrFeYH5UsBDFv0o9H72Egg4IG43TH9uDJoDnRgAsDuhWvEU4Ks0xJl/
	cRN/Jt2iahj5QQR0JLGLPeEGbsHM4layaVziPiAsOcl6yXd5bKO+Z1avYQr/PIUqf66VjKV69Gu
	oyeZ47FNtg/ZVrspbbeXq4VCaIDc9KEbCd3/7HpJW5BSaVoXo0x38WdNjt7JDPyk5ijIuHs+593
	CzBu9D9C3wvQKOe61V7dFkAKxRTQiWXmpRiekiiCXG9Ad1xMophGPpYb1HPkOh9G6A4CAU2UN1Z
	Bo3Z3DY/juQOf7cfI4OM+bYQhauj3N7XsRhkK0lcu6WZz3uikGQwJ4Up2dOIOCLtUmo=
X-Received: by 2002:a05:6000:1a8f:b0:48d:ee35:b3fe with SMTP id ffacd0b85a97d-48e5d45a495mr870578f8f.8.1793128767407;
        Tue, 27 Oct 2026 12:19:27 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8f:b0:48d:ee35:b3fe with SMTP id ffacd0b85a97d-48e5d45a495mr870532f8f.8.1793128766789;
        Tue, 27 Oct 2026 12:19:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e4806e208sm19045689f8f.40.2026.10.27.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:19:25 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:19:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: shao.mingyin@zte.com.cn
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	hch@lst.de, dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in batched
 completion
Message-ID: <20261027151917-mutt-send-email-mst@kernel.org>
References: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j0cw6byAtXLRgTYjSypu6ziit22ngT4FI2G4GzL2Kls_1793128768
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2026 at 07:55:19PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> For zone append, the block layer copies req->__sector back into the
> bio in blk_zone_append_update_request_bio(), so the driver must update
> req->__sector with the sector reported by the device.
> virtblk_request_done() does that, but the batched completion path used
> by virtblk_poll() only unmaps and cleans up the requests before calling
> blk_mq_end_request_batch().
> 
> A zone append completed through polling therefore keeps the sector that
> was assigned at submission time, and the file system or application sees
> the wrong LBA for the written data.
> 
> Move the sector update into a helper and call it from both completion
> paths.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c8bfbf8435ac..cc29b8238a4d 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -331,18 +331,25 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
>  	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
>  }
> 
> +static inline void virtblk_update_zone_append_sector(struct request *req,
> +						     struct virtblk_req *vbr)
> +{
> +	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
> +
> +	if (req_op(req) == REQ_OP_ZONE_APPEND)
> +		req->__sector = virtio64_to_cpu(vblk->vdev,
> +						vbr->in_hdr.zone_append.sector);
> +}
> +
>  static inline void virtblk_request_done(struct request *req)
>  {
>  	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>  	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
> -	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
> 
>  	virtblk_unmap_data(req, vbr);
>  	virtblk_cleanup_cmd(req);
> 
> -	if (req_op(req) == REQ_OP_ZONE_APPEND)
> -		req->__sector = virtio64_to_cpu(vblk->vdev,
> -						vbr->in_hdr.zone_append.sector);
> +	virtblk_update_zone_append_sector(req, vbr);
> 
>  	blk_mq_end_request(req, status);
>  }
> @@ -1196,8 +1203,11 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
>  	struct request *req;
> 
>  	rq_list_for_each(&iob->req_list, req) {
> -		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
> +		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> +
> +		virtblk_unmap_data(req, vbr);
>  		virtblk_cleanup_cmd(req);
> +		virtblk_update_zone_append_sector(req, vbr);
>  	}
>  	blk_mq_end_request_batch(iob);
>  }

