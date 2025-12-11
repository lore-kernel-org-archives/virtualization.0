Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FC1EC018
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765439458; cv=none; b=mAE0WAXkeA4pQC7m+n6MLCUq59Bl000O3QzNTC/ze2Yb+AlCSn9DjyJ4v4zM+jU4Dccjg+I4lhHqonTzLvuHf8AgM0E5fwVtHURl1a9GCsRtWX6I7zSrqdWlknKlQCUXg1E3e1MMN0w5lU/hAzG42Uk/4Nz2gDk0Akt12X9vAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765439458; c=relaxed/simple;
	bh=Tdaj27oj3uUmgl9B6hjdaVnC0Z/17Xx96phCTkl90B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nT8snqstlbQuTAPqNvTKAZaaFwi9hN8OXfQbsU9yxh8ZUJrwAZkuhy+Mfoz2rqb7cW0Qtz+KfF4aYnCDHllLsqx2U6FWX76C/mOEbVa+6jOOZ4gAlLCce8E6Pr5VwpApiQ4j/v4uKTwzNc62KtcawHS8KjLYYNG2N+qgtIMc4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTcwO76j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTcwO76j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765439454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1julX6+lHM93SRmQtBaRqoKkJXlGzuQZ/nqcTrNS9W8=;
	b=eTcwO76jhRrHrBPsqx3yZGQjoN6ffdtqiCny6SkNPzJjWT7hOEAlvC/ZMbURDK9qD2PPXE
	rbMmXC1pq9d8VzXceXOGvKF1sIOVHe3faT+WxLhmb06qAoZ4grcDzjny52Z/lanRCrbzrg
	jCvb/9jW5Wf+E86yETpSrnwwldjXSxg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-dk3PD3z9OyWGnyQ5JQT3Pg-1; Thu, 11 Dec 2025 02:50:53 -0500
X-MC-Unique: dk3PD3z9OyWGnyQ5JQT3Pg-1
X-Mimecast-MFC-AGG-ID: dk3PD3z9OyWGnyQ5JQT3Pg_1765439452
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477964c22e0so3606165e9.0
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 23:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765439452; x=1766044252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1julX6+lHM93SRmQtBaRqoKkJXlGzuQZ/nqcTrNS9W8=;
        b=uq2yVCISmloWOac+Ke0rP2hDJ6Kj9K3DrFfxRDVVZzJEOxfW40r3nOG2DFB5aHw92M
         9sF1Nma6BfoahOycANHHl5BcR9onksV+ggYJDPnXZ8qhuhW/UwS1ej0dGDs9TNEAQmBB
         hKrboh3N49tRi0OQqDt/vOVICDxvqtBJ2aWhMgX/qWn4/zPotv2pNXqR1xT/lb2KHi6T
         beSoh5CLtVbELQAIuN/O75JF9P5b4ukbKvoRTOYg5PrNGfRdUukZZ3AT7xST1z+4rExU
         dJeLZMjGxsadSw6+Uocip5agiyQy5RAwaxl+rwn+Pv/jeNNMNjUbvW5mS/xYtUdcI7kO
         0SUA==
X-Forwarded-Encrypted: i=1; AJvYcCVDJUL8igjMrAm1EPlq6F4jdVz2cwHMQ/iTJacgkSal/sLbIPhKT7irQAXpUM8Sh8OINh86npV/vYIx0T3vJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwME80ow7n61HV2ujuLijHf9IupQzO/Ds5JrPUbIrzyAM1IIkpf
	Ff1B5jdQr0KoG9fvRziQCHc5o5LgKaIKZV6NgetojxhgVo3GlHIG9mdkJ74rO3+saWssw8MDA+C
	3pbaHaMbtwnQv5wI7W/vQMVJdcEOpqlgPGzwiyF0ZBEZ3Y/xvt2apjBf1ObhJ4vEv1xtc
X-Gm-Gg: AY/fxX6kbZtfy7Wd9GqbkT4NyVsjshSnKwC29VtOptnPl7oZbym/pRdvYqN9bpcyXye
	ihmVy/wMBGOHsvdebquQzJ278YCORKjx6K3A4znfT6o01WRDpWql9cqm5rtloHLvGjTfMCv87tD
	a2Jmz/IM+tBjb1Edq6bvL5WIh6MWNX8goHb0jPEKjmY7npG/7D8meCPBH4XYl7V1U+r6kvtKolv
	caqyxz+whKRI1As0sT3VwHcgaaezrev8WNSdUbuhL/DjbNl2ep5YmrzfNke6bKjMeYzCzPUFzVm
	aorwLe3pCPvV8UxiCKGF1cDO1vM4CwbLv2yFnTkpFxIDg2JJFdzBeczmROGdt+3yM1qtvWxEKFw
	LD2P1NkM0C8peMP91oMoYn/VaR3xo1Nw=
X-Received: by 2002:a05:600c:c101:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-47a89da461emr8884065e9.7.1765439452368;
        Wed, 10 Dec 2025 23:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqSjcn3rTA9O8e0vbxus6mZdzQZ1RPlwK+jJom7NtOKCUAyJXsaTZy7V9armCUnMlhTK9Uqw==
X-Received: by 2002:a05:600c:c101:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-47a89da461emr8883815e9.7.1765439451922;
        Wed, 10 Dec 2025 23:50:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-32-59.inter.net.il. [80.230.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b96c70sm3927469f8f.37.2025.12.10.23.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:50:51 -0800 (PST)
Date: Thu, 11 Dec 2025 02:50:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: Fix error code in
 virtio_transport_recv_listen()
Message-ID: <20251211025034-mutt-send-email-mst@kernel.org>
References: <aTp2q-K4xNwiDQSW@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aTp2q-K4xNwiDQSW@stanley.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AjYUoPa2c9te1aqc3YOsYdlULb_MUKkaCjs-gJiwHDQ_1765439452
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 11, 2025 at 10:45:47AM +0300, Dan Carpenter wrote:
> Return a negative error code if the transport doesn't match.  Don't
> return success.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> >From static analysis.  Not tested.
> 
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index dcc8a1d5851e..77fbc6c541bf 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1550,7 +1550,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  		release_sock(child);
>  		virtio_transport_reset_no_sock(t, skb);
>  		sock_put(child);
> -		return ret;
> +		return ret ?: -EINVAL;
>  	}
>  
>  	if (virtio_transport_space_update(child, skb))
> -- 
> 2.51.0

