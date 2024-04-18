Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96415E211
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437908; cv=none; b=Qo3+RTSRR4tHxehMLx3oqYmoLdcHVH9bNVI4x+GS7TTsVsJosvyp07T3zHDXQ53jGj4W6j7qY5F8yyHYSrYzxb2FJhURKnozaIr5MBVxPdZkou2SZoLQgn59PZ//zzRp5sBubG4hN7FuNoG/btRFuSKQQXIoF3eaAwWsbAKEwJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437908; c=relaxed/simple;
	bh=zTOTkzFe7i6mwVPzvpuFuKg9+co3We1RwHUHZmalDAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdRnKgUXxGGiOxw4oCzzNEh9TquEUn/Xz41mdoT/CfAo8TSJPOgDPeLgG5q9rM9iU1tVnHTAEj3vixFq3/NWIguc3Ns6ACecB1ceM5xPTnteNj+SqPJQog47CN+Ry3UhKebdZB4clNik9mOLgCuMSstOPO9snNXkHZ/gvarBv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgojlH11; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgojlH11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713437906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e3Q519Xd0bzyd5fUjD22zYGmIt9PVitnNvbYLhe3u7U=;
	b=XgojlH113W8+R3Dr5rXSrCXswQECVhVAMcLkMsE/l4rPQ6jZ4GkM+gryfVjJkqmf/1S+jp
	w2l9iCw7AZZ7bMxIneqm4oLtM5mWhe7HSHggTUT02JpVsM4OUTP+NWgq8KNZxi7g37I6xS
	sO4LAdKPOkdioDnOlLo+b3T84SuUhQg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-3nFafWddO4C2Em7WbdiXbw-1; Thu, 18 Apr 2024 06:58:23 -0400
X-MC-Unique: 3nFafWddO4C2Em7WbdiXbw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-415591b1500so3600275e9.3
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 03:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437902; x=1714042702;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3Q519Xd0bzyd5fUjD22zYGmIt9PVitnNvbYLhe3u7U=;
        b=V18v7EuElG+ndyxXHmD0rgAnMLQb/mgCxFYmNszZsYwyuofZTsov/jxjAVwGetIvdW
         rKWVecjHZEP9Df20jkW9+2FYdY3VVXGlxfraPjy51yt0CTF5p8X4E7BAszKatilsWhmu
         xdkNllRrpAHHXAPhqP7LNmX5Y9HS+SsYdHeryDxRaxFafPn42medfk4pLK5u9+5BN83e
         7+CLAiX8gut+1Gf0BuftsXS6JydLWzyjvQ6CadU47HIYgFv9BmHuMN4XTH+foIpAQCSz
         Vq/bMMS7uKn1cauRRVQG2aWNkOEx5dEnxR0pSgrIe0nJBON1/YFZqSi9XOAEnchKIWyS
         QmbA==
X-Forwarded-Encrypted: i=1; AJvYcCVFkIbG/xkw0LfMGtDPX8u0fUhjUPKO2CswUqyrShb2zoKqkPXG28Z5X1KLm24RCLiAh9XhDvDVEginVRpZlIqcLt5w/DISl9z63SG/93g=
X-Gm-Message-State: AOJu0YyT87cHfrFRuj4rBcQ6t4bff8aT6Y7PDoi04dUx1zEya8RiCb4K
	2vkTGz33JUDgZ5X3KM/xWoG02/FgLqsj7a/eODNJpLOELgvLIkFV/AM1iF5bAlfg7VSpL5s20Tu
	BWH7hnB1NEk4DCZXk+CzYt5faeN0QmnVMiBioRPNx2gJEUx1a/+iHLfmTd6o+ZjqQ
X-Received: by 2002:a05:600c:4fc4:b0:418:a447:a2b4 with SMTP id o4-20020a05600c4fc400b00418a447a2b4mr1650258wmq.3.1713437901870;
        Thu, 18 Apr 2024 03:58:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw4pLCbR7ff+xkBLCuoZDdCLaBRv2TsxwjXdiRLDkVpmg8putzFIUNFiohJYuquLeWZAhtFA==
X-Received: by 2002:a05:600c:4fc4:b0:418:a447:a2b4 with SMTP id o4-20020a05600c4fc400b00418a447a2b4mr1650242wmq.3.1713437901497;
        Thu, 18 Apr 2024 03:58:21 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0041897c6171dsm6036966wmq.16.2024.04.18.03.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 03:58:21 -0700 (PDT)
Message-ID: <02cfd9fb-5481-4ea1-9b43-b1aa24de82d1@redhat.com>
Date: Thu, 18 Apr 2024 12:58:20 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] virtio_balloon: introduce oom-kill invocations
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
 <20240418062602.1291391-2-pizhenwei@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240418062602.1291391-2-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.24 08:26, zhenwei pi wrote:
> When the guest OS runs under critical memory pressure, the guest
> starts to kill processes. A guest monitor agent may scan 'oom_kill'
> from /proc/vmstat, and reports the OOM KILL event. However, the agent
> may be killed and we will loss this critical event(and the later
> events).
> 
> For now we can also grep for magic words in guest kernel log from host
> side. Rather than this unstable way, virtio balloon reports OOM-KILL
> invocations instead.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

