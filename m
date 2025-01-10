Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCB207E05
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497729; cv=none; b=Xa76ppQoRZaK0bYR3fdW4KkbOJZuyso9CDLLs2YKyaaJzVZ7VHFvF1YwU+hxZ9nMRLujBR9dyEkN4/eOCKf4sAlSf7zMuXSoKGsOZ71Seuewy4o7ppzdZ+DrLz5NR+500p3AE2wnLOQk7p/4qpQKZChl7FrBDfCtoyqoxbkvcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497729; c=relaxed/simple;
	bh=mpE7hYntObRlHLj2s8ybBavAi+cZh37RwpDamWOgN40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CLgv+e97YQ11NiW7TpTqXcYEnJDaNkUKKtjad0ewsO08nA8wlpWINma85FjMTLfas/ATRHlP0+bOGqzL4TF8jqmiknLZrHyTh+fZ5m9mcjq5frCmKAie/gWlyUgmJsA2b5dzsTnfVn90M5FbO2eOUx7FIZ3e2O+7IYJCsisaVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=s49S3miz; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="s49S3miz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8B1D4103B
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 08:28:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IdHytGud7_4J for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 08:28:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 478BA404D1
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 478BA404D1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=s49S3miz
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 478BA404D1
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 08:28:46 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2166022c5caso27834765ad.2
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 00:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736497725; x=1737102525; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMHAnr47gYJmPF4Dg6UKLdQQ9r7gUgpmT9CNdLeTBRg=;
        b=s49S3mizcR/1LGiRx0WJVoCimHs+jf9kYByJxw5rPMyVeSiWfXdHeIRMY2cEzItd/b
         +PamOr1Y93BimeTDpJ8eRfqkWKq/5mlqSu+isO6H7XsiJ84tyGxB5EXetqmyqDsrmFIN
         Mor40isDGxwagkooVtf3IoVcLX5eRX7i58PD5o5WAZBUWHskbSEplQaxfKv4b+nFUG/Q
         bHlzXkWlTXgbYiosFhtQtQf6u4Jc3g6eHr71FCKlRwb/QAEpa7XEL4zjn9W3o+hQHrpj
         3Gmg08UOE+51IVOhKI950MJlyuGznIUR+PFuhKB6fmjNq16v5Iq1VXfKmOCck09prQ2s
         ZGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736497725; x=1737102525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMHAnr47gYJmPF4Dg6UKLdQQ9r7gUgpmT9CNdLeTBRg=;
        b=px5N8Qh+7P7/fv8XyHFz0gMwTEJvcU1jq2x1Gadrbu9n1ATe+UsaBLnICikNW9AOnz
         K9H2qiinEzGOyoo0/x5XVmxwLxl8YQlxn5YUAwSbhX9Xrdf6cEYkzDqwzP+hCC9cfa2Z
         kp+EE/uRnXGlE67J7780dWRQzasB0vqd9c08yi/48zSficSvU6tvZiTRp2mQ6XLodZq1
         l8OqhtjY1tYjCQiluNrTfIO3M2hQldHMatfmLwq013DM3ysuIzQEX2+2kmdb9qPRLsiv
         koMhaUdn0ss8qnPDWS8LTWKbwiKqPYYnJbe87Bu5Mw0ispYXhN+GqrX9S9tGt8AfkzjX
         J+wA==
X-Forwarded-Encrypted: i=1; AJvYcCWWfHoAVHwd0Ta3N5nH9rX95QVW11buHpvq9YqdlCUWps3fVnGiAztfjeNGtm0sCVjTG1+ZHfys4ukt/zAYlg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzfo907PApeR4tqykIA8Y/4wYk2hAt8rjlOQWMF2Z8NUwZUCyp9
	0xEoEy2GjvZSXkjk5zKrtX/ZbQytCPCjlqvRkXpUjqW11iBQczH/5QzDppAGD54=
