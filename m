Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94121C16A
	for <virtualization@lists.linux.dev>; Mon, 31 Mar 2025 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457551; cv=none; b=sMHhELa4MmyW2jNe++W5RfxJK69VtRzYX/Pheg77i/nR/wJOjZGyd0Z7s7EiVlBl9A6Mx4fLIFrL9CYGFC3ZrehC96oEL01Ksx4WjbBtoOzxSwgLf2K6UN2H6tzGX8k55oiaIv/9nlwvnpITgSoIPfC6407XdT1w3wVCeodEXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457551; c=relaxed/simple;
	bh=5Idp/e1CX6KvP46H/IAQSzNlFEJZHJleXvMU+UGEsKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqPWE/gDLcj/lOZFniBKy3aIYowCEK6dWzrKAco8wjiA6ffg/fikduDochET+CS9E2emFicQYQ8AsYS+SLmKkJshOFWIhQHVAhxTJXa7a0SToN0/zpCpxVZFbHm4ETCBEN3eebf2dpckj9R9XnKHbTJ3JyHtWmS5YSesS5nSa1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=lPchgpap; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="lPchgpap"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so49814145e9.2
        for <virtualization@lists.linux.dev>; Mon, 31 Mar 2025 14:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1743457546; x=1744062346; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mlR2/wtGl27sbeVJieM7lcGEWWY98/3HknehfYFQ3N0=;
        b=lPchgpapNYqfy+bhNN3Zfy4c5dq7dF/81OrVwmWXqwiQL3Hz9LV7qjcIxeA4VQbiWI
         TF6+8Xue9xNSFn9APudx2IL0tHe0EAW3o5vSuqmFvLDIKW9PgrAUKEhK/CGdlEX+gkBl
         /hrc0hmyOpaMd9xdfpH+r07iohvyMmTZt8atY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457546; x=1744062346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlR2/wtGl27sbeVJieM7lcGEWWY98/3HknehfYFQ3N0=;
        b=VxlMg78fEllVSFxnL6jIgsK4EkvCZugD/qQZrW9x7hKvvaQkRQN8UxWpdIHxRl6Te/
         KE1uUL3FjLPdw59ejOFCljbXz9T1t9pzt2t9h4oSlaAtN3NPWgfH+0bcwPGgs1zRcogr
         DD8MAubhxY3c9WcAPln42ECbWAo/94TO5qXU3w6s9lyu53mBzr5ltW6TUVEGPPsz+LdE
         TltI2znmChnwDNrdvZGmZvv5o01oEeLt2YCnZ59vWJ/oiOr0GfxP8pU/tx97YMoVcy5l
         dLDWMitWI5uVWIvoyoN4kSK78t4Cf7mbys7IR/BlPkIVnE202u9wSzbvFNHLTZKWcNrb
         GBIg==
X-Forwarded-Encrypted: i=1; AJvYcCVqsVSmGTxhCwxtpjalZtcHjP2LBsuq+qkA+GBNOiChsfoELGxdPtfpXRmdVL0U1412IIwqA51zUPAeDUo2IQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyW+jTseNKZyCx7o1zJoKIv0NERqTlMb9Fgvg8U5UY1W71UtBiK
	MZvWhI54CFmnd6NtPcezVWqttNOvfiV4SqwiNU1OajKJcZxNu8uBhbQvC0jiMq0=
X-Gm-Gg: ASbGncvFgp6ooz19AAUiGf1FvdyK3OZd2ZYWN83pSDMkC1urpgHW29i2trG3DhXJVrh
	WVNefpXTXl/oIiCQe0Xd1++lYvqOleZ6w3yI+2+glNrUCAfla7XlFQUe7NGhDjZ111yH0m3tm/4
	bKQbdzuk2JQe+Fxev4cw3UGx2SCmnv7rQAmKI/NwhPfk3m8f7ao3qWcLu+4LjCX8182bKK4f7Tu
	rwAPPgiLa+ALaa29Juk9iIVvHhuJCaJs/DqDpTzk9FSTvlKP+7lxeEaPZxDmyYSrTvW4VXW4cSH
	sHJerGeACnnfuZYY0+LiHGOugtSijXnv2IyLkvErZPF0WwuPUdcBlBD54eVdv1DHAanrUdNUSi8
	EwQ5Q/VK8Fg==
X-Google-Smtp-Source: AGHT+IEht0ibCOVwapLKQorYkWh1tvEc+BCDGhekq3S+vwpg3hG7nDeUzCkmGMWNB+hguSfQi069kg==
X-Received: by 2002:a05:600c:314b:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43db624b452mr113357845e9.18.1743457546422;
        Mon, 31 Mar 2025 14:45:46 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efeacasm177430295e9.23.2025.03.31.14.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 14:45:45 -0700 (PDT)
Message-ID: <0da43a86-81b0-4388-b47b-3a76b15f2a4c@citrix.com>
Date: Mon, 31 Mar 2025 22:45:43 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/15] x86/msr: Replace __wrmsr() with
 native_wrmsrl()
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, linux-edac@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jgross@suse.com,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 wei.liu@kernel.org, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
 pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
 luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com
References: <20250331082251.3171276-1-xin@zytor.com>
 <20250331082251.3171276-2-xin@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250331082251.3171276-2-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2025 9:22 am, Xin Li (Intel) wrote:
> __wrmsr() is the lowest level primitive MSR write API, and its direct
> use is NOT preferred.  Use its wrapper function native_wrmsrl() instead.
>
> No functional change intended.
>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

The critical piece of information you're missing from the commit message
is that the MSR_IMM instructions take a single u64.

Therefore to use them, you've got to arrange for all callers to provide
a single u64, rather than a split u32 pair.

~Andrew
