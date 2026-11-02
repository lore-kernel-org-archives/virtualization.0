Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612158;
	b=JMq7M3Z1vo2zNoVJd6vMY4zH/Z1bLsh7V0Y9ly/47+lW+XgHw/gjlO45oXbh5kHoGvvM
	 MC4YP7r1tQ0bVMk6CgBOMNOwQrhz2FqCEmXU3ph9ZibJgtUbpqOysbRZ867J5JVXjRd3u
	 15xATItTlzVfW3mmt0a4WiPXRnvoZEjHpT3ERY8tfecPdGzNww4V9VeN6Ygb7iYXKd4ZC
	 xaQ9yRa+74zya2/QZJrxZDMpicp1yiy8MR3MnzcFKy0w90f3SZ9ebOs+DBU1aMRg5abB1
	 XFM1U9qUT8ua6Te5JngpmBKZ5F1i/cDmiByYw3ZCO3LFdcQx6l48aS2q8RJC2VJdqgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612158;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Mm9UAeiTDrhCY7oe9mnBBjHCOX4kZjsSHaPe1K0OWSw=;
	b=IavrFxyAkFzJly0SuyFaTH+BDttPu4nO3Lf0OpYwTnR7qFzciminKBb9Zif54nYZDrRG
	 FZRSiNdn2zJzZtpH0pTYsrmL0wVi1R7NKdKQoIKo0P4dtd2Kvgk1Q0/zMG7OmkaloGuCb
	 MfTJEMhrRowcv6OhrxQj6NxUdkabALe/bSGgslHRFNAK49aLqNRHck4zva9vh1ilt2XjJ
	 O5k3AXZVP6nXXcw/KeXejXonfyJKKBjHqB9YImbNAYNBlaNgmo+UECq/icc+cymKqtBoZ
	 TeXFvCUrJ2zsdwvaIx1+I3SrBwyWW55QkeSptH/rFPyMvDo2veWnjcI9h4WZ+hoj81Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UFTkJ+mv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F64606A338
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 09:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0F64606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UFTkJ+mv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793612156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm9UAeiTDrhCY7oe9mnBBjHCOX4kZjsSHaPe1K0OWSw=;
	b=UFTkJ+mvX0cSyL7Ru/Ychv8nd/tsyjr4F7N4I953A4u1L4VaNQXzJ2qpFhkAnClSBDjzeT
	KVsPG/QVtBHzCgKP9q2Yi7TKljoYTf0KAWiMFebpZLFOBqMSM5cjJqkM+3YuMSBUMmYgXC
	2lNQMWxGLMQrxzxzhLG42nbu2PC7bZg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NQOSunB7OnGZstW_x7UxLg-1; Mon, 02 Nov 2026 04:35:55 -0500
X-MC-Unique: NQOSunB7OnGZstW_x7UxLg-1
X-Mimecast-MFC-AGG-ID: NQOSunB7OnGZstW_x7UxLg_1793612154
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2065a2ef9so26803625e9.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 01:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612154; x=1794216954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mm9UAeiTDrhCY7oe9mnBBjHCOX4kZjsSHaPe1K0OWSw=;
        b=YBxHlSItR7AorsTXbWc2YHahKZjdN96gW1mY1t6Wevc76avL3bGYRqFv79/D/8kZcI
         ezggrvWz2h048xZaHUd3HlyYaLfrqloj18fcnD9MunGeWN7oi0qK4oTxiXi7siSmCB9z
         hpTbOJ+Ys/3G4Av2jQr2YdNdqnZNAEpr1fPY/HUHD8KUT9gWrI3hiYwGCER5nDA0MZK6
         +UwN5/VVZcPHDSpt3cQD/Qpb2n6AthH8AJ3pu7MRhD7+ixqcHFHViTtN7BShZkPZttlg
         AGc+1JkGOvkAO+iSwjllrBuCqHB5tjfvEXG2ZeLaxr0BYfT3AkOE2haz+ud1oBOvGPDn
         HKGw==
