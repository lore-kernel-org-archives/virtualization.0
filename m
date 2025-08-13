Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987571F17EB
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114701; cv=none; b=NVo0pYIeYiojG5zFsTgfBFMF6JmVZZnoXHIPlqhIrN7F9gM8jBhFD4yK+oCxx+yxlptdu9ygjQxuYT8ZWuSsG+M9KfRm10al87w3vS8fL2KCKV0Me9NAwa9jY+f65VLBInSTiFKWdMuishUJLz804OSOogXseW7nvSaooWH2hjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114701; c=relaxed/simple;
	bh=x0zidj6WTnI3FjHdw+pCrGk7qsGuqC3GI8c0CDTKSJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBDVd34ojImgP5qD36ATsObHWBG/loP49i3QcllbrAhxtq770vWOxAHuJGv5HuHPJQT9LjRFdJ+KRFN6Vgu5HmF0XYBRkYj/iZXfyv0plLvyfa6vaXcSeBZOsXxmnRvPq/X/3G6jyau0De0NUJ2ZF82bbYO+TBGc6YVvSjYtdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHbDJwXo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHbDJwXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755114697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j183C3V9YFuT97WgSzXp5t9Qr2ck9VAY1fTHVyPsoY8=;
	b=FHbDJwXowIRmbgoZd56ABTUX9AQQp/jUfPsFcoczZ3ERVTHqxgT2cXW+08+RySyilsLi6a
	dOu8YH5z+W3yc7tsiiOZpNZ6HJdueXP3h7BcjRArxWerfpUFXRy2EymH1E4E1YqXg9VoyP
	pMUraZTPP4MPT5zBDdK7XEWfJ9Bekbo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-4HFqo9ykMQ61bKwu-Pd3tg-1; Wed, 13 Aug 2025 15:51:36 -0400
X-MC-Unique: 4HFqo9ykMQ61bKwu-Pd3tg-1
X-Mimecast-MFC-AGG-ID: 4HFqo9ykMQ61bKwu-Pd3tg_1755114696
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9289baafso5702196d6.1
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 12:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755114696; x=1755719496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j183C3V9YFuT97WgSzXp5t9Qr2ck9VAY1fTHVyPsoY8=;
        b=qvbQGwUP2LW3GKyQmrLrpTMrtePYpAvQ0XLWyEiRl7mzUgDuQm41zSQEjLcxnzkH5Z
         S7r/d3eMkeMSji4+MYhVi7k23Oa7x8O/nfiGiGWWlL0/jGm10eX3vBD5iUQo0JS2BJyY
         /p+eFfF3Pk1xqzckQi4O5gB6ZOY1Ql9zJe8kk1va0TwUhTydzHH7QedcUqGGVRIJHcPk
         N32COw73UhE5kssqJzBjBHQK5+DlzHmvqOmA3T/8qJFDlcKHPTrAYY5wJOToXyPBU6ZI
         iR6yl0Tjf81FjhTHZFnxvh43L2J2YFoUajEcFZnETWYjAFTprSPTxnIRBpDNumzCeaSH
         d9yg==
X-Forwarded-Encrypted: i=1; AJvYcCWvrHxaRVjphQWMZVfscxHK2ws4+eyJmpGRwzvfoAsmDimWzu3wWtiroqkrFElzPdDFy0orRRcMUgYGhYJKTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+2j1Syqf1xZ8BvVMPiex3Sb+leGhNxdaKUzALpMr4eotvXn7V
	/R09HwPCOaFyC+kwkRigknf0iDwnBQ+xX6uHf/RjOmBRSFf3s0BIJe+OkUu7Ihz0huYxtN7fnV+
	tNcSJ9cbQJr73ESwU5/FkDfJJa3MAxPIlBwqy2FpV+7HrNB2CAQXgCCeIhAzkInxXSbYh
X-Gm-Gg: ASbGnct2FcQkFNtiqkbQIPG6CaMVOFvZ6+sqSwr1o/cAodj9SqS2fqY6FFzT2eg6NzO
	HCqahCRGMqlkVz+A5UsEyxxbarliqZuxVmS3vTbR/2XMNERXiXijfVSYXlrkOxcNhkirsQdZziN
	cP5Q2Rlmuk+z0vGnWl8P7mI3U7QrJL4Lm1IBJdnaWtGho9iDwe8rDiDkDDq8xDPqaU91eVoaIkW
	oHP6iaGdnvSt7rRegJYl/8vUhyjzNcHMeYkTw+y3SKHrfLu+ehdFiMtkLwfF3+O8H+c1P2xDeTY
	aiwVv8gZLFvF5SgEoDBNBX8ZVe4NIRNRxZfHrbnWNQ==
