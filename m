Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DE1DE2A1
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430666; cv=none; b=XmSCw6vxmQwgPkYaO6BRL/JGbJ5Usu6lnNkPHlEFGfbLosbllU6lrLQMIoZtkE819opT/9PnxKfvThvLpTvpYaE3quphj/cjQHAegZxrEqLL7tix8sdVEgpGxzeidbF4vgKyHrpDJd+V6ZUDufB2nN55Jhn7SLfnkMXGl0EIVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430666; c=relaxed/simple;
	bh=wA86OvXvQW2Wk0ySWN1S8dAXgWbBM9cP3A1cI9Z6u5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m72coO+j73HYXg00lXh0yCszN8OC1pRV+2h5uVk6S40mPDsfpG8Ls9msOwzhb2KQBB+mw60D3uqGbRqzZDE8zaby3tarjz3FLN5obuwsdBbxXNBYB79MG39V1fnzRzQT6P0tqYlfe4bk4OOCFa+f3ic5/IP/AirYmL1txKYz9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXS1gEJj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXS1gEJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746430663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbQ8Ebd7T0AIaFrJMEa7u08GAGQmcdkDS4quExidCGE=;
	b=RXS1gEJjdqJJjGzcdwYJC26o/62iUqfvjeNzD0P09hsGQ8xP1mAu1tHihp28JtdxUA7Wlq
	AytQ41x0vbVX0KSMavJrspJ+P9wklVr7Ro4fRhKTl5Eees8KMC50r4Mklp5F1uo033RQTB
	lH41B+4gTsbSMmd3cpGwRZUp27I86xk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361--IM5sKCZNfiNR63EF-7YTw-1; Mon, 05 May 2025 03:37:42 -0400
X-MC-Unique: -IM5sKCZNfiNR63EF-7YTw-1
X-Mimecast-MFC-AGG-ID: -IM5sKCZNfiNR63EF-7YTw_1746430661
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39abdadb0f0so1062728f8f.0
        for <virtualization@lists.linux.dev>; Mon, 05 May 2025 00:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746430661; x=1747035461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbQ8Ebd7T0AIaFrJMEa7u08GAGQmcdkDS4quExidCGE=;
        b=eLiIPTSRo0BoR0KSvGulmS/os+Qzab4kzZBjqnd2BZcOsHUBSNwtftHm1lvz48wzWC
         JUe9AJClTqsFLugkCbYA6mPf1DjNtENc//nka1GGLxixRleVtcAYRryfbRS4TctUdRZl
         +gvQsOW+oOlyOish/pAlFFA6oYj89V4tu5x1u2SbbKcSHeOhARy9iAT1HnHCvjF5aS3y
         Pe6j18h53zEBYEW430mI/fi83L+nxz3KsFd10/ewHHurKsbjQA5Q2O0kQtYNhptTMtPR
         d269Q/MkSyDJ/hVDG9QjT66Du9/VNt8KxvVI2r/WyRkNJKvkFkRGLtz6zzzeffT2B51n
         DqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmDA//8ascab1q0BzmHGzd+tQrEl819jha4zIvUgjiZZ1rVErBbBnvtUPNK3TmB8OvH/sz6dNeOaevsrL57g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3mP1te7n7xIVJWjY2KipwwWQSr15bUpnpu0v0+F776sa28BMp
	Ocd2A5wJOrmMsTDFPYOmH5PFPb44h6Og/093hLPT6c9K7TrkZYx+EpouTUTkwERoRC501hfiyPZ
	rexDo6IMEeew8ndPG1UOE1v7APJ4forAgZyiPHjHG3R8pvMKV3XcvTsStMRgUbZkm
