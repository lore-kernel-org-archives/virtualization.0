Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F23A962B
	for <virtualization@lists.linux.dev>; Thu, 19 Mar 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908113; cv=none; b=i1vKXUuI3TCAMzo3NutJtGRAc3QiUoDOTu/CZNVoR/zfo2hB8g0Obh2sQuIg2g3goWMQRuFK6laIy36bGwzN9xOL5RFgOvpbvysPHDCrEQsNwdu/yYb9qlXbB/a5S/VVKy2+n5By0F8poH1aj8JcRodSrrMW66W+9teND+n/fqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908113; c=relaxed/simple;
	bh=QANDCGLwr0Rsph14eghi4C+OqJMt6Szo+XgLHBQngJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuPHvXxBMljztT3uhvhu0UkdRu+VBIROUODgef3qkZWqS0h+U2MtJIAXG6q4Pwe7I1HWDFOMQ4vaPMvvmebshsqyh04OkFkgYFAlMw54vSNQiF2WHUSCl50OqKKmg7irK6NyPKr6zHvn4B7jPiYAF4QnSCPt9HlBd1a8JW5Fuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTS8pdAh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTS8pdAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773908111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQwb/jbYCyylu7ufKUxxowBWIvCxOUbZAHno6gx/wM8=;
	b=iTS8pdAhB7DcHT3Br/KjUI21mfv3SWbKRXcHFkDFwBf5DVCLhJSYISSRRef9L1TuDV+ejC
	vdYpr1O31Wr1ILYHuCe3l3gjYWi0aSVHfOgFLgQGrT+Y3L/4+OO71LHV4ncV7sdv01rZam
	pCMZ0oKGAe1G2QDVKLmPtucIvxpsWiI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-ck3mf2YwNpmEAdtHfb5WMg-1; Thu, 19 Mar 2026 04:15:09 -0400
X-MC-Unique: ck3mf2YwNpmEAdtHfb5WMg-1
X-Mimecast-MFC-AGG-ID: ck3mf2YwNpmEAdtHfb5WMg_1773908108
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b4d3919e4so484785f8f.0
        for <virtualization@lists.linux.dev>; Thu, 19 Mar 2026 01:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908108; x=1774512908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQwb/jbYCyylu7ufKUxxowBWIvCxOUbZAHno6gx/wM8=;
        b=cbGZCRWV7zq2ohgallhIUZAUDDqK7zLF5kVXO0tI/doQOHDk+2dt0XlEZoHC066OYS
         VtyoueF2mm9DsPlB2hFDTiU1joIG2upVDHF985Lmss+I4bUTtC+ypg1BvY0nTj4tKNf8
         R03ZNVzIRzR/Gidh0Mv/+p7jSWApWIDM0h1W8BiMcNIdtbnBu+sYCEUx/qiINqujuFsW
         PIXmGCqZRTE7BqyVItLlUX6Dp/VzRaZeUmOPY1B4+6iAQ6ZXBFsN/f5pQ+gINJjZJS3c
         Isg/USC8EtS2AQc3eGGNtVF+Z2aamKO5GE+j4wIiXmXBo+/DFqvBhlBNT62a/Vwqo2/Z
         KCow==
X-Forwarded-Encrypted: i=1; AJvYcCWZxU2Ez7H0OAiB10tYplRkHE1JP2NpqavGYjOb8DiND8DQ2cgjF88lZtrQ0MMKUga7/IDgGImbS2gdJ6nonQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwikjXpvfL8HalnroNz6Itw75KKgJi5Nve/MkYmgcA9rnTNzhn
	IRUVfBv87ZlS98Y4zHMkvUxPt7OJ+ZZnd8FXztmp70j9jLoqSQ9NiEyIacqzHNiRzcZPbR5IH0s
	0cQWntieu7/HmulvrevJi4ROgDTHFPPqJiaBCMxXkL9xaFCCWj5X2PUTsCCmnFdlJMQk8
