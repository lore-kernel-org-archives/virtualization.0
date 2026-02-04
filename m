Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C82F7AD2
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194422; cv=none; b=SzIrpWA39C+RuTTB5pa7EGBwI/wcv9qvCYrkquhCqkT6cUY0aMZLQ0jKxK1jWbcfcbYBSYG7o1kzuUOFiTcx2ewloQgm3IxdLfkhTdiPkniLsliHZyhnC3ABLGMBNgs5yVGujr/WvJfQ8jy85yOIjHfhfb4EPVpTkjPkqAhxtwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194422; c=relaxed/simple;
	bh=3+L6PI4GMuiQHrHIZb7E3cB/vnOAJRDCFkosOULZ/80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBsA6CWmDzBTjrxPMv4CdGxJhSsu6Hlhaxd++C1Q4FOmyYup2JJy352SAjqAjJQwEiFeMJltYUPwvDjbS9Q5JOvsOWkVgc31q3v1pkbDRfMYCrbfPmbXS4e6jxSu3d4p2o1QAZAUeydqpnx4h45Sp5VxIM7DX7ncw5vM4z+JWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K43YDj8b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K43YDj8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770194420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6IMhKc2VzBHFc6lr2fAv4BQhS3mPy88vUETyFpbphk=;
	b=K43YDj8bHH1WNZUYAGOlGhuTA5b94i4QpLOPa4jVvbLIoEtcSUqo+odiPmHEU8fWvjc9v3
	l+ufYBMJdk80nomtIdjQcZZtsuVSlplnes4MllIJxepcEp0nqD2wv+aLDMITxt2hN6lhfi
	drMyPaNOxwNG+zL00AYZc4scMh4Giv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-C-1ZokPtOpeslf2OdLMAOw-1; Wed, 04 Feb 2026 03:40:19 -0500
X-MC-Unique: C-1ZokPtOpeslf2OdLMAOw-1
X-Mimecast-MFC-AGG-ID: C-1ZokPtOpeslf2OdLMAOw_1770194418
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so75006075e9.1
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 00:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770194418; x=1770799218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6IMhKc2VzBHFc6lr2fAv4BQhS3mPy88vUETyFpbphk=;
        b=BMyW4PCOyV3pS6EqfEX+7KXlqym7v7EndaLBm56DksNIqF8Jv5o7dn6DiuEr3YMAZN
         6oZUeIewYWYoRuX1Y0LDTarj7GpJ69YW9i3gIacYczOyu7xUT8YCAYbyiHEQr0DaeTkj
         0hm3GdN7PO0X9/HAQCUvl8L0EhcstgvO1p7pmRTflc1Jss5m7XZnt+fQfFBtYqJ+sT6H
         1Nmz3m+VnPTzsVRcFXjX42qSJJsHTzNsGpjiVufuNJQqS5SjKNAIjqZx8kyUJUTOUqiU
         wyt3nuwbXGIEgRbdJO2AEp8JmHLkm9uyeOg0kPWIabbuNMA2H/0NCCzko41e+g7OvPmc
         wDTg==
X-Gm-Message-State: AOJu0YwYWD3i/af2X0Qgp2D3ywJj6mgRbHwq/JbsMsjf4p4FIj/BksxL
	gLZmPSXQHbHsfPfmzeh5bAddubFNpH5zx9c3ScwnKbrsdCwjqIBU1RLa4tTJrWBofVWdLxVd9fH
	YcVx/9ns2xuLAg4e+Jt7IngKJLBiLASk8RkNdBpAre19v8Zu1S1l4pDRr6tOs+ef8ZN8B
