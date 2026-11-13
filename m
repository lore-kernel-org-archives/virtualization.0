Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583186;
	b=gdMjRWURu9et0CHtkzn3jKXStxCXUuMHuU0nPB4qQpDKLMzPP7qiRsg9w6Ps3w3N07s5
	 B6cwn+G5XN3nMseoK58pxvoIv+tYzLR/FZPBlKxmjX5BbQoLawP3LvDZGETaQ/DLc9Za/
	 PUKtXqBRGOh4lUQZtcDYIUDpED7L/2lT4HwICC5wMwPokzeoZ46WqBtq/Z8T1O5eOQEQV
	 2lry4LnFKHt6qy0H4wRa/O8qP8bN2EbpgbR+PJapHIrWrVKYmzVvyTWI/udS3i8dOCWSo
	 sTchRyLTtfGqIn1bEed7gXnAGtsegW4VFBgp8iA8yrZ56YL3eo7s14VL6WgOhISqs0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583186;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=juFDnmO5EDRtsSCXIUiqwlHbuc6Wxn7oOfpk1FDCS/0=;
	b=FQaL7DN2qcIzy3zbVj1j2QQrE6FuAjzXSM/3s4K5HbiNO6w6qW+Opr/rlCzv6g32T9bW
	 JaSogm+mkPbribj9TvtDF9qWeqUzFaoizgCZYErNCY+GXCP+CzA7oLYckuJn6PG9Uf0AP
	 LgW1xJAS3hmKIGO4EfjbulHl/FvERBbrnzjJ3LhgDLZb8/z1wE+GitO7nq3JPURsB8Dr+
	 Ko+GzWVMTFTvnKmwgBhF9lWDXXyMzCHfXytaNG1awPu38r55Itka+Q/c6UXde2j0CDC4s
	 VEGeHGOslVCfbg/RBlYMI6jIjicOp3iZAMIk+okTU+VA0TRcorxAlOdy1jZSa8HTlWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=rK7OT7NJ;
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B9606A32E
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 15:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A0B9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=rK7OT7NJ
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jR1Bv2VW0zNls7;
	Fri, 13 Nov 2026 16:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794583175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juFDnmO5EDRtsSCXIUiqwlHbuc6Wxn7oOfpk1FDCS/0=;
	b=rK7OT7NJBGMGnT65DfgAikqlPWKvwgStjKE6a9/DJJ2z2QZf0EFYeOsoERKR26t7ZtNIf5
	h5lxgs4bytdcFtqLDqN72nRKWLN0yUIMdVQQoNIU/qJiFUcd/d7/01kb4t1JlhXoiveCNl
	0KcVayUcQYK4WO/RY8s1dF1EokmufpGPFcelcoB/tZheZ8hA4ASi7u4RssehtoOPbH0gh+
	B61CwCKURSlaPR5Wedd41nsgD5AlFwinINU7viB6zA6yKXYuh7fwy5QKIcDXfH/RIyybmP
	+fNK+cJzNMr0OCagPFxl4uTYNmAeJZNg3tqtro59m+UjMaF+vMaoGnrTH2fZWA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <9afd9031-9a66-4c13-b1a2-e1da62ef5e69@mandelbit.com>
Date: Fri, 13 Nov 2026 16:19:32 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] selftests: net: add a vhost-net test for the
 tun NAPI queue bound
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, jasowangio@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maheshb@google.com, peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
References: <20261111014208.1795777-1-antonio@mandelbit.com>
 <20261111014208.1795777-3-antonio@mandelbit.com>
 <willemdebruijn.kernel.1220f3b31f685@gmail.com>
 <73aa2f53-e2ba-42b7-9712-06e223459144@mandelbit.com>
 <willemdebruijn.kernel.14b320acee076@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <willemdebruijn.kernel.14b320acee076@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jR1Bv2VW0zNls7

On 13/11/2026 16:07, Willem de Bruijn wrote:
>>> That's a lot of code for a fairly narrow test.
>>>
>>> Not that long ago I would have applauded all test coverage we can get.
>>> But now that LLMs generate them instantly, not sure where to draw the
>>> line.
>>
>> Well, the test has already done its job because it immediately helped me
>> fix some small itches in patch 1.
>>
>> This said, I can definitely shrink this test a bit, maybe around 50% of
>> the current code. But it'll still be quite some code for a small fix.
>>
>> Should I just drop this patch?
>>
>> Alternatively, I drop it from this series and I send the shrunk-down
>> version with the wrapper script to net-next later on.
>>
>>
>> Opinions?
> 
> If you could compress it to about 50%, let's merge.
> 
> Maybe we can use it over time for more coverage in this area.

Ok, I'll see what I can do and I'll send v6 including a compressed test.

Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

