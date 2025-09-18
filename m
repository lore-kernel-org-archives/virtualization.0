Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6D27F011
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207153; cv=none; b=HHdijmpvzNtwWPAvsfN4GL4lxwLON0l1/LwoD9DE4X3LExpEBhJ3CNa8IrwNfkASVqaWr4JlmWJ7xwkFs6v+jujP1vmcWY5wfmBeRc4TStFT8W31M36ZHdZrscAQwnPMIDbDnErEI1PWQLE4hNGKKrzCmiIEQ7ks4SMlPZYjZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207153; c=relaxed/simple;
	bh=877fy4JwCj6Yt7dwkYYuI8E/1ziIUPjIl8VIeeaY+04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l/rwmsjKqkN6jvuW6asqlZGepBzw2lMj6hLsJIaavaXih4KtyPGbM/Cen1Y6isx7dzFlF3MqUOVyfZBR4vNJnLLMw7KHv7GSa48y6gOJL/YOe8VDrSuvOaCBJqav4YWm7DRFcr39QRXWcHc2ZHpGqYc/3g8hwt8OQSX9pK+FxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVvuEHXy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVvuEHXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758207149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4xuHLo8yzB0A9DafNx4LR5vIcuDhtQe+LRGJvMc0Qw=;
	b=jVvuEHXyyx2qRRl9+A8XcdWiFUC36jVy3Glzrc7VCHOMFIF700KlwkzHADd8FzKXHehWOE
	fH3SyKpjNf4y3VNMXsWBwa66EYZtWhp9J0FHaTVdffoCuyTAHfylPVU8brrwinyiCHHUny
	eA1AJ9rmMf03cJU8dyP6zJIMkaP9/vA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Jkmzqk7EPgmYFTPbdK4oHw-1; Thu, 18 Sep 2025 10:52:28 -0400
X-MC-Unique: Jkmzqk7EPgmYFTPbdK4oHw-1
X-Mimecast-MFC-AGG-ID: Jkmzqk7EPgmYFTPbdK4oHw_1758207147
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45e037fd142so11682615e9.3
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 07:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207147; x=1758811947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4xuHLo8yzB0A9DafNx4LR5vIcuDhtQe+LRGJvMc0Qw=;
        b=EQ6KAbLkwCK1x1oe0UdC3NiYd8DiXEnZBuvYNfLaiaI72hK6Ph42TDZEZ2XLowczZg
         A4QOB5ld6ZAiBOCEDXMrasdjN/y0JJTbNYAKgb0qvs/aEmWwp2ozlQ5GZJ705Qd1Q6ti
         cCTz3LJxngKscDkkR6JiqS2hgRv/0RPjm2RW6HCDRfMfYhXsIQHPVOKF0qQxaVltf8x2
         DlTQO4AjfjALVCIOTSYSSmeFHd5h1FyqZJBWVGVlH/HlzcwphTEjoNCKib8o54awkYA1
         wWbGh/ZiL4tb7FQ2JDuI/p3ewYr2ajIZXnW5bgrEqfl81D5WtFnJZI4TlUCd2EE8KUoO
         /cEg==
X-Forwarded-Encrypted: i=1; AJvYcCVHlnKtCV4nbiooR1tI6NNF5pEIsH1HBYR1fXqJFo/QfYbV4NrBm16FdMTFeM/mJm2fiiCzMSwBnIREoFNUCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPeoaqRFzyhtM8WHw+peAxw092LAMZgmQ0sQ128shyHjCVvUvi
	qR7r2I/IFLnvOtnoeR45gSggEUXBO829+L3gMw6ukrZSsUVSZeEZTBkCie7+XqjoerXVrOR2py1
	UrGVSQESlS/4Go3cojVkDtYlx4VzM/pOdHSkGhUzGHpmeFs031td8wsd/TD4oxaQFhuOH
X-Gm-Gg: ASbGncuLVsIFJ05aXYQ8JQRkxQXstSfSh5wSWAs2aRRPswPPorjMP3jZUsQ8dbZSWDD
	HzMRWb2CCVoWGUTq6KKBZj/FVCGPl28ydBMtRDNYAfW4Nex37+qik6ivNX9qgawz5xud6CKhZ4h
	ZIfM3mGeaBZLKi811SIkQ0zL3jIWKP+gtgtuTcaEwZgau5BYSm8xD3Wh3dpNq59f+Xz5AU9GSEW
	x+45m5srr1GDDYWInGDdS0bAP3gWGuoco8kWY0xe0dt9GBC1c6TxyGoZ3DHsp8vIHaJ2kTN5iRK
	l28RcQI35VCKvAsos9YZT33YBrrfm1NrGZI=
X-Received: by 2002:a05:6000:430c:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-3ecdf9bbb14mr6283932f8f.22.1758207146772;
        Thu, 18 Sep 2025 07:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqwMRBHuFFqMWYMrzOGs/Y1LvHSUdwEyMMdSeQZSTNEKri6ViSDAyQsaqS+nlL7xHwrs2MhA==
X-Received: by 2002:a05:6000:430c:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-3ecdf9bbb14mr6283908f8f.22.1758207146339;
        Thu, 18 Sep 2025 07:52:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32083729sm61479685e9.0.2025.09.18.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:52:25 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:52:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
Message-ID: <20250918105037-mutt-send-email-mst@kernel.org>
References: <20250917063045.2042-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250917063045.2042-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qHhSsTGg1TjXwq5hlx90jNYbN5YIssBUmCsJZBBvkSA_1758207147
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2025 at 02:30:43PM +0800, Jason Wang wrote:
> Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> of used elem to vhost_net_rx_peek_head_len() to make sure it can
> signal the used correctly before trying to do busy polling. But it
> forgets to clear the count, this would cause the count run out of sync
> with handle_rx() and break the busy polling.
> 
> Fixing this by passing the pointer of the count and clearing it after
> the signaling the used.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I queued this but no promises this gets into this release - depending
on whether there is another rc or no. I had the console revert which
I wanted in this release and don't want it to be held up.

for the future, I expect either a cover letter explaining
what unites the patchset, or just separate patches.

> ---
>  drivers/vhost/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c6508fe0d5c8..16e39f3ab956 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
>  }
>  
>  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
> -				      bool *busyloop_intr, unsigned int count)
> +				      bool *busyloop_intr, unsigned int *count)
>  {
>  	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
>  	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
> @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>  
>  	if (!len && rvq->busyloop_timeout) {
>  		/* Flush batched heads first */
> -		vhost_net_signal_used(rnvq, count);
> +		vhost_net_signal_used(rnvq, *count);
> +		*count = 0;
>  		/* Both tx vq and rx socket were polled here */
>  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
>  
> @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
>  
>  	do {
>  		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> -						      &busyloop_intr, count);
> +						      &busyloop_intr, &count);
>  		if (!sock_len)
>  			break;
>  		sock_len += sock_hlen;
> -- 
> 2.34.1

