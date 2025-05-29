Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633319DFA2
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490287; cv=none; b=RDnMsqZgA7sSaT8vtt70R1Tl8prQWI9ZZNGRZ5XBpn8yRRpNjLXNWq8CPLXMH4QSn16OIGnquFF2vLrf08H5S6VuLzmHaYtpilLJmf4g3pDVyfC1kA+yfpPRdjSSejh4RguQociNOEb0QYGOZPNtTdnfOz3fMKqcfQfqt7ANArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490287; c=relaxed/simple;
	bh=qP5gjdbUL1UfLl8u+WQq9TWXaK1d3a5ARjTU0ouqSss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJiFfTnfOtnpWnxNc889nqgKfNTtlyfYH/mvGBz9bOCmptU1Wy+2X1s8WvbYda64D56LXRnZWWIejpUtdZ013HoyOMdDAtaw0QJYEA5tnIZBIccd/JYrxlBYDfJPEWlJeDh6YKBBJ9+cXEPmiq8/0ARP7xvet+oMg1tLC2leons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwV7VrxN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwV7VrxN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso477250b3a.2
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748490285; x=1749095085; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbJOS9RirTTM579TH3s6Zvz82kENRx54Nq1I6huQPgk=;
        b=OwV7VrxNqMqGfpc/Ab9yFZ/yWPnNpmb19MJRx50k2mfzzfadXQ9hKLqznVzEDBv/bT
         b8EgVNdzJ6nnkaZfX2elCFvzZRiQ0FjptXZ0Y60h6UMYqoedPBE4ngf7R5CUWCA9CyX5
         OZCGjof8f8MRBy3N5+OBorixyxxovIRKvw+/5SzyHszpiSsHk9elRYKAbzDMDMR+cK66
         Am9937XIFlILXfmO8ysh1oyUcG01Qtz0p6NX01Kqx520nI7+NwW6FtL7TuA8R9cwMKTu
         6dYZYgBR86vMyidB63kuCOmWp2ZfbtjUaWCilDrs6q9Qz0OhTOqP4/YHbhF06P6sw2iQ
         x1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748490285; x=1749095085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbJOS9RirTTM579TH3s6Zvz82kENRx54Nq1I6huQPgk=;
        b=qRilKo+a/mJgCnB/vu55QFGagCEWT72iHD77d795uxbs69YH/QVnZI3k0tz01feXPt
         6QepZqglESaLn0V5MUoSxjvuM3FyK1y+u2fuihE6II+FkGav2RUQb3Dx/QmCvDUbPaf5
         7U5CrCVVhf764IecHigSsZKr0s0sd3cMF+EjCRZFKEKK3TqpyGzlDWdu2n1RpEnz1U0u
         pNHCj+xQS5k2TZEmMImIltGztrJjnLl6AhoKJA5ZQzdjhcbGsGGijeYETgG1d/EZfzVh
         GVAFW5uybl3tPxons4pvyo31d6aBjqDB/psSU65ki0mC7QUZcXO02/DvHwxMMXPQE/kW
         AbCg==
X-Forwarded-Encrypted: i=1; AJvYcCXCEMWgdk2udcI/8JW7LO7u8MQV1avNmTWIyJyTJDMWDwOVkiAbj0mHcMs+TAv3MdFzv6ZJZqt53SSkVZSl5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqOghFClbiL5fljlyk6Ylm+8K755bs5IxBLqYtcyHQVntnWtLj
	MdLpucy9ihlr60fOws3NKe+/vO3wp0UjWqKnZ7b8sivZPoZ8QjfZp9Vk
X-Gm-Gg: ASbGncu/6dgBaSJBL/mw7mc/Nm5UsbvO9B5icO83a8YIvkPMZpfT09hVuyx6LKr2W88
	1huRJjabS8OccqjR1CNAWCxwcWfLFUdIQvsm8jNgRM0giw1N22w4FLJpgg0opLHVn9lIJEaUjwn
	opCIin5GGMfXVooJaeyabJVwOhd/DeZA4lXlVoOOoTP+UNyrfmU6ISp3FyaplIpoLGFA2m/70vC
	RrrpJGG3S9Rt3ITq4AvGpjARaRJlFbCY/osyi5O49/VpXYJm/7OFWW1aNztqc2Hr01mdubbNvZH
	9EcgjGBthHjtVDfEmlDBvCTSW3jclhrAsNn+3fU0Oy/9SSA6vZO/AdVekEdvW9FE0Gr0WvPUWnL
	ycwtUonCHkSWYWo0NNb9K0BZ9wz7FqsyuftAu
X-Google-Smtp-Source: AGHT+IGzpp+yFzFB3LHe0wo9L12fBskGn3KUXtzadW4NYiqfzcITkoJlkzjviP3Km5G42o8xBZu06w==
X-Received: by 2002:a05:6a00:234b:b0:740:595a:f9bf with SMTP id d2e1a72fcca58-747b0c8cademr1149905b3a.3.1748490285078;
        Wed, 28 May 2025 20:44:45 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:76aa:9d32:607:b042? ([2001:ee0:4f0e:fb30:76aa:9d32:607:b042])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe966easm374915b3a.4.2025.05.28.20.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 20:44:44 -0700 (PDT)
Message-ID: <3d9999b6-5c8b-4ab1-a9c6-e7cd09488779@gmail.com>
Date: Thu, 29 May 2025 10:44:37 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com>
 <0a827263-7257-4ac6-89cf-d694c9d3ab65@oracle.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <0a827263-7257-4ac6-89cf-d694c9d3ab65@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/25 00:04, ALOK TIWARI wrote:
>
>
> On 27-05-2025 21:49, Bui Quang Minh wrote:
>> +def main():
>> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
>> +        cfg.bin_local = path.abspath(path.dirname(__file__)
>> +                            + "/../../../drivers/net/hw/xsk_receive")
>> +        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
>> +
>> +        server_cmd = f"{cfg.bin_remote} -s -i {cfg.remote_ifname} "
>> +        server_cmd += f"-r {cfg.remote_addr_v["4"]} -l 
>> {cfg.addr_v["4"]}"
>> +        client_cmd = f"{cfg.bin_local} -c -r {cfg.remote_addr_v["4"]} "
>> +        client_cmd += f"-l {cfg.addr_v["4"]}"
>> +
>> +        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, 
>> server_cmd, client_cmd))
>> +    ksft_exit()
>
> SyntaxError ?
> inner ["4"] uses double quotes, which clash with the outer double 
> quotes of the f-string

This works just fine because the ["4"] is inside {}. But I can fix this 
to avoid confusion.

Thanks,
Quang Minh.

