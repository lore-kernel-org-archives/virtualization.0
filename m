Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFE2F85B
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985067; cv=none; b=V0MMIxN1472KlpeasIS4BOM+N79JjSHvuudiXe49EyKR05vemdi3DOhZU+ZMCg6SG9owWvTNvQyP0EhxTSUMyTCkY1Xy5uT44g5il8uaulp/NwPYOt5FG8or7fhdfF6eDSC4XH1aIMqcvm5pFkSQ8MxqsL870CW76X3AAnYlNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985067; c=relaxed/simple;
	bh=OuHY8n2Odq3N7kvzxCgurj7dAhMVYiooBCIgediBTMY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eycjUB298YkZxWWqznLgMoVuL+1iLUysvRhiQM4B3kYAFkYStTODj3CFfVInH80mvFAKRMoWp6PJfSDCF9sAt0ZBV+JvZfT9EUwTOERX+X+x2yu0BLY/s69NeQZdSUVNwCf7LceVBgyvaMxBpnv9CuMFsy9hacw+3MmtzoBuN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImQe6bwS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImQe6bwS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b52bf417cso2876899b3a.0
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985066; x=1752589866; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BeYXPTb5LA7yVu+YZrMTInys/k5EZTTHl3niU3gqITo=;
        b=ImQe6bwSF2Loic/KA0eyebYn0r+9gqFMabFdwie0Xvj5CjUryC7FNGHNld/V5aD31N
         XYauloMm2zmOMDUEnB+J5DDFEoQYoMGjEAMOlld71YMbNv1lG/fFw+4u2FSlyOFm/jSi
         4dovJze1/Yk7mKu2Ld/6w8SsG6JBBKG3sTfljxRDbSSeClo2PGYNmcGdFbWOfGqjxP2O
         ccxUvntBsXjLygs8iU5u9QV+Pw3hJY8ov77OZi4oG2hkFX+nIUVf/R9DKk5xb7AicaFn
         DDv76kUkQ/iXc163g0h7yBEVjB9b6bYnQXULi+CSZVFBe7MMWDI/kQtjxWwSdu1Pdqn/
         VTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985066; x=1752589866;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeYXPTb5LA7yVu+YZrMTInys/k5EZTTHl3niU3gqITo=;
        b=Y/QqDCCnteETWAPWUlomrwNwToB6oohObiB+SxTLvh+23uwHPRNVAXZIDMMG3yNJlt
         ysZlET2isuJMuyOAcRGyUpU99W7yJJXzCR9vonNt+o7FfETCsp6Bljj9aAkl9nUXYPIb
         LTZKurVTrzPlgIW7AxfrjvGRRp+BMnCKccoBiVfS+ppVx8BUrtfPpt6PUxmERmAUZzDe
         6DWQHwz6rAd+pE4jhVxXEOk++jLImUc8CeH3berm0E7m/dwcJMfeSt0A92TQ8QXwtRZw
         sK/1i6omInMpTTJbxjOsBdaD23EOtR8f7aPf5pR0ZI5suFLuk6kZ2GIBvTD3YMFUcBT8
         qL3w==
X-Forwarded-Encrypted: i=1; AJvYcCX9+mbNMlyeGuOUU5MyqjTQQagD7TOCxdfkMN5haUN657kHIbjvg6TPzYmUYk1aM9dyR4mRklYzuFsFAAm1zA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL8OVaKjxf4uFpShmaVVaVWNUHmCJ9GHHKZK1Jzta7t1q/BBDK
	J9XVmifhWXsNtMwby8OyTP8n/W5nYFXem3+1TTZcoNKkqAY2lN+ke2Xb
