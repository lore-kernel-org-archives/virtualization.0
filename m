Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493200;
	b=WS+TU9nTJvvMRdfDwmAYRZ+cDETOOZYIvfbeOwEhSFv/lm0EdG5kCMqgNVuYaXotRzyQ
	 hbUZnnLNhxlow6XkwVowirvEpfMmom1O5rQhgfm0BOV8Vlq/DF+2isvoZXzIOzCdnK4vS
	 w0MAJlXR/C67RGRzJVAeZc/F2RVj1ZZP6lX/BgVDyejd2wSNYpANM207kVKJnLoH9IuX7
	 0c+LNsmcoSFQgCokMF65/fRP2zo17CiMUrYJoQ+WxXsm18omzNLh3x/ymikDHkwdKN4b0
	 xJRQ/Go8faNJE3ovuMBUigNdD576AliTL9vki2Av7hlDERV7oUnqDxblHBPG+tp4NNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
	b=4/tz5zKsvTLeo/TpwsKgQmCNcBVgcuHrJ2wXOr0jJsp+uiAxpGQY08V+UKoQDJS5TzSc
	 nOZpr7iRBKH8voyeVkOs9TPZTAAde0Jqn6wASPWh8P79COi1Wob4tS/fqXJcLLB++Fb5+
	 YShGZ/CTeWxoNgmtlKMVXks7UFilIUWaYdZEeWZRUr/AJd57KBwgZW8WsVfaQsP3aWGKD
	 73upAq1dv8ft4fRH/ZRkewM9xHy080yEWchJEAWAnsGa0Mg2baNNBlOfORTsLaJtQ8Ari
	 EjBjNXEi4nYc6Z5W1CAlis4lGKY7SEsIiiQAJqIexg1LCIsGLq6Az268qIuN7nKxJNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k6aQ8TBg;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19F6072A20
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 14:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC19F6072A20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k6aQ8TBg
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so33476715e9.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794493198; x=1795097998; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
        b=k6aQ8TBgvOP81qK8evRjO1kfyLhq37qbBlEGMjRzMYGHxNtz+BFOCJGKr3+gPAtExr
         K/8DJI+sKVNzR00NgxC69t1PwfynRjIf2+oh7dllbH8FG5RM4/Q96vp1B5lHIzdLccgi
         CRZSBsLU4uwpzZSB319txOuHJU0WN6vU0SvJWx7YpHJb4mWmieOOpEa+umXiQTn53Hnr
         VaxSyoM7oO53jHzZ+godH1VkcH8yZ9j4nzV0BYSqVLHlPp1o+Fx+lIM9+iZL2bS+HN6s
         XRN/wlXmoHVPxj2nJd59UsEt2NthrFB2Ahzd9U2gVna7dWd38fraBnq6oZe2CJkw7o0e
         N6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493198; x=1795097998;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
        b=0La1cGgrbbgJZz8sDaQ1lcNyyj2Vt26RufPGQp6zdNzOnt/ZqwaAjC5/6rztHl9pyY
         Z6Ge+3XeOsVBC7M+e6P2bWADLFJlDsuQMuX8m32xxUbjNqp5pspvJBHQpWOiRvWqvJim
         x3Nu4qN169anF4lQk3dZL7h5l/rMJUNLQhBVnLIkSwAVER5e2ajZ6pCqYFBh56P9uazi
         GJBFhrIfo+c6OrRmURljxg2R7uEWykrHm4kQpfq7KA/5Ovhwb4k+0eu8eOwDT2EoENlq
         0dscgWL0PL8NKd56m+KmSaUn3rNKUELLsF2Nz7Jcw+hR9zMK/lvyIicnaubZ6fO44rDE
         a7iQ==
X-Forwarded-Encrypted: i=1; AL+hErF4cTVQ3ott1pNlIHxqjLQ/XRIV+rKdVpQwPVkwsjtVJ28WTKrbjr7g8kDTrj8bRyEg9EazFkHK+Hm4iIiS5A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+T2jCSWVg189mAfGz8gzzXSDs71thEDmBHcX2FP9V4iE03Zo/K
	ibWOTiKE2EvxGt+6cWitmdN320Le/dq5DXsAGzr5+KKO8Id32MxYcI5mvQ+Yty5p520=
