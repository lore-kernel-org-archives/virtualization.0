Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7C28937F
	for <virtualization@lists.linux.dev>; Fri,  6 Jun 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224943; cv=none; b=IBo/zH54pwsvbgbXPgLGh8NdnoTo7JcjWzYIT0ePSSMepB4Ku/ixpsNxh4ZI1x8yd89W+LEsJ5j1luWE868tAoUbXQ13hIcZwTQUsh9yUXaH+CRLgZ6TjzqbK+3/1YT3m7ycvO5PajlShMgVLsavxrm04KPPiCHGluFsagBb9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224943; c=relaxed/simple;
	bh=qteTWSdXmGXbvSh/VWtVvDyFhQzDEAd2cyVRYJIO0yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su3JyLeECc9POlaqsV9NX0mmffc6oUpvIirGytxKxBJdXwaDIi95Q0A2Hs79ilI6ebuxGfUXr1n1Xwe3wbtxYTucZHwzZYjE5eDMO2934KS23fp+hzgtKA597hKMjHNEllwl0P6hlKZO1kgBVQ/sjd8Do/0gQ403xKfGfMRXBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5KImJNJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5KImJNJ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-312b0d83a10so1432553a91.0
        for <virtualization@lists.linux.dev>; Fri, 06 Jun 2025 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749224941; x=1749829741; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFAXCqQFrPjFZs7s5flyQDRDOg704B5o+gINoyafWfw=;
        b=C5KImJNJueWKQ/c8xbEHyqA8HkK6SqZEYzwYzBcp9NYHPCgvkF6H4KFLOgLYJq7Nt/
         dIBmhqmdMB2uawtUgP7nDJ5Fl7r83UhYfU++QNXT++x5+KP9MC14ufSMGtgWSMetls/9
         DRstYZj++xMmshJ2av46MTgVWiwiCVxW1QYWJjTcRBAMWLYcjRA2EfXlPX6gwPxSjr0C
         wrTE4GAMi9p8knyBA83GUGphPZyqGUBxQ6H+CZLkd/A8aBFSAY7b1dc0XeFYYN5ybgds
         yHe8WRxAN3Yx8dTIFHUWuobQiE6ZPxXDzum9JVHUVLFTFDY5G5b5QHGv6bBMvXEd5EUM
         VXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749224941; x=1749829741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFAXCqQFrPjFZs7s5flyQDRDOg704B5o+gINoyafWfw=;
        b=CauKSq/3wqmvrU/F65QgMkGsihIeCIGXREzFdSuHOFNJyAcFoM0929HYrlZVeYAaoN
         Mo33Lt4z4EiYD83q7Esch5H214K5rlUfpOn/doT/L4/ySV3w+LbOy5TKzofR6WVuEwjm
         m58AB+ao1WuTvPbxWduudulHoMY5R7Vn3aKY+Fu37KLMzejpz5portCf/WnWxyZTv7pJ
         +pEVFBiy7DTFDrKfKYv9R3eJhMS9nqEmDI+lZUMGJzH8yK1ywgQhzzxWYLVVbl/TSap4
         QaHTeihUj7Qsooli1Gk8zjPvHJuWxPtn/uyi1fvbzGmSOC7+kZ7Cco5I2MqdURcGNdf/
         G6tg==
X-Forwarded-Encrypted: i=1; AJvYcCWtkIVZmeWmuy4aka4T45F2YNXK+ylbJeKID0C2NIgqiXhUMO1x7vOxNHSHF8YBBT9678OLi0ueow4E+s1nfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCqx3Oizbb3KF23kIYtm4orMmJ0VaEcf0iQOPjCC5Cd00hDomW
	15QaoKlR39VOsX3iN/tVO6RobFbPducOsvOZ3P0h1PACqIGwrmyGU11/
X-Gm-Gg: ASbGnctLhA4Hxf1qfnq39pmiDLxO2MHmBU3U/px96lft9ldP/Sk5o2bupEuxVbtOZOI
	xsj11TJeSoI/yhhPaHDvrwCpYNnI7z9xoVpNZ29/J+qUqEqUd5ciiT9sqhyMXlviYzUJDQZMNGm
	VTrE6aIONGl9u4OZ7E1e1t02SI1dDTqUy4ePEYPiYJzy0JjvKjgw3LIEeIKwLGtUARy8ixmJOPX
	Fgfvy25Nja0SJpOROt5A6il0qy3VO5v+GkWklf2kilJBBE2P5vQ1fu3OPaDepYzPUKwY37zpV8H
	R7X1X3cUB87ftY1qycrxy5IrXNkChz7UFR4QyrCMWiF0FSlyTIQXkngnh+2M9qx4yRoViQCm3wI
	nNP9RPad0Khubak6H4hl1vLhlWdzuRkqseuxG1XRu
X-Google-Smtp-Source: AGHT+IHG/4StZ2v8LodTRZ+tFEEY1GEgtwGds0NXN4+D7wj3obn0sPwJ9Edgk7OM0j71WGZIu3Rb6w==
X-Received: by 2002:a17:90b:4b09:b0:313:2adc:b4c4 with SMTP id 98e67ed59e1d1-31347678bbcmr5917844a91.24.1749224941467;
        Fri, 06 Jun 2025 08:49:01 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:e7b6:944a:261d:ef5a? ([2001:ee0:4f0e:fb30:e7b6:944a:261d:ef5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcf53sm13827705ad.129.2025.06.06.08.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:49:00 -0700 (PDT)
Message-ID: <f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
Date: Fri, 6 Jun 2025 22:48:53 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
 <f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
 <20250605074810.2b3b2637@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250605074810.2b3b2637@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 21:48, Jakub Kicinski wrote:
> On Thu, 5 Jun 2025 21:33:26 +0700 Bui Quang Minh wrote:
>> On 6/5/25 18:03, Paolo Abeni wrote:
>>> On 6/3/25 5:06 PM, Bui Quang Minh wrote:
>>>> In virtio-net, we have not yet supported multi-buffer XDP packet in
>>>> zerocopy mode when there is a binding XDP program. However, in that
>>>> case, when receiving multi-buffer XDP packet, we skip the XDP program
>>>> and return XDP_PASS. As a result, the packet is passed to normal network
>>>> stack which is an incorrect behavior.
>>> Why? AFAICS the multi-buffer mode depends on features negotiation, which
>>> is not controlled by the VM user.
>>>
>>> Let's suppose the user wants to attach an XDP program to do some per
>>> packet stats accounting. That suddenly would cause drop packets
>>> depending on conditions not controlled by the (guest) user. It looks
>>> wrong to me.
>> But currently, if a multi-buffer packet arrives, it will not go through
>> XDP program so it doesn't increase the stats but still goes to network
>> stack. So I think it's not a correct behavior.
> Sounds fair, but at a glance the normal XDP path seems to be trying to
> linearize the frame. Can we not try to flatten the frame here?
> If it's simply to long for the chunk size that's a frame length error,
> right?

Here we are in the zerocopy path, so the buffers for the frame to fill 
in are allocated from XDP socket's umem. And if the frame spans across 
multiple buffers then the total frame size is larger than the chunk 
size. Furthermore, we are in the zerocopy so we cannot linearize by 
allocating a large enough buffer to cover the whole frame then copy the 
frame data to it. That's not zerocopy anymore. Also, XDP socket zerocopy 
receive has assumption that the packet it receives must from the umem 
pool. AFAIK, the generic XDP path is for copy mode only.

Thanks,
Quang Minh.