X-Gm-Gg: ASbGncs8lDHouecQfrPVKw9SBnxhT+GiBvFKF7d9+/qVnsy3bxPzo3Bb7G42AXKI9g7
	88LbZQur6nXzNX64VE58x4VgAguoiGuGhW0DHsz1xEeU4I09SiFMKelrftJ5N1s+OFuk1JU24oT
	fH7LFV+vBSjJIEPdSysX+uDzDz0muON80O3DBTzdrEumbhFdaKfYQLefwBNHP2CXKURbVVO3IKT
	+bL7rxCBTHomnDFFGyDp2rkWR+5rlNrrwbkKKLMRmbj7JH8lfvS5Kvb97TW2/18scFO5P7p5Q5f
	Aow0KFsN1Y4rkiRVJORbflonu0uAIMSklCdZ8uZgSkkjnDkN5T3GA56uHZ/b9RA1GeFfVU/ILIb
	RTqhcxr8oSk4OkI/Py+MLTzT7BqzYRZnoL3BVdyY=
X-Google-Smtp-Source: AGHT+IGi9NKWi8E6Z/7yPngDFJ9kYl1XknUux47tkMEMvUexqOhrnZdk0a18FdQITKgVztDsHDC/LA==
X-Received: by 2002:a05:6a00:b89:b0:748:1bac:ad5f with SMTP id d2e1a72fcca58-74ce65a909fmr21643923b3a.12.1751985065387;
        Tue, 08 Jul 2025 07:31:05 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a? ([2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35d0014sm11883826b3a.67.2025.07.08.07.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:31:04 -0700 (PDT)
Message-ID: <a9e0138f-3d8a-4178-b765-869de8ab13b6@gmail.com>
Date: Tue, 8 Jul 2025 21:30:58 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: fix received length check in big packets
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250706141150.25344-1-minhquangbui99@gmail.com>
 <CACGkMEvCZ1D7k+=V-Ta9hXpdW4ofnbXfQ4JcADXabC13CA884A@mail.gmail.com>
 <9fa577cf-0999-431c-bfc9-e7911601543c@gmail.com>
Content-Language: en-US
In-Reply-To: <9fa577cf-0999-431c-bfc9-e7911601543c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/8/25 21:26, Bui Quang Minh wrote:
> On 7/7/25 10:48, Jason Wang wrote:
>> On Sun, Jul 6, 2025 at 10:12 PM Bui Quang Minh 
>> <minhquangbui99@gmail.com> wrote:
>>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>>> for big packets"), the allocated size for big packets is not
>>> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
>>> number of allocated frags for big packets is stored in
>>> vi->big_packets_num_skbfrags. This commit fixes the received length
>>> check corresponding to that change. The current incorrect check can 
>>> lead
>>> to NULL page pointer dereference in the below while loop when erroneous
>>> length is received.
>>>
>>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for 
>>> big packets")
>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>> ---
>>>   drivers/net/virtio_net.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 5d674eb9a0f2..ead1cd2fb8af 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>   {
>>>          struct sk_buff *skb;
>>>          struct virtio_net_common_hdr *hdr;
>>> -       unsigned int copy, hdr_len, hdr_padded_len;
>>> +       unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>>          struct page *page_to_free = NULL;
>>>          int tailroom, shinfo_size;
>>>          char *p, *hdr_p, *buf;
>>> @@ -887,12 +887,16 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>           * tries to receive more than is possible. This is usually
>>>           * the case of a broken device.
>>>           */
>>> -       if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>>> +       BUG_ON(offset >= PAGE_SIZE);
>>> +       max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>>> +       max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>>> +       if (unlikely(len > max_remaining_len)) {
>>>                  net_dbg_ratelimited("%s: too much data\n", 
>>> skb->dev->name);
>>>                  dev_kfree_skb(skb);
>>> +               give_pages(rq, page);
>> Should this be an independent fix?
>
> I've realized this is not needed. In receive_big(), if page_to_skb() 
> returns NULL then give_pages() is called. I'll remove this in next 
> version.

It's a wrong fix actually. Calling give_pages twice will create bug.

>
>>
>>>                  return NULL;
>>>          }
>>> -       BUG_ON(offset >= PAGE_SIZE);
>>> +
>>>          while (len) {
>>>                  unsigned int frag_size = min((unsigned)PAGE_SIZE - 
>>> offset, len);
>>>                  skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, 
>>> page, offset,
>>> -- 
>>> 2.43.0
>>>
>> Thanks
>>
>

