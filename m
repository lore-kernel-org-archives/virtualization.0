Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552213B58A
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573710; cv=none; b=HoyF9wMMEkEnVGRvEDR9U82ayG72UvKVDM3/zpdQP1273JzxBG4lC9IRR6S+82O0RBRgFtmu0yH1vp4MrOSTwhCDLOSz4TPZ7yrebZTTXbdb63EDU5gBNxS8uSG29byKj+FznxON8HfVGV53hrhXtDNuME1sV28zONqVlQWx4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573710; c=relaxed/simple;
	bh=Ofxkttwg0q855Ek5bR3XqsEaUHIuwh6pDb4e/Mc1zDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G/IvhrExU/hrnFOrbQdh9aWDpmCZ/3+6tpdVN5THgMkF7JpupfDYt4I9AEqsoz2+LODU7luYANC0JYyBH8BnkVpFKJwArXuR8CAQS3KXiykebIvYVLygeCuiVP5Z2oZsbR8fbbQtfmAGxgEUQuoA8GmBMVft+Gdl4q044plHBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Moo6RBKR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Moo6RBKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754573708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CBQHPeKWhgk2iCIsY4V4ZP6qdCDXKu5p8FwiQ8N6ht0=;
	b=Moo6RBKRV3r6xkKvJNt9xjFS43+xpEKg66OzBy+OjGMaFsfaNBbzTddwk/fsMrQwy+bcMY
	4z7/tIpMkZxKAjEqFh7/UMjT/QvN+gylmPwSh+v7wZ7LzA1R4kF0iJP/pXKf1l1Ahwpg/V
	h5FeLybLLpRoaujkLw21dLuH8aiiTx8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-j4_gRJTKNnmG8Rm4wZA2Qw-1; Thu, 07 Aug 2025 09:35:07 -0400
X-MC-Unique: j4_gRJTKNnmG8Rm4wZA2Qw-1
X-Mimecast-MFC-AGG-ID: j4_gRJTKNnmG8Rm4wZA2Qw_1754573706
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7882c0992so386465f8f.0
        for <virtualization@lists.linux.dev>; Thu, 07 Aug 2025 06:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573706; x=1755178506;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBQHPeKWhgk2iCIsY4V4ZP6qdCDXKu5p8FwiQ8N6ht0=;
        b=niAYRRehvZYR0PfDjnZIgLvK7oZZsIXXPwgLNx35Yr36jNPkhBiB7Vcojwpa22JdXW
         hR2+4PQYAdLpTRr1X1Zj9AhmL3/ysUC0khpBoczkUuwcrtKnk95d+lxF43b0O5+eeZvI
         9LfqjNGBXv0aBaclUBOr5tUGzQeqll9bODl8So1ybiPgITUIpCI88Qy5w9dHi0C/zy+6
         QKAK6NRbN2nJ1DQdoRvyVBolbPVwFlq6n/sxywTwKml1W2yAbOUt8hBr6s8BGhDad3Hm
         BdrjptqtZoeoDhIH9fmei+gP47nFf4JilUVf01fK03ayBC3VRiPq+ZRAONMS58uddu3v
         cXsw==
X-Forwarded-Encrypted: i=1; AJvYcCWyXb0q31OX1bZBy37Tivzczs3U0wdIdsd9iujqpfCOFVzWVBEKjvX96FBxkoBJmj1SqKA5BmOTtW3fKymEsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPO06874UDvkJD20reyqIKOghPcoOTJGkx7AEk57DOrscngYyj
	V30hPkaTMCrE5GJAlSefDKd3wRe+olLXDzKbM5yZQUMwe/vdnnYjZu8r0/f06BNg7Hlgx5I6oGn
	AFgGbPllNoQUUubZedmr3SWhRUC4WgeNO9yX3IxkU7LLW/yUZQsDWu721Kfnp4wE5jjIP
X-Gm-Gg: ASbGncudksF2BLCSO+JQyist3f4lJTiseUnK1Ycmv2zVhgiq51S2uYyYUFFHJPoRJXO
	3QUBDGS+qXVD18Yz2Fw2/x+HMoNem1D57v05mrEd9BnBpux1e5Rx1JVS3JqhhwI0r7t8lq4T2KE
	g3IWgGz38hNaXSOi6hbLlm8zKK6TOnvbscZBuQkEKNwoUh5JRI1nxKEpbfuMa1vwSt8iD/AInOD
	v0KRtE39+LLmMHmQXKSZIrX+chm5A3HBK3Xb/r0/DFDZrGhPNPx+VRHIrgRiDIAwQP4bpwiAxEG
	qvlv8V56y/ndOD7sgo4mIBAuIRKIle2qI2oI9rdjeTjieudzfRFMXTaQsyJKntqoz69pqK2Cuhy
	htI8sVKzYQNXa/CAjgOKozJc/qvlQKm/e4PVWrZoySfgG2lUeg37OaDDl/4oGCJrdv78=
X-Received: by 2002:a05:6000:2510:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3b8f48d517fmr5156103f8f.9.1754573705609;
        Thu, 07 Aug 2025 06:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKAWIc38nplrhbPxuf6snMnPctmO09EXGzbkFU/1mEiE/6sqV99tA3cZv7IkrjU5hDDh+S9A==
X-Received: by 2002:a05:6000:2510:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3b8f48d517fmr5156077f8f.9.1754573705113;
        Thu, 07 Aug 2025 06:35:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abeb2sm26905675f8f.11.2025.08.07.06.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:35:04 -0700 (PDT)
Message-ID: <bded0995-4930-400a-a3f5-060073e4caa0@redhat.com>
Date: Thu, 7 Aug 2025 15:35:03 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: Remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250807132643.546237-1-rongqianfeng@vivo.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250807132643.546237-1-rongqianfeng@vivo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bSgJERsIB6fBD4Cbw7UgMZlQwW188MUsnjoQzqHJ3_8_1754573706
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 15:26, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

