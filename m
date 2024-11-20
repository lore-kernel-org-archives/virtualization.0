Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886815B0EE
	for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092904; cv=none; b=OWeXUe0hbkfZ493CIKrEN8vkTKC+x1lpRHYsqVfe1HINe2HMDQC0QIW6OQpxv/sN1rJUM0q66E5YSTk22eYbkSHAymRTjYWUoN/haYwd65g9fTIubr8I+mjgzNkW7MvOwgjQRsUKwOtrq9hdpdOBFJbbyqEmXyA3metvyYp185c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092904; c=relaxed/simple;
	bh=nid7QSnQblLfZFZqlvoCYnby8cBRsCYTlv1NQ8OAb8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpx8Fb2wneuPeb7ew4++IkXRnbK2CXqhnELNySWG2sX4V7nwRqVjh93H4I3nDXIP7qE+8o4A2Dkbi70TxcuWP61gWjal5wTiE42oOsxbrnFqAVwsm7oDzbbIwdLCSEBrI0n0QMIHG+bZ0xxBSTpRRnkaaGFvIu5eSIypNoLP3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgSTz6n9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgSTz6n9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732092901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JMYPpUq2XDxx8Xvb7qlMs/pEnqIP8D2NZt89L6OHoyg=;
	b=KgSTz6n9zCRvlRJeA3UD4I30Z8RqG4dPxc7RTdRC3T5FbNztOYvMSXkBMV9AE3tZCDJiro
	fM5vijLhE84FRFkOyUA/8izQADv8fIWRftmmDXo5TG6C6XB6cUbOmS0Q9/B5Hq6fHWEG3I
	fq59NYwqPPc8CuHHqLQbYrjaMHvl9iA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-bMSzbNIVP72vN0QIoUY4Cw-1; Wed, 20 Nov 2024 03:54:59 -0500
X-MC-Unique: bMSzbNIVP72vN0QIoUY4Cw-1
X-Mimecast-MFC-AGG-ID: bMSzbNIVP72vN0QIoUY4Cw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so14785165e9.1
        for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 00:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732092898; x=1732697698;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMYPpUq2XDxx8Xvb7qlMs/pEnqIP8D2NZt89L6OHoyg=;
        b=XMwosbOb0y4ywWT/b3zNbmXUWKF4ejL5QzPnC5+qTr6H+HEUqfOM44qOcuAQ/vDmjt
         K/3Dje5UHb2L3zNtvlm1ENqyFPAOc3haVQkUarlIMbiddFjO+Y7ArrDCecEk3ntEBRHl
         vQlygvBofXUooKE0dnrOahHOkuCXM4la7wYaT6JdHHA9CWfkw0sTCnVwV9aLBbEiho5P
         96Eay7no+XDOOz3zVqgS9pUnc5llFs3UPKGlbM7OmuUhsOyekD42EqZAgk05C16uhogO
         Ag+vPncdwQXLeR3GrYTQZ2Wg0HekYNEjyotVPs0U52+KV1vPWtmGv74bC/ovRzEQww8R
         wlVA==
X-Forwarded-Encrypted: i=1; AJvYcCUJzgZrNE4TQiRHYwfQMXRBK6tMdFwGKZODL2mrfWvLaUvO7XM8UDpsdxdqZlB10NdAE8Wttii75NpNKlHjog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjAKQ3TZrz0abffD97UiY8DlL4qv6IAyhE7bp2cbnwvkbzhKrF
	Ysw0UcMxr1UHgTifhdj5l9s/B5z1wVItIiITsfdBYvMLDEfU2Gg+jfv0rd2m4JJlEY+XKUbnzPN
	zs9DwxvKTs81g0o07CZ6seKrP5Rgmtg+YLIul7ZDLq9BpRodAIo6kt/MZE73kf/f9
X-Gm-Gg: ASbGncsTGS05MEa5S15pgmw/5xrS44psWFiXH2rtbRj1XV4fmlGdSPPiouUYTTvqprm
	3hKrS0mYNba1HPYYtofCHFOXJNI9diVy9s7661o4+7+u9K+xha+uJcoRnJn9efTjKVzuU/rXeP3
	atDupPzLGpJq/UGU0tMw5WPI7QbO2s3M9nB3LWUKro9qn/KwDOdetY3/6L/E/XS8fxFwlTwwAHB
	BeRaG6WWt22+9uQCbSjzV6FHMvr+Kl2aUOohEOVT05lNyrimjp38KfAN4REHnQn/Bf8OPYijfOZ
	B/jcd7siB3dtrqCnTvyEebpkiA2jYCRGiazuMgNbufKFQOzgnLdBONWLsCwJnNbmMnC7YUwj3Q4
	zgA==
X-Received: by 2002:a05:600c:3d9b:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4334f016ecemr15122055e9.25.1732092898624;
        Wed, 20 Nov 2024 00:54:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAXo2WtFyTtlUkIZYThyUarlZoutt+Vkv1nHozZ0jnX+DGSyr3choO6UEwt7EDBYp0SzUvIg==
X-Received: by 2002:a05:600c:3d9b:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4334f016ecemr15121935e9.25.1732092898252;
        Wed, 20 Nov 2024 00:54:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254905437sm1468998f8f.3.2024.11.20.00.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 00:54:56 -0800 (PST)
Message-ID: <1dd9689c-f392-4bb9-a3f6-359d84bb3183@redhat.com>
Date: Wed, 20 Nov 2024 09:54:55 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: Use outer variable 'page'
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, mst@redhat.com
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KignA3MPOFwt8ITTtlvleHl5M_EdKuJnTZEkmUFTdnY_1732092899
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 06:49, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is no need to define a local variable 'page',
> just use outer variable 'page'.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b36d2803674e..89da052f4f68 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -251,7 +251,7 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
>   
>   	for (num_pfns = 0; num_pfns < num;
>   	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page = balloon_page_alloc();
> +		page = balloon_page_alloc();
>   
>   		if (!page) {
>   			dev_info_ratelimited(&vb->vdev->dev,

Looks reasonable

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

