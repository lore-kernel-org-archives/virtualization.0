Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714319E7E2
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830328; cv=none; b=UKKruulFq1WTRNwyc4Tg5AOfFglKVctJ1l2j/oxyJsRYeFA0oka/KGTFZBbhebyW+udXsnlI+PcNP1rr+nqNFFvnlGk79fF523xr/2eIKMZe9zW2YgZDTBiegMkx5bWRmIL7mJ2uFUNXICsX7vslh20ajIHzBAJP/N5OcoXupzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830328; c=relaxed/simple;
	bh=jHspmyvQYxNtlI9sxlSzz47M3IR/Dsvnejhvt4pQ7kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvG3TzwaGfJMouHlNBAgUEmfUY72w0wH8fNUfU8vSO3PNofDsN4EHHqkjLc/MqJ4fNhCw0DkzrMWtsxur0LNAzOOl/hgYmpzXI4BNfDINbgr8oynS9+ZYdAth99ri+STUC3u/2I4GUlu03OR9V4jSgFELDQ+z/ESUR7laccpdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUpZ0ybE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUpZ0ybE"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350fc2591dso22533645ad.1
        for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749830326; x=1750435126; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QN6pByW5k+1ZTsCPCBrvGzfPYIjlhF9IzLERSPXHg6s=;
        b=XUpZ0ybEf8RjsEd9+syDRcJMaut4X0fDd/i9kE9J3Nz3lBERO/3ofZQkhy8W1dK8z+
         kXJKzI5DcxxStghTQmyT/Q8o8LbYEEFmMIE3loQT6+voxfvkA2SzJNUriYCGIgFmJYgj
         VDhpwV5qKtWMU2gxKuUcaGkgy+Hw7mbAWyM1JAoekzBIrfl77Q1YucJ2UDplNqyAHXpL
         f5/lOdS8u0hz2PYuG7Cp/yHMK6udvU8qGT/apSST+vkyo9Wds3ePUpr1MW/lp1DgSFiL
         8kg7UxOa5cyCQBKVhSspEyFPN3Mt9TT+1uLkddPTfgIWg2wiZ9gJwRKeUQ7VyYi+RcsK
         uyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749830326; x=1750435126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QN6pByW5k+1ZTsCPCBrvGzfPYIjlhF9IzLERSPXHg6s=;
        b=qTTtyS1FATANuZjUVSHnqcUZiCwSmkI6oYlBUVddFv7VeJuc4t5qiyev1EXiDbd4A5
         uIcALHuNoff+8+sXW8vvSCOp9ktShLCEAs6abPp4swx3S0yapVQmy1TOEoeWq76BmldA
         CcqN90tHbPGkJl4i0pnCsLkYa98srOk6njquFvxcfEAlAmjhzJB8X1TtNsWbJKBZTOJ1
         ASa8j1njM67nE/vSu1d4k7XC1/+mpshrEujfVynsI2sbJZmvAA8WGQk083tpnUcFrqhW
         AzJTVykB2Lx5MjYQbcR1NwJJUK02Dxw4FOYmMiP62rs6bVgryQSsakcGvVSsQjgl2xu0
         vG3A==
X-Forwarded-Encrypted: i=1; AJvYcCU3YgHSHeCEjbKdFgUO7j630d+mDZar9FXXU3qhIW+V5DVJPC3TazJPBtOpQitz9n2E8odov30qVD2T+9ZTRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YweXgkYlefGWD6vztuovp6rE/T+m42szZQL14tHtan4slIyYalh
	33kDB/32gh/IK+GsUfQ9UuZVURqRaH+8l5jOs7LKGvBbCzJxe7czLCLA
X-Gm-Gg: ASbGncsmUNYLL83R5nvZ0u8Wr0jrTh04DqmdgkMrjNVvElBhi3sI1xlnlcji4hd/DCa
	fFdmpBM4cWRR2E/VhR+j9Rt7tov87A8CXTGZUyF3xPzv//Ee1qKTOKk7yJvRsqyr5oybvVl3mPc
	NGXyZenRe+SPWJhTr+1He8VDLGA7Jm+A2/KvvSla3YHBn4jOxGQz1tgv9spZOCWTBj7QcILtQoI
	RMOGub2kyTz+hypdhKEbG4GBJqt3N6PHrTajvvvfnYym85TpZsQan8EuX4w3XwvFzazQEOYz1/j
	/Wh3BhyDrpD2HCrviyQVuej0nFruf5QISwlYb7OSEU8lR28qd2fXTTlOq2VERp+inqMInqnpoIQ
	h3i+t1xzkvsv+Kw0k+Da1Mu0MXR2lxMdhwM/ow4lN
