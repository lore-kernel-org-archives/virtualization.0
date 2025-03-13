Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB2266191
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862877; cv=none; b=u3w7yXO36iajLPf8UnEKsv9bKfSG5qxUnwODuZynVdKGqDYCuokOb5cPYcvBSj6pVT0un0Mv13FF0oMoOohCcHi+oKI2L9z1+94aw+MBemx0GQjTBmdW36WRXvmxlEMfdX2/VfXpOg0TmRnQ2AuChyPfti50CJN3OVeYktDgyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862877; c=relaxed/simple;
	bh=flFI4F9iJbigAdLeH1msK0WPNSRRKGt+NPtx2Z0lY7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F97FlaRYGcJ2z8yEceCFgCC+6Rj8yg4t9TFD92K7SV/GtdaqbhCRYoCdC2u/GbntRNUSMBjZFZyJ1WVOHSRdcvh1J1ggD/Hyhvwoa5h+EEQ7FIEnhJ/vUJDuXnEimVS0pNiYu2oTbM7u+JzPFzCvxOGT7+6h+tgUoD+LnmwQzIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftzECcAp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftzECcAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741862874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKlH8svYGZq8nS9wIHoOZaP2tIWMcEGLEEAOkrVCTz8=;
	b=ftzECcApN1hfG7Xn3xvn3iEG+4j3SqtRIbnnpYg9pZWzcP7/yJVRkEupciYpMmXXRe846C
	tmuDSL2atyfhTiCWK50BXthoKHknYN+cdBgtZ51Dys57rABi8jAzlEEeqhraA3NygY1te6
	2qPkG0FMFcFhsfihyHvgeGqNhf8IMRg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-TJMWiHoxOQ2j7yuBYubfiw-1; Thu, 13 Mar 2025 06:47:49 -0400
X-MC-Unique: TJMWiHoxOQ2j7yuBYubfiw-1
X-Mimecast-MFC-AGG-ID: TJMWiHoxOQ2j7yuBYubfiw_1741862868
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c489babso4064855e9.1
        for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 03:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862868; x=1742467668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKlH8svYGZq8nS9wIHoOZaP2tIWMcEGLEEAOkrVCTz8=;
        b=IoPt2Iz5pFcKln+vr9iuxtBuS35HsOnrq0xHv0FgPV2uz7bprqZAR2qPU6X0XKetTM
         ES80L59GDH2fR93gSUItG3W7/lBj4WEaQAN4hqqzthlrepGM+w5+VehfMwdWsyG5Vdzc
         X26qbZMJrnGJTWG7yGzoDXnt5tJX9Ue2z3WUmBW7X/tkuXrGRj8ZNiuKqmevjWQ6xDTu
         VZ7hTl4MmhqgHMVOVJybCsz2rJ5NvcQaNCU+Xx3cbtZ0BSCJW6kLFAty3V64LMIt3RZj
         rVuTvmUOcsuj8p7YMLPDvMcul2Tte9UTQ1LN/rT22xGVHuE6vE733JSMjnZfu62tsY+X
         /BtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7bCHuDJmaQIePiMq5dcpLfqXBDJfV5mVy/u06Au+jwqLQLlmnLTvk6xAivn9B6HWIvvSPU3HOFSh/lT76ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHE7+UZhBKw8wuIbVWC+GZsBqOu2k+FEBfd4cSh1l0h/3Tg7LI
	hTZkt/9gO2d3/FF84FmIbOhJxTdavvb+eNchhOTXBnXHhWOFmGCrWE/AMfmVrYjjIBRmXKW0ow4
	UgQ6GUh3ugnToZnbVNQ3tSt4cYN/PxM4AUJicxS+nq2B11RHI4TbEBQr0vRf+WCdU
X-Gm-Gg: ASbGncuaksx8jGkwkz3z8f618GfSwMija23m3OuhOgn/vFW6JLj/6HIehECLpwjD4Em
	IiOauqsABzeTBTLKnMUhjG366yv/nnhNQ7x85trKgEHCqaWrLWu58v9mC35bzCToSCSvhS6/DFV
	p2MSvbKjGWbk6q9rVXibHNXpPi0a2eQ8+Qx9s9YIY0JI5S1A3eIGsHyHldbAeFF+9nNrrUm/xcy
	hxquPrrIJqul/BsWSZfU5yDg9/iGSzRz9Z+2/5WYzlK/7oCxs97E25ZnFPmo3+gg2ufsg2oSyuG
	KvYiFJGJeFxxDWuZslW/OYvcQSSNxttKhhw9BuF9
X-Received: by 2002:a05:600c:524c:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-43d05637140mr66351335e9.21.1741862868070;
        Thu, 13 Mar 2025 03:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuof90DCs7eJ3JwItRCIRpwATmH/3XNmF4IhoW7PyjbpLbTIbp4p7z1rZXGN+i2daYNGVW0g==
X-Received: by 2002:a05:600c:524c:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-43d05637140mr66350925e9.21.1741862867674;
        Thu, 13 Mar 2025 03:47:47 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm38333535e9.3.2025.03.13.03.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:47:47 -0700 (PDT)
Message-ID: <87e8bde7-b05e-4a1b-bcef-f6bb3a12315a@redhat.com>
Date: Thu, 13 Mar 2025 11:47:44 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/9] net: add get_netmem/put_netmem support
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-3-almasrymina@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250308214045.1160445-3-almasrymina@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FFDDa4GZrbca8TdcypTNmVGTBHvQg355M7obQDM02Co_1741862868
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 10:40 PM, Mina Almasry wrote:
> Currently net_iovs support only pp ref counts, and do not support a
> page ref equivalent.
> 
> This is fine for the RX path as net_iovs are used exclusively with the
> pp and only pp refcounting is needed there. The TX path however does not
> use pp ref counts, thus, support for get_page/put_page equivalent is
> needed for netmem.
> 
> Support get_netmem/put_netmem. Check the type of the netmem before
> passing it to page or net_iov specific code to obtain a page ref
> equivalent.
> 
> For dmabuf net_iovs, we obtain a ref on the underlying binding. This
> ensures the entire binding doesn't disappear until all the net_iovs have
> been put_netmem'ed. We do not need to track the refcount of individual
> dmabuf net_iovs as we don't allocate/free them from a pool similar to
> what the buddy allocator does for pages.
> 
> This code is written to be extensible by other net_iov implementers.
> get_netmem/put_netmem will check the type of the netmem and route it to
> the correct helper:
> 
> pages -> [get|put]_page()
> dmabuf net_iovs -> net_devmem_[get|put]_net_iov()
> new net_iovs ->	new helpers
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> ---
> 
> v5: https://lore.kernel.org/netdev/20250227041209.2031104-2-almasrymina@google.com/
> 
> - Updated to check that the net_iov is devmem before calling
>   net_devmem_put_net_iov().
> 
> - Jakub requested that callers of __skb_frag_ref()/skb_page_unref be
>   inspected to make sure that they generate / anticipate skbs with the
>   correct pp_recycle and unreadable setting:
> 
> skb_page_unref
> ==============
> 
> - callers that are unreachable for unreadable skbs:
> 
> gro_pull_from_frag0, skb_copy_ubufs, __pskb_pull_tail

Why `__pskb_pull_tail` is not reachable? it's called by __pskb_trim(),
via skb_condense().

/P