X-Gm-Gg: ASbGncsDeXVude2I9CAPbz5SBYmIRY9P7YgmCmZoHW4ClJVREqAPAU1ejWrGmqfih0U
	uYuD4f/FAo9f1eqihA1n0YmPEp2Kw7jfpF3vknnnxGiGqqnrWyCN3oBleRVlwx5H2rZGm6b6v2r
	QXBctboShehyuqUOnwSB/Gy34J6XMefgtPzPPx1MQH6I4GL/gnjKyEcZOusTKmTvf5xaKpLo9W6
	1TvXNLrrFEruyKH0Hc+V3mcw63DALCNWfNhGr65Ip6a+m68ux0dbXczrmPSDt+TmvE=
X-Google-Smtp-Source: AGHT+IF1ZJ34S8wHfK4e0giFWrsLi/td4d5wyPmgupD6AicJN1a26QYSVhI7ULzCco4C0ujTpbXL5A==
X-Received: by 2002:a05:6a20:c70a:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e88cfd5b94mr16188605637.21.1736497725427;
        Fri, 10 Jan 2025 00:28:45 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40569fddsm1067441b3a.39.2025.01.10.00.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 00:28:44 -0800 (PST)
Message-ID: <aeb2bd68-f5b9-49b7-81ff-18472bd8b7b0@daynix.com>
Date: Fri, 10 Jan 2025 17:28:38 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tun: Unify vnet implementation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-1-388d7d5a287a@daynix.com>
 <677fd7d26e090_362bc129432@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <677fd7d26e090_362bc129432@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 23:06, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> Both tun and tap exposes the same set of virtio-net-related features.
>> Unify their implementations to ease future changes.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   MAINTAINERS            |   1 +
>>   drivers/net/Kconfig    |   5 ++
>>   drivers/net/Makefile   |   1 +
>>   drivers/net/tap.c      | 172 ++++++----------------------------------
>>   drivers/net/tun.c      | 208 ++++++++-----------------------------------------
>>   drivers/net/tun_vnet.c | 186 +++++++++++++++++++++++++++++++++++++++++++
>>   drivers/net/tun_vnet.h |  24 ++++++
>>   7 files changed, 273 insertions(+), 324 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 910305c11e8a..1be8a452d11f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23903,6 +23903,7 @@ F:	Documentation/networking/tuntap.rst
>>   F:	arch/um/os-Linux/drivers/
>>   F:	drivers/net/tap.c
>>   F:	drivers/net/tun.c
>> +F:	drivers/net/tun_vnet.h
>>   
>>   TURBOCHANNEL SUBSYSTEM
>>   M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 1fd5acdc73c6..255c8f9f1d7c 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -395,6 +395,7 @@ config TUN
>>   	tristate "Universal TUN/TAP device driver support"
>>   	depends on INET
>>   	select CRC32
>> +	select TUN_VNET
> 
> No need for this new Kconfig

I will merge tun_vnet.c into TAP.