X-Gm-Gg: AYBFou3FBJxuKclnyPzHrOKqJN85lE5IjfxzZrPByRvvcW2dfJ0uptPlNHC1hoFf5e7
	Q1lNJ9AU4UiyFSvmQXZzkssrun3x2GAcvIDCnvEXJZmXVrebzbbsSlWXVVP2hkQ3W++CZfjWpsO
	/PhzKgzPas2SL1mV3v1zQRRiKC1kKu7EIa4fBojXsSCWnn3gY7Lsw779Pd8PbOmncqLjaSopmYU
	YZbmww3GgV9RdC2TZElMQ4QYhH8/DTMBNVeJr8UW81LN+duFQFvmBnyb+SdM0OxqV7p9peEqBUU
	SxiQlc4XP0s/cjVfjF/A38SVzMgjcM8LoMKcyfZ48z3ijJyoM8/yvFjDQBRbfyoGJMgubEW6kTX
	imvV/lRViHQsqjiBDoXA0d6jnvVXzLdotK1A16U+vyYQLbCvrHkZr6WaqAG0VjX2XLK7/i92R0F
	pFo9dXzibtWpnjGeZWTmZdHPu/V7kPaV0FZuUWkgZRH+11unpvywT2B/X+TXiNRsP25smRnBC3n
	Z+c2NzQe88ZOzPi4dmNGyHhu/fjwSigKg7cgU5Vw0WRnSy4R+MQFVYp0bv5hltfUGK81t6yLdCd
	qlViHukxrPsVoDCloDiW9qGFGugdW8hqptn5l+wUwrU=
X-Received: by 2002:a05:600c:4f84:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4ba0931ed6bmr104812575e9.4.1794493197930;
        Thu, 12 Nov 2026 06:19:57 -0800 (PST)
Received: from [192.168.0.167] ([109.78.26.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29d24dsm75906065e9.11.2026.11.12.06.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:19:57 -0800 (PST)
Message-ID: <a35530a0-3a4e-4975-8335-94898aa9abaa@linaro.org>
Date: Thu, 12 Nov 2026 14:19:55 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Srinath Mannam <srinath.mannam@broadcom.com>,
 Oza Pawandeep <quic_poza@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
 <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
 <97c4eabf-16b0-4e3f-8aab-1c56912c27d4@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <97c4eabf-16b0-4e3f-8aab-1c56912c27d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2026 14:04, Vikash Garodia wrote:
> 
> On 11/11/2026 5:32 PM, Bryan O'Donoghue wrote:
>> On 06/11/2026 17:14, Vikash Garodia wrote:
>>> @@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device 
>>> *dev, struct list_head *list)
>>>                   }
>>>                   type = iommu_resv_region_get_type(dev, &phys, iova, 
>>> length);
>>> +                if (type != IOMMU_RESV_DIRECT)
>>> +                    continue;
>>> +
>>
>> This change is not about requiring a reg though, which is why it 
>> should be a standalone patch with its own justifications.
>>
> 
> This is about reg, which determines the direct mapping, hence the code 
> is very much applicable to this patch. Please refer this code [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/ 
> tree/drivers/iommu/of_iommu.c#n223
But this change is not about requiring a reg. It's about not reserving 
when reg and IOVA don't match.

So reading a patch entitled "Require reg for iommu-addresses" doesn't 
actually transmit the information of what this second change does.

Which is why that change should have its own patch.

Require reg != don't reserve reg + non-matching IOVA.

A reasonable reviewer might ask "why is a mismatch dropped instead of 
reserved" - which is the question I ask myself as I read and IMO isn't 
answered - which is why I've asked for a patch which reasons that out.

It may be that conjoining iommu-addresses/reg and !reserving mismatch 
are in fact the same thing but I don't think that jumps out of the code 
as you read it and I doubt adding to this commit log would make it much 
clearer because it seems like two changes in one patch.

It would be something like "require a reg and don't reserve on mismatch"

The "and" part is the part I'm flagging as likely deserving its own 
patch which explains what/why but "require reg" ain't it.

---
bod
