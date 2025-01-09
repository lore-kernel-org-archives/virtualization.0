Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D12153FB
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415500; cv=none; b=eAssENT5tAxe1wxtNoOuAvTvwZNFcMT1xoRFHXx339foRkEWdVfXbY+EqZNYAsAm1Wyqr2jxWG5hEZ3dQtf15tXpCzik/ikHNMk+QV32s/Dcz+K/wHNVpaWHlD67y86I6+J+/NWEoGb5Z5FbxFgXR/BmlA3zR7QJ9/9TV+obXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415500; c=relaxed/simple;
	bh=Mf8o7lroOT1imCTt2bwlE12K0z806yPl+dcKb86wiOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mx1MalfH27VYXABr/kuan3C+AeuHBx7k0beeqx0wO8kSLnsoLeiPueID8D5KMF93VdIyWAP1SNhfBt67h/2XBmI4OSmcO8oPxDQgrn8HeETVKLaVGu+Bjp/cEeaH+SeLtVm+6/V3+eo19mwawa4fBXBbW8OgWhAauTt728O5108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=deHHq6f8; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="deHHq6f8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 352BC40482
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 09:38:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ST1Dg1vQ7A0l for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 09:38:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1CDBA402AC
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CDBA402AC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=deHHq6f8
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1CDBA402AC
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 09:38:16 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2164b662090so9722105ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 01:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736415496; x=1737020296; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iX5Xv7vZXmp6Diw4dhkXM/NBpxHnqibMmwyNh801U+c=;
        b=deHHq6f8KHnTUVyareHeRmgCfetIvkm8Un9kwIBE6UxCyGkxggmy99TBf1gFKnLplO
         EMDMwftf91Xya1Vd1mY/38/WJV3m6LdYGbyIUJsk7TDtKR2enA4xCHtF6nPx0ZuyE+bY
         sOcUWYK2tYS7r0bqCouxcnh9ic9BUhAwyfGwSlIZFY49bWRl2Eni/f2VBa+1KNIluihG
         13TAump7ju/y+xaIrw0ZVkM+jIl5WP3TXl2K9xKP0HQ4wH0Ih8WisXb1LEdeDki8XwbQ
         H/KppKWJZ5ZqB/z1jkCi+iU1MSkq7D7LVgHNXfSUK3KQ8QzaDXBJtrgd8CVpRDmFZGNu
         jJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736415496; x=1737020296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iX5Xv7vZXmp6Diw4dhkXM/NBpxHnqibMmwyNh801U+c=;
        b=ThUxz0OOVik6LP+zsbwxJKxmzFAc/Q6qnOhIhKCfGhYggksuKiL3iL/FkPwGmH7l+p
         4G9UGlRaKdT5JI3r5K62kc6EohCJGaKG7+Oka7oGHpsobs1F10fZCzF+YMlGUnqd9CNC
         OoKe/UNP49TriW1GIkb5TiMcUhhrSE5TeY4pxdCt48MvvenHB5hnITx3yl+tdzhOiqZS
         pDuV8+ELtN4AwDEKCxwL5ha1CWrX8BgC584+bCTTLe4piMrl896xBESZX4hGW6n0lZMO
         lbCz6oxhm0kLY4oiDB8KPMQwJdkIqZJXPDYIs1h0gmzeilM05+X50NLgMk1dpg3QEf1X
         rp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2PJvw5nvSt/nie+WgMDADK76G6b6JhATBLVlWdHeICGPf/mkr14KwhL8PBAmHZmxnN7JpT/S/cMjrws1/Rw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw6dDQSPhJdgsa/BxMRqz/WSbaVNLgMAnU6MLh3XtIeh0RWyP3U
	42rUqRFjybh9VzXI7esFIcPdJeFFCBSeNWdq9Qmo/0zitdI4a9oDxxNL7NiHvRo=
X-Gm-Gg: ASbGnct5FBOBJtKdZ9HqU1d5hmotkgoXOqO/Y16oMDjY2PXxWgh9LUbsPSJmfi26Tlw
	aCoNm8HFDedbekihwsn9k225MCqKAOPZZq0Y1qKsuAXpeA9kYzt12NTVweJGBwSrqq5CjF0qzCN
	qOllxUf5RSvDL+M7ltcbktyyoZboBz0ljGRVkJAOA/DT3Y7wu4KykFKisfVWUZXHq3vH/A4AwLU
	+o38zdw+R3LTtFEUCsl8IG4nWN5vsusHNmawC0sIZa/oEbZzeY9eymcsnyZxxcZDVc=
X-Google-Smtp-Source: AGHT+IE6uJuEESeHnIQxeeue01pEKjS62LqgqXa6Hf+8Q13I/VJgPMpbucR025bUQAgc88TrZ6Nz2A==
X-Received: by 2002:a17:903:1251:b0:215:9894:5670 with SMTP id d9443c01a7336-21a83f591cemr79565855ad.16.1736415496269;
        Thu, 09 Jan 2025 01:38:16 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a917687c0sm8556475ad.17.2025.01.09.01.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:38:15 -0800 (PST)
