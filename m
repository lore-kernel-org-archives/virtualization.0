Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC6204C35
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483897; cv=none; b=C+ar17x5x7ylVL3T5luKb5ZRFCov34YYa8oT83EMquDXTm2UaztGxTOz6D74lG/6SdbHevA1LWww5o6LeF7wvVU0z4b3EF6KxvR+v+FloABVGK3TLBmcnv18Zzd2tvIrRbjTn1cDrTD4YL380D8/eEaNf515ZxdniDbtrD+pel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483897; c=relaxed/simple;
	bh=NQABrOdJjxGKaiqAIDo3XL0V9WgsqmrsrgDnSsJEpZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnFN1SoKTLu1sJUo/uaSjxwAzgazcmLvnbfFjrxIYmWY3rDN+Pv8yVZBI5wcORq+eqr/Sp5ivheEiNrGU0xtkpnLNgdcKR3ef1HGJ7OdFRxCjiZvqsASnUt9WnO9K82xPBuK65tZFKo/rzudGCBZoKvfkcnyxKBMEYL6tWgmy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=d4zEwiRa; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="d4zEwiRa"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AF8B40335
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 04:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2GoaLuOq39Y for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 04:38:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1055E40295
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1055E40295
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=d4zEwiRa
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1055E40295
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 04:38:13 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2161eb95317so25371955ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 20:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736483893; x=1737088693; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VRHR34mrz0IlpIAFdzRMCZZmZsA3d1rUTcqvnksKWQ=;
        b=d4zEwiRacLrrGiUuYhpO73eZ9inZKk8dRJjtq763qqJn9uprIQnUWDvorO/HOrQ+V/
         bvulJ/JEA+4NU7KdMHZxX9Eudn0mQIlX+DoSYHBfLdAs+XHC9LY5eziFyd5vQ7hQjXdU
         cW2y9PJ6Zd5OqizlM9UfFJl9lGG7D8OyKlW5O1aDYWMp4RpKB1H73XI8Rls/c0w0bev6
         qcReq3ZPWSmEYCqQ0KXqnzaq6Hl2Fk/9mK1IPdisrl8DGMVD3XNvWnSJ7GR4Hx/n3rb3
         t7Jk6g6j7MUoDhqrVRtAVkbmyBBdqSQN+sotbHSrgOHHGxU271IYaGHXXjj0NzK6kkFu
         3ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736483893; x=1737088693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VRHR34mrz0IlpIAFdzRMCZZmZsA3d1rUTcqvnksKWQ=;
        b=P8Of2DJ3DJ4CGdQZLlZmd1no6JLTL8h3SlyZ1VAgyea6ffllykaXxFWXSA/LmIXL5o
         EmSBxvZafG9x7f/kh+MqMyDrxFqgIn3W0yG7ajAshQGegY+GpGTH1U9o1JYiGCcfE8Wq
         uVkARzdGLnfbD1R58iduYfvEIFkBylUBhCEYSipxbxUhSI6DepOGmxq7id3vKfNKAZAA
         rRs2fm7HTbjOkRogTd1oIu2KyfV2M7lKXAWh7qlky7kPDL8HzYoDJTIEAOATjgP+ObQp
         vHnzmiGV+3I4iHY9/34hiV2GUqPBy4m+DsFJkVGqfw0xkgLsNrWgevqq8YzqaZVYtktw
         jxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC4XzkSh2YaEX/jUKeR20v3C4gW2xW7y1WSsGkjxcRt6QepjsCo0pMgbdcXwMwFXWYmVlcG+aziOibS2bisw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx42Z1ZlTctTewFHp7eQgi8cBKcpjoPKl8p9jaQfkZHu1H64f1+
	E6Ytw7Z1ZqXKXFJlZyWMdIR6sFh6PhyBqrqBICAC1R9Ti/PcCrET/XjJQ/nMByk=
X-Gm-Gg: ASbGnctrVkUtdtbrGvH4Iwunfe4q48bn+me8cjb8+iywRKvTBmgsV5pLjCNkTo4w/tF
	5RfwtgkaJjjiJtzxOTs9+AuMyZwMyT6fEennlxjs+2RVxft5YfGoWsshbM31w1odP2moBKaM4+J
	f4CXwpq3wu0bIhdnVUK4QfXUOMmCFZeTotQ3y2H23w7kmB7xad8C9cuXT9g6lQqyhRu3Xju+WWV
	igFi6+02IRlxhV5PIdRLTbwBCal1xWztJFty33BuILh7gsI75Tpr2VN/waZUfVtaxw=
X-Google-Smtp-Source: AGHT+IGIzSe99ixGVZWcgiRWGgX+k+OXNMhmSVlKwOwyHf8ERTDIVn5bxtWt8REsRDYstEUOtvnfEg==
X-Received: by 2002:a17:902:ce8d:b0:216:282d:c697 with SMTP id d9443c01a7336-21a83f62877mr120429985ad.27.1736483893141;
        Thu, 09 Jan 2025 20:38:13 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f26d996sm5709995ad.257.2025.01.09.20.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 20:38:12 -0800 (PST)
Message-ID: <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
Date: Fri, 10 Jan 2025 13:38:06 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 21:46, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
>>>> which leaves the garbage in the buffer as is. This is especially
>>>> problematic when tun starts to allow enabling the hash reporting
>>>> feature; even if the feature is enabled, the packet may lack a hash
>>>> value and may contain a hole in the virtio header because the packet
>>>> arrived before the feature gets enabled or does not contain the
>>>> header fields to be hashed. If the hole is not filled with zero, it is
>>>> impossible to tell if the packet lacks a hash value.
> 
> Zero is a valid hash value, so cannot be used as an indication that
> hashing is inactive.

Zeroing will initialize the hash_report field to 
VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.

> 
>>>> In theory, a user of tun can fill the buffer with zero before calling
>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
>>>> awkward anyway so fill the buffer in tun.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> But if the user did it, you have just overwritten his value,
>>> did you not?
>>
>> Yes. but that means the user expects some part of buffer is not filled
>> after read() or recvmsg(). I'm a bit worried that not filling the buffer
>> may break assumptions others (especially the filesystem and socket
>> infrastructures in the kernel) may have.
> 
> If this is user memory that is ignored by the kernel, just reflected
> back, then there is no need in general to zero it. There are many such
> instances, also in msg_control.

More specifically, is there any instance of recvmsg() implementation 
which returns N and does not fill the complete N bytes of msg_iter?

> 
> If not zeroing leads to ambiguity with the new feature, that would be
> a reason to add it -- it is always safe to do so.
>   
>> If we are really confident that it will not cause problems, this
>> behavior can be opt-in based on a flag or we can just write some
>> documentation warning userspace programmers to initialize the buffer.

