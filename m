Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66A2D2385
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773957; cv=none; b=P+bdBnW7so5cQ+Tw2HXVMSC/9CyT5RmT4h2fdgBy9Jm5dw7+hrrKA889khktRyD1HfG1q/ZWE0PGzXOzUmnAP9Cu/Eis28ppzeJ6cjGEmi6lXLfg/kQ6Suxb4NTT0HcMWWaWD8Ht9yiD7/NZ5ZZGWdQtDt5pgoilZh8YBQDv/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773957; c=relaxed/simple;
	bh=ShTqc7z0FpK2/U8YVqk2gMmafxHT4PEfEtsONZW/Zjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxevnNFhblvzl26T4MoSXxMgxnbxv3Vg0kxRvudtaLvGxBG79OBzn5ErOUJN0AsmF7OdZs1rA2QGkUEALnap+QnSDuibr/UDp7UpEzlvs+RmLx/elyru8ihjY4TD7Z52U1QNW4f59Fd/mqlEulh7lbWrQDlQ8c3bIFYnb8PLWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuu6XwFK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuu6XwFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750773955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+TKbeGRcKoBZxXH6jFI/Y3rhb44odXuWUwrtNDdL2o=;
	b=iuu6XwFK5XRPtolXrw/zEBwH2sjm8eMB66GaVGqoieBz163O2kVme3gGvZLMeIpQgHGta4
	VpWrIjLcQlU5nQwpMoXmIFE5QBWc+KfUm94eahWAJWnOQxLRkTczVBTqEZ4DFtsXGnPUEq
	AhsgxpeL3BMkXsrojiEKzPixxPeKb8s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-xANIqCCDMGS2IF7kDEH2SQ-1; Tue, 24 Jun 2025 10:05:53 -0400
X-MC-Unique: xANIqCCDMGS2IF7kDEH2SQ-1
X-Mimecast-MFC-AGG-ID: xANIqCCDMGS2IF7kDEH2SQ_1750773952
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so277099f8f.0
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 07:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773952; x=1751378752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+TKbeGRcKoBZxXH6jFI/Y3rhb44odXuWUwrtNDdL2o=;
        b=W0H2f+jpoTHnNV49mRT0q+gLLpOm+J49d8z/6MZFffLZqOHAXo5tEC1zKKw6srdOP7
         Bp7Aho/7J5LeNqHC3BgQ+YDbACUyhkkP4vLU17xsEHNQ1F+ZJUhXTAg2fXET/daoYi66
         RG/yh0IXX58XF3OtCCAzRt5pB/99/QXjxNKwkAfSkZmswYB/Ifap0Qz10pdmAUBeDfwD
         vFga1w+64ukAYtS+HlIRm7DiAMY4RASLlbMPkjy8aIXokh+2J4n1LSMz42eXF4uIJqQ1
         U590V7OBx7Ax4O3qwlLOYR63e7JvBZbmBRLCgf2031aFHeuNePXD5kxQoG7ndTH7Loi1
         r8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXn+gsARKlfUs0whIIEJFOuur9Y7EUf7XuGOK8blCY/iQASOjyauXnL16mQGQ+wGhnsucOaeX7G7fyKKJ+fpA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7hGc0ltnhKw5c99ZBYecXLNm5UOc7UUOyRlTuQk5CPuO4bEOj
	T1uuKaGqNFP7RK56rIYx1EpMr4z5t5EUkl3aN9IKl7QIRzXGA+cHdvHIX0md1Mgtf/ExGEm1tza
	9vPApfef+3QUxleZdrj9POfbO0PzT9ooBEEyc2SC9iGHIVE8AN1g9GguvqX/PcNkyYqV1
X-Gm-Gg: ASbGncsfcmYtAbP6vnthRVIIXEgifdsMr3eIKM+1m2UuJKaGhX8ZVm03NK99aAUEA06
	JjWdIVmIkuNWwkBqT+V2CsO4UfuB07JMmS7H4aQVsBn+iyx6zhVW48xcNw1LuKd6Eps1GCIfWTV
	No8fZ1C9Iy67Ba8YLGr7Eaz6T2rOalLBkIbdd1Hq8tyYHf+4ItlgKqyEy6wLRiBAEpIUWxlevKz
	f/guaJp1Q/aiTD1wfjYGHspcepYxMgczmL1VAJgU88CQqE0OL5gL7OmZ5IlXG2xMrZDsJos/Wp/
	6njEKDvyeCNu0ktUZ3KmZMr6pTr5Hg==