X-Received: by 2002:a05:6214:240f:b0:709:a27f:2f93 with SMTP id 6a1803df08f44-70b97d124a2mr898026d6.5.1755114696003;
        Wed, 13 Aug 2025 12:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhvqEVSPsc7zEAbTUnL3rnYt5hM0shMbs5IPz3+hwNRA+6JEU6BvOZKIVqTc73WN7hre/z3Q==
X-Received: by 2002:a05:6214:240f:b0:709:a27f:2f93 with SMTP id 6a1803df08f44-70b97d124a2mr897696d6.5.1755114695535;
        Wed, 13 Aug 2025 12:51:35 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ae6d02f89sm2811256d6.37.2025.08.13.12.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 12:51:35 -0700 (PDT)
Message-ID: <aa46dd09-a450-4633-a647-b04781599c87@redhat.com>
Date: Wed, 13 Aug 2025 21:51:30 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Virtio networking issues on v6.17-rc1
To: Cristian Marussi <cristian.marussi@arm.com>,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <aJycJvs3xztfD5Rm@pluto> <aJzU1JsV5we-QqgQ@pluto>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aJzU1JsV5we-QqgQ@pluto>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DUAQJd1V1zNwXQgYNK_EHyfY7AcQITH3H8Si64g4Scg_1755114696
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 8:09 PM, Cristian Marussi wrote:
> On Wed, Aug 13, 2025 at 03:07:34PM +0100, Cristian Marussi wrote:
>> Not sure if it has been already reported but in a kvmtool/guest setup moving
>> the guest kernel from v6.16 to v6.17-rc1 I completely lost host-guest network
>> functionality....in a very funny way, though, I'd say...
>>
>> In fact NO error is apparently reported in the guest kernel log and the
>> interfaces seems perfectly up an running both sides, but looking at the
>> host/guest interfaces you can see that ALL received frames are indeed dropped:
>>
>>
>> enp0s1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>> ....
>>         ether 02:15:15:15:15:15  txqueuelen 1000  (Ethernet)           <<<<<<<<<<<<<<<<
>>         RX packets 125  bytes 17948 (17.5 KiB)
>>         RX errors 0  dropped 125 overruns 0  frame 0
>>         TX packets 1207  bytes 51182 (49.9 KiB)
>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>
>>
>> ...on the host same..(taken later on...)
>>
>> tap0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>>         inet 192.168.33.1  netmask 255.255.255.0  broadcast 192.168.33.255
>>         ether 8a:10:f6:df:a1:70  txqueuelen 1000  (Ethernet)
>>         RX packets 804  bytes 43904 (42.8 KiB)
>>         RX errors 0  dropped 804  overruns 0  frame 0
>>         TX packets 101  bytes 14408 (14.0 KiB)
>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>
>> ....and for a good reason, apparently, since sniffing around on the Host TAP
>> interface I can see a never ending stream of:
>>
>> $ sudo tcpdump -i tap0
>> listening on tap0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
>> 22:40:42.309158 00:00:00:00:00:00 (oui Ethernet) > 00:00:00:00:00:00 (oui Ethernet), ethertype Unknown (0xffff), length 54:
>> 	0x0000:  ffff ffff 0215 1515 1515 0806 0001 0800  ................       <<<<<<<<<<<<<
>> 	0x0010:  0604 0001 0215 1515 1515 c0a8 2102 0000  ............!...
>> 	0x0020:  0000 0000 c0a8 2101                      ......!.
>>
>> ... DST/SRC Macs are just all zeros WHILE in the payload you can spot my guest
>> SRC mac address 0215 1515 1515  :P
>>
> 
> I bisected this regression to:
> 
> 56a06bd40fab64448aa6b84aa06b3dc470c1254a is the first bad commit
> 
> commit 56a06bd40fab64448aa6b84aa06b3dc470c1254a
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Tue Jul 8 17:55:02 2025 +0200
> 
>     virtio_net: enable gso over UDP tunnel support.
>     
>     If the related virtio feature is set, enable transmission and reception
>     of gso over UDP tunnel packets.
>     
>     Most of the work is done by the previously introduced helper, just need
>     to determine the UDP tunnel features inside the virtio_net_hdr and
>     update accordingly the virtio net hdr size.
>     
>     Acked-by: Jason Wang <jasowang@redhat.com>
>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
>  drivers/net/virtio_net.c | 85 ++++++++++++++++++++++++++++++++++++------------
> 
> Reverting this commit on top of v6.17-rc1 solves for me and network works fine again.

Thanks for reporting, I was not aware yet of this regression.

Apparently there is mismatch between the negotiated features (that
determinate the virtio net header size) and the actually virtio header
used by both the guest and the host, which is totally unexpected.

Could you please share the host kernel version, the arch and the kvmtool
version? Also I understand you only upgraded the guest kernel, without
any other setup changes, am I correct?

Thanks,

Paolo

