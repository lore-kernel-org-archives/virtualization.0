Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9F221F29
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050599; cv=none; b=tBGsfOtSbcWC1wkya7t7/BHLxVr0gA9OCkrcXYSOwOwNL/Bw13or7ErDZ6Xo0Gp3En3Q4s4XyCFHCGYtstWXfBS8WQ49/0HaEJFc3l7DG7YMa3D4wIyhfHbdKf12loO91iHKi9lnmhVtQspR6mJSi2Jc+12zoWL2uXeNXlNMWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050599; c=relaxed/simple;
	bh=carmFchbB3h6+n0MrYXOugZ7YhuAaQxUxJVlaqD2wNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JN9lgGeIrjqP5bLHm/dHc7HiVbqudQ1V/cBNisJliWgDrmvmw7w2dmq9H4+AxslW02lxhQDnDLhXIqxg3EvlViA+sJxPpYftSF0Ijly+TO7HMec3GO1nJ6bR9Wvdmk7jZfxS3S430IofI+/5indROnnenea/4Xd0re3UsM5fYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S0mS08B4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S0mS08B4"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b06e9bcc986so302573a12.0
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746050597; x=1746655397; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2YWN51GbRiePbmSrLsK3YdrUKa8WqlcywHQ98t4q0ho=;
        b=S0mS08B4UyS51J3oWhXQbmCD7UepxrZK342wtjXLlpcQttlIt4ubwqgIJKaqNv+ero
         hqSDmT9GYlyjZyP+/qxsivXmYUsIwpuFTUEgQJ29jNP7reTkthJZtCZXbInMiYnT3SBt
         it/y6SjQOVR9muSCQgpQHrES7jdiodmoFvB7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746050597; x=1746655397;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YWN51GbRiePbmSrLsK3YdrUKa8WqlcywHQ98t4q0ho=;
        b=kO5+ytFwn+h66J3eSRGkMl6muN3HMXXNtJ6ycjuo4N7CgGKpg3BWHbhwmdSwvFb9Gt
         DLp9+nEB+nPLOIV3HDbm0Ip1RvYtNO78g/ih5F66SqFU49c6OBvLh9ugSy+zP+xeG4nG
         wcIgk0WNa7fEQDgyn+q2gkm1aPu5wR3zxuoHZ2faSDvdDqsMOlz26dMQxMu5o0219Hv0
         lWkU4295/mCb+5n4QxNZsPqyLvC5AzYm7zRInRHPbRBJPq4heWFRjV5xaEq+M8y307Ti
         IK0CZ6ASXxe89BoIUpkIxjc5uFZ512IGFNalNBqlTdXdi9v+9bbL7LzumPv9COHx9EqX
         aVsg==
X-Forwarded-Encrypted: i=1; AJvYcCVKtoLCOS1DFdGf78RO2hx8L83uleHUAYGjcd3bKwG3EfkoTDO/nskkcriPhcwnDrfhTysQ1wC3D4Pniq0CYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyavtYxmDgmG21Y0B+tuq80n1tyTbB9Bf9UcSOtY1poopVQzv0c
	bfnd/+BCXg+2aTZJ65r+yTxUP448uL279dwEodq5DJ6KWQoN6Ze8Fq+HeaXwKQ==
X-Gm-Gg: ASbGncuDcH3y2I4EcTulCD1t45UfXCGnt20mvWG+zUasBiaC9+EHvqD71K5rX2I+gM8
	o3GhsJu5WweKMtSyHzpSj6cwotYp438iyYMyV2P/kgT3tyixHJzQKvxBiClg66SJCZcitdHRzl5
	IGXMNwDs/5wHPiOveLhGqFbeddDtUkLPXI6TXgm1fc+Kkz3nLFNvqyZ15Iv8++UxEIiPYZ4H4LV
	YHBZ3AE85DxZy9JXtC5dPjXukLhvc7MoNq91YdQxtWLIHrQDXLI1/X5umdLe5fJUl9htwo94RPP
	dzCUxlgu/zC6rX9AXEp4FyoohQ0E5BvHAbMhX8KdlOPNAKgLic/bcfIOpW1nLZelux/an8jqqUp
	a21eHzBye+/wNLahzJPgIqptg73A=
X-Google-Smtp-Source: AGHT+IFpLzmAWQyi3yHhSLx4NQ7vfkHaDuiqhdSemTCGHQcKg8Di7BJKaapB4H2wF946DpWxN1pZbA==
X-Received: by 2002:a17:90b:2e41:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-30a343ce7ddmr6267761a91.5.1746050597312;
        Wed, 30 Apr 2025 15:03:17 -0700 (PDT)
Received: from [10.66.194.199] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34826677sm2210052a91.40.2025.04.30.15.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 15:03:16 -0700 (PDT)
Message-ID: <2fe44a46-cd13-47a8-8873-56292028b165@broadcom.com>
Date: Wed, 30 Apr 2025 15:03:15 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
Cc: gregkh@linuxfoundation.org, bp@alien8.de, ajay.kaher@broadcom.com,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Borislav,

I see this patch didn't get a traction.
Can you to merge this fix in x86 tree, please?

Thanks,
--Alexey

On 3/17/25 5:40 PM, Alexey Makhalov wrote:
> Fix a typo in an email address.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9763412a508..c2eb78c1ab75 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17945,7 +17945,7 @@ F:	include/uapi/linux/ppdev.h
>   PARAVIRT_OPS INTERFACE
>   M:	Juergen Gross <jgross@suse.com>
>   R:	Ajay Kaher <ajay.kaher@broadcom.com>
> -R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
> +R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	virtualization@lists.linux.dev
>   L:	x86@kernel.org
> @@ -25341,7 +25341,7 @@ F:	drivers/misc/vmw_balloon.c
>   
>   VMWARE HYPERVISOR INTERFACE
>   M:	Ajay Kaher <ajay.kaher@broadcom.com>
> -M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
> +M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	virtualization@lists.linux.dev
>   L:	x86@kernel.org
> @@ -25369,7 +25369,7 @@ F:	drivers/scsi/vmw_pvscsi.h
>   VMWARE VIRTUAL PTP CLOCK DRIVER
>   M:	Nick Shi <nick.shi@broadcom.com>
>   R:	Ajay Kaher <ajay.kaher@broadcom.com>
> -R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
> +R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	netdev@vger.kernel.org
>   S:	Supported

