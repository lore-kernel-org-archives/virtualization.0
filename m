Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398B19E831
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Sep 2024 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750310; cv=none; b=l1teMGprGnRscLUHvGku8Vrejv/Q3oE3pv12ojoHzjDePwIwk1nt4L8vGK9Bg5cqsQ+BqLZ79hOnYGz/KF88tEeNm+fEePofLVOXLpAHEWSZHBaPtYK7u00Gm0jWDNn+SxIIcVzVPhUrOJvvAIC5kflW+7Nu1GKY9kqg3I9L/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750310; c=relaxed/simple;
	bh=SlJmwhGl3SrJKXIOv4Gm2FmJKvlW3Kv5wJXm0Ihsfbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kygJuv4/+QzutzAukZHwiMYPvdiPuj/Ei3XcOAY0N/HoootFkvUY4Lf5ysIsdY1nFfB3DzXKci4vQDiIsElXNet1GNIkcLnisULYEKC+d/XgAegKl7Wn5yq9Z0zCgdY5vJuwKFyAF4jiPHNUMJPEdJEa3lb/JKfOvK7BD3wSRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=GV/qlp5n; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="GV/qlp5n"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24D0480579
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Sep 2024 12:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdtgLqKuB8nv for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Sep 2024 12:51:48 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8E66380578
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E66380578
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=GV/qlp5n
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E66380578
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Sep 2024 12:51:47 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a8d3cde1103so104210866b.2
        for <virtualization@lists.linux-foundation.org>; Thu, 19 Sep 2024 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726750305; x=1727355105; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2ods2eZT8RMxJfTBuByt96hZQnySzfhNv8GJfRYckM=;
        b=GV/qlp5ntN110sKhWEzzFZMWmH3x2y7tK5M1J0H13eRYCMMZHNaFQB8FVSzB5M72CP
         MAQFqwkJRsnb/hb7rKKreHzlMmfTROLKZ3r+2TtQRKge5GMFVWQV+uf52gCP6Hi8SvBg
         jCyV3TQaWdUlne/WbrNp6tWlKinqG638hW0KnasqNddThaO/ugFt5zovyQurTxXoeiRP
         yOV8MOUkBR2koq+Hgw81IHD/jyfSGkdau8wZXc8bmKw3lgITT7KqnP5l0yd5brVF7kCJ
         biwtONsuu4/5FtZok+1IbP4K9AHzIyvZx1R/I2jwHL9YlzWRg2pIkQWbPoMQDuTFqzfz
         tb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726750305; x=1727355105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2ods2eZT8RMxJfTBuByt96hZQnySzfhNv8GJfRYckM=;
        b=Gq9NbPiholTaJynmB9mrRBQFQAJmVPNcMxKm0bJuEaDCcq4dPElwxfESkUScX2vCii
         8Qm+vCYXHd7lOOesPx+Y1w0VRXeloH3R9o+ygu7ujgLachwzeFsD+ItKLzIzxbflV2ej
         gFz4bWg6nV2GVE9AElB/er9/hiqiuzzhAD55GvK2fFWP5SdpW6HOxRhu44MtHu8YflgH
         tToF0KKPT40hFSbXJFj7AVkl7ZzQTLqnVVKpcR98Xn1vlDjWISlfJwhY+I8BFZvquGq6
         cEPGut10HsFxMdmirbo4GB8HDqZ3zfVCnNJT8F/XYzOuCtm90Jcq/NwPf9Fz4rNYPN5D
         C0IA==
X-Forwarded-Encrypted: i=1; AJvYcCXvi/gjtAI3TBsaW89DTT4x+v0Fux3OuzaZroaDvSQyZAF1CFALecigQCCuYA4Ztn+kc7jbBoIlsT5e8hcJLQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxTwlOoeSdJquZtZ7mY/BOpaq4n6dFNSOXDSUxiqb/aRTvxC7Nq
	62p9VoiUCeHLCWpCXdgVvPR8cIkwM1Z9uLtXOEXTKIH8q6Uz/wiRiCP27jdeFHQ=
X-Google-Smtp-Source: AGHT+IGZqgve+KamWKCTyn5ghHOmYZoUojN3YplaJpvEJ6WqeTRtpjQs7A0Ut18Ni9wirgc/SkN/uw==
X-Received: by 2002:a17:907:36cd:b0:a90:b73f:61d7 with SMTP id a640c23a62f3a-a90b73f63bamr599108766b.42.1726750305479;
        Thu, 19 Sep 2024 05:51:45 -0700 (PDT)
Received: from [10.130.6.89] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610968b9sm718971366b.5.2024.09.19.05.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:51:44 -0700 (PDT)
Message-ID: <18d61c52-be6f-4ef3-b020-d597ba7cdaeb@daynix.com>
Date: Thu, 19 Sep 2024 14:51:43 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
To: gur.stavi@huawei.com
Cc: andrew@daynix.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, jasowang@redhat.com, kuba@kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org,
 virtualization@lists.linux-foundation.org, willemdebruijn.kernel@gmail.com,
 xuanzhuo@linux.alibaba.com, yuri.benditovich@daynix.com
References: <20240916071253.462-1-gur.stavi@huawei.com>
 <20240916080137.508-1-gur.stavi@huawei.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240916080137.508-1-gur.stavi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/09/16 10:01, gur.stavi@huawei.com wrote:
>> +
>> +static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
>> +				       const __be32 *input, size_t len)
>>
>> The function calculates a hash value but its name does not make it
>> clear. Consider adding a 'calc'.
>>
>> +{
>> +	u32 key;
>> +
>> +	while (len) {
>> +		state->key++;
>> +		key = be32_to_cpu(*state->key);
>>
>> You perform be32_to_cpu to support both CPU endianities.
>> If you will follow with an unconditional swab32, you could run the
>> following loop on a more natural 0 to 31 always referring to bit 0
>> and avoiding !!(key & bit):
>>
>> key = swab32(be32_to_cpu(*state->key));
>> for (i = 0; i < 32; i++, key >>= 1) {
>> 	if (be32_to_cpu(*input) & 1)
>> 		state->hash ^= state->key_buffer;
>> 	state->key_buffer = (state->key_buffer << 1) | (key & 1);
>> }
>>
> 
> Fixing myself, in previous version 'input' was tested against same bit.
> Advantage is less clear now, replacing !! with extra shift.
> However, since little endian CPUs are more common, the combination of
> swab32(be32_to_cpu(x) will actually become a nop.
> Similar tactic may be applied to 'input' by assigning it to local
> variable. This may produce more efficient version but not necessary
> easier to understand.
> 
> key = bswap32(be32_to_cpu(*state->key));
> for (u32 bit = BIT(31); bit; bit >>= 1, key >>= 1) {
> 	if (be32_to_cpu(*input) & bit)
> 		state->hash ^= state->key_buffer;
> 	state->key_buffer =
> 		(state->key_buffer << 1) | (key & 1);
> }

This unfortunately does not work. swab32() works at *byte*-level but we 
need to reverse the order of *bits*. bitrev32() is what we need, but it 
cannot eliminate be32_to_cpu().

Regards,
Akihiko Odaki
