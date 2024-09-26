Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB14A24
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372806; cv=none; b=hucDl+hAl1s2lmlzE3ozMDpdd5gJ9ZFWXVv16tP4t7UT7GJCq3mP/nN6dvotmrAKXekTreM5nYQ/U4Sm08GwzKjMMNq7oa4UQeh9UW4cVd3DYHkUXGlSdQx0LmKkiOU332CGjvxex0hPK3zGazSzER+YYE9b1BeBC+L5dJkE8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372806; c=relaxed/simple;
	bh=Lmz7liPcNuuaaTWTU1XHUaviD7rc4zE+DOvgVm+RGaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/AfdxeF45EhmwUm3+2xwmoriE46fw7xJ+tAyoSph/7+sZhtrJ66CXuUIXMKlx30KOQ8N7tVodSPoXrNnhdZN2pxgobGcpEN9/IDBmkdbWoBdjj8XOfG91on6+X3l+EVy/hJTkTpGZt03zFmA41hXdSKbriTniCuDMhjJNILbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cfzmawtk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cfzmawtk"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-458311b338eso8431271cf.2
        for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727372804; x=1727977604; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sBHhXyPYas4J+tWOA4Kg0n0RXQMflyg/QVeqGL12BR0=;
        b=CfzmawtkkDSGzVNgH2BoXLV/g1QV+vXL4MVpmuI/BJzLZSUhQSYBmT9cMNqhbW326N
         J2oTVECLKSfIpLxgTJHBwbtemvUftiUOprImJhnnNfd9kS8V//YBAloLKMF5UoBMJ5PU
         nJXb2iDUPYCPorh+KwY1hZ9wqs1EjSQmg74xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372804; x=1727977604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBHhXyPYas4J+tWOA4Kg0n0RXQMflyg/QVeqGL12BR0=;
        b=UjhrAXj1zka+1hryA7n3iTjGfz894zyQYzWY5tD23ShSjeS+Lk10XkaIidy7vvxQnc
         IpFAN8e4WHHOoR7WsWm9QWaP3WvXvu9vnFaUapdi/zkSOnu9MAiUr908pVv4XpMC+iOr
         zSxaWKfpZ2ienkmm0cbWmo3XheweyOoxcfjYY2Wy8XPZdEBeQoZjQj+QJmkojJvKuyiM
         DuMIf8xOrMwEOGB4Kegfoy5otIrNHC4jsm/MNjUCQWrFRh6hlDWSr+RI2/VyunO+aWXy
         x4OZsdWekSDNQ3sZVeazeDT06X1siVmPM9Modp9xV5LSewFoRrHHIr1fmdk6Ke+qXddj
         K4lw==
X-Forwarded-Encrypted: i=1; AJvYcCW53VF6zpzfBW1irzWuJkEC0IGW7YJlg922ybHb85/BWS8htKbiCUxGxcEx/lrGkBjXAHPZWZSv9FGhMTkzNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp1ppnw20OKAjoMphH3058lHVBFh4e+Yq66cbvdv8Ru4E/rYnR
	8gZN2vE4qjsulfJZ6DPgn+vSVykiR2V8vf+9gOdEAUSRskr1wvc4L1Lvbao8tg==
X-Google-Smtp-Source: AGHT+IH2WYeQSFICFAZ1o8kVPzTKme8C/rnNs0aVGTTfhG70Oldn9u7cpzO7QrLkQGRWHlM5hfpMHw==
X-Received: by 2002:a05:622a:1a1b:b0:453:74f7:556a with SMTP id d75a77b69052e-45c9f1c76b6mr5577411cf.7.1727372803800;
        Thu, 26 Sep 2024 10:46:43 -0700 (PDT)
Received: from [192.168.0.212] ([50.46.252.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f28eaabsm1001831cf.12.2024.09.26.10.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 10:46:43 -0700 (PDT)
Message-ID: <b3442002-d1ec-4962-90b9-b409f12d7f5e@broadcom.com>
Date: Thu, 26 Sep 2024 10:46:40 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bouncing maintainer: Alexey Makhalov
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, virtualization@lists.linux.dev,
 helpdesk@kernel.org
References: <20240925-sturdy-red-seagull-2c17a6@lemur>
 <7ffe60a3-2dc1-40fa-814d-b0ec0aca7ed4@broadcom.com>
 <20240925-rational-succinct-vulture-cca9fb@lemur>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240925-rational-succinct-vulture-cca9fb@lemur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/24 6:14 PM, Konstantin Ryabitsev wrote:
> On Wed, Sep 25, 2024 at 02:10:56PM GMT, Alexey Makhalov wrote:
>>> The email address for the only maintainer listed for that subsystem is
>>> bouncing:
>>>
>>>     M: Alexey Makhalov <alexey.amakhalov@broadcom.com>
>>>
>>> This appears to be a typo in the email address, because I do see email coming
>>> in from <alexey.makhalov@broadcom.com> on the mailing lists. Please send in a
>>> patch to correct all MAINTAINERS entries to the valid address.
>> Hi Konstantin,
>>
>> The email address is correct.
> 
> So, both "alexey.makhalov" and "alexey.amakhalov" are valid?

Thanks for pointing out, I missed that from your first email.
The patch to correct that was just sent.

Thanks again,
--Alexey

> 
> -K
