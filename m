Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5623C515
	for <virtualization@lists.linux.dev>; Fri,  2 May 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181706; cv=none; b=hu4qFVaOKoT9fnY183XDKBv18cFL/9ijw8tBluBI4a/TuV7XTfCJHBbz5orC0xXsKRFqDwE5HBuWO0pFnyRigi9VwnN6gr3fQDnYed8vev4krni4SZS+aM/al2kAe08DXBiJz3Ylthf3D4QjVhFRsOGhkjDs7bvANCYF+qEc/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181706; c=relaxed/simple;
	bh=SEU8CqxPdXWm5kBs+itfyCdnnlLFQ0gV+s9EvH0h3a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/hbEwz/3YyKeMhexXHLcqSwVk1n7rKtAmj0+jyce1UgwbxTKMuQ3RDHpJMBt56d/H6uC2s5/fwPlr4lHDJQclIEfHcm29PIt3mI705e2oHe8Ds7Sy9HmSDwJTb264MIOhsGNMpHh+YiYGujVE8sZOZImsBPs0RgVc6M2TzeY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O49jaUlT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O49jaUlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746181704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSbhw2lx3uIU9bt71Ke9bjoVhiyqLGEvU1SMMBHqrLU=;
	b=O49jaUlTgeTmaChlaxAksfMo5LHGkdS33Hsf9XQac/P61QpIZaRVJTJbtvjGxe5SWZYcBA
	37BP44hIWOINq2yraJR+rYlBCxd9wR+69lJf55wdZc7n9Aev+V4ymmQg4Otk6btN10OiCn
	noZ2U012LV7ultjUlT6wRvz4Jdfuxhs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-t0xKPKXtPvGAOlvB4vdr0Q-1; Fri, 02 May 2025 06:28:21 -0400
X-MC-Unique: t0xKPKXtPvGAOlvB4vdr0Q-1
X-Mimecast-MFC-AGG-ID: t0xKPKXtPvGAOlvB4vdr0Q_1746181700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso1160193f8f.0
        for <virtualization@lists.linux.dev>; Fri, 02 May 2025 03:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181700; x=1746786500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSbhw2lx3uIU9bt71Ke9bjoVhiyqLGEvU1SMMBHqrLU=;
        b=sZu/cmRhSDcLbtoIzwvNd1jSIHbp82lTKU46kwLamxqEzkzXnbR1K6xFleAEdZrTPh
         az5D6czC/fwAX3ict5el9wHj9dYYQ4TM1C4F3W382YfV7opWWHm5zUxB4hAhGt/ZC1Qo
         BqyP4HcKzQtyIDwaPozKkQfDh7yjtvkqctktUM3zp0SdL6Umww+yh9uKs/KDrXzPDU6X
         xP5/WD47KMuECqfEcOj6YRvYE1xBRP+oGjtk/vyMntmtbU++FZBjD3jdx5DDnDTH5crL
         +IJG03LsJssHgDR7zTlh70bOZfmyyf8+ec9DBs9CsTuwf/l7EWxUbF43RNdtbXC4As57
         GCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVweMDHepB9AoZKae9MafBZnhQ/csA27dAzBv35pb0jD1eSaHm+3gz1xV12Ggkm0VMehyDdGYSKX3LeaD5DrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YweILGPZIviNdN+R+Tp8f8nqWldSSnZ9GeB+5rLmfBgk7JPrN7N
	QcadyUCLQ0DQdvRjm7osLPHvt1LQdiElRcpM1IQUkUGlh9G4b8NV3sGdNrCgFk6xxJZ4oR0tISU
	SPE3m8knWR2/BbOT8wOok7mJQKqtoOqxEu9+8cZMW7hXEGVHW3gFxCnRYMU9eSb7/
X-Gm-Gg: ASbGnctUnX0YlBLHrOjapoDKhkgsZO3hZ1LbnmsbIAh+Q2NwgW0+2nXdzROW41WXTCq
	knGPXIhBcyKL7WQxRLV2DXptCpruxcPprZhlY2UM2VptEdkRwuOM0fPkNz/j+18yYo6R/UoD0kK
	6rs99D37M1YsZBCQ5W0xUn45RVMgApHO3DTqJV6veRQAhGasnhvTwHOh1hWwqfJkdBSTN/xdT3a
	MYv9ipysjijg7WxjvKqDE9nsMQ1G1jdn98/4usRd8KfHFnWeIpyWpKe4xqm1b7hRT6KJjgCcSk7
	DcHUETIqXxm4Ip8NN1M=
