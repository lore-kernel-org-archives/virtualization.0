Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8413A4AAE
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594893; cv=none; b=haTOyXSVJCNMjOrtlfnge7xVvq4oyfhhs/oRuUELs2l2Fd9+DyWozRT60japz+avSwvcIdyJZ51YcAokpgNQKKv5mnDZeuL1jKuh8z/CiPzaAuAE2tI3prx4t1bsn5xYP4zjnwZJ9HtG8zDw7f4i0RmSY/Zh2STf/QxAR4GE26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594893; c=relaxed/simple;
	bh=yCSdMD4ToLGgmxhqQUtjj3m1ZlUrBUAba/VP+IyFmpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SIeEoH+gb8K9CdLzxRZ4CXjQu2MwEFui8DQW/fR4gUaK45Pq/o7qY4uhomzklZIC05RXPagpfbrWXC7JYai5QWy7vS5tdGxdrwsz2O/G/8TlqfIlaDO56oWLjahciWHfURlbQn4FA3qxvaqwfOE+9jDgn9wvTRb3sBHpNzk1RSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1H0Q0NM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1H0Q0NM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TM7qIG6S/L7S3GUslC1W7AHVB3tEGDHeSbLotnEOSBU=;
	b=Y1H0Q0NMg9O88pau7F4UEoD0pUzawlyt92xLqB6JXnWddr6v7BVTkANrAAFVHFoRwdbHw8
	EUGwcMSsDpeLzy7+zbhKHyHiRD7OIfjWnBgt1/32oRWAEJxpcq+2RqiYWZPtBd8ZFmb8J3
	TelY4lZtYRByxA2net60B+1lgZnsQIo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-cDodoJvxPZmzb-lAn224TA-1; Fri, 16 Jan 2026 15:21:28 -0500
X-MC-Unique: cDodoJvxPZmzb-lAn224TA-1
X-Mimecast-MFC-AGG-ID: cDodoJvxPZmzb-lAn224TA_1768594887
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4801bceb317so23618955e9.1
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 12:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594887; x=1769199687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TM7qIG6S/L7S3GUslC1W7AHVB3tEGDHeSbLotnEOSBU=;
        b=Q1DuOdYHsOv3Jo/EEVTdl/4hYC9Y789/pNu9cIg6QVpskxYXmgDF4ck1qfA0YJeYn1
         qv91pB5SUxcbqrszNQqK+7IIlYt7x7uS+ybLtGRbdxs7du6j/9ZCrNJJjyRetCBcmENR
         ZCDGHp2N08m7lLgcHsBlKO6MaskcrCIbjuw3LcqgXhW8VbgykvPib2Re90bXaGSfhN9B
         fKuNIi41pYnbcuEHcB00bqNyiD4HEQOWanuJhdxfpdYFsrVeidKBJtxmfbNvqdHEGuZL
         cxJyajR2OgOnsfagNPiOiFYW9xHyoMBa0DPsaG9gHosMVP827X8l2iSkUQ7DFAllSjIa
         Mwsg==
X-Forwarded-Encrypted: i=1; AJvYcCVDkoDcAtYtYeOFgwE2ze7RM3kiF5kyjOLJyUHyiwlNxNFy+WhEtCnBkPY0Z+ugiJCWC3BSb3nLrr87rA7KqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLME1jQCK8Es8fPcYICXBK1dM8D76nCEd3qECqn7cQH+l9KqzV
	feLTx9sbfOnz4WYapD8YdtdPGU9vsDu0nMujj2msC2i1B+Zp8NEszx2DKyUTN+Azv6h2F6mQWtS
	jssEB4vEUkwlbrduzrbSgbV3G+OXyw+m7tfeeReO8dUQpTqgyCT4L6K71CLTWu773DMuN
X-Gm-Gg: AY/fxX617Tuz6iNRJICXQpxngRTeGJrLeb3DESZdoioWPNZ6OufGOk1JXXi1D5GmaZb
	OSQ1DzQYON1IwwlYPmLs9+s1KX3qqidF/go2fWIznLNlJ3reXS9OT4UjQBXau7siUgHX/FQyT1Q
	by3I4XbwoxAZzclTc97wO7EQ8xDlr9xxA0BaYjZFUm7O1dNSFSz54mYwDc+s2H7pSlAHySkwScL
	GPhIojazxQ9tTyCqWgeiqa6arsEY+91yCZfMCUMTNfrbUBV6eVX2JzxSD/F+s4hjdljejqM+Lee
	TfsC/q5GvUGxQNzbpJ1XQUfUopbxthrk0cBAB57l9fiHD1zEXUMiiTRAmMEYE2VbrkddiWKFmBB
	ilO2ZuZW+qq5if1KGON43QUx8JN+kNJv0lFiC+rP/OYBeZOTjmzpKV7vYF2c=
X-Received: by 2002:a05:600c:1d16:b0:47d:2093:649f with SMTP id 5b1f17b1804b1-4801e2f912amr62205875e9.8.1768594887000;
        Fri, 16 Jan 2026 12:21:27 -0800 (PST)
X-Received: by 2002:a05:600c:1d16:b0:47d:2093:649f with SMTP id 5b1f17b1804b1-4801e2f912amr62205655e9.8.1768594886479;
        Fri, 16 Jan 2026 12:21:26 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm144369235e9.15.2026.01.16.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:21:25 -0800 (PST)
Date: Fri, 16 Jan 2026 21:21:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 0/4] vsock/virtio: fix TX credit handling
Message-ID: <aWqdjSUeEWMf53g9@sgarzare-redhat>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <xwnhhms5divyalikrekxxfkz7xaeqwuyfzvro72v5b4davo6hc@kii7js242jbc>
 <aV-UZ9IhrXW2hsOn@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aV-UZ9IhrXW2hsOn@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t7sagcITROadvvTHZPzQk18hSoeuizN2-XHE-Wpv9Uc_1768594887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 08, 2026 at 12:27:41PM +0100, Stefano Garzarella wrote:
>Hi Melbin and happy new year!
>
>On Thu, Dec 18, 2025 at 10:18:03AM +0100, Stefano Garzarella wrote:
>>On Wed, Dec 17, 2025 at 07:12:02PM +0100, Melbin K Mathew wrote:
>>>This series fixes TX credit handling in virtio-vsock:
>>>
>>>Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
>>>Patch 2: Cap TX credit to local buffer size (security hardening)
>>>Patch 3: Fix vsock_test seqpacket bounds test
>>>Patch 4: Add stream TX credit bounds regression test
>>
>>Again, this series doesn't apply both on my local env but also on 
>>patchwork:
>>https://patchwork.kernel.org/project/netdevbpf/list/?series=1034314
>>
>>Please, can you fix your env?
>>
>>Let me know if you need any help.
>
>Any update on this?
>If you have trouble, please let me know.
>I can repost fixing the latest stuff.

Since it's almost a month without any reply, I fixed the latest stuff 
and sent a v5 here: 
https://lore.kernel.org/netdev/20260116201517.273302-1-sgarzare@redhat.com/

Thanks,
Stefano

