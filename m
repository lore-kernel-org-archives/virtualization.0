Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33992C86A
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385889; cv=none; b=e7fcmZdWldImDDf2vb2C9QQbvc4YCuCWhd32XWBI7qL4/2TM6+Hi3yS7dYiYNu8hrlCBnKS1es06+puZT+LiHGcn2flGYmsJE5vNZacrrYe/WkQFQYFcwPHs4RihbLGslWMNUT8hKQHMM+flZ/53nvVWoxsCzpp21N0FCepY8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385889; c=relaxed/simple;
	bh=Dp4WhcAEm3LjoebX3QhKlSxpYfp26vcYnT3xltjPvdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCGUi1Z6wEORIirA41zzKPMA07c/vpaHQ9tZgqWN9YE7/R2KxRAHHY5RUVI7rocLcAIyzpLjjaN6FwVcHQfbquA14LE1B6Rq/aFXd82jxDladb+/2WWRp9VzdHQnFpy05bPEFlXmRCrykqSRx5MfszWGJNwIJKsN+G0/atDGe/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL+hftWD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL+hftWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3aeDuQ2ScmwkduPqNuDpZ1kq3jr/gZ/7h6UWkDfJo4=;
	b=fL+hftWDo4reqtaDorl3jcfhFpHAJqQxFWgW4ti8G25hefsqv8cGst1friQWehXroDjJIB
	oKPNUQQu291hjUGhtSO+24dDovRGGDwmEUxYgBzmb7cVDDmKTQUhAk1WS0XwNJMfBUB7Ab
	V1mIT9U9Pd1LVwm5F9wbW6JL+kEOZqY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-W8_CX7IsOzykZ-ZcqhDKdQ-1; Mon, 29 Apr 2024 06:18:05 -0400
X-MC-Unique: W8_CX7IsOzykZ-ZcqhDKdQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed2e00aa22so4018337b3a.0
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 03:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385884; x=1714990684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3aeDuQ2ScmwkduPqNuDpZ1kq3jr/gZ/7h6UWkDfJo4=;
        b=lldX8H/92H93zHMHF8CXz1TEJk64qAurTqvQalT1TSiDqZABnxxsZfTQsTJY0FgRPm
         yz2fqSHOQgIt6sy0TqXYiVx7QgEwUKaHsZzmf314qMV6pvLidTwmUk7EI/J+g5s43gZI
         brZJWDFA03NpV8P+Ei93YDd/3I0OIvLqrKY2wMpGu9DgMezpTFjvC3/Nptczeh3gZonL
         yDsyyB1B4Z0+/XyQhNZsNmKpmDcs6+WHqO549GM21khQKSVfSmkhznb4MEgGzo6NtQEQ
         pa3RDRZWVg4HYJLIWlmriZX2iGcAtgew+eM/ob9OJUFa3CfkRhWCsbXHqs/9UrleXGk7
         Ur4w==
X-Gm-Message-State: AOJu0Yy9pzkDbEq93m+k56xshnhGw+INKth3dlE5p371m0xyn7LzFnvg
	eobErViULB/iqGreCyziAB9teNiy0Xu1vfEIkVLk7LBSZ9z1ec0aQaaS915FM+AEaVbZRyvUVvT
	PI7/lwq60BJAIoyxcF7qleVkVLZU1FdLgMHU8tWnsvWvmt1Nkctdq7xvBeVgk/4tU
X-Received: by 2002:a05:6a00:181a:b0:6f0:28a4:a871 with SMTP id y26-20020a056a00181a00b006f028a4a871mr12925342pfa.19.1714385883774;
        Mon, 29 Apr 2024 03:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7eC24ZKymDj34tQBxNz7Rb3a/lZm4YtKpVZG+eZcQITmkeRVRNQMXKkPx9ADzN0m+zHz5eQ==
X-Received: by 2002:a05:6a00:181a:b0:6f0:28a4:a871 with SMTP id y26-20020a056a00181a00b006f028a4a871mr12925319pfa.19.1714385883454;
        Mon, 29 Apr 2024 03:18:03 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b006f0830a298dsm18919959pfn.156.2024.04.29.03.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 03:18:02 -0700 (PDT)
Message-ID: <aedb7cd5-56b3-4efe-b62c-ac3d7a9be740@redhat.com>
Date: Mon, 29 Apr 2024 20:17:57 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vhost: Cleanup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, shan.gavin@gmail.com
References: <20240423032407.262329-1-gshan@redhat.com>
 <20240429025750-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240429025750-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 17:02, Michael S. Tsirkin wrote:
> On Tue, Apr 23, 2024 at 01:24:03PM +1000, Gavin Shan wrote:
>> This is suggested by Michael S. Tsirkin according to [1] and the goal
>> is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
>> the caller of the function needn't to worry about memory barriers. Since
>> we're here, other cleanups are also applied.
> 
> 
> Gavin I suggested another approach.
> 1. Start with the patch I sent (vhost: order avail ring reads after
>     index updates) just do a diff against latest.
>     simplify error handling a bit.
> 2. Do any other cleanups on top.
> 

My apologies, Michael. I didn't see your patch until now [1]

   [1] https://lore.kernel.org/virtualization/20240327155750-mutt-send-email-mst@kernel.org/

v2 was sent with your changes integrated and other cleanup are applied on
top of it. Please take a look when you getting a chance.

   v2: https://lore.kernel.org/virtualization/20240429101400.617007-1-gshan@redhat.com/T/#t

Thanks,
Gavin

