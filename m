Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9CE211A24
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992871; cv=none; b=AFbNXLkhBrLIe7gdZWl5I+zRx5AVEE0Wl0MH/SuuajvO8ILQpyPSAaNlXkmGBJ7/7VRaot10KzL7d/K6EsaBRHWXjIjSPi9wruCEdpm0JtKOMbD01FCrwQ7BiU/xXKVRhlDTINXGA5CRa16J4zoOFdwVK1dMYgm9XjkmcpR/PNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992871; c=relaxed/simple;
	bh=lBAsK4128QqAndyQK1xQuEI3avTd269+XLXJMVQegYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc9P0McQNemAAqhv0LC1esqGlzwC/agkRZTzXlu7eVsD1MF10N6aC6zgDoxI1BCEyBeddZwKaCjBf4rinYJslbIEQyfAcimz9l5Jkz8waJ3F74ecQiNGWS45uT1IwTDEgY1UZ135/V7GJyL68sfheInnngAS+F27G6dKjQgASmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ+um5Bz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ+um5Bz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso2641813a91.1
        for <virtualization@lists.linux.dev>; Sun, 06 Apr 2025 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743992869; x=1744597669; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMXI96KY1NlyfuaSnxUqUHlO9ydv3v+nJJ7C8/Y0/PY=;
        b=DZ+um5Bzv57+GzMoMVlkjE49csoHLwPuettaVHmhxbsrSVeJkuQd78K75zh8Kestdu
         GOpIHsCe8/4LM0T4SFFhYX6qLGirSzEj4pE0M7zYiWNFDmF8O5tdhBnfvCrkywUcZBTH
         /3oC5ax93ogX/muOAEFWAsXCmnuiEZ6r8f7xbpo7ctTmmX7kR6yzjgFo4wj3tlp+MLXZ
         SibLidJKDLUCmBoPe919721MmHneQ3QVU2gXKlANDSE3NCPYZzYC5YJhQXdQZXTQBWh9
         V0C+rglZZ/c2IcZDjv3TJPuTmnzSptcIK3kdDWDKSZYSPAvzz5MzUg4oBfTuKmHE5DtG
         T8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743992869; x=1744597669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMXI96KY1NlyfuaSnxUqUHlO9ydv3v+nJJ7C8/Y0/PY=;
        b=e9GitgQqEgAEc+4jgyn17KY6CHqX9HoWRppaANuFGpdqrCB/HrLkUhHSrAnIc4Nqkd
         w6cgH14eH9uctFmB64luA2VSXS0pcWj2aZohKfHHAc4Ls7hw0ICvJ0fPYxWIgKyMv6ME
         vnH6qSs8YFs5n+fJhp1IOHjOH+Yq4u/Sw6K5lGJzd2/wbCbUAm2biLC5Q/w/SsZheP8F
         1nPjl0J30F60C+zDSQjv5RtlLDhG8m8aZ6Zt+uDgmLwMugcg7GvNce5VPAL5ruZd9QIf
         HX5eA1/4seOFV6IO9IxT9BczeMMGLdVpGTE4lMLwvJ54FoyXVIhKRbzGro38YIqzvffd
         Hy3w==
X-Forwarded-Encrypted: i=1; AJvYcCV93wrY9YDaBlteeJnMw2uCRp/hrFoq9fVbJX49Dqq1bLZ7/fv7GMZXwVRDvB8G40dwiIMOP4uAoYXMVHveSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGja81Pvu8gJO5bjxqsQwX2OoTokoQ2YFeV0DyruzXhYzUtXPW
	k+swaU27Du0PZmz6F9pfpCn+ms1KxtzLlXytQxVM9rcI6+Qzu9Ga
X-Gm-Gg: ASbGncsUcocd19W/zrMvVJ2x/xjq2q10m9AuKZO26052fcrL7U7sKFttzz8q9vfOUq1
	RSer/J/OXbulbPQRqJ67tCev5VdYAgWsti8J4GwhwuQd90d6Bh3EYh/EwUxEMSTgNNDSM2zt5SE
	+5uKyERyQh67eyT9rIknVnHDOX9/4/kph5i5jkao2YuwmPDmfwd8QRy5RNnuM2uwjWq0JgEwsl3
	GUUtTF2Paue06+pa/7mVUR+AJkkLRWr+eapMNr9vcb0i62HfKHuDaiFfT8iozVyIwY8DVzm3Ve0
	xVdz37Z2SjO+Mq5csMd+pUkbv5GcU0btIYeyBkZuUHtmD7BbGgz7B99E7DOArvDYguHfD+BlG3D
	3Y+3UdiurKmepMYcWjqeWlyc=
X-Google-Smtp-Source: AGHT+IFLx8dLNxCZzv12MywXhBO0lTHHnKGTceaSSuaAjzKfGMQlupPZA3H1O36DYRXf2E9QaW3B+w==
X-Received: by 2002:a17:90b:2552:b0:305:5f32:d9f5 with SMTP id 98e67ed59e1d1-306a60eddc1mr15700652a91.7.1743992869012;
        Sun, 06 Apr 2025 19:27:49 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:cbc1:cad1:513d:e384? ([2001:ee0:4f0e:fb30:cbc1:cad1:513d:e384])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3058494aa8csm7608800a91.16.2025.04.06.19.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 19:27:48 -0700 (PDT)
Message-ID: <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
Date: Mon, 7 Apr 2025 09:27:41 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 08:03, Xuan Zhuo wrote:
> On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>> napi_disable() on the receive queue's napi. In delayed refill_work, it
>> also calls napi_disable() on the receive queue's napi. This can leads to
>> deadlock when napi_disable() is called on an already disabled napi. This
>> scenario can be reproducible by binding a XDP socket to virtio-net
>> interface without setting up the fill ring. As a result, try_fill_recv
>> will fail until the fill ring is set up and refill_work is scheduled.
>
> So, what is the problem? The refill_work is waiting? As I know, that thread
> will sleep some time, so the cpu can do other work.

When napi_disable is called on an already disabled napi, it will sleep 
in napi_disable_locked while still holding the netdev_lock. As a result, 
later napi_enable gets stuck too as it cannot acquire the netdev_lock. 
This leads to refill_work and the pause-then-resume tx are stuck altogether.

Thanks,
Quang Minh.
