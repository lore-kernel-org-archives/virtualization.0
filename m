Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474293A5E76
	for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864400; cv=none; b=bpFpuGSYAJhrobyCMYvS7q4DOUzYkAwGyMQN16goaIJkL0DDU/7fOSl1R0FKwvuba0ZhJyXAoboZDnKOVAkJpp+pehW2f8O1Z8Dptp6KuzNl4pmyjoy1AT07tiFKeOQ3e3zOqeRb0eZK2SfyfO8pB9Ic59DGq5v1PlPiwC2kJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864400; c=relaxed/simple;
	bh=iOWBNEkhaYulz60fd9nqYbYaUth2lUkhdRV+MRZ+GSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYL7XZ+b7wpeN4smoo5FhY/ET6GsqodWydP1oqh6I21Z9OjbzzRJnfTMBEd0akSNN7VElMRtdd1Xmo9ae1WMogUJGnbB1ZMhWA6m2Ip4XecjYbbKUTg42wrdIj1eI1BJMQt2ioNQQvTeea+xTGx8j9dt4chb8dhkSM04fVQn22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0BAxquF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0BAxquF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762864398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEMqTiIls3GK+BcBgDdLsrWg6wcMid5JirlC8x4cCJQ=;
	b=U0BAxquFk6C3O2Us3SGdMkpIj8xisbfq5cShEBO8qiPTsuuUZe360iOL2SBzwHOYdsjyB2
	Pk90NJ+ZjoLk0abI39ggvQ7VOastHAYrE5o7CZR0jYATBULgCqZonQXf2TWEy6K8MMUaLo
	AZTyzjPp3W8cHgzYMBEL7vSIS7Iecj0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-f5mzHni4P4GND-E8GYJ8Mw-1; Tue, 11 Nov 2025 07:33:15 -0500
X-MC-Unique: f5mzHni4P4GND-E8GYJ8Mw-1
X-Mimecast-MFC-AGG-ID: f5mzHni4P4GND-E8GYJ8Mw_1762864394
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3339cab7so1360610f8f.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 04:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864394; x=1763469194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEMqTiIls3GK+BcBgDdLsrWg6wcMid5JirlC8x4cCJQ=;
        b=fGUs7AMXQ7vzv9tCPVkqxv+mQCCmjdv0KZF5/auPnN5mqsYDtPTTk7jIfCvlUlUHKb
         /uGtcK+wTIT31k+OC9dAfQk6vOWIO2+Gqdl1OFy1LW27pQxQzFXbUxk75D+PoJZksOGy
         Emgr4HGIXhO8Mw+skJniK1nGWInKra8g8SDjVxy05//1QqAGct0g4bqCy1Z6URjxbjEp
         5Eupv65gEhgAowEzwAczalIY+bAiXEdYzq4sHOgQExGGWTTj9jNAFQ8lyiRZLhXI/Dcu
         XiUUErd5sbFqrkUca5c+pYBvrtxZUKW6oEVfDtYKai+1hm6lA35va4FTdIm9vBEZP3vv
         JZ7A==
X-Gm-Message-State: AOJu0YwIBk5dk6mGhoneU2Z1W3KF1diNOu4DxNu6Q7wzIq/39rXsKmro
	RCrlrBwU7U2CMmzMJk7prcw05oETux4jjaBNAd1T5VL6UCwJbM04oOmoe5rkCxohpM0ZPTEOPZy
	WheR/tzbLAB6tJAOE/CjGRkP+uHRszBG1LxI7AKRm6KGrVLAtufDXrthLb/DMTA8p7XzL0WB+ly
	SE
X-Gm-Gg: ASbGncswlAPtjucb/qd8nNo52oV6ZOi8ASivyMerfNlD8rRSA2r5zbfk+Kp5DRRBhEN
	mzaUNGcVmTNIuFLfeggPyEi3KjrC0uzWSlvBiV4W8tP698ZihqOU5eFmwgX747xN4FrtceO4lp+
	6bMLWTkt3gI6uMsyF2mHfHqt75sH7rtZW0ADRWP93if390nVSHHVeNcFbpmgUWhdUXwCyqYHWeS
	L2B5P4gbHvfD9TOWWlHSKjv3zQgNIoZ11DnHnavDmYYzeLhCTa+sGolo9jvin2Pa5HNWYSryZI8
	zqq9uS/C2qbpCFNnx4Aa1hIrIaeDTnRIntvKQG+/4DsgFk7ZqNwYP8WpYBYk+6I0VZi4aFpabE9
	kvA==
X-Received: by 2002:a5d:5f53:0:b0:42b:32c3:3949 with SMTP id ffacd0b85a97d-42b32c341e4mr8571483f8f.31.1762864393724;
        Tue, 11 Nov 2025 04:33:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEogtUOY4yTdf1DuIqascBGW9c45+fo19oaNrpbIqMX41Hc32xWFtKascZRxunxinjoalWo2A==
X-Received: by 2002:a5d:5f53:0:b0:42b:32c3:3949 with SMTP id ffacd0b85a97d-42b32c341e4mr8571452f8f.31.1762864393278;
        Tue, 11 Nov 2025 04:33:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm31385653f8f.41.2025.11.11.04.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 04:33:12 -0800 (PST)
Message-ID: <d19c7bea-9b4d-4f00-a6bc-35247011e788@redhat.com>
Date: Tue, 11 Nov 2025 13:33:11 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UIvkC4RmXSQs7g2m3HtJpdQHxfrA2qJUmrjnUOmhdms_1762864394
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/25 5:00 PM, Bobby Eshleman wrote:
> This patch series refactors the vsock selftest VM infrastructure to
> improve test run times, improve logging, and prepare for future tests
> which make heavy usage of these refactored functions and have new
> requirements such as simultaneous QEMU processes.
> 
> These patches were broken off from this prior series:
> https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/
> 
> To: Stefano Garzarella <sgarzare@redhat.com>
> To: Shuah Khan <shuah@kernel.org>
> Cc: virtualization@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Simon Horman <horms@kernel.org>
> 
> Changes in v4:
> - fix messed up rebase (wrt check_result() and shared_vm_test() patches)
> - more consistent variable quotes style
> - use associative array for pidfiles, remove after terminate
> - Link to v3: https://lore.kernel.org/r/20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com
> 
> Changes in v3:
> - see per-patch changes
> - Link to v2: https://lore.kernel.org/all/20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com
> 
> Changes in v2:
> - remove "Fixes" for some patches because they do not fix bugs in
>   kselftest runs (some fix bugs only when using bash args that kselftest
>   does not use or otherwise prepare functions for new usage)
> - broke out one fixes patch for "net"
> - per-patch changes
> - add patch for shellcheck declaration to disable false positives
> - Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

Series LGTM, but let's wait a little bit more for explicit ack from Stefano.

Thanks,

Paolo

