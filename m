Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA333377A87
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878469; cv=none; b=CSutyUWwOdJDz6iRXRncKXwV/CpuATlNtJdqFlSu9Clqv4w3HC5QuSVT6+no+k9OaEzr6pzO4nNFH4qbvyXAOModoZ0zE2eTU7U61KCN3LJaQc+k12W85ATl8Cc3LxUO97t+WWzOZOzuungrwIqV76UJH+byHLGmlpfSnO0kWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878469; c=relaxed/simple;
	bh=vXpRSWi/oVCMquWL7cTrWQgG+Q6PVnMDhgoEilSgEXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDWHnVAfLb3ArmSzqn4LmdxHgZUIODAxxPKhmQ8o62c0GNlXWQ3dtgBTLU0+HRRs2yANpbkqpG24hsq+f3KI62UL9w+2WomhHV9cBE+8rjEKDKXROIorzKjiuPG7ENtbozfGzkNtv9EwVjzmcMbvkzJBt62XKlx2MgnKQjFp6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtzViVZs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtzViVZs"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad4170e8eso2133515ad.3
        for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784878467; x=1785483267; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LzKJmUsJl3t+t7LREmJa3ZK6twh8h3ZLCQyYGIQu7w=;
        b=NtzViVZs5adX/L6xQjMgTdtlggQeJZFmH9adv1MbF2Cd3ECxBN3r7MaA80S+X6lN2N
         ffykPqkMQOI1S9WDVhUijUaqudgBYGNzFWDKSnq62EsVTPtagYHsPgNpzyYMmK/BjkEb
         iemYMmw6AMAKV4Gtj/UCjQY4NweNgilBPVx2CN0Fg0YfXC5CsmyH4j+GtCkMpNvyKciv
         ZBC9s0yFIajcCPCwL4f/UnfM1iEkWg6OzkyMMLov9P17HrVbuwc1B4xqbqI2Ib1aX7Fc
         rzzksUQD4Vz6WDRhgAfCm3RKSEz2ouLFUVuj6l769Ze0aoUhcpsow+X26pLM2s78rPtO
         TaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784878467; x=1785483267;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LzKJmUsJl3t+t7LREmJa3ZK6twh8h3ZLCQyYGIQu7w=;
        b=imgagdhgCPB252hwav0MVY1ER63TzedEs6GGfOISAucljGJqklk6K4K1E8Od4I7fOB
         xoPIEnFl2fK05+0bgjPBb2c/wwEqWWaxzldgJm7sCLx2+xXgeFl6cBEijagts7LoBwQr
         5Fd5Dvple0Sd3gOc88OzJQ/aKKPr+B4uFugIcAzsipGcCAz75s0nAO1q1roT+CaWAw5E
         ehKQMeGKx6x76xC+lFLNN6xIS3Yw0ZEs+XLE7hSBWR2ZkDnQzyo0wqbOGnG+aouMQReb
         /G/ABGNjWb2CFZ8ixiTgyLByAViuveDbkCt/b7wpc6LmwW3Rm+ZVWl3n/V0SMxuW4TY9
         MLCQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3GrQt5h3z/GSTbIk14VmgKzxByuR6KbgExlxQskHk3+9dvtGt3iCM/dxDL4E1ChR0fUnxuBowGE9iYmclSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn7FwppWSyBb7m0Fc92YkQU4l5SaTdvxrHeH3YQt0l2gMrqETo
	UWpvTCA7WRo+GIgSf/AS6L8Z8BELee35BoSOUklsR4DBgcE9zEfC8v08
X-Gm-Gg: AR+sD129gVD6x2DFrDXfzPq2Wn1QJHUhJjuGFyVnYB+2tIWJRM2UmEWJ/OxqZQGcwvX
	KUUK+aZ9yHqIowm1wKgUEeDQSQ5jLhQPSazVABW+XkLNkWtPM7uwXpyOjGQkQJZI9TRaOQtsBNd
	1K+ltP/4Iob2dgD2PzNoK1QScvsxYQ0/fNgY57omDWvlYpnRNFtEOPYBE8ocPt9a0H/voK/PYMy
	uUUcLzYl6lWaKk8zpslaaSxBfyiqBN7OtvvDp5yKsyqqfG9m9iikBVxEKjdE4RmAsLUdeTxK+Zn
	7dP9XpzeGF04qhhdpGQQcP4VQ2cljgLen/KzrVLGmXe42nJiSo2ShhGkj6JNVdN1MA7QlbnQIQR
	IbYKAJmAycKVp0B/mdbznQ5CzB3ikMaJd5rJ5DcnKCk5y5LWnH1CROCvoj58hAZQQs1hm/PO7FY
	e2qJtM9CcdyTlGWUUNc5g=
X-Received: by 2002:a17:903:468e:b0:2c9:fbde:ab66 with SMTP id d9443c01a7336-2cfa6c72079mr71784215ad.37.1784878467184;
        Fri, 24 Jul 2026 00:34:27 -0700 (PDT)
Received: from [10.22.76.22] ([111.223.92.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa39ddsm46944805ad.17.2026.07.24.00.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 00:34:26 -0700 (PDT)
Message-ID: <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
Date: Fri, 24 Jul 2026 15:34:23 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Content-Language: en-GB
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/7/26 05:43, Michal Luczaj wrote:
> On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>> ...
>>>>>> Yeah, we need to handle that part better, I think it's a leftover when
>>>>>> we generalized AF_VSOCK to support more transport than vmci.
>>>>
>>>> Speaking of leftovers, I have trouble understanding where does vsock set
>>>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>> checks for it?
>>>
>>> I can't also see where it can be set TBH. Should we remove it ?
>>
>> I couldn't find it for listener side too.
> 
> Removing sk_err handling from vsock_accept() solves the problem, right?
> 
> thanks,
> Michal

Yes, confirmed, removing sk_err checks from vsock_accept() does solve 
the problem.

Thanks,
Phi
