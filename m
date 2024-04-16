Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54426AF6
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256294; cv=none; b=ZSkK27p10jXOeETjnMqvgnO5iI9YvfXZSBie6s6j6013Qhg6LkX8MKAXsZiDPRpie8Si5TUZtqvxj3iImae9EG2lXZZ9uzwJCNJYVVHSD2fD+dvKFqVw/j9jQG6F7tLfGzt0kbQKhwS0MPmCBtq29OlsMaN6M05FT/xBjG5eY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256294; c=relaxed/simple;
	bh=QJUQ/zdpL5MKogbwTVUpahdJojofb6ggmogXZkHP62Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpDpCd4KQ27+pSTG4uSgMuXPdZ97uzQpAV6P6kyXwHws+O7l6GS9HHH+bnwaqY5w02mvpq91lu4RfjHiRvs8b8nbSKhpC9HqxBUy9cJ/k5/uwSZfTOXdCz58DSxlpPxeOPDpzcZW0ePAHqdac/Lj2YxyXgHMhRYCdRST1i5jdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LgCvrSSX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LgCvrSSX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so1534279a91.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713256291; x=1713861091; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akzntEN6IcfsPIIN3EJ0b1QR4PPdVf92yYRa0+VTDrk=;
        b=LgCvrSSXzdYmYqhGauP0BkqW2bqSzhMQhkUG9FBUoT+su9+K4ZCV+tz1tOgUE7eZWs
         HLd/ZCOkul0rgq8focNYMZZzSs2D4DnFeKH0hhSZHAj63R77zIBY2FDCmAt7It+cdVys
         wWDAVE8j+ZVP+ehjtfcQjXrOMmA2cUDY2l3SnM2Fwrysd9EDusSuGl10RPaPg5OCUvu4
         cS9Y6QWE03Y32hKijL7qL4CQTkyuMLOF0wtGRcb3XFFA+gL+S+UiGc0KcVJyNkXRi/sN
         CoM/eDlW6+t8V4LvAvZozgKnw0AbQBLWUSIQBr6r5rE8PfBM9EebwLzWZ2ASxoPOsCUV
         UrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256291; x=1713861091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akzntEN6IcfsPIIN3EJ0b1QR4PPdVf92yYRa0+VTDrk=;
        b=CPvVUsBlHuqTUy+lDZWoXyG8i1jSpIT/5v3S5MBbg65Aj5GFwvzqD0bAeBeSiZ8DQ0
         D5YXFy5OZc1cRI2aTp8MQXgLziltt9J2pnuIpNqZNelfPpRymISin+WOssbuTuz0yfV+
         XoGgEYiWy+EyY1W3U+s0t3G75EqT6+dHgDyGKfbtxOvE2YktycPcEkkhZCMjPYDZ/KUX
         R171W904claE4OTP88txKb+uZlnGCt/TX7WgErSqGO9DFgj+fH61myIHGXto2o/pbf3Q
         31/Fu9EfNilcjQP/12/XSva60R8zvHkqb1Uuvk1TE7BMgRFMMxMRCSaxgR707V33zh0g
         3x9A==
X-Forwarded-Encrypted: i=1; AJvYcCU9Z3qEvK9+h0R0o0mQG6l+b7kotOfbahWn49CKcTz0QAXYtvWOIv18Kovh9vGEovE5TRkw79bLkUeT7GkSq8NZ5d3Xxld310QdzDdmAjs=
X-Gm-Message-State: AOJu0YzQ4AAksdNAoghC3B0Llax46bBrCu/h9lP9UYbkLklXzWaq3euP
	NTiZixTc1BbXy/LgfwAvBiRtxPZdtDCQTaSe4lU1LtcHo7eq9BT5Wwu3mt1JzJM=
X-Google-Smtp-Source: AGHT+IEjp4eHKvU41MXzaTBSiCq/DCxOMtVytJg0BK7QzgSTloHHj2HR6MrE7Rn4vkRt6wQgP/UbDw==
X-Received: by 2002:a17:90a:640a:b0:2a4:752f:b7b7 with SMTP id g10-20020a17090a640a00b002a4752fb7b7mr11498554pjj.26.1713256291117;
        Tue, 16 Apr 2024 01:31:31 -0700 (PDT)
Received: from [172.16.0.33] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ab31800b002a513cc466esm10012347pjr.45.2024.04.16.01.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:31:30 -0700 (PDT)
Message-ID: <2a63d7da-91b6-496d-9966-e6c0a0aa6c6c@rivosinc.com>
Date: Tue, 16 Apr 2024 01:31:27 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/24] RISC-V: Use the minor version mask while
 computing sbi version
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-8-atishp@rivosinc.com>
 <20240415-e229bb33ad53ce43e3534f5a@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240415-e229bb33ad53ce43e3534f5a@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 06:06, Andrew Jones wrote:
> On Wed, Apr 10, 2024 at 05:07:35PM -0700, Atish Patra wrote:
>> As per the SBI specification, minor version is encoded in the
>> lower 24 bits only. Make sure that the SBI version is computed
>> with the appropriate mask.
>>
>> Currently, there is no minor version in use. Thus, it doesn't
>> change anything functionality but it is good to be compliant with
>> the specification.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/sbi.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index f31650b10899..935b082d6a6c 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
>>   static inline unsigned long sbi_mk_version(unsigned long major,
>>   					    unsigned long minor)
>>   {
>> -	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
>> -		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
>> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
>> +		| (minor & SBI_SPEC_VERSION_MINOR_MASK));
> 
> The previous version had ((major & major_mask) << major_shift) | minor
> (parentheses around all the major bits before the OR). Now we have
> parentheses around everything, which aren't necessary, and no longer

We have to use parentheses around | to avoid compiler warnings 
(-Wparentheses)

Are you only concerned about the outer parentheses ? I have removed it.

> have them around all the major bits before the OR. We don't need the
> parentheses around the major bits, since shift has higher precedence
> than OR, but I'd probably keep them.
> 

Is this what you prefer?

return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << 
SBI_SPEC_VERSION_MAJOR_SHIFT) | (minor & SBI_SPEC_VERSION_MINOR_MASK); 
 



> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
>>   }
>>   
>>   int sbi_err_map_linux_errno(int err);
>> -- 
>> 2.34.1
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

