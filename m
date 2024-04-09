Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACD19B
	for <virtualization@lists.linux.dev>; Tue,  9 Apr 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622117; cv=none; b=BHHEnVT3/k2ACI5XyUcWVaxBKFVJXbi54HaXC/pEmG+DFN98rre0/KDGP/s3AR3mFiNiu1kRGmxr0S2tAT60eNgmKJ8hcrcc4MShfv0tfmO1gT9YZV4OgNzvaz0WpQfuj2TcS+rruC3o2tmcfM2ptVAiVbW6c6lTA7H5lpSLDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622117; c=relaxed/simple;
	bh=y8+B3fBdv0+pwLEVFa2oRmsHTM6gfVbpXdHodVkQD0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/h7ZVwWbYJocww6b+YhvUrNPYJuPwJCtYOGrUn8h9/2yItpYz0O9OkYhKTVVUE+v6oUJIoUEgZbDaO+si6ZsZS+IxfV5YAvmZBUlIh8mArVU8VMWIK9nWRlbTrczQad1DWdSSs1HZErdyeIZro/NrKXVMs4QZMEXRS+FhiMqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KKDcRLyq; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KKDcRLyq"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d5e19d18fbso60251939f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712622115; x=1713226915; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4RWqXaWFwmiNP6pNOx5Yfz/MuJboItuSjd5cmtvGoo=;
        b=KKDcRLyqBgQWsS1RBuJWvuKcjmnOcPNoFHopTXGaJq1l3MzxL+GenvLCRfG32ugY0H
         N/EgWr2y/RIzGNnJAkW58o2lwu+JIDMyM9V7qcVBP9jzm1pzFS8SD1KVZGqwKbNi9vjS
         zOpPCsco3mIrtcvXUxE0p/Lryyj+62vtch49g5bVah7LJeH4PNkdtuuKHgznWhg7cKqg
         d6HJD6/LswPre8qxYFhyEMqk3pbMOIvuPKxPbMDi1saMYwAxSOnQki8QfURIQq7jSQY3
         zMPMZzUBzMYbIklgt0u7ve8lYcwHQ2u3TB6fq8cLgz09qvH2lBbOmZufsLpFPWpbaWIq
         ySAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622115; x=1713226915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4RWqXaWFwmiNP6pNOx5Yfz/MuJboItuSjd5cmtvGoo=;
        b=OMbbsVj7gQxtM0pLhoqnI9rSNkcN+8OjcMydhgl+Xx3R/my4K9OyyTNt4SMHPqfHCT
         kewzDUCpa/XCt4q5lNYCfMdlMDoNBqg+kaTQNb6pClMYk3EYBbSzbprpwdXAW1OAPy+G
         z85Yy/Ejgcqa+01ArVQ35HID45yr33miWfTlCfsUngDLTWGFXvChz8SWwN5NaKLNWqr3
         M5Ne/p+vqxw0ZrklmMwFNDCoFqCIQ6Qu2/Kxc9ptiOBiHejYMjYhy09ZNEp1UD/dyOcp
         OgoqGwFUOZtBzt2kHJ5eNE5YYc7koTh/fpRgwokgqeFQ4eLDKSTbkwTf4cwSfO1+XPn3
         tK4g==
X-Forwarded-Encrypted: i=1; AJvYcCUl/W1ANLyG+Xn8HfpJMj9AFJoRowXjf+KXHsUA1YmtgfHARd8JYa4h+0TKHrwDvfoJhiUYulwo0YolwGWSbOPc3UpZx1po4NkQ5nzv0LY=
X-Gm-Message-State: AOJu0YwDOgRmq9oiFDipUh9eyz0LLnFvNICOZj2NJ1wJKYRaoNyzfkaC
	e/bvH8cSLDh4A8rgkuVQyRb1CQoZn1qvokXzBgWvzKznGVD/5Gv/2LsqyP4VcWw=
X-Google-Smtp-Source: AGHT+IGDn7RB5cU8iSXf8xntybKszf4HI5OoCRwBUHdVivfSY4dzeQk6+44VVtnK3iUR/Ypb1pjzqA==
X-Received: by 2002:a05:6e02:20cb:b0:36a:203e:6433 with SMTP id 11-20020a056e0220cb00b0036a203e6433mr6545247ilq.9.1712622115407;
        Mon, 08 Apr 2024 17:21:55 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::e8c1? ([2601:647:4180:9630::e8c1])
        by smtp.gmail.com with ESMTPSA id e1-20020a630f01000000b005f072084432sm7093745pgl.38.2024.04.08.17.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 17:21:55 -0700 (PDT)
Message-ID: <c33b4da9-5759-4a1a-844d-c6dbad028d12@rivosinc.com>
Date: Mon, 8 Apr 2024 17:21:53 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/22] drivers/perf: riscv: Implement SBI PMU snapshot
 function
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>,
 Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-7-atishp@rivosinc.com>
 <20240404-bbfb02e3aec944f9e11745ae@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240404-bbfb02e3aec944f9e11745ae@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 05:01, Andrew Jones wrote:
> On Wed, Apr 03, 2024 at 01:04:35AM -0700, Atish Patra wrote:
> ...
>> +static int pmu_sbi_snapshot_disable(void)
>> +{
>> +	struct sbiret ret;
>> +
>> +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
>> +			-1, 0, 0, 0, 0);
> 
> The "Rename the SBI_STA_SHMEM_DISABLE" patch should come before this
> patch so SBI_SHMEM_DISABLE can be used instead of the -1's here.
> 

Sure. Done.

> Thanks,
> drew