X-Google-Smtp-Source: AGHT+IE49Pb69AIw0IS9/8YqLJ7V6KI3z9sFVxvTeTw1vDhGs4tCHtUAJ+SZdvTjEVwhLWGuNznZpQ==
X-Received: by 2002:a17:903:320b:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-2366ae41407mr2879835ad.15.1749830326267;
        Fri, 13 Jun 2025 08:58:46 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:3762:5a1d:19b5:ad26? ([2001:ee0:4f0e:fb30:3762:5a1d:19b5:ad26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78176sm15999775ad.96.2025.06.13.08.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 08:58:45 -0700 (PDT)
Message-ID: <9dd17a20-b5b8-4385-9a61-d9647da337a9@gmail.com>
Date: Fri, 13 Jun 2025 22:58:38 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
 <f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
 <20250605074810.2b3b2637@kernel.org>
 <f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
 <20250609095824.414cffa1@kernel.org>
 <e2de0cd8-6ee2-4dab-9d41-cfe5e85d796d@gmail.com>
 <20250610133750.7c43e634@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250610133750.7c43e634@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/25 03:37, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 22:18:32 +0700 Bui Quang Minh wrote:
>>>> Furthermore, we are in the zerocopy so we cannot linearize by
>>>> allocating a large enough buffer to cover the whole frame then copy the
>>>> frame data to it. That's not zerocopy anymore. Also, XDP socket zerocopy
>>>> receive has assumption that the packet it receives must from the umem
>>>> pool. AFAIK, the generic XDP path is for copy mode only.
>>> Generic XDP == do_xdp_generic(), here I think you mean the normal XDP
>>> patch in the virtio driver? If so then no, XDP is very much not
>>> expected to copy each frame before processing.
>> Yes, I mean generic XDP = do_xdp_generic(). I mean that we can linearize
>> the frame if needed (like in netif_skb_check_for_xdp()) in copy mode for
>> XDP socket but not in zerocopy mode.
> Okay, I meant the copies in the driver - virtio calls
> xdp_linearize_page() in a few places, for normal XDP.
>
>>> This is only slightly related to you patch but while we talk about
>>> multi-buf - in the netdev CI the test which sends ping while XDP
>>> multi-buf program is attached is really flaky :(
>>> https://netdev.bots.linux.dev/contest.html?executor=vmksft-drv-hw&test=ping-py.ping-test-xdp-native-mb&ld-cases=1
>> metal-drv-hw means the NETIF is the real NIC, right?
> The "metal" in the name refers to the AWS instance type that hosts
> the runner. The test runs in a VM over virtio, more details:
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests-on-virtio

I've figured out the problem. When the test fails, in mergeable_xdp_get_buf

         xdp_room = SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
                       sizeof(struct skb_shared_info));
         if (*len + xdp_room > PAGE_SIZE)
             return NULL;

*len + xdp_room > PAGE_SIZE and NULL is returned, so the packet is 
dropped. This case happens when add_recvbuf_mergeable is called when XDP 
program is not loaded, so it does not reserve space for 
XDP_PACKET_HEADROOM and struct skb_shared_info. But when the vhost uses 
that buffer and send back to virtio-net, XDP program is loaded. The code 
has the assumption that XDP frag cannot exceed PAGE_SIZE which I think 
is not correct anymore. Due to that assumption, when the frame data + 
XDP_PACKET_HEADROOM + sizeof(struct skb_shared_info) > PAGE_SIZE, the 
code does not build xdp_buff but drops the frame. xdp_linearize_page has 
the same assumption. As I don't think the assumption is correct anymore, 
the fix might be allocating a big enough buffer to build xdp_buff.

Thanks,
Quang Minh.
