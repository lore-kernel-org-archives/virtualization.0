Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E472F6199
	for <virtualization@lists.linux.dev>; Tue,  2 Dec 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708449; cv=none; b=cqdJX3pCxEw1AV1HkEMIYD+saqHWJUPa5Zr6dwZDiMMyZTXGMtQo6niVp1ONX84sbM47iEeAZo+Dv6oeAIBHlHyBmNybEdjNyFSRXj9puMtl3KOLRj6QKUBH2qeINhahU84BDtPZcXaJ051Rv76luIZnDBXnpSXdu2F5gfQRgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708449; c=relaxed/simple;
	bh=UM18VZ97rudmnPHbViAf5T/QAoYaIPRYtTn8w10RmJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAIX6gut3lCeFo93v9gMm25dsnPokIXkKE3AyMZtOEvtS4S/Orj4vUbrVizqHH8eDvRKl49wIyw4YhGmDQbFkf3ulA1Lshv8/pA6kWeoStE9wFnjSvqjOPpbSmDhb2BUDaVBUfBdl1ycuvphePpTH9UBxd1n07q2SmEk0MVbHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRuT6630; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRuT6630"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764708446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93E6zWcOFHYDryuio97v2YbtHjZdnUdD9zTGmSSfbUU=;
	b=HRuT66301KO5Ni91WjHSvMsYnHHzIP5kl2J8kXShTFpS2ZK0Jj245knrneyCOd1MjWi839
	Hjl1kRUYI7k8rzZFzqTWXkG65gbaA08o2I3Vja6NAFCT2YvceTfeeEdslWbcweOHa/SAMP
	bD9mmZeWJV6x3NmAB+j0cRi3FYtEZeY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-unQl_eBoNV6BKwrwvWO0YA-1; Tue, 02 Dec 2025 15:47:25 -0500
X-MC-Unique: unQl_eBoNV6BKwrwvWO0YA-1
X-Mimecast-MFC-AGG-ID: unQl_eBoNV6BKwrwvWO0YA_1764708442
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso1497575e9.1
        for <virtualization@lists.linux.dev>; Tue, 02 Dec 2025 12:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764708442; x=1765313242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93E6zWcOFHYDryuio97v2YbtHjZdnUdD9zTGmSSfbUU=;
        b=T8dyhjC5SAtpSdl5HLXVIEHJyKnyqKIUzeqC+Zp6R99y2xJUCkVR1RpGK/DImeUwb5
         fxjfhQq6/WuP5ZxstVaT3uI82pYrhWYfAT2uO4f+CBD6GwiXaH/qoxLTepQguhV5BRt0
         2VPf9rXHbWa9FAMFtqWi8P+pIjbtXAnozSGloDMhT31X+i2xnE8H5zZubqIxCkKZX6MH
         W21reSYyuM2OB84gEZJMVp4VuiDUEesBY0D0i3wwp+RKgke1pEr61J7OcwEByt+1Orhf
         5obEM1u3ETwlV//mH+s+WWuY1+ZMCqs8Y/b7pan7NqGPRBso39XpUJLt4IIxz+r1Ne6y
         D4qg==
X-Forwarded-Encrypted: i=1; AJvYcCVpL+5v48g8C/CJEYUMsHVdlmUkli0CDMySXLQZxt3IsTlTuc9swLcLdx/NSbFLzKcF7HQt6Gt95I8IEtPlYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8nb4XG+7EgXK3FCFIgVqpl/4Za0B7L7V1ZMuNGeAi8K2+SSq8
	wDPwqt1leQ5NewfC4Pi+xR/SMtN5vr78/FusX9j1kVjQreRfgfvKKffx/Cxe7S+VehI2+t4Xh/B
	MLiHdn+mXPrN7kSyxjs4FXwjeaBfQ9hN7fDUWp7HcwWMW/KqsqPYd1VgvmM8LP6zv/C5V
