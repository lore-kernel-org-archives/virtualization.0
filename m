Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4A347BAF
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976788; cv=none; b=FE9IcxL8P1YyRoyR/C97sdzAGcM8/1LceQ/seA86dKGSBAsQmYnaecwhTgW6k5DLcUWrJgSZ6aays/ZgkeTb7JKEJtnF11WoAohDZK5dkgg6VhqOTDNsT4toovg9DqcRUtP6gAcPs3jIX9Gy9W0TliZi3sS0UWSl94JxbSmyC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976788; c=relaxed/simple;
	bh=RRVfVaOkvzElgVyb2yZpLwWWK5VmJ9IAKgLIwU5tDcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7STcEoc1xTo8j8t/8tzFTXcEcQw1NEYsh8mlr+Gt5a/rFr7FC4phlZFIMRmdHBNo/xQsNjjtml9cv8bkh8ajjgdnHF0LIz/DB/YBkmhwEmICeCiAOECkZ4fI4lp4YK5sp35kVbBJ0wgUwLb4QdTZguYk461CCmFe4mObw7CkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGDbEP2C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGDbEP2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777976786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OCMbAA6XIkOk80k4O/cwTIGAofxbZ6zwNtF/F1aXko=;
	b=eGDbEP2C6NgHWsCRw46WhvmNp3RaXFAbb797/fKXI+jQ4KYzH0pkgaWeK0qGuLmnETS+IJ
	3xNB1EKGUfqpAW7uiV8/IH8SaQxM4sCMqgN1x/i8+ObomPiv4/jvKtLZ9j99rojgssPPBB
	JtGOf3xbsCoJx9EvkElAJI2dAYNk/s4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-oPJg510XMaaZarrkwLjgcQ-1; Tue, 05 May 2026 06:26:24 -0400
X-MC-Unique: oPJg510XMaaZarrkwLjgcQ-1
X-Mimecast-MFC-AGG-ID: oPJg510XMaaZarrkwLjgcQ_1777976783
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so2150435e9.0
        for <virtualization@lists.linux.dev>; Tue, 05 May 2026 03:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976783; x=1778581583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OCMbAA6XIkOk80k4O/cwTIGAofxbZ6zwNtF/F1aXko=;
        b=Wc9jnwvKOSrXFrDiPK+asmBky8aAu4QNFcrppuInK0NIkCB5k0K8jj8ngqm3OetdGC
         N8V19paeg3c2kDsNT7CVixEP1oAXMqdWCGJUoSDmB6nbYbyiThBGX+45Y/vBe3PqAsMh
         HW1Q12E0Me3gD4JhrzbCUg3//t8yFzFX4sfCkAA5wnoWD4YkvoBcolxUpM40iPBq6rAy
         N7BpdHUileFecywksHt4LOpfCOXhUxHrp07Fo31QQwnZ41QK2Ow7irV0dD9099jFwY0u
         uCQuPpNwmbixl5jl1AA+XCsrg5YcWq0IuWp+kSvvd4U6ARl9RokHMSdRG0Hr0nZBvSes
         YRXg==
X-Forwarded-Encrypted: i=1; AFNElJ/u5vaec1j8az9vH0X+gxBdHZpBcMThmgIgOlry8eo0Y/gu1jferEv7q3iqb6fR/5vOv79HGHLd9P8U1gfQgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZIgmHlPWD5L+/dw4UMUQdXxeJoZZ+xTrGufll+YahCjKKg5Q3
	pbzZAauGOWqa+959L19hSl4zKE1aP7BKof2Q/lCMQA9NYkWXZZb6o65EOzxOH87NwrjjYQtH/vM
	66JjurI/ia/G3Ghgv3dus67/VcVJP7wD3RFzxzSia2gbXTWJ462FPHOwlwdBc76TVB0ZW
X-Gm-Gg: AeBDieuB4RhumJg1Nb56Qvf4l2XzPADcV8lnNDMfAVazRcRkHlcGtnFVAS4rZm0WVZB
	bKW9ix4GiUbd4qIGG8sZTyBnk1vziRgDLavaOFmnFFSrEHqgkOAleiZwgJoQv8KsLk2Z7MqVu6W
	zz31JIECDeRQ8SjUyF4qVJw9jCRfIujrAqmS1nROp3txtCW1HECGHXepH9Klx3PqLP+VVZ8JiJG
	b6EoOEi92FNQUyl43BqWmk+NVpuuNResyEVHIkFwmLJdij+9h5pi3QS4M8KCySW8g3yZBeWmqEY
	TNUs3+lH9Xvh/nsoogluU3PK773VR7mYyoEuE+CntyqgvxwVmgsZ1d9WjBfr//fG8nllgFM14tj
	ZbCBGU/kdLGMhf6RpQVCjc8bJtYhVf2EAPxAT/cZRlwcgaJ1ORL0HWu+HkrjFkhqjKO8=
X-Received: by 2002:a05:600c:4e16:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48d1425b450mr48869405e9.10.1777976783427;
        Tue, 05 May 2026 03:26:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e16:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48d1425b450mr48868885e9.10.1777976782990;
        Tue, 05 May 2026 03:26:22 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17714dc8sm28079685e9.4.2026.05.05.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:26:22 -0700 (PDT)
Message-ID: <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
Date: Tue, 5 May 2026 12:26:21 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
To: sgarzare@redhat.com, stefanha@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tvQkMDSNvFwtru4QfQkwyHVLuEfQvqpU73RNmhWhClM_1777976783
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 9:11 AM, Yiqi Sun wrote:
> vsockmon mirrors packets through virtio_transport_build_skb(), which
> builds a new skb and copies the payload into it. For non-linear skbs,
> this goes through virtio_transport_copy_nonlinear_skb().
> 
> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
> As a result, skb_copy_datagram_iter() sees zero writable bytes
> in the destination iterator and copies no payload data.
> 
> This becomes an info leak because virtio_transport_build_skb() has
> already reserved payload_len bytes in the new skb with skb_put(). The
> skb is then returned to the tap path with that payload area still
> uninitialized, so userspace reading from a vsockmon device can observe
> heap contents and potentially kernel address.
> 
> Fix it by initializing iov_iter.count to the number of bytes to copy.
> 
> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 416d533f493d..6b26ee57ccab 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>  	iov_iter.nr_segs = 1;
>  
>  	to_copy = min_t(size_t, len, skb->len);
> -
> +	iov_iter.count = to_copy;
>  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>  			       &iov_iter, to_copy);

@Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
pre-existing issue you should probably want to address:

>  	to_copy = min_t(size_t, len, skb->len);
Does this length calculation account for the offset when a packet is
split across multiple transmissions?
If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
but to_copy still evaluates to the full length of the skb.

/P

