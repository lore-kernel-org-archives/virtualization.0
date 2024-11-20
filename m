Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E25158535
	for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096944; cv=none; b=KJ/QmpEhfYiHmB2JzKq5VE0ZYpETxlgn6e+CRj86irQekgDtU0/ejZOO/jCf6bChE9bfODDqJsSxlIqYgogMPlV/Nc7/1L7i/meGFRbx5aFhT82DKMgiSehqKjXCl0eCkyUh+/Nhp3gf73Rd5exXA921UxGS+q59EgiyGe9t9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096944; c=relaxed/simple;
	bh=WnTEXtZEqyDDz7fFBXbqrFdaitOHF4Gb/h2SPWe6guM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5gVEyiKrXT1JyPyItrI5gtDIocePlhsOyOWlF49hZvSUvV6CV4evadx7N0Qpy6yXT7h0Z4OfdzJ4yf4fi7lKgrzdoXKgI1zdLeokG7zvBTj9bYR+NwDaf3U3T98rwRI/+lX3l/XI0tO455h7E7qCBaacPWNJZVcmUeJlihn9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xlt+4wX6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xlt+4wX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732096940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRZSdKlHsQ9OLHnq7+esx3i440YtlBSJBdUXroQOduQ=;
	b=Xlt+4wX6x58lkJUGy64yiHmxchdefo2sK5/xKkK7a58SC9prc4V5ZTrKOBWJnJjeV0ncYP
	+wdL7rwA6+mTeQNVbFXH43x/4agQeoCcAttSIOlG0vGoHpCiwdJw4ZRtQGUSxhW145te7V
	OVV1wxNl6AADDobktBAV7lHcBYrg/L0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ujnY55kDOveopjSkaIhm2w-1; Wed, 20 Nov 2024 05:02:19 -0500
X-MC-Unique: ujnY55kDOveopjSkaIhm2w-1
X-Mimecast-MFC-AGG-ID: ujnY55kDOveopjSkaIhm2w
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2124902b13bso24142135ad.2
        for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 02:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732096938; x=1732701738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRZSdKlHsQ9OLHnq7+esx3i440YtlBSJBdUXroQOduQ=;
        b=UbUMwIvXyVtnS/TSC4f7usATDTxmQIzDw/p1glPnVCgQBoM9DPqCvUiG7B9fUuP991
         pOekkkXjvFiY4tzALoYbwZX+JuppFHhCnyrftnD9eWdvjp5X3m+iV/pVe7m6fmwOmFb8
         qWMgnsgfaLQ/7vAE5AvIxdlsJkH1CW/OFFHovT8wjJPSYMYL7NUOp6iDCnTDFy5isDWI
         axySPjRyMLPT3hmB48pydJSxu1H2sgluj0hedgDbr4m8hccMpB42vyJtLMnFcp1nhfEp
         RBK8IF0IJbd7bK0SiRF/yYMjmbIVyom1dzw9pv4vV6xrkRj54AVwFUU4r05rV98StNTj
         io4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVThLTbHYiFkjpG2+tw6jjraVic1Mban+qB4KWArv0lM3jQqUGgLj0I+N0DGd96gP/dmmomazuD32j6OdTbDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEhVRmAFAZvSjjLY5NvChXCfR9unDtPqTl6Xms02+U6IEYNDNV
	3fzrSwvQNlZgY5LOxUwUEppofsSuCuGcsRAWv+UgootvdaA7jxYoGC1v/IxcKz6BH1p3CW8/Q/G
	Ng9N1d4Er4tE0aewg9cEwNZpcZCWFzico9cpiUOJ4oe6smFir2koxtyDblNrb2m6i
X-Received: by 2002:a17:903:18b:b0:212:69dc:dfaf with SMTP id d9443c01a7336-2126a37f40bmr25831595ad.2.1732096938058;
        Wed, 20 Nov 2024 02:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAaBU51SY3Boqa8bG2Xb6gOymOvVKgEIvy+s4iqLlUXFYzuNzpBNEMSRlFzLEQ12NB5JCYEw==
X-Received: by 2002:a17:903:18b:b0:212:69dc:dfaf with SMTP id d9443c01a7336-2126a37f40bmr25831225ad.2.1732096937369;
        Wed, 20 Nov 2024 02:02:17 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2126e59294esm8291295ad.202.2024.11.20.02.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 02:02:16 -0800 (PST)
Message-ID: <5f969243-f14d-4264-b3be-bc4f4571bb30@redhat.com>
Date: Wed, 20 Nov 2024 20:02:12 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: Use outer variable 'page'
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, mst@redhat.com
Cc: david@redhat.com, jasowang@redhat.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ic9ISV2WezU-vFdGoZ5dIdO_NWdxiXr8sgfoYr1zjk4_1732096938
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/20/24 3:49 PM, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is no need to define a local variable 'page',
> just use outer variable 'page'.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

