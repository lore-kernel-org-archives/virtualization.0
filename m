Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA5214A8A
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418594; cv=none; b=Z4DECl34rrl1ieaPHN/W9HA/cDXbnNldTSqUHgNjQaqrcP4Ens4+OXuMOa8dE1JpD4/R9Qhvq6kHpqQ6hH7B/A7VLeo9ZexcmiG7p+vvDFCwBpQM32uUh8NXV+ySARX9ml4SIrPb1eVtrrQn51p52nE65exkRolyQde+n1P2YLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418594; c=relaxed/simple;
	bh=t0DQSzj76o+q28S/J/Q+aN0pxw+YPVtotQKrAVrAB6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXt688FMsqQCoNzlmZVKWbAquB/8LGID6ug7kRabCjVbbmx0wSb5Jms+a+KlL7kQIsfoGvRHvRzyubZrQDlE38+ekt5htf+Xa5+CNk9nI9WEXvndUUaxD+Yn+ldybbGRInkskwCVRMZvB4lihZVGs0CrJjo5/FzRGK9b4uPlVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsRDxFU+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsRDxFU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742418591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7HoSvSm7GM5yXTNBY3sCZv8nsyIwGMkLSsX5gJEiNY=;
	b=PsRDxFU+PpMqOQt5f/heazOIyN4YxilVn3h3Ytc9odUSozdaDZqt4eGfuCaTPMdlbxXOhp
	cybkjLWVMCBdx6K64wj6hPtNq1i7gFk1yJWvUYJLdw6+0UCb2EqjENJRcy0ga4iOAwHZ8z
	5YvaFYB/JX+b8QrjkkTCmjOWZIAsGpo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-8xKYzgO2Mh-XkdsLXDo1uA-1; Wed, 19 Mar 2025 17:09:48 -0400
X-MC-Unique: 8xKYzgO2Mh-XkdsLXDo1uA-1
X-Mimecast-MFC-AGG-ID: 8xKYzgO2Mh-XkdsLXDo1uA_1742418587
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso31836f8f.0
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 14:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418587; x=1743023387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7HoSvSm7GM5yXTNBY3sCZv8nsyIwGMkLSsX5gJEiNY=;
        b=I6b/lPuC98sn2NbJclKjeoGykPbEi/P0OloeHlDaAwU6VdlSY2YalMLRmddoJIPjwt
         Q2JdiQHu0xttBjVc7iHhju35VXSWifQ+OCSyIQuHfRAG7NS3r+34K42jtHQw9p5HV0Ra
         ZNMZAU4ejwF/SSDCGfPFYT1KdboGRlCAiAjI0lHvpPV2Ri5lTvp607wKQ81RzM6EOrsn
         QQ4lJIOY4gEIqS21hmtW3YMkyjc5G6Fe0bsRju1ckh6rxOTTeik/z2RdPCzWAEbKsY6v
         MW7ej6gzjgzgC9CO7r+H6kIN8F9yjKCSXprFaGNWi+xozJuDwYyZ+7EhNG45p2zhe8EE
         fAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyDG+gTZKxb1kx3uVBllW7joZ8CUKiFyPJyzqTnox9jgkZUCnvm9PDWIAXxbSPBDbdVq80oMf1L1CkcY9/tQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1B0Zk9mFkelrKBiivz/nXozzjNEASMkvXX0KgqM9VdgdrekqI
	lRmK1QvzF0V5rv1Up5XswQ3hxJAdIgIel9BwBT0B9BuFubUylAyOOo7wxtkT18oZYNR5EoexhXe
	IXj2Z/FwpprIdjFX70kFAMEMRJY+kiKt0msGFHVYfMJkEcc+cF2SsmxvKSOt9kkZ7
X-Gm-Gg: ASbGncsdPq4uR6VVbmg9cax5tC7D8SDrq0VAW26n2LWQ+RKo6Z7YFJZw1D+HkWcufk2
	sAiqyERFjzvPEvpGj3qUOkmjErIeSCbC6+JbohQ2hWzVY6r583bUjhalriC6RDJ7RVIgaMRF0pW
	cHrWNXAD6Mnwy2PEkKWDUSH3sx3io7V8OMXjCph7rLYekv0LoYPB8A9avcyl87YX99IJaOtqsLP
	HQf17sx11nUfmzTLi9H8CUkJhz6aG8lMyiKIXbqJe+j4SXW42HXDZBJg69p7g+JGEleDizRvR/7
	X0lAwTuqTwF2ScFmsFUC8MPnVLaWz5v5qxcvRYI0SZ4LAw==
X-Received: by 2002:a5d:5f4f:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-399795c2ademr966982f8f.25.1742418587042;
        Wed, 19 Mar 2025 14:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUNp5m5kg5nT9dIUi3KyGpUUwGQCEZhhXoTguvu2e0VxM6ACwAq8iInQv4AfDuk3Kc6Z9FwQ==
X-Received: by 2002:a5d:5f4f:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-399795c2ademr966951f8f.25.1742418586581;
        Wed, 19 Mar 2025 14:09:46 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35ecsm22151312f8f.16.2025.03.19.14.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 14:09:46 -0700 (PDT)
Message-ID: <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
Date: Wed, 19 Mar 2025 22:09:44 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AqbqHbcMVZXpUKFFuLjwEGITeHj0Ifh8LXNDF94lV5Q_1742418587
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 9:59 PM, Bobby Eshleman wrote:
> @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>  
>  	vhost_dev_cleanup(&vsock->dev);
> +	if (vsock->net)
> +		put_net(vsock->net);

put_net() is a deprecated API, you should use put_net_track() instead.

>  	kfree(vsock->dev.vqs);
>  	vhost_vsock_free(vsock);
>  	return 0;

Also series introducing new features should also include the related
self-tests.

Thanks,

Paolo

