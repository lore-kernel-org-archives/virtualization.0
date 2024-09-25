Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE022EE4
	for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298662; cv=none; b=CMTbL+kFxPXGgLHk4TQm7BJqOmFFxPTK+ZiZfF6j6s++aHSPKtK2smfMYuOyCMQ3Nf0xk4m5QrRDemYIoHrORqppNQ2AB4XdMjgGnSX0qRT5TYanVljI/CQyVxd2f3/lxJXMIgJ64Rc8S8OaHA+qGLA+J9l06RtG3nzW9myxQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298662; c=relaxed/simple;
	bh=sgNbBYoFeoNUnZ+I0McV2SBT2RS4I2xG+zbS0ryPr3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA5mp/Wq/sQ/f5SRqRQfpJBQFsXco8zrsRwEn9AhWEh3wEMyOFR+AyDzG/8uia+mo5cypnSZEPhPhNilM9mR0Qub9aTljzk0kdN9vMhxdp3kSyPenDgTFEZWbjnaZtN8IzCs3WiQmSqZ0cqfdxiKU3+N4brO0ZKDpVgUR0AZoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V1ZvuaoM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V1ZvuaoM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71798661a52so272611b3a.0
        for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727298660; x=1727903460; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EYFjh4y+oez80dLgCofxCbu3s1biOXUEJoxXs6c1E4g=;
        b=V1ZvuaoM2TVi6k68oo+U+DVYakFTTTUhhmNb44wMROD8+KvZmuWo9CXfJCQJGFDe7h
         E7CqqJSjiww7KUlnuAz2bCM3CC6Xi0oJn2dBQmcOoBYvVxyKaQ7Xkbjud2/NHR6UWA5S
         Br7v5k0WvS1etkJXrIKYlm5IDvO3AffYh38Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727298660; x=1727903460;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYFjh4y+oez80dLgCofxCbu3s1biOXUEJoxXs6c1E4g=;
        b=DZs+kRLgOur7RdCd+fKnM992o9GtSQLeSCZaQoaomjan+6kEKxrqwOhCWF40BMD7Am
         1rn+jTwgbqwh1F11IEiUoB7WhYre/j+zQeabt1gRAuVMxs0NRlpJgvstf08EcOo1idsc
         IScnPCkFGodt8rj4AML1MmiWuQlvK4osWC5nXvSxfgmoQAaVTkMBgmT7j+vVJDZM6F+n
         orlNCmFIyD/UF2XscQ3XwJe6Srh1kuWtjgunuTkgsJHt5mMsDI9eObA0tB0n+B8COFIH
         3/IcLFubPyNsrvPefPehA0LNizPLRBFihzVBrfhkFWPvsLKMEEEWe7GifLCFZjwss9bl
         ddVQ==
X-Gm-Message-State: AOJu0YyfnyO55dOPI4800yy166Cewfeip/poLTRQycI5EzeK9AjqWxBF
	G1XOzN7vj4CA03Wj2YU/UGvr+2QGqx15aFfSOLeVqRMFfXjIvyXw2IFuurxUEg==
X-Google-Smtp-Source: AGHT+IEWqhItnCg8mQ6uvM0Kx5G6pNAJ+zqehcTfw03/GT2jmcegYcY0RQVIRkW9n3U6uzWj5sP+WA==
X-Received: by 2002:aa7:8c50:0:b0:718:eeab:97ca with SMTP id d2e1a72fcca58-71b1926574fmr1175422b3a.2.1727298659754;
        Wed, 25 Sep 2024 14:10:59 -0700 (PDT)
Received: from [10.66.192.250] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c7a51sm3116634b3a.217.2024.09.25.14.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 14:10:59 -0700 (PDT)
Message-ID: <7ffe60a3-2dc1-40fa-814d-b0ec0aca7ed4@broadcom.com>
Date: Wed, 25 Sep 2024 14:10:56 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bouncing maintainer: Alexey Makhalov
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Cc: virtualization@lists.linux.dev, helpdesk@kernel.org
References: <20240925-sturdy-red-seagull-2c17a6@lemur>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240925-sturdy-red-seagull-2c17a6@lemur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/24 7:39 AM, Konstantin Ryabitsev wrote:
> Hello:
> 
> I'm reaching out to the list associated with this subsystem:
> 
>    - VMWARE HYPERVISOR INTERFACE
> 
> The email address for the only maintainer listed for that subsystem is
> bouncing:
> 
>    M: Alexey Makhalov <alexey.amakhalov@broadcom.com>
> 
> This appears to be a typo in the email address, because I do see email coming
> in from <alexey.makhalov@broadcom.com> on the mailing lists. Please send in a
> patch to correct all MAINTAINERS entries to the valid address.
Hi Konstantin,

The email address is correct.
And I'm still within VMware/Broadcom maintaining VMware guest code with 
latest contributions from 3 months ago:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/arch/x86/kernel/cpu/vmware.c

Did I miss something?

Thanks,
--Alexey
