Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D232D44F
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230381; cv=none; b=tWU/VEVF5XQqaLiM4bMOG7jTdKHDK0+xMGuQG1FQ9gFTcQtGg1GW3r8e468vzYTwGtVq6T9FjEo4w08PiXqnctxkwq4qPFkO3vuFnqtN8cNWZNby2VbL+XpV56ymRBDWePbageeTKIBCIqCh/v/OLPfWvJjX/rTTbemz6HG4hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230381; c=relaxed/simple;
	bh=K6yURn9UYOo/OGlw/SxR7FpRD28Usu6/d+6K4vyqldg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/6r95sjff49ERAjaxMDkAtzA9GrNdVKuU638JwMZMdgeDVeFZQDwZykPEFAu1U45UQDmwMWD8AdxIb7CLpL1ci2XvPHaxLzfi9zspvGcalynQrfdYWAJX2RmK3osJ6ZPSVs1gLlJ3/wKHJmMeDSfXcv9UCNJnLmxH4y+6MaPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9GVmICo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9GVmICo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29292eca5dbso12477265ad.0
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230379; x=1761835179; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3zBGPrVkQkNSFhl6cJF22SK2sjH+IBauiisvtj1eDE=;
        b=Z9GVmICojd78Hoy6v9QnPCBfuXyiKTN5RYzXeUu2MvPyj63NVEeuzjFNSsWRELQzoK
         QLZwLnUacaHTY9kefi5FQa2k36xeM6l1QApHFRL+aa3n95jaqmPBQiypKlc1VP1YXl4K
         GmHI04DlYQm3mGIa956GvysP4+lYJJUUUaQqRg/jfLvLdXmEpDBofEaQ0cWmgvoWL8bi
         3HxbPO4mJZoDpBe3Y0/8oekvZmHO47Psmeo8aFKodC4sZAXU1Pzuujnu96pq5cOWn65o
         HSupmZnZucUacNdCt2wPtW/qzs5u/etdtQzcD+WBVMapJwvIs0540z92EwjXlIZXSiTy
         u+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230379; x=1761835179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3zBGPrVkQkNSFhl6cJF22SK2sjH+IBauiisvtj1eDE=;
        b=vAujEypKZKTcOYUq0rO6rVd9d+6DooNBl/Gs+671BV4mQjl5WX4ESPSlQZUMSxfuG9
         19ozUk8TjUXQw3Agbfzw9OiUTTGoyC9E9BALXY9NPGztsu56kR9hhhqNHE0GdzX0+IVy
         /oBJAhQwAZMknfAsiwcsMRUIf2BUn0zRSUnZywb0RMJldSXQnN2CQ5o5yI7dNBmFtFFY
         qsI/v2/5eAC8fLrQPZgtI+1rcaSBtEPgd0XC02IkZrZO1Iq8Bo/OMGBz+fQfbUjYUIIU
         h69AucUHuDT0TiRNoWEhVBLZtZjmCGjI5Cd7lHcYZoxKeTP3HF7flE+pp5JFq4lbSQ8y
         eXPg==
X-Forwarded-Encrypted: i=1; AJvYcCVhzJgVIuvNyPqsQ13Kk3/RU9D7q4W0IvTor1/JIUvCjTo/u4ZZN7VEjJwzZN/6N3l8BfIlGRk1fx/W0jpOsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEaGyBKgfv7G51IzyoxznPFu8RxVsZJIzYg7Z5vK1ttXDzExzx
	JEgLnLI18oZL2EP5Kw5KS62p7nUNP51UXoLxnUZMsEFnT7WZoe0dacT/
