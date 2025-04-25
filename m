Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A66FC5
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554872; cv=none; b=jN8seQtRSYWhI3XoNYXS0ywZmLFvYQQs3dzi572GAnap6iwP+zheMo9+iD2UeclDnT4SwTjl6rs02nakFzx963q2CFXWjcoZfVVcS1dBu3Om16Sxvg17VVon6cyZzYGCik47/iRQx1VS135FGqAcxKuTs4xV5TjrnLZBtuU3wMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554872; c=relaxed/simple;
	bh=+yaWzT6r4JMRJQXV6x1vvZyp88WGrpRvUaCULB0Q3qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgQAo9ormXB9g0p+IFFVfebaPnsEbTLsqIEO6xsFclBo6IiDb9EJmMyP11bxorKVy1X+lMUxwzLF5hwqYkg9XXh+GscHn3VfY/BILWLMaGyQpERJJK3pRGuuYxzQB7xeFAZpn0DaCkN9Cn+HhWc0pIEEo9mCJMzLg9TXC6tyscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAmHNscg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAmHNscg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240b4de12bso27881885ad.2
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 21:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745554870; x=1746159670; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yaWzT6r4JMRJQXV6x1vvZyp88WGrpRvUaCULB0Q3qA=;
        b=RAmHNscg5AMHOxQANu7TNyEx3V5WhwduHH90wD/9UGCVVhRAYUTeEqZIHwtHdMUIw+
         jVUkxmch+DM2PQ3/B8jm/AnYZs2MqYWhCIW+sn7JZgArrSunH6PKPZxHWW/EzXoV2s3P
         SF4jqGwsknppe0741JLLtOgppOuRM/CAHZcvokFmclSjPQ1LQ3LBYzeFEDL5noxWWDj0
         OU6390cGhE09NGT2QNOkrD8Wxb4NiKJ/nrhdlzdLTiZf3SoS56Owk0U5FhGDA2l1tXP6
         2Nz1oXztKYysC1RKSqjelIVSn1FsovYpn83s2N2cheAQasMMFBpb4lLibTMpmz7ivwnG
         wVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745554870; x=1746159670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yaWzT6r4JMRJQXV6x1vvZyp88WGrpRvUaCULB0Q3qA=;
        b=aLOXzPeTiApI4rIBC+B9Q/C+u3u/e3ckgshlL57LZjvoO7L+MfY+HP8QOALBXy0VKb
         cQVMGjhujFAhNwWLYDELlNlkcQmi4mHgT6+LnF9TSONNoATt/MNCP6lFHBLvykW0gGfb
         TNaJfTO6PVOZtui6xHljMYzYS/iM2Of/Gyrcz9rSoe9B6lwFk5W9qIFgjMYtU+MAky9K
         d8Sr5N2TH8x9tTmvOt7gFQvYuzuxXzXPbHv9LecdRjAgWw4OtLexSqRp3/++8cZ6+DZC
         K3wFUW7nFz5/JNrCO79Bt5CQIxCL48kNJFVSgXTzNcebZnkWc1Myhsgzjss6a41i14mB
         NWCQ==
X-Gm-Message-State: AOJu0YzBIBkS7mBxyT8rOugezJiKLajqGM6MrfE0Ym3YIMFN+b2N7hfl
	tNQY4n84pq2yowGGl1AXit2KsuYgIPmU3SfpkWupk5vndvg0ekHU
X-Gm-Gg: ASbGncv71v4r1iRrqObJdiZNroRbMfbscVy4va9okp9bOlQp7kthg8RPaPZ/w3lmvi+
	hiMzznOw3BzgthccG9j3RB/Hs9k2CnToouVVyEDPW9E/YHSmSuhKrWVoj4nNsoxJddRbVLVL6dK
	m47Pnif5gi5XHYHks3d7Tknk5jI2K4+yrGs7cpIKk139pX8gnuQaX9SvR43n236GwepaM4nBC1x
	T1IG7uJX5+HnjBR7mMFpK/8YZ4Cf1nBpg8Q8w4e3vjDSRKzjKkHnukx1SO8CicWRRmdr4BoKYUz
	D3Lq00F2WgFHwUhhi8LTLk5jHDvSrRRHttydxUxhir2/G0mFIpufgCZdMjUxMF3SOkfxCCQOfgp
	6GhSrBIWE+a+tEbDse7k=
X-Google-Smtp-Source: AGHT+IGWLbMKf5sYtW4rSiMV38NKZyqcmVeq1HvhSCzBrf7T/vSTtn9Z0BU/6O41NwkpiLMa+8jRAQ==
X-Received: by 2002:a17:903:fa6:b0:22d:b305:e082 with SMTP id d9443c01a7336-22dbf640a4emr13120665ad.47.1745554869899;
        Thu, 24 Apr 2025 21:21:09 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:ed97:ee93:42a1:7559? ([2001:ee0:4f0e:fb30:ed97:ee93:42a1:7559])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5103259sm22367705ad.185.2025.04.24.21.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 21:21:09 -0700 (PDT)
Message-ID: <099f2537-e756-4608-ab28-d7702b9c1436@gmail.com>
Date: Fri, 25 Apr 2025 11:21:01 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] virtio-net: disable delayed refill when pausing rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
 <20250424183450.28f5d5fb@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250424183450.28f5d5fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/25 08:34, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 17:47:13 +0700 Bui Quang Minh wrote:
>> This only includes the selftest for virtio-net deadlock bug. The fix
>> commit has been applied already.
> This conflicts with Joe's series slightly:
> https://lore.kernel.org/all/20250424002746.16891-1-jdamato@fastly.com/
> Could you rebase on latest net-next and perhaps follow the comment
> I left on v4 ?

Sure, I'll do it. Thanks for your review :)

Quang Minh.