X-Forwarded-Encrypted: i=1; AKwUvBw1hG30zWX9+V54vrLGeUdLm1WfAjvZC17f18x5gmSyZPC/yFxIzzMPF9peqrDUlq7yTKGt6bF8EM/UXGQMQg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIUlrQcy+9coFWsoyNT6/mdA09XC+SQ+iSBXcWZUA2cEsKqQxLt
	mD32wC4AvbXWw6njigGnPxYyla24XvFHF2frI8GaUu+veVuG3HwaCr1UpFFlrGAr4I2N2AR85QG
	KsHHMXll/G7V8wcUVMaqA+I2ZwtGgV/2vp6bHtdLYpJcu+I/LC7eDEZfKVhi+A+KyrOiL
X-Gm-Gg: AYBFou3t+5tnb6tgZuCJKmngO1ONz1J40nzwIuVOuZMlqKzicpgAkzPq4M/VT+kYeLc
	dwB7peejE292ojgHPN9ZqmNjZks/OE0fdQ/lvRdhNG3C6B1KrnxeanxyvD0ym4pkZtTkQNwGiXV
	v9jbaleocslJ/cqGwTjk6DEntdkoTMjieXOvS0bU1h+8HTU8583n8nMBJftLGOXt+9wRcgP5Ir5
	+g8UH3J2HKv7pzcF5aDlBmEQJD3ZRmyIzyDAmWGuSdaxiETi36YEx8iGDzqE5g2oxTlpLynNwVZ
	9gS+0ydWl6gNp4Ey0nwDUlIYcw0Evc6CDx0KNey7TplQfiLn0S3C3KS3FNfJXKKUCzrOVytlTXL
	sxfsA23ubIGpUFnyCTVhRQSafAf8maGpp76Fn+WpWsw==
X-Received: by 2002:a05:600c:5397:b0:4a3:5991:719 with SMTP id 5b1f17b1804b1-4ac1899353bmr216599235e9.31.1793612154063;
        Mon, 02 Nov 2026 01:35:54 -0800 (PST)
X-Received: by 2002:a05:600c:5397:b0:4a3:5991:719 with SMTP id 5b1f17b1804b1-4ac1899353bmr216598595e9.31.1793612153380;
        Mon, 02 Nov 2026 01:35:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm335169085e9.12.2026.11.02.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:35:52 -0800 (PST)
Date: Mon, 2 Nov 2026 04:35:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa: fix typos in comments
Message-ID: <20261102043526-mutt-send-email-mst@kernel.org>
References: <20260904104440.18772-1-hemanth.selam@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260904104440.18772-1-hemanth.selam@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q2duKOZCl75obb9605dp40rok5_F3JQwGGdcHGy4Zi0_1793612154
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2026 at 04:14:38PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
>  include/uapi/linux/virtio_net.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index fd6fdba46094..6bb5f6ef57cf 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -273,7 +273,7 @@ static int eni_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
>  	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>  	const struct vdpa_vq_state_split *split = &state->split;
>  
> -	/* ENI is build upon virtio-pci specfication which not support
> +	/* ENI is build upon virtio-pci specification which not support
>  	 * to set state of virtqueue. But if the state is equal to the
>  	 * device initial state by chance, we can let it go.
>  	 */


given you are bothering - built, not build

> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 1db45b01532b..4a458ebb2567 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -316,7 +316,7 @@ struct virtio_net_ctrl_mac {
>   * Control link announce acknowledgement
>   *
>   * The command VIRTIO_NET_CTRL_ANNOUNCE_ACK is used to indicate that
> - * driver has recevied the notification; device would clear the
> + * driver has received the notification; device would clear the
>   * VIRTIO_NET_S_ANNOUNCE bit in the status field after it receives
>   * this command.
>   */

separate patch pls.

> -- 
> 2.48.1

