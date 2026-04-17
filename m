Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDC23E325
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413473; cv=none; b=ccHvXTdi3GoRp4obGSHXpxnsSzDx1LAL012A++A4WCgxE5j92IzeKE6EQiG0OKopJE9BhpiuWFZqqurMXgUyRVChp63CCMt0i1pT+xcS8O94SI1wnBNLY8YmnY5MntZkYIgSREb6au6n5e685xnebBBVkMyJkYEOrpi94yRgw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413473; c=relaxed/simple;
	bh=KaCpviZPSmkiF4jmKYcWq3DzQZ2+p6j12ROyja2bfaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FhlrVFZYRGkL90sGc7YKYT5YzpTUx6tU7YNcprPHlEwK3OEAvjObD5Z4S7wQy+7YQgd6oBkUjQFt8QC/1vXHE2J4hgWLYVDQI736xorbCxuuDxtNrQiwfesvnfRe0ac9aOfO72C6MV9XICnSGqkfgPul79WkIq8CA42mZG22C3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcRClTFE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcRClTFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776413471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQAofqZYzRAetGSFBCfd2UZ3jU4AYAQOO1zS3D2btb4=;
	b=JcRClTFEVfGmISpUkkZQLKl2p7UTvg81kSJsLWKWszcVUvPTtdbJLuPbeCJbfw/04DD1Wy
	RO/tubgzPxZO2nSVHMWxO2HDaMq+HfIBhVpWRpazewnKrcOqwm2b+n1zwWHdM4fmLzDE51
	Gh8420KxQXxlAdC0paDueglNCCNCtGo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-B7jqBkmMP4SSBfEg7LTTHg-1; Fri, 17 Apr 2026 04:11:10 -0400
X-MC-Unique: B7jqBkmMP4SSBfEg7LTTHg-1
X-Mimecast-MFC-AGG-ID: B7jqBkmMP4SSBfEg7LTTHg_1776413469
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d1ceb2ddfso301489f8f.2
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 01:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776413469; x=1777018269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQAofqZYzRAetGSFBCfd2UZ3jU4AYAQOO1zS3D2btb4=;
        b=QHyQXMmFzFCa3DrJFeHSfk9NZc17P58SGlEHTf0althPisnL9e5zPUHxPIIKOdpbwG
         WAOQblnW9hqrfZcIYkKL/cH5yajT1AmZk13g2cq2B6oykNduE1b/xInQgQMWIpw40oai
         2G0UJM0Jl3BTn+jalBqmIxK7xh/wr08A6u6/rv1jW8JdhD80s9aAGtdpw6xbJgJIVSk/
         mKYlcz9P9d7R4GCjwapTDSu2Ufq5s2AVYLvXDv1WAXkMuIkgsA/rdghEPx2iXA+rB/4V
         UU2KsXo3KAnqQtjNcM3anduPkDzXAOPalhe/iXOtQLAOB83Bat7xmXCKNK3B/j1EptZg
         CkRg==
X-Forwarded-Encrypted: i=1; AFNElJ91A1tjVnXmXw9A+yEUdxdX6LCrY89+I4TkxOJJfwl93IO9Yuj92r5AbL/XGVa9O5R1ramRb+aR/TxMfmF0EA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbtTmCY/YigNjQVy02eG8r5DtlfROHhqr4ujs0SYm1gzgSKmF6
	p/Z5m9dKGsfmNdcR55kXxIZNS9g3lGmis47rGvapvtqzzHoJ9dF/mu/IvPw50gXXSnmzmjkf1tD
	LJZPwOLbilwSOAE4DFoZgFHRcU2LP7SElgoSNR2FqccLqWyNl/0hWDbVFtymcMIzh2xbT
X-Gm-Gg: AeBDieu6HKrZig4syXv60lUqmxbab/qGCO/my8pXlCidiG+EU9kKAB8TyC0kkV7HuBA
	ILkIvHf371h7tcMt4cVNwBp6C8a/5JH4492FYljqQA+2JZlZ6PksvYnLq4SR99c4JmfGyrGDkvU
	D8wE1YgPHZG2uEYWogFYl3jWmAtaMTiqYpGjHgWZxmIoSnf8iNMYmwh86loTFIH3zlEEXt74SFA
	0fGkpJJZfP0AZin9uUMwaMbPabO/g6B1gfJnNmK9cBUEY5v8CZZ1oNYeFE/iOE12AAImf8UBuUq
	3okk0xI/DuzXIZTSEPRa4ri71rWrXweWYQjV9QBTZNupXHEsd7FpUaZNwoQGJmUp3IURbRJr0iH
	GuShb61suFb9zbzcixppvNACTK1oahKRMjzNWQcpDigxjPpGrehusB1IovKGavQmWJ4zJpxbu7e
	T6mAUHXg==
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr2356253f8f.36.1776413468892;
        Fri, 17 Apr 2026 01:11:08 -0700 (PDT)
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr2356185f8f.36.1776413468277;
        Fri, 17 Apr 2026 01:11:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a381sm2920727f8f.21.2026.04.17.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:11:07 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:11:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ben Hillis <Ben.Hillis@microsoft.com>, 
	Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO for FIN
Message-ID: <aeHor6IpXUDyMtnW@sgarzare-redhat>
References: <20260416191433.840637-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260416191433.840637-1-decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DvZanjE-RQOhQXl_cXfO8-5ew6fms1sfl_KeDoZ98N4_1776413469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 16, 2026 at 12:14:33PM -0700, Dexuan Cui wrote:
>Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
>and the final read syscall gets an error rather than 0.
>
>Ideally, we would want to fix hvs_channel_readable_payload() so that it
>could return 0 in the FIN scenario, but it's not good for the hv_sock
>driver to use the VMBus ringbuffer's cached priv_read_index, which is
>internal data in the VMBus driver.
>
>Fix the regression in hv_sock by returning 0 rather than -EIO.
>
>Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
>Cc: stable@vger.kernel.org
>Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
>Reported-by: Mitchell Levy <levymitchell0@gmail.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Changes since v1:
>    Removed the local variable 'need_refill' to make the code more
>    readable. Stefano, thanks!

Thanks for the fix!

>
>    No other change.
>
> net/vmw_vsock/hyperv_transport.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