X-Gm-Gg: ASbGncvD4L1aI547+lMAY4qG5UkXaeoxmb37SSPS3nosOWH6G7YJkZ8mSkE9gvXMJWP
	IO6fGpim2LJ7NEvoVWHBZnAvVxfWGWXBObcH6t5+qzQ87W7AD00QYqH01Bn2ujUWZ9Kv+V81jfA
	c1cX9p9t3BXKSOb+0kWq1M1np6pI6T5YlPs0Cp6ORubeXzDsf0YVHMy2JCe4bnT8c+eK32/6PHa
	2fkTZzut8h45L4paB4EyTjhnDPrpTUp7a9NYpQE/EKYrP22u2uYe6GF16fKGeHt80o32YnJXsXC
	VtDVSpycpzMHrhDAw5fOkVQkmN1xBI2orSnqT0IE2SzQd6IW4arQee+jXLD3EL0MXHXCuteZq/U
	+hGJkP/bM9cOaiG341wbKDzv3CR1HAGqYnYkR+5+pod8UBYtSg6MNVoezIGAJ5iAnDWQAjM0z6l
	MfLa824/4jt3RdgdsYo72JXiSt4UCdzdOpgscPk6uWLQM4SWCmgyQ=
X-Google-Smtp-Source: AGHT+IFucwEwOTFxaTJoVOzjbuSgOqn6+M6IcAfQome0saJAV+NsptRDrBbl50zj7o+T/juUYZJt+A==
X-Received: by 2002:a17:903:1a4c:b0:27e:f201:ec90 with SMTP id d9443c01a7336-290c9ce63b3mr295801785ad.25.1761230379128;
        Thu, 23 Oct 2025 07:39:39 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4? ([2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc1c8asm26155705ad.71.2025.10.23.07.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:39:38 -0700 (PDT)
Message-ID: <cd963708-784a-4b1e-a44e-6fb799937707@gmail.com>
Date: Thu, 23 Oct 2025 21:39:30 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] virtio-net: fix received length check in big
 packets
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
References: <20251022160623.51191-1-minhquangbui99@gmail.com>
 <1761206734.6182284-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <1761206734.6182284-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 15:05, Xuan Zhuo wrote:
> On Wed, 22 Oct 2025 23:06:23 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"), when guest gso is off, the allocated size for big
>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>> negotiated MTU. The number of allocated frags for big packets is stored
>> in vi->big_packets_num_skbfrags.
>>
>> Because the host announced buffer length can be malicious (e.g. the host
>> vhost_net driver's get_rx_bufs is modified to announce incorrect
>> length), we need a check in virtio_net receive path. Currently, the
>> check is not adapted to the new change which can lead to NULL page
>> pointer dereference in the below while loop when receiving length that
>> is larger than the allocated one.
>>
>> This commit fixes the received length check corresponding to the new
>> change.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v4:
>> - Remove unrelated changes, add more comments
>> Changes in v3:
>> - Convert BUG_ON to WARN_ON_ONCE
>> Changes in v2:
>> - Remove incorrect give_pages call
>> ---
>>   drivers/net/virtio_net.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index a757cbcab87f..0ffe78b3fd8d 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   {
>>   	struct sk_buff *skb;
>>   	struct virtio_net_common_hdr *hdr;
>> -	unsigned int copy, hdr_len, hdr_padded_len;
>> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>   	struct page *page_to_free = NULL;
>>   	int tailroom, shinfo_size;
>>   	char *p, *hdr_p, *buf;
>> @@ -915,13 +915,23 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   	 * This is here to handle cases when the device erroneously
>>   	 * tries to receive more than is possible. This is usually
>>   	 * the case of a broken device.
>> +	 *
>> +	 * The number of allocated pages for big packet is
>> +	 * vi->big_packets_num_skbfrags + 1, the start of first page is
>> +	 * for virtio header, the remaining is for data. We need to ensure
>> +	 * the remaining len does not go out of the allocated pages.
>> +	 * Please refer to add_recvbuf_big for more details on big packet
>> +	 * buffer allocation.
>>   	 */
>> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> +	BUG_ON(offset >= PAGE_SIZE);
>> +	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>> +	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>
> Could we perform this check inside `receive_big` to avoid computing
> `max_remaining_len` altogether? Instead, we could directly compare `len` against
> `(vi->big_packets_num_skbfrags + 1) * PAGE_SIZE`.

That looks better, I'll do that in the next version.

> And I’d like to know if this check is necessary for other modes as well.

Other modes have this check as well. check_mergeable_len is used in 
mergeable mode. In receive_small, there is a check

     if (unlikely(len > GOOD_PACKET_LEN)) {
         goto err;

Thanks,
Quang Minh.