X-Gm-Gg: ASbGncvcMbO7DhzW0W4kx/LNiuuOKT9Uhp7jsYYI7n7h8Haq0KwwBJsEPC2U2t887et
	pdPI2l00+wtwvSKI8PZLVKhMihq/rl+GQr+eKdFLKU92rZMMq+Q4STcAvIouwq5vb821gJskEMu
	3T707WccRjj1TTGf2m97t5S5vHGUlvzugyyNY03DdGQfDhjXaqA2rDZETyFOzz0nKnnQG7dAns3
	IwSyoqGLDpuHx5X3KroBlRD+uqN3XxaXJ00SkHB2hT1x01MTQIRMY8WNAV0JmVsioLnhbCPxMSO
	s+FFvmAuGe4eg4qxPAsDC2F1uizUplfrUVFiVFz82zivtdB6ryt8jpLED9A=
X-Received: by 2002:a5d:6711:0:b0:3a0:a0f5:1b02 with SMTP id ffacd0b85a97d-3a0a0f51bcdmr2980340f8f.25.1746430661016;
        Mon, 05 May 2025 00:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXPgUBS6oLYKFEGfiQb4hNjm4EqETq0WQb6mbrzb4uGVHXyVmTL98k94ybGGle6pM8Sc5r1w==
X-Received: by 2002:a5d:6711:0:b0:3a0:a0f5:1b02 with SMTP id ffacd0b85a97d-3a0a0f51bcdmr2980306f8f.25.1746430660573;
        Mon, 05 May 2025 00:37:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b172a8sm9666263f8f.91.2025.05.05.00.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 00:37:40 -0700 (PDT)
Message-ID: <1710b0e0-ec7a-4d79-89ad-ad9d0cf58f5c@redhat.com>
Date: Mon, 5 May 2025 09:37:37 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, io-uring@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250429032645.363766-1-almasrymina@google.com>
 <20250429032645.363766-5-almasrymina@google.com>
 <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
 <fd7f21d9-3f45-4f68-85cb-dd160a0a95ca@redhat.com>
 <CAHS8izPr_yt+PtG5Q++Ub=D4J=H7nP0S_7rOP9G7W=i2Zeau3g@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izPr_yt+PtG5Q++Ub=D4J=H7nP0S_7rOP9G7W=i2Zeau3g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZK00cYG0HU2rZlsvhXMCXup6t5gw1BB590gt_cPlY4A_1746430661
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/25 9:25 PM, Mina Almasry wrote:
> On Fri, May 2, 2025 at 4:51 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 5/2/25 1:47 PM, Paolo Abeni wrote:
>>> On 4/29/25 5:26 AM, Mina Almasry wrote:
>>>> Augment dmabuf binding to be able to handle TX. Additional to all the RX
>>>> binding, we also create tx_vec needed for the TX path.
>>>>
>>>> Provide API for sendmsg to be able to send dmabufs bound to this device:
>>>>
>>>> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
>>>> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
>>>>
>>>> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
>>>> implementation, while disabling instances where MSG_ZEROCOPY falls back
>>>> to copying.
>>>>
>>>> We additionally pipe the binding down to the new
>>>> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
>>>> instead of the traditional page netmems.
>>>>
>>>> We also special case skb_frag_dma_map to return the dma-address of these
>>>> dmabuf net_iovs instead of attempting to map pages.
>>>>
>>>> The TX path may release the dmabuf in a context where we cannot wait.
>>>> This happens when the user unbinds a TX dmabuf while there are still
>>>> references to its netmems in the TX path. In that case, the netmems will
>>>> be put_netmem'd from a context where we can't unmap the dmabuf, Resolve
>>>> this by making __net_devmem_dmabuf_binding_free schedule_work'd.
>>>>
>>>> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
>>>> of the implementation came from devmem TCP RFC v1[1], which included the
>>>> TX path, but Stan did all the rebasing on top of netmem/net_iov.
>>>>
>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>>>> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
>>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>>>
>>> I'm sorry for the late feedback. A bunch of things I did not notice
>>> before...
>>
>> The rest LGTM,
> 
> Does this imply I should attach your Reviewed-by or Acked-by on follow
> up submissions if any? I'm happy either way, just checking.

Should any other revision be required, please add my acked-by tag to all
the patch except 4/9.

Thanks,

Paolo