X-Gm-Gg: AZuq6aIzet9ithnr763tHmA+YW//NvCy/flwSXT4+nWm2FXKNowkBRxAI7JTifaVn67
	DNWuOTmGg8WQxBNj4+YC9II9T1BEM/BcNrqQr6Vovr78yIEX3HHtmMA+ADMHK/mu/YCh3XNdQ1W
	fQ3+vHDS/eDrlhPWm4/ajZTwlkL6I//WnZDkxgC2uGJ93+8D7krC//nlhW2r0/3MHG14SK+AY/6
	tB9BW3nJ+wBMaLd4CPHI0DDtmtNuZTnZHT8lKYokFxXbsZ8kKTzuXhVafmBC4zeznV1k4nQypyv
	2Aurww9mt8aIEpixythJ/Elp5Rb8WGm4KbrPbJ7R13LeZlg9ArVIejFYaj/k3IXtGZXFP7L4JbD
	4cn/ORHHZK1xA
X-Received: by 2002:a05:600c:3549:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-4830e92cc18mr30995955e9.1.1770194418122;
        Wed, 04 Feb 2026 00:40:18 -0800 (PST)
X-Received: by 2002:a05:600c:3549:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-4830e92cc18mr30995685e9.1.1770194417736;
        Wed, 04 Feb 2026 00:40:17 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffc9f3asm14137265e9.19.2026.02.04.00.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 00:40:17 -0800 (PST)
Message-ID: <eb700d8d-81e0-4c56-9cf2-48473404563b@redhat.com>
Date: Wed, 4 Feb 2026 09:40:15 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: Dan Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260202170518.9076-1-danielj@nvidia.com>
 <20260202170518.9076-8-danielj@nvidia.com>
 <90017867-2649-4632-8497-96e2592c73c3@redhat.com>
 <a3aec539-9468-4273-b7fa-6705331c9b92@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a3aec539-9468-4273-b7fa-6705331c9b92@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xJscnyE2hzlWYcTFoDBp-W4xjnCoYKmIGXQ4JQmqdl4_1770194418
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi,

On 2/3/26 10:40 PM, Dan Jurgens wrote:
> On 2/3/26 3:19 AM, Paolo Abeni wrote:
>> Hi,
>>
>> The AI review reported a possible issue that looks valid to me.
>> Reporting the feedback manually because I think only one to the AI
>> remarks is valid, see below.
>>
>> On 2/2/26 6:05 PM, Daniel Jurgens wrote:
>>> +static bool validate_eth_mask(const struct virtnet_ff *ff,
>>> +			      const struct virtio_net_ff_selector *sel,
>>> +			      const struct virtio_net_ff_selector *sel_cap)
>>> +{
>>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>>> +	struct ethhdr *cap, *mask;
>>> +	struct ethhdr zeros = {};
>>> +
>>> +	cap = (struct ethhdr *)&sel_cap->mask;
>>> +	mask = (struct ethhdr *)&sel->mask;
>>
>> This function casts sel_cap->mask to struct ethhdr * and accesses fields
>> at offsets 0, 6, and 12. Shouldn't there be validation that
>> sel_cap->length is at least sizeof(struct ethhdr) = 14 bytes?
>>
>> Looking at virtnet_ff_init() at line 6291, it only checks that
>> sel->length <= MAX_SEL_LEN (40 bytes) but doesn't enforce a minimum
>> length for the ETH selector type. If a device provides an ETH selector
>> capability with length < 14 bytes, won't validate_eth_mask() read beyond
>> the allocated mask array?
> 
> It won't read beyond the end of the array. When we retrieve the selector
> caps we make sure the that the size of all the selectors and their data
> is less than what we allocated. So I don't think this is really a bug.

[sorry for the latency]

I'm possibly lost, but I do see such check for classifier->selectors,
but I do not see them for ff->ff_mask->selectors, neither in
get_selector_cap() nor in virtio_admin_cap_get().

> I'll change the check here to be sel->length !=
> get_mask_size(sel->type). It'll fail in a clearer way if this is the case.
> 
>                 if (sel->length > MAX_SEL_LEN ||
>                     test_and_set_bit(sel->type, &sel_types)) {
>                         WARN_ON_ONCE(true);
>                         err = -EINVAL;
>                         goto err_ff_action;
>                 }

If you mean:

		if (sel->length != get_mask_size(sel->type) ||
                      test_and_set_bit(sel->type, &sel_types))

LGTM!

Thanks,

Paolo

