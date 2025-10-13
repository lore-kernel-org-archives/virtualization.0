Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4562F1FD6
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343437; cv=none; b=lx6359ZJqtNoaOWsK4q0ARunOljvHrxNWbZYF4FfcC67iG5TzoFgDTpfkAng017V6MmTFrVu0GIRuvViWNDDwajfgmBdo2kDdbzTVWqnd44z10TIXgCJM0xj2FZ8ET3Mr+ae9byW/+hWq9qIdfwduxjOtM90YKBtceZ4GZ7OgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343437; c=relaxed/simple;
	bh=bbT9yOnrUpGxMOJQdhtTIrV7PDDNbFu+OWYMIHMr4KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Njrw63Vz1+yJ0UEUHX7ymLVX2ZplafB87C6UE/5uYZn5EfUx/JmcXQtzK7HHTLgYQRSqO+4KaYo6kaDmBMjEw2QBgGdO9/UW+aSijz5/1/3ErH7VlipxXWTub0qeOIX1mn+vltThHFufliQjFGAKixTThE4aBQthHhAQ41tBSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwXwHyIP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwXwHyIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760343434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqj5d00jcHO4W9mBttRtSq9Cpy6KvXlw2OhtfpPjxks=;
	b=BwXwHyIP2br3slqp5CZzPrLIlcQLDgejfA1rHpL1gsLU0aAbWs7luSXgQXD09a7hjbn4Ce
	FazbZLvVxjiCR8KXMNdjtoRtZYXI29F04+2XABZ/Zp4QoAUZopM9JvX6BYEMBl2LdLXkyx
	OvFx/JiZgc41i/zHDU27SwSIeV718R4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-Il1Llf35Ml-A_TZ3RBX4HQ-1; Mon, 13 Oct 2025 04:17:11 -0400
X-MC-Unique: Il1Llf35Ml-A_TZ3RBX4HQ-1
X-Mimecast-MFC-AGG-ID: Il1Llf35Ml-A_TZ3RBX4HQ_1760343430
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f030846a41so2783070f8f.2
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 01:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343430; x=1760948230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqj5d00jcHO4W9mBttRtSq9Cpy6KvXlw2OhtfpPjxks=;
        b=H5c2hd6mJn5FNuQkPn/4kWh0JDBwrSw4nzMDbS/OnF3dmMgZbWdCS7GombI+g+EdYu
         0XniAkpiVkKvHnMcmAJW4270ZDdgK2gmwCVLZyMKysObAQOQKnkmZR1OmKmV/HO1/DI5
         PoHCZAtTJtFug7VuthBT9HSW8LrH78U8JNLI+ew/WDgEHE4LjHjJyyJZ0hzwRIXVrqwo
         fzEdCuO6DXhzd1GAUKOP3LR3H9yIc/k+o7NSIrpANtrfOXTiGAfp+m9vWyhkX6v0DitZ
         DE6CApGjS8tnItfYVcm2pS9g86glYhgSRMz8Zm9NXNNyOU2O/wT4SY/qV+0sdU7WYfte
         wNYg==
X-Forwarded-Encrypted: i=1; AJvYcCV/KX2X5jyYvqvBI8d1wrlcufQ/pYKmYDWUzGjzmpR0yTdFfeqhij10ypdbHD/wD6gVQglqHkdDB4ThWcbAdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUD3LSSBxkFkl95E9Pmzpd2bLQiQ4IdeJZ/TVaLW2mVht6lgDV
	WFjU0iiFpBwm/EBzByQ+QLXDIzyb+yqz6uUht4TMo6FiaPFIXKdshA6bfEowDg6pL9MNeMgsyR2
	yyDUE9w0BBH8FGLW73RsY0EG8ENPfMWBj+hngfakZPng7jMnOqXBy3FwZ5E0qyIgNtnXU
X-Gm-Gg: ASbGncul29DkOJvbCJG/orRS58fHQyb+/SHtlnw859oA6CK2pn/Q/m7mcjA+03R1p1j
	sI8bourNUwig+nk8Q+/OfS5Z81Y8UaBgIPeskrEqRJ6QpqADk9BL+6wdrpzEOHM9qjHZ9jvMnI0
	Uw4Sj3281L12NPxqmy4s1why1ui7nbDbX8CooxGoelyxWFNsDkODU1B/I7Wu5kInflK+aQZ8Ftd
	fFXHqjFfUdMPHTSopSDeCCMgKVnZvCeU14YNmnPzdqoWhJu+dtCQrRMDByIJXJeRzAx0hTGlJ9e
	dZfj1NSEpSUo9QVNpo5/WeRAlQ18KHXt7Z9tpOHG47CA
X-Received: by 2002:a05:6000:4382:b0:3e8:94d3:765e with SMTP id ffacd0b85a97d-4266e8e6f33mr12096952f8f.61.1760343430205;
        Mon, 13 Oct 2025 01:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHNOu3j942TJx+SPp1N0vqDmsORYCRvGGBs28WUJxp2fKqfO/+R3TDIqKAKYVdaJfte8zuJQ==
X-Received: by 2002:a05:6000:4382:b0:3e8:94d3:765e with SMTP id ffacd0b85a97d-4266e8e6f33mr12096930f8f.61.1760343429832;
        Mon, 13 Oct 2025 01:17:09 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm17326350f8f.32.2025.10.13.01.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:17:09 -0700 (PDT)
Message-ID: <3480dcc9-a41a-4ae6-960d-4a13eed359e2@redhat.com>
Date: Mon, 13 Oct 2025 10:17:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in
 vring_map_one_sg
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>,
 eperezma@redhat.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
 <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
 <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>
 <20251013040810-mutt-send-email-mst@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013040810-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Apm_K238Ttxykoo9oDLRqQoq0DX721QCdAJnWT7CjVs_1760343430
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 10:08 AM, Michael S. Tsirkin wrote:
> On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
>> On 10/13/25 9:20 AM, Jason Wang wrote:
>>> On Mon, Oct 13, 2025 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
>>>> On Sat, Oct 11, 2025 at 3:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>> #syz test
>>>>>
>>>>> On Sat, Oct 11, 2025 at 4:38 AM syzbot
>>>>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Paolo, it looks like the GSO tunnel features will leave uninitialized
>>>> vnet header field which trigger KMSAN warning.
>>>>
>>>> Please have a look at the patch (which has been tested by syzbot) or
>>>> propose another one.
>>>
>>> Forget the attachment.
>>
>> I have a few questions. The report mentions both UaF and uninit; the
>> patch addresses "just" the uninit access. It's not clear to me if and
>> how the UaF is addressed, and why/if it's related to the uninit access.
> 
> I'd like to understand that, too.

Somewhat related: the syzbot dashboard reports that the issue is no more
reproducible on plain Linus' tree:

https://syzkaller.appspot.com/bug?extid=ac856b8b866cca41352c

"""
* repros no longer work on HEAD.
"""

Possibly there was some external problem?

/P


