Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58CA27511F
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739377; cv=none; b=SZ4yg6kajc5asEt/6dhBWKeFMC7EEAqf6xg1UYj8QPMlNkKa0Q3C+Kp/VZkswidL5CUFLO2bn/rRXJYQhU42kn6iWacRUVWw54FoF1N7/x5qbWd5Ck063B3zBQLyZToz3rcAvYXjQFdugpqX8a8T47TIZ2tkCBCg2e8kehTySXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739377; c=relaxed/simple;
	bh=DyjGjmIKPnH7C36i8ffActQ/GQ9mwbRyIId9YRlceUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jRKqxs+k1iLX46BLYHqfIGYoGTE9o80eAEcrRBRx1HEUl9oBZJ814A32cNWPgsv5kgH8Goyd8peM5GhdL5R4QQBf/dSXlbscgKyw2CYaUjbR07dI6iOv+LJlit2KMxnYRxrSBGDzFNT9IMvRXGtllc1+0yFy8AUTIrwTkVzMxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ly0Gi48E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly0Gi48E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747739373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DARJsHp4jsWx/AeNTG3Ix546yRHwSXlPjjzPU2VmlJs=;
	b=Ly0Gi48EC6Ro1oYwtH1YQy21QYrxKNSW7z8VC3gtjyFYN/72+rWOsg673CXNmmZ1lZna+S
	vipqRQSkWN/Rmfuy5nszAsN/lHMdiS+oBJq5LxADRBbrwwFsHCCjoQE9qHt/LhvqKrpmu/
	PUYpANs2HwQ5C5rjUQ0C1MhUbUpHJMI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-3j7eLjlvNei1TsquIhn0iQ-1; Tue, 20 May 2025 07:09:32 -0400
X-MC-Unique: 3j7eLjlvNei1TsquIhn0iQ-1
X-Mimecast-MFC-AGG-ID: 3j7eLjlvNei1TsquIhn0iQ_1747739371
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acb8f9f58ebso439404966b.2
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 04:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747739371; x=1748344171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DARJsHp4jsWx/AeNTG3Ix546yRHwSXlPjjzPU2VmlJs=;
        b=K8WRwl/4C9FKOTobfIt25wbX39WOCksW4pr6G73ugEO3lrCj7Tl6UJPvTeA1GBVuTU
         /cjgPTZsr5mtvq9JZlwcURgLHChPuAB4wtsMAaDxRC+qCk1KJenIequ0zo4WTRCYSXyj
         Iitn1cSemIjrhdYU1IevhT6fdiTyME3RapnV2B3aHwBWoF38wjeO2zieehRTwFTxnMmR
         hf+jSVUKU1vPi9RXmN7mHrpsvUGSZTB09BuFeb8KDnq2W4AEiv9gmgMZuCd1kkXzECw1
         2OqBNGK16Z96jptP0nDwBAOQS1/eSSInKvLhi20YCHpSiA6iy+AQ622X3qo9YtSnDSMY
         hiug==
X-Forwarded-Encrypted: i=1; AJvYcCXMtgOwcwrUSYHtAIy5tErisBXH46lBieBBs3H2Rg8CQAeAlWHaLshofVw5+p3K8H2rzpPXjsyp0/JJXDwCdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YynUFWKZ0L+x2CdP423oDF4J5XM99XKn4jIV+CF/Pt5i70AM6PP
	W0GyH7tFudpcRNy/rX4gw6/LBvSpNTfjFZ2iJ7hRAdugTnI1/kjXUdGw4a6N4C5aCIbauVtf1aQ
	O/nh74/3konzjjnNGR9UTCajzLPdmR/GaSHM7j4kK7oMnzMWJtSCiHSwzUZGqGobWH75K
X-Gm-Gg: ASbGncsQzHu8eWwAFHX8MnoN9sXuXOj7E+4ZC32AzgffoDfokAAy3cdGV17b8Q1YeBh
	CZ7edKHY8akPvemPaOVUaGwjMgUYuYWBgygmPLjODmZQGqkBsJP/vKPrpyUPm9OGzB2C12684pm
	HhgVuIaXuCvsxgM527aVVx8vAe1yH4eAme9dZsX2jShyFF50keopAXZdFpK/XUSP2jhheUvqXLe
	coqO4C7Ck4RhCdRMjUZ5PyP1N/BjPohf3gADuoWEZ+gqJYUBHXQubHQHv1XKXS0LTLvLvQU1xIz
	rlzsSu421QXoMs46+t8S0kcQ36qmz5djsrymqXtel42XoI4/RqfOE08o4TRx
X-Received: by 2002:a17:907:d26:b0:ad5:715b:d1d4 with SMTP id a640c23a62f3a-ad5715bd3b3mr675886366b.32.1747739371297;
        Tue, 20 May 2025 04:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVmZPA0gP+lVwuu4tl/IU00u142/ZIBl7HKt5LlJNVBoXEwIpfvNF2MTZxVOWT8Ao84FYsRQ==
X-Received: by 2002:a17:907:d26:b0:ad5:715b:d1d4 with SMTP id a640c23a62f3a-ad5715bd3b3mr675881166b.32.1747739370698;
        Tue, 20 May 2025 04:09:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d271916sm722395766b.69.2025.05.20.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 04:09:30 -0700 (PDT)
Date: Tue, 20 May 2025 13:09:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <w6aizeb2i5m52e2ifqcikgwdbrkkbc46sf4hx5b6jsm7o4drio@n3dzlatb426s>
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
 <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M2LFS6x3ZXeDR_R_D_ZQzGY7OFjWGqRb8oCDgcuPPpw_1747739371
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 20, 2025 at 12:58:18PM +0200, Paolo Abeni wrote:
>On 5/20/25 10:24 AM, Stefano Garzarella wrote:
>> On Thu, May 15, 2025 at 03:00:48PM -0700, Bobby Eshleman wrote:
>>> This commit introduces a new vmtest.sh runner for vsock.
>>>
>>> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>>> H2G, and loopback. The testing tools from tools/testing/vsock/ are
>>> reused. Currently, only vsock_test is used.
>>>
>>> VMCI and hyperv support is automatically built, though not used.
>>>
>>> Only tested on x86.
>>>
>>> To run:
>>>
>>>  $ make -C tools/testing/selftests TARGETS=vsock
>>>  $ tools/testing/selftests/vsock/vmtest.sh
>>
>> I am a little confused, now we have removed the kernel build step, so
>> how should I test this? (It's running my fedora kernel, but then ssh
>> fails to connect)
>>
>> Would it be better to re-introduce the build phase at least in the
>> script as optional (not used by selftest, but usable if you want to use
>> the script directly)?
>>
>> Or at least I think we should explain that the script launches the
>> running kernel, because the config file introduced by this patch
>> confused me. How it's supposed to be used?
>
>This is the usual selftests schema. The user has to build and install
>the kernel including the specified config before running the tests, see
>
>make help |grep kselftest
>
>Also this is what we do for our CI:
>
>https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Thanks for the link!

>
>@Bobby: AFAICS this now has all the ingredients to fit NIPA integration
>am I correct? the last commit message sentence could possibly be dropped.
>
>Still it could be worthy to re-introduce (behind a command line option)
>the ability to build the kernel as per Stefano request, to fit his
>existing workflow (sorry for the partial back and forth).

If that's possible, I'd appreciate it (not a strong opinion). Otherwise 
if we don't, I'd say take the use of the direct script out of the commit 
messaging, because to me it's confusing if we don't plan to use it 
without the selftest infrastructure.

Thanks,
Stefano

