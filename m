Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE12063D8
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535453; cv=none; b=Iu55SACl0b4MurRQ/mdlY2ncqFdi4j944mhu2ssWhpcFDzNMN4A7KKje8y2BXDA3jE18ViNcudi/0XSzCCiWS9fWOocym65yLEBA+sD2uY2b7/FySaOuFGKn7hE87i45ZBDHptUpDsG6KiaUnSmdLUtLbpFRxpfp76bv6pULa58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535453; c=relaxed/simple;
	bh=508bg14U3UMJ8jdr3pX2AL6akRM/QyTn1EwYOGL0phw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aXcVUJK/V8JmomwpLBmRH7nDTNiwM9lOFSl2f+r5yCHHtP42r5v2RRKd9jSCR8YuO3neXETN12vlp0wzpdC6v9fRicbGYVN2kqGJHX9p0cBfXuSTzQo6z3o4SZ5h9Li0zu162vQ1+MTV3DSOPLYW5b2Kyn94x89Yx74UAJ88cQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7N/9TGo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7N/9TGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739535451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZijvutShOwbMhwLPMjJwb8XWzeFIQw45xdK6ukivSY=;
	b=J7N/9TGovXCge1ko/0xLQVccvL2XxhtJ1uUVxvQ7FI/oWVJLZfO4MnOjNNP119rIdfgkDD
	TLI7Iw5ExEyybxgy8YFlNCSAILmlzeXbpXRSwVAfp62eNNFpLfOK1bti6p//jUC2jlj5Yq
	SDxdcjnhaEDUyuK7YVdZKDLBM/wLhQw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-Sh9mm4QOPOWS3H_ZGnt-hA-1; Fri, 14 Feb 2025 07:17:30 -0500
X-MC-Unique: Sh9mm4QOPOWS3H_ZGnt-hA-1
X-Mimecast-MFC-AGG-ID: Sh9mm4QOPOWS3H_ZGnt-hA_1739535449
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab7ee92898fso227441866b.0
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 04:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535449; x=1740140249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZijvutShOwbMhwLPMjJwb8XWzeFIQw45xdK6ukivSY=;
        b=EBl5Ok+zqq/9o2a5ExVWYrvIFapaxKWbmxdLnOKbTF33GlsqUr5t6ihgUiLMBkrPhn
         a2ADdTboOoX4q7/DVlpFbABJFf/MbKzGHSJ3lXWTd5BgOANHU1bBXVgYnyqsHI4yjJW5
         4bR5viBJGsBMKU1pl8vMicuW7noppSeJJ7xp8K73AJZgxTTzzG5IIgs+VzmU3zOcjSJF
         pWtwn1w0SaqjDPEW/8A5Z8nGiWqSalvqI5ytslkULzLEG+uTf+gKppniAM5zkFK/vSgg
         FSpyfPvEIxUcl40CMX9SXEmDz5SxvcapimAoSBfMN13LMzGwu2o87eMlWRl7uZ0gYDCm
         lp9A==
X-Forwarded-Encrypted: i=1; AJvYcCUvOIHlt028hCliPjFjCVH+VYgsI1s77Pv+B3MKuh+107oO5EGhn5R06Qc3xJDLml3n8FUs+bETFf1iiA51iw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4vLbg/0g3RTjDh0/TsMmD6qWsSA10X+iSHDQ3Agl4pbVYQi3Q
	SidRA7x3OjozCDNrMaiejNc0Gyt34HDBmO87gNUBW78B916VztyIkO9QUNCqrtTI6cRgpeHqVlx
	3goz1Le2Yro8L7nQBsCS++HPccL+a5wEQRiaodLzuKcr4ySIQaYV0OWq6pAMh7V3G
X-Gm-Gg: ASbGnctOeihLevV7VlgndXpEG6vYpklvibxQ6so6I5TAxp9UW+/PaGG7pDSTZghFoFN
	YtyB8I01OHh5r6VUHrUiDAtxx4yPjK+c4XsnnqjX+/1xLSzdjEiCjVurC1Bb7IB2KgDXW9kH509
	/u5sAfoIx6A0eg7Cpo4CEvHH/W410V8S3gxZq14n1lJpUESU2EiNv4tFAVagJ1fpZkAf6ScXMb9
	QS9uRmppGT1ltKLV3p142qfM8+4hkNJSnvwabDAq+cy3WF6z3Qf8HGscsZx0QrczfQavA==
