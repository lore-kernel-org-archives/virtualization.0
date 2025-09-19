Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA942303CB4
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269243; cv=none; b=sT3lnq2hIzDsy1e9nWD089D21L3ktsdMoESwF1XfoIQc79heUlzS/hW2H5BTf2ukHNVK1nR3M0uiMHPH5JR2Wf1rJr+BxP9fR56lbaWJIi6/cM9h0ATlWQrDJUTTx5ZgKzN6VHEWIYwl/PwOpcdDi867/TV8XV8SqiLg9IWUoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269243; c=relaxed/simple;
	bh=tBNH676IQPThHfYpAKjw3vV8GDNLK4A21I6JHi5JUXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k0WxaDJ2EQj6niWQWtJtD8yzivXzXwFJ6P+tSxTD2ZjN3bU7si0VFu4SfZ0PdFKH1lMJJX4xelvU5/hf7inAFIoRK3PRQKetyF6UpAa9EOadKqiQXzQPVuhIvhlUeVVNftKWSgxkjt3y0iNKSBQ0/ajrctScJx67V1iNERNM+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLh/Vt9C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLh/Vt9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758269239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ4QvBsVVW78p3Cfy0leIhRLNF4HKJO/3heDThFL56U=;
	b=hLh/Vt9CPMGjZGa6WJb+dEVQfZsF9+aigjAFCMj8fb2A7WuMaBFQAe3ISi9ai3LBMmdZ9b
	wXdlvxMIzMW3wv8egdKEinMDg5ohQ07uEOXoMH8m3PtAOmvMhkvVSs28PNhJsVKNAzk4+6
	NPXFqKGSzz69vWehS1x+LoS8ICYln00=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-aU6qi-JVN9qvqpY32WPtSA-1; Fri, 19 Sep 2025 04:07:18 -0400
X-MC-Unique: aU6qi-JVN9qvqpY32WPtSA-1
X-Mimecast-MFC-AGG-ID: aU6qi-JVN9qvqpY32WPtSA_1758269237
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b920a0c89so8180755e9.2
        for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 01:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269237; x=1758874037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ4QvBsVVW78p3Cfy0leIhRLNF4HKJO/3heDThFL56U=;
        b=ePtWX4gtxsOLW1A/nmMFN1vZuFqsjCCpjyJ0YeeqCjLtpbRuutikeMwE6wHKQoOY1M
         rT19/RAKZbyP+JDhHqdoDgQhSVTx4lBF93klfUlgIJEJq1BQG6YeQElmVBDTqKQtfJpH
         izvrSpC4q4OmBG0b69iPhAyzvQRffhQGQbcy6DHyb9dIwr/BQsr/raGT++Q66Rxjc/xA
         IVivtvVBt+fyqkZ7m+SRp643SjKFj8/4BRuiOS5lmCc9UuoTa5ujmTYbr0sz0iFyHjxB
         QgmLmvcC47FPu/1sYqNNJl6B/1w7inaS8WPfTgB5mIU2eEJCSORzL4SCw+tfmfJECFMH
         nadg==
X-Forwarded-Encrypted: i=1; AJvYcCV9VuUjHYKUK93eZMF9eYexMaOqHMDx4L3tqj955+isOQmz/BvRxioBdn3x3d5lfyHMkAbYMlchODDJvbatjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YytO5lJ1wr5TB0E9HLfOEbiiX2HRLz/CMxZgojclRaPQNYl9Yxu
	dqYXVoJoFZAufW08k6BAn98bzOR6+x5UVE7ha/80RxIahbtkewe2gNFdFJgqk5/hBp9X4XlRXWl
	m0Ur5BJSqyStd60mdOA+NomTZQnZN0EhthGmMl7gtGaHJ3T8qT7z4vPZC2aW5olqm4oNz
X-Gm-Gg: ASbGnctUcKEjHeQ+j66pHRfpMHQudYxlcR1D4R9qf9vQAm/KTByU30wMFoeQ63hKcEM
	KYfPPOFPBu9Qp0nFunrbJQgt4lKiqnh1c9LermPZAJ/V0qZJALMyivKCVTG1aaMIdxLNwmKG9PD
	j0v1P8tU0e/tmf0X4/eoF+O87CDvLipE7emdnd/VynK3eIQnjcwGmhnrcUAq4iBzlUHfHokYma3
	cPV/NH9gGo9x6a7UCJOwlEgqDKodQw8RZqSuoHkH2ZgQlV0kUgqL9ehyhWzBikYQLgRG/P3Rkvs
	nREbkklsul8zfA3UgUUbuXrbTGG+npg=
X-Received: by 2002:a05:600c:4511:b0:45d:d515:cf42 with SMTP id 5b1f17b1804b1-467f0498c81mr17348255e9.37.1758269237157;
        Fri, 19 Sep 2025 01:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFinVaPgj48GzlMH0uGul7V9Taa9ADowVJqnSzC3mwQ51zuNJ0wdmkOpIJySWkfMdEYVB/FiA==
X-Received: by 2002:a05:600c:4511:b0:45d:d515:cf42 with SMTP id 5b1f17b1804b1-467f0498c81mr17347925e9.37.1758269236709;
        Fri, 19 Sep 2025 01:07:16 -0700 (PDT)
Received: from redhat.com ([147.235.214.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc72e6sm6472416f8f.29.2025.09.19.01.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:07:16 -0700 (PDT)
Date: Fri, 19 Sep 2025 04:07:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: fix incorrect flags recording in big mode
Message-ID: <20250919040401-mutt-send-email-mst@kernel.org>
References: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _fiBQKPvmH2LJylyOjlh1QxXRMASrpbo8YK1FNJvB-I_1758269237
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2025 at 09:34:50AM +0800, Xuan Zhuo wrote:
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
> 
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
> 
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Thanks for the patch! Yet something to improve:

> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 975bdc5dab84..6e6e74390955 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	 */
>  	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>  
> -	if (vi->mergeable_rx_bufs)
> +	if (vi->mergeable_rx_bufs) {
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>  					stats);
> -	else if (vi->big_packets)
> +	} else if (vi->big_packets) {
> +		void *p;
> +
> +		p = page_address((struct page *)buf);

I'd move this assignment to where p is declared:
		void *p = page_address((struct page *)buf);


> +		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> +
>  		skb = receive_big(dev, vi, rq, buf, len, stats);
> -	else
> +	} else {
>  		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
> +	}
>  
>  	if (unlikely(!skb))
>  		return;


Indeed but let's please not do the initial 
       flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
for the big mode at all, it's confusing, and only works because struct
page is bigger than struct virtio_net_common_hdr.

pls move it into the clauses for mergeable and small.


> -- 
> 2.32.0.3.g01195cf9f

