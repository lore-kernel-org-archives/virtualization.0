Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5422D94BB
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577566; cv=none; b=SWRn15GeeFk5/Hz+u78ylS18+Nx8KxGc9mWSMbLI1TKy8L4/Imrd/Lju7kz+6XOob9Y3Z2eWCHlcEDiXbySnZTHfiJPx6UtOdUN6H6GqsSefLIgWEVZW/F0e+r7LzuT4Oytvn19WdVMiI5RGbTdM4MpIvosAXz1UtzeDM8qaB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577566; c=relaxed/simple;
	bh=juEvfZ6xSAmrjLQLGlrgYpDF4UPOG2/XdIWNOau1zWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIohR6OybRp0me/O1ro5ka8lHtrJMe1XPT8MwRn0nh6RgEAU07G4/jeii0f9q3zP9FFSPRD1Yen5dH7u3Zi2LKUKUAT4BhjAaaZRSNgxVihP1Y1Xz2XMkNLnzLfQjurNODEsvyex83mMC8n/XE/aVE9cyJSiXuTytZzWg/25A+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqAtaACM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqAtaACM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so6363938b3a.2
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577564; x=1762182364; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuqEiBypQSyV+NhjApDxiloo6xn14f1pCOFw2OHgWCg=;
        b=jqAtaACMp0LHYO6JMBmvEeA2EV4IQv426g9gyz1rLICf8cDpk+qXIDDaJ0CZ8JFzc0
         asocPMS4K6jl1F8myDUqjttuUaz8ZJ1mLXIi8q6KsshCVXguDT7oaHMIV4/eio9SgTuF
         sAbg5YoNWY24+Nz9gGJUFJgGXqVeVN9PLD3c/oCFqGQe20tvWH0MAqJBHl3TOi6kJm4V
         DeWkUfaRQwFXhkX6wn4t54jatG1Q9+I8LBwhjpTHzgv0lBFX//O5s+4YZ8NWtpHcDSN8
         mLTrm64fEj0EBsOBNVkHs3Y5hOORoFYwkixhO3ndN860zIb0vKZCD8RcS206zPaxX6fc
         DoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577564; x=1762182364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuqEiBypQSyV+NhjApDxiloo6xn14f1pCOFw2OHgWCg=;
        b=uhAW6m3oL5kWlSPKeO5osHIap5i8Sa9EeSBCLNNWAaRXl5/Xv3M4R5idbL0BJhwwf6
         Mu1m6jsaoYrf7aG/iozi+MESkT/w7HSiw3P4IgGF96SxmafM2KitDzUpPH3Em+E+ngsc
         wzmVOj2iX/h7IKgGDJNTgfwmRskL6VJHFTtEWfXqpg7Mq7YNWpwT8DWmFw7Nu+QTc+ib
         by45XGuE/WbzUEy9uuhoKrGcy1iwkW8Lw/ERcyzqAQv0Vkjme+m8/Qk9SOp1kBr9nKg4
         IlHrDqpiNsUWoW9i245dH7slpxF9D0zJGFMhggi+DnmQz5S4BuwV3bs6BbSjo/4EK026
         FvOA==
X-Forwarded-Encrypted: i=1; AJvYcCVxZcNUyTPHxJ1GYQmOYZdYB+np6kosxjKo0hT1UNLTzMl8QITRD8xwy20gC1sG30KUBn7nJFp9M/MbocoDNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4vMlSlkUcSxvu16i16bkxROqW+18AJaQ9sEhBhsyvcu+glFP0
	jM45wBjKFymSErFxWNvJFE2EuMWPRd3fqzOR36aAhzDy7me/AW1vLoSi
