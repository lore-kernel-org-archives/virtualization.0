Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EDF4156CC;
	Thu, 23 Jul 2026 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844143; cv=none; b=OX/k5yQVufP9751L3jQh1lBVsRQdh/HIJpCa4GRJ71k265uSqmgGHB1dlRhKpzkYcrwFnez39I69/2YcMk3oXyUUnMaQct8yAq0IE/sMw1/L5ki9uavkvFhEOh9nK1yC0oBJZXFx2ms6A+UDqQDrLh8hox3cih64v1Gbjh7eUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844143; c=relaxed/simple;
	bh=yTKD2ylMSXMS8V5nkF1x7X7ZzJuSNZ0OcYC+Nxo8WOM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g6V2dTQrSubCOk63cxyA5sP5RqcUcNiW/xEtjPY4iOflzp+iNRRIWthYz191BYZTrPKokjmzhpsqmXmVvZQOG7NNKfHnePz50KVIij/zanzQhsdOUbDGNMF0Kn0TQ4q6tZHOifoT5AEf19pmzX/OfNyhHQviRbDsgcT7LTq7afw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ecsbMeCE; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ecsbMeCE"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wn1CV-008XUy-IY; Thu, 23 Jul 2026 23:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=T8152CiV8EwT62bqqcPesc6eI+p812MzTD8kzmluCSs=; b=ecsbMeCE6TqrPmgQ1BaLolesB/
	9E80FoXtvEoszlyJYdAGXl/04gVMxwqM5HsnPFfDk6Pqwqr61vwX7apkc8pUYJNPIiJw6mvNvHFTm
	6m5UN9nq69bS2fZw3Dz/+lsqaUafsAAylNV7t8sez2cHOCdN5dEcPVn03e35xdrZBO/ZSYJgSeeiQ
	6i83sa9+6Yo1qT+PQXgp/wnfDbKXrMyHlmok+M0WXWpjBJ0iHTcumz31Al3wwtHNDvYkQfLvgh666
	LVZF/JI8Tj8fmcYB6/h9LfwLdkxY3m5MWcHJPeG+hOYcEwcLB7dlnbiFG9z/KT3gSPASTnsELum0u
	NR+VZGGw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wn1CU-0001U9-Th; Thu, 23 Jul 2026 23:43:31 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wn1CO-0078xw-Br;
	Thu, 23 Jul 2026 23:43:24 +0200
Message-ID: <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
Date: Thu, 23 Jul 2026 23:43:23 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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
Content-Language: pl-PL, en-GB
In-Reply-To: <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>> ...
>>>>> Yeah, we need to handle that part better, I think it's a leftover when
>>>>> we generalized AF_VSOCK to support more transport than vmci.
>>>
>>> Speaking of leftovers, I have trouble understanding where does vsock set
>>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept() 
>>> checks for it?
>>
>> I can't also see where it can be set TBH. Should we remove it ?
> 
> I couldn't find it for listener side too.

Removing sk_err handling from vsock_accept() solves the problem, right?

thanks,
Michal
