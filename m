Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2524887C
	for <virtualization@lists.linux.dev>; Tue, 10 Jun 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568722; cv=none; b=eHq6wFanDlPFkvMIJeplub4FAoG4BZsxOJI37YH0qbbxAQL5vjThMhjH+lGf5N7cPMRnkHH2w63sDsnK5SP6091iavPoLYJhv6sv7OynzjbYuM+svTu5pWMguk4izXkuhPFI9ybfF4Ujvit/tdpPJ1v8bNGUR9QqYO76/blDQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568722; c=relaxed/simple;
	bh=gOnIpi7jKT6E0yFvnngAH2TDUzwDY8Q0gWw1+BeaW+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7wvtCkfuqlHA6/hLyPpySVQDYJeXG74m/2n1ncKb+aa1YV18hQ+DVpIW8utnHFfwV/RwDrDuTqCxyKH32rG4XDtxfidOksv75X+PPeBMEO4xvRBPdrJFUwhe5znq+Qrx3oR/l2pqPImHv8MJEZuiSCwSy/56Ekdp2xc3K9kezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAwHRe23; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAwHRe23"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so4803877a91.0
        for <virtualization@lists.linux.dev>; Tue, 10 Jun 2025 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568720; x=1750173520; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hbx+bHktyO4/4VPvenmlBdgvye7zZKBy6tNsedw1riY=;
        b=dAwHRe23xLYVEPgJoEHffICwe4Rh4nxRa6K+yPwovo2zhbqHI0tOZStbTxtzTBHAjp
         iI1wdlxjnce4ZwQ8lQcDr5UEROar9/d+++HBEJJdp2R+huxPwv/S1zCwQULlIg91c5vL
         X1sP+bfctWX56pzgqgzpm1nCLEuzTAeRBnpQ6+4NQWw5jWlgpNHULzy1rYl+4dSaUBIj
         09K8AxYW9U3FxEh448qRgVaFl9NCly2YS9MtQzJIhn2Zv5E+ZucLJlHTY/A6E2pqaa8r
         X9fUoTI3mgkkFZGz012G4IrU+uOtIadH4qfBsYFZl0peav+yk2ZU+DlAlSRU//gvd8q6
         28dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568720; x=1750173520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hbx+bHktyO4/4VPvenmlBdgvye7zZKBy6tNsedw1riY=;
        b=gQJOmSVugfhd6D61D2zSp7wOcPgRn1f6Pytz4HmmVnn3RZBqWKbH/Z5FlmHACXX0Dc
         0Ra+gxILohBKBB29CQruBfOAq767KSRwceQQ1exP1QxvaJV290bbQTugJvVz27HHD+Au
         Y8BdQSA53ae+OXkoOOZ8TGPq5dou5dBaCYvgZ4+GA+HJ0dqVpnsKhsoWszVziQfkmr1M
         Xdmkp4RZrJyzQYdTfQrcqL6F95LJOa+RSPyMfbWFBEG1+tIv5tN/bPdA/yvWHFOKJ1sx
         Ey6xH+YuXHeneDqL4iIdW+C4uHn3sDA9voankrNk3BZqKHczcvyKAJs068OvK/TAxMrb
         XeNg==
X-Forwarded-Encrypted: i=1; AJvYcCXH6cMYdTsl2OV8RK8An2h04D1d26k7m5EcyYyWsbek4fp3hOVkzhv6AfZF4ep4OSYsTSEKxTio6nXFf7LryA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoF++0RGt5wZU4MQDSO3T9ELnYgPYmIAuCAUUHdSuaVmCzmaUa
	vh9oDZWVyZqVNntEtD5s94M6VTpa5NtJNDCZpNB1nHIjJhlp16hxjMmY
