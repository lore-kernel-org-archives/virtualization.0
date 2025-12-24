Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C18233D88
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595009; cv=none; b=B4ghYPvG4ukCEVp/2kYD6g8Y2oJgsitmD5bkboTHQGRgylaDQ+Jpef1xX+J2ZKrA0W5PYaQVEGeRWztUtZ5oFtMjx7X9AQeS846tdnsxZ4sVn7QkrN+F7SUUnEnh4xtplYhORxS5Ls8Ev/zumxCFtNasAbQWYNWIlwOe+2SrWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595009; c=relaxed/simple;
	bh=pD8YfDZ8KDvIJ2txTMDBnlCOh6vlZTyz6vhh+e8d2W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uePpeaSjSneWguKg5MuSwXaLNptdRQZaAbaBvKuozfeubt0Rajg8bMdzXIKItbflj6wmN2W0oVlVrxStB4xT8FaRFYEaw7YwR+PNjE3gsblY2mBhcHmH3qNO7Tv6UbX2hhGxwUrAB1cJYNHmZvd3TuORMwgNm9RttWsl74F5WUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFJAOWoK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFJAOWoK"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so4889236a91.1
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766595007; x=1767199807; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnHqqpgJDbRv/a/D7gH1Mi4jXPMVJ5IBYITwv6FaifY=;
        b=cFJAOWoKJzyHjPLd4fATyS/oGgKbw4MSN6AdQ1/Sz445aqVnm0CCHHp0loOzAo3bYZ
         +bdEMdxoAYbH04xJYAqVnT28vX+z1jOyBcEeEIFPADH79Jd28GaGxKe7Q2TOaxkmXn2T
         FCsPgaO9/hGCU7O62l4sOGqzJwLeN1Dh1PMvlFNtZU8tignxQCseJ4Dx8WF3VwPf1Ds5
         H83dsr8qkr8pzeWq2aD2q5IEgG84Achu6UcIc1zdrAYjisixoVW4jEdQvefjyYRl9zC6
         n16MmAUL9Lbjs35xhB0mBklsQ7NG4HZBWURHQkCNlfJXI2Q/70roir5rInsz/e6XGmD+
         juRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766595007; x=1767199807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnHqqpgJDbRv/a/D7gH1Mi4jXPMVJ5IBYITwv6FaifY=;
        b=Lq910ojZ6NH1ywNe0BoI76q4VP9CwjB8kjDuj7qGvQjBePEmN6qk43d7QJfhiOWoIp
         wcLhnScGCNXKvLAq3rNKjZkMjtRMcsfHHMGyEr7q/jCqBZfgX0e8GtpiEI4SX2K23G6N
         qTybmsNa6XNktlQ5UmeFeyXou3fw7LVOU27wzPBU0OwKV0GawlV/AmER3RcDUPg7TOk5
         lWBY+pu7PWczW+M2Wv6KxpoMlBFJ6Mn4fSJd9L98/LiaQGrQLqdED66/z7ZVohUX0mSo
         cuJWuXrI/GB4pksjJDgDVvvFixEIqVTUXxlUL707GB6Oqhmet2B7NkjRqNS0JQWlFFfg
         X3JQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1/5QZmkykHHx06I0IQsIT731pa1kOiJXK9ppJTTLL9MEhjkcRlLASYYiIKPWlj/hGwuVrQlc5hVxNBYA3oQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrJWtMAuVMwT4HuOErLBXU7aJQQANLBulwWiHWyLfA0qAPg3C2
	A5HNCo65e+zS0rOsP/ulWuQ79WKsNJF542czmW+jOhc3uBhrj8nZRhA40ybUjnWG
X-Gm-Gg: AY/fxX7W7H2Kp3pRhbQqHY5/YLUuUY7f8EnqyiKVF45o69LSf9bAQ8zwXtDzlxqHN1t
	UsPHTzCwhVHaxxtbim3e+svJ4Vwi4OzobGP04hVRTr5vHO2Iaoc6FBp8ybohq4HQsTv8xAcYlPh
	0KXwaApyktpis7srPyx+K4KgBkMfT4ALltETNjMgJbrnZ/VIf9nL51wf7O1ZthoXFKSft0eFT2w
	+7Mfdg+TLjDjwVbLFXPZrI1r5XtyhRKk2NisdxjnYVVdc66vY7ICrV7N89ze7Tsnlc09g7so92n
	/u81k9SZJZUYjfXN5ZF26idQprs9pp/5bvxsxvE7mVEiQ1EVPFILpwJXwhA0RTCcAsPkWJ1Cwml
	v48Q5F9nQKwRlElSl8gk0Zunhk8Xqbs818aWOVR6G3+TGO+pVLsJTCvO8kK68lYtxg/GlugaTnU
	GxIUjigFf5yN9WS8I8/zxkOs4yS5x5bqlz3wRGg/ZsAIqE8DnXWCXT5nAHioAmiFZRO7x59Q==
X-Google-Smtp-Source: AGHT+IFbzQ7yMQch0JLVgEhdJ9FTN364+UnyPdio+VpjXb21RfQOByyL0xWkrHKOy6iC60/tY4/H+A==
X-Received: by 2002:a17:90b:580e:b0:340:d511:e164 with SMTP id 98e67ed59e1d1-34e921ae4camr14319741a91.19.1766595007324;
        Wed, 24 Dec 2025 08:50:07 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f26asm17027776b3a.52.2025.12.24.08.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 08:50:05 -0800 (PST)
Message-ID: <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Date: Wed, 24 Dec 2025 23:49:59 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251223204555-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 08:47, Michael S. Tsirkin wrote:
> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>> Hi Jason,
>>
>> I'm wondering why we even need this refill work. Why not simply let NAPI retry
>> the refill on its next run if the refill fails? That would seem much simpler.
>> This refill work complicates maintenance and often introduces a lot of
>> concurrency issues and races.
>>
>> Thanks.
> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>
> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
>
> Not saying refill work is a great hack, but that is the reason for it.

In case no allocated received buffer and NAPI refill fails, the host 
will not send any packets. If there is no busy polling loop either, the 
RX will be stuck. That's also the reason why we need refill work. Is it 
correct?

Thanks,
Quang Minh.


