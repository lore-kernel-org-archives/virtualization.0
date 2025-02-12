Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C725A355
	for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375548; cv=none; b=dZJL3sxEoIXw7yg2xHizWE8F7WaIOI/NnK556Ir9oXrpj+EtCH+DEW3rel4lN5IfVBDm2YN7jYMgkupVmbXq8Nxzwz4x6kmRZHjwvpd478Iwop9aDnzRGr83uxGhfEfz9EWPAi/DqsoW71VgbzYSugIlfcSikYHEV17MxrpLthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375548; c=relaxed/simple;
	bh=jrXhWYnImskFko9wBtv2JPSJVKz9x+wgYx6uQ0eFWZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=My0wpQ6wP6lkejBZupCvNF4G6CvRDuzLv+d6L87f0eJVE6OvqmyaxDwJ8ce7LOdtrjOrGctHjVWTnIGjQl3+PvZnrQeqSkLlyBpCKHY9gflm2K71Dw+eJHL4Nm25SfaUAVI1zWuDd/gf2e7fx4eR6J8LGn+m1vG2zeS48tyJKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NessjPhH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NessjPhH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so5456928f8f.3
        for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739375544; x=1739980344; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zy76W96ncGtjcIE/1RFX9zT9Pr7PxW1QtkdC0k/xF7g=;
        b=NessjPhHTs8jVNFwiTZNGjrepRGwBVJyvAwRodmqMixSJ2GdYhMqtZ2aQEiuQy+CE+
         0KMDe+8hqEERfu7+JSSuDJZ/KiDC13zGuXISrVneA4L6nYVT10VhqhbCcITay9QWUyR6
         a2NYaY7qnLhc+aWUocLvVx1WtiHzkW1kJcFqr0dl/cbYafS/iZuWfw34mA/6ISB4Qwjz
         wT3fR8Y69T/r6h1FUg0t4itCoorNnAGVAAXfYB+l6bpB96Oi5CYsAUNXwPM3VZH2dsEs
         SIHGVfbPXCiypp8lTNKPnRd7tzB29Vsn8/JT2Vp2ZbnZCYgZhuMKqAq331UctIFDmKQt
         nkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739375544; x=1739980344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zy76W96ncGtjcIE/1RFX9zT9Pr7PxW1QtkdC0k/xF7g=;
        b=LAcj+F67XI/j7g0mLnOofHFBsECpTdm9+q37R00dVdppQILDuCPxzpCAQoGnuvc7xn
         k6lAEiXIUBIlFJumgsg7M/nmZhvob6ZSgBIZDLDVJE03U0UNb9VYBRSKhc3CGCf+BWNN
         5DcVvRZVPOvEmiTYJEterXiZmeJyIzzbb0NZK3Q0erIgjkW9y9RDk2ae/MsGtkqT9RjN
         i/lwEn+ggEq2G0BvMU8Kg52iZVK6I4iJTXOZRJ2dSoMLmyvwSLr1N+XyPMeeM8qQprq1
         ARiayNv/K+z/sjbvXNYN5+UAOi6Tyxr7dkgWzT/Ljw/Iv63AvbqQC20oOPtHUHSSGnLI
         9ZuA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVgSNd2UkENX+rvKxbElyI1O/2HnBD9YaYTq44Efqnfmx9+vuk2V6IWdTaDfIcQTuih8nULbF3yW0pzKWDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLuYZcfLePAm/s/NrVaBv2woPEjbNvOo6cLKa+I/ec9H7td6Zg
	G8ToQCa+E8VGtoTZVgDEUGhYf+2s+2nVqsPhnLBgyNS/oDIIL3Yb
X-Gm-Gg: ASbGnctuhJNAijZJ0Ug7KVk0P/nH3qlpLAfGkO8bvupCaaKmmb0zFMfug91dJw7qYrN
	OMHXCinUb0rZwvBxd0QNU/9ufGvwoAvxUR5qx2W5VWG2ccVgtU2o7hAn3+MPY8wx/mnVZfmrsMw
	QaQGV26GAo4M6DDtYBg7cmKzjmRF+xqdddQtJA3yYLfibUCccPIJ8alxBiNu93MY0pnyNWPV1yO
	mI9BPI69/qFLYXLr75AqgZb1iXYf2ljEKyUhe6qw21ifW6pTcxIuiJXqkgBWK9+S0DaDEVMsYUE
	ZKOsixfq1l479Q4C6eDprXzT
