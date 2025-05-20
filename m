Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1C274678
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738706; cv=none; b=JBvIz5OAgikCcnBs+wQSHf1r+TlxikDx4GFpNTPq7V86y/4mLAhNrl0J+evSkM7ci7u452kAD1os7rfrW471X5tjuGiTWvShOesSUn7vnS+jIYHhTCYQON3C930nXM8bfU+yCBq9SvXPGPGV8Xn/cjssho/2+azT0/xGMfxIxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738706; c=relaxed/simple;
	bh=XCjhuqMISSLiz8GE+zUfY3bVdPUVO6omDyP1PQiJ4QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amzBOct+xipxv6Lis+aT4cYHGTThhFruocDyx0LCp8zJUl5qixfwOCm8DWruUZfVc7vUo8+E2/mihz+y+gkJ2iCDqNOmSa9dU2L6DSARD1iaYbkXIZKarjguzS0iEjo0kU3ZqCajWSgl9s5RNTF7/PqwmVzSfiucSnqNNTZTOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL/1PXNI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL/1PXNI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747738703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D274b/Kowlx4frHiCJWZP9nEutUPctu6wUBTBcBAl+Q=;
	b=FL/1PXNIhWSeLXnyHnd6L1CGvcIpqOeGjkYUPkenRVJ23R1Fr5eOF/+kkgqWIiBQMRuEGX
	G/Jz/H50tVl12AC68A+385ys8j6BeQkOTibLyyAq9XeYXVtr89ts7h4+4dAU8lC4/DrsEn
	Gh6+1SOoStzECLl3V75G9ptC+vIgCHQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-lPBe4BWENuKpbbgQbeEVyA-1; Tue, 20 May 2025 06:58:22 -0400
X-MC-Unique: lPBe4BWENuKpbbgQbeEVyA-1
X-Mimecast-MFC-AGG-ID: lPBe4BWENuKpbbgQbeEVyA_1747738701
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442cd12d151so38666295e9.1
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 03:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747738701; x=1748343501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D274b/Kowlx4frHiCJWZP9nEutUPctu6wUBTBcBAl+Q=;
        b=pybgFMkKLVZLBu3RVjrWC27k4BwW3km69Wlj8xEaXwXMyZSfJG8LIB4/hgByUJjKoF
         Ywt/RJo7uQO+D4fzAN21pcCfY+Y1KksnptaBxwcBwQhKFuXipWYxBuwiX6uao0cT6LAi
         Laci+9oq5fl24BhWd1eNWqQxiK2PzZIi8VGO4UNw9L+gbjAuxjvoKN3U9fz3eR8BDRZw
         oCO1hFjPhpjkkDDSb7hwz8LxJl1tLtriECl9ihHXfzcjldETeWFDqAk+vzo9Yjz+t2zD
         J8yqkNNEUQGd66ckC4cPZrpjcsVuIFUYu7h+hZsJvcuRp91XFjSit0rsG+RWfoCRHhNk
         w9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmDc3qbOwRwbvlc6hjFHKe/nqIy7aWt5zBg3TNI6IXgC1fn7qh/s9oO91i3uRctb4ZqAqGnFZrJ0lMVnRkEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZkClFZUUnWSP+Ed6ABH2heS0u91lYTEy9g+CHKwzkpYdQUpZg
	P9HQhvKbnNmI0fMmUJMmSfq8+Tu5WEBSI8rEZhIxliidbt91hNEj8ZE5Kh6STXDES6jej5xMFZx
	oVdFupKzxO4VvAn5hNNuFAgty2C4huXaWj1cX5tzd4VqLXQT7NMC71PUCugq66cLY64ZW
X-Gm-Gg: ASbGnctgSaDPSCIPAoZbMUswdY0bPZtegq3ksB0mZjT0gxm7595fLEYs0GfX26T3h0Q
	FkcG3ivluivagY8OYYnuBEMp9QzZdlPayJx1Rd7LOPlmrS6uhVNrBx1Zh4g+bDGykElWPjD1hIj
	ndniatrpABtB3yrWkLGrK+8ygS85woF0M062hOS9zNUR8tJszsw4XlPc/uPQholiefp+ByTQbOs
	DQupp+i8GEop4FIoVX6MyJhdPJNqKuAuDg60ZzclEHrZ9InaqJ06D22ZwYRfj2kLqAB4Uwli+Hv
	2F+2/w9YbzpMeLAawcFDzn61OCnpz/0/BrejCRzVUDGZ9QzPkiNv1y1RDgA=
X-Received: by 2002:a05:600c:34c9:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-442fd671d12mr138378705e9.32.1747738701187;
        Tue, 20 May 2025 03:58:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvQyiml0UoaDF/88g9sn8ucNfch1PfIPLwL2A/DSRiTilof5rRlAsf3z16t0LsF6Ckj58VyA==
X-Received: by 2002:a05:600c:34c9:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-442fd671d12mr138378435e9.32.1747738700827;
        Tue, 20 May 2025 03:58:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca9417dsm15708833f8f.101.2025.05.20.03.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:58:20 -0700 (PDT)
Message-ID: <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
Date: Tue, 20 May 2025 12:58:18 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
To: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hQIEWLqOvB2ZDAi9zvRUP2UW9idcrHtAbRPQnfLtShE_1747738701
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/25 10:24 AM, Stefano Garzarella wrote:
> On Thu, May 15, 2025 at 03:00:48PM -0700, Bobby Eshleman wrote:
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
>>  $ make -C tools/testing/selftests TARGETS=vsock
>>  $ tools/testing/selftests/vsock/vmtest.sh
> 
> I am a little confused, now we have removed the kernel build step, so 
> how should I test this? (It's running my fedora kernel, but then ssh 
> fails to connect)
> 
> Would it be better to re-introduce the build phase at least in the 
> script as optional (not used by selftest, but usable if you want to use 
> the script directly)?
> 
> Or at least I think we should explain that the script launches the 
> running kernel, because the config file introduced by this patch 
> confused me. How it's supposed to be used?

This is the usual selftests schema. The user has to build and install
the kernel including the specified config before running the tests, see

make help |grep kselftest

Also this is what we do for our CI:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

@Bobby: AFAICS this now has all the ingredients to fit NIPA integration
am I correct? the last commit message sentence could possibly be dropped.

Still it could be worthy to re-introduce (behind a command line option)
the ability to build the kernel as per Stefano request, to fit his
existing workflow (sorry for the partial back and forth).

Thanks,

Paolo