X-Received: by 2002:a05:6000:144e:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3a6d1322c05mr14142483f8f.36.1750773945814;
        Tue, 24 Jun 2025 07:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErDuslqfWPmZ/xGGypV3ktOS9Nn3dYluWljaHpFoweUHaB+FTxcneVu21gRhwulUWipnA3OA==
X-Received: by 2002:a05:6000:144e:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3a6d1322c05mr14142006f8f.36.1750773940575;
        Tue, 24 Jun 2025 07:05:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8106a69sm2015375f8f.79.2025.06.24.07.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:05:40 -0700 (PDT)
Message-ID: <6ebf5a0a-f13a-43c4-8e42-ba4743e7e417@redhat.com>
Date: Tue, 24 Jun 2025 16:05:38 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] vhost-net: reduce one userspace copy when
 building XDP buff
To: Jason Wang <jasowang@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org
References: <20250612083213.2704-1-jasowang@redhat.com>
 <20250612083213.2704-2-jasowang@redhat.com>
 <684b89de38e3_dcc452944e@willemb.c.googlers.com.notmuch>
 <CACGkMEsKTLfD1nz-CQdn5+ZmxyWdVDwhBOAcB9fO4TUcwzuLPA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEsKTLfD1nz-CQdn5+ZmxyWdVDwhBOAcB9fO4TUcwzuLPA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ubICmUf8YeFqA3hLXBRQY6eUvMcOD4zX6xBDVBwiIOI_1750773952
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/16/25 5:01 AM, Jason Wang wrote:
> On Fri, Jun 13, 2025 at 10:16 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> Jason Wang wrote:
>>> We used to do twice copy_from_iter() to copy virtio-net and packet
>>> separately. This introduce overheads for userspace access hardening as
>>> well as SMAP (for x86 it's stac/clac). So this patch tries to use one
>>> copy_from_iter() to copy them once and move the virtio-net header
>>> afterwards to reduce overheads.
>>>
>>> Testpmd + vhost_net shows 10% improvement from 5.45Mpps to 6.0Mpps.
>>>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>
>> Acked-by: Willem de Bruijn <willemb@google.com>
>>
>>> ---
>>>  drivers/vhost/net.c | 13 ++++---------
>>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>> index 777eb6193985..2845e0a473ea 100644
>>> --- a/drivers/vhost/net.c
>>> +++ b/drivers/vhost/net.c
>>> @@ -690,13 +690,13 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>>>       if (unlikely(!buf))
>>>               return -ENOMEM;
>>>
>>> -     copied = copy_from_iter(buf, sock_hlen, from);
>>> -     if (copied != sock_hlen) {
>>> +     copied = copy_from_iter(buf + pad - sock_hlen, len, from);
>>> +     if (copied != len) {
>>>               ret = -EFAULT;
>>>               goto err;
>>>       }
>>>
>>> -     gso = buf;
>>> +     gso = buf + pad - sock_hlen;
>>>
>>>       if (!sock_hlen)
>>>               memset(buf, 0, pad);
>>> @@ -715,12 +715,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>>>               }
>>>       }
>>>
>>> -     len -= sock_hlen;
>>> -     copied = copy_from_iter(buf + pad, len, from);
>>> -     if (copied != len) {
>>> -             ret = -EFAULT;
>>> -             goto err;
>>> -     }
>>> +     memcpy(buf, buf + pad - sock_hlen, sock_hlen);
>>
>> It's not trivial to see that the dst and src do not overlap, and does
>> does not need memmove.
>>
>> Minimal pad that I can find is 32B and and maximal sock_hlen is 12B.
>>
>> So this is safe. But not obviously so. Unfortunately, these offsets
>> are not all known at compile time, so a BUILD_BUG_ON is not possible.
> 
> We had this:
> 
> int pad = SKB_DATA_ALIGN(VHOST_NET_RX_PAD + headroom + nvq->sock_hlen);
> int sock_hlen = nvq->sock_hlen;
> 
> So pad - sock_len is guaranteed to be greater than zero.
> 
> If this is not obvious, I can add a comment in the next version.

The relevant initializations are not visible in the patch itself, so I
think either a comment in the code or in the commit message would be useful.

Thanks,

Paolo