X-Gm-Gg: ASbGncsPYGw1MW13iUxpvrJHLMga6Yto9EV3jDg6tohSWlNkCi0adulyO0oMNBElMBn
	YL/QwxEt1Qq9swwpG6nm/Kzd2+1dLQ2S4WkCF8WdYra1omfTk5jJj5dTsW2fWkEW6gigFyXA4iN
	RbB48znpNRwmpI7tHorS4/CmDWeDGzPoxprO6SSGXqn7hXspVAPnYJmQLjDY9mWR+Rcnadcuho4
	ihhrkFb4ZwRJT681QckKx6Qpk7U3LTydeIEjXABP+Gh3+FvSn/Pm2s2b6gkP2kAxVZXrH0CkPj2
	j81PyHfylKpYpb/r0mGcao/wYH9hXSVxyF8/Hfq4yXWpuHC2zCK4V/q+nr12QfSvLp2GvwBlVIv
	b3vYjHKtRb0Y1dg==
X-Received: by 2002:a05:600c:4507:b0:479:2a78:4a2e with SMTP id 5b1f17b1804b1-4792aeefe08mr67075e9.7.1764708442345;
        Tue, 02 Dec 2025 12:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtz/lzVuD567rALCwx3x7VkFHPvswA+h4sGnpysQXizUNAK/zCsPREdKaY3F5ZICBkIIzs/w==
X-Received: by 2002:a05:600c:4507:b0:479:2a78:4a2e with SMTP id 5b1f17b1804b1-4792aeefe08mr66825e9.7.1764708441897;
        Tue, 02 Dec 2025 12:47:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a7971c7sm8502095e9.2.2025.12.02.12.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 12:47:21 -0800 (PST)
Message-ID: <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
Date: Tue, 2 Dec 2025 21:47:19 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kselftest@vger.kernel.org, berrange@redhat.com,
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LQrOlh32PE4R9cKdJx0QXHfXz5Yb-r0OexaYDsP6WVw_1764708442
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
>> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
>>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>>>  		goto out;
>>>  	}
>>>  
>>> +	net = current->nsproxy->net_ns;
>>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
>>> +
>>> +	/* Store the mode of the namespace at the time of creation. If this
>>> +	 * namespace later changes from "global" to "local", we want this vsock
>>> +	 * to continue operating normally and not suddenly break. For that
>>> +	 * reason, we save the mode here and later use it when performing
>>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
>>> +	 */
>>> +	vsock->net_mode = vsock_net_mode(net);
>>
>> I'm sorry for the very late feedback. I think that at very least the
>> user-space needs a way to query if the given transport is in local or
>> global mode, as AFAICS there is no way to tell that when socket creation
>> races with mode change.
> 
> Are you thinking something along the lines of sockopt?

I'd like to see a way for the user-space to query the socket 'namespace
mode'.

sockopt could be an option; a possibly better one could be sock_diag. Or
you could do both using dumping the info with a shared helper invoked by
both code paths, alike what TCP is doing.
>> Also I'm a bit uneasy with the model implemented here, as 'local' socket
>> may cross netns boundaris and connect to 'local' socket in other netns
>> (if I read correctly patch 2/12). That in turns AFAICS break the netns
>> isolation.
> 
> Local mode sockets are unable to communicate with local mode (and global
> mode too) sockets that are in other namespaces. The key piece of code
> for that is vsock_net_check_mode(), where if either modes is local the
> namespaces must be the same.

Sorry, I likely misread the large comment in patch 2:

https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/

>> Have you considered instead a slightly different model, where the
>> local/global model is set in stone at netns creation time - alike what
>> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
>> inter-netns connectivity is explicitly granted by the admin (I guess
>> you will need new transport operations for that)?
>>
>> /P
>>
>> [1] tcp allows using per-netns established socket lookup tables - as
>> opposed to the default global lookup table (even if match always takes
>> in account the netns obviously). The mentioned sysctl specify such
>> configuration for the children namespaces, if any.
> 
> I'll save this discussion if the above doesn't resolve your concerns.
I still have some concern WRT the dynamic mode change after netns
creation. I fear some 'unsolvable' (or very hard to solve) race I can't
see now. A tcp_child_ehash_entries-like model will avoid completely the
issue, but I understand it would be a significant change over the
current status.

"Luckily" the merge window is on us and we have some time to discuss. Do
you have a specific use-case for the ability to change the netns mode
after creation?

/P

