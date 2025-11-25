Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1DD32ABF7
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093552; cv=none; b=QDHaaowHGbGTfYJ/f3uxLK2foe8D+UaTs2o8yfvnspLiBtAnLcZwfowp8ljg1GPgoqeQGUdcJj2GJrnoVK+0DIsm9Nf7+qm2wG2I1m+fDsBoN9n0TaGTPuEHNkxp5og2WO/wv8rPPBGjzjoXkGDSYtk6/d3NMbKP2Ytj3M6TvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093552; c=relaxed/simple;
	bh=RyhNmS2vGG3hvmsd5fJ7DzAZ9Xaj+bN/VVH47DtsSNk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ezN/YpNbH1a3Ja8K45tK3T6bPp5OW4GPXLCbnywGIy9SWgMUFu4m2Ew+J4dYWYX6gPrYPztvKobTJlSeBKfEvv0mS6XCEzUTdDuKS+pcHHwhVd1a4WR8swZ8wxyNK/qnEk9zkkT6QE19UdspLrQMrpdKMPc0MMXR0m6O3zrTxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV/7qJcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV/7qJcu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764093549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggRdSNkElU+a399plx+DRkCBhOmqAokOxhar5O5tK68=;
	b=LV/7qJcuw2i65oqxO9Zu7e1e/IY/UxMsoC0FZ+u9W+QPYNtJOgDt1jMYxXjFQO7lFb0P/4
	4g/9vE9Eju2mtL9U/UgPMVZPE7qWhghhCRTCz0NNM5wWVZcxXncjopSBgmZC+TypXuIS3M
	Lt2Pps4H1fSLxmiBeMjXf/ifvmB9XkI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-NtKzQXbHPlqkLUXSmIe2Ag-1; Tue, 25 Nov 2025 12:59:06 -0500
X-MC-Unique: NtKzQXbHPlqkLUXSmIe2Ag-1
X-Mimecast-MFC-AGG-ID: NtKzQXbHPlqkLUXSmIe2Ag_1764093545
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4776079ada3so47233955e9.1
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 09:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764093545; x=1764698345;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggRdSNkElU+a399plx+DRkCBhOmqAokOxhar5O5tK68=;
        b=KXqUMyTFE1lMXGGRVvmDSHnfnDu+WgDFs99xxFC+i+XJYZ5Xs9zqF74kwgzxAcrFIW
         Pu3LvsrRn0wTxAd+gILeAjch+eCdprIJOtR7Z4xTeTvY9pbpbVydr9UX0MJMjwL4Mv6e
         dB/wp3SyDBWTELRFfqhf8gRSI6fJqGioxT06nzBGmm8BiBIF/kZfiJ1za7wcRCfBAS+F
         xJO4X+k5WZliCpANpQ584ry3m5f6Y7B0nORfQtlM2INa5e6eAVp8Pz9TW3lLTt7u5GQF
         L/YT2YsrbfNq88o33nxb/cjAEW5NOTLH6jRlpp6Xu7WQqRUwjRtTTdsRzvnaNSp+xVVI
         JojQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0LAjWwfyQwccKwgPJKAA7T4OTVeTv4UvLypaMKpcKf/ni6h2rvko0ZfZ8d1YyC1q321x3SUKVtp5y1s/aFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/eCspnnMsmowJG445TYYG2AuDQCIizqzecI3LwVnyxpDgSKDm
	T0CEo2l+7VDOVvPygrnsotMGekSHHoboyElmc2DqHvLYmw0u8ikRFSTnhRN6ZgIWe4sNPUZuAW+
	Mh7Qh+9SqJ5tov1Qtq91WSwTER/oAwyqCfFU0MvkFlrb/yBGD87dpZqzVI36MGgWJ5UpY
X-Gm-Gg: ASbGncswNnnEGSiddidJeV4HfGT/58eBqtqvLkdw2b627CNnqOQDedSfLAmPMyfH0qc
	SPDmetu9mbqfQct1MTieYRjD68Xs1qTPhvimZpZ3yNSERTXSkfwcrH0AxsTigO41EXI4gOzrl1U
	HpcUlToROEx1TT+0GWOUzIpKfmWqwzyBjS5QRpqF24K7bGj4Mns5u/WRpR+++/R2Sfr8d6kJ63u
	MYMjfrpzzPXEO2+xJtqdsGlThAInV5kFMF8EeptBCxpRspB3jD26yBoczAw8WgKix7aKFcSCdIy
	lcCCOEtivMK5KiBObCWz2k9nn3hkodb3Wd7iVzYbxscxqkokbaUjxLNuOTZnYRrYr+Y49cfRMtM
	=
X-Received: by 2002:a05:600c:354e:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47904b12eb0mr32984035e9.17.1764093544981;
        Tue, 25 Nov 2025 09:59:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7KQT3sUoiUAmwtj+59LzZJLLFJ+8j4a0ieDuHCTy3Ekk0Z4pUbgQyJD2REcyJfcjeD9yfHA==
X-Received: by 2002:a05:600c:354e:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47904b12eb0mr32983845e9.17.1764093544552;
        Tue, 25 Nov 2025 09:59:04 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363b0sm36115430f8f.13.2025.11.25.09.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:59:04 -0800 (PST)
Message-ID: <8492bf2b-0fbc-4819-ab7a-dfe860cca412@redhat.com>
Date: Tue, 25 Nov 2025 18:59:03 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
From: Paolo Abeni <pabeni@redhat.com>
To: Jon Kohler <jon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
In-Reply-To: <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ikREh2BiZ459kFDACBpNHHy5hky-i6ccJ3mxAzlskNo_1764093545
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 6:57 PM, Paolo Abeni wrote:
> On 11/25/25 6:51 PM, Jon Kohler wrote:
>> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
>> GSO tunneling.") inadvertently altered checksum offload behavior
>> for guests not using UDP GSO tunneling.
>>
>> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
>> has_data_valid = true to virtio_net_hdr_from_skb.
>>
>> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
>> which passes has_data_valid = false into both call sites.
>>
>> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
>> for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
>> guests are forced to recalculate checksums unnecessarily.
>>
>> Restore the previous behavior by ensuring has_data_valid = true is
>> passed in the !tnl_gso_type case.
>>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
>> Signed-off-by: Jon Kohler <jon@nutanix.com>
>> ---
>>  include/linux/virtio_net.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>> index b673c31569f3..570c6dd1666d 100644
>> --- a/include/linux/virtio_net.h
>> +++ b/include/linux/virtio_net.h
>> @@ -394,7 +394,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>>  	if (!tnl_gso_type)
>> -		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
>> +		return virtio_net_hdr_from_skb(skb, hdr, little_endian, true,
>>  					       vlan_hlen);
>>  
>>  	/* Tunnel support not negotiated but skb ask for it. */
> 
> virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
> 
> I think you need to add another argument to
> virtio_net_hdr_tnl_from_skb(), or possibly implement a separate helper
> to take care of csum offload - the symmetric of
> virtio_net_handle_csum_offload().
> 
> Also you need to CC netdev, otherwise the patch will not be processed by
> patchwork.

whoops... I almost forgot... this is 'net' material, the subj prefix
should be adjusted accordingly.

Thanks,

Paolo

