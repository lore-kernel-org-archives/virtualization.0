Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B66BE5E
	for <virtualization@lists.linux.dev>; Sat, 31 May 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748681528; cv=none; b=Rg8Wy2Qv0wlnpqFLyb0AigmjKt7i+5AsALlqflwjTg7b6RTaFqTruhF+R+COZC0rV420BeOLZVYuWXBc8XGbyrvxG8TBJE5A14g3BWrN0uEAnBDRc/ipS/6Wi72yhaGakGU7b4JdAi5STGZszlZFhMJz2zCvj0UM4rMWp2nPscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748681528; c=relaxed/simple;
	bh=REe60zlbqeu01BOJVePubuQZLx8kofDHdn8NxkEDkks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vblc3wbrUEjjHjqzV0r1WzwN+Y04r5kHgA7p1rpgEGfALyDD48/6jV5Myyh12mZ2vckt07UartyglysDrMVQ9vsSW/SIDfUHdTRTLkMvzULWzmcviqeaybNt3KzaEZ+JAhDBiMBENdYcXg7EORI2DSuOecixdJpJe8UnhPo9vwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erOt4QR7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erOt4QR7"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so3191341b3a.0
        for <virtualization@lists.linux.dev>; Sat, 31 May 2025 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748681526; x=1749286326; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REe60zlbqeu01BOJVePubuQZLx8kofDHdn8NxkEDkks=;
        b=erOt4QR7x/uBEh4VJZfuuVul8uc28eO2ERVvJOotBEC65+ebVcYC8lWlS8S7JyS7rL
         bx6UBAgD5uc5jqNzLu17Q9WpJtwL5wGmbPLCn5oNMCSbn0G53YjgfrSKoOHcIQrGJ8Hw
         RoI6Zd0EeCQ4OHwbN5Zaj9/wO4b8+NUkdxuUMJ7pcaOjoDP2lGt3ze6xslQCo8HkGtVM
         cWj8otXm5/EZL5nhGJvdjUH/BNyhSWZ8A01WSti32zNZSg7qADMKg5DN9sHCEb0lI6/h
         3UNmXR5l/3TKPDpaBSTWxTtJloMIdnlCAlXGzi+MXPi/EFDvDTFa+WEssMtkuIi5y0yX
         hcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748681526; x=1749286326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REe60zlbqeu01BOJVePubuQZLx8kofDHdn8NxkEDkks=;
        b=uPS+PXwpckD2SJ6w/cSGnrzatT4TZbrgsrHRJwHgDXUuDLiISUq8MhjgXl/ARTv//A
         AjdZqmrzqBQdJ1WLIgH7QE65hb1MSREWQyqUjRHJ9QePG9lVgxQFz4ypBCIl9+vRN020
         CnStdgUj/x/+HiDtGbCSoVlfThhn1No769e3/qwVX03mBTlK90WMLvcpDoXSbr4xwckS
         GzRSx512ksUgv0XSPPgTLpAPkBNqrm7cpgM8xvUnxbdzniaXq1mE8oq7YAraUtuEdLZT
         h3IGeg97qpbEqrzgkkwWVI6CDjsO5YBv4AiIqFFeNbiYUPPK7QdHXtC04VoiAxVIQqmZ
         ICEA==
X-Forwarded-Encrypted: i=1; AJvYcCWNrrkQ9RnUl+5k0ef9CTrbHfzRu+U4JE1kqjHwR8Yn8PQAcgN3iwB6mczRrBQCa3vXEVenMZM3yXrKv/Ovsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YymSE2YbykqvVy4+MhCPW93Lywtlfg8a1M4Y80Mzr6Ownw/P4Zg
	K5HmDB4jKYgDJ/GYQ4hWB9FveVJ/FsUFXztPMWEVD0K8bA7R1F4aTEuo
X-Gm-Gg: ASbGncvULJxhWx0ohLiTVgt6AvyEyihj+bN+Oqkr0y7f2oSxYP3SUmvdBNzfnIFRD2I
	WKDyb5ZL0aITo0fLWFzcspYPXbnhtW8qXXPa9RtbvpF7wDMWvk7AThiuY+V0l6nVEu8yUwLpYqk
	+no4ePwppD6vU7kuwXLJnAfa9R2nbbj+GRExgrd0YmUA+zBkpjL2dr5rQgReegMkYP3LPmw6iiT
	jXjoWAcKThxG+4HZOdxy/o5CuSEMQU+m7xXMVK/tZf3S60kr/Fmec2soija2PXkwkVQBMymgKh8
	rup4hHiFACNs+eGkChMAF1XQsRYIHkU/5ZRVH9jOo46HTkj8qWRSbB1J81/lbd0SIIzHudmwdLk
	/FyYf10PsighYj7sRXabyPYVLdjYBQpbRtdH9dG3y
X-Google-Smtp-Source: AGHT+IFrK8g6/dGJ+qH8DK2puY7/mPl63dYSmPTZk3WE+0FNPHkZ94c11mvWpcO4rQ5k5aBxw+s1VQ==
X-Received: by 2002:a17:903:1a0b:b0:234:71c1:d34f with SMTP id d9443c01a7336-234f67a7c06mr152428215ad.8.1748681525735;
        Sat, 31 May 2025 01:52:05 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:af83:9564:6a79:4f18? ([2001:ee0:4f0e:fb30:af83:9564:6a79:4f18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd362fsm39298485ad.116.2025.05.31.01.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 May 2025 01:52:05 -0700 (PDT)
Message-ID: <ef4ac528-3f91-4004-b47b-e758a5712d28@gmail.com>
Date: Sat, 31 May 2025 15:51:57 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com> <aDhCfxHo3M5dxlpH@boxer>
 <fe162eed-fd44-4c18-a541-8243ccfc4252@gmail.com> <aDmaT1cmoRa6PaqK@boxer>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <aDmaT1cmoRa6PaqK@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 18:45, Maciej Fijalkowski wrote:
> On Thu, May 29, 2025 at 09:29:14PM +0700, Bui Quang Minh wrote:
>> On 5/29/25 18:18, Maciej Fijalkowski wrote:
>>> On Tue, May 27, 2025 at 11:19:04PM +0700, Bui Quang Minh wrote:
>>>> This adds a test to test the virtio-net rx when there is a XDP socket
>>>> bound to it. There are tests for both copy mode and zerocopy mode, both
>>>> cases when XDP program returns XDP_PASS and XDP_REDIRECT to a XDP socket.
>>>>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>> Hi Bui,
>>>
>>> have you considered adjusting xskxceiver for your needs? If yes and you
>>> decided to go with another test app then what were the issues around it?
>>>
>>> This is yet another approach for xsk testing where we already have a
>>> test framework.
>> Hi,
>>
>> I haven't tried much hard to adapt xskxceiver. I did have a look at
>> xskxceiver but I felt the supported topology is not suitable for my need. To
>> test the receiving side in virtio-net, I use Qemu to set up virtio-net in
>> the guest and vhost-net in the host side. The sending side is in the host
>> and the receiving is in the guest so I can't figure out how to do that with
>> xskxceiver.
> I see - couldn't the python side be executing xdpsock then instead of your
> own app?

I'm not aware of xdpsock. Could you give the path to that file?

> I wouldn't like to end up with several xsk tools for testing data path on
> different environments.
