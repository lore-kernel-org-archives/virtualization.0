Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C643901F
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134828; cv=none; b=l6cEoYxkPrI2U4ilbnXgzz05cSn1T32diMx9uLG08lGrDGuBWTYzk0KmIIeZYDgvrn0QtnMme2dyzD7fhG8rLW1nW5AklVtaLKamBl+O+ymFKqBBgagLeH//SdBXTWUHesszl85mS1h4MYNARnZuyxM4NAKOtdIe4R2zfIKP944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134828; c=relaxed/simple;
	bh=prO5jcc8QDr/hEZyY6kj9FvhTx8zB5lagn1VGqip1d4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r9LMECK3L2LupLFV/+MlTupNvoc43V8HmfOgeBHaECioqAKIby9rcl63WzQOTzcNbsHoTM4zTHWGNMb1LLbk7kzqbF2S88+zdtq2NEwz1ByOuKXP9M4Ul8JtBbxyZrtEBPInRdCsquiDJk+mtK9CFFpJEvFXIMVDn7YNR/bKmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAQHJC8w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAQHJC8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773134824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1KrvmYp6lBxwgMqOHTT+joFxW786mg3MVzokkCHO1s=;
	b=PAQHJC8w4eTou2l1ukkNrTDkjeDjF3nCM5pAzEu8AyzS10yZPtD2ufwRuhHTltiG1lxllJ
	bjT779OpdoYjrAKm9dkvEyrh5dOuCiJZgxiqmpu2kK5P5kVb37zHk0xPz/qHSIf7wTjuvC
	Elp3D5NzH/VXK+m5ZtnLZLSlXRqsj1Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-pBLG9_uhO6SajfdtEAeelA-1; Tue, 10 Mar 2026 05:27:03 -0400
X-MC-Unique: pBLG9_uhO6SajfdtEAeelA-1
X-Mimecast-MFC-AGG-ID: pBLG9_uhO6SajfdtEAeelA_1773134822
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439da07c5bfso3171234f8f.1
        for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 02:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134822; x=1773739622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1KrvmYp6lBxwgMqOHTT+joFxW786mg3MVzokkCHO1s=;
        b=bMQTQWJj6j8FK4aYGu2Z4AFhZH+FBbK5YBrYcIM/cPM5FZMb0nBrjxQUL50TRiaVnR
         UEGugu5CS0yh6pHZ9eDckiuVgkKcmMSoD1icxYgUEHfU9PZ37nnCX0Y062khXMzgZ+by
         7gKDKy5B2DLG/qefcXoFSCV42KCJWfVcKHs/U/Irirbb1ta6UGT3LLZPKLaEZvRXvgCb
         4wzExYfqINxrvC1lCEYjSx4ylCNn/3CZuN8vW0SVoohRdAaCNbFsR7SHNc1Rar76kVOk
         C+rnAoElQG4eh+1dUQN1MKtNULOcntHFXxScwNej50CpN5mfIurDffDsKQhQ+d/T8zFb
         aVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3fcbJMKUkIrZFxiwuKmAgii1IlVC+V9O/bavYGwcPEOwexdzGpBYGPCvhhNzMAA3HZBf0nSctbKeAUdlVeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydQP85qydooVkMqlzhss/YbKpuTKpMr4rOhu4UII4ZCIb7IJd6
	oIUlCpQAsPo8IJ/iyRNSGq+q0S2Z0Rh8wYWGjPkxfFhEmBU95U/I2aq6UgdX+W2vkBEgbP/cf66
	qviuPDxduC00dEQ+3lSKlaqGz57z4/A//HxZT9eSbZyyfVsZ1ZI2r2Ia+hKcNPTL54PjJ
X-Gm-Gg: ATEYQzxEsfZHFWf1BC4G3OM0VYyUqcq3Isltg1xphrITXRX7lpVftDsvpf6Qvn74uWf
	bkJ1I09UB28FrRyYx2O2cigaSmVizTsE2GFZQ28uFErnTDe0ETAweGHKWhAf2C7Lg/JXlIuZDCK
	uq+2RGXU7nloq5jGVJs0CTo/VTgXXe8khy/qo1HKF4yjUYTF6i8pYKFGRl/65MyhILcQBsULSLM
	rwivewUl/BXgHLtCL6jaZRGIYJ49R/vQTHeMSKcSfe0Po4k1Osd0BIvDFHnKg/XO65KVXtVM1UP
	IOVk5NVV5MmN79+8uvFKXPAj0x9dD+4BIL3Xbx2JYMhlaKbqvZgLpcp/mI0DLRQ38BvACOFCFSe
	gjqXRc8meAvswb14sp6IxKMgtrMGFUSkdNMiCAVm/xtZ7H6iW2LMChKnW
