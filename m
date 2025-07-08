Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8E20B80D
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986714; cv=none; b=pAQVy5dHHDT+OLUoGMUaQ9F/GuM5+CivJdfhIec/hp/e1By63Git0A67PETWTVfKKA7t5S5mS1vjZfqdh0nTyWeYkhUoUzPvPomwGaSIupf0fEmv8i8HLq8S5JMmhmIsUxccNQPg/vr6JDwXjXPA3K5hBQ507QcbgUOxYX2Wpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986714; c=relaxed/simple;
	bh=+NqjU4uQXlMtOkNUF+YqZyMgp92MuypF4BvPFXX8Ve0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxucAh/6T6Yvd/3DU+eOrWREqqmVrWv18dEwKKwG37nMOipSkiWv15wtCqVdhJz8faH3PmVyYC9MSSfoEOF+QIMny8hHtjoz6utq52JefeZO0E//LeMICXInxSfIjY8OXp1x9P6qIqgyGQz67UyaSBotSj3wBGjNPh/diLBOt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ohsq2SUe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ohsq2SUe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23508d30142so54411735ad.0
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751986712; x=1752591512; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWScCBjnLf2R/TIfIIUf9QArMhSADm4WDSoogHlveqE=;
        b=Ohsq2SUeHPYt13fAs0t5Z6NwtVNNqxcey2ITuPR4605Wue+UeIt/69omPvgVpuAo/A
         c3LKKPMvZIzqp10OlIW/OmZmrS4B4geETHLf8UoJa2ygIkA/nG0PPsQyXUMNgUT+4zuO
         JAoRzDlLDlOdZtVyX3ZJQtsHVk7YtFP0tCoBNddmRe/0fKqzE6v38EUzIXPTRULcj7JJ
         YhwBVBX1sWz6Hp6gYZ9FPEt8NJ9DI5KEtQldtEUcSF21OaXfJZgLqeqxYhj50eo/CJHJ
         EwXrktARyepVz+071t2+nBl3kfiZ/gH5YCpQ+HToBSLkhAERxg0axJ2HIxDRIinyc4r/
         LNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986712; x=1752591512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWScCBjnLf2R/TIfIIUf9QArMhSADm4WDSoogHlveqE=;
        b=PzPFgItrPAw1ZV9lnDOwbQmDb79SzyL653GQe4qc0zOgkV5xQtEeQPmCnjWcjnT35P
         6+h0zpwpO112L/7jNNLM8VPmrt5sn0d5hTuvB1eIEyDqNoKY28+Jpl9bISBU7AN1VkeN
         UDsYScdEFvytByNqpMpzuWNq/evRBJgDcSG/b5IZY2+3aVLZCE7NXNeA+GmA3GtO0UWe
         kRfDwJ2Kb9vUU/ApQoz0ayPTPP5+pSDyt9/5c9cQyf8Q04SkDnOEXp2/HUhyinKgLi40
         DnERdhySbyenk9j1ey6YwM18umn80LWX/kI5LQxcX1FEA1pRrv8k/5NVyc2Tuu2ZIhhS
         cZLA==
X-Forwarded-Encrypted: i=1; AJvYcCUYAHNjY1xvr+3m1R8EcHaj8eo5cCWmJHrnV+V3smdi7cORC8xgvuk7VC3c1TISV2vUAFCwEhbcC/DF3BhFfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTwJdzRqJO4l7aewzjURuS1nNN3cwIK7YN81kREmSZzsyLWuiL
	7MM5TY7yvrannkrdg5vyzY0rJESFhAilXOKuUmuTiFc6udR5RTIN1TQ8
X-Gm-Gg: ASbGncvBEyXvmouId+dYdQ5HFgzXhM2jEWztzT72xXjY0Xpb5cVu6wX5lVCUoDh5pVw
	vl2GfYwLWnhproUMaPwVcTtXElrgAmfXPSB40FehWSrwwVUSdI2H6gxnKP3tWgBa8TwnrPDJ0FR
	ozRUhs6m0Bb/D+aZtwnoONRqWWa8XipPN71wc9eASTLwcueinA+qSbwk2KnHjNgV0tdWwckW1/f
	ZAMB53fO3jUVWyTNuXaOzqutF2ISj3YSoKyTNQ+d08pIkkhRGZ2z8bRuT0hcRk2InZS0gIErnTP
	2E0drOJD5SzvnV1RZVbkMHw/CDjXbLWJNjwwQkUpsn/aacaMZROpGCbJXTv2z1RSxKxnbqRCPDW
	9zsIllRISfCwpFl/Jx0nbT93ozJLyjptJzfWE3pFE
X-Google-Smtp-Source: AGHT+IGsiWMFIFsAbr8aNOe79of4TnBXH6qxow/kWKTKfQRaWTwycD8M4/HGPfM50XdIS7N54Zneag==
X-Received: by 2002:a17:903:40d1:b0:235:ca87:37ae with SMTP id d9443c01a7336-23c85eb057dmr299625885ad.41.1751986712178;
        Tue, 08 Jul 2025 07:58:32 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a? ([2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d153sm115207925ad.94.2025.07.08.07.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:58:31 -0700 (PDT)
Message-ID: <a9def060-375b-4980-8ee5-e5a54fc6cb8c@gmail.com>
Date: Tue, 8 Jul 2025 21:58:24 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
 packets
To: Parav Pandit <parav@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Minggang(Gavin) Li" <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
 <CY8PR12MB7195AC4C23690D748ABAD675DC4EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CY8PR12MB7195AC4C23690D748ABAD675DC4EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 21:52, Parav Pandit wrote:
>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>> Sent: 08 July 2025 08:12 PM
>>
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets"), the allocated size for big packets is not MAX_SKB_FRAGS *
>> PAGE_SIZE anymore but depends on negotiated MTU. The number of
>> allocated frags for big packets is stored in
>> vi->big_packets_num_skbfrags. This commit fixes the received length
>> check corresponding to that change. The current incorrect check can lead to
>> NULL page pointer dereference in the below while loop when erroneous
>> length is received.
> Do you mean a device has copied X bytes in receive buffer but device reports X+Y bytes in the ring?

Yes, that's what I mean. AFAIK, it's not checked in the ring level.


Thanks,
Quang Minh.

>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v2:
>> - Remove incorrect give_pages call
>> ---
>>   drivers/net/virtio_net.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>> 5d674eb9a0f2..3a7f435c95ae 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info
>> *vi,  {
>>   	struct sk_buff *skb;
>>   	struct virtio_net_common_hdr *hdr;
>> -	unsigned int copy, hdr_len, hdr_padded_len;
>> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>   	struct page *page_to_free = NULL;
>>   	int tailroom, shinfo_size;
>>   	char *p, *hdr_p, *buf;
>> @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct
>> virtnet_info *vi,
>>   	 * tries to receive more than is possible. This is usually
>>   	 * the case of a broken device.
>>   	 */
>> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> +	BUG_ON(offset >= PAGE_SIZE);
>> +	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>> +	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>> +	if (unlikely(len > max_remaining_len)) {
>>   		net_dbg_ratelimited("%s: too much data\n", skb->dev-
>>> name);
>>   		dev_kfree_skb(skb);
>>   		return NULL;
>>   	}
>> -	BUG_ON(offset >= PAGE_SIZE);
>> +
>>   	while (len) {
>>   		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset,
>> len);
>>   		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>> --
>> 2.43.0