X-Received: by 2002:a05:6000:1a85:b0:3a0:8524:b480 with SMTP id ffacd0b85a97d-3a09402cacbmr5066374f8f.2.1746181699723;
        Fri, 02 May 2025 03:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWyOVTRRGEVNWXO/iDfooNor6IST3SO4x3a3xxs7csOvOKwxwfMPv7xS3Tnv2MrR9Li9kpkg==
X-Received: by 2002:a05:6000:1a85:b0:3a0:8524:b480 with SMTP id ffacd0b85a97d-3a09402cacbmr5066344f8f.2.1746181699348;
        Fri, 02 May 2025 03:28:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad784asm85337125e9.7.2025.05.02.03.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 03:28:18 -0700 (PDT)
Message-ID: <74e11512-934b-446c-94cf-93bf97eff9fb@redhat.com>
Date: Fri, 2 May 2025 12:28:17 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] selftests/vsock: add initial vmtest.sh for
 vsock
To: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com>
 <a57wg5kmprrpk2dm3zlzvegb3gzj73ubs5lxeukyinc4edlcsw@itkgfcm44qu2>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a57wg5kmprrpk2dm3zlzvegb3gzj73ubs5lxeukyinc4edlcsw@itkgfcm44qu2>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _8sP3IWzS4jMNZfRDgijje6dIlPDCE0S97C3UHSChbk_1746181700
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 3:06 PM, Stefano Garzarella wrote:
> On Mon, Apr 28, 2025 at 04:48:11PM -0700, Bobby Eshleman wrote:
>> This commit introduces a new vmtest.sh runner for vsock.
>>
>> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>> H2G, and loopback. The testing tools from tools/testing/vsock/ are
>> reused. Currently, only vsock_test is used.
>>
>> VMCI and hyperv support is automatically built, though not used.
>>
>> Only tested on x86.
>>
>> To run:
>>
>>  $ tools/testing/selftests/vsock/vmtest.sh
> 
> I tried and it's working, but I have a lot of these messages in the
> output:
>      dmesg: read kernel buffer failed: Operation not permitted
> 
> I'm on Fedora 41:
> 
> $ uname -r
> 6.14.4-200.fc41.x86_64

This sounds like the test tripping on selinux. I think this problem
should not be handled by the script itself.

[...]
> ERROR: trailing whitespace
> #174: FILE: tools/testing/selftests/vsock/vmtest.sh:47:
> +^Ivm_server_host_client^IRun vsock_test in server mode on the VM and in client mode on the host.^I$
> 
> WARNING: line length of 104 exceeds 100 columns
> #174: FILE: tools/testing/selftests/vsock/vmtest.sh:47:
> +	vm_server_host_client	Run vsock_test in server mode on the VM and in client mode on the host.	
> 
> ERROR: trailing whitespace
> #175: FILE: tools/testing/selftests/vsock/vmtest.sh:48:
> +^Ivm_client_host_server^IRun vsock_test in client mode on the VM and in server mode on the host.^I$
> 
> WARNING: line length of 104 exceeds 100 columns
> #175: FILE: tools/testing/selftests/vsock/vmtest.sh:48:
> +	vm_client_host_server	Run vsock_test in client mode on the VM and in server mode on the host.	
> 
> ERROR: trailing whitespace
> #176: FILE: tools/testing/selftests/vsock/vmtest.sh:49:
> +^Ivm_loopback^I^IRun vsock_test using the loopback transport in the VM.^I$
> 
> ERROR: trailing whitespace
> #443: FILE: tools/testing/selftests/vsock/vmtest.sh:316:
> +IFS="^I$
> 
> total: 4 errors, 4 warnings, 0 checks, 382 lines checked
> 
I almost forgot: I think it's better to avoid the special formatting and
replies on review for proper updating of the script's help.

Thanks,

Paolo

