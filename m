Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C55256C8D
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984807; cv=none; b=tgC5FFlCoC/Z4rhkmI9voIy+K+68bDYV0zW6QA/wL2WFozKZPh4SmxeNejtHr2gNseR0dMTMUSG3BqT2JgBpDkiFQY7Eez3b/ME5k6FZH9nM1snXdSd4RGPCe36TS4oVI/LAcdmSwDlX/e9YuP3011rxEUFVDOe9W07anY1hfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984807; c=relaxed/simple;
	bh=FnMJBbKPiDFO1AIn7dnhFfO7zlcFSBcjt9eAlqWtieI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=By4x28ThHl4zFJONwu6iN1Qi8pR7tMuAxRb9WQZXXe0j8gxM+RqOyrA+DQ2qvkZSwIkAA4NsCag3hLUbdHLXCrTJw0Y1xQY9pjMA4T8qhfE52AQpuMmYKy3WT9gQMPt2wdBNvlin92e8U4OA7s0uTV9TMPDg2uDVkrLL+YE/lPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXJIgmm4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXJIgmm4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73972a54919so3968966b3a.3
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984805; x=1752589605; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+V/4hzINiNtnwUKYapOA6OBBGlFzgjmnEijOcNgHxw=;
        b=gXJIgmm4VIX+9JyLszDo+HU2uHZbE6aGWsYyRT9u9UM+KbN4fb4yL16MZV0FNDyBBR
         WL5ZMeeC4UZeUR0SSvdohOr3QsKr5fQt4PBOAOwD83q4ltM9DSxcv63ksLbrRUSLIJSM
         TqO0d0RRE2xvvgodssWn//PWWddzdkoVS1zih1jw/8CPW+ncAj9sFCGdlRfdHjV3s6a3
         JYEfwAc3MP3E7K6bfBgDwMNCeEpjSX3FWbpLkV5Zg+XjJFJ9rexOLVF1qEE9+x/In0Z5
         lxy+HhWCcxCH3Z9/vWroW07ojb54fR5dGx6WiJZVmK7UNGt+Zby2EAAf391pqfX8pSis
         sB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984805; x=1752589605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+V/4hzINiNtnwUKYapOA6OBBGlFzgjmnEijOcNgHxw=;
        b=idFM++ucgljWgD9q/NPEdqsx4PQLKXNicQ/LWx2uw7yBfaeIMo0C+YEjbYk8QwuaL/
         LiZ16bSVV2JNrZoc3GdRgAyz4OFj5gOuz984BVJfD7rorUft+IgGtKKQBBz/P6XnYuL5
         kLw2UAmBeHmLlvHpCRs7ud9A+e4tqzyK4xfgzErt+CUzK5zQnFM6BHUXvORhQScDCyBF
         aowR0e9+oQf89YmKY61XMxlzljsuMIFTFYXIqarEqPAlyQvD8GIxc6c9M875T3wSJ0nQ
         r1mNFvpTQpQ7vCZdd1s7TxoC9jq5Gmb2tRy+c/ZOCsd3JuwZGmVlWZ2h8VBigESr1qGB
         wiXg==
X-Forwarded-Encrypted: i=1; AJvYcCVBBGIMZRNXHhCWDK9en6JALopJscCJzLIb7r50JBiRqM+1dVqJ89p+JPnzT2vCx6FWmTX+oJkpzIohX2SPVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnIFken/Ei66XSbYVQ+CLppFdnprdyB/4BaOB3DPxUzDrSLRpE
	bqoZT+ZGjW/6T8e8X7PTw6TjtwmYfAATuK5XF4QkRtyQhJav+zcdfhdj
X-Gm-Gg: ASbGncvoT87+eEPxZfyPUApAlrQfve607wEIMO5MuNNoIVvsHMR8VCIGYa8LGsHGW4V
	Mnph5utU/EU4i2hCCaWiSAZt6sGpNB7L7ePIxQa+UtyUO2R7OOS8M4ZhRJVW8uG7c+ZqvzSCYpd
	44UWwyiUDe7GiiXoW1natZ+NfnNG1cL4uLNM46giYJLdg7dMiGHdm0nCT9y8Deb2WE+xrNpMbbe
	cc2XlQPmwEPWTuV8GkPmYeCqbeX/Jg+wu2CB0FkMZDnv3MvCEwrddbnkWdIEFYLuGpaT3xYC19b
	yI3OippNRTgyF4hkWCbyeXqoPslN8Fik88XwXslVn4O57LK53pDnCjtA+8tkhCHHxNTJ8FmcQjX
	6GXnZUe2Jak6Zcm/k2avr+eb5+Sx12VW+Fm6v3VcL
X-Google-Smtp-Source: AGHT+IGM8VTrVWuRijpvW/6zRn7zP7Y3/ODvDnK8T/rQZXTP+qzbmuc4pfDOBx/ywvZQREAbUs9kHQ==
X-Received: by 2002:a05:6a00:3c92:b0:73f:f623:55f8 with SMTP id d2e1a72fcca58-74ce88249b6mr19245771b3a.5.1751984804772;
        Tue, 08 Jul 2025 07:26:44 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a? ([2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce4299c3dsm11944325b3a.116.2025.07.08.07.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:26:44 -0700 (PDT)
Message-ID: <9fa577cf-0999-431c-bfc9-e7911601543c@gmail.com>
Date: Tue, 8 Jul 2025 21:26:36 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: fix received length check in big packets
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvCZ1D7k+=V-Ta9hXpdW4ofnbXfQ4JcADXabC13CA884A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/25 10:48, Jason Wang wrote:
> On Sun, Jul 6, 2025 at 10:12 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"), the allocated size for big packets is not
>> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
>> number of allocated frags for big packets is stored in
>> vi->big_packets_num_skbfrags. This commit fixes the received length
>> check corresponding to that change. The current incorrect check can lead
>> to NULL page pointer dereference in the below while loop when erroneous
>> length is received.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 5d674eb9a0f2..ead1cd2fb8af 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   {
>>          struct sk_buff *skb;
>>          struct virtio_net_common_hdr *hdr;
>> -       unsigned int copy, hdr_len, hdr_padded_len;
>> +       unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>          struct page *page_to_free = NULL;
>>          int tailroom, shinfo_size;
>>          char *p, *hdr_p, *buf;
>> @@ -887,12 +887,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>           * tries to receive more than is possible. This is usually
>>           * the case of a broken device.
>>           */
>> -       if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> +       BUG_ON(offset >= PAGE_SIZE);
>> +       max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>> +       max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>> +       if (unlikely(len > max_remaining_len)) {
>>                  net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
>>                  dev_kfree_skb(skb);
>> +               give_pages(rq, page);
> Should this be an independent fix?

I've realized this is not needed. In receive_big(), if page_to_skb() 
returns NULL then give_pages() is called. I'll remove this in next version.

Thanks,
Quang Minh.

>
>>                  return NULL;
>>          }
>> -       BUG_ON(offset >= PAGE_SIZE);
>> +
>>          while (len) {
>>                  unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
>>                  skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>> --
>> 2.43.0
>>
> Thanks
>

