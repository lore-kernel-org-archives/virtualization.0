Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F11291C1A
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777138; cv=none; b=BLoSgWrn8Z17LhcS6nAkVvXp5p3tkcKkdWfoZO9nbwb/Cx5QuKcvAzYkOqELs98g4vcmfW6suOE5XvsjzHoRllDVEu3TZf11r08tXIAFBszJkgqrcz0IOJA6nzWNUqWB0cDa0XPolZlzfPU6LgqctQPdUuipRuiBYIKSuWWvYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777138; c=relaxed/simple;
	bh=loG2cx3ZGfP/J061ElEISkikcZshIqrgMfBBB4m1POc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw8xGu1xn7F1XTVQ4kXLl0d8hxrd6HFx+yIgduR5Jkr2YzH9rAnyKGKcx+t+KunDHu0G+7rQ+h5NXi10xQUsCO4jy0csK9AWtaITA8lzQicUc0ir4jyJxeo1+xdNYSw4vvB9GcYkI/dZUrrYHVh6y+x/0liywQWmPH+TJyQn3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdNFNjju; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdNFNjju"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a8f69862so535873a12.2
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750777136; x=1751381936; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFS9CMumjJJISBCLnrgNW43kLYsugAi5o9ZdE09jh+0=;
        b=IdNFNjjuOahTpl2pDFVT6Sytd0tF9TU+Jq6GO1i5HkQCOm4gLlVVv1sKIGaQsY+vO4
         9qRZxBuX/1UC4oNoTquxhxBonyhZZeumAgZtzpjCv/p30u02OsROeABlctkxmz1HF5b1
         NqAC6mXW5rWyPlB70EcCmWuJqTEIWi+UMK8iNeC5z/vW/yx0NjxaiExI96Ew8+mR+d5w
         ifKgRG/AhowLnUaXphpdiu7rtc2vbqSnWo8nZCp4QgA0yzWutuqRSW+eYrkhRXho2aqg
         2dHyimHrWneTxpBTXJgz1O7vbgve45eUZZgJ9RiADUCTww/+Obld8Mvlvkl3PL2wjhVS
         UgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777136; x=1751381936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFS9CMumjJJISBCLnrgNW43kLYsugAi5o9ZdE09jh+0=;
        b=uHSfZiRAFuEfYAUSItJ8IMKJ7gDAVkPYY5vYw8v5JxlGk8kvQPOe5nVu/2Y7KScl8t
         TTjbkL7hfwu4dLEROa3jGFE5AQtWX9acd2/SQfKMwCffYiCTHjFG1wB+O779ZxLW2nGk
         UJM+F5IyZpVmbbu3kKvDlxuV2b9/66fo7b1feVIx7NNp7lqvSGVvSK4F/ddSm4m76XU6
         eqiQl+aJpeJ/lIXgXyw/dtQbv3pLbmHRDKMw8to+J5NZtmnfTpObNPoCSfbdfn8SgmZ5
         Mw8vW7M7lrrg+1VXfdDejSaWBT4qDVnCs98XhWcxELssVpWm7qeg0uMK7jPUQkNskiU/
         miAw==
X-Forwarded-Encrypted: i=1; AJvYcCU3KZr3zPRF95s3LtGw9sJgeni1JGwfEf/Ehb6kI0D8BP1w5ubR2hgoiWJi67TorC+boT3hTCIbe1kz4UbzLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLDHR3qbJ2GhidgGiI3iIrZlCdX94lCGIW6jzVbDhrFA2mbUfN
	3tcQqzE4a7e6syziAk2hyfJwBdSbtcw0UkY9mZWKP+6pH1izFFSbs+uG
