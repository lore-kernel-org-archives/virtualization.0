Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B545FFA6
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343922; cv=none; b=bkbdtDfjlWKlJRyMnZTi9B05ssDA6Q9n0M8WZ38VUwXtQsc5SjXgVK/Yavgfq/WPrUuplYxkPc0Yyhklaidfdun3KuiFfcbPwPeSInX6BFdYPgxGe2eblhJSHwmv2KtTSKvyQkB19nZi+aDlbVNgfBYYV1geL6Bl4eFwoBLYPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343922; c=relaxed/simple;
	bh=0ZcKYC6CqCOE778Klu3EdkP+RTdCnMbliRZDv81Ibc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izjKz0NrEfvb9qktHvp7O6KT+wnMrPKxQxyhHovb/y8c8LGEzvJIszLEt/7FPSFCbJoZ+hu1UYVo/XpCwWbNS1h1rZfzS2Lj7ciTwa+JJCsGLLXO3m+GNA5FbBLyEJ21uXIQtKMNIJqKQYcTfMrUkS7QGlNsBVKmS3XEfQ5gRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlUwnh4u; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlUwnh4u"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84ea0ded155so125730b3a.2
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785343921; x=1785948721; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynliW8RV51DVn6/Hi9bIDwJycFbIH0QxQmXIx2aXoNg=;
        b=BlUwnh4uB7AVTq6CozRLxcffrDHPVetK/SrKgU5bMrGG6o8qXbae2OhcMhcAZUDKB+
         GULwEpb2NewBOYRG4Rqg6573ygyyzaM53kM+eZUe6d011p66UJ98sOxjmJKZnhB2JJBK
         JNKR7lVS6Vs5DBNQMm53leYXVCC3eH7DohHRcoZ7yEdJRs4IptE/xSQT9QWiBmlnREEx
         oUAvDsKDMj9mX9/QyO2h4eYgmfIDtqRHDA2i7HOAXNRdJUs76p6doBamp1fSwRRutQcR
         5M0gIrkvqJpKUqEjGdJJ/lpZAmxpzgjsuZOaDwNva+NjOePXeloOxqF6A5Pw6NNhqk6I
         datA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785343921; x=1785948721;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynliW8RV51DVn6/Hi9bIDwJycFbIH0QxQmXIx2aXoNg=;
        b=tQiFpmtnzNq/JmHCPfNKPkgNWjeZ2+1Tcv8S4Exvx5VStvQAYt4UFGBq2FW8IOOchc
         EPxDSRCLXPHpza3wPaBoKP+bPFIjeAZIZ+6OzIt5qfPrCCaNzI9NkukCVz0PjeXsCqsg
         sXBIj50UGn3gQHPx8NbIvh2v2D+zPQIX8uv7UXmUQijx0nnJNLed8V3wyzO6kzqpJRLU
         yQETQOtQDnuvBlM/0dVegA/UE7W5PlbsD2XE8Y1H7Q939fqgyEqTg5/AAoWH4B+PzzRt
         S0g8U2z686hEr09P52Fp2POR+bHZANcg3iBs9dWmoWrBzbaxwQI3FF/Km/T1Ox44dZHX
         Ogkg==
X-Forwarded-Encrypted: i=1; AHgh+RqlZSKa5CrvaHO64s/WVS4j4ge0UemkFRbsD8Siaoyom465uXlaU8ocC9KdYlOelDa6kkujxTcbxWsUXXTuBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3VJY+hlIW0Xq61tDpqxWUF/BVFfemKkB0dKlNyLHdkAWvbL1P
	PsxSIvvnHNB4JyZPntfPJp34BqarcItuccuougTq900EvTLIV+Sr5hJW
X-Gm-Gg: AR+sD13XZ6g7sVakXOpsrKmU/hgOLjBIyJn1WPqIyczL8AKAboAe3tNeStQZLJh+4Am
	81kNIvRIS3xfDG22AlimGiCPiM1sZ9/YBCzuB+jDHgiokoLAEnD1J76mW/kCyb3bGMdgtyWWfRU
	rwAZM+iH57veHnWqkkIIQ0u3f8oe4Gp1H9sGryRYtjRwEc6+a5dWxSPujoCbjeCcS3sfrN0JD/U
	eWsZq3tfY1yKeuMu1lZfTleY2e28oxX7RKTZVHp65hVAHiU+Gp9dkMoFuOvvxz/LbAoYYzTgaeD
	pBXR+qHN/zBiJmE9dkpyj1w9A119XSHI0Z2E7w+zb7bnlrGVEzslfHc4ERo+6S2E6gToShZ9L8h
	2oz2a4spol27rMzTXae3//ESAfgt5cjQPoN4DC72z7yppu+9+imB4Eg51a4V0AL4/MrFqHRoF2c
	6F8C9QGgQR0ygYfC/OATaLvsnLvAc4IGaN4kMyD9E+P0juhzGVDMAHdKGrTumgsIUU9EtJon0fe
	4qzQbECegcVdzb5ZsoqENDPLnkpIyWZzFXYA/Zt
X-Received: by 2002:a05:6a00:a86:b0:848:31fb:43d9 with SMTP id d2e1a72fcca58-84e9332e820mr7983253b3a.45.1785343920946;
        Wed, 29 Jul 2026 09:52:00 -0700 (PDT)
Received: from ?IPV6:2406:3003:2007:2131:923:11ce:1cdb:19d4? ([2406:3003:2007:2131:923:11ce:1cdb:19d4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe1d07dsm1697570b3a.8.2026.07.29.09.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 09:52:00 -0700 (PDT)
Message-ID: <148e56ec-dc26-4be2-a7af-eb547b517a68@gmail.com>
Date: Thu, 30 Jul 2026 00:51:55 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
 <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
 <amn5vWcyY0f5ErEM@sgarzare-redhat>
 <e7ff506a-850d-4d7c-8346-c6fef9ad8553@rbox.co>
 <amoACichDryCaVsG@sgarzare-redhat>
 <bf3a61f0-cd82-4796-a3ce-d6de8c8dd7ae@rbox.co>
Content-Language: en-US
From: Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <bf3a61f0-cd82-4796-a3ce-d6de8c8dd7ae@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2026 11:49 PM, Michal Luczaj wrote:
> On 7/29/26 15:29, Stefano Garzarella wrote:
>>
>> This is a good point!
>>
>> So we still need to remove `sk_err` check in vsock_accept(), or set
>> `sk->sk_err = 0` in vsock_listen() to have a complete fix, right?
> 
> Yup, that's my understanding as well.
> 
> That said, I'm not against flushing sk_err on a failed blocking connect()
> (this patch) as a follow up, if you guys agree that makes vsock behave like
> other socket families.

IMO, we should remove the sk_err check in vsock_accept() and invoke 
sock_error() in vsock_connnect()

Thanks,
Phi
