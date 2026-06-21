Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC310F2
	for <virtualization@lists.linux.dev>; Sun, 21 Jun 2026 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782020005; cv=none; b=XxuTqooqGfBk3yY/xk37iG48LqNamjo0SN5HI36ofM2l5iWi28dUQrFf16PO/KglsS2Yrj/pUl5byn420nXHu4Thovn9RZepo4qLmeNQ01J5qOe60LpcSlgrDLnd2+W/022O3Zh8Ziif7IoANwPwlCX5bSM8U8LjOn+VLxSxNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782020005; c=relaxed/simple;
	bh=7IXgE6bKdUBoyITIytNaAB4oVQtOuc5MoAabCRbQPA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MvFKIukFqa95NkBRReIV3LE+0S+NHGaQtLiTkQCtPyiqmHZM0voDbwN6DPOonFT8boyalL6V4Oqk3lHjgiC4EOxULJBwaFL8bxxawcRCxSZqqZ+qD+Iu6XMYQB5cwq29o6AOMqav02WcnpwPFP4QUb+5CJFUs2+Ri59vixK9LBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk0mQMbR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk0mQMbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782020002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3KhV9nn6ENAoii49nltbnc+k1VDXTF1dIVeYs6uUbM=;
	b=Lk0mQMbRoBvkTpa8SG1WpQt5lawBBFI3XtS/plzpsAgStT4SJCxcuZl1knmH8GfajzHFut
	d+9Mw1XzClqYrQg4zrx3t3tsmK2M9USWUQMNIGh0LMBj7gOjt6X+ih2MGTYqfAxVOx8Ogx
	GbdFoMVR2Tg5kwieXvzLKkHzPEwLHlE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-cH1uIV5oMpe1JWtP_vQL7w-1; Sun, 21 Jun 2026 01:33:21 -0400
X-MC-Unique: cH1uIV5oMpe1JWtP_vQL7w-1
X-Mimecast-MFC-AGG-ID: cH1uIV5oMpe1JWtP_vQL7w_1782020000
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46671e99713so547254f8f.2
        for <virtualization@lists.linux.dev>; Sat, 20 Jun 2026 22:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782020000; x=1782624800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3KhV9nn6ENAoii49nltbnc+k1VDXTF1dIVeYs6uUbM=;
        b=WK1MH6fgBRtaQ1Py2QVhEUk0dGwJZcIZylUte3MpoMFjVy8ZcYX+GUiD4sjHn6k9Hm
         BWqkDQ2BbJHVm7++LH0YiVNcO/wUG38YloF1DXc6j6U+tCsoh2eQrAW3eQxW8iUHU9Bo
         HBVlzrKnB9FupCJPWDWW9xr9skiV0mksxcsmiOMccZAaUOvRvdiVd60yrkjxGS8mo+ph
         H5MIdVR77wHm9J1KqN9Y9sUAvvs61cA1gr5WyY6W2kWr5RSB2rP1qdmhJWzTh7y0hLHT
         r7zADiEcqCogXA12Que2/7yu4iHaOE+VYcNTDKl2heeJkGrooscB8h7qGeTaKRVJTyqU
         Aq2g==
X-Forwarded-Encrypted: i=1; AHgh+RpwJLsLjtuWJ+Ht/LImYNZIkkd/NAfKsWOoMM2RnLNpnNNO6cDGB418E2i4QFLFBWh1+CBXrbQHJY1NdN+bkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDoAd13ohc+ObpdHK7hFw2gZ6S5w66oFTfNT+dX42fCN/jBwIq
	Nws21BgoSD4HzgxsW/T470XxDGsbNJpraOZ2udcjucY2/xZ6hxjudOTCiT4XDtiKlpGW+L+gVOS
	In+SpDkdZaY3c0EDT7YLkIPtw0g7gWw5o87iULFvOW8iXKaKrz3MVdAS1MzTJJk4Wkz8h
X-Gm-Gg: AfdE7cmkjzGtiwHmQbss+njupsKGugCgfkeyHy64R6gdJjlDlYE+vpoAhGpNoEC0jll
	j/AE4XVzJzT4D5ICObzcTYFNVXRE/jcBZaI7022Czp4wtxKFyWBWQxxc6RiB9dY/9H+H8MX86k0
	oewRVHh3m7jxbXwxh3tX/EVFXgn6iSE5B121703N944MY/rXhDkuCpkq6+ZLRflrQYytIRNxWFy
	mhwn5k9ZXF0MdWtOhMGX9rb/aFf/WWavREHA8HIMGt+J7VFcQgebNmH2X/r8xvb94zFPY2r84ra
	05c2Ma1naxvi80Qj8RICvLhoMo1N6xn9SYljyYBLRUr9DkVLlhzzfpX2lWhvGtf77LHxEtCHdNl
	/ofTf8EX9mbfumm22nEonjV6ZfcAxdRQWr8l0umEp6Q==
X-Received: by 2002:a05:6000:1844:b0:460:25f3:b25a with SMTP id ffacd0b85a97d-46503176022mr16556267f8f.34.1782019999823;
        Sat, 20 Jun 2026 22:33:19 -0700 (PDT)
X-Received: by 2002:a05:6000:1844:b0:460:25f3:b25a with SMTP id ffacd0b85a97d-46503176022mr16556229f8f.34.1782019999322;
        Sat, 20 Jun 2026 22:33:19 -0700 (PDT)
Received: from redhat.com (bzq-79-177-155-162.red.bezeqint.net. [79.177.155.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4666678828dsm13793325f8f.19.2026.06.20.22.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:33:18 -0700 (PDT)
Date: Sun, 21 Jun 2026 01:33:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: hexlabsecurity@proton.me
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>, Gonglei <arei.gonglei@huawei.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: virtio - bound the device-reported akcipher
 result
Message-ID: <20260621013215-mutt-send-email-mst@kernel.org>
References: <20260620-b4-disp-27caeeac-v1-1-956e8f9c4f01@proton.me>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260620-b4-disp-27caeeac-v1-1-956e8f9c4f01@proton.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BqZqdSxKAViL8h_-JyF_apGXAAmCibLz8hePtIYpb3I_1782020000
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 20, 2026 at 09:44:21PM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> length


some kind of corruption here.

> virtio_crypto_dataq_akcipher_callback() sets the result length from the
> device-reported response length without bounding it to the destination
> buffer, which was allocated for the original request length.
> sg_copy_from_buffer() then reads that many bytes from the destination
> buffer; a backend reporting a larger length over-reads adjacent kernel
> heap into the caller's scatterlist (an out-of-bounds read).
> 
> Clamp the reported length to the originally requested destination length.
> A conforming device reports no more than that, so valid results are
> unaffected.
> 
> Fixes: a36bd0ad9fbf ("virtio-crypto: adjust dst_len at ops callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index d8d452cac391..64ea141f018c 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -88,7 +88,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
>  	}
>  
>  	/* actual length may be less than dst buffer */
> -	akcipher_req->dst_len = len - sizeof(vc_req->status);
> +	akcipher_req->dst_len = min_t(unsigned int, len - sizeof(vc_req->status),
> +				      akcipher_req->dst_len);
>  	sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
>  			    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
>  	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
> 
> ---
> base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
> change-id: 20260620-b4-disp-27caeeac-5b8b67962fdd
> 
> Best regards,
> -- 
> Bryam Vargas <hexlabsecurity@proton.me>
> 