Message-ID: <ad580d7b-2bd1-401e-bb7b-b67ec943918f@daynix.com>
Date: Thu, 9 Jan 2025 18:38:10 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <20250109023144-mutt-send-email-mst@kernel.org>
 <20250109023829-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250109023829-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 16:40, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 02:32:25AM -0500, Michael S. Tsirkin wrote:
>> On Thu, Jan 09, 2025 at 03:58:45PM +0900, Akihiko Odaki wrote:
>>> The specification says the device MUST set num_buffers to 1 if
>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>>
>> How do we know this is v1 and not v0? Confused.
> 
> Ah I got it, you assume userspace will over-write it
> if VIRTIO_NET_F_MRG_RXBUF is set.
> If we are leaving this up to userspace, why not let it do
> it always?

tun may be used with vhost_net, which does not set the field.

> 
>>> ---
>>>   drivers/net/tap.c      |  2 +-
>>>   drivers/net/tun.c      |  6 ++++--
>>>   drivers/net/tun_vnet.c | 14 +++++++++-----
>>>   drivers/net/tun_vnet.h |  4 ++--
>>>   4 files changed, 16 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>>> index 60804855510b..fe9554ee5b8b 100644
>>> --- a/drivers/net/tap.c
>>> +++ b/drivers/net/tap.c
>>> @@ -713,7 +713,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
>>>   	int total;
>>>   
>>>   	if (q->flags & IFF_VNET_HDR) {
>>> -		struct virtio_net_hdr vnet_hdr;
>>> +		struct virtio_net_hdr_v1 vnet_hdr;
>>>   
>>>   		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>>>   
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index dbf0dee92e93..f211d0580887 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>> @@ -1991,7 +1991,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>>>   	size_t total;
>>>   
>>>   	if (tun->flags & IFF_VNET_HDR) {
>>> -		struct virtio_net_hdr gso = { 0 };
>>> +		struct virtio_net_hdr_v1 gso = {
>>> +			.num_buffers = __virtio16_to_cpu(true, 1)
>>> +		};
>>>   
>>>   		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>>   		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
>>> @@ -2044,7 +2046,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>>   	}
>>>   
>>>   	if (vnet_hdr_sz) {
>>> -		struct virtio_net_hdr gso;
>>> +		struct virtio_net_hdr_v1 gso;
>>>   
>>>   		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
>>>   		if (ret < 0)
>>> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
>>> index ffb2186facd3..a7a7989fae56 100644
>>> --- a/drivers/net/tun_vnet.c
>>> +++ b/drivers/net/tun_vnet.c
>>> @@ -130,15 +130,17 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
>>>   EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
>>>   
>>>   int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>>> -		     const struct virtio_net_hdr *hdr)
>>> +		     const struct virtio_net_hdr_v1 *hdr)
>>>   {
>>> +	int content_sz = MIN(sizeof(*hdr), sz);
>>> +
>>>   	if (iov_iter_count(iter) < sz)
>>>   		return -EINVAL;
>>>   
>>> -	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>>> +	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
>>>   		return -EFAULT;
>>>   
>>> -	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
>>> +	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
>>>   		return -EFAULT;
>>>   
>>>   	return 0;
>>> @@ -154,11 +156,11 @@ EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
>>>   
>>>   int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>>>   			  const struct sk_buff *skb,
>>> -			  struct virtio_net_hdr *hdr)
>>> +			  struct virtio_net_hdr_v1 *hdr)
>>>   {
>>>   	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>>>   
>>> -	if (virtio_net_hdr_from_skb(skb, hdr,
>>> +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
>>>   				    tun_vnet_is_little_endian(flags), true,
>>>   				    vlan_hlen)) {
>>>   		struct skb_shared_info *sinfo = skb_shinfo(skb);
>>> @@ -176,6 +178,8 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>>>   		return -EINVAL;
>>>   	}
>>>   
>>> +	hdr->num_buffers = 1;
>>> +
>>>   	return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
>>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>>> index 2dfdbe92bb24..d8fd94094227 100644
>>> --- a/drivers/net/tun_vnet.h
>>> +++ b/drivers/net/tun_vnet.h
>>> @@ -12,13 +12,13 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
>>>   		     struct virtio_net_hdr *hdr);
>>>   
>>>   int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>>> -		     const struct virtio_net_hdr *hdr);
>>> +		     const struct virtio_net_hdr_v1 *hdr);
>>>   
>>>   int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>>>   			const struct virtio_net_hdr *hdr);
>>>   
>>>   int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>>>   			  const struct sk_buff *skb,
>>> -			  struct virtio_net_hdr *hdr);
>>> +			  struct virtio_net_hdr_v1 *hdr);
>>>   
>>>   #endif /* TUN_VNET_H */
>>>
>>> -- 
>>> 2.47.1
> 

