Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA41019DF75
	for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607739; cv=none; b=PuSrqHIYvztCZgfndYUkrV+iszuaMaBIrwOmfnJa+u8J7M/RAiBML/Ln3r9dgOtqpY8CSYbYtzl2/hasCOFYcqUwAtd1opSTQbRYtNjXA2HsYdKm+CLu4neGe0IMd9uPFHf/d8IBZCPlc5w9aLHXCNNcnrj9xkkibdzHfhZhVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607739; c=relaxed/simple;
	bh=IN3uw7A4e5+EHfOBzjLB/rIishhOKQYppCUa9vpRwos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANAkNG2+Ho7Te4iLHwzvO/EkpG9O+tCUKAZn4hxP1ENqlxgvtKGQT1VuFRjv3YqgV9oX1mF1SCmi1Eby23DjLi285w2H310cZQRWjLUokIQLKd6NZqnaPF+7oiqWdnk9Ja+O7oBM8vsNpIMxw6tWpuWDnSaw7vxdjazOXgYUlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSE0g/ru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSE0g/ru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729607736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lamMGHbzeKB83vh3+3DISoETzmuJPevg91wnqG+F12Y=;
	b=VSE0g/ru5929r0f+zcO7yAZp+T8FIbvh95iV4UHCVooFyKl/KHgnlBG5osRZ8RCyHFSwMr
	U2OBLL7lLGyx8Dy5GT2dFKByPvm+KIbf2s+5ojaP/Dwuq1DwdExeP2cj+hELEgTXJ2QepM
	I2X06k8bmI06IRz5wR1UrMQ56iCX+7A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-AugiVN2oNKSDkmBwnwIPow-1; Tue, 22 Oct 2024 10:35:34 -0400
X-MC-Unique: AugiVN2oNKSDkmBwnwIPow-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d49887a2cso3186770f8f.0
        for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 07:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607733; x=1730212533;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lamMGHbzeKB83vh3+3DISoETzmuJPevg91wnqG+F12Y=;
        b=EI1SAzROdKp878ahHrxnPLXPOISDRm4XMt/0ZEgNzfM/5hNI8xNSmTpZlWNLCVRD04
         fjDkoXbPGAO23Xcbks/AuOqTp4OXWZUmonVoK9G5WulZ+B8E6x52E1j7aYtR5YFFWArK
         owMz5uu/Lk09dwiCKjUp3ebFbxqh4A4t/UEJd+3x6lRE5M/enDCZKj8/XI6pJOAH1lrD
         8M6cG/6EVrMS70AtkGD+go+eFceq6lklly3KIr5AW2LwoU1JffIufJI5HEj9T9y3NET9
         ex1mqYeL3MbFh+Fcp3G63zvk2SDJWCiFR/qfjfQvoReZ6Aj41JBO+UexvfG6SEuq0XGd
         HV+g==
X-Forwarded-Encrypted: i=1; AJvYcCVLiGks9kx4jRrqYxFnEUvCpuf6WN4M/im57g5cuUUhpteoOaRJCyIXpiOeXuS1uJOg2/ptIVaPtTx+pWPwJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqwXJcvog0aUCgd8j7KmX40ea3iTc4up88AxdZGl1EKBqec4dh
	QJbiXmWyssbzDC8ygwY+Z/GJbROCao81PAl0gdU5MwDz7bMTXcAK2TAxiC+DnzU8HSqKphJHEKw
	PK6DuUPPRA3MaGbTHG8UhUp9nCg8EhaTx54WwAsC5atxBcphvt2STnPexEWGgEHU/
X-Received: by 2002:a5d:6dd1:0:b0:37d:34e7:6d24 with SMTP id ffacd0b85a97d-37ef14da610mr2116310f8f.18.1729607732942;
        Tue, 22 Oct 2024 07:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWL0LrxW7yMAYEPXvxEhUcKCrtkxuOmsMf8pB0UDuwJsdi/xEgMYz10obQmmaXjoQPDcO2QA==
X-Received: by 2002:a5d:6dd1:0:b0:37d:34e7:6d24 with SMTP id ffacd0b85a97d-37ef14da610mr2116288f8f.18.1729607732535;
        Tue, 22 Oct 2024 07:35:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f700:352b:d857:b95d:9072? (p200300cbc705f700352bd857b95d9072.dip0.t-ipconnect.de. [2003:cb:c705:f700:352b:d857:b95d:9072])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb15sm6766254f8f.99.2024.10.22.07.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 07:35:31 -0700 (PDT)
Message-ID: <4a14d90b-75f0-4f4f-9e04-e2f7a39d85ba@redhat.com>
Date: Tue, 22 Oct 2024 16:35:30 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, John Groves <John@groves.net>,
 virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
 qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
 wangkefeng.wang@huawei.com, John Groves <jgroves@micron.com>,
 Fan Ni <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>,
 =?UTF-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240815172223.00001ca7@Huawei.com>
 <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
 <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
 <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>
 <Zxe1h8-E-OcO9cG3@PC2K9PVX.TheFacebook.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zxe1h8-E-OcO9cG3@PC2K9PVX.TheFacebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.24 16:24, Gregory Price wrote:
> On Tue, Oct 22, 2024 at 11:33:07AM +0200, David Hildenbrand wrote:
>> On 20.09.24 11:06, Gregory Price wrote:
>>
>>> The only concern is when insufficient ZONE_NORMAL exists to support
>>> ZONE_MOVABLE capacity - but this is unlikely to be the general scenario AND
>>> can be mitigated w/ existing mechanisms.
>>
>> It might be worthwhile looking at
>> Documentation/admin-guide/mm/memory-hotplug.rst "auto-movable" memory
>> onlining polciy. It might not fit all sue cases, though (just like
>> ZONE_MOVABLE doesn't)
>>
> 
> I managed to miss auto-movable in my last pass through there. Though for
> our use-case, forcibly preventing ZONE_NORMAL for all CXL is the preferred
> option in an effort to keep as much kernel resources out of high latency
> memory.

Yes, that makes sense for this memory with very different performance 
characteristics.

-- 
Cheers,

David / dhildenb

