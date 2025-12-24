Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8F330D28
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766594612; cv=none; b=mzEPQKULZKCm5KTEagFcv9aHPLWXITYQArMop7k7CFUPilAYomRbPOnE1Q/jTgT3g3RnjuekhU2bX1Gh6hWawb9u47vwo+0XVhnRDdgIoB15k6qzD3FJLiwAYBhPA/bl5eI7ZQMaFZ2QET2dgOXde0Z6Dk83qa7IDRUgauiczkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766594612; c=relaxed/simple;
	bh=2khFtyxoG8D3pvttVzE9sVaw7e+CdusfWtieJ8Un1NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwnPyWEUS+L8AmDNa3DPoPOkVdvQ9XK3gsfHfnZ/c7HpOQ24AyxiwdTqLTWOEPXjevyglZZxx6mXnz9/kv8VJlMuv0ey29gOZwzL2B4BC6NHQ5sJQHCizjjgv1yMOK4OAGyZNlvQM1Y8VNeUkiG5WlzPLN3UzXnGQScm2zevy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlX2h8L2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlX2h8L2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3890744b3a.2
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766594610; x=1767199410; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwIk1nvhH1d/vdoQL7AOIOe4muNkhVEYe/P22V7V6vE=;
        b=SlX2h8L2vf89JeNYDS4ymg0iNPdCgaH29WcSeAxtVd7NA1Bnjo2wjHS+G2pj0iftU0
         Sw3AJu7ih8HCwVJ0VIIsr++YVSR0+1Mn2+Z63MuyLdmWb60XchHlBy5RNhsTXS9ehIgv
         5s7KhkE0b9n3LZcpBIcj0FmR+Q3Wljifd1KILRxw8l1XIeH2+BT6X1Oc9b2p5mWaJ9Fc
         5ygTOoVNKxX6WfvjKG2NpmDdk75wxF9e5wrMo43ZJi6sI2vNhBTO5ZEe8IgML6uXd+UC
         wpBSYa3wEnARzu2Ov6Q0k4UQdAscV3pxzCEaBgXvaDlzRBVcGqIN7Z9rXSFRmECypFDh
         9a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766594610; x=1767199410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwIk1nvhH1d/vdoQL7AOIOe4muNkhVEYe/P22V7V6vE=;
        b=DYP3bLVeDvhGvMe0rhhZFiTUqKKgX1XnPtvXCd+tBkfxLfSpcnb4uZK/4spj0dTTR9
         CjKooiFcqgh7aKDMUgowuikf2rK8hP3tdEfCDNptRGDkj6ucK7NLBU8pLQQbzTyNhfEc
         skYHxuu8W8CaxXMVlM51lKMUxlDHQY5UrkkJJuzRcabBOfsjlquTDy9M5RfgTa5LezCb
         O4jXVW4nQrrtqCMBZb6HZyUTRci0cr3B+e4Rf7IGngcTWbUTnbeAD36YmuwJwxKqN1UL
         JdfD3g7ZzgSEWsr0e5DvM0r6C6yXq6HMOYsRsLuRqDCFsNFx0avAZLsyAf1bjAGnmRiO
         16kA==
X-Forwarded-Encrypted: i=1; AJvYcCVNROYpTq73hN50SPusPEbFbqBVhyfY8um2LeMlnWTMErOEldYS46CmX7FrA7r9awRTqPppTUfEaynWzOB6IQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDmOj2WGJIbNDOHfjuc+67dZaF6/CtNqZuiJ6tm1cHNRACYk5v
	lHX1rKHwhv/KUcYPv8OU3uDN10b6QWEhlBktkW2ypWpaRRwW6+jxkNJR
X-Gm-Gg: AY/fxX7mHQ5S6h8nVEl0hxt3y78IOCbuX2/mPuB12o53oE7bE3iDzkSyZ+YxQdL4aqP
	o7PdDknFJniKQ1vpSLYExmJUEyYN0KnvcyEutXDpbtGlzRxnb9HtFUFMUHl9+yC/b2AZVDifpvw
	1XY5q9EdAyyOX0R0g4Y5ADU8YLhl5iN7l+mmRTHuuqzN7l34HSz+GqhMPcFEZD5+vLyibhsyvW4
	bhn7znWR+rdJmqAJrd5o28lHvitqVFzCEcPr3qRk/lFDg5xA09MEYd3nKVXAUAAu/32wBzp+b3I
	Hea+t8CNlqX8UEdKbyW+4KK694vYGI4Tv4LLLo2RxC9yi8Hf3aqi6G5ZQozzmt2E62hjS6bRpsK
	OuB0gQflU9tmrBdxWLO1dLn59cVLXf1h9iW6qKeEkJjE+rsw4cdVHovikzeDcveDMje28rdROok
	HSrkyzZtx5Bk5n65I2rM+s+IcX2k/pVzG567JFytwOd7elK6OJH1hXBV/UiQ==
X-Google-Smtp-Source: AGHT+IESvaaiYDz0FQXnk+cOSP0Y3BphqGxvFTMbynES490LRlFZ6uF+ljLMEtDR9jmc0Xu4izDLEA==
X-Received: by 2002:a05:6a20:a107:b0:364:31e:2cb1 with SMTP id adf61e73a8af0-376a7af61c3mr17802942637.17.1766594609908;
        Wed, 24 Dec 2025 08:43:29 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7d3sm19211220a91.4.2025.12.24.08.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 08:43:29 -0800 (PST)
Message-ID: <0c94aed3-bef9-4ae8-b9fa-bf2db113eee8@gmail.com>
Date: Wed, 24 Dec 2025 23:43:21 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/24/25 07:52, Jason Wang wrote:
> On Tue, Dec 23, 2025 at 11:27 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> Currently, the refill work is a global delayed work for all the receive
>> queues. This commit makes the refill work a per receive queue so that we
>> can manage them separately and avoid further mistakes. It also helps the
>> successfully refilled queue avoid the napi_disable in the global delayed
>> refill work like before.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
> I may miss something but I think this patch is sufficient to fix the problem?
>
> Thanks
>

Yes, this fixes the reproducer in virtnet_rx_resume[_all] but the second 
patch also fixes a bug variant in virtnet_open. After the first patch, 
the enable_delayed_refill is still called before napi_enable. However, 
the only possible delayed refill schedule is in virtnet_set_queues and 
it can't happen between that window because during 
virtnet_rx_resume[_all], we still holds the rtnl_lock. So leaving the 
enable_delayed_refill before napi_enable does not cause an issue but it 
feels not correct to me. But moving enable_delayed_refill after 
napi_enable requires the new pending bool in the third patch.

Thanks,
Quang Minh.
