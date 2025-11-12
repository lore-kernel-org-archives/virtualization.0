Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684A30DD0C
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946966; cv=none; b=rIMboJoEUpxl4AklPQ5Rdm0JyET+iOmvaO8XE9oyU/7Uarg1R1Blu0f4TiOJkxHe2UCtRjcSvMedXVtqDSylxgdjqb7UQS3YsMokphush38shA8lAGcqLpRpmV7+lIza+3KT2nx/scpQgwIlrQAR8YuJQCEaj/Lie5EUwyoTQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946966; c=relaxed/simple;
	bh=yRKl92YIodipSDJpj5FM6SuTiPvUzBXwPijlqgd2Fgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I1Ea0XDOxvEp1QA2hxXQqjFLCWMPUHXTUHtdoEVMYleLR43lPQkTAdaKsMV4pRLJD5HETL8HSKlk4WeB1/TyXURUSpXGD1MHRz+JkgiwdBhbXGdoUlECPpXN8nNsY7fo8etHDJNDXwKoaNwCn0yJgV5NBaPVxwr0M3hC0qFJqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+Shx7zG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+Shx7zG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+0n/gIH659cLeiKRT95CYm5fjgEisAw12N4OwZEDpM=;
	b=E+Shx7zGAPuYNBp79hZ4/INdDaBul3/kkjaRWFim/zfRJWM9wiH2E8yBFeicVJqsAXbFzH
	jGG3Rvz9gKMyKxjV6wHx7kDK2510IqT3G7fJIxZOGmIu3Z0mMKboGrKIxqTkleaTnRhRDe
	U+Rs0H4JDMfw33KHx8RJ9KVztqdAXBs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-yTKpiQmsPZ-dAqfLvefGTg-1; Wed, 12 Nov 2025 06:29:22 -0500
X-MC-Unique: yTKpiQmsPZ-dAqfLvefGTg-1
X-Mimecast-MFC-AGG-ID: yTKpiQmsPZ-dAqfLvefGTg_1762946961
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b25c61abe2so382213385a.1
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946961; x=1763551761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+0n/gIH659cLeiKRT95CYm5fjgEisAw12N4OwZEDpM=;
        b=bqD/KDCRegaVbPdP6HB3CNqX5Dqqr0LVD9j1m3tEHqlcxLv0wS8FWKPoDewdgMcyEw
         eMpCvC69NVIAJDJ73DR7NIp1qILvjiExTT4vjyqGgEzKqoKh9iZY21zSxyjsbiNhgu5E
         RD1icDq5tOusT4USM2KjfHIXBdzdVR8pCHuR8KW7zsvM5EzIwv0phK6b+s/LIFBrgEUT
         oJ78fg+0xlwkt/VBOxBnNLhsWd/ZMormBP5QNLIdOekB/eRHHjyk/c6vPWPChaYAKKmU
         q0NQSAlmCIqzrsDnupfEG4pmyY7ndPKKVJTm3u8jQv18ra3vcFCx37JfDdkrIWKiXvLy
         mNog==
X-Forwarded-Encrypted: i=1; AJvYcCUU0JVF+QfxX1eqQB57JjZee6maws0MmXkl0dR9rLjNH4UXDi7mAnn5eX5VNLi/mUi3xWCPHEvurhtmrwnZTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWO/mbszIi8uAP9mHznLKUYKtEdpZMGb+5ryOHCcAK013Cfp6K
	lT3sWS+rAROGTBWddnfoVAzvf6xX0/hsZTCLc1+JdxyIwomRc2b1MX6DYeWdtnIgmYjX1mYDeUG
	BgdhRuNypqlVaMJzpjYyYU+CwJOZRwehOAWRGhmN0Ly5AEyzoj+kvnLlxpIQG0FZ0oXGQCBRzJ8
	Os
X-Gm-Gg: ASbGncuY5lnDr9VRJgKlU0NSbr5vOlMpjcMHcVN2g7X48M5GJQzaerLTkwjT+xRptQK
	DHDIyr5QqZ0Yex82HxEeGQYmQmcYJ+sF9Tk32A0IzDQoXn8Y5pGv2uqdtqt18nhj3OiqRsAYOSg
	eYAuJq7Tes22o1X1fwpaBxmEhxfgMOMJgB0Z3eTQlLmhnwgeNkhynyl0BLa/Fi+Yy4/UBjwkxMZ
	wpeqKAeTYW6xJA3Z8RVdZZvqnpP/ckcL7gGgtL59VEXJWjZqT6mhWch05S6pRizBnvP0ja+O+67
	+t2uyDzUEpHhFT6QN70gQe1BkgdJETAvXZt3uo9/eUjplPGeig9EAfj+kAqNk2pg2nFv/jwtYXG
	3dIK1nKMJpf0u1eHc3no3f5MIbyi4gw452XmpUo8+4yVJxJktC8w=
X-Received: by 2002:a05:620a:288d:b0:854:b9a1:b478 with SMTP id af79cd13be357-8b29b764a91mr352965885a.18.1762946960688;
        Wed, 12 Nov 2025 03:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUJFxOJbDQYyH5iAisGFENmrwrjD8S/tLmssJoauTGvGRsQ2OlHPKZyUfeC9cCLoY0kaU2QQ==
X-Received: by 2002:a05:620a:288d:b0:854:b9a1:b478 with SMTP id af79cd13be357-8b29b764a91mr352963785a.18.1762946960297;
        Wed, 12 Nov 2025 03:29:20 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e7059sm172313385a.38.2025.11.12.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:29:19 -0800 (PST)
Date: Wed, 12 Nov 2025 12:29:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Message-ID: <3htkg6jotej6ev35jyc7edo6jtoo6tm7ciivnzvd7rd4my4nsp@47nbily4raoi>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <d19c7bea-9b4d-4f00-a6bc-35247011e788@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d19c7bea-9b4d-4f00-a6bc-35247011e788@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HIuOAQo_QaTNCFxF_2xp7ywFq-CYnTGKDw-Ik5kjPhQ_1762946961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 11, 2025 at 01:33:11PM +0100, Paolo Abeni wrote:
>On 11/8/25 5:00 PM, Bobby Eshleman wrote:
>> This patch series refactors the vsock selftest VM infrastructure to
>> improve test run times, improve logging, and prepare for future tests
>> which make heavy usage of these refactored functions and have new
>> requirements such as simultaneous QEMU processes.
>>
>> These patches were broken off from this prior series:
>> https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/
>>
>> To: Stefano Garzarella <sgarzare@redhat.com>
>> To: Shuah Khan <shuah@kernel.org>
>> Cc: virtualization@lists.linux.dev
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Simon Horman <horms@kernel.org>
>>
>> Changes in v4:
>> - fix messed up rebase (wrt check_result() and shared_vm_test() patches)
>> - more consistent variable quotes style
>> - use associative array for pidfiles, remove after terminate
>> - Link to v3: https://lore.kernel.org/r/20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com
>>
>> Changes in v3:
>> - see per-patch changes
>> - Link to v2: https://lore.kernel.org/all/20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com
>>
>> Changes in v2:
>> - remove "Fixes" for some patches because they do not fix bugs in
>>   kselftest runs (some fix bugs only when using bash args that kselftest
>>   does not use or otherwise prepare functions for new usage)
>> - broke out one fixes patch for "net"
>> - per-patch changes
>> - add patch for shellcheck declaration to disable false positives
>> - Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com
>
>Series LGTM, but let's wait a little bit more for explicit ack from Stefano.

Sorry for the delay, yep it LGTM too and I should replied with my R-b to 
all patches. In any case, it can go IMO.

Thanks,
Stefano