X-Gm-Gg: ASbGncs62fXaOhx7Ozy4gpZM9jbCuOAW/N7kkSh9HktwEEfLJkPu7NlRk6HUN5on8zE
	TTEMEVYTy1LVniMOcYR5I32tlMfQ+AbIAgewuX/RmTdyNlGKNc8UdBg0sCftMO2d5/rzeR4jp+p
	7QJGuYieMhLWYJTg/UPNfddxLQaBn4CZxuo2dCsQleDKnW/0qNVz943v6dZlAD5KlftAYliC1nS
	ZCeIF/MiCXLYlMLiIsoVGNPg76A0x7Qrm3IoHVn/mK91dGE/MlDA4foid2EVTgPl+mYz0uzxRn0
	pFRvJcvbbVYFMvTK+/jvRhJYIrbnmEnVYYyr8Dmr73T3h9rxmiHovWy3ISQYt4MxdVFtwv4EIAp
	yr0+NjJACnV5zptnFYxT34z/vxgvJdEoAw5Qwt8+Q
X-Google-Smtp-Source: AGHT+IF+qbX1Ip+UnixDoMvVlniOQVuJKKO8aqdN56Jco+7UYSwZVb5AUVnkERXoLBP1nfjqvA8V0w==
X-Received: by 2002:a05:6a21:684:b0:218:9b3e:e8bd with SMTP id adf61e73a8af0-22026dca74dmr26352327637.10.1750777135577;
        Tue, 24 Jun 2025 07:58:55 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:1f60:cc25:9268:94fb? ([2001:ee0:4f0e:fb30:1f60:cc25:9268:94fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e21799sm2122923b3a.51.2025.06.24.07.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:58:55 -0700 (PDT)
Message-ID: <ffb4b02e-fadb-4697-b001-7d879ca3b6de@gmail.com>
Date: Tue, 24 Jun 2025 21:58:47 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-3-minhquangbui99@gmail.com>
 <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 17:17, Paolo Abeni wrote:
> On 6/21/25 4:49 PM, Bui Quang Minh wrote:
>> This commit does not do any functional changes. It moves xdp->data
>> adjustment for buffer other than first buffer to buf_to_xdp() helper so
>> that the xdp_buff adjustment does not scatter over different functions.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1eb237cd5d0b..4e942ea1bfa3 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>>   		return NULL;
>>   	}
>>   
>> -	xsk_buff_set_size(xdp, len);
>> +	if (first_buf) {
>> +		xsk_buff_set_size(xdp, len);
>> +	} else {
>> +		/* This is the same as xsk_buff_set_size but with the adjusted
>> +		 * xdp->data.
>> +		 */
>> +		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
>> +		xdp->data -= vi->hdr_len;
>> +		xdp->data_meta = xdp->data;
>> +		xdp->data_end = xdp->data + len;
>> +		xdp->flags = 0;
>> +	}
>> +
>>   	xsk_buff_dma_sync_for_cpu(xdp);
>>   
>>   	return xdp;
>> @@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>   			goto err;
>>   		}
>>   
>> -		memcpy(buf, xdp->data - vi->hdr_len, len);
>> +		memcpy(buf, xdp->data, len);
>>   
>>   		xsk_buff_free(xdp);
>>   
> I'm unsure if this change is in the right direction because it almost
> open-code the existing xsk_buff_set_size() helper - any changes there
> should be reflected here, too.
>
> Also AFAICS xdp->data will now carry a different value, and I guess such
> change is user-visible from the attached xdp program. The commit message
> should at least mentions such fact.

The else path in buf_to_xdp is only triggered when it's called in 
xsk_append_merge_buffer. That's also the reason of the memcpy line 
change in xsk_append_merge_buffer. xsk_append_merge_buffer will allocate 
frag and copy xdp_buff's data to that frag. Previously, after 
buf_to_xdp, the xdp->data does not point to correct place yet so when 
memcpy, we need to copy from xdp->data - vi->hdr_len. With this change, 
we will adjust xdp->data = xdp->data - vi->hdr_len right in buf_to_xdp 
and also adjust other fields (xdp->data_end) to the correct place too. 
So I don't think there is a functional change in this commit.

Thanks,
Quang Minh.