> 
>>   static struct proto tap_proto = {
>>   	.name = "tap",
>> @@ -641,10 +576,10 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	struct sk_buff *skb;
>>   	struct tap_dev *tap;
>>   	unsigned long total_len = iov_iter_count(from);
>> -	unsigned long len = total_len;
>> +	unsigned long len;
>>   	int err;
>>   	struct virtio_net_hdr vnet_hdr = { 0 };
>> -	int vnet_hdr_len = 0;
>> +	int hdr_len;
>>   	int copylen = 0;
>>   	int depth;
>>   	bool zerocopy = false;
>> @@ -652,38 +587,20 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	enum skb_drop_reason drop_reason;
>>   
>>   	if (q->flags & IFF_VNET_HDR) {
>> -		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>> -
>> -		err = -EINVAL;
>> -		if (len < vnet_hdr_len)
>> -			goto err;
>> -		len -= vnet_hdr_len;
>> -
>> -		err = -EFAULT;
>> -		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
>> -			goto err;
>> -		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
>> -		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>> -		     tap16_to_cpu(q, vnet_hdr.csum_start) +
>> -		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
>> -			     tap16_to_cpu(q, vnet_hdr.hdr_len))
>> -			vnet_hdr.hdr_len = cpu_to_tap16(q,
>> -				 tap16_to_cpu(q, vnet_hdr.csum_start) +
>> -				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
>> -		err = -EINVAL;
>> -		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
>> +		hdr_len = tun_vnet_hdr_get(READ_ONCE(q->vnet_hdr_sz), q->flags, from, &vnet_hdr);
>> +		if (hdr_len < 0) {
>> +			err = hdr_len;
>>   			goto err;
>> +		}
>> +	} else {
>> +		hdr_len = 0;
>>   	}
>>   
>> -	err = -EINVAL;
>> -	if (unlikely(len < ETH_HLEN))
>> -		goto err;
>> -
> 
> Is this check removal intentional?

No, I'm not sure what this check is for, but it is irrlevant with vnet 
header and shouldn't be modified with this patch. I'll restore the check 
with the next version.

> 
>> +	len = iov_iter_count(from);
>>   	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>>   		struct iov_iter i;
>>   
>> -		copylen = vnet_hdr.hdr_len ?
>> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
>> +		copylen = hdr_len ? hdr_len : GOODCOPY_LEN;
>>   		if (copylen > good_linear)
>>   			copylen = good_linear;
>>   		else if (copylen < ETH_HLEN)
>> @@ -697,7 +614,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   
>>   	if (!zerocopy) {
>>   		copylen = len;
>> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
>> +		linear = hdr_len;
>>   		if (linear > good_linear)
>>   			linear = good_linear;
>>   		else if (linear < ETH_HLEN)
>> @@ -732,9 +649,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	}
>>   	skb->dev = tap->dev;
>>   
>> -	if (vnet_hdr_len) {
>> -		err = virtio_net_hdr_to_skb(skb, &vnet_hdr,
>> -					    tap_is_little_endian(q));
>> +	if (q->flags & IFF_VNET_HDR) {
>> +		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
>>   		if (err) {
>>   			rcu_read_unlock();
>>   			drop_reason = SKB_DROP_REASON_DEV_HDR;
>> @@ -797,23 +713,17 @@ static ssize_t tap_put_user(struct tap_queue *q,
>>   	int total;
>>   
>>   	if (q->flags & IFF_VNET_HDR) {
>> -		int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>>   		struct virtio_net_hdr vnet_hdr;
>>   
>>   		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>> -		if (iov_iter_count(iter) < vnet_hdr_len)
>> -			return -EINVAL;
>> -
>> -		if (virtio_net_hdr_from_skb(skb, &vnet_hdr,
>> -					    tap_is_little_endian(q), true,
>> -					    vlan_hlen))
>> -			BUG();
>>   
>> -		if (copy_to_iter(&vnet_hdr, sizeof(vnet_hdr), iter) !=
>> -		    sizeof(vnet_hdr))
>> -			return -EFAULT;
>> +		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
>> +		if (ret < 0)
>> +			goto done;
>>   
>> -		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
>> +		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
>> +		if (ret < 0)
>> +			goto done;
> 
> Please split this patch in to a series of smaller patches.
> 
> If feasible:
> 
> 1. one that move the head of tun.c into tun_vnet.[hc].
> 2. then one that uses that also in tap.c.
> 3. then a separate patch for the ioctl changes.
> 4. then introduce tun_vnet_hdr_from_skb, tun_vnet_hdr_put
> and friends in (a) follow-up patch(es).

I will do so.

> 
> This is subtle code. Please report what tests you ran to ensure
> that it does not introduce behavioral changes / regressions.

I tried:
- curl on QEMU with macvtap (vhost=on)
- curl on QEMU with macvtap (vhost=off)
