Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0610A1F
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351552; cv=none; b=hcU1PpndN/dLvQY+UfyVNWu8zXoFs+EFYV39xKn8qSicnTFkS86ERqnCkuyliOLxqSB6xZIys7tXz3VOvE+vuweaayDDOHeSThU5kZm/PJArDpZyHp3GDul/fvnsSLZfq/H1Hj4PJ+5ZOLMljA60mvcq+Q9hc1EL9JfEiCFkDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351552; c=relaxed/simple;
	bh=TsKpKK9AIx4BTd1yFG2C5c7DbVWMwacOB58VibFxJvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDSIfjlI8W4XQYM9WVJgU2Gsph4tfmC6x9y1dI6qXqVrmGKR5QWz/RiSbFpBoJw2Fg27bLrGqOKwJb6IhNKa3DWb18F2ZY6Vjz4XbaiSVP+KnWpfaMSXG3LrCdJde6ZcjOuFxXvuAS802Hs6riwVKkn4ZeP2a23mJyUxBQlxRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJdZRbCA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJdZRbCA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso53859935e9.2
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745351549; x=1745956349; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaJv2nPBZFqC9cL0CpWH1eeCNJ8QkWT+UyTio/7U2Qc=;
        b=WJdZRbCAj639Bd0FkzZQPEecMju4JeFkQaRNnUmnyYA8LeZZGbG/OZnc1n/X3ynqHB
         bXIrtWYkxFqg0hhFZNfepalA5TbwSR3FYn0K84j8NJtZvCoS8qFOEmxENWVlvJA4+5Jn
         3JV+K1jGeq/mBOlnv74BRX+gC39BWq5t3oxEuLTHm+i7ppoEVZmteM01Z3BaRr6OAcjX
         ge6fBoknhKmwP0CuMU4mO/rgKCQXI7myIL6tu1miZKje32mwhkMZaxL9g7sqc+4E6YXt
         epqBR2AOfBcGMmOxkonoEsYEGZhFkOFunzzpAajtgzM4HapvQtTWxaFUPtr9KthphYJ7
         E1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351549; x=1745956349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaJv2nPBZFqC9cL0CpWH1eeCNJ8QkWT+UyTio/7U2Qc=;
        b=DANS+qXLVWrY5+okEXLKK59BNpUM66ocdXVkKwA431KxO16tfcFhePNteYbcp+0/Zv
         IUV50Du7Su5PRGmIE96QbBrQyMeNuhx2K3YvRiVY76GuAjmO190mwomXYF9YUjF8bNOc
         3bskGa9zrJN4urnjHERt80qcQlpDCRWaD1DkjIf7XPmpyk/7Dwsp0LDJMCMq1xTYSYI0
         WtBBcqwZPZIG087UynkUU20QPgTzjGFKk2PpwOydOXFLPaD6N0+F5EmBHQXMFeuul2kf
         UdY7Lof6WVTzOZknu7ruQYInyDsdBnQ8KMGhz4k/Ti+o110LY2dLQiyfLNSbmYjLVjbk
         E6bw==
X-Forwarded-Encrypted: i=1; AJvYcCXYGzy5HJr+IgO4plvYezvOnzyYVBDd8tPNmtvM5+/z3xlpQOIygMK9brDxbGcTyxx/85p1DMLro68WUBkRiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPI/XtKzHpxlPt+Fmta8kALnO/rILHl7wggPkfqG3n4r1hLcw9
	BvBjtKtGac6dns7gQKZWxiykGt31DsGYy/6kvEH/uZMSQnvj/cIc6e2hHOwt
X-Gm-Gg: ASbGncsDiT2/sNQmfJPD96cakBm7nF4NU6J726LyU2qp7/U/XPTmrbexeBDy02YWNWZ
	U38e0H5IHn8Lp9g6Ma9CFVhN4l6omJDQ21largdPitLmsksnH0ICyTlqggwY1nRjk6WjCyT2UWo
	PMvfXTGiVyduEKrrb+iIFCwhAt5aqDery+XDEqAAkRCKOFzneYsXK3nDkmFV8Ck8L+CLXQyPJE+
	Qw6InaAlWJ7C4pQbnRP6yfdVedecunKo7hWdNxmryNzHXf0ucJlHKWTzk1Dqh8HawNNIxl7tfui
	Yv5+O/sO+h46Ojy7141XGC5aaCzsG66dDBxZkduEJ5WxEEwj
X-Google-Smtp-Source: AGHT+IEl6pg04k8aqg4kCSPz/epA7Jsgnzijdyhk9uUD8rpuhWFSBuVeC+Gc0wxgNurOByb1LeTItQ==
X-Received: by 2002:a05:600c:1914:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4406ab70701mr143149385e9.4.1745351548385;
        Tue, 22 Apr 2025 12:52:28 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.235.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6e034csm183795355e9.39.2025.04.22.12.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 12:52:27 -0700 (PDT)
Message-ID: <5d2f86ce-e2bb-406a-8d53-58a464958d2d@gmail.com>
Date: Tue, 22 Apr 2025 20:53:41 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, io-uring@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-2-almasrymina@google.com>
 <f7a96367-1bb0-4ed2-8fbf-af7558fccc20@gmail.com>
 <CAHS8izMFxDG5E07ZdqnDH_2D_g1fW8X0M7u3gGyV8efzxDNZbg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMFxDG5E07ZdqnDH_2D_g1fW8X0M7u3gGyV8efzxDNZbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/22/25 15:03, Mina Almasry wrote:
> On Tue, Apr 22, 2025 at 1:16 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 4/18/25 00:15, Mina Almasry wrote:
>>> Later patches in the series adds TX net_iovs where there is no pp
>>> associated, so we can't rely on niov->pp->mp_ops to tell what is the
>>> type of the net_iov.
>>
>> That's fine, but that needs a NULL pp check in io_uring as well,
>> specifically in io_zcrx_recv_frag().
>>
> 
> I think you mean this update in the code:
> 
> if (!niov->pp || niov->pp->mp_ops != &io_uring_pp_zc_ops ||
>      io_pp_to_ifq(niov->pp) != ifq)
> return -EFAULT;
> 
> Yes, thanks, will do.

That will work. I'm assuming that those pp-less niovs can
end up in the rx path. I think it was deemed not impossible,
right?

>> You can also move it to struct net_iov_area and check niov->owner->type
>> instead. It's a safer choice than aliasing with struct page, there is
>> no cost as you're loading ->owner anyway (e.g. for
>> net_iov_virtual_addr()), and it's better in terms of normalisation /
>> not unnecessary duplicating it, assuming we'll never have niovs of
>> different types bound to the same struct net_iov_area.
>>
> 
> Putting it in niov->owner->type is an alternative approach. I don't
> see a strong reason to go with one over the other. I'm thinking there
> will be fast code paths that want to know the type of the frag or skb> and don't need the owner, so it will be good to save loading another
> cacheline. We have more space in struct net_iov than we know what to
> do with anyway.

That's fine. I wouldn't say it's about space, we can grow net_iov
private bits beyond the pp fields in sturct page, but it's rather
about the mess from the aliasing page. The fact that it's net_iov
makes it better, but I'd rather avoid any additional aliasing
altogether.

-- 
Pavel Begunkov

