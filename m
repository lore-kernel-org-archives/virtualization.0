Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C53B2FC2
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399934; cv=none; b=nBj6LLhKkht7lsQWDdXciJSkGyMq//fxsP9qAJuT2zoZ26fQpo7VheswnesWu8/wGjWAg18CPglvwCxZP83ZxHQdcxX9BjoZKgtJJRDlhPZhwhZEf0s5j/O+mFUvK+t9TFkbiuZ0eEK+n2UuQG58w7ar7r0FUwSY0XWObeDRlDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399934; c=relaxed/simple;
	bh=3HnYLCft5wrDNptkmSDOqzkg8ENAlnD+Y0X0181LznA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZ5mi90crrrzjyd5O+Zy9VXrLqYYGyxxex+glNLIuWGuz9GkGyceItsZh87FlTwejbuoiEpWLBKlPGfOddfc2YjaRZcxGLthgcTDWPC5mSOAMfgL9vbFI3hU6eVtwenVUHdrUUNC4Ks+5ocIpMfPrJYah7dp/x+HLYOg7pss3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dosXkjE1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dosXkjE1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf27856f9cso19659725ad.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785399932; x=1786004732; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fEPC2WyvmVN5ymscE1Iz0kKQcHLyRFx4o2IfQD+5pVg=;
        b=dosXkjE1XA4EwHzgY1U0MrP280c7A/hU+prwQmakBYADBtORoYdRrqxnfjGyIPiXwd
         B41WRfKflvXrSwOjiNIb+lRAsy+R5LhdiTEiqdvCP0zhnToRXPhToOcZ94pViCZhtutH
         f5mKZc7B9wUsk4/JTh9TxHWFkevQbfJtnI3zMPNeaHF5E0HhJ89QiDROuzGQHSFEjp0Z
         SERLj4BvAThXOvNBZMvEW0ju9RkA+ljTvq25hjmyo6Rfpestz4KP7ofPVfYoy1YDJ7Rx
         hGQ7UBMG2QZPnF/n6Y+f6N9Ki3VHLQw1wtAQ5TxjGbdRUZA2tEdjP3e48CtI/t1QIFy/
         8Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399932; x=1786004732;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fEPC2WyvmVN5ymscE1Iz0kKQcHLyRFx4o2IfQD+5pVg=;
        b=WcgPAoi/PpF5pHG/BZ9wL82YVAq8SHwNGd95k+JTtMgZj8qwLCjw6aMEgtKDokOeJk
         CfDwmHpuxbPNn0Ue8Po8Oq/KAg3nnJnfq2zPC/Ugn0syTxKlEXLNru4WgnORKdjATDL6
         6yIfXhD0Zm9QYXeMfivbqifELKNnpnH06mqMvnK3RD0H1BhN4WJGC3JXSaRKzBZuEfzK
         gAn8oUHXu40nNHsD/BNvTzf5SftcDqJ2nCHceocjGSydcErEuTc6kiSZL9ftnLyT5Hf4
         uOtfhrIrjyXV7TVfWONvBrWmi9njiUVEOrS6V3F1eGET3yevqk5x1eTkbcmyAqrGjtlI
         QVTA==
X-Forwarded-Encrypted: i=1; AHgh+RpFoZKBiAnVClYx6aKTLCL6dxloQdGEaACHkhcRC5IOZsiRJXVP2Qyt9T/PFrR6jwhPs6dcOYI7AAe5WP6t3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YybOEomad/t4HQgf0nYvK6sUTTTMdZeEQVG4bzPgW2ZuXL1hjTD
	Zwar8Rbob9Zwh8dCzfiHIWp7YVlAEUodMmUmjbxcg0eOlfDaJqfBv0pi
X-Gm-Gg: AR+sD11fMjGUsyiY/M3JzwGGtVZwphci0bZ60HJHoZ3wZnZGPPEsILj1cRqFTrgaOZx
	RNET4tmhVAF9pg3VLX4rmYF2u0z5eVEq66pH6cyATvoMKOyeWF34KF76LoJJVFwrWoQYVnq0hH4
	nZANoKY6fL+SHU+jT8oPjf3zlgZE44qBpg0utByJ7vpU5TYvXEQ7kyKbJO4S3Msx7ozMCkAAo9s
	VPv8b7OxwYQfTCIdf1CS4ViBfsugCW6u1OysFu932cEOlLam9kLCbSLrjlcTd9wEh2AR5WWqId1
	lQioEFMmeKxMlYdvr7YGTpiuK1Cn+QPFKLc4ARBB//gp/Q81ZBevNy/kZ+OnSLbMEgGWfegRIRo
	6mE0ns1LG6sdlTyFY/H/2R6WTj6dUjaL07PncGKlDBFK+k9FCK6U+Dyo6cyT/ktzpk92LZFjeAH
	y+80WlABPTlpkhHv/ypLwqP0yG/qGKL6Hy3sS3GOoeCKRSQvHBTyQ/qQPgZ8G8it1wcCz5GS6+o
	G4rQ2NQg7O66EJKkg==
X-Received: by 2002:a17:902:dacd:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2d035b98770mr17436495ad.5.1785399931588;
        Thu, 30 Jul 2026 01:25:31 -0700 (PDT)
Received: from [10.22.76.22] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c4090fsm22601515ad.80.2026.07.30.01.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 01:25:31 -0700 (PDT)
Message-ID: <51881c2d-0c76-4333-9bf5-63d4945c520d@gmail.com>
Date: Thu, 30 Jul 2026 16:25:26 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vsock: use sock_error() to consume sk_err after a
Content-Language: en-GB
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 George Zhang <georgezhang@vmware.com>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727071305.45826-1-phind.uet@gmail.com>
 <amn7W3hAIEC7kcQO@sgarzare-redhat>
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <amn7W3hAIEC7kcQO@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/7/26 21:19, Stefano Garzarella wrote:
> 
> Should we do the same in other paths (e.g. send/recv) as well in a 
> follwup patch or in a series?
> 
> The patch itself LGTM.
> 
> Thanks,
> Stefano
> 
That is a good point. I'll look into it and send a follow-up patch if it 
makes sense.

Thanks,
Phi