X-Received: by 2002:a05:600c:5490:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-48535eefa3emr126931025e9.2.1773134822147;
        Tue, 10 Mar 2026 02:27:02 -0700 (PDT)
X-Received: by 2002:a05:600c:5490:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-48535eefa3emr126930725e9.2.1773134821691;
        Tue, 10 Mar 2026 02:27:01 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a8f610sm103923765e9.7.2026.03.10.02.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:27:01 -0700 (PDT)
Message-ID: <ef3435b1-5d86-4137-903f-bddeca3deb91@redhat.com>
Date: Tue, 10 Mar 2026 10:26:59 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v4] vsock: add G2H fallback for CIDs not owned by H2G
 transport
From: Paolo Abeni <pabeni@redhat.com>
To: graf@amazon.com
Cc: vishnu.dasa@broadcom.com, stefanha@redhat.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 netdev@vger.kernel.org, eperezma@redhat.com, gregkh@linuxfoundation.org,
 mst@redhat.com, jasowang@redhat.com, corbet@lwn.net,
 nh-open-source@amazon.com, bryan-bt.tan@broadcom.com,
 syzbot@syzkaller.appspotmail.com, sgarzare@redhat.com,
 linux-kernel@vger.kernel.org
References: <20260304230027.59857-1-graf@amazon.com>
 <20260310091843.101237-1-pabeni@redhat.com>
In-Reply-To: <20260310091843.101237-1-pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K2S7jGzZEfWA0-hD2vGGQIUQMxSCMHkY0TN3ZaCSyk0_1773134822
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/10/26 10:18 AM, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
>> @@ -581,11 +585,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>  	case SOCK_SEQPACKET:
>>  		if (vsock_use_local_transport(remote_cid))
>>  			new_transport = transport_local;
>> -		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>> +		else if (remote_cid <= VMADDR_CID_HOST ||
>>  			 (remote_flags & VMADDR_FLAG_TO_HOST))
>>  			new_transport = transport_g2h;
>> -		else
>> +		else if (transport_h2g &&
>> +			 (!transport_h2g->has_remote_cid ||
>> +			  transport_h2g->has_remote_cid(vsk, remote_cid)))
>> +			new_transport = transport_h2g;
>> +		else if (sock_net(sk)->vsock.g2h_fallback &&
>> +			 transport_g2h && transport_g2h->has_remote_cid &&
>> +			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
>> +			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>> +			new_transport = transport_g2h;
>> +		} else {
>>  			new_transport = transport_h2g;
>> +		}
>>  		break;
> 
> The old code had `!transport_h2g` in the second else-if condition at line
> -583, which routed all CID > VMADDR_CID_HOST traffic to transport_g2h when
> no H2G transport was loaded. The new code removes this check.
> 
> When transport_h2g is NULL (no H2G transport loaded) and the G2H transport
> does not implement has_remote_cid (as is the case for VMCI and Hyper-V
> transports), what happens?
> 
> The G2H fallback branch at line +596 requires
> `transport_g2h->has_remote_cid` to be non-NULL. If it's NULL, the
> short-circuit evaluation skips this branch and executes the final else at
> line +601, setting `new_transport = transport_h2g` (which is NULL),
> ultimately returning -ENODEV.
> 
> The commit message explicitly states the intent to preserve the existing
> no-H2G fallback behavior. Does this implementation break it for G2H
> transports that do not implement the new optional has_remote_cid callback?
> 
> This affects VMCI and Hyper-V environments: when no H2G transport is
> loaded, CID > 2 connections that previously fell back to G2H now get
> ENODEV.
Other comments from AI looked like nit picking to me, but the above one
looks relevant. I forwarded verbatim all the feedback for completeness.

/P