X-Google-Smtp-Source: AGHT+IGpD+27wLo/4uLAUDA60FDap/eR74/Ue8vD3BXCKcQh+GD2m9lFZwxy9qa3lhW3DrbvJ0WWIw==
X-Received: by 2002:a5d:6da5:0:b0:38d:eb33:79c2 with SMTP id ffacd0b85a97d-38deb337a6cmr2961051f8f.32.1739375543490;
        Wed, 12 Feb 2025 07:52:23 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee2fsm23278465e9.4.2025.02.12.07.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:52:22 -0800 (PST)
Message-ID: <28343e83-6d93-4002-a691-f8273d4d24a8@gmail.com>
Date: Wed, 12 Feb 2025 15:53:23 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com>
 <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
 <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/10/25 21:09, Mina Almasry wrote:
> On Wed, Feb 5, 2025 at 4:20 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/3/25 22:39, Mina Almasry wrote:
>> ...
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index bb2b751d274a..3ff8f568c382 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>> ...
>>>    int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>>>                                struct iov_iter *from, size_t length);
>>> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>>>    static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
>>>                                          struct msghdr *msg, int len)
>>>    {
>>> -     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
>>> +     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
>>> +                                    NULL);
>>
>> Instead of propagating it all the way down and carving a new path, why
>> not reuse the existing infra? You already hook into where ubuf is
>> allocated, you can stash the binding in there. And
> 
> It looks like it's not possible to increase the side of ubuf_info at
> all, otherwise the BUILD_BUG_ON in msg_zerocopy_alloc() fires.
> 
> It's asserting that sizeof(ubuf_info_msgzc) <= sizeof(skb->cb), and
> I'm guessing increasing skb->cb size is not really the way to go.
> 
> What I may be able to do here is stash the binding somewhere in
> ubuf_info_msgzc via union with fields we don't need for devmem, and/or

It doesn't need to account the memory against the user, and you
actually don't want that because dmabuf should take care of that.
So, it should be fine to reuse ->mmp.

It's also not a real sk_buff, so maybe maintainers wouldn't mind
reusing some more space out of it, if that would even be needed.

> stashing the binding in ubuf_info_ops (very hacky). Neither approach
> seems ideal, but the former may work and may be cleaner.
> 
> I'll take a deeper look here. I had looked before and concluded that
> we're piggybacking devmem TX on MSG_ZEROCOPY path, because we need
> almost all of the functionality there (no copying, send complete
> notifications, etc), with one minor change in the skb filling. I had
> concluded that if MSG_ZEROCOPY was never updated to use the existing
> infra, then it's appropriate for devmem TX piggybacking on top of it

MSG_ZEROCOPY does use the common infra, i.e. passing ubuf_info,
but doesn't need ->sg_from_iter as zerocopy_fill_skb_from_iter()
and it's what was there first.

> to follow that. I would not want to get into a refactor of
> MSG_ZEROCOPY for no real reason.
> 
> But I'll take a deeper look here and see if I can make something
> slightly cleaner work.
> 
>> zerocopy_fill_skb_from_devmem can implement ->sg_from_iter,
>> see __zerocopy_sg_from_iter().
>>
>> ...
>>> diff --git a/net/core/datagram.c b/net/core/datagram.c
>>> index f0693707aece..c989606ff58d 100644
>>> --- a/net/core/datagram.c
>>> +++ b/net/core/datagram.c
>>> @@ -63,6 +63,8 @@
>>> +static int
>>> +zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>>> +                           int length,
>>> +                           struct net_devmem_dmabuf_binding *binding)
>>> +{
>>> +     int i = skb_shinfo(skb)->nr_frags;
>>> +     size_t virt_addr, size, off;
>>> +     struct net_iov *niov;
>>> +
>>> +     while (length && iov_iter_count(from)) {
>>> +             if (i == MAX_SKB_FRAGS)
>>> +                     return -EMSGSIZE;
>>> +
>>> +             virt_addr = (size_t)iter_iov_addr(from);
>>
>> Unless I missed it somewhere it needs to check that the iter
>> is iovec based.
>>
> 
> How do we end up here with an iterator that is not iovec based? Is the
> user able to trigger that somehow and I missed it?

Hopefully not, but for example io_uring passes bvecs for a number of
requests that can end up in tcp_sendmsg_locked(). Those probably
would work with the current patch, but check the order of some of the
checks it will break. And once io_uring starts passing bvecs for
normal send[msg] requests, it'd definitely be possible. And there
are other in kernel users apart from send(2) path, so who knows.

The api allows it and therefore should be checked, it's better to
avoid quite possible latent bugs.

-- 
Pavel Begunkov