X-Received: by 2002:a17:907:3fa2:b0:ab7:5b58:f467 with SMTP id a640c23a62f3a-ab7f347aa6cmr1198349266b.40.1739535448569;
        Fri, 14 Feb 2025 04:17:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPf+AeSUeRn24l529Z9ZendqwqQDqP06Hke8qwzwFNKUt9IcGq+7DW+H44R0X87YfMunCk/g==
X-Received: by 2002:a17:907:3fa2:b0:ab7:5b58:f467 with SMTP id a640c23a62f3a-ab7f347aa6cmr1198344266b.40.1739535448190;
        Fri, 14 Feb 2025 04:17:28 -0800 (PST)
Received: from redhat.com ([2.55.187.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323226asm334107966b.8.2025.02.14.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:17:26 -0800 (PST)
Date: Fri, 14 Feb 2025 07:17:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	eperezma@redhat.com, horms@kernel.org, jasowang@redhat.com,
	kuba@kernel.org, kvm@vger.kernel.org, lei19.wang@samsung.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, q1.huang@samsung.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [Patch net v3] vsock/virtio: fix variables initialization during
 resuming
Message-ID: <20250214071714-mutt-send-email-mst@kernel.org>
References: <CAGxU2F7PKH34N7Jd5d=STCAybJi-DDTB-XGiXSAS9BBvGVN4GA@mail.gmail.com>
 <CGME20250214012219epcas5p2840feb4b4539929f37c171375e2f646b@epcas5p2.samsung.com>
 <20250214012200.1883896-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250214012200.1883896-1-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: upRaQXr7z7sawi9FbpBFIg540D_Bid8cDUot8FY9EFk_1739535449
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2025 at 09:22:00AM +0800, Junnan Wu wrote:
> When executing suspend to ram twice in a row,
> the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
> Then after virtqueue_get_buf and `rx_buf_nr` decreased
> in function virtio_transport_rx_work,
> the condition to fill rx buffer
> (rx_buf_nr < rx_buf_max_nr / 2) will never be met.
> 
> It is because that `rx_buf_nr` and `rx_buf_max_nr`
> are initialized only in virtio_vsock_probe(),
> but they should be reset whenever virtqueues are recreated,
> like after a suspend/resume.
> 
> Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
> virtio_vsock_vqs_init(), so we are sure that they are properly
> initialized, every time we initialize the virtqueues, either when we
> load the driver or after a suspend/resume.
> 
> To prevent erroneous atomic load operations on the `queued_replies`
> in the virtio_transport_send_pkt_work() function
> which may disrupt the scheduling of vsock->rx_work
> when transmitting reply-required socket packets,
> this atomic variable must undergo synchronized initialization
> alongside the preceding two variables after a suspend/resume.
> 
> Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
> Link: https://lore.kernel.org/virtualization/20250207052033.2222629-1-junnan01.wu@samsung.com/
> Co-developed-by: Ying Gao <ying01.gao@samsung.com>
> Signed-off-by: Ying Gao <ying01.gao@samsung.com>
> Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index b58c3818f284..f0e48e6911fc 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -670,6 +670,13 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>  	};
>  	int ret;
>  
> +	mutex_lock(&vsock->rx_lock);
> +	vsock->rx_buf_nr = 0;
> +	vsock->rx_buf_max_nr = 0;
> +	mutex_unlock(&vsock->rx_lock);
> +
> +	atomic_set(&vsock->queued_replies, 0);
> +
>  	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
>  	if (ret < 0)
>  		return ret;
> @@ -779,9 +786,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>  
>  	vsock->vdev = vdev;
>  
> -	vsock->rx_buf_nr = 0;
> -	vsock->rx_buf_max_nr = 0;
> -	atomic_set(&vsock->queued_replies, 0);
>  
>  	mutex_init(&vsock->tx_lock);
>  	mutex_init(&vsock->rx_lock);
> -- 
> 2.34.1

