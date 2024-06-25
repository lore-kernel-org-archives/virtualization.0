Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4E178361
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327673; cv=none; b=Wcxa6gCb0hvDdirJ6uMDZB+UPHZfHeb3zd79TM05tXhCNZISPPGi79kK8zdTGTuoNDQc/9gWy2rK3riAo/XvGGCvL4sCY2cHuO3+GVL6Frm2AH4Gor+pz5pa48Afs6eGByWSEWKVuYd+GGxUbCMfDZZs2pKbvn2Nvd3RNwLQHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327673; c=relaxed/simple;
	bh=8Mkc2dAeIVEx3R7G9p6Y+1c9o51iRv92j9rBtFVabHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m87ElR/klDpoiRaQyQ5NYjnLl2lMNVHsKY2ex9dfGSyl/ntiD5wX3f0q8kvJTwu5+OtWg4uCOMeZS1e7O6MDpJ0nHjaYdxYj+K6PqQNw9mn6Ru6ECvtACYZeTZNaTEAnDTUFT2KCRc9A9I5vzqG82DUzdUWzcSnSFlWV+6iQgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dho0q6Vl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dho0q6Vl"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79c0c19ff02so39937685a.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719327671; x=1719932471; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wU0PYC0ZkNLbhTARB/13j0B2U4nC3MBHctLxER+tD4c=;
        b=Dho0q6VlwlV5BUF1I8Cziw7g43cbubM52bxQvNmGSCNve8NNihD2UWQtXyCtYCmyin
         /WnLExC/CCLDyfTQlATnRomKBik90MaXt1T1rOKbf49xzARYDLdoODq8pOuqy9LkfA43
         V8pVAq38h5SmOjQ6Oqavj7cbruMzNfYxTbRGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327671; x=1719932471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wU0PYC0ZkNLbhTARB/13j0B2U4nC3MBHctLxER+tD4c=;
        b=UZDmCI7NZ1CGz5liUg+/m6KlBmx+Nl1GeVAel0L5DIlbVif/C8WkluEc28h01B0kcy
         uE4gaxXVSnqRdeKNgpE9Bi6aZunpN9xNsY5WEcnmOnPrsn5i8levTy7q9vGtFqwPkd2y
         CjNjJ/Of3Z+aRfLUsYvaLhR1/ijLHOHvtvLapmR0gFgdhdIS6g61rH/0gDvNoXCE1wCX
         ZS+qZFzDbkdLMvf9Lf5CKjRTPgDXQJXWz53+7HArVP0a+lj6BHaaz8Emw95Ljr1xfm/K
         M355LN2niCYsYFOXMf8hKzYTjVdYI3XOzrVqh0uCzZm2dPWdT0eBpJTm191cENQ8vP1+
         Mzjg==
X-Forwarded-Encrypted: i=1; AJvYcCWHyv/uqt4QqBC2MLFElp9bunGFemgPFxelxNM4YoXJ5CzxtOwgkz2bfscU5/xyGDKw96n/4FpbvaljPyi88SOY0HwXxZ3U8Oc0KSOD8dA=
X-Gm-Message-State: AOJu0Yw8Y634f4PAllPahF2/wA060fs+PTIIwEdmQYZTcNALTOiA35ky
	DwcyCDqBkBCdXDYsV2OHE4uscfrp+2iPPl0ZK0Xw+qBgfMXxyFXq+K71/rOgfnnuLslA78cCBbw
	=
X-Google-Smtp-Source: AGHT+IHnSEvz1eYSAgsxVMAW3ADhvEI2ogcmyxjTyn9pVh+UkXUPLC1xrx6TzTqfMgC/8209I7UkCQ==
X-Received: by 2002:a05:622a:4fcc:b0:444:f0b5:8a5e with SMTP id d75a77b69052e-444f0b58da0mr41753701cf.32.1719327670970;
        Tue, 25 Jun 2024 08:01:10 -0700 (PDT)
Received: from [192.168.1.26] ([98.97.116.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c96b06a2sm48629061cf.15.2024.06.25.08.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 08:01:10 -0700 (PDT)
Message-ID: <46fb037b-0ee7-4d30-b690-9bdfbb38aa00@broadcom.com>
Date: Tue, 25 Jun 2024 08:01:08 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/vmware: fix panic in vmware_hypercall_slow()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org, ajay.kaher@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, Alex James <alex.james@broadcom.com>
References: <20240625083348.2299-1-alexey.makhalov@broadcom.com>
 <20240625084721.GCZnqEGbrkNNW6ZCfZ@fat_crate.local>
 <8193d6d2-5322-4a9a-82ed-50ac24dd3525@broadcom.com>
 <20240625145128.GGZnrZcEK4YWOJyEMq@fat_crate.local>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240625145128.GGZnrZcEK4YWOJyEMq@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/25/24 7:51 AM, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 07:45:50AM -0700, Alexey Makhalov wrote:
>> My test environment was screwed up during the last version of the patchset.
>> I was using a kernel which was built previously and didn't pay attention to
>> commit hash suffix in `uname -r`.
>> Human mistake, apologize for that.
> 
> Ok, no worries, happens.
> 
>> Alex found it while doing TDX testing on x86/vmware on tip.
>>
>> Do you want me to resubmit the patchset to do not brake a git bisect?
> 
> Nah, I'll fold it into the broken patch and rebase.

Thanks for your time.

> 
> Btw, pls do me a favor and do not top-post but put your reply underneath the
> quoted text, like we all do.
Noted.

> 
> Thx.
> 