X-Gm-Gg: ATEYQzydsSKmR+WXi15CH6KYS0KlIN3kV058LjbgTw+mWvFd2u2qcds97j2NnMlGylh
	FMA9gDBKhf5jOo0qNY8+xDRUoGA6HXHWGXxBf1onUkvGCfhljwUq3c5qRas6+lwFAOLaOr+iweZ
	97CWDu781cIyAisHOjoniz/gtkQ9F2G00L355wcVB4Rr8Bw+qkl9Oly3+/b8csL4nYDEWQLLT/V
	xfdghtEuB9QSkQX+O1wHM3bVEduFKuK3QKuv7R4YhOeADUw6ZH9mbu/IXV/LGELPwH3/1xXLWrA
	s9jO57Yr0roCNGoVwBmEbicKBgDY1U6RHAy+dCqvpJlzMP3QMZg3ZFZiblcB4LqNN73w+YanPJs
	IMD7b0WTCudtkbHFKtMwpCcsCwsjmIVkv0kpEJlD7C90uQ49S4TQYpzIW
X-Received: by 2002:a05:6000:420f:b0:439:f64b:a82b with SMTP id ffacd0b85a97d-43b527a4623mr11039694f8f.6.1773908108424;
        Thu, 19 Mar 2026 01:15:08 -0700 (PDT)
X-Received: by 2002:a05:6000:420f:b0:439:f64b:a82b with SMTP id ffacd0b85a97d-43b527a4623mr11039647f8f.6.1773908107942;
        Thu, 19 Mar 2026 01:15:07 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5184961csm15529582f8f.6.2026.03.19.01.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 01:15:07 -0700 (PDT)
Message-ID: <6be7d6f0-08ce-466c-87cc-bc2ad3f26aab@redhat.com>
Date: Thu, 19 Mar 2026 09:15:05 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
To: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
 <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QqWXOPOtlsCsUe0PTfr1F1ItN-2Z3kEOeV_ssKnzfIw_1773908108
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/18/26 5:11 AM, Jason Wang wrote:
> On Wed, Mar 18, 2026 at 12:07 PM Jason Wang <jasowang@redhat.com> wrote:
>> On Fri, Mar 13, 2026 at 3:59 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>>> index 75dabb763c65..48de4a16a96a 100644
>>> --- a/include/linux/virtio_net.h
>>> +++ b/include/linux/virtio_net.h
>>> @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>>>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
>>>  }
>>>
>>> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
>>> +                                        struct virtio_net_hdr *hdr,
>>> +                                        bool little_endian)
>>> +{
>>> +       u16 hdr_len;
>>> +
>>> +       hdr_len = skb_transport_offset(skb);
>>> +
>>> +       if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
>>> +               hdr_len += sizeof(struct udphdr);
>>> +       else
>>> +               hdr_len += tcp_hdrlen(skb);
>>
>> Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()
>>
>>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
>>                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
>>                 else if (sinfo->gso_type & SKB_GSO_TCPV6)
>>                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
>>                 else if (sinfo->gso_type & SKB_GSO_UDP_L4)
>>                         hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
>>         else
>>                         return -EINVAL;
>>
>> To be more robust, I'd suggest moving it there.
>>
>> But I have another question, the logic above depends on the headlen is
>> correctly set:
>>
>>                 /* This is a hint as to how much should be linear. */
>>                 hdr->hdr_len = __cpu_to_virtio16(little_endian,
>>                                                  skb_headlen(skb));
>>
>> Is the headlen guaranteed to be correct in all cases (e.g for nested
>> setups or dodgy packets?)
> 
> Speak too fast, I miss
> 
> hdr_len = skb_transport_offset(skb);
> 
> This is probably another call to
> 
> 1) Move virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb() or
> 2) call virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb().

It looks like that the above leads to more complex code with a bunch of
additional conditionals, which possibly the compiler can't optimize out,
and IMHO not nice layering violation, see the already mentioned previous
iteration:

https://lore.kernel.org/all/cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.com/

What about instead simply rename virtio_net_set_hdrlen() to
__virtio_net_set_hdrlen(), virtio_net_set_tnl_hdrlen() to
__virtio_net_set_tnl_hdrlen(), and add explicitly mention in a comment
that such functions must be invoked only after virtio_net_hdr_from_skb()
validation?

/P