X-Gm-Gg: ASbGncuwZPZpfCiBNSeUyCPfHlOLtUuNlVtEsdeb4MQLdgoaYGnEJNXhPVb4YOeHYdm
	AvA7hFaPBB+BdzabGkFVz7UAQt1S8AVnzy5SHdXADBpgmR1CVQ2nZ1k5rI0IM958lg20XMyWcfj
	/2gp+QSYl+rzz41D2lcgwL2jCQZh2r7E0xwyTMVaQ34S1dqAq++6THwRxbyCLpE+LwO8Dn60OvD
	VgkxVo/f8B6oTblbn+W9/zoMvpVjB3ienSzeAotNtGHXQKn6erJcxCgPF56JtTvWimTTm//6pWF
	8wRbdQjOzYajNY6KPQsQnPN7qJbD6IpJvvwQbwft4CkIq1sANocu6TbnFuWm/R3VNv2WdAHcMGT
	0IkJcJlUVu+sFOqzEnWICOxgcarRULJ2LLFuknFrIQdwsfObGTaZg2XPb4+xWU7T9tdEf0g1ohY
	4tLlAS9JJ1rbfzzS227NYnX1cfpSI1DdT0oaIuMI9F7sojGrqFVos=
X-Google-Smtp-Source: AGHT+IE//ftoG7hudWyqwVqH7rp/r57M0IzNCI5Ivf6IYwy5vXRcB+e2jlZU94XIYDL362p6j8hxMg==
X-Received: by 2002:a05:6a20:3c90:b0:341:5d9f:8007 with SMTP id adf61e73a8af0-3415d9f87a5mr9096245637.57.1761577564184;
        Mon, 27 Oct 2025 08:06:04 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318? ([2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087005sm8526808b3a.60.2025.10.27.08.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:06:03 -0700 (PDT)
Message-ID: <e7e05a6f-1995-4c49-929d-3d8ee7b0ac5c@gmail.com>
Date: Mon, 27 Oct 2025 22:05:55 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <8e2b6a66-787b-4a03-aa74-a00430b85236@gmail.com>
 <CY8PR12MB7195F589628BD6617A77F81CDCFCA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CY8PR12MB7195F589628BD6617A77F81CDCFCA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/25 21:55, Parav Pandit wrote:
>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>> Sent: 27 October 2025 08:19 PM
>>
>> On 10/25/25 14:11, Parav Pandit wrote:
>>>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> Sent: 24 October 2025 08:37 PM
>>>>
>>>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>>>> for big packets"), when guest gso is off, the allocated size for big
>>>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>>>> negotiated MTU. The number of allocated frags for big packets is
>>>> stored in vi-
>>>>> big_packets_num_skbfrags.
>>>> Because the host announced buffer length can be malicious (e.g. the
>>>> host vhost_net driver's get_rx_bufs is modified to announce incorrect
>>>> length), we need a check in virtio_net receive path. Currently, the
>>>> check is not adapted to the new change which can lead to NULL page
>>>> pointer dereference in the below while loop when receiving length that is
>> larger than the allocated one.
>>> This looks wrong.
>>> A device DMAed N bytes, and it reports N + M bytes in the completion?
>>> Such devices should be fixed.
>>>
>>> If driver allocated X bytes, and device copied X + Y bytes on receive packet, it
>> will crash the driver host anyway.
>>> The fixes tag in this patch is incorrect because this is not a driver bug.
>>> It is just adding resiliency in driver for broken device. So driver cannot have
>> fixes tag here.
>>
>> Yes, I agree that the check is a protection against broken device.
>>
>> The check is already there before this commit, but it is not correct since the
>> changes in commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"). So this patch fixes the check corresponding to the new
>> change. I think this is a valid use of Fixes tag.
> I am missing something.
> If you don’t have the broken device, what part if wrong in the patch which needs fixes tag?

The host can load the own vhost_net driver and sends the incorrect 
length. IMHO, it's good to sanity check the received input.

The check

     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE))
         goto err;

is wrong because the allocated buffer is (vi->big_packets_num_skbfrags + 
1) * PAGE_SIZE not MAX_SKB_FRAGS * PAGE_SIZE anymore. 
vi->big_packets_num_skbfrags depends on the negotiated mtu between host 
and guest when guest_gso is off as in function virtnet_set_big_packets.

Thanks,
Quang Minh.