X-Gm-Gg: ASbGncs8RyFFP3ZMyxELkn+wNxyzGnhFW8ZNi4LeN2dciinYvPe5IT8Hn6VKiq2pa4k
	vT8HGJpOhnO3Kx2qp5iwre98ji9V8c6wVL+6+MwcZXlU7c+vzWLlftuJmRccGunG0j6UYwe3riz
	7ON5JvFL83tpK/r/2hLVyXdN3G2AY80qfbvzHZEPdH1/Jqn7E+dJMHFYWCfpXjIIhrzK6gzfQmK
	feidTF/S8+yMgUH11/trhxufSw+hYEJ4xeBRv0NtZVal5T1Qd8m7FlvZK5VCJH5mj3hodKdrR5u
	b4fMqsxHm7pFxm5bdUtHjp1OmV8mLh66qFkNaP07gTwg0ksSeXxfrSTLqIawBkyj555QjNugYuw
	BE17ZsIgIE/jDTFLlOjg9L7kGPevB/gX9mMuz34Z+
X-Google-Smtp-Source: AGHT+IFaLkJBXLMB5kRAXzQ6BTbGig21zU55qmOvpJ9RWPtjwP3TLdPuITWrEAgEHQ56jpCpm82CNQ==
X-Received: by 2002:a17:90a:dfd0:b0:30e:9b31:9495 with SMTP id 98e67ed59e1d1-3139e039a1dmr4917189a91.9.1749568720457;
        Tue, 10 Jun 2025 08:18:40 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:6df1:5935:37b2:fe6a? ([2001:ee0:4f0e:fb30:6df1:5935:37b2:fe6a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f17bd2sm7467484a91.5.2025.06.10.08.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 08:18:40 -0700 (PDT)
Message-ID: <e2de0cd8-6ee2-4dab-9d41-cfe5e85d796d@gmail.com>
Date: Tue, 10 Jun 2025 22:18:32 +0700
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
 <f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
 <20250609095824.414cffa1@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250609095824.414cffa1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:58, Jakub Kicinski wrote:
> On Fri, 6 Jun 2025 22:48:53 +0700 Bui Quang Minh wrote:
>>>> But currently, if a multi-buffer packet arrives, it will not go through
>>>> XDP program so it doesn't increase the stats but still goes to network
>>>> stack. So I think it's not a correct behavior.
>>> Sounds fair, but at a glance the normal XDP path seems to be trying to
>>> linearize the frame. Can we not try to flatten the frame here?
>>> If it's simply to long for the chunk size that's a frame length error,
>>> right?
>> Here we are in the zerocopy path, so the buffers for the frame to fill
>> in are allocated from XDP socket's umem. And if the frame spans across
>> multiple buffers then the total frame size is larger than the chunk
>> size.
> Is that always the case? Can the multi-buf not be due to header-data
> split of the incoming frame? (I'm not familiar with the virtio spec)

Ah, maybe I cause some confusion :) zerocopy here means zerocopy if the 
frame is redirected to XDP socket. In this zerocopy mode, XDP socket 
will provide buffers to virtio-net, the frame from vhost will be placed 
in those buffers. If the bind XDP program in virtio-net returns 
XDP_REDIRECT to that XDP socket, then the frame is zerocopy. In case 
XDP_PASS is returned, the frame's data is copied to newly created skb 
and the frame's buffer is returned to XDP socket. AFAIK, virtio-net has 
not supported header-data split yet.

>> Furthermore, we are in the zerocopy so we cannot linearize by
>> allocating a large enough buffer to cover the whole frame then copy the
>> frame data to it. That's not zerocopy anymore. Also, XDP socket zerocopy
>> receive has assumption that the packet it receives must from the umem
>> pool. AFAIK, the generic XDP path is for copy mode only.
> Generic XDP == do_xdp_generic(), here I think you mean the normal XDP
> patch in the virtio driver? If so then no, XDP is very much not
> expected to copy each frame before processing.

Yes, I mean generic XDP = do_xdp_generic(). I mean that we can linearize 
the frame if needed (like in netif_skb_check_for_xdp()) in copy mode for 
XDP socket but not in zerocopy mode.

>
> This is only slightly related to you patch but while we talk about
> multi-buf - in the netdev CI the test which sends ping while XDP
> multi-buf program is attached is really flaky :(
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-drv-hw&test=ping-py.ping-test-xdp-native-mb&ld-cases=1

metal-drv-hw means the NETIF is the real NIC, right?

Thanks,
Quang Minh.

