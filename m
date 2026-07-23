Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052633911CE
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795059; cv=none; b=RibsV/edtjvFlX0tfmnqy07JHntLQj+X/D0qkrbMxHbD3c/aehu0+U00hNcBz5Ze3T9F122n8lsYBtxG54+VRf5VFZ3NaMZJbc6YxW5GOFk5Zh0G/kd+IYpgbjtjPCtsObT5gpZNuNZ5iWrNrcDRmvyJQgqUxHED79Y6lCtYflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795059; c=relaxed/simple;
	bh=0rqfheA5EIXH0AMcWpDhTeseyxtr6Y8S9xKkiNg2LoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rdmkXaFZCmij6x53xIlTL0OIN039ak8/ghDQI0wM/DUvoC6AgeGKo4WTlSuMqCziieduHHVCPisI6TP0cDgxX7uNwK36nXFIwPAT9qGlW9tYbjY1nsewK/TX5rr3uVDmAyT/njPD+wB2Zsve+W8U/sL49Tgmy4p9gH5S4fLF6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3RHgqii; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3RHgqii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784795055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7H6Kr57Rfp4anc7zWKfgtlCWOPHxbgtuQqU6WGrAM4=;
	b=P3RHgqiiNfv5tbgRJX4dr6Espn7B0ejdFskGC7vmMFaPPa4GGD/aZv6BgcrxMDmgAc4wgT
	FAhXpTnd5fOPUCMvK4sz2PSlEg7/YuXTmBgi93lscKLsAAoVtx4bz0oGMlOMYIIiNvQSdX
	whTG1CNQaI9BmL04JolsEgOcxCej7Io=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-v_kZnLvRPP-27S7CTAuiRA-1; Thu, 23 Jul 2026 04:24:14 -0400
X-MC-Unique: v_kZnLvRPP-27S7CTAuiRA-1
X-Mimecast-MFC-AGG-ID: v_kZnLvRPP-27S7CTAuiRA_1784795053
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49560dddaa4so2299075e9.3
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 01:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795053; x=1785399853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c7H6Kr57Rfp4anc7zWKfgtlCWOPHxbgtuQqU6WGrAM4=;
        b=JVk0U1dH90vvtpHzZoJY0R0b7M3A06sl6OzObzt1vpxrCmvgqQa2mzQ2S6VYYH3znM
         +ayvJh5ry5UTLwIjBLwET9+xTdi8Jb43NxO+mONB6EZxmQ7d5MlGtIDKRx/yo4swz+hJ
         sieF3AjOXpeSRrRI+wucl2Tls6zkPBq/lzsfQJQurZyi9Ryn84c8dEW7Pkc9/4qbaC0S
         8Dwj49TZbfAEWWSTNceJsAIIQZefM+XAx0nhFF9e5rn25Hxs/4wSpSLcRT7O/MxnBjb/
         0cwsNyMPTStykOjnvgZqm6siD1fHMdxhcuVBo8ypk4p5BgI35wjYCeKRz+Ns+Sebzbmj
         a/cQ==
X-Forwarded-Encrypted: i=1; AHgh+RoiO69uEBXZpwxtH4940Bf6l7Hw+Bwmmh6Nx/bVa7AQmG7n5AoTnxKiQ+Tlq3KqYUf8ahxhtSWkH7moOHZIqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuH5wfZKwNqFOOYqfsH0bF3YTA8QCopu22gbVJt5DSx9ziW4NU
	7JrY6ijKzxTgUYfaL2UP6TGwJ3KDgvb3eIq7hEQzAon/y4W0E+1+GadLwd4bu+/RufZ4Qzrb3IU
	9dmMgll8YpDZlH9IQJtc+kAmwDigabr4npyj5+7awVEFbTheqjO83O1J2fSOD1UuHAt0K
X-Gm-Gg: AR+sD12fHCawZOfz0jaE5t3U4u0R3F7sj798ekIEVVzNMm6ubYT3/IOJH9JycMbOyYi
	RryWl1JUeg0+F8bmS2eVufnXaN0yxaEMWxJgd4EkGE2Jq445xL5Ta5uF62Y/2hmlxzl5QtLhGga
	eTIlWTxxYt720ouxdWXaLYGChwL1Hs0tmsieAh6rqJvjCuK5F3TNM3KzSYRWtEJ3IX68l1Gq5C5
	bGullBBKYPdLk/O2WSgVC3FXZ+8LJYNOqEXmRmSvP9MnCRLfE6w2zMOuia5Bv//C0MtnQLzk9zN
	TWZOeOPhYvNWWN+Zy5znKaC2/it/65841gtnoCP7YGdRoimqj4ZGl9TIhwkr4MeSRU4y1puvQ6z
	dARTnbWJjfcLnAj5Fwl7GY++TWq6FMv6iiyltf/4OrK94PuxMpQ==
X-Received: by 2002:a05:600c:1c1b:b0:493:bfad:9d99 with SMTP id 5b1f17b1804b1-49573c9af25mr21718145e9.13.1784795053107;
        Thu, 23 Jul 2026 01:24:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1b:b0:493:bfad:9d99 with SMTP id 5b1f17b1804b1-49573c9af25mr21717795e9.13.1784795052528;
        Thu, 23 Jul 2026 01:24:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653731b2sm208346055e9.4.2026.07.23.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:24:11 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:24:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <amHN9mOGj7oMak4-@sgarzare-redhat>
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ra2ivtKyMuSuZlQ9ugfiBop2NHpAFcLaPFnXmsOImBc_1784795053
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 23, 2026 at 08:00:31AM +0200, Michal Luczaj wrote:
>On 7/23/26 06:14, Nguyen Dinh Phi [SG] wrote:
>> On 22/7/26 15:55, Stefano Garzarella wrote:
>>> On Tue, Jul 21, 2026 at 01:34:03AM +0800, Phi Nguyen wrote:
>>>> On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
>>>>> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>>>>>> After vsock_connect() exits the wait loop due to sk->sk_err being
>>>>>> set, the error was read but not cleared. This left sk->sk_err set
>>>>>> for subsequent operations.
>>>>>
>>>>> So, is this a fix? If yes, we should put a Fixes tag.
>>>>>
>>>>> Also, can you describe how to trigger the issue?
>>>>>
>>>>> Because I see this in vsock_connect(), so I thought it was in some
>>>>> way already handled:
>>>>>
>>>>>         /* sk_err might have been set as a result of an earlier
>>>>>          * (failed) connect attempt.
>>>>>          */
>>>>>         sk->sk_err = 0;
>>>>>
>>>> This only handles the case where the function following the failed
>>>> connect is another connect() call.
>>>
>>> So, can we remove that with this patch, or better to leave as defensive
>>> action?
>>>
>>
>> I prefer to keep it here as defensive action
>
>Is changing how vsock_poll() behaves intended?

Good point, but IIUC __inet_stream_connect() is also using consuming the 
error with sock_error().

>
>I.e. if sk_err should be kept after a failed connect(), what about
>`sk->sk_err = 0;` in vsock_listen() instead?

Yeah, maybe this is a bit less invasive.

>
>>> ...
>>> Yeah, we need to handle that part better, I think it's a leftover when
>>> we generalized AF_VSOCK to support more transport than vmci.
>
>Speaking of leftovers, I have trouble understanding where does vsock set
>sk_err on listener sockets anyway. If it doesn't, why vsock_accept() checks
>for it?

I can't also see where it can be set TBH. Should we remove it ?

Thanks,
Stefano

