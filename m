Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAB1A3029
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162931; cv=none; b=bO46zIoTU/7SZx2yHQ7p2gZ9sHA7s+zrmW3aI/ifK5eQfctnEyd9gR+MQtMxRt+6xez50D+DzLW0G+EOYVn2Gn0531O4fydJp8RIEyAarss8DUaYDqOS8gzQWoW0tNlSvXxQuIGt0Viu5O+YqJWU+sMQKCknf5lq24FfS1XSYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162931; c=relaxed/simple;
	bh=QaqfHAczpbtT8cGTYb66uFZanVaUTd8LjL+QGZKif0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amw7NiBuiNxPI/v7InGpMTbMjghpq88qR9OEwPfNna4qsvH1yLbtaYGF8X9np7nSKzoI9xXywr1N9EK4z7GbV5wIrjzfSsv1u2M6iswjuf5MEhKocuwtSAd2mSZ1eQmE3IRRFf8EK4etCwazOCQGpzVT2UXiWH/DCXOAKQg3Sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVhKuf3G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVhKuf3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781162929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6EPp4PuFmtO2xH44RdCW6HHUd3lOCnDExqRH2uDRv8=;
	b=KVhKuf3GjoDryMrOQyymYAWBc0s97VmQnlzJEOucnjDD1Y6w3Upa5zZgrSuZu9nw/8EqJk
	OwDE6uZEcKYxa33SXkh92CNET4K/myjdGAejHvd4C3chw/ouEE8FwS1KYjHfT8txhbrugq
	6qQqNM3sFx/mhDaROLHFUDrrCD/TzeQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77--MTxPq4tPZG7W7ErjgVk4A-1; Thu, 11 Jun 2026 03:28:48 -0400
X-MC-Unique: -MTxPq4tPZG7W7ErjgVk4A-1
X-Mimecast-MFC-AGG-ID: -MTxPq4tPZG7W7ErjgVk4A_1781162927
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45eecec7667so5318106f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162927; x=1781767727;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6EPp4PuFmtO2xH44RdCW6HHUd3lOCnDExqRH2uDRv8=;
        b=S1JzSUX+s5gGMbFIFA6SrKwo/PhQCbcjnl7aPUcSgBoEu9FXoGnXJthB8JFtfQ1Y+X
         PEPeJskOgResX2lw2//U2bXe8NDDy520IPJNsA+U1xnFEse9cIGwp8rRUFowhLa190lD
         QWN7gW1Mz72CfnuXrbr519eMHiQ6JGID1WauEsJx3gHfwZWXYD715gxn69D93QshVw51
         +xTGFocpn483D0MAHFCUfRS6UxQoD4uhgBwAaDKJV1ogqEfF6FyZit6zOVsWG8VB/kVq
         FIwp0xHTdqHxeFrhPDMgGF/cf17A2KR0yQEBko10mVHDYc8qNos8N1ggPkFNOI/2bmue
         5GKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TizkLBFxFRwMcjDqvYhke7TXbGq3PTQYpyA+KSQPXEHk8lDNP6mIVLoZ1qBfQ8T6vr5WZnnm1FUrOPoFm1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4qhgcVg7UXgFDDXY2WVAzJuKVBFvk+GZURhfpqbeVEzd9s0OE
	Zon8tuMF2u8LjzQpLQ5HEpEW1DH12lN+CsuyIuBsNRMCFUYlRIl/zmHo85yDb4m4BywpCOlPTgW
	xfHY5n99vgaJCVuWUdtJIEFrbb/ef+jwVpqHnYbmsDx1GSZIKHW9GYZUXzA5Krbz+/kHi
X-Gm-Gg: Acq92OED8dJCVgB1xYngl6FNi9UugPHLdBYWWQjuMQMFOHY/bWlNUN32BvSHENTspYV
	eRrBluNPFdQv43Tgj3PfJyn1C54YX/qZhkOPUorGB7aaSCWIdNsVUHLQ87QS+v/Un47QcZdz0nc
	mEE6mFPSGAbZjGQpqqwdle3I1YeAqWdwUGTjJvwgIsdTf/tjhaptodXY83EwD3AvdWqf/XGq5VG
	3XcGgdSARSuN1PWKGRHhRuHaz9eFM6bV7fEMZEXnIcy2XBlr6j5cFjIs4yzjAFmXLEcbqL86VzJ
	ODk8dxtR6DgINYg6HMMrlPpaPR8/DmRtUI5o8VqSV1kKn4Ns5gj2/FbOOP1Z92OsGUvGUkNpE34
	91bqH1F057waUEyBEbTT8/q5P8PKEgBrK4AQsk8WzXFqcghNFYO67O6MZ0z0rVFajHA==
X-Received: by 2002:a05:6000:4687:b0:43b:5672:efe with SMTP id ffacd0b85a97d-4606758d337mr1416811f8f.9.1781162926777;
        Thu, 11 Jun 2026 00:28:46 -0700 (PDT)
X-Received: by 2002:a05:6000:4687:b0:43b:5672:efe with SMTP id ffacd0b85a97d-4606758d337mr1416793f8f.9.1781162926294;
        Thu, 11 Jun 2026 00:28:46 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm81186389f8f.13.2026.06.11.00.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 00:28:45 -0700 (PDT)
Message-ID: <7711d6d5-ff7e-4a8f-b69f-c06d1adec580@redhat.com>
Date: Thu, 11 Jun 2026 09:28:44 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: do not allow tunnel csum offload for non
 GSO packets
To: Gabriel Goller <g.goller@proxmox.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
 Willem de Bruijn <willemb@google.com>
References: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
 <178109396600.129329.5073003425673349392.b4-review@b4>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178109396600.129329.5073003425673349392.b4-review@b4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: psKiXCiumfYA7CrQRKzAle-hfluJTykgvBTQNy5_NNI_1781162927
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 2:19 PM, Gabriel Goller wrote:
> On Tue, 09 Jun 2026 16:44:26 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
>> [...]
>>
>> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
>> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
>> Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
>> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Gave it a spin and it works alright, so consider:
> 
>>
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index f4adcfee7a80..07b8710639f9 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -6222,6 +6222,18 @@ static void virtnet_free_irq_moder(struct virtnet_info *vi)
>>  	rtnl_unlock();
>>  }
>>  
>> +static netdev_features_t virtnet_features_check(struct sk_buff *skb,
>> +						struct net_device *dev,
>> +						netdev_features_t features)
>> +{
>> +	/* Inner csum offload is only available for GSO packets. */
>> +	if (skb->encapsulation && !skb_is_gso(skb))
> 
> A small question -- should we maybe check for skb_gso_ok here as well?
> So add:
> 
> 	(!skb_is_gso(skb) || !skb_gso_ok(skb, features)))
> 
> Because skb_is_gso alone doesn't guarantee that the packets leaving virtio will
> be gso'd, they could be software gso'd at validate_xmit_skb, which is called
> after ndo_feature_check.
> leaving the virtio device.

Good point. Indeed disabling tx-udp_tnl-segmentation inside the guest
after successful VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO negotiation would
again break the connectivity in the critical scenarios.

Let me test a v2.

Thanks,

Paolo

