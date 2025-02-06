Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD3224AEA
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824817; cv=none; b=V7ku9pOl9vLLZH1X3uTOHrtH+U3aia35Pvn/4RJmKO6I7LLtxjD2ntRjZ8cwb1cqsVc8VBfocclm/qvOEteiX4H+NhoUYANk9OlwclOt94hBlqDmcFSBVVFJl1jQzXsfuKdP8z9nxl87iyv5SoObxpdgyArTSD1nA/rZW7c2juE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824817; c=relaxed/simple;
	bh=QFOprhmkYAckDmLpj8OaQpl0QIRArOwxk2YuENHmzqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWOkiRC04ha91X5J2RMQdziUxESp9Wyv42gvimJLij+5K7OX3etTJKpPgYtTnMRGUKNxty/okZZn8oQA+FjJKOUhsUkR+I4W4f+IKNtOxhRFMgRM34cidR5XxnXMd0ZkqiqpeHvymiyCd+xMXayTSeqBpzrakhl5PyC1xbo/7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=StZbqQTh; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="StZbqQTh"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA7EE405BA
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 06:53:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coU58KOUcQUg for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Feb 2025 06:53:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 126AB405CC
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 126AB405CC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=StZbqQTh
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 126AB405CC
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 06:53:33 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2f9cd8ecbceso1033428a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Feb 2025 22:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738824813; x=1739429613; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfPzJgqGwInu62D/JbABqcLSTAUY1ivE7x32/lUlB+s=;
        b=StZbqQTh3W3pGNdWHsY/NkdPLV6FBov2jYHEehXaByH54jAmXU64Cvmzl/HQ9bu27q
         hIOrKFda2qVNQMYFnlYQ5Yt9W8aA1tDgxuHrUWlZwI6MfqRqur+WZ5nLVofsNbkyq684
         Ou5SfRA4ju76/Bt5J2HAnaPap66eKpG7r6pESfEZgiVLlWlWF27D37ayQjQPxMvq5F2b
         ZlPIqveXGxdVLMPDGza32dgETjpulfPPqKQZ5hjU2PIeUAr175dvrqjMmovE3tvtbC49
         /KbI76Z7+T75DMM/5ncyzl5YjcnwvvKAEvGq0HRw4W6n331dNootTtxF+uwZA8PMyW5v
         Suwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738824813; x=1739429613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfPzJgqGwInu62D/JbABqcLSTAUY1ivE7x32/lUlB+s=;
        b=w4qXc7QNic5ECCK3S02c3IYRI3fPdbaq9JmPOUKM/YvqTAoGoA6HflqTBmXmehI4mP
         K7rUgbIMuyRqyvRe93cH2UOPxuV/yTiOBc0BKtUv0A1tmTqrAYcnJ6fdJeRepfoYTq72
         yPt8V17JtvTE4BcpAhe0y0cz0ekmI2EsM5w3NqECO0MvIgbe7ToldEGrrDAdUdWn3jKz
         PInGsyFe7HF1epa2gBQ+8ea4gmJas/zSVcKzxi0K9ovhUD9rhLQJtHUZ1h7lKjTiIUmu
         HZ+CQ37PlNTutlrn5sOTIcSfEH0EIwnI9sux+3cfvBzdMf5j4cG+0jbIlu6EJqXw/64P
         QF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhjxxPeT3oZGNaOPUXfEsNdtuTRcyZK76NV8j8/QaTTmZKfOiHlWM9gq/FA8GsT2FMVwkpgWEbqUMCuWVrkA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxc960uFtxHQq6ykHY1wzu2tMjxRvSARp4LIMPz1GqChyqkyFg+
	QJ+EDQtpZBizwF2Twd6UCpCx/D4E76+V13gh5t4f3J+BNNQJwmAd6FVPupRpzyM=
X-Gm-Gg: ASbGnctXeuxW64B7EKJam6q4uo14EZiAbSmdqr/X7ZVAiRPR4Jj0TUlm86b0HETNlWZ
	3Xhcr7t9cJPcGrZ3BJxFgibli0peV3Ku1vcEA1Ze/+DQaN6utHhyAVMcuW4GpCQSuvcf5GRDYk3
	VtqHboYf6VTIIz0heODZTM5qKOmP7GKjUeVTZPt3ZJPiVZgIc8DaLOeZj6t0KVZsnj49MvZBiDO
	1O1I8z4HxChjF5PdXULsnwK6OLPy7SnOvKW0Vh9bAmR/ocpRazjqML58f9G5HqSshPSRVqOKNu+
	7mJnKBEofjQJjvJlBgXknoBlQMic
X-Google-Smtp-Source: AGHT+IER8psjFE80ifTWvoXn5WHFoV2OjIRpn8B020yOLPR0qnk21Bx82Mdy+x+4gwZSwLApBeX7OA==
X-Received: by 2002:a17:90b:2d8e:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2f9e0767573mr10783588a91.12.1738824813210;
        Wed, 05 Feb 2025 22:53:33 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e24559sm2800958a91.31.2025.02.05.22.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 22:53:32 -0800 (PST)
Message-ID: <12dbfa5e-32cc-4355-89e4-6c1cd4e12d1a@daynix.com>
Date: Thu, 6 Feb 2025 15:53:26 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
Cc: Willem de Bruijn <willemb@google.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
 <67a3d2efbba32_170d392944d@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67a3d2efbba32_170d392944d@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/06 6:06, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
>> future changes easier.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>> ---
>>   drivers/net/tun.c | 26 ++++++++------------------
>>   1 file changed, 8 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..452fc5104260fe7ff5fdd5cedc5d2647cbe35c79 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -298,10 +298,10 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
>>   	return tfile->napi_frags_enabled;
>>   }
>>   
>> -#ifdef CONFIG_TUN_VNET_CROSS_LE
>>   static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
>>   {
>> -	return tun->flags & TUN_VNET_BE ? false :
>> +	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
>> +		 (tun->flags & TUN_VNET_BE)) &&
>>   		virtio_legacy_is_little_endian();
> 
> Since I have other comments to the series:
> 
> Can we make this a bit simpler to the reader, by splitting the test:
> 
>      if (IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && tun->flags & TUN_VNET_BE)
>              return false;
> 
>      return virtio_legacy_is_little_endian();
> 

I kept all in one expression to show how different variables are reduced 
into one bool value, but I agree it is too complicated.

I'm adding a new variable to simplify this. The return statement will 
look like: return !be && virtio_legacy_is_little_endian();

It means: for tun, whether the legacy format is in little endian will be 
determined from the tun-specific big-endian flag and the virtio's common 
logic.
