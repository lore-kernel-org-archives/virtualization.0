Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E70223DDA
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490840; cv=none; b=mBZEyQhcN5fewqF+Bu22YrNZdk37Vx3CNkd5jvjztuIDe/2jWO1ZoGI6dLVONwt12VqsnvkA5mVLUW7HWMx5uSG0fEJA3KvdW2Z6aU86bs5Rxcf6vvEfwYOPbLsQCVJJVI/11wqYalFtVgDGB8KDJM40aQRYbPwkhtSsu+sftxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490840; c=relaxed/simple;
	bh=Uy+mUasuhKbgXtDTxk3JR8h6eqRQF8rsNoKeGi5WQnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4LHnuXu537cdcqvpIf2Nc9z0P+Q9yX4a1Vj4BuykCYNsPh9p3infCzNDbJKrCvEeVR1w9KaV2t16L+B7bG9WF+XniiUMk1+hr6yvrV0afwXiV8YIsmu6BR5W8DANk2fFMKo0RJTss0WvXe1EE4rSJEmpRrtWrV7FJ5Wm33hBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8idOT7e; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8idOT7e"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so646871b3a.2
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745490838; x=1746095638; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VS98H9vhuUvesz4nn7FmfvGAmjamAD7zXnYiaxDdLvI=;
        b=m8idOT7etBGxkXB1y5B057YUeEFrBiqJuU0DUjIXNwCugmQtrF7gBkRFLQxKcFxEzY
         /4XE4PBiPZ+iQKuZWzDpW9OW8onF+PSUSS8dyH12o7+XfeS3EkWsrnt37VHjXpqJoLAh
         Ou/EC/BMU3/tncWtrgQwgm7bQByDuYH/ajwF0HhFO0ASH/9thK1rc80v1jSuN7XQXZCw
         YcYzyRVpxIpdNcn6P0Fvx2bU6i17xK7Bi/drz7GGesbEipTz1ItQbUSUdP3vq6KDVEFV
         4XZB2JDUAbOJPueCJHvDSSS+pe6H+ukGyY1zfPFQmXidofD44H4HSQAOSb9NX3JJzf82
         Xx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745490838; x=1746095638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VS98H9vhuUvesz4nn7FmfvGAmjamAD7zXnYiaxDdLvI=;
        b=mF2O/aChGV5Rs6Ml0ddvy+EYLGGO+/rQQt4RssedIjy8CXEXtCdfI9PJmHycHTlmgX
         Tp/My6dpcnxqqXh/WTXH84tv9Mf27EbN+CgzzxVZZ4GAnHeh3aI/8rF1dwMNsyaVkHsn
         /ZMG3a7grAXFOB9Qi17KPwwNmLL9/jobQTx3yZ32QLcT7wT73JmEee6RBczJzK5mrBRb
         4isbMNNrQUpBLZ/W7qumdjv+85zB9AiwGuAqoPZL63l8ZEqI/UCVdGLgjLbCKCW/cCAK
         KXUcOtbRqsHVsdY4n86izUc4Yv4KXOBzlaL1WGfhWYwG5XAn1sqzzBgZe8XbSrSnjtQD
         lndQ==
X-Gm-Message-State: AOJu0YwXhr6xuCY55lFY1B+XlWlxtf/EsvTbC708x3C1lHN2OmwD4o4y
	28/GQ2g1+pasUUxBtYFUUgrzstYoC1hxpZt8o4hJnV8XfTspVoad
X-Gm-Gg: ASbGncudpndO14dJQ2uq77tmcS7+/39skdUlpT+n5tPLAhpgxrkvM8f4LdZLFyFan4V
	VehAyo5IybtR3cRyrardo1TB27QXP16GHRlfugmJpbt3oeGd7g/iOW9xzW0yZ1mnm8er8hwx6qc
	VM9goxBtVe/8pnTMdwHB4MdH1Z1CMbix4Q7jOIKx+oVHfRVykDv0eLi5jR9PBPOB85p70iUNjL1
	B3h/80WAJwo5FrKCC2ALllKz52Uu83dLm9MQTBvCO2flaHnOFLS64RxLVBV34YHQMZ5Cc4XQ9kM
	5R7PTkH6K/HB0F8/wgU4Zf/RsjafbiLI/u4u5L94f7uGmv0gn1j92kAxUPoY1lCOJlNUyDjIbwv
	uJ1MulIGhepOaEeQ9Y+Q=
X-Google-Smtp-Source: AGHT+IE16otPz//YJ1TEtt4Uv/PnG/T0CeZp27eSS79xfdk9zP1F3OBCyutLV1LXJhRM9Cm0Rt17bg==
X-Received: by 2002:a17:90a:e7c5:b0:2ff:5357:1c7f with SMTP id 98e67ed59e1d1-309ed3424efmr3084886a91.30.1745490837878;
        Thu, 24 Apr 2025 03:33:57 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:f632:6238:46f4:702e? ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03b27asm1086032a91.6.2025.04.24.03.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 03:33:57 -0700 (PDT)
Message-ID: <619bc46d-4acf-4c54-bd47-6b482fb76878@gmail.com>
Date: Thu, 24 Apr 2025 17:33:49 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] selftests: net: add a virtio_net deadlock selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
 <20250417072806.18660-5-minhquangbui99@gmail.com>
 <20250422184151.2fb4fffe@kernel.org>
 <aac402b4-d04c-4d7e-91c8-ab6c20c9a74d@gmail.com>
 <20250423152333.68117196@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250423152333.68117196@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/25 05:23, Jakub Kicinski wrote:
> On Wed, 23 Apr 2025 22:20:41 +0700 Bui Quang Minh wrote:
>> I've tried to make the setup_xsk into each test. However, I've an issue
>> that the XDP socket destruct waits for an RCU grace period as I see this
>> sock's flag SOCK_RCU_FREE is set. So if we start the next test right
>> away, we can have the error when setting up XDP socket again because
>> previous XDP socket has not unbound the network interface's queue yet. I
>> can resolve the issue by putting the sleep(1) after closing the socket
>> in xdp_helper:
>>
>> diff --git a/tools/testing/selftests/net/lib/xdp_helper.c
>> b/tools/testing/selftests/net/lib/xdp_helper.c
>> index f21536ab95ba..e882bb22877f 100644
>> --- a/tools/testing/selftests/net/lib/xdp_helper.c
>> +++ b/tools/testing/selftests/net/lib/xdp_helper.c
>> @@ -162,5 +162,6 @@ int main(int argc, char **argv)
>>            */
>>
>>           close(sock_fd);
>> +       sleep(1);
>>           return 0;
>>    }
>>
>> Do you think it's enough or do you have a better suggestion here?
> Interesting :S What errno does the kernel return? EBUSY?
> Perhaps we could loop for a second retrying the bind()
> if kernel returns EBUSY in case it's just a socket waiting
> to be cleaned up?

Yes, the kernel returns EBUSY. Loop and retry sounds good to me but it's 
not easy to get the return code when using bkg(). So for simplicity, 
I'll retry with sleep(1) 3 times when the xdp_helper fails.

Thanks,
Quang Minh.
