Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95319AD5C
	for <virtualization@lists.linux.dev>; Thu,  5 Jun 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134014; cv=none; b=tWAMZ1pPKqXON4vJOMIRR8lP83V7bmIB9GQz+IJ5vTU7n0jhEZOVUDr875ij2jkxU9MceaZvUENfRggxxVKz51TyIr3qxpYko4X6ubdGQip6NffjF+AM28okWdp8Cd5FYq1H0GDMhxCky3WSDRkGc9z7j3pul4wqPDpDdyIIBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134014; c=relaxed/simple;
	bh=tr58EZgbVcJISngjP+ObYSCUQbAQYsfVcd2Vwdp3hD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhGOjePFXhDAEYoypZqklx24DRYVwjP+PGYDs2rvbrOX7uwmzc9u0LcnB9C+Xh0Gtimo45kKB5fG2ETlNTFQakZRcojOKogTXtOsjn0KPdOsn85eyZJ1C4IFFxWuQnaBV9vCt5aRMln6MHj5JKf9BfT6MF8JMz0IvDKzNhVMeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlBDzfEl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlBDzfEl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23035b3edf1so10003475ad.3
        for <virtualization@lists.linux.dev>; Thu, 05 Jun 2025 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749134012; x=1749738812; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9avWjVFt6aWkiQYT2o6nDnnWjkbc+AGyVyiibpfVvU=;
        b=QlBDzfElKnjOz++QYD1czQRGYEuzyyYxtugPDWMRXbWeSwzeST9yuZbw4kcl/xNybK
         1kbHpG0Y2wRZ3btMhV/j7eZYX8pfOkIwGLpC3OTdAd8huZ0tXsbqyNnJxB/kMGH3ypIQ
         urVhL/gMgisn4cD6RlVm0tXPBLLYYA70XSFcwht4XU3zVe7P49gxXz5zdeShG6KC27d1
         fXelcu7HbWuVoyMKmg3g2sKkikHEMgCXFDY/hsTHW5B8jIGVeA0JpFqz7ldPViHzB74y
         y7o9frk2dDIAPZNLJMPFBD0c+TN9fVEuTLZsPYSQjmQUvRN5g78ILofP3vrb36pJ2LF5
         VF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749134012; x=1749738812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9avWjVFt6aWkiQYT2o6nDnnWjkbc+AGyVyiibpfVvU=;
        b=foQT7rufJOpivb9YE5lvNd95bEeMbrKIcSp9uGY8aDV4aZ8IKDtDjhbYZPCmzA27y3
         UIrG+qSdG+oTSPPKU4AD9HQFgY99z9klrtziIaifTa6ebDf6Xad0QFhK1OxyDgRb5e8V
         xJ+hY8GKS0e4dkcZBJw3BddJnzhSoU+ESwO53F4VvLOc/7aeYMM/4StkT2Oc6DB9/rnb
         ooaO2pY8+84fZns4fqvTH7wHXRghGKYHpZRrz3YUofAHktvtWLLmqhLZBzL1W9hj0B4V
         JkHzTRbvErMXev/NhzJnzFeJQkOuySyFej/ZqTQc8fVBpn3yRHayWwV3Ww1Kk7YqAbE6
         pYFw==
X-Forwarded-Encrypted: i=1; AJvYcCVmdSrrwrE72yYbiSl6O79IqSTiWUyjThb8ehNff4I4+2k4gHmwTiEnrcl6uylwpgsKRjZxB9s0yJiuXS/iMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7l0KJyHHK8udGVNEfcz5J09dGuRzZWareHc/xiT7Idd9w9kMZ
	UbAGvpKxDVqVurRSVaVtmXS4uVAfXPcrBmOCAFgLVGuIMVr2ROvgPDx8
X-Gm-Gg: ASbGncuyW3jz6MwgNH3CLwiaAE3fV9IhQiVrox31ovfMkRgJExcrd/V2oztvydTfzCI
	lwtKkTL4dOFVwbYGHg8KJAleWLm7nNJyc5a9jKjjnYYb6Njm+KI6YuXt/Hz0GKTR1DK5RkCi8F4
	QON3dIuQV7BQicyxonqzLxSfBCjsGGHHa741ZWmvHdqTnrs7JJ8ivVpBM3czYt7qOxz8YoYE/66
	3N/aFq++Wacx09eQLwHXbuudH5KnK/z3elghB7rsW2ESQg7XvbfcvlfO84uuXmP/3HOPlzsvGrY
	PiJK8D+sp35pv2ODj/S+GsXnUQwmAb3vXai8qX876XhUfMRq9ZGXmIRdqw+vI3vtJOnFFB/Scpj
	tre1gHcqhxF2hw7Ml69KZ6ZRGUMY=
X-Google-Smtp-Source: AGHT+IHoYsehzq4W4hQnnnjTlH/Y7tcjh0kuCIpQiDNFzibOyjGm7QM3TfN7RjAAdMWkvPfyNTl5uw==
X-Received: by 2002:a17:902:d550:b0:224:1af1:87f4 with SMTP id d9443c01a7336-235e14bc5d2mr113225345ad.22.1749134012316;
        Thu, 05 Jun 2025 07:33:32 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:fe1:cf75:ee2d:d934? ([2001:ee0:4f0e:fb30:fe1:cf75:ee2d:d934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd8cf0sm120472525ad.155.2025.06.05.07.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 07:33:31 -0700 (PDT)
Message-ID: <f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
Date: Thu, 5 Jun 2025 21:33:26 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 18:03, Paolo Abeni wrote:
> On 6/3/25 5:06 PM, Bui Quang Minh wrote:
>> In virtio-net, we have not yet supported multi-buffer XDP packet in
>> zerocopy mode when there is a binding XDP program. However, in that
>> case, when receiving multi-buffer XDP packet, we skip the XDP program
>> and return XDP_PASS. As a result, the packet is passed to normal network
>> stack which is an incorrect behavior.
> Why? AFAICS the multi-buffer mode depends on features negotiation, which
> is not controlled by the VM user.
>
> Let's suppose the user wants to attach an XDP program to do some per
> packet stats accounting. That suddenly would cause drop packets
> depending on conditions not controlled by the (guest) user. It looks
> wrong to me.

But currently, if a multi-buffer packet arrives, it will not go through 
XDP program so it doesn't increase the stats but still goes to network 
stack. So I think it's not a correct behavior.

>
> XDP_ABORTED looks like a better choice.
>
> /P
>

Thanks,
Quang Minh.
