Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8924B29
	for <virtualization@lists.linux.dev>; Sun, 29 Jun 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751175076; cv=none; b=QdpC/FoqU13hp/tCURhnD0JjbpBDvCiPNB5q3B9BocbNNdub+5FILkVh51urZvNFbkYKYCYxI9wA1jipmE2+Tao4fDXbqmXkN8fAeO0tTqnSF9JY/0yL4pVjRROB4grW8yiQvJZjN6zDxsG134Z2oeCHJLAjfaODxp7s/b7Q3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751175076; c=relaxed/simple;
	bh=ETOpPQhKUGbb3m1DQNXZ9d1API2efLKRSgFfw3wjXYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mf/dSZ+v24WWdVoelqtZoaMNXC+UOr3z8wEuGzc0lX0xGxhBy/nLDKoMTeDc+Yhei5ufL796Q+azp0HMv8Br8bhjStk++8yykz4FI8Vy5fCVu6SRoYd48oH3ggTvERRRUeYEZAGXgcSGM/ZwyrNbTaHE1CUPf4TBma3tH6D7wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtM+BW/y; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtM+BW/y"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af51596da56so1219018a12.0
        for <virtualization@lists.linux.dev>; Sat, 28 Jun 2025 22:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751175074; x=1751779874; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KxQw+8wrv6WHqC8EiMCQt88wHvecAR5EAJYKEAI9aQ=;
        b=LtM+BW/y6oyiKZF/OYmGEzwYJdhb4GVbwygPNdHQPZqB9NUg7YQtUHS0b0884IAelZ
         tsC0TdyzJrzofkRd552MEYbSshyKfEaR/fi3IYbwF+51l2rNO31MndSkJqlZlFd/OQ2V
         HpggMigS/BQS8PArquoM6NMIjHNZo5JBK1bL4s5fKfoEOCbPWB2dWmBC0owDsccXTM5R
         eXDkEgNNOzY+3wACiKwD5TSf1Poi7FMBjLrEdK6O++MOjX990iWI3QMEed8o4nu3Pi8f
         yOfaN0BeDCPUFpzXWKFJbnzUwZ0bFcBrG3Yam9Ex2rUrGDoX8Aurcj95K9NcIaldDoSv
         ZCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751175074; x=1751779874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KxQw+8wrv6WHqC8EiMCQt88wHvecAR5EAJYKEAI9aQ=;
        b=Zs0YLLNd/F0e/9UxSTXpFq1QiZb4Z/gyAvIjQHKn+V7i/vZ2GwhMjZ12Y0wuDzwg49
         R/vLhT0MqeylKUN3blmc5pZuDS6ScSwZckQTP4IfWK+tlQm2buCVKdftEQItQuTt1jYJ
         yuU/u6hlbTukn4rq9qvy8mUXSYyjo2KsCqRl3f6vEkbVPO+ZSMefbF9kRIx8GrArTmjd
         T4t2UwG9TSJMhVK4Dmca7VIfQsijw05aKwlkpPKbjSMJnryt0kC6MLAHBnnZNUdLJ2yD
         zNu+58MaoVC+BZ6uy5UtK89DH4ksOAkU9OeG2wTlXlb2LkfFdvBFfMUtEoU6jYH4pnFS
         CDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt/h2vcDXiGLudLEPkW4vUW9ebTvr1qxefN2Sr6hicZ/4Ibdag3T/AmdaS5vf8qD/qJzUuczNmq9jgs+7rzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/7aGydquG/mIxZZkXj2+3ahW/GAFxiYrafMKphGDOmPeL+lRG
	6EH7wz5JIlHErT+Wo15UoOcmiBgUl3XjdlSd509IH2DaJq5vpu8W1fCS
X-Gm-Gg: ASbGnct9efnutKygUmBMrM9n64lf3AuiQFt2Bgdxt6zm2+FUPAdbphQWOVOxtkGEW51
	Nt06p187avwn9WTnWITjKjMLZf8gTO5sJe+I3QbUClczvjDC2QrveNUUR+Uv/v64yq9i4dVVyK+
	mYFXUI1e/KxaYd/v9mjTnQJ+ff+0eGK2KO3pEwEZ0wzPttAj8bhqh/Q896ZjBpFjyM89UHrhlIZ
	Mo0l1LzSklW4LEzF0lIBnitCxcvGR/Y3RH0DpCAMfaNwGmpU3zRLp2qzoRQjCY/0VOl0fd4lJC1
	lVOE6fOOpbrjzLfleuW2vriNbZOsnED9KRy+V3hvB2fHbFWVNxv5ioYXC3NpgEo9eoZIPeIGCDP
	d5pwfPLwvhda5WFwoqipp5Yn+2gExAuRrj7RhXnD8
X-Google-Smtp-Source: AGHT+IEVZEItwhAmpQ7qT5rj0OSH/4b+v0bHuKzDVzS/4Qq/q+fKX3xbk/96CMChuM4cXxPSEAR6mA==
X-Received: by 2002:a17:90b:4c89:b0:312:29e:9ec9 with SMTP id 98e67ed59e1d1-318c92ee68dmr14182999a91.24.1751175073661;
        Sat, 28 Jun 2025 22:31:13 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:6051:fd69:c29f:10f6? ([2001:ee0:4f0e:fb30:6051:fd69:c29f:10f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54414acsm10901024a91.47.2025.06.28.22.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 22:31:13 -0700 (PDT)
Message-ID: <c207a343-7e08-4a2f-9163-2d64dd47d906@gmail.com>
Date: Sun, 29 Jun 2025 12:31:07 +0700
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

I've found out that there is xdp_prepare_buff helper which gives more 
control over the headroom so it can be used here. I'll update in the 
next version.

Thanks,
Quang Minh.

